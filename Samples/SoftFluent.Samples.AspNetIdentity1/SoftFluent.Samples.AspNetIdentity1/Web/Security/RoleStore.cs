using System.Threading.Tasks;
using Microsoft.AspNet.Identity;

namespace SoftFluent.Samples.AspNetIdentity1.Web.Security
{
    public class RoleStore : IRoleStore<Role>
    {
        public Task CreateAsync(Role role)
        {
            return Task.Run(() => role.Save());
        }

        public Task UpdateAsync(Role role)
        {
            return Task.Run(() => role.Save());
        }

        public Task DeleteAsync(Role role)
        {
            return Task.Run(() => role.Delete());
        }

        public Task<Role> FindByIdAsync(string roleId)
        {
            return Task.Run(() => Role.LoadByEntityKey(roleId));
        }

        public Task<Role> FindByNameAsync(string roleName)
        {
            return Task.Run(() => Role.LoadByName(roleName));
        }

        public void Dispose()
        {
            // Nothing to do here
        }

    }
}