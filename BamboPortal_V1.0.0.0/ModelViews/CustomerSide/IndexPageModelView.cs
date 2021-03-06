﻿using BamboPortal_V1._0._0._0.Models;
using BamboPortal_V1._0._0._0.Models.CustomerSide;
using BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BamboPortal_V1._0._0._0.ModelViews.CustomerSide
{
    public class IndexPageModelView
    {
        public List<Id_ValueModel> Categories { get; set; }
        public List<Id_ValueModel> GroupsList { get; set; }
        public List<Id_ValueModel> Tags { get; set; }
        public List<CustomerSidePostModel> Posts { get; set; }
        public int Page { get; set; }
        public int Pages { get; set; }
        public string Cat { get; set; }
        public int Id { get; set; }
        public string SearchNAmeHeaderH1 { get; set; }

    }
}