using BamboPortal_V1._0._0._0.DatabaseCenter.Class;
using BamboPortal_V1._0._0._0.ModelFiller.CustomerSide;
using BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace BamboPortal_V1._0._0._0.Controllers
{
    public class CustomerSide_BlogController : CustomerSide_BlogRuleController
    {
        ////////////////////////{ start : blog }////////////////////////5
        ///مثال 
        ////url = MS/blog?NamePage=post&page=1
        ////url = MS/blog?NamePage=Categories&Valuepage=اخبار پاندایی&page=1
        public ActionResult Blog(string Cat = "همه", int Page = 1, int Id = 0, string search = "")
        {
            PDBC db = new PDBC();
            string SearchNAmeHeader = "تمامی مطالب";
            int num = 1;
            db.Connect();
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
                db.DC();
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Categories] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND [GroupId] = " + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Groups] WHERE [G_Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Tags] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where (Is_Deleted=0 AND Is_Disabled=0) AND (Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%') ").Rows[0][0]);
                db.DC();
            }

            if (num % 15 == 0)
            {
                num = (num / 15);
            }
            else
            {
                num = (num / 15) + 1;
            }




            BlogModelFiller BMF = new BlogModelFiller();
            var model = new BlogPostsModel()
            {
                Categories = BMF.BCategory_Filler(),
                Tags = BMF.B_AllTags_Filler(),
                Posts = BMF.UserPostModels(Cat, Page, Id, search),
                GroupsList = BMF.C_AllTags_Filler(),
                Pages = num,
                Page = Page,
                Cat = Cat,
                Id = Id,
                SearchNAmeHeaderH1 = SearchNAmeHeader
            };

            return View(model);
        }

        /// /////////////////////{ end : blog }////////////////////////
        /// 
        public ActionResult Blog_Post(int Id)
        {
            BlogModelFiller BMF = new BlogModelFiller(3);
            var model = new SinglePostModel()
            {
                PostModel = BMF.UserPostModels("همه", 1, 0, ""),
                SPPD = BMF.SinglePostFiller(Id),
                BlogPicSlider = BMF.GetAllBlogPostPics(Id)
            };
            return View(model);
        }

        public ActionResult BlogPosts(string Cat = "همه", int Page = 1, int Id = 0, string search = "")
        {
            PDBC db = new PDBC();
            string SearchNAmeHeader = "تمامی مطالب";
            int num = 1;
            db.Connect();
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
                db.DC();
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Categories] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND [GroupId] = " + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Groups] WHERE [G_Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
                using (DataTable dt2 = db.Select("SELECT [name] FROM  [tbl_BLOG_Tags] WHERE [Id] =" + Id))
                {
                    SearchNAmeHeader = dt2.Rows[0][0].ToString();
                }
                db.DC();
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where (Is_Deleted=0 AND Is_Disabled=0) AND (Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%') ").Rows[0][0]);
                db.DC();
            }

            if (num % 15 == 0)
            {
                num = (num / 15);
            }
            else
            {
                num = (num / 15) + 1;
            }




            BlogModelFiller BMF = new BlogModelFiller();
            var model = new BlogPostsModel()
            {
                Categories = BMF.BCategory_Filler(),
                Tags = BMF.B_AllTags_Filler(),
                Posts = BMF.UserPostModels(Cat, Page, Id, search),
                GroupsList = BMF.C_AllTags_Filler(),
                Pages = num,
                Page = Page,
                Cat = Cat,
                Id = Id,
                SearchNAmeHeaderH1 = SearchNAmeHeader
            };

            return View(model);
        }

        public ActionResult PostDetails(int Id)
        {
            BlogModelFiller BMF = new BlogModelFiller(3);
            var model = new SinglePostModel()
            {
                PostModel = BMF.UserPostModels("همه", 1, 0, ""),
                SPPD = BMF.SinglePostFiller(Id),
                BlogPicSlider = BMF.GetAllBlogPostPics(Id)
            };
            return View(model);
        }

        //[HttpPost]
        //public ActionResult PostModels_ByType(string Type_Token)
        //{
        //    BlogModelFiller BMF = new BlogModelFiller();
        //    return Json(BMF.PostModels_ByType(Type_Token));
        //}
    }
}