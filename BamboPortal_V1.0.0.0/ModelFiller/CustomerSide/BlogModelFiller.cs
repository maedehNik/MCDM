using BamboPortal_V1._0._0._0.DatabaseCenter.Class;
using BamboPortal_V1._0._0._0.Models.CustomerSide;
using BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels;
using BamboPortal_V1._0._0._0.StaticClass;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;

namespace BamboPortal_V1._0._0._0.ModelFiller.CustomerSide
{
    public class BlogModelFiller
    {
        private string NoImage = "/CustomerSide_desinerResource/images/shop/imgNotFount.jpg";
        private int TopSelector = 0;
        public BlogModelFiller()
        {
            TopSelector = 0;
        }

        public BlogModelFiller(int top)
        {
            TopSelector = top;
        }


        public List<Id_ValueModel> Groups_Filler()
        {
            PDBC db = new PDBC();
            var res = new List<Id_ValueModel>();
            db.Connect();
            DataTable dt = db.Select("SELECT [G_Id],[name] FROM [tbl_BLOG_Groups] WHERE Is_Disabled=0 AND Is_Deleted=0");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> B_Types_Filler()
        {
            PDBC db = new PDBC();
            var res = new List<Id_ValueModel>();
            db.Connect();
            DataTable dt = db.Select("SELECT [B_TypeId],[B_TypeToken] FROM [tbl_BLOG_PostType]");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["B_TypeId"]),
                    Value = dt.Rows[i]["B_TypeToken"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> BCategory_Filler()
        {
            PDBC db = new PDBC();
            var res = new List<Id_ValueModel>();
            db.Connect();
            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Categories] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<Id_ValueModel> B_Tags_Filler(int CatId)
        {
            PDBC db = new PDBC();
            var res = new List<Id_ValueModel>();

            db.Connect();
            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Tags] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0 AND [CtegoryId]=" + CatId);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }
        public List<Id_ValueModel> Post_Tags(int PostId)
        {
            PDBC db = new PDBC();
            var res = new List<Id_ValueModel>();

            db.Connect();
            DataTable dt = db.Select("SELECT [Id],[Name] FROM [tbl_BLOG_Tags] as A inner join [tbl_BLOG_TagConnector] as B on A.Id=B.Tag_Id Where [Is_Disabled]=0 AND [Is_Deleted]=0 AND B.Post_Id=" + PostId);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["Name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }


        public List<CustomerSidePostModel> Posttable()
        {
            var res = new List<CustomerSidePostModel>();
            PDBC db = new PDBC();
            db.Connect();

            DataTable dt = db.Select("SELECT [Id],[Title],[GroupId],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic FROM [tbl_BLOG_Post] order by(date)desc");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                
                var model = new CustomerSidePostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    ImagePath = dt.Rows[i]["Pic"].ToString(),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = DateConvert.DateReturner(dt.Rows[i]["Date"].ToString(), "Date"),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString()
                };
                res.Add(model);
            }
            return res;
        }

        public List<Id_ValueModel> B_AllTags_Filler()
        {
            PDBC db = new PDBC();
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [Id],[name] FROM [tbl_BLOG_Tags] WHERE [Is_Disabled]=0 AND [Is_Deleted]=0 ");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }
        public List<Id_ValueModel> C_AllTags_Filler()
        {
            PDBC db = new PDBC();
            db.Connect();
            var res = new List<Id_ValueModel>();

            DataTable dt = db.Select("SELECT [G_Id],[name] FROM [tbl_BLOG_Groups] WHERE [Is_Deleted]=0 AND [Is_Disabled]=0 ");
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new Id_ValueModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["G_Id"]),
                    Value = dt.Rows[i]["name"].ToString()
                };
                res.Add(model);
            }

            return res;
        }

        public List<CustomerSidePostModel> UserPostModels(string Cat, int Page, int Id, string search, string DateType = "Date")
        {
            var res = new List<CustomerSidePostModel>();
            PDBC db = new PDBC();
            db.Connect();
            DataTable dt = db.Select(QueryMaker_BlogPost(Cat, Page, Id, search));
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CustomerSidePostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
                    ImagePath = dt.Rows[i]["Pic"].ToString(),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = DateConvert.DateReturner(dt.Rows[i]["Date"].ToString(), DateType),
                    AdminPic = dt.Rows[i]["AdminPic"].ToString()
                };

                if (string.IsNullOrEmpty(model.ImagePath))
                {
                    model.ImagePath = NoImage;
                }


                res.Add(model);
            }
            return res;
        }

        public string QueryMaker_BlogPost(string Cat, int Page, int Id, string search, int PostsInPage = 15)
        {
            PDBC db = new PDBC();
            db.Connect();
            int num = 1;
            if (Cat == "همه")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post]  where Is_Deleted=0 AND Is_Disabled=0").Rows[0][0]);
            }
            else if (Cat == "دسته بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=" + Id).Rows[0][0]);
            }
            else if (Cat == "برچسب")
            {
                num = Convert.ToInt32(db.Select("SELECT COUNT(*) FROM [tbl_BLOG_TagConnector] as A inner join [tbl_BLOG_Post] as B on A.Post_Id=B.Id where Is_Deleted=0 AND Is_Disabled=0 AND Tag_Id=" + Id).Rows[0][0]);
            }
            else if (Cat == "جست و جو")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND Title Like N'%" + search + "%' OR Text_min Like N'%" + search + "%' OR [Text] Like N'%" + search + "%' ").Rows[0][0]);
            }
            else if (Cat == "گروه بندی")
            {
                num = Convert.ToInt32(db.Select("SELECT Count(*) FROM [tbl_BLOG_Post] where Is_Deleted=0 AND Is_Disabled=0 AND GroupId=" + Id).Rows[0][0]);
            }
            db.DC();
            if (num % PostsInPage == 0)
            {
                num = (num / PostsInPage);
            }
            else
            {
                num = (num / PostsInPage) + 1;
            }


            StringBuilder Query = new StringBuilder();
            if (TopSelector == 0)
            {
                Query.Append("select * from(SELECT NTILE(");
            }
            else
            {
                Query.Append("select TOP(");
                Query.Append(TopSelector);
                Query.Append(") * from(SELECT NTILE(");
            }
            Query.Append(num);
            Query.Append(")over(order by(Date)DESC)as tile,[Cat_Id],[GroupId],[Id],[Title],[Text_min],[Text],[ad_firstname]+' '+[ad_lastname] AS adminName,[AdminPic],[Date],[weight],[Is_Deleted],[Is_Disabled],[G_Id],[GroupName],[Category],[Pic] FROM [v_CustomerSide_BlogPostList]");

            if (Cat == "همه")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0");
                Query.Append(")b where b.tile=");
                Query.Append(Page);
            }
            else if (Cat == "دسته بندی")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND Cat_Id=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);

            }
            else if (Cat == "گروه بندی")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND GroupId=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);

            }
            else if (Cat == "برچسب")
            {
                Query.Append(" as B1 inner join [tbl_BLOG_TagConnector] as B2 on B1.Id=B2.Post_Id where Is_Deleted=0 AND Is_Disabled=0 AND B2.Tag_Id=");
                Query.Append(Id);
                Query.Append(")b where b.tile=");
                Query.Append(Page);
            }
            else if (Cat == "جست و جو")
            {
                Query.Append(" where Is_Deleted=0 AND Is_Disabled=0 AND Title Like N'%");
                Query.Append(search);
                Query.Append("%' OR Text_min Like N'%");
                Query.Append(search);
                Query.Append("%' OR [Text] Like N'%");
                Query.Append(search);
                Query.Append("%')b where b.tile=");
                Query.Append(Page);
                Query.Append("order by([weight])DESC");
            }

            return Query.ToString();
        }

        public List<BlogPics> GetAllBlogPostPics(int postid)
        {
            List<BlogPics> result = new List<BlogPics>();
            PDBC db = new PDBC();
            db.Connect();
            using (DataTable dt = db.Select("SELECT * FROM [v_Blog_AllImages] WHERE ISDELETE<>1 AND PostID = " + postid))
            {
                db.DC();
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    BlogPics BP = new BlogPics();
                    BP.PicAddress =dt.Rows[i]["PicAddress"].ToString();
                    BP.alt = dt.Rows[i]["alt"].ToString();
                    BP.uploadPicName = dt.Rows[i]["uploadPicName"].ToString();
                    BP.Descriptions = dt.Rows[i]["Descriptions"].ToString();
                    result.Add(BP);
                }
            }
            return result;
        }

        public SinglePostPostDetail SinglePostFiller(int idPost, string DateType = "Date")
        {
            SinglePostPostDetail result = new SinglePostPostDetail();
            PDBC db = new PDBC();
            db.Connect();
            using (DataTable dt = db.Select("SELECT * FROM [v_Blog_SinglePost] WHERE PostID = " + idPost))
            {
                if (dt.Rows.Count > 0)
                {
                    result.Cat_Id = dt.Rows[0]["Cat_Id"].ToString();
                    result.GroupId = dt.Rows[0]["GroupId"].ToString();
                    result.Gpname = dt.Rows[0]["Gpname"].ToString();
                    result.CatName = dt.Rows[0]["CatName"].ToString();
                    result.Title = dt.Rows[0]["Title"].ToString();
                    result.Text_min = dt.Rows[0]["Text_min"].ToString();
                    result.Text = dt.Rows[0]["Text"].ToString();
                    result.Date = DateConvert.DateReturner(dt.Rows[0]["Date"].ToString(), DateType);
                    result.weight = dt.Rows[0]["weight"].ToString();
                    result.IsImportant = dt.Rows[0]["IsImportant"].ToString();
                    result.PostID = dt.Rows[0]["PostID"].ToString();
                    result.WrittenBy_AdminId = dt.Rows[0]["WrittenBy_AdminId"].ToString();
                    result.ad_firstname = dt.Rows[0]["ad_firstname"].ToString();
                    result.ad_lastname = dt.Rows[0]["ad_lastname"].ToString();
                    result.ad_avatarprofile = dt.Rows[0]["ad_avatarprofile"].ToString();
                    DataTable Comments = db.Select("SELECT [Id],[Email],[message],[Date] FROM [tbl_BLOG_Comment] where PostId=" + idPost);
                    var Com = new List<CommentsModel>();
                    db.DC();
                    db.Connect();
                    for (int i = 0; i < Comments.Rows.Count; i++)
                    {
                        var Rep = new List<CommentsModel>();
                        DataTable rep = db.Select("SELECT [Id],[Email],[Message],[Date]FROM [tbl_BLOG_Reply] where commentId=" + Comments.Rows[i]["Id"]);
                        for (int j = 0; j < rep.Rows.Count; j++)
                        {
                            var Rmodel = new CommentsModel()
                            {
                                Id = Convert.ToInt32(rep.Rows[j]["Id"]),
                                Email = rep.Rows[j]["Email"].ToString(),
                                Message = rep.Rows[j]["Message"].ToString(),
                                Date = DateConvert.DateReturner(rep.Rows[j]["Date"].ToString(), DateType)
                            };
                            Rep.Add(Rmodel);
                        }

                        var model = new CommentsModel()
                        {
                            Id = Convert.ToInt32(Comments.Rows[i]["Id"]),
                            Email = Comments.Rows[i]["Email"].ToString(),
                            Message = Comments.Rows[i]["Message"].ToString(),
                            Date = DateConvert.DateReturner(Comments.Rows[i]["Date"].ToString(), DateType),
                            Reply = Rep
                        };
                        Com.Add(model);
                    }

                    result.Comments = Com;
                }
                else
                {
                    result.PostID = "0";
                }
            }
            db.DC();
            return result;
        }

        //public List<CustomerSidePostModel> PostModels_ByType(string Type_token, string DateType = "Date")
        //{
        //    var res = new List<CustomerSidePostModel>();
        //    PDBC db = new PDBC();
        //    db.Connect();
        //    DataTable dt1 = db.Select("SELECT [G_Id] FROM [tbl_BLOG_Groups] where [GpToken] LIKE N'" + Type_token + "'");
        //    if (dt1.Rows.Count != 0)
        //    {
        //        DataTable dt = db.Select("SELECT [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] WHERE [GroupId] = " + dt1.Rows[0]["B_TypeId"]);
        //        db.DC();
        //        for (int i = 0; i < dt.Rows.Count; i++)
        //        {
        //            var model = new CustomerSidePostModel()
        //            {
        //                Id = Convert.ToInt32(dt.Rows[i]["Id"]),
        //                by = dt.Rows[i]["adminName"].ToString(),
        //                Category = dt.Rows[i]["Category"].ToString(),
        //                InGroup = dt.Rows[i]["GroupName"].ToString(),
        //                GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
        //                ImagePath = dt.Rows[i]["Pic"].ToString(),
        //                IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
        //                IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
        //                text = dt.Rows[i]["Text"].ToString(),
        //                title = dt.Rows[i]["Title"].ToString(),
        //                text_min = dt.Rows[i]["Text_min"].ToString(),
        //                date = DateConvert.DateReturner(dt.Rows[i]["Date"].ToString(), DateType),
        //                AdminPic = dt.Rows[i]["AdminPic"].ToString(),
        //                PostType = dt.Rows[i]["TypeId"].ToString()
        //            };
        //            res.Add(model);
        //        }
        //    }
        //    db.DC();

        //    return res;
        //}


        public List<CustomerSidePostModel> PostModels_Chosen(string Cat, int TopSelect, string DateType = "Date")
        {
            var res = new List<CustomerSidePostModel>();
            PDBC db = new PDBC();

            string Query = "";
            if (Cat == "Popular")
            {
                Query = "SELECT top " + TopSelect + " [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] Order By(SELECT COUNT(*) FROM [tbl_BLOG_Comment] WHERE PostId=Id) DESC,Date DESC";
            }
            else if (Cat == "New")
            {
                Query = "SELECT top " + TopSelect + " [Id],[Title],[Text_min],[Text],(SELECT [ad_firstname]+ ' '+ [ad_lastname] as name FROM [tbl_ADMIN_main]where id_Admin=[WrittenBy_AdminId])as adminName ,[Date],[IsImportant],[Is_Deleted],[Is_Disabled],(SELECT [name]FROM [tbl_BLOG_Categories] where Id=[Cat_Id]) as Category,(SELECT [name]FROM [tbl_BLOG_Groups] where G_Id=[GroupId]) as GroupName,(SELECT top 1 B.PicAddress FROM [tbl_BLOG_Pic_Connector] as A inner join [tbl_ADMIN_UploadStructure_ImageAddress] as B on A.[PicId]=B.PicID where A.PostId=Id)as Pic,(SELECT [ad_avatarprofile] FROM[tbl_ADMIN_main] where id_Admin=WrittenBy_AdminId) as AdminPic ,(SELECT[B_TypeToken] FROM [tbl_BLOG_PostType] WHERE B_TypeId=[TypeId]) as TypeId FROM [tbl_BLOG_Post] Order By(Date)DESC";
            }


            db.Connect();
            DataTable dt = db.Select(Query);
            db.DC();
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                var model = new CustomerSidePostModel()
                {
                    Id = Convert.ToInt32(dt.Rows[i]["Id"]),
                    by = dt.Rows[i]["adminName"].ToString(),
                    Category = dt.Rows[i]["Category"].ToString(),
                    InGroup = dt.Rows[i]["GroupName"].ToString(),
                    GPIDforPostPAge = dt.Rows[i]["GroupId"].ToString(),
                    ImagePath = dt.Rows[i]["Pic"].ToString(),
                    IsDeleted = Convert.ToInt32(dt.Rows[i]["Is_Deleted"]),
                    IsDisabled = Convert.ToInt32(dt.Rows[i]["Is_Disabled"]),
                    text = dt.Rows[i]["Text"].ToString(),
                    title = dt.Rows[i]["Title"].ToString(),
                    text_min = dt.Rows[i]["Text_min"].ToString(),
                    date = DateConvert.DateReturner(dt.Rows[i]["Date"].ToString(), DateType),
                    AdminPic = dt.Rows[i]["AdminPic"].ToString(),
                    PostType = dt.Rows[i]["TypeId"].ToString()
                };
                res.Add(model);
            }
            return res;
        }


    }

}