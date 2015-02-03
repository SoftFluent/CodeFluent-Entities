using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;

namespace SoftFluent.Samples.AngularJs.App_Start
{
    public class BundleConfig
    {
        // For more information on bundling, visit http://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js",
                      "~/Scripts/bootstrap-datepicker.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css",
                      "~/Content/datepicker3.css",
                      "~/Content/angular-toastr.css"));

            bundles.Add(new ScriptBundle("~/bundles/AngularJs").Include(
                      "~/Scripts/angular.js",
                      "~/Scripts/angular-route.js",
                      "~/Scripts/angular-animate.js",
                      "~/Scripts/angular-messages.js",
                      "~/Scripts/angular-toastr.js",
                      "~/Scripts/App/app.js",
                      "~/Scripts/App/Factory/DataFactory.js",
                      "~/Scripts/App/Controller/CartController.js",
                      "~/Scripts/App/Controller/CustomerController.js",
                      "~/Scripts/App/Controller/ProductDetailController.js",
                      "~/Scripts/App/Controller/OrderController.js",
                      "~/Scripts/App/Controller/ProductController.js"
                      ));
        }
    }
}