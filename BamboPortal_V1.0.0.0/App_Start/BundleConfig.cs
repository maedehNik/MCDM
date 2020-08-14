using System.Configuration;
using System.Web;
using System.Web.Optimization;

namespace BamboPortal_V1._0._0._0
{

    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {
            //Bundles {Start} : StockpileProductPage
            bundles.Add(new ScriptBundle("~/bundles/StockpileProductPage.js").Include(
                "~/AdminDesignResource/vendors/bootstrap-clockpicker.js",
              "~/AdminDesignResource/vendors/persianDatepicker.js"));

            bundles.Add(new StyleBundle("~/Content/StockpileProductPage.css").Include(
                      "~/AdminDesignResource/vendors/bootstrap-clockpicker.css",
                      "~/AdminDesignResource/vendors/persianDatepicker-default.css"));
            //Bundles {End} : StockpileProductPage

            //Bundles {Start} : Global Theme Bundle
            bundles.Add(new ScriptBundle("~/bundles/MetronicGlobalThemeBundle.js").Include(
                "~/AdminDesignResource/vendors/jquery.min.js",
              "~/AdminDesignResource/vendors/base/vendors.bundle.js",
              "~/AdminDesignResource/demo/default/base/scripts.bundle.js"));

            bundles.Add(new StyleBundle("~/Content/MetronicGlobalThemeBundle.css").Include(
                      "~/AdminDesignResource/vendors/base/vendors.bundle.rtl.css",
                      "~/AdminDesignResource/demo/default/base/style.bundle.rtl.css"));
            //Bundles {End} : Global Theme Bundle

            //Bundles {Start} : Page Scripts --> LoginPage
            bundles.Add(new ScriptBundle("~/bundles/MetronicPageScripts_LOGIN.js").Include(
              "~/AdminDesignResource/snippets/custom/pages/user/login.js",
              "~/AdminDesignResource/snippets/custom/pages/user/validate-login.js"));
            //Bundles {End} : Page Scripts --> LoginPage
            //Bundles {Start} : Page Scripts --> Dashboard
            bundles.Add(new ScriptBundle("~/bundles/Dashboard.js").Include(
                "~/AdminDesignResource/vendors/custom/fullcalendar/fullcalendar.bundle.js",
                "~/AdminDesignResource/app/js/dashboard.js",
                "~/AdminDesignResource/vendors/jquery.min.js",
                "~/AdminDesignResource/custom-js.js"));
            bundles.Add(new StyleBundle("~/Content/Dashboard.css").Include(
                "~/AdminDesignResource/vendors/custom/fullcalendar/fullcalendar.bundle.rtl.css",
                "~/AdminDesignResource/vendors/custom/custom-css.css"));
            //Bundles {END} : Page Scripts --> Dashboard
            //Bundles {Start} : Page Scripts --> AdminProfile
            bundles.Add(new ScriptBundle("~/bundles/AdminProfile.js").Include(
                "~/AdminDesignResource/app/js/jqueryvalidate.js",
                "~/AdminDesignResource/app/js/adminPanelMainControllerJS.js"));
            //Style Uses Dashboard styles
            //Bundles {END} : Page Scripts --> AdminProfile
            bundles.Add(new ScriptBundle("~/bundles/Select2.js").Include(
    "~/AdminDesignResource/demo/default/custom/crud/forms/widgets/select2.js"));
            //Bundles {Start} : Page Scripts --> CustomerSide
            bundles.Add(new ScriptBundle("~/bundles/Afra.js").Include(
               "~/CustomerSide_desinerResource/assets/js/jquery.min.js",
               "~/CustomerSide_desinerResource/assets/js/bootstrap.min.js",
               "~/CustomerSide_desinerResource/assets/js/plugins.min.js",
               "~/CustomerSide_desinerResource/assets/js/main-scripts.js"));

            bundles.Add(new StyleBundle("~/assets/Afra.css").Include(
               "~/CustomerSide_desinerResource/assets/css/icons.min.css",
               "~/CustomerSide_desinerResource/assets/css/bootstrap.min.css",
               "~/CustomerSide_desinerResource/assets/css/plugins.min.css",
               "~/CustomerSide_desinerResource/assets/css/colors.css",
               "~/CustomerSide_desinerResource/assets/css/styles.css"
           ));

            /////Afra bundles

            bundles.Add(new ScriptBundle("~/bundles/Afra.js").Include(
               "~/CustomerSide_desinerResource/assets/js/jquery.min.js",
               "~/CustomerSide_desinerResource/assets/js/bootstrap.min.js",
               "~/CustomerSide_desinerResource/assets/js/plugins.min.js",
               "~/CustomerSide_desinerResource/assets/js/main-scripts.js"));

            bundles.Add(new StyleBundle("~/assets/Afra.css").Include(
               "~/CustomerSide_desinerResource/assets/css/icons.min.css",
               "~/CustomerSide_desinerResource/assets/css/bootstrap.min.css",
               "~/CustomerSide_desinerResource/assets/css/plugins.min.css",
               "~/CustomerSide_desinerResource/assets/css/colors.css",
               "~/CustomerSide_desinerResource/assets/css/styles.css"
           ));


            //Bundles {Start} : Page Scripts --> UploaderModules
            bundles.Add(new ScriptBundle("~/bundles/Uploader.js").Include(
              //"~/AdminDesignResource/vendors/custom/custom-js.js",
              "~/AdminDesignResource/app/js/uploader.js"));
            //Bundles {END} : Page Scripts --> UploaderModules

            //Bundles {Start} : Page Scripts --> Adminstrator_Customers
            bundles.Add(new ScriptBundle("~/bundles/AdminCustomer.js").Include(
              "~/AdminDesignResource/demo/default/custom/header/actions.js",
              "~/AdminDesignResource/vendors/custom/custom-js.js",
              "~/AdminDesignResource/app/js/Admin_Customers.js"));
            //Bundles {END} : Page Scripts --> Adminstrator_Customers

            //Bundles {Start} : Page Scripts --> Adminstrator_Customers_Profile
            bundles.Add(new ScriptBundle("~/bundles/AdminCustomerProf.js").Include(
              "~/AdminDesignResource/demo/default/custom/header/actions.js",
              "~/AdminDesignResource/vendors/custom/custom-js.js"));
            //Bundles {END} : Page Scripts --> Adminstrator_Customers_Profile

            //Bundles {Start} : Page Scripts --> Adminstrator_Blog
            bundles.Add(new ScriptBundle("~/bundles/AdminstratorBlog.js").Include(
              "~/AdminDesignResource/app/js/Admin_Blog.js"));
            //Bundles {END} : Page Scripts --> Adminstrator_Blog

            BundleTable.EnableOptimizations = false;



        }
    }
}
