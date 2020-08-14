using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BamboPortal_V1._0._0._0.Models.CustomerSide.BlogModels
{
    public class CustomerSidePostModel
    {
        public int Id { get; set; }
        public string title { get; set; }
        public string date { get; set; }
        public string by { get; set; }
        public string text_min { get; set; }
        public string text { get; set; }
        public string tags { get; set; }
        public string ImagePath { get; set; }
        public string InGroup { get; set; }
        public int Comments__ { get; set; }
        public List<string> Tags { get; set; }
        public string PostType { get; set; }
        public int IsImportant { get; set; }
        public string Category { get; set; }
        public int IsDeleted { get; set; }
        public int IsDisabled { get; set; }
        public int SearchGravity { get; set; }
        public string AdminPic { get; set; }
        public string GPIDforPostPAge { set; get; }
    }
}