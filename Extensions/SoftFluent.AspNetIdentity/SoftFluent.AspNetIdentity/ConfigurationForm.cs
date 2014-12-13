using System;
using System.Linq;
using System.Windows.Forms;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Runtime.UI;
using CodeFluent.Runtime.Utilities;
using Message = CodeFluent.Model.Message;

namespace SoftFluent.AspNetIdentity
{
    public partial class ConfigurationForm : Form
    {
        private readonly AspNetIdentityProducer _aspNetIdentityProducer;
        private readonly Project _project;

        public ConfigurationForm(AspNetIdentityProducer aspNetIdentityProducer, Project project)
        {
            if (project == null)
                throw new ArgumentNullException("project");

            _aspNetIdentityProducer = aspNetIdentityProducer;
            _project = project;

            InitializeComponent();

            InitializeEntities();
            UpdateControls();
        }

        private void InitializeEntities()
        {
            Entity userEntity = ProjectUtilities.FindByEntityType(_project, EntityType.User);
            Entity claimEntity = ProjectUtilities.FindByEntityType(_project, EntityType.UserClaim);
            Entity loginEntity = ProjectUtilities.FindByEntityType(_project, EntityType.UserLogin);
            Entity roleEntity = ProjectUtilities.FindByEntityType(_project, EntityType.Role);
            Entity userRoleEntity = ProjectUtilities.FindByEntityType(_project, EntityType.UserRole);
            Entity roleClaimEntity = ProjectUtilities.FindByEntityType(_project, EntityType.RoleClaim);
            var entity = userEntity ?? claimEntity ?? loginEntity ?? roleEntity ?? userRoleEntity ?? roleClaimEntity;

            Property emailProperty = userEntity == null ? null : ProjectUtilities.FindByPropertyType(userEntity, PropertyType.UserEmail);
            Property phoneNumberProperty = userEntity == null ? null : ProjectUtilities.FindByPropertyType(userEntity, PropertyType.UserPhoneNumber);

            foreach (Namespace ns in _project.AllNamespaces)
            {
                comboBoxNamespace.Items.Add(ns.FullName);
            }

            // Set namespace
            if (entity != null)
            {
                comboBoxNamespace.Text = entity.Namespace;
            }
            else
            {
                comboBoxNamespace.Text = _project.DefaultNamespace;
            }

            // initialize checkbox
            checkBoxClaims.Checked = claimEntity != null;
            checkBoxExternalLogins.Checked = loginEntity != null;
            checkBoxRole.Checked = roleEntity != null;
            checkBoxRoleClaim.Checked = roleClaimEntity != null;
            //checkBoxUserRole.Checked = userRoleEntity != null;
            checkBoxEmailUnique.Checked = emailProperty != null && emailProperty.IsUnique;
            checkBoxPhoneNumberUnique.Checked = phoneNumberProperty != null && phoneNumberProperty.IsUnique;
        }

        void UpdateControls()
        {
            textBoxClaimsEntityName.Enabled = checkBoxClaims.Checked;
            textBoxUserLoginsEntityName.Enabled = checkBoxExternalLogins.Checked;
            textBoxRoleEntityName.Enabled = checkBoxRole.Checked;
            textBoxRoleClaimEntityName.Enabled = checkBoxRoleClaim.Checked;
            //textBoxUserRoleEntityName.Enabled = checkBoxUserRole.Checked;
            buttonOk.Enabled = IsValid();
        }

        bool IsValid()
        {
            if (checkBoxClaims.Checked && string.IsNullOrWhiteSpace(textBoxClaimsEntityName.Text))
                return false;

            if (checkBoxExternalLogins.Checked && string.IsNullOrWhiteSpace(textBoxUserLoginsEntityName.Text))
                return false;

            if (checkBoxRole.Checked && string.IsNullOrWhiteSpace(textBoxRoleEntityName.Text))
                return false;

            if (checkBoxRoleClaim.Checked && string.IsNullOrWhiteSpace(textBoxRoleClaimEntityName.Text))
                return false;

            //if (checkBoxUserRole.Checked && string.IsNullOrWhiteSpace(textBoxUserRoleEntityName.Text))
            //    return false;

            if (string.IsNullOrWhiteSpace(textBoxUserEntityName.Text))
                return false;

            if (string.IsNullOrWhiteSpace(comboBoxNamespace.Text))
                return false;

            return true;
        }

        private void checkBox_CheckedChanged(object sender, EventArgs e)
        {
            UpdateControls();
        }

        private void textBoxEntityName_TextChanged(object sender, EventArgs e)
        {
            UpdateControls();
        }

        private void buttonOk_Click(object sender, EventArgs e)
        {
            Entity userEntity = CreateUserEntity();
            Entity roleEntity = null;
            //Entity userRoleEntity = null;
            Entity loginsEntity = null;
            Entity claimsEntity = null;
            Entity roleClaimEntity = null;

            if (checkBoxRole.Checked)
            {
                roleEntity = CreateRoleEntity();
            }

            //if (checkBoxUserRole.Checked)
            //{
            //    userRoleEntity = CreateUserRoleEntity();
            //    AddRelation(userEntity, PropertyType.Roles, userRoleEntity, PropertyType.User, RelationType.ManyToOne);
            //    AddRelation(roleEntity, PropertyType.RoleUsers, userRoleEntity, PropertyType.Role, RelationType.ManyToOne);
            //}
            //else
            //{
            AddRelation(userEntity, PropertyType.UserRoles, roleEntity, PropertyType.RoleUsers, RelationType.ManyToMany);
            //}

            if (checkBoxClaims.Checked)
            {
                claimsEntity = CreateUserClaimsEntity();
                AddRelation(userEntity, PropertyType.UserClaims, claimsEntity, PropertyType.UserClaimUser, RelationType.ManyToOne);
            }

            if (checkBoxExternalLogins.Checked)
            {
                loginsEntity = CreateLoginsEntity();
                AddRelation(userEntity, PropertyType.UserLogins, loginsEntity, PropertyType.UserLoginUser, RelationType.ManyToOne);
            }

            if (checkBoxRoleClaim.Checked)
            {
                roleClaimEntity = CreateRoleClaimEntity();
                AddRelation(roleEntity, PropertyType.RoleClaims, roleClaimEntity, PropertyType.RoleClaimRole, RelationType.ManyToOne);
            }

            CreateUserMethods(userEntity, loginsEntity);

            SetCollectionMode(userEntity);
            SetCollectionMode(roleEntity);
            //SetCollectionMode(userRoleEntity);
            SetCollectionMode(loginsEntity);
            SetCollectionMode(claimsEntity);
            SetCollectionMode(roleClaimEntity);

            if (_aspNetIdentityProducer.MustCreateMessages)
            {
                ProjectMessages messages = new ProjectMessages(_project);
                if (messages.RoleNotFoundMessage == null)
                {
                    var message = new Message
                    {
                        EditorName = "RoleNotFound",
                        Class = MessageClass._default.ToString(),
                        CultureName = ConvertUtilities.ToCultureInfo(_aspNetIdentityProducer.MessagesCulture, _project.Culture).Name,
                        Value = "Role '{0}' does not exist.",
                        AddToRuntimeResourceFile = true
                    };
                    message.SetAttributeValue("", "messageType", Constants.NamespaceUri, ProjectMessageType.RoleNotFound);
                    _project.Messages.Add(message);
                }
            }

            this.Close();
        }

        private void SetCollectionMode(Entity entity)
        {
            if (entity == null)
                return;

            int keyPropertyCount = entity.KeyProperties.Count;
            if (keyPropertyCount > 1)
            {
                entity.SetType = SetType.List;
            }
        }

        public static void AddRelation(Entity fromEntity, PropertyType fromPropertyType, Entity toEntity, PropertyType toPropertyType, RelationType relationType)
        {
            if (fromEntity == null || toEntity == null)
                return;

            Property fromProperty = ProjectUtilities.FindByPropertyType(fromEntity, fromPropertyType);
            Property toProperty = ProjectUtilities.FindByPropertyType(toEntity, toPropertyType);

            if (fromProperty == null || toProperty == null)
                return;

            switch (relationType)
            {
                case RelationType.OneToOne:
                    fromProperty.TypeName = toEntity.ClrFullTypeName;
                    toProperty.TypeName = fromEntity.ClrFullTypeName;
                    break;
                case RelationType.OneToMany:
                    fromProperty.TypeName = toEntity.ClrFullTypeName;
                    toProperty.TypeName = fromEntity.Set.ClrFullTypeName;
                    break;
                case RelationType.ManyToOne:
                    fromProperty.TypeName = toEntity.Set.ClrFullTypeName;
                    toProperty.TypeName = fromEntity.ClrFullTypeName;
                    break;
                case RelationType.ManyToMany:
                    fromProperty.TypeName = toEntity.Set.ClrFullTypeName;
                    toProperty.TypeName = fromEntity.Set.ClrFullTypeName;
                    break;
            }

            fromProperty.SetRelation(toProperty, relationType);

            switch (relationType)
            {
                case RelationType.OneToMany:
                    toProperty.CascadeDelete = CascadeType.Before;
                    break;
                case RelationType.ManyToOne:
                    fromProperty.CascadeDelete = CascadeType.Before;
                    break;
            }
        }

        private Entity CreateUserEntity()
        {
            Entity entity = GetOrCreateEntity(EntityType.User, textBoxUserEntityName.Text, comboBoxNamespace.Text);
            foreach (var typeProperty in TypeProperty.UserProperties)
            {
                if (!MustGenerate(EntityType.User, typeProperty))
                    continue;

                Property property = GetOrCreateProperty(entity, typeProperty);
                if (typeProperty.IdentityPropertyType == PropertyType.UserKey)
                {
                    property.IsKey = true;
                }
                else if (typeProperty.IdentityPropertyType == PropertyType.UserName)
                {
                    property.IsCollectionKey = true;
                }
                else if (typeProperty.IdentityPropertyType == PropertyType.UserEmail)
                {
                    property.EditorIsUnique = checkBoxEmailUnique.Checked;
                }
                else if (typeProperty.IdentityPropertyType == PropertyType.UserPhoneNumber)
                {
                    property.EditorIsUnique = checkBoxPhoneNumberUnique.Checked;
                }
            }

            return entity;
        }

        private void CreateUserMethods(Entity userEntity, Entity loginEntity)
        {
            if (userEntity == null) throw new ArgumentNullException("userEntity");

            // LoadByUserLoginInfo
            if (loginEntity != null)
            {
                var loginsProperty = ProjectUtilities.FindByPropertyType(userEntity, PropertyType.UserLogins);
                var providerKeyProperty = ProjectUtilities.FindByPropertyType(loginEntity, PropertyType.UserLoginProviderKey);
                var providerNameProperty = ProjectUtilities.FindByPropertyType(loginEntity, PropertyType.UserLoginProviderName);
                if (loginsProperty != null && providerKeyProperty != null)
                {
                    Method loadByProviderKeyMethod = ProjectUtilities.FindByMethodType(userEntity, MethodType.LoadUserByUserLoginInfo);
                    if (loadByProviderKeyMethod == null)
                    {
                        loadByProviderKeyMethod = new Method();
                        loadByProviderKeyMethod.Name = "LoadByUserLoginInfo";
                        loadByProviderKeyMethod.SetAttributeValue("", "methodType", Constants.NamespaceUri, MethodType.LoadUserByUserLoginInfo);
                        userEntity.Methods.Add(loadByProviderKeyMethod);

                        Body body = new Body();
                        if (providerNameProperty != null)
                        {
                            body.Text = string.Format("LOADONE(string providerKey, string providerName) WHERE {0}.{1} = @providerKey AND {0}.{2} = @providerName", loginsProperty.Name, providerKeyProperty.Name, providerNameProperty.Name);
                        }
                        else
                        {
                            body.Text = string.Format("LOADONE(string providerKey) WHERE {0}.{1} = @providerKey", loginsProperty.Name, providerKeyProperty.Name);
                        }

                        loadByProviderKeyMethod.Bodies.Add(body);
                    }
                }
            }

            // LoadUserByEmail
            var emailProperty = ProjectUtilities.FindByPropertyType(userEntity, PropertyType.UserEmail);
            if (emailProperty != null)
            {
                Method loadByEmailMethod = ProjectUtilities.FindByMethodType(userEntity, MethodType.LoadUserByEmail);
                if (loadByEmailMethod == null)
                {
                    loadByEmailMethod = new Method();
                    loadByEmailMethod.Name = "LoadByEmail";
                    loadByEmailMethod.SetAttributeValue("", "methodType", Constants.NamespaceUri, MethodType.LoadUserByEmail);
                    userEntity.Methods.Add(loadByEmailMethod);

                    Body body = new Body();
                    body.Text = string.Format("LOADONE({0}) WHERE {0} = @{0}", emailProperty.Name);

                    loadByEmailMethod.Bodies.Add(body);
                }
            }
        }

        private Entity CreateRoleEntity()
        {
            Entity entity = GetOrCreateEntity(EntityType.Role, textBoxRoleEntityName.Text, comboBoxNamespace.Text);
            foreach (var typeProperty in TypeProperty.RoleProperties)
            {
                if (!MustGenerate(EntityType.User, typeProperty))
                    continue;

                Property property = GetOrCreateProperty(entity, typeProperty);
                if (typeProperty.IdentityPropertyType == PropertyType.RoleKey)
                {
                    property.IsKey = true;
                }
                else if (typeProperty.IdentityPropertyType == PropertyType.RoleName)
                {
                    property.IsCollectionKey = true;
                }
            }

            return entity;
        }

        //private Entity CreateUserRoleEntity()
        //{
        //    Entity entity = GetOrCreateEntity(EntityType.UserRole, textBoxUserRoleEntityName.Text, comboBoxNamespace.Text);
        //    foreach (var typeProperty in TypeProperty.UserRoleProperties)
        //    {
        //        if (!MustGenerate(EntityType.User, typeProperty))
        //            continue;

        //        Property property = GetOrCreateProperty(entity, typeProperty);
        //        property.IsKey = true;
        //    }

        //    return entity;
        //}

        private Entity CreateUserClaimsEntity()
        {
            Entity entity = GetOrCreateEntity(EntityType.UserClaim, textBoxClaimsEntityName.Text, comboBoxNamespace.Text);
            foreach (var typeProperty in TypeProperty.ClaimsProperties)
            {
                if (!MustGenerate(EntityType.UserClaim, typeProperty))
                    continue;

                Property property = GetOrCreateProperty(entity, typeProperty);

                if (typeProperty.IdentityPropertyType == PropertyType.UserClaimKey)
                {
                    property.IsKey = true;
                }
            }

            Method deleteMethod = ProjectUtilities.FindByMethodType(entity, MethodType.DeleteUserClaimsByClaim);
            if (deleteMethod == null)
            {
                deleteMethod = new Method();
                deleteMethod.Name = "DeleteByClaim";
                deleteMethod.SetAttributeValue("", "methodType", Constants.NamespaceUri, MethodType.DeleteUserClaimsByClaim);
                entity.Methods.Add(deleteMethod);

                Body body = new Body();
                string typePropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserClaimType).Name;
                string valuePropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserClaimValue).Name;
                body.Text = string.Format("DELETE({0}, {1}) WHERE {0} = @{0} AND {1} = @{1}", typePropertyName, valuePropertyName);

                deleteMethod.Bodies.Add(body);
            }

            Method loadMethod = ProjectUtilities.FindByMethodType(entity, MethodType.LoadUserClaimsByClaim);
            if (loadMethod == null)
            {
                deleteMethod = new Method();
                deleteMethod.Name = "LoadByClaim";
                deleteMethod.SetAttributeValue("", "methodType", Constants.NamespaceUri, MethodType.LoadUserClaimsByClaim);
                entity.Methods.Add(deleteMethod);

                Body body = new Body();
                string typePropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserClaimType).Name;
                string valuePropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserClaimValue).Name;
                body.Text = string.Format("LOAD({0}, {1}) WHERE {0} = @{0} AND {1} = @{1}", typePropertyName, valuePropertyName);

                deleteMethod.Bodies.Add(body);
            }

            return entity;
        }

        private Entity CreateLoginsEntity()
        {
            Entity entity = GetOrCreateEntity(EntityType.UserLogin, textBoxUserLoginsEntityName.Text, comboBoxNamespace.Text);
            foreach (var typeProperty in TypeProperty.UserLoginProperties)
            {
                if (!MustGenerate(EntityType.UserLogin, typeProperty))
                    continue;

                Property property = GetOrCreateProperty(entity, typeProperty);

                if (typeProperty.IdentityPropertyType == PropertyType.UserLoginProviderKey ||
                    typeProperty.IdentityPropertyType == PropertyType.UserLoginProviderName ||
                    typeProperty.IdentityPropertyType == PropertyType.UserLoginUser)
                {
                    property.AddUniqueConstraintName("ASP.NET_Identity");
                }
            }

            Method deleteMethod = ProjectUtilities.FindByMethodType(entity, MethodType.DeleteUserLoginByUserLoginInfo);
            if (deleteMethod == null)
            {
                deleteMethod = new Method();
                deleteMethod.Name = "DeleteByUserLoginInfo";
                deleteMethod.SetAttributeValue("", "methodType", Constants.NamespaceUri, MethodType.DeleteUserLoginByUserLoginInfo);
                entity.Methods.Add(deleteMethod);

                Body body = new Body();
                string userPropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserLoginUser).Name;
                string providerKeyPropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserLoginProviderKey).Name;
                string providerNamePropertyName = ProjectUtilities.FindByPropertyType(entity, PropertyType.UserLoginProviderName)?.Name;
                if (providerNamePropertyName != null)
                {
                    body.Text = string.Format("DELETE({0}, {1}, {2}) WHERE {0} = @{0} AND {1} = @{1} AND {2} = @{2}", userPropertyName, providerKeyPropertyName, providerNamePropertyName);
                }
                else
                {
                    body.Text = string.Format("DELETE({0}, {1}) WHERE {0} = @{0} AND {1} = @{1}", userPropertyName, providerKeyPropertyName);
                }

                deleteMethod.Bodies.Add(body);
            }

            return entity;
        }

        private Entity CreateRoleClaimEntity()
        {
            Entity entity = GetOrCreateEntity(EntityType.RoleClaim, textBoxRoleClaimEntityName.Text, comboBoxNamespace.Text);
            foreach (var typeProperty in TypeProperty.RoleClaimProperties)
            {
                if (!MustGenerate(EntityType.RoleClaim, typeProperty))
                    continue;

                Property property = GetOrCreateProperty(entity, typeProperty);
            }

            return entity;
        }

        private bool MustGenerate(EntityType entityType, TypeProperty property)
        {
            switch (entityType)
            {
                case EntityType.User:
                    switch (property.IdentityPropertyType)
                    {
                        case PropertyType.UserRoles:
                            return checkBoxRole.Checked;
                        case PropertyType.UserClaims:
                            return checkBoxClaims.Checked;
                        case PropertyType.UserLogins:
                            return checkBoxExternalLogins.Checked;
                    }
                    break;

                case EntityType.Role:
                    switch (property.IdentityPropertyType)
                    {
                        case PropertyType.RoleClaims:
                            return checkBoxRoleClaim.Checked;
                    }
                    break;

            }

            return true;
        }

        private Entity GetOrCreateEntity(EntityType entityType, string entityName, string @namespace)
        {
            Entity entity = _project.Entities.Find(entityName);
            if (entity == null)
            {
                entity = ProjectUtilities.FindByEntityType(_project, entityType);
                if (entity != null)
                {
                    entity.Name = entityName; // Rename
                }
            }

            if (entity == null)
            {
                entity = new Entity();
                entity.Name = entityName;
                entity.Namespace = @namespace;
                entity.SetAttributeValue("", "entityType", Constants.NamespaceUri, entityType);
                _project.Entities.Add(entity);
            }

            return entity;
        }

        private Property GetOrCreateProperty(Entity entity, TypeProperty typeProperty)
        {
            Property property = entity.Properties.Find(typeProperty.CanonicalName, StringComparison.OrdinalIgnoreCase);
            if (property == null)
            {
                property = ProjectUtilities.FindByPropertyType(entity, typeProperty.IdentityPropertyType);
                if (property != null)
                {
                    property.Name = typeProperty.CanonicalName;
                }
            }

            if (property == null)
            {
                property = new Property();
                property.Name = typeProperty.CanonicalName;
                property.TypeName = typeProperty.ExpectedType;
                if (typeProperty.ExpectedUIType != UIType.Unspecified)
                {
                    property.UIType = typeProperty.ExpectedUIType;
                }

                property.IsNullable = typeProperty.Nullable;

                if (!property.IsNullable && (
                    property.ClrFullTypeName == typeof(int).FullName ||
                    property.ClrFullTypeName == typeof(uint).FullName ||
                    property.ClrFullTypeName == typeof(short).FullName ||
                    property.ClrFullTypeName == typeof(ushort).FullName ||
                    property.ClrFullTypeName == typeof(long).FullName ||
                    property.ClrFullTypeName == typeof(ulong).FullName ||
                    property.ClrFullTypeName == typeof(byte).FullName ||
                    property.ClrFullTypeName == typeof(sbyte).FullName ||
                    property.ClrFullTypeName == typeof(float).FullName ||
                    property.ClrFullTypeName == typeof(decimal).FullName ||
                    property.ClrFullTypeName == typeof(double).FullName ||
                    property.ClrFullTypeName == typeof(DateTime).FullName ||
                    property.ClrFullTypeName == typeof(TimeSpan).FullName ||
                    property.ClrFullTypeName == typeof(DateTimeOffset).FullName ||
                    property.ClrFullTypeName == typeof(Guid).FullName ||
                    property.ClrFullTypeName == typeof(bool).FullName))
                {
                    property.MustUsePersistenceDefaultValue = false;
                }

                property.SetAttributeValue("", "propertyType", Constants.NamespaceUri, typeProperty.IdentityPropertyType);
                entity.Properties.Add(property);
            }

            return property;
        }
    }
}
