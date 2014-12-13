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


        public static readonly IEnumerable<TypeProperty> UserProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.UserKey, mandatory: true, nullable:false),
            new TypeProperty("UserName", PropertyType.UserName, "string", mandatory: true, nullable:false),
            new TypeProperty("CreationDateUTC", PropertyType.UserCreationDate, "datetime", mandatory: false, nullable:false),
            new TypeProperty("Email", PropertyType.UserEmail, "string", UIType.EMail, mandatory: false, nullable:true),
            new TypeProperty("EmailConfirmed", PropertyType.UserEmailConfirmed, "boolean", mandatory: false, nullable:false),
            new TypeProperty("PhoneNumber",  PropertyType.UserPhoneNumber, "string", mandatory: false, nullable:true),
            new TypeProperty("PhoneNumberConfirmed", PropertyType.UserPhoneNumberConfirmed, "boolean", mandatory: false, nullable:false),
            new TypeProperty("Password", PropertyType.UserPassword, "string", UIType.Password, mandatory: false, nullable:true),
            new TypeProperty("LastPasswordChangeDate", PropertyType.UserLastPasswordChangeDate, "datetime", mandatory: false, nullable:true),
            new TypeProperty("FailedPasswordAttemptCount", PropertyType.UserFailedPasswordAttemptCount, "int", mandatory: false, nullable:false),
            new TypeProperty("FailedPasswordAttemptWindowStart", PropertyType.UserFailedPasswordAttemptWindowStart, "datetime", mandatory: false, nullable:true),
            new TypeProperty("LockoutEnabled", PropertyType.UserLockoutEnabled, "boolean", mandatory: false, nullable:false),
            new TypeProperty("LockoutEndDateUtc", PropertyType.UserLockoutEndDate, "datetime?", mandatory: false, nullable:true),
            new TypeProperty("LastProfileUpdateDate", PropertyType.UserLastProfileUpdateDate, "datetime", mandatory: false, nullable:true),
            new TypeProperty("SecurityStamp", PropertyType.UserSecurityStamp, "string", mandatory: false, nullable:false),
            new TypeProperty("TwoFactorEnabled", PropertyType.UserTwoFactorEnabled, "boolean", mandatory: false, nullable:false),
            new TypeProperty("Roles", PropertyType.UserRoles, "RoleCollection", mandatory: false, nullable:true),
            new TypeProperty("Claims", PropertyType.UserClaims, "UserClaimCollection", mandatory: false, nullable:true),
            new TypeProperty("Logins", PropertyType.UserLogins, "UserLoginCollection", mandatory: false, nullable:true),
        };

        public static readonly IEnumerable<TypeProperty> RoleProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.RoleKey, mandatory: false, nullable:false),
            new TypeProperty("Name", PropertyType.RoleName, "string", mandatory: true, nullable:false),
            new TypeProperty("Users", PropertyType.RoleUsers, "UserCollection", mandatory: true, nullable:true),
            new TypeProperty("Claims", PropertyType.RoleClaims, "RoleClaimCollection", mandatory: false, nullable:true),
        };

        public static readonly IEnumerable<TypeProperty> UserLoginProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.UserLoginKey, mandatory: true, nullable:false),
            new TypeProperty("ProviderName", PropertyType.UserLoginProviderName, "string", mandatory: true, nullable:false),
            new TypeProperty("ProviderKey", PropertyType.UserLoginProviderKey, "string", mandatory: true, nullable:false),
            new TypeProperty("ProviderDisplayName", PropertyType.UserLoginProviderDisplayName, "string", mandatory: false, nullable:false),
            new TypeProperty("User", PropertyType.UserLoginUser, "User", mandatory: true, nullable:false),
        };

        public static readonly List<TypeProperty> ClaimsProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.UserClaimKey, mandatory: true, nullable:false),
            new TypeProperty("Type", PropertyType.UserClaimType, "string", mandatory: true, nullable:false),
            new TypeProperty("Value", PropertyType.UserClaimValue, "string", mandatory: true, nullable:true),
            new TypeProperty("ValueType", PropertyType.UserClaimValueType, "string", mandatory: false, nullable:true),
            new TypeProperty("Issuer", PropertyType.UserClaimIssuer, "string", mandatory: false, nullable:true),
            new TypeProperty("OriginalIssuer", PropertyType.UserClaimOriginalIssuer, "string", mandatory: false, nullable:true),
            new TypeProperty("User", PropertyType.UserClaimUser, "User", mandatory: true, nullable:false),
        };

        //public static List<TypeProperty> UserRoleProperties = new List<TypeProperty>()
        //{
        //    new TypeProperty("User", PropertyType.User, "User", mandatory: true, nullable:false),
        //    new TypeProperty("Role", PropertyType.Role, "Role", mandatory: true, nullable:false),
        //};

        public static readonly List<TypeProperty> RoleClaimProperties = new List<TypeProperty>()
        {
            new TypeProperty("Id", PropertyType.RoleClaimKey, mandatory: true, nullable:false),
            new TypeProperty("Type", PropertyType.RoleClaimClaimType, "string", mandatory: true, nullable:false),
            new TypeProperty("Value", PropertyType.RoleClaimClaimValue, "string", mandatory: true, nullable:true),
            new TypeProperty("ValueType", PropertyType.RoleClaimClaimValueType, "string", mandatory: false, nullable:true),
            new TypeProperty("Role", PropertyType.RoleClaimRole, "Role", mandatory: true, nullable:false),
        };
    }
}