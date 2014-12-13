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
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        Claim = UserClaim,
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        Login = UserLogin
    }
}