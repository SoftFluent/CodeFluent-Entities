using CodeFluent.Runtime;
using SoftFluent.Samples.AspNetIdentity1;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace CodeFluentEntitiesAspNetIdentity.Web
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            try
            {
                // Update Database Schema
                var pivotRunner = new CodeFluent.Runtime.Database.Management.SqlServer.PivotRunner(Server.MapPath("~/SQL Server Pivot Script/SoftFluent.Samples.AspNetIdentity1.pivot.xml"));
                pivotRunner.ConnectionString = CodeFluentContext.Get(Constants.SoftFluent_Samples_AspNetIdentity1StoreName).Persistence.ConnectionString;
                pivotRunner.Run();
            }
            catch
            {

            }

            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}
