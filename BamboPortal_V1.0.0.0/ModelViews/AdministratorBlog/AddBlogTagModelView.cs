﻿using BamboPortal_V1._0._0._0.Models.AdministratorBlogModels;
using BamboPortal_V1._0._0._0.Models.CustomerSide;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BamboPortal_V1._0._0._0.ModelViews.AdministratorBlog
{
    public class AddBlogTagModelView
    {
        public AddTagModel AddTag { get; set; }
        public List<BlogTagListModel> TagList { get; set; }
        public List<Id_ValueModel> BlogCategories { get; set; }
    }
}