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
            Syncfusion.Licensing.SyncfusionLicenseProvider.RegisterLicense("MjA1MTc0QDMxMzcyZTM0MmUzMEtiNXNYTC8rNGdzeDE3dm5uRUxPUElwRXExTTRCcWQzL2ZxV1ZENnEvcWc9");
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
        }
    }
}