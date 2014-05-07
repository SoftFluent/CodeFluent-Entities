using System.Collections.Generic;
using CodeFluent.Runtime.UI;

namespace SoftFluent.AspNetIdentity
{
    public class TypeProperty
    {
        public TypeProperty(string canonicalName, PropertyType identityPropertyType)
            : this(canonicalName, identityPropertyType, false, true)
        {
        }

        public TypeProperty(string canonicalName, PropertyType identityPropertyType, bool mandatory, bool nullable)
            : this(canonicalName, identityPropertyType, null, UIType.Unspecified, mandatory, nullable)
        {
        }

        public TypeProperty(string canonicalName, PropertyType identityPropertyType, string expectedType, bool nullable)
            : this(canonicalName, identityPropertyType, expectedType, false, nullable)
        {
        }

        public TypeProperty(string canonicalName, PropertyType identityPropertyType, string expectedType, bool mandatory, bool nullable)
            : this(canonicalName, identityPropertyType, expectedType, UIType.Unspecified, mandatory, nullable)
        {
        }

        public TypeProperty(string canonicalName, PropertyType identityPropertyType, string expectedType, UIType expectedUIType, bool nullable)
            : this(canonicalName, identityPropertyType, expectedType, expectedUIType, false, nullable)
        {
        }

        public TypeProperty(string canonicalName, PropertyType identityPropertyType, string expectedType, UIType expectedUIType, bool mandatory, bool nullable)
        {
            CanonicalName = canonicalName;
            ExpectedType = expectedType;
            ExpectedUIType = expectedUIType;
            Mandatory = mandatory;
            IdentityPropertyType = identityPropertyType;
            Nullable = nullable;

            //string name = CanonicalName;
            //if ((name.StartsWith("<")) && (name.EndsWith(">")))
            //{
            //    name = name.Substring(1, name.Length - 2);
            //}
            //IdentityPropertyType = ConvertUtilities.ChangeType(name, PropertyType.None);
        }

        public PropertyType IdentityPropertyType { get; set; }
        public string CanonicalName { get; set; }
        public string ExpectedType { get; set; }
        public UIType ExpectedUIType { get; set; }
        public bool Nullable { get; set; }
        public bool Mandatory { get; set; }


        public static IEnumerable<TypeProperty> UserProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.UserKey, mandatory: true, nullable:false),
            new TypeProperty("UserName", PropertyType.UserName, "string", mandatory: true, nullable:false),
            new TypeProperty("CreationDateUTC", PropertyType.CreationDate, "datetime", mandatory: false, nullable:false),
            new TypeProperty("Email", PropertyType.Email, "string", UIType.EMail, mandatory: false, nullable:true),
            new TypeProperty("EmailConfirmed", PropertyType.EmailConfirmed, "boolean", mandatory: false, nullable:false),
            new TypeProperty("PhoneNumber",  PropertyType.PhoneNumber, "string", mandatory: false, nullable:true),
            new TypeProperty("PhoneNumberConfirmed", PropertyType.PhoneNumberConfirmed, "boolean", mandatory: false, nullable:false),
            new TypeProperty("Password", PropertyType.Password, "string", UIType.Password, mandatory: false, nullable:true),
            new TypeProperty("LastPasswordChangeDate", PropertyType.LastPasswordChangeDate, "datetime", mandatory: false, nullable:true),
            new TypeProperty("FailedPasswordAttemptCount", PropertyType.FailedPasswordAttemptCount, "int", mandatory: false, nullable:false),
            new TypeProperty("FailedPasswordAttemptWindowStart", PropertyType.FailedPasswordAttemptWindowStart, "datetime", mandatory: false, nullable:true),
            new TypeProperty("LockoutEnabled", PropertyType.LockoutEnabled, "boolean", mandatory: false, nullable:false),
            new TypeProperty("LockoutEndDateUtc", PropertyType.LockoutEndDate, "datetime?", mandatory: false, nullable:true),
            new TypeProperty("LastProfileUpdateDate", PropertyType.LastProfileUpdateDate, "datetime", mandatory: false, nullable:true),
            new TypeProperty("SecurityStamp", PropertyType.SecurityStamp, "string", mandatory: false, nullable:false),
            new TypeProperty("TwoFactorEnabled", PropertyType.TwoFactorEnabled, "boolean", mandatory: false, nullable:false),
            new TypeProperty("Roles", PropertyType.Roles, "RoleCollection", mandatory: false, nullable:true),
            new TypeProperty("Claims", PropertyType.Claims, "UserClaimCollection", mandatory: false, nullable:true),
            new TypeProperty("Logins", PropertyType.Logins, "ExternalLoginCollection", mandatory: false, nullable:true),
        };

        public static IEnumerable<TypeProperty> RoleProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.RoleKey, mandatory: false, nullable:false),
            new TypeProperty("Name", PropertyType.RoleName, "string", mandatory: true, nullable:false),
            new TypeProperty("Users", PropertyType.Users, "UserCollection", mandatory: true, nullable:true),
        };

        public static IEnumerable<TypeProperty> ExternalLoginProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.LoginKey, mandatory: true, nullable:false),
            new TypeProperty("ProviderName", PropertyType.LoginProviderName,"string", mandatory: true, nullable:false),
            new TypeProperty("ProviderKey", PropertyType.LoginProviderKey,"string", mandatory: true, nullable:false),
            new TypeProperty("User", PropertyType.User, "User", mandatory: true, nullable:false),
        };

        public static List<TypeProperty> ClaimsProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.ClaimsKey, mandatory: true, nullable:false),
            new TypeProperty("Type", PropertyType.ClaimsType, "string", mandatory: true, nullable:false),
            new TypeProperty("Value", PropertyType.ClaimsValue, "string", mandatory: true, nullable:true),
            new TypeProperty("ValueType", PropertyType.ClaimsValueType, "string", mandatory: false, nullable:true),
            new TypeProperty("Issuer", PropertyType.ClaimsIssuer, "string", mandatory: false, nullable:true),
            new TypeProperty("OriginalIssuer", PropertyType.ClaimsOriginalIssuer, "string", mandatory: false, nullable:true),
            new TypeProperty("User", PropertyType.User, "User", mandatory: true, nullable:false),
        };

        public static List<TypeProperty> UserRoleProperties = new List<TypeProperty>()
        {
            new TypeProperty("User", PropertyType.User, "User", mandatory: true, nullable:false),
            new TypeProperty("Role", PropertyType.Role, "Role", mandatory: true, nullable:false),
        };
    }
}