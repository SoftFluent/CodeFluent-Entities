using System.ComponentModel;

namespace SoftFluent.AspNetIdentity
{
    public enum PropertyType
    {
        None,

        [Description("User - <Key>")]
        UserKey,
        [Description("User - <Name>")]
        UserName,
        [Description("User - NormalizedName")]
        UserNormalizedName,
        [Description("User - CreationDate")]
        UserCreationDate,
        [Description("User - Email")]
        UserEmail,
        [Description("User - EmailConfirmed")]
        UserEmailConfirmed,
        [Description("User - PhoneNumber")]
        UserPhoneNumber,
        [Description("User - PhoneNumberConfirmed")]
        UserPhoneNumberConfirmed,
        [Description("User - Password")]
        UserPassword,
        [Description("User - LastPasswordChangeDate")]
        UserLastPasswordChangeDate,
        [Description("User - FailedPasswordAttemptCount")]
        UserFailedPasswordAttemptCount,
        [Description("User - FailedPasswordAttemptWindowStart")]
        UserFailedPasswordAttemptWindowStart,
        [Description("User - LockoutEnabled")]
        UserLockoutEnabled,
        [Description("User - LockoutEndDate")]
        UserLockoutEndDate,
        [Description("User - LastProfileUpdateDate")]
        UserLastProfileUpdateDate,
        [Description("User - TwoFactorEnabled")]
        UserTwoFactorEnabled,
        [Description("User - SecurityStamp")]
        UserSecurityStamp,
        [Description("User - Roles")]
        UserRoles,
        [Description("User - Claims")]
        UserClaims,
        [Description("User - Logins")]
        UserLogins,

        [Description("Role - <Key>")]
        RoleKey,
        [Description("Role - <Name>")]
        RoleName,
        [Description("Role - Users")]
        RoleUsers,
        [Description("Role - RoleClaims")]
        RoleClaims,

        //[Description("UserRole - Role")]
        //Role,
        //[Description("UserRole - User")]
        //User,
        
        [Description("Login - <Key>")]
        LoginKey,
        [Description("Login - ProviderKey")]
        LoginProviderKey,
        [Description("Login - ProviderName")]
        LoginProviderName,
        [Description("Login - ProviderDisplayName")]
        LoginProviderDisplayName,
        [Description("Login - User")]
        LoginUser,

        [Description("Claims - <Key>")]
        ClaimKey,
        [Description("Claims - Type")]
        ClaimType,
        [Description("Claims - Value")]
        ClaimValue,
        [Description("Claims - ValueType")]
        ClaimValueType,
        [Description("Claims - Issuer")]
        ClaimIssuer,
        [Description("Claims - OriginalIssuer")]
        ClaimOriginalIssuer,
        [Description("Claims - User")]
        ClaimUser,

        [Description("RoleClaim - <Key>")]
        RoleClaimKey,
        [Description("RoleClaim - Role")]
        RoleClaimRole,
        [Description("RoleClaim - ClaimType")]
        RoleClaimClaimType,
        [Description("RoleClaim - ClaimValue")]
        RoleClaimClaimValue,
        [Description("RoleClaim - ClaimValueType")]
        RoleClaimClaimValueType,
        [Description("RoleClaim - ClaimIssuer")]
        RoleClaimClaimIssuer,
        [Description("RoleClaim - ClaimOriginalIssuer")]
        RoleClaimClaimOriginalIssuer
    }
}