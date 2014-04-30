using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CodeFluentEntitiesAspNetIdentity.Web.Startup))]
namespace CodeFluentEntitiesAspNetIdentity.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
