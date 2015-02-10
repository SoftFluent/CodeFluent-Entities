This producer allows to generate an ASP.NET Identity implementation. It will help you in creating identity entities and generating `UserStore` and `RoleStore`

## Supported ASP.NET Identity interfaces:
- `Microsoft.AspNet.Identity.IUser`
- `Microsoft.AspNet.Identity.IUser<TKey>`
- `Microsoft.AspNet.Identity.IRole`
- `Microsoft.AspNet.Identity.IRole<TKey>`
- `Microsoft.AspNet.Identity.IUserStore<TUser>`
- `Microsoft.AspNet.Identity.IUserStore<TUser, TKey>`
- `Microsoft.AspNet.Identity.IUserPasswordStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserPasswordStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserSecurityStampStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserSecurityStampStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserRoleStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserRoleStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserLoginStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserLoginStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserLockoutStore<TUser, string>,`
- `Microsoft.AspNet.Identity.IUserLockoutStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserClaimStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserClaimStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserEmailStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserEmailStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserPhoneNumberStore<TUser>,`
- `Microsoft.AspNet.Identity.IUserPhoneNumberStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IUserTwoFactorStore<TUser, string>,`
- `Microsoft.AspNet.Identity.IUserTwoFactorStore<TUser, TKey>,`
- `Microsoft.AspNet.Identity.IRoleStore<TRole>,`
- `Microsoft.AspNet.Identity.IRoleStore<TRole, TKey>,`
- `Microsoft.AspNet.Identity.IQueryableRoleStore<TRole>`
- `Microsoft.AspNet.Identity.IQueryableRoleStore<TRole, TKey>`
- `Microsoft.AspNet.Identity.IQueryableUserStore<TRole>`
- `Microsoft.AspNet.Identity.IQueryableUserStore<TRole, TKey>`

*Note: While CodeFluent Entities does not provide an `IQueryable` data source such as some ORM, stores can implement `IQueryableRoleStore` and `IQueryableUserStore`. The implementation is very limited and simply calls `LoadAll` method.*

## How to install
1. Copy "SoftFluent.AspNetIdentity.dll" to "C:\Program Files (x86)\SoftFluent\CodeFluent\Modeler"
2. Integration in the graphical Modeler - Copy (or Merge) "custom.config" to "%APPDATA%\CodeFluent.Modeler.Design"

## How to use it:
1. Create a CodeFluent Entities project
2. Add a CodeDom producer
3. Add this new producer (Security -> Asp.Net Identity). Note: The target path has no effect. The target path will be "Target Path of the BOM Producer\Web\Security\(User|Role)Store"
4. Right click on the producer and click the "Create Identity Entities" menu item
5. Select necessary entities (User, Role, Claim, Login) and the destination namespace
6. Customize entities. For example you can remove "Password" property if you don't need it
7. Generate and use the code :)

*Note: you must add the "[Microsoft.AspNet.Identity.Core](https://www.nuget.org/packages/Microsoft.AspNet.Identity.Core)" nuget package before compiling the generated code (but this is obvious)*
