using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityLogin
    {
        public IdentityLogin(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LoginKey);
            ProviderKeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LoginProviderKey);
            ProviderNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LoginProviderName);
            ProviderDisplayNameProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LoginProviderDisplayName);
            UserProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.LoginUser);

            DeleteByUserLoginInfoMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.DeleteLoginByUserLoginInfo);
        }

        public Entity Entity { get; set; }

        public Property KeyProperty { get; private set; }
        public Property ProviderKeyProperty { get; private set; }
        public Property ProviderNameProperty { get; private set; }
        public Property ProviderDisplayNameProperty { get; private set; }
        public Property UserProperty { get; private set; }

        public Method DeleteByUserLoginInfoMethod { get; private set; }
    }
}