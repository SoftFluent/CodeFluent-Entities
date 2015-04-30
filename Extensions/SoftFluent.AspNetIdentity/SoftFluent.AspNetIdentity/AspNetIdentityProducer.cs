using System;
using System.CodeDom;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Model.Common.Design;
using CodeFluent.Model.Design;
using CodeFluent.Producers.CodeDom;
using CodeFluent.Runtime.Utilities;
using JetBrains.Annotations;

namespace SoftFluent.AspNetIdentity
{
    [UsedImplicitly(ImplicitUseTargetFlags.WithMembers)]
    public class AspNetIdentityProducer : BaseProducer
    {
        //private CodeDomProducer _codeDomProducer;
        private IdentityUser _identityUser;
        private IdentityRole _identityRole;
        private IdentityUserLogin _identityUserLogin;
        private IdentityUserClaim _identityUserClaim;
        private IdentityRoleClaim _identityRoleClaim;
        private UserStoreProducer _userStoreProducer;
        private RoleStoreProducer _roleStoreProducer;
        private CodeDomProducer _inputProducer;

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
                return XmlUtilities.GetAttribute(Element, "implementQueryableUserStore", false, CultureInfo.InvariantCulture);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "implementQueryableUserStore", value.ToString(CultureInfo.InvariantCulture));
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
                return XmlUtilities.GetAttribute(Element, "implementQueryableRoleStore", false, CultureInfo.InvariantCulture);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "implementQueryableRoleStore", value.ToString(CultureInfo.InvariantCulture));
            }
        }

        public virtual CodeDomProducer InputProducer
        {
            get
            {
                if (_inputProducer == null && Project != null)
                {
                    List<CodeDomProducer> codeDomProducers = new List<CodeDomProducer>();
                    foreach (Producer producer in Project.Producers)
                    {
                        CodeDomProducer instance = producer.Instance as CodeDomProducer;
                        if (instance == null)
                            continue;

                        codeDomProducers.Add(instance);
                    }

                    if (codeDomProducers.Count == 0)
                        return null;

                    string inputProducerName = this.InputProducerName;
                    if (inputProducerName != null)
                    {
                        _inputProducer = codeDomProducers.Find(p => p.Producer.Name != null && string.Equals(p.Producer.Name, inputProducerName, StringComparison.OrdinalIgnoreCase));
                        if (_inputProducer == null)
                        {
                            throw new Exception(string.Format("BOM Producer '{0}' does not exist.", inputProducerName));
                        }
                    }
                    else
                    {
                        _inputProducer = codeDomProducers[0];
                    }
                }
                return _inputProducer;
            }
        }

        [Category("Source Production")]
        [Description("Defines the CodeDom producer to use as the input. If null or empty, the first available producer will be used.")]
        [DisplayName("Input Producer")]
        [ModelLevel(ModelLevel.Normal)]
        public virtual string InputProducerName
        {
            get
            {
                return ConvertUtilities.Nullify(XmlUtilities.GetAttribute<string>(this.Element, "inputProducerName", null), true);
            }
            set
            {
                XmlUtilities.SetAttribute(this.Element, "inputProducerName", ConvertUtilities.Nullify(value, true));
            }
        }

        [DefaultValue(false)]
        [Category("Source Production")]
        [DisplayName("ASP.NET Identity Version")]
        [ModelLevel(ModelLevel.Normal)]
        public AspNetIdentityVersion TargetVersion
        {
            get
            {
                return XmlUtilities.GetAttribute(Element, "aspNetIdentityVersion", AspNetIdentityVersion.Version2);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "aspNetIdentityVersion", value.ToString());
            }
        }

        public Version TargetFrameworkVersion
        {
            get
            {
                return new Version(4, 5);
            }
        }

        [DefaultValue(false)]
        [Category("Design")]
        [DisplayName("Must Create Project Messages")]
        [ModelLevel(ModelLevel.Normal)]
        public bool MustCreateMessages
        {
            get
            {
                return XmlUtilities.GetAttribute(Element, "mustCreateMessages", false);
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "mustCreateMessages", value.ToString());
            }
        }

        [DefaultValue("")]
        [Category("Design")]
        [DisplayName("Project Messages Culture")]
        [ModelLevel(ModelLevel.Normal)]
        public string MessagesCulture
        {
            get
            {
                return XmlUtilities.GetAttribute(Element, "messagesCulture", "");
            }
            set
            {
                XmlUtilities.SetAttribute(Element, "messagesCulture", value);
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
                    var form = new ConfigurationForm(this, project);
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

            if (InputProducer == null)
                return;

            if (Utilities.IsNullOrWhiteSpace(EditorTargetDirectory))
            {
                EditorTargetDirectory = InputProducer.EditorTargetDirectory;
            }

            InputProducer.CodeDomProduction += CodeDomProducer_CodeDomProduction;


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

            Entity loginEntity = ProjectUtilities.FindByEntityType(project, EntityType.UserLogin);
            if (loginEntity != null)
            {
                _identityUserLogin = new IdentityUserLogin(loginEntity);
            }

            Entity claimEntity = ProjectUtilities.FindByEntityType(project, EntityType.UserClaim);
            if (claimEntity != null)
            {
                _identityUserClaim = new IdentityUserClaim(claimEntity);
            }

            Entity roleClaimEntity = ProjectUtilities.FindByEntityType(project, EntityType.RoleClaim);
            if (roleClaimEntity != null)
            {
                _identityRoleClaim = new IdentityRoleClaim(roleClaimEntity);
            }

            ProjectMessages projectMessages = new ProjectMessages(project);

            if (_identityUser != null)
            {
                _userStoreProducer = new UserStoreProducer(this, InputProducer, projectMessages, _identityUser, _identityRole, _identityUserLogin, _identityUserClaim);
            }

            if (_identityRole != null)
            {
                _roleStoreProducer = new RoleStoreProducer(this, InputProducer, _identityRole, _identityRoleClaim);
            }
        }

        private void CodeDomProducer_CodeDomProduction(object sender, CodeDomProductionEventArgs e)
        {
            if (TargetVersion != AspNetIdentityVersion.Version1 &&
                TargetVersion != AspNetIdentityVersion.Version2)
                return;

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
                            if (TargetVersion == AspNetIdentityVersion.Version1)
                            {
                                ImplementIUser(typeDeclaration, false, false);
                            }
                            else if (TargetVersion == AspNetIdentityVersion.Version2)
                            {
                                if (!_identityUser.IsStringId)
                                {
                                    ImplementIUser(typeDeclaration, true, true);
                                }

                                ImplementIUser(typeDeclaration, false, true);
                            }
                        }

                        else if (type.GetAttributeValue("entityType", NamespaceUri, EntityType.None) == EntityType.Role)
                        {
                            // Implements IRole<TKey> & IRole
                            if (TargetVersion == AspNetIdentityVersion.Version1)
                            {
                                ImplementIRole(typeDeclaration, false, false);
                            }
                            else if (TargetVersion == AspNetIdentityVersion.Version2)
                            {
                                if (!_identityRole.IsStringId)
                                {
                                    ImplementIRole(typeDeclaration, true, true);
                                }

                                ImplementIRole(typeDeclaration, false, true);
                            }
                        }
                    }
                }
            }
        }

        private void ImplementIRole(CodeTypeDeclaration typeDeclaration, bool generic, bool supportGeneric)
        {
            if (_identityRole == null)
                return;

            string keyTypeName = generic ? _identityRole.KeyTypeName : typeof(string).FullName;
            var iroleCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IRole");
            var iroleGenericCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IRole");
            iroleGenericCodeTypeReference.TypeArguments.Add(keyTypeName);
            if (generic)
            {
                iroleCodeTypeReference.TypeArguments.Add(keyTypeName);
            }

            CodeDomUtilities.SetInterface(iroleCodeTypeReference);
            CodeDomUtilities.SetInterface(iroleGenericCodeTypeReference);
            typeDeclaration.BaseTypes.Add(iroleCodeTypeReference);

            CodeMemberProperty idProperty = new CodeMemberProperty();
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityRole.KeyPropertyName : "EntityKey")));

            CodeMemberProperty roleNameProperty = new CodeMemberProperty();
            roleNameProperty.Type = new CodeTypeReference(typeof(string));
            roleNameProperty.Name = "Name";
            roleNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name), new CodePropertySetValueReferenceExpression()));
            roleNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name)));

            if (generic || supportGeneric)
            {
                idProperty.PrivateImplementationType = GetPrivateImplementationGenericType(InputProducer.LanguageCode, "Microsoft.AspNet.Identity.IRole", keyTypeName);
                idProperty.ImplementationTypes.Add(iroleGenericCodeTypeReference);
                roleNameProperty.PrivateImplementationType = GetPrivateImplementationGenericType(InputProducer.LanguageCode, "Microsoft.AspNet.Identity.IRole", keyTypeName);
                roleNameProperty.ImplementationTypes.Add(iroleGenericCodeTypeReference);
            }
            else
            {
                idProperty.PrivateImplementationType = iroleCodeTypeReference;
                idProperty.ImplementationTypes.Add(iroleCodeTypeReference);
                roleNameProperty.PrivateImplementationType = iroleCodeTypeReference;
                roleNameProperty.ImplementationTypes.Add(iroleCodeTypeReference);
            }

            typeDeclaration.Members.Add(idProperty);
            typeDeclaration.Members.Add(roleNameProperty);

        }

        private void ImplementIUser(CodeTypeDeclaration typeDeclaration, bool generic, bool supportGeneric)
        {
            if (_identityUser == null)
                return;

            string keyTypeName = generic ? _identityUser.KeyTypeName : typeof(string).FullName;
            var iuserCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IUser");
            var iuserGenericCodeTypeReference = new CodeTypeReference("Microsoft.AspNet.Identity.IUser");
            iuserGenericCodeTypeReference.TypeArguments.Add(keyTypeName);
            if (generic)
            {
                iuserCodeTypeReference.TypeArguments.Add(keyTypeName);
            }

            CodeDomUtilities.SetInterface(iuserCodeTypeReference);
            CodeDomUtilities.SetInterface(iuserGenericCodeTypeReference);
            typeDeclaration.BaseTypes.Add(iuserCodeTypeReference);

            CodeMemberProperty idProperty = new CodeMemberProperty();
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityUser.KeyPropertyName : "EntityKey")));

            CodeMemberProperty userNameProperty = new CodeMemberProperty();
            userNameProperty.Type = new CodeTypeReference(typeof(string));
            userNameProperty.Name = "UserName";
            userNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name), new CodePropertySetValueReferenceExpression()));
            userNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name)));

            if (generic || supportGeneric)
            {
                idProperty.PrivateImplementationType = GetPrivateImplementationGenericType(InputProducer.LanguageCode, "Microsoft.AspNet.Identity.IUser", keyTypeName);
                idProperty.ImplementationTypes.Add(iuserGenericCodeTypeReference);
                userNameProperty.PrivateImplementationType = GetPrivateImplementationGenericType(InputProducer.LanguageCode, "Microsoft.AspNet.Identity.IUser", keyTypeName);
                userNameProperty.ImplementationTypes.Add(iuserGenericCodeTypeReference);
            }
            else
            {
                idProperty.PrivateImplementationType = iuserCodeTypeReference;
                idProperty.ImplementationTypes.Add(iuserCodeTypeReference);
                userNameProperty.PrivateImplementationType = iuserCodeTypeReference;
                userNameProperty.ImplementationTypes.Add(iuserCodeTypeReference);
            }

            typeDeclaration.Members.Add(idProperty);
            typeDeclaration.Members.Add(userNameProperty);
        }

        private static CodeTypeReference GetPrivateImplementationGenericType(LanguageCode language, string typeName, params string[] arguments)
        {
            if (typeName == null) throw new ArgumentNullException("typeName");
            if (arguments == null) throw new ArgumentNullException("arguments");
            if (arguments.Length == 0) throw new ArgumentException(null, "arguments");

            int indexOf = typeName.IndexOf('`');
            if (indexOf < 0)
            {
                indexOf = typeName.Length;
            }

            if (language == LanguageCode.CSharp)
            {
                string str = typeName.Substring(0, indexOf) + "<";
                for (int index = 0; index < arguments.Length; ++index)
                {
                    if (index > 0)
                        str += ",";

                    str += CodeDomUtilities.CreateCSharpEscapedIdentifier(arguments[index]);
                }
                return new CodeTypeReference(str + ">");
            }

            if (language == LanguageCode.VisualBasic)
            {
                string str1 = typeName.Substring(0, indexOf) + "(Of ";
                for (int index = 0; index < arguments.Length; ++index)
                {
                    if (index > 0)
                        str1 += ",";
                    str1 += CodeDomUtilities.CreateVisualBasicEscapedIdentifier(arguments[index]);
                }
                return new CodeTypeReference((str1 + ")").Replace("(Of ", "_").Replace(")", "_"));
            }

            return CodeDomUtilities.GetGenericType(typeName, arguments);
        }

        public override void Produce()
        {
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
