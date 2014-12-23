using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;
using CodeFluent.Runtime.Model;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityUser
    {
        public IdentityUser(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserKey);
            UserNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserName) ?? ProjectUtilities.FindNameProperty(entity);
            NormalizedUserNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserNormalizedName) ?? UserNameProperty;
            CreationDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserCreationDate);
            EmailProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserEmail);
            EmailConfirmedProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserEmailConfirmed);
            PhoneNumberProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserPhoneNumber);
            PhoneNumberConfirmedProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserPhoneNumberConfirmed);
            PasswordProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserPassword);
            LastPasswordChangeDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLastPasswordChangeDate);
            FailedPasswordAttemptCountProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserFailedPasswordAttemptCount);
            FailedPasswordAttemptWindowStartProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserFailedPasswordAttemptWindowStart);
            LockoutEnabledProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLockoutEnabled);
            LockoutEndDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLockoutEndDate);
            LastProfileUpdateDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLastProfileUpdateDate);
            TwoFactorEnabledProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserTwoFactorEnabled);
            SecurityStampProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserSecurityStamp);
            RolesProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserRoles);
            ClaimsProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaims);
            LoginsProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLogins);

            LoadByKeyMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByKey);
            if (LoadByKeyMethod != null)
            {
                LoadByKeyMethodName = LoadByKeyMethod.Name;
            }
            else if (KeyProperty != null && Entity.LoadByKeyMethod != null)
            {
                LoadByKeyMethod = Entity.LoadByKeyMethod;
                LoadByKeyMethodName = Entity.LoadByKeyMethod.Name;
            }
            else
            {
                LoadByKeyMethodName = "LoadByEntityKey";
            }

            LoadByUserNameMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByUserName) ?? Entity.LoadByCollectionKeyMethod;
            LoadByEmailMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByEmail) ?? Entity.Methods.Find("LoadByEmail", StringComparison.OrdinalIgnoreCase) ?? (EmailProperty != null && EmailProperty.IsCollectionKey ? Entity.LoadByCollectionKeyMethod : null);
            LoadByUserLoginInfoMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByUserLoginInfo);
            LoadAllMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadAllUsers) ?? Entity.LoadAllMethod;
        }

        public Entity Entity { get; private set; }

        public string ClrFullTypeName
        {
            get
            {
                if (Entity != null)
                    return Entity.ClrFullTypeName;
                return null;
            }
        }

        public string StringKeyPropertyName
        {
            get
            {
                if (KeyProperty != null && KeyProperty.ClrFullTypeName == typeof(string).FullName)
                    return KeyProperty.Name;

                return ViewPropertyDescriptor.EntityKey;
            }
        }

        public Property KeyProperty { get; private set; }
        public Property UserNameProperty { get; private set; }
        public Property NormalizedUserNameProperty { get; private set; }
        public Property CreationDateProperty { get; private set; }
        public Property EmailProperty { get; private set; }
        public Property EmailConfirmedProperty { get; private set; }
        public Property PhoneNumberProperty { get; private set; }
        public Property PhoneNumberConfirmedProperty { get; private set; }
        public Property PasswordProperty { get; private set; }
        public Property LastPasswordChangeDateProperty { get; private set; }
        public Property FailedPasswordAttemptCountProperty { get; private set; }
        public Property FailedPasswordAttemptWindowStartProperty { get; private set; }
        public Property LockoutEnabledProperty { get; private set; }
        public Property LockoutEndDateProperty { get; private set; }
        public Property LastProfileUpdateDateProperty { get; private set; }
        public Property TwoFactorEnabledProperty { get; private set; }
        public Property SecurityStampProperty { get; private set; }
        public Property RolesProperty { get; private set; }
        public Property ClaimsProperty { get; private set; }
        public Property LoginsProperty { get; private set; }
        public Method LoadByKeyMethod { get; private set; }
        public string LoadByKeyMethodName { get; private set; }
        public Method LoadByUserNameMethod { get; private set; }
        public Method LoadByEmailMethod { get; private set; }
        public Method LoadByUserLoginInfoMethod { get; private set; }
        public Method LoadAllMethod { get; private set; }

        public string KeyTypeName
        {
            get
            {
                if (KeyProperty != null)
                    return KeyProperty.ClrFullTypeName;

                return typeof(string).FullName; // EntityKey
            }
        }

        public bool IsStringId
        {
            get { return KeyProperty == null || KeyProperty.ClrFullTypeName == typeof(string).FullName; }
        }

        public string KeyPropertyName
        {
            get
            {
                if (KeyProperty != null)
                    return KeyProperty.Name;

                return ViewPropertyDescriptor.EntityKey;
            }
        }
    }
}