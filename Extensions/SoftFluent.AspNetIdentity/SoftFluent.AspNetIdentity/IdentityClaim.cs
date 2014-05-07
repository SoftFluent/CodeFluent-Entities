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

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsKey);
            TypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsType);
            ValueProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsValue);
            ValueTypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsValueType);
            IssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsIssuer);
            OriginalIssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.ClaimsOriginalIssuer);
            UserProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.User);

            DeleteClaimMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.DeleteClaim);
        }

        public Entity Entity { get; set; }

        public Property KeyProperty { get; private set; }
        public Property TypeProperty { get; private set; }
        public Property ValueProperty { get; private set; }
        public Property ValueTypeProperty { get; private set; }
        public Property IssuerProperty { get; private set; }
        public Property OriginalIssuerProperty { get; private set; }
        public Property UserProperty { get; private set; }

        public Method DeleteClaimMethod { get; private set; }

     

    }
}