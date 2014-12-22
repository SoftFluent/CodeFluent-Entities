using System.ComponentModel;

namespace SoftFluent.AspNetIdentity
{
    public enum EntityType
    {
        None,
        User,
        Role,
        UserRole,
        UserClaim,
        UserLogin,
        RoleClaim,

        // Compatibility
        // ReSharper disable UnusedMember.Global
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        Claim = UserClaim,
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        Login = UserLogin
    }
}