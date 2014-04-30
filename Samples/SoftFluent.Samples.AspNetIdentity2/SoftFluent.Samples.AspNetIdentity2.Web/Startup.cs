using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SoftFluent.Samples.AspNetIdentity2.Web.Startup))]
namespace SoftFluent.Samples.AspNetIdentity2.Web
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
