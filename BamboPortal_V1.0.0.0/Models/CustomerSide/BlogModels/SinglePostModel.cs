using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels
{
    public class SinglePostModel
    {
        public SinglePostPostDetail SPPD { set; get; }
        public List<CustomerSidePostModel> PostModel { set; get; }
        public List<BlogPics> BlogPicSlider { set; get; }
    }
}