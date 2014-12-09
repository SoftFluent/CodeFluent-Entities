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
        LoadUserClaims,
        DeleteUserClaims,
        DeleteLoginByUserLoginInfo,
        LoadAllRoles,
        LoadClaimsByRole,
        LoadAllUsers
    }
}