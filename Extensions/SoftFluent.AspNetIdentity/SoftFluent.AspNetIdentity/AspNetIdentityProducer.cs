using System;
using System.CodeDom;
using System.Collections.Generic;
using System.ComponentModel;
using System.Xml;
using CodeFluent.Model;
using CodeFluent.Model.Common.Design;
using CodeFluent.Model.Design;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime.Utilities;

namespace SoftFluent.AspNetIdentity
{
    public class AspNetIdentityProducer : BaseProducer
    {
        private CodeDomProducer _codeDomProducer;
        private IdentityUser _identityUser;
        private IdentityRole _identityRole;
        private IdentityLogin _identityLogin;
        private IdentityClaim _identityClaim;
        private UserStoreProducer _userStoreProducer;
        private RoleStoreProducer _roleStoreProducer;

        protected override string NamespaceUri
        {
            get { return Constants.NamespaceUri; }
        }

        [DefaultValue(false)]
        [Category("Source Production")]
        [DisplayName("Must Implement IQueryableUserStore")]
        [Description("Determines if the IQueryableUserStore interface must be implemented. WARNING: this is not a real IQueryable data source. This can be used to load all users.")]
        [ModelLevel(ModelLevel.Normal)]
        public bool MustImplementQueryableUserStore
        {
            get
            {
                return XmlUtilities.GetAttribute(Element, "implementQueryableUserStore", false);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "implementQueryableUserStore", value.ToString().ToLowerInvariant());
            }
        }

        [DefaultValue(false)]
        [Category("Source Production")]
        [DisplayName("Must Implement IQueryableRoleStore")]
        [Description("Determines if the IQueryableRoleStore interface must be implemented. WARNING: this is not a real IQueryable data source. This can be used to load all roles.")]
        [ModelLevel(ModelLevel.Normal)]
        public bool MustImplementQueryableRoleStore
        {
            get
            {
                return XmlUtilities.GetAttribute(Element, "implementQueryableRoleStore", false);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "implementQueryableRoleStore", value.ToString().ToLowerInvariant());
            }
        }

        public Version TargetFrameworkVersion
        {
            get
            {
                return new Version(4, 5);
            }
        }

        protected override void BuildMenus(IList<IDesignProducerMenu> menus)
        {
            base.BuildMenus(menus);

            if (menus == null)
                return;

            menus.Add(new BaseDesignMenu("Create Identity Entities", true));
        }

        protected override bool ExecuteMenu(IServiceProvider serviceProvider, IDictionary<string, object> context, int index)
        {
            Project project = context["Project"] as Project;
            if (project == null)
                return false;

            switch (index)
            {
                case 0:
                    var form = new ConfigurationForm(project);
                    form.ShowDialog();
                    return true;
            }

            return base.ExecuteMenu(serviceProvider, context, index);
        }

        protected override void BuildDescriptors(IList<Descriptor> descriptors)
        {
            base.BuildDescriptors(descriptors);

            if (descriptors == null)
                return;

            descriptors.Add(BuildDescriptor(
                name: "entityType",
                typeName: typeof(EntityType).AssemblyQualifiedName,
                defaultValue: "None",
                displayName: "Entity Type",
                description: "ASP.NET Identity Entity Type.",
                targets: NodeType.Entity));

            descriptors.Add(BuildDescriptor(
                name: "propertyType",
                typeName: typeof(PropertyType).AssemblyQualifiedName,
                defaultValue: "None",
                displayName: "Property Type",
                description: "ASP.NET Identity Property Type.",
                targets: NodeType.Property));

            descriptors.Add(BuildDescriptor(
                name: "methodType",
                typeName: typeof(MethodType).AssemblyQualifiedName,
                defaultValue: "None",
                displayName: "Method Type",
                description: "ASP.NET Identity Method Type.",
                targets: NodeType.Method));
        }

        public override void Initialize(Project project, Producer producer)
        {
            base.Initialize(project, producer);

            _codeDomProducer = project.Producers.GetProducerInstance<CodeDomProducer>();
            if (_codeDomProducer == null)
                return;

            if (string.IsNullOrWhiteSpace(EditorTargetDirectory))
            {
                EditorTargetDirectory = _codeDomProducer.EditorTargetDirectory;
            }

            _codeDomProducer.CodeDomProduction += CodeDomProducer_CodeDomProduction;


            Entity userEntity = ProjectUtilities.FindByEntityType(project, EntityType.User);
            if (userEntity != null)
            {
                _identityUser = new IdentityUser(userEntity);
            }

            Entity roleEntity = ProjectUtilities.FindByEntityType(project, EntityType.Role);
            if (roleEntity != null)
            {
                _identityRole = new IdentityRole(roleEntity);
            }

            Entity loginEntity = ProjectUtilities.FindByEntityType(project, EntityType.Login);
            if (loginEntity != null)
            {
                _identityLogin = new IdentityLogin(loginEntity);
            }

            Entity claimEntity = ProjectUtilities.FindByEntityType(project, EntityType.Claim);
            if (claimEntity != null)
            {
                _identityClaim = new IdentityClaim(claimEntity);
            }

            if (_identityUser != null)
            {
                _userStoreProducer = new UserStoreProducer(_codeDomProducer, this, _identityUser, _identityRole, _identityLogin, _identityClaim);
            }

            if (_identityRole != null)
            {
                _roleStoreProducer = new RoleStoreProducer(_codeDomProducer, this, _identityRole);
            }
        }

        private void CodeDomProducer_CodeDomProduction(object sender, CodeDomProductionEventArgs e)
        {
            if (e.EventType == CodeDomProductionEventType.EntityCommitting)
            {
                CodeCompileUnit unit = e.Argument as CodeCompileUnit;
                if (unit == null)
                    return;

                foreach (CodeNamespace ns in unit.Namespaces)
                {
                    foreach (CodeTypeDeclaration typeDeclaration in ns.Types)
                    {
                        BaseType type = UserData.GetBaseType(typeDeclaration);
                        if (type.GetAttributeValue("entityType", NamespaceUri, EntityType.None) == EntityType.User)
                        {
                            // Implements IUser<TKey> & IUser
                            if (_identityUser.MustImplementGenericInterface)
                            {
                                ImplementIUser(typeDeclaration, true);
                            }

                            ImplementIUser(typeDeclaration, false);
                        }

                        else if (type.GetAttributeValue("entityType", NamespaceUri, EntityType.None) == EntityType.Role)
                        {
                            // Implements IRole<TKey> & IRole
                            if (_identityRole.MustImplementGenericInterface)
                            {
                                ImplementIRole(typeDeclaration, true);
                            }

                            ImplementIRole(typeDeclaration, false);
                        }

                        //if (type.GetAttributeValue("entityType", NamespaceUri, EntityType.None) == EntityType.Claim)
                        //{
                        //    // Add FromClaim, ToClaim method (implicit conversion), IEquatable<Claim>
                        //    var fromClaimMethod = new CodeMemberMethod();
                        //    fromClaimMethod.Name = "FromClaim";
                        //    fromClaimMethod.Attributes = MemberAttributes.Public | MemberAttributes.Static;
                        //    var claimParameter = new CodeParameterDeclarationExpression(typeof(System.Security.Claims.Claim), "claim");
                        //    fromClaimMethod.Parameters.Add(claimParameter);
                        //    fromClaimMethod.ReturnType = CodeDomUtilities.ReferenceFromDeclaration(typeDeclaration);

                        //    fromClaimMethod.Statements.Add(CodeDomUtilities.CreateThrowIfNull(new CodeArgumentReferenceExpression("claim"), "claim"));
                        //    fromClaimMethod.Statements.Add(new CodeVariableDeclarationStatement(CodeDomUtilities.ReferenceFromDeclaration(typeDeclaration), "result", new CodeObjectCreateExpression(CodeDomUtilities.ReferenceFromDeclaration(typeDeclaration))));

                        //    if (_identityClaim.TypeProperty != null)
                        //    {
                        //        fromClaimMethod.Statements.Add(new CodeAssignStatement(
                        //            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("result"), _identityClaim.TypeProperty.Name),
                        //            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Type")));
                        //    }

                        //    if (_identityClaim.ValueProperty != null)
                        //    {
                        //        fromClaimMethod.Statements.Add(new CodeAssignStatement(
                        //            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("result"), _identityClaim.ValueProperty.Name),
                        //            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Value")));
                        //    }

                        //    if (_identityClaim.ValueTypeProperty != null)
                        //    {
                        //        fromClaimMethod.Statements.Add(new CodeAssignStatement(
                        //            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("result"), _identityClaim.ValueTypeProperty.Name),
                        //            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "ValueType")));
                        //    }

                        //    if (_identityClaim.IssuerProperty != null)
                        //    {
                        //        fromClaimMethod.Statements.Add(new CodeAssignStatement(
                        //            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("result"), _identityClaim.IssuerProperty.Name),
                        //            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "Issuer")));
                        //    }

                        //    if (_identityClaim.OriginalIssuerProperty != null)
                        //    {
                        //        fromClaimMethod.Statements.Add(new CodeAssignStatement(
                        //            new CodePropertyReferenceExpression(new CodeVariableReferenceExpression("result"), _identityClaim.OriginalIssuerProperty.Name),
                        //            new CodePropertyReferenceExpression(new CodeArgumentReferenceExpression("claim"), "OriginalIssuer")));
                        //    }

                        //    typeDeclaration.Members.Add(fromClaimMethod);
                        //    fromClaimMethod.Statements.Add(new CodeMethodReturnStatement(new CodeVariableReferenceExpression("result")));

                        //}
                    }
                }
            }
        }

        private void ImplementIRole(CodeTypeDeclaration typeDeclaration, bool generic)
        {
            string keyTypeName = generic ? _identityUser.KeyTypeName : typeof(string).FullName;
            var iroleCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IRole");
            var iroleGenericCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IRole");
            iroleGenericCodeTypeReference.TypeArguments.Add(keyTypeName);
            if (generic)
            {
                iroleCodeTypeReference.TypeArguments.Add(keyTypeName);
            }

            typeDeclaration.BaseTypes.Add(iroleCodeTypeReference);

            CodeMemberProperty idProperty = new CodeMemberProperty();
            idProperty.PrivateImplementationType = iroleGenericCodeTypeReference;
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityRole.KeyPropertyName : "EntityKey")));
            typeDeclaration.Members.Add(idProperty);

            CodeMemberProperty roleNameProperty = new CodeMemberProperty();
            roleNameProperty.PrivateImplementationType = iroleGenericCodeTypeReference;
            roleNameProperty.Type = new CodeTypeReference(typeof(string));
            roleNameProperty.Name = "Name";
            roleNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name), new CodePropertySetValueReferenceExpression()));
            roleNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name)));
            typeDeclaration.Members.Add(roleNameProperty);
        }

        private void ImplementIUser(CodeTypeDeclaration typeDeclaration, bool generic)
        {
            string keyTypeName = generic ? _identityUser.KeyTypeName : typeof(string).FullName;
            var iuserCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IUser");
            var iuserGenericCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IUser");
            iuserGenericCodeTypeReference.TypeArguments.Add(keyTypeName);
            if (generic)
            {
                iuserCodeTypeReference.TypeArguments.Add(keyTypeName);
            }

            typeDeclaration.BaseTypes.Add(iuserCodeTypeReference);

            CodeMemberProperty idProperty = new CodeMemberProperty();
            idProperty.PrivateImplementationType = iuserGenericCodeTypeReference;
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityUser.KeyPropertyName : "EntityKey")));
            typeDeclaration.Members.Add(idProperty);

            CodeMemberProperty userNameProperty = new CodeMemberProperty();
            userNameProperty.PrivateImplementationType = iuserGenericCodeTypeReference;
            userNameProperty.Type = new CodeTypeReference(typeof(string));
            userNameProperty.Name = "UserName";
            userNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name), new CodePropertySetValueReferenceExpression()));
            userNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name)));
            typeDeclaration.Members.Add(userNameProperty);
        }

        public override void Produce()
        {
            if (_codeDomProducer == null)
                throw new Exception("No CodeDom producer found.");

            if (_userStoreProducer != null && _userStoreProducer.CanImplementUserStore)
            {
                _userStoreProducer.Produce(true);
            }

            if (_roleStoreProducer != null && _roleStoreProducer.CanImplementRoleStore)
            {
                _roleStoreProducer.Produce(true);
            }
        }
    }
}
