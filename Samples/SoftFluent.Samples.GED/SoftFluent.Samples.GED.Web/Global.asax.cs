using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace SoftFluent.Samples.GED.Web
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();
            
            LaunchProcessDelegate d = new LaunchProcessDelegate(LaunchProcess);
            d.BeginInvoke(null, null);
        }

        public delegate void LaunchProcessDelegate();
        public void LaunchProcess()
        {
            SoftFluent.Samples.GED.Utility.OCR.Process.ProcessQueue(System.Web.Hosting.HostingEnvironment.MapPath("~/App_Data"));

            System.Threading.Thread.Sleep(30 * 1000);
            LaunchProcess();
        }
    }
}