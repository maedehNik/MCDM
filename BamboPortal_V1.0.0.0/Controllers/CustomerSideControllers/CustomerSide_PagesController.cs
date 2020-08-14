using BamboPortal_V1._0._0._0.DatabaseCenter.Class;
using BamboPortal_V1._0._0._0.ModelFiller.CustomerSide;
using BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels;
using BamboPortal_V1._0._0._0.ModelViews.CustomerSide;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BamboPortal_V1._0._0._0.Controllers
{
    public class CustomerSide_PagesController : CustomerSide_CustomerRuleController
    {
        // GET: CustomerSide_Pages
        public ActionResult index()
        {
            BlogModelFiller BMF = new BlogModelFiller(3);
            var model = new IndexPageModelView()
            {
                Posts = BMF.UserPostModels("همه", 1, 0, "")
            };
            return View(model);
        }

        public ActionResult AboutUs()
        {
            CustomerModelFiller modelFiller = new CustomerModelFiller();

            var ModelView = new AboutUsModelView()
            {
                CustomerMessages = modelFiller.CompanyCustomers(),
                TeamMembers = modelFiller.TeamMembers()
            };
            return View(ModelView);
        }

        public ActionResult Rules()
        {
            return View();
        }

        public ActionResult ContactUs()
        {

            return View();
        }


        public ActionResult AfraMaterPostsTypes()
        {

            BlogModelFiller BMF = new BlogModelFiller();

            return View(BMF.Groups_Filler());
        }

        public ActionResult BlogMainPageSectionofPost()
        {

            BlogModelFiller BMF = new BlogModelFiller();
            var model = new BlogPostsModel()
            {
                Posts = BMF.UserPostModels("همه", 1, 7, "")

            };

            return View(model);
        }

        public ActionResult MainPage()
        {
            BlogModelFiller BMF = new BlogModelFiller(3);
            var model = new BlogPostsModel()
            {
                Posts = BMF.UserPostModels("همه", 1, 0, "")
            };
            return View(model);
        }

        public ActionResult ContactUsMessage(string Name, string Email, string Subject, string Message)
        {
            PDBC db = new PDBC();
            List<ExcParameters> parss = new List<ExcParameters>();
            ExcParameters par = new ExcParameters()
            {
                _KEY = "@Name",
                _VALUE = Name
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Email",
                _VALUE = Email
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Subject",
                _VALUE = Subject
            };
            parss.Add(par);

            par = new ExcParameters()
            {
                _KEY = "@Message",
                _VALUE = Message
            };
            parss.Add(par);

            db.Connect();
            db.Script("INSERT INTO [tbl_CotactUs]VALUES(@Email,@Name,@Subject,@Message)", parss);
            db.DC();
            return Content("Success");
        }

    }
}