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

        [Description("UserLogin - <Key>")]
        UserLoginKey,
        [Description("UserLogin - ProviderKey")]
        UserLoginProviderKey,
        [Description("UserLogin - ProviderName")]
        UserLoginProviderName,
        [Description("UserLogin - ProviderDisplayName")]
        UserLoginProviderDisplayName,
        [Description("UserLogin - User")]
        UserLoginUser,

        [Description("UserClaim - <Key>")]
        UserClaimKey,
        [Description("UserClaim - Type")]
        UserClaimType,
        [Description("UserClaim - Value")]
        UserClaimValue,
        [Description("UserClaim - ValueType")]
        UserClaimValueType,
        [Description("UserClaim - Issuer")]
        UserClaimIssuer,
        [Description("UserClaim - OriginalIssuer")]
        UserClaimOriginalIssuer,
        [Description("UserClaim - User")]
        UserClaimUser,

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

    internal enum PropertyTypeCompatibility
    {
        None,

        UserKey = PropertyType.UserKey,
        UserName = PropertyType.UserName,
        CreationDate = PropertyType.UserCreationDate,
        Email = PropertyType.UserEmail,
        EmailConfirmed = PropertyType.UserEmailConfirmed,
        PhoneNumber = PropertyType.UserPhoneNumber,
        PhoneNumberConfirmed = PropertyType.UserPhoneNumberConfirmed,
        Password = PropertyType.UserPassword,
        LastPasswordChangeDate = PropertyType.UserLastPasswordChangeDate,
        FailedPasswordAttemptCount = PropertyType.UserFailedPasswordAttemptCount,
        FailedPasswordAttemptWindowStart = PropertyType.UserFailedPasswordAttemptWindowStart,
        LockoutEnabled = PropertyType.UserLockoutEnabled,
        LockoutEndDate = PropertyType.UserLockoutEndDate,
        LastProfileUpdateDate = PropertyType.UserLastProfileUpdateDate,
        TwoFactorEnabled = PropertyType.UserTwoFactorEnabled,
        SecurityStamp = PropertyType.UserSecurityStamp,
        Roles = PropertyType.UserRoles,
        Claims = PropertyType.UserClaims,
        Logins = PropertyType.UserLogins,

        RoleKey = PropertyType.RoleKey,
        RoleName = PropertyType.RoleName,
        Users,

        Role,
        User,

        LoginKey = PropertyType.UserLoginKey,
        LoginProviderKey = PropertyType.UserLoginProviderKey,
        LoginProviderName = PropertyType.UserLoginProviderName,

        ClaimsKey = PropertyType.UserClaimKey,
        ClaimsType = PropertyType.UserClaimType,
        ClaimsValue = PropertyType.UserClaimValue,
        ClaimsValueType = PropertyType.UserClaimValueType,
        ClaimsIssuer = PropertyType.UserClaimIssuer,
        ClaimsOriginalIssuer = PropertyType.UserClaimOriginalIssuer,
    }
}