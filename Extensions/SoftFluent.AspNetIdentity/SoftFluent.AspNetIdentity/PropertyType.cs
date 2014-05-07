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
        [Description("User - CreationDate")]
        CreationDate,
        [Description("User - Email")]
        Email,
        [Description("User - EmailConfirmed")]
        EmailConfirmed,
        [Description("User - PhoneNumber")]
        PhoneNumber,
        [Description("User - PhoneNumberConfirmed")]
        PhoneNumberConfirmed,
        [Description("User - Password")]
        Password,
        [Description("User - LastPasswordChangeDate")]
        LastPasswordChangeDate,
        [Description("User - FailedPasswordAttemptCount")]
        FailedPasswordAttemptCount,
        [Description("User - FailedPasswordAttemptWindowStart")]
        FailedPasswordAttemptWindowStart,
        [Description("User - LockoutEnabled")]
        LockoutEnabled,
        [Description("User - LockoutEndDate")]
        LockoutEndDate,
        [Description("User - LastProfileUpdateDate")]
        LastProfileUpdateDate,
        [Description("User - TwoFactorEnabled")]
        TwoFactorEnabled,
        [Description("User - SecurityStamp")]
        SecurityStamp,
        [Description("User - Roles")]
        Roles,
        [Description("User - Claims")]
        Claims,
        [Description("User - Logins")]
        Logins,

        [Description("Role - <Key>")]
        RoleKey,
        [Description("Role - <Name>")]
        RoleName,
        [Description("Role - Users")]
        Users,

        [Description("UserRole - Role")]
        Role,
        [Description("UserRole - User")]
        User,



        [Description("Login - <Key>")]
        LoginKey,
        [Description("Login - ProviderKey")]
        LoginProviderKey,
        [Description("Login - ProviderName")]
        LoginProviderName,

        [Description("Claims - <Key>")]
        ClaimsKey,
        [Description("Claims - Type")]
        ClaimsType,
        [Description("Claims - Value")]
        ClaimsValue,
        [Description("Claims - ValueType")]
        ClaimsValueType,
        [Description("Claims - Issuer")]
        ClaimsIssuer,
        [Description("Claims - OriginalIssuer")]
        ClaimsOriginalIssuer,

    }
}