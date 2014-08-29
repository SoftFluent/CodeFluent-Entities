using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;

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
            CreationDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.CreationDate);
            EmailProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.Email);
            EmailConfirmedProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.EmailConfirmed);
            PhoneNumberProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.PhoneNumber);
            PhoneNumberConfirmedProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.PhoneNumberConfirmed);
            PasswordProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.Password);
            LastPasswordChangeDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LastPasswordChangeDate);
            FailedPasswordAttemptCountProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.FailedPasswordAttemptCount);
            FailedPasswordAttemptWindowStartProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.FailedPasswordAttemptWindowStart);
            LockoutEnabledProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LockoutEnabled);
            LockoutEndDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LockoutEndDate);
            LastProfileUpdateDateProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LastProfileUpdateDate);
            TwoFactorEnabledProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.TwoFactorEnabled);
            SecurityStampProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.SecurityStamp);
            RolesProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.Roles);
            ClaimsProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.Claims);
            LoginsProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.Logins);

            LoadByKeyMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByKey);
            if (LoadByKeyMethod != null)
            {
                LoadByKeyMethodName = LoadByKeyMethod.Name;
            }
            else if (KeyProperty != null && Entity.LoadByKeyMethod != null)
            {
                LoadByKeyMethodName = Entity.LoadByKeyMethod.Name;
            }
            else
            {
                LoadByKeyMethodName = "LoadByEntityKey";
            }

            LoadByUserNameMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByUserName) ?? Entity.LoadByCollectionKeyMethod;
            LoadByEmailMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByEmail) ?? Entity.Methods.Find("LoadByEmail", StringComparison.OrdinalIgnoreCase) ?? Entity.LoadByCollectionKeyMethod;
            LoadByProviderKeyMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserByProviderKey);
            LoadAllMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadAll) ?? Entity.LoadAllMethod;
        }

        public Entity Entity { get; set; }

        public Property KeyProperty { get; private set; }
        public Property UserNameProperty { get; private set; }
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
        public Method LoadByProviderKeyMethod { get; private set; }
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

        public bool MustImplementGenericInterface
        {
            get { return KeyProperty != null && KeyProperty.ClrFullTypeName != typeof(string).FullName; }
        }

        public string KeyPropertyName
        {
            get
            {
                if (KeyProperty != null)
                    return KeyProperty.Name;

                return "EntityKey";
            }
        }
    }
}