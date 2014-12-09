using System;
using System.CodeDom;
using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
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
        //private CodeDomProducer _codeDomProducer;
        private IdentityUser _identityUser;
        private IdentityRole _identityRole;
        private IdentityLogin _identityLogin;
        private IdentityClaim _identityClaim;
        private IdentityRoleClaim _identityRoleClaim;
        private UserStoreProducer _userStoreProducer;
        private UserStore3Producer _userStore3Producer;
        private RoleStoreProducer _roleStoreProducer;
        private RoleStore3Producer _roleStore3Producer;

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

        private CodeDomProducer _inputProducer;
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

        //public Version TargetVersion
        //{
        //    get
        //    {
        //        switch (TargetVersion)
        //        {
        //            case AspNetIdentityVersion.Version1:
        //                return new Version(1, 0);
        //            case AspNetIdentityVersion.Version2:
        //                return new Version(2, 0);
        //            default:
        //                throw new ArgumentOutOfRangeException();
        //        }
        //    }
        //}

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

            if (InputProducer == null)
                return;

            if (string.IsNullOrWhiteSpace(EditorTargetDirectory))
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

            Entity roleClaimEntity = ProjectUtilities.FindByEntityType(project, EntityType.RoleClaim);
            if (claimEntity != null)
            {
                _identityRoleClaim = new IdentityRoleClaim(roleClaimEntity);
            }

            if (TargetVersion == AspNetIdentityVersion.Version1 || TargetVersion == AspNetIdentityVersion.Version2)
            {
                if (_identityUser != null)
                {
                    _userStoreProducer = new UserStoreProducer(InputProducer, this, _identityUser, _identityRole, _identityLogin, _identityClaim);
                }

                if (_identityRole != null)
                {
                    _roleStoreProducer = new RoleStoreProducer(InputProducer, this, _identityRole);
                }
            }
            else if (TargetVersion == AspNetIdentityVersion.Version3)
            {
                if (_identityUser != null)
                {
                    _userStore3Producer = new UserStore3Producer(InputProducer, this, _identityUser, _identityRole, _identityLogin, _identityClaim);
                }

                if (_identityRole != null)
                {
                    _roleStore3Producer = new RoleStore3Producer(InputProducer, this, _identityRole, _identityRoleClaim);
                }
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
                            var supportGeneric = TargetVersion == AspNetIdentityVersion.Version2 && !_identityUser.IsStringId;
                            if (supportGeneric)
                            {
                                ImplementIUser(typeDeclaration, true, supportGeneric);
                            }

                            ImplementIUser(typeDeclaration, false, supportGeneric);
                        }

                        else if (type.GetAttributeValue("entityType", NamespaceUri, EntityType.None) == EntityType.Role)
                        {
                            // Implements IRole<TKey> & IRole
                            var supportGeneric = TargetVersion == AspNetIdentityVersion.Version2 && !_identityRole.IsStringId;
                            if (supportGeneric)
                            {
                                ImplementIRole(typeDeclaration, true, supportGeneric);
                            }

                            ImplementIRole(typeDeclaration, false, supportGeneric);
                        }
                    }
                }
            }
        }

        private void ImplementIRole(CodeTypeDeclaration typeDeclaration, bool generic, bool supportGeneric)
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
            idProperty.PrivateImplementationType = generic || supportGeneric ? iroleGenericCodeTypeReference : iroleCodeTypeReference;
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityRole.KeyPropertyName : "EntityKey")));
            typeDeclaration.Members.Add(idProperty);

            CodeMemberProperty roleNameProperty = new CodeMemberProperty();
            roleNameProperty.PrivateImplementationType = generic || supportGeneric ? iroleGenericCodeTypeReference : iroleCodeTypeReference;
            roleNameProperty.Type = new CodeTypeReference(typeof(string));
            roleNameProperty.Name = "Name";
            roleNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name), new CodePropertySetValueReferenceExpression()));
            roleNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityRole.NameProperty.Name)));
            typeDeclaration.Members.Add(roleNameProperty);
        }

        private void ImplementIUser(CodeTypeDeclaration typeDeclaration, bool generic, bool supportGeneric)
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
            idProperty.PrivateImplementationType = generic || supportGeneric ? iuserGenericCodeTypeReference : iuserCodeTypeReference;
            idProperty.Type = new CodeTypeReference(keyTypeName);
            idProperty.Name = "Id";
            idProperty.HasSet = false;
            idProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), generic ? _identityUser.KeyPropertyName : "EntityKey")));
            typeDeclaration.Members.Add(idProperty);

            CodeMemberProperty userNameProperty = new CodeMemberProperty();
            userNameProperty.PrivateImplementationType = generic || supportGeneric ? iuserGenericCodeTypeReference : iuserCodeTypeReference;
            userNameProperty.Type = new CodeTypeReference(typeof(string));
            userNameProperty.Name = "UserName";
            userNameProperty.SetStatements.Add(new CodeAssignStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name), new CodePropertySetValueReferenceExpression()));
            userNameProperty.GetStatements.Add(new CodeMethodReturnStatement(new CodePropertyReferenceExpression(new CodeThisReferenceExpression(), _identityUser.UserNameProperty.Name)));
            typeDeclaration.Members.Add(userNameProperty);
        }

        public override void Produce()
        {
            if (InputProducer == null)
                throw new Exception("No CodeDom producer found.");

            if (_userStoreProducer != null && _userStoreProducer.CanImplementUserStore)
            {
                _userStoreProducer.Produce(true);
            }

            if (_roleStoreProducer != null && _roleStoreProducer.CanImplementRoleStore)
            {
                _roleStoreProducer.Produce(true);
            }

            if (_roleStore3Producer != null && _roleStore3Producer.CanImplementRoleStore)
            {
                _roleStore3Producer.Produce(true);
            }

            if (_userStore3Producer != null && _userStore3Producer.CanImplementUserStore)
            {
                _userStore3Producer.Produce(true);
            }
        }
    }
}
