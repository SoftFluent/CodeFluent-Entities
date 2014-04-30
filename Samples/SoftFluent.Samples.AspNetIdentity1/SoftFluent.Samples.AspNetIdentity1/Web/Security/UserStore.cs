using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;

namespace SoftFluent.Samples.AspNetIdentity1.Web.Security
{
    public class UserStore :
        IUserStore<User>,
        IUserPasswordStore<User>,
        IUserSecurityStampStore<User>,
        IUserRoleStore<User>,
        IUserLoginStore<User>,
        IUserClaimStore<User>
    {

        public Task CreateAsync(User user)
        {
            if (user == null) throw new ArgumentNullException("user");
            return Task.Run(() => user.Save());
        }

        public Task UpdateAsync(User user)
        {
            if (user == null) throw new ArgumentNullException("user");
            return Task.Run(() => user.Save());
        }

        public Task DeleteAsync(User user)
        {
            if (user == null) throw new ArgumentNullException("user");
            return Task.Run(() => user.Delete());
        }

        public Task<User> FindByIdAsync(string userId)
        {
            return Task.Run(() => User.LoadByEntityKey(userId));
        }

        public Task<User> FindByNameAsync(string userName)
        {
            return Task.Run(() => User.LoadByUserName(userName));
        }

        public Task SetPasswordHashAsync(User user, string passwordHash)
        {
            user.Password = passwordHash;
            return Task.FromResult(0);
        }

        public Task<string> GetPasswordHashAsync(User user)
        {
            return Task.FromResult(user.Password);
        }

        public Task<bool> HasPasswordAsync(User user)
        {
            return Task.FromResult(user.Password != null);
        }

        public Task SetSecurityStampAsync(User user, string stamp)
        {
            user.SecurityStamp = stamp;
            return Task.FromResult(0);
        }

        public Task<string> GetSecurityStampAsync(User user)
        {
            return Task.FromResult(user.SecurityStamp);
        }

        public Task AddToRoleAsync(User user, string roleName)
        {
            return Task.Run(() =>
            {
                Role role = Role.LoadByName(roleName);
                if (role == null)
                    throw new Exception(string.Format("role '{0}' not found", roleName));

                role.Users.Add(user);
                role.Save();
            });
        }

        public Task RemoveFromRoleAsync(User user, string roleName)
        {
            return Task.Run(() =>
            {
                Role role = Role.LoadByName(roleName);
                if (role == null)
                    throw new Exception(string.Format("role '{0}' not found", roleName));

                if (role.Users.Remove(user))
                {
                    role.Save();
                }
            });
        }

        public Task<IList<string>> GetRolesAsync(User user)
        {
            return Task.Run(() => (IList<string>)user.Roles.Cast<IRole>().Select(role => role.Name).ToList());
        }

        public Task<bool> IsInRoleAsync(User user, string roleName)
        {
            return Task.Run(() =>
            {
                Role role = Role.LoadByName(roleName);
                if (role == null)
                    throw new Exception(string.Format("Role '{0}' not found.", roleName));

                return user.Roles.Contains(role);
            });
        }

        public Task AddLoginAsync(User user, UserLoginInfo login)
        {
            return Task.Run(() =>
            {
                var externalLogin = new ExternalLogin();
                externalLogin.ProviderKey = login.ProviderKey;
                externalLogin.ProviderName = login.LoginProvider;
                externalLogin.User = user;
                externalLogin.Save();
            });
        }

        public Task RemoveLoginAsync(User user, UserLoginInfo login)
        {
            return Task.Run(() =>
            {
                var externalLogin = ExternalLogin.LoadByProviderKey(login.ProviderKey);
                if (externalLogin != null)
                {
                    externalLogin.Delete();
                }
            });
        }

        public Task<IList<UserLoginInfo>> GetLoginsAsync(User user)
        {

            return Task.Run(() => (IList<UserLoginInfo>)user.ExternalLogins.Select(externalLogin => new UserLoginInfo(externalLogin.ProviderName, externalLogin.ProviderKey)).ToList());

        }

        public Task<User> FindAsync(UserLoginInfo login)
        {
            return Task.Run(() => User.LoadByProviderKey(login.ProviderKey));
        }

        public Task<IList<Claim>> GetClaimsAsync(User user)
        {
            return Task.Run(() => (IList<Claim>)user.Claims.Select(claim => new Claim(claim.Type, claim.Value)).ToList());
        }

        public Task AddClaimAsync(User user, Claim claim)
        {
            return Task.Run(() =>
            {
                UserClaim uc = new UserClaim();
                uc.Type = claim.Type;
                uc.Value = claim.Value;
                uc.User = user;
                uc.Save();
            });
        }

        public Task RemoveClaimAsync(User user, Claim claim)
        {
            return Task.Run(() => { UserClaimCollection.DeleteByTypeAndValue(user, claim.Type, claim.Value); });
        }

        public void Dispose()
        {
            // Nothing to do here
        }
    }
}
