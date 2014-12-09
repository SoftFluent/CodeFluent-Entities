using System;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityClaim
    {
        public IdentityClaim(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimKey);
            TypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimType);
            ValueProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimValue);
            ValueTypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimValueType);
            IssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimIssuer);
            OriginalIssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimOriginalIssuer);
            UserProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimUser);

            DeleteClaimsMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.DeleteUserClaims);
            LoadClaimsMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadUserClaims);
        }

        public Entity Entity { get; set; }

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