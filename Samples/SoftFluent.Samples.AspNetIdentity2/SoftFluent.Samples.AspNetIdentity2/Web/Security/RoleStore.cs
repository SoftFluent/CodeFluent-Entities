namespace SoftFluent.Samples.AspNetIdentity2.Web.Security
{
	public partial class RoleStore : Microsoft.AspNet.Identity.IQueryableRoleStore<SoftFluent.Samples.AspNetIdentity2.Role>, Microsoft.AspNet.Identity.IQueryableRoleStore<SoftFluent.Samples.AspNetIdentity2.Role, System.Guid>, Microsoft.AspNet.Identity.IRoleStore<SoftFluent.Samples.AspNetIdentity2.Role, System.Guid>, Microsoft.AspNet.Identity.IRoleStore<SoftFluent.Samples.AspNetIdentity2.Role>
	{
        public System.Threading.Tasks.Task CreateAsync(SoftFluent.Samples.AspNetIdentity2.Role role)
        {
			if(role == null)
				throw new System.ArgumentNullException("role");

            return System.Threading.Tasks.Task.FromResult(role.Save());
        }

        public System.Threading.Tasks.Task UpdateAsync(SoftFluent.Samples.AspNetIdentity2.Role role)
        {
			if(role == null)
				throw new System.ArgumentNullException("role");

            return System.Threading.Tasks.Task.FromResult(role.Save());
        }

        public System.Threading.Tasks.Task DeleteAsync(SoftFluent.Samples.AspNetIdentity2.Role role)
        {
			if(role == null)
				throw new System.ArgumentNullException("role");

            return System.Threading.Tasks.Task.FromResult(role.Delete());
        }

        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.Role> FindByIdAsync(string roleId)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.Role.LoadByEntityKey(roleId));
        }
		
        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.Role> FindByIdAsync(System.Guid roleId)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.Role.Load(roleId));
        }
		
        public System.Threading.Tasks.Task<SoftFluent.Samples.AspNetIdentity2.Role> FindByNameAsync(string roleName)
        {
            return System.Threading.Tasks.Task.FromResult(SoftFluent.Samples.AspNetIdentity2.Role.LoadByName(roleName));
        }

		
		public System.Linq.IQueryable<SoftFluent.Samples.AspNetIdentity2.Role> Roles 
		{ 
			get
			{
				return System.Linq.Queryable.AsQueryable(SoftFluent.Samples.AspNetIdentity2.RoleCollection.LoadAll());
			}
		}
		
		
        public void Dispose()
        {
        }
	}
}