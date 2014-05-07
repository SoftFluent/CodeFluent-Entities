namespace SoftFluent.AspNetIdentity
{
    public enum MethodType
    {
        None,
        LoadUserByKey,
        LoadUserByUserName,
        LoadUserByEmail,
        LoadUserByPhoneNumber,
        LoadRoleByKey,
        LoadRoleByName,
        LoadUserByProviderKey,
        DeleteClaim,
        DeleteLogin,
        LoadAll
    }
}