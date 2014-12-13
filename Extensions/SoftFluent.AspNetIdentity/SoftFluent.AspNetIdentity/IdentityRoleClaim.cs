using System;
using System.Linq;
using CodeFluent.Model;
using CodeFluent.Model.Code;

namespace SoftFluent.AspNetIdentity
{
    public class IdentityRoleClaim
    {
        public IdentityRoleClaim(Entity entity)
        {
            if (entity == null) throw new ArgumentNullException("entity");

            Entity = entity;

            KeyProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimKey);
            ValueProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimClaimValue);
            TypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimClaimType);
            ValueTypeProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimClaimValueType);
            IssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimClaimIssuer);
            IssuerProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimClaimOriginalIssuer);
            RoleProperty = ProjectUtilities.FindByPropertyType(Entity, PropertyType.RoleClaimRole);

            LoadByRoleMethod = ProjectUtilities.FindByMethodType(Entity, MethodType.LoadRoleClaimsByRole);
            if (LoadByRoleMethod == null && RoleProperty?.ProjectEntity != null)
            {
                LoadByRoleMethod = entity.LoadMethods.FirstOrDefault(
                    method =>
                        method.Parameters.Count == 1 &&
                        method.Parameters[0].ClrFullTypeName == RoleProperty.ProjectEntity.ClrFullTypeName);
            }
        }

        public Entity Entity { get; set; }

        public Property KeyProperty { get; private set; }
        public Property ValueProperty { get; private set; }
        public Property TypeProperty { get; private set; }
        public Property ValueTypeProperty { get; private set; }
        public Property IssuerProperty { get; private set; }
        public Property OriginalIssuerProperty { get; private set; }
        public Property RoleProperty { get; private set; }

        public Method LoadByRoleMethod { get; private set; }

        public string KeyTypeName
        {
            get
            {
                if (KeyProperty != null)
                    return KeyProperty.ClrFullTypeName;

                return typeof(string).FullName; // EntityKey
            }
        }

        public bool CanImplementGenericInterface
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