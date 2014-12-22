using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityUserClaim
    {
        public IdentityUserClaim(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimKey);
            TypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimType);
            ValueProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimValue);
            ValueTypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimValueType);
            IssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimIssuer);
            OriginalIssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimOriginalIssuer);
            UserProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.UserClaimUser);

            DeleteClaimsMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.DeleteUserClaimsByClaim);
            LoadClaimsMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserClaimsByClaim);
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
        public Property TypeProperty { get; private set; }
        public Property ValueProperty { get; private set; }
        public Property ValueTypeProperty { get; private set; }
        public Property IssuerProperty { get; private set; }
        public Property OriginalIssuerProperty { get; private set; }
        public Property UserProperty { get; private set; }

        public Method DeleteClaimsMethod { get; private set; }
        public Method LoadClaimsMethod { get; private set; }



    }
}