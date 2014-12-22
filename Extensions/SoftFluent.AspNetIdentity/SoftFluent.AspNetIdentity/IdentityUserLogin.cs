using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityUserLogin
    {
        public IdentityUserLogin(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLoginKey);
            ProviderKeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLoginProviderKey);
            ProviderNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLoginProviderName);
            ProviderDisplayNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLoginProviderDisplayName);
            UserProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserLoginUser);

            DeleteByUserLoginInfoMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.DeleteUserLoginByUserLoginInfo);
        }

        public Entity Entity { get; set; }

        public string ClrFullTypeName
        {
            get
            {
                if (Entity == null)
                    return null;

                return Entity.ClrFullTypeName;
            }
        }

        public Property KeyProperty { get; private set; }
        public Property ProviderKeyProperty { get; private set; }
        public Property ProviderNameProperty { get; private set; }
        public Property ProviderDisplayNameProperty { get; private set; }
        public Property UserProperty { get; private set; }

        public Method DeleteByUserLoginInfoMethod { get; private set; }
    }
}