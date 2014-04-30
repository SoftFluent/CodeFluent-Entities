namespace SoftFluent.Samples.AspNetIdentity2.Web.Security
{
    public partial class UserStore : 
        Microsoft.AspNet.Identity.IUserStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IQueryableUserStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserPasswordStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserSecurityStampStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserRoleStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserLoginStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserLockoutStore<SoftFluent.Samples.AspNetIdentity2.User, string>,
        Microsoft.AspNet.Identity.IUserClaimStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserEmailStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserPhoneNumberStore<SoftFluent.Samples.AspNetIdentity2.User>,
        Microsoft.AspNet.Identity.IUserTwoFactorStore<SoftFluent.Samples.AspNetIdentity2.User, string>,
        Microsoft.AspNet.Identity.IUserStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IQueryableUserStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserPasswordStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserSecurityStampStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserRoleStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserLoginStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserLockoutStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserClaimStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserEmailStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserPhoneNumberStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>,
        Microsoft.AspNet.Identity.IUserTwoFactorStore<SoftFluent.Samples.AspNetIdentity2.User, System.Guid>
    {
    
        public System.Threading.Tasks.Task CreateAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            if (user == null) 
                throw new System.ArgumentNullException("user");
            
			if(user.CreationDateUTC == CodeFluent.Runtime.CodeFluentPersistence.DefaultDateTimeValue)
			{
				user.CreationDateUTC = System.DateTime.UtcNow;
			}
			
            return System.Threading.Tasks.Task.FromResult(user.Save());
        }

        public System.Threading.Tasks.Task UpdateAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            if (user == null) 
                throw new System.ArgumentNullException("user");

            return System.Threading.Tasks.Task.FromResult(user.Save());
        }

        public System.Threading.Tasks.Task DeleteAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            if (user == null) 
            throw new System.ArgumentNullException("user");

            return System.Threading.Tasks.Task.FromResult(user.Delete());
        }

        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.User> FindByIdAsync(string userId)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.User.LoadByEntityKey(userId));
        }
        
        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.User> FindByIdAsync(System.Guid userId)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.User.Load(userId));
        }
        
        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.User> FindByNameAsync(string userName)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.User.LoadByUserName(userName));
        }



        public System.Threading.Tasks.Task SetPasswordHashAsync(SoftFluent.Samples.AspNetIdentity2.User user, string passwordHash)
        {
            user.Password = passwordHash;
            user.LastPasswordChangeDate = System.DateTime.UtcNow;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<string> GetPasswordHashAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.Password);
        }

        public System.Threading.Tasks.Task<bool> HasPasswordAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.Password != null);
        }



        public System.Threading.Tasks.Task SetSecurityStampAsync(SoftFluent.Samples.AspNetIdentity2.User user, string stamp)
        {
            user.LastProfileUpdateDate = System.DateTime.UtcNow;
            user.SecurityStamp = stamp;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<string> GetSecurityStampAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.SecurityStamp);
        }
        


        public System.Threading.Tasks.Task<System.DateTimeOffset> GetLockoutEndDateAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            
            return System.Threading.Tasks.Task.FromResult(user.LockoutEndDateUtc.HasValue ? new System.DateTimeOffset(System.DateTime.SpecifyKind(user.LockoutEndDateUtc.Value, System.DateTimeKind.Utc)) : new System.DateTimeOffset());
            
        }

        public System.Threading.Tasks.Task SetLockoutEndDateAsync(SoftFluent.Samples.AspNetIdentity2.User user, System.DateTimeOffset lockoutEnd)
        {
            if (lockoutEnd == System.DateTimeOffset.MinValue)
            {
                
                user.LockoutEndDateUtc = null;
                
                
            }
            else
            {
                user.LockoutEndDateUtc = lockoutEnd.UtcDateTime;
            }

            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<int> IncrementAccessFailedCountAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            
            if(user.FailedPasswordAttemptCount <= 0)
            {
                user.FailedPasswordAttemptWindowStart = System.DateTime.UtcNow;
            }
            

            return System.Threading.Tasks.Task.FromResult(++user.FailedPasswordAttemptCount);
        }

        public System.Threading.Tasks.Task ResetAccessFailedCountAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            user.FailedPasswordAttemptCount = 0;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<int> GetAccessFailedCountAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.FailedPasswordAttemptCount);
        }

        public System.Threading.Tasks.Task<bool> GetLockoutEnabledAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.LockoutEnabled);
        }

        public System.Threading.Tasks.Task SetLockoutEnabledAsync(SoftFluent.Samples.AspNetIdentity2.User user, bool enabled)
        {
            user.LockoutEnabled = true;
            return System.Threading.Tasks.Task.FromResult(0);
        }



        public System.Threading.Tasks.Task SetEmailAsync(SoftFluent.Samples.AspNetIdentity2.User user, string email)
        {
            user.Email = email;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<string> GetEmailAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.Email);
        }

        public System.Threading.Tasks.Task<bool> GetEmailConfirmedAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            
            return System.Threading.Tasks.Task.FromResult(user.EmailConfirmed);
            
        }

        public System.Threading.Tasks.Task SetEmailConfirmedAsync(SoftFluent.Samples.AspNetIdentity2.User user, bool confirmed)
        {
            
            user.EmailConfirmed = confirmed;
            
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.User> FindByEmailAsync(string email)
        {
            
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.User.LoadByEmail(email));
            
        }



        public System.Threading.Tasks.Task SetPhoneNumberAsync(SoftFluent.Samples.AspNetIdentity2.User user, string phoneNumber)
        {
            user.PhoneNumber = phoneNumber;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<string> GetPhoneNumberAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.PhoneNumber);
        }

        public System.Threading.Tasks.Task<bool> GetPhoneNumberConfirmedAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            
            return System.Threading.Tasks.Task.FromResult(user.PhoneNumberConfirmed);
            
        }

        public System.Threading.Tasks.Task SetPhoneNumberConfirmedAsync(SoftFluent.Samples.AspNetIdentity2.User user, bool confirmed)
        {
            
            user.PhoneNumberConfirmed = confirmed;
            
            return System.Threading.Tasks.Task.FromResult(0);
        }



        public System.Threading.Tasks.Task SetTwoFactorEnabledAsync(SoftFluent.Samples.AspNetIdentity2.User user, bool enabled)
        {
            user.TwoFactorEnabled = enabled;
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<bool> GetTwoFactorEnabledAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            return System.Threading.Tasks.Task.FromResult(user.TwoFactorEnabled);
        }




        public System.Threading.Tasks.Task AddToRoleAsync(SoftFluent.Samples.AspNetIdentity2.User user, string roleName)
        {
            SoftFluent.Samples.AspNetIdentity2.Role role = SoftFluent.Samples.AspNetIdentity2.Role.LoadByName(roleName);
            if (role == null)
                throw new System.ArgumentException(string.Format("role '{0}' not found", roleName), "roleName");

            role.Users.Add(user);
            role.Save();
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task RemoveFromRoleAsync(SoftFluent.Samples.AspNetIdentity2.User user, string roleName)
        {
            SoftFluent.Samples.AspNetIdentity2.Role role = SoftFluent.Samples.AspNetIdentity2.Role.LoadByName(roleName);
            if (role == null)
                throw new System.ArgumentException(string.Format("role '{0}' not found", roleName), "roleName");

            if (role.Users.Remove(user))
            {
                role.Save();
            }

            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task<System.Collections.Generic.IList<string>> GetRolesAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            System.Collections.Generic.IList<string> result = new System.Collections.Generic.List<string>();
            foreach (Microsoft.AspNet.Identity.IRole role in user.Roles)
            {
                result.Add(role.Name);
            }

            return System.Threading.Tasks.Task.FromResult(result);
        }

        public System.Threading.Tasks.Task<bool> IsInRoleAsync(SoftFluent.Samples.AspNetIdentity2.User user, string roleName)
        {
            SoftFluent.Samples.AspNetIdentity2.Role role = SoftFluent.Samples.AspNetIdentity2.Role.LoadByName(roleName);
            if (role == null)
                throw new System.ArgumentException(string.Format("role '{0}' not found", roleName), "roleName");

            return System.Threading.Tasks.Task.FromResult(user.Roles.Contains(role));
        }



        public System.Threading.Tasks.Task AddLoginAsync(SoftFluent.Samples.AspNetIdentity2.User user, Microsoft.AspNet.Identity.UserLoginInfo userLoginInfo)
        {
            SoftFluent.Samples.AspNetIdentity2.Login login = new SoftFluent.Samples.AspNetIdentity2.Login();
            login.User = user;
            login.ProviderKey = userLoginInfo.ProviderKey;
            
            login.ProviderName = userLoginInfo.LoginProvider;
            
            login.Save();
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task RemoveLoginAsync(SoftFluent.Samples.AspNetIdentity2.User user, Microsoft.AspNet.Identity.UserLoginInfo userLoginInfo)
        {
            
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.LoginCollection.DeleteByUserAndProviderKey(user, userLoginInfo.ProviderKey));
            
        }

        public System.Threading.Tasks.Task<System.Collections.Generic.IList<Microsoft.AspNet.Identity.UserLoginInfo>> GetLoginsAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            System.Collections.Generic.IList<Microsoft.AspNet.Identity.UserLoginInfo> result = new System.Collections.Generic.List<Microsoft.AspNet.Identity.UserLoginInfo>();
            SoftFluent.Samples.AspNetIdentity2.LoginCollection userLogins = user.Logins;
            foreach(SoftFluent.Samples.AspNetIdentity2.Login userLogin in userLogins)
            {
                
                Microsoft.AspNet.Identity.UserLoginInfo userLoginInfo = new Microsoft.AspNet.Identity.UserLoginInfo(userLogin.ProviderName, userLogin.ProviderKey);
                
                result.Add(userLoginInfo);
            }
            
            return System.Threading.Tasks.Task.FromResult(result);
        }

        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.User> FindAsync(Microsoft.AspNet.Identity.UserLoginInfo login)
        {
            
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.User.LoadByProviderKey(login.ProviderKey));
            
            
        }



        public System.Threading.Tasks.Task<System.Collections.Generic.IList<System.Security.Claims.Claim>> GetClaimsAsync(SoftFluent.Samples.AspNetIdentity2.User user)
        {
            System.Collections.Generic.IList<System.Security.Claims.Claim> result = new System.Collections.Generic.List<System.Security.Claims.Claim>();
            SoftFluent.Samples.AspNetIdentity2.UserClaimCollection userClaims = user.Claims;
            foreach(SoftFluent.Samples.AspNetIdentity2.UserClaim userClaim in userClaims)
            {
                System.Security.Claims.Claim claim = new System.Security.Claims.Claim(userClaim.Type, userClaim.Value, userClaim.ValueType, userClaim.Issuer, userClaim.OriginalIssuer);
                result.Add(claim);
            }
            
            return System.Threading.Tasks.Task.FromResult(result);
        }

        public System.Threading.Tasks.Task AddClaimAsync(SoftFluent.Samples.AspNetIdentity2.User user, System.Security.Claims.Claim claim)
        {
            SoftFluent.Samples.AspNetIdentity2.UserClaim userClaim = new SoftFluent.Samples.AspNetIdentity2.UserClaim();
            userClaim.User = user;
            userClaim.Type = claim.Type;
            userClaim.Value = claim.Value;
            
            userClaim.Issuer = claim.Issuer;
            
            userClaim.OriginalIssuer = claim.OriginalIssuer;
            
            userClaim.ValueType = claim.ValueType;
            
            
            userClaim.Save();
            return System.Threading.Tasks.Task.FromResult(0);
        }

        public System.Threading.Tasks.Task RemoveClaimAsync(SoftFluent.Samples.AspNetIdentity2.User user, System.Security.Claims.Claim claim)
        {
            SoftFluent.Samples.AspNetIdentity2.UserClaimCollection.DeleteByTypeAndValue(claim.Type, claim.Value);
            return System.Threading.Tasks.Task.FromResult(0);
        }


		
		public System.Linq.IQueryable<SoftFluent.Samples.AspNetIdentity2.User> Users 
		{ 
			get
			{
				return System.Linq.Queryable.AsQueryable(SoftFluent.Samples.AspNetIdentity2.UserCollection.LoadAll());
			}
		}
		
		
        public virtual void Dispose()
        {
        }
    }
}