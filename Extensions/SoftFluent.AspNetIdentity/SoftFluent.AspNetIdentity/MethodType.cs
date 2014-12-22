using System.ComponentModel;

namespace SoftFluent.AspNetIdentity
{
    public enum MethodType
    {
        None,
        LoadUserByKey,
        LoadUserByUserName,
        LoadUserByEmail,
        LoadUserByUserLoginInfo,
        LoadRoleByKey,
        LoadRoleByName,
        LoadUserClaimsByClaim,
        DeleteUserClaimsByClaim,
        DeleteUserLoginByUserLoginInfo,
        LoadAllRoles,
        LoadRoleClaimsByRole,
        LoadAllUsers,

        // Compatibility
        // ReSharper disable UnusedMember.Global
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        LoadUserClaims = LoadUserClaimsByClaim,
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        DeleteUserClaims = DeleteUserClaimsByClaim,
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        DeleteLoginByUserLoginInfo = DeleteUserLoginByUserLoginInfo,
        [Browsable(false), EditorBrowsable(EditorBrowsableState.Never)]
        LoadClaimsByRole = LoadRoleClaimsByRole,
    }
}