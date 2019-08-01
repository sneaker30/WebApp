using System;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;

namespace parti.admin
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            ////Register Syncfusion license
            Syncfusion.Licensing.SyncfusionLicenseProvider.RegisterLicense("NzI4NTNAMzEzNjJlMzQyZTMwbFJKamNiSFhSdDB3dG11MjRTemlwN0xSU1ZRaStxeVgwZ0J4WG55emxhST0=");
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}