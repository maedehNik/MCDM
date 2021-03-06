USE [_bamboPortaldb]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Categories]    Script Date: 7/5/2020 1:54:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Categories](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Categories_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Post]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Post](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](max) NULL,
	[Text_min] [nvarchar](max) NULL,
	[Text] [nvarchar](max) NULL,
	[WrittenBy_AdminId] [int] NULL,
	[Date] [datetime] NULL,
	[weight] [int] NULL,
	[IsImportant] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Cat_Id] [int] NULL,
	[GroupId] [int] NULL,
	[TypeId] [int] NULL,
 CONSTRAINT [PK_Post_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_main]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_main](
	[id_Admin] [int] IDENTITY(1,1) NOT NULL,
	[ad_typeID] [int] NOT NULL,
	[ad_username] [nvarchar](max) NULL,
	[ad_password] [nvarchar](max) NULL,
	[ad_firstname] [nvarchar](100) NULL,
	[ad_lastname] [nvarchar](200) NULL,
	[ad_avatarprofile] [nvarchar](max) NULL,
	[ad_email] [nvarchar](max) NULL,
	[ad_phone] [nvarchar](20) NULL,
	[ad_mobile] [nvarchar](20) NULL,
	[ad_has2stepSecurity] [tinyint] NOT NULL,
	[ad_isActive] [tinyint] NOT NULL,
	[ad_isDelete] [tinyint] NOT NULL,
	[ad_lastseen] [datetime] NULL,
	[ad_lastlogin] [datetime] NULL,
	[ad_loginIP] [nvarchar](50) NULL,
	[ad_regdate] [datetime] NOT NULL,
	[ad_personalColorHexa] [nvarchar](max) NULL,
	[AdminModeID] [int] NULL,
	[ad_NickName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_main] PRIMARY KEY CLUSTERED 
(
	[id_Admin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Groups]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Groups](
	[G_Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
	[GpToken] [nvarchar](50) NULL,
 CONSTRAINT [PK_Groups_tbl] PRIMARY KEY CLUSTERED 
(
	[G_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Blog_SinglePost]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Blog_SinglePost]
AS
SELECT        dbo.tbl_BLOG_Post.Cat_Id, dbo.tbl_BLOG_Post.GroupId, dbo.tbl_BLOG_Groups.name AS Gpname, dbo.tbl_BLOG_Categories.name AS CatName, dbo.tbl_BLOG_Post.Title, dbo.tbl_BLOG_Post.Text_min, dbo.tbl_BLOG_Post.Text,
                          dbo.tbl_BLOG_Post.Date, dbo.tbl_BLOG_Post.weight, dbo.tbl_BLOG_Post.IsImportant, dbo.tbl_BLOG_Post.Id AS PostID, dbo.tbl_BLOG_Post.WrittenBy_AdminId, dbo.tbl_ADMIN_main.ad_firstname, 
                         dbo.tbl_ADMIN_main.ad_lastname, dbo.tbl_ADMIN_main.ad_avatarprofile
FROM            dbo.tbl_BLOG_Categories INNER JOIN
                         dbo.tbl_BLOG_Post ON dbo.tbl_BLOG_Categories.Id = dbo.tbl_BLOG_Post.Cat_Id INNER JOIN
                         dbo.tbl_BLOG_Groups ON dbo.tbl_BLOG_Post.GroupId = dbo.tbl_BLOG_Groups.G_Id INNER JOIN
                         dbo.tbl_ADMIN_main ON dbo.tbl_BLOG_Post.WrittenBy_AdminId = dbo.tbl_ADMIN_main.id_Admin
WHERE        (dbo.tbl_BLOG_Post.Is_Disabled <> 1) AND (dbo.tbl_BLOG_Post.Is_Deleted <> 1) AND (dbo.tbl_BLOG_Groups.Is_Deleted <> 1) AND (dbo.tbl_BLOG_Groups.Is_Disabled <> 1) AND (dbo.tbl_BLOG_Categories.Is_Deleted <> 1) AND
                          (dbo.tbl_BLOG_Categories.Is_Disabled <> 1)
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryType] [int] NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
	[CreatedDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_ImageSize]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_ImageSize](
	[picSizeType] [int] IDENTITY(1,1) NOT NULL,
	[picSizeTypeName] [nvarchar](max) NULL,
	[picSizeTypeWidth] [float] NULL,
	[picSizeTypeHeight] [float] NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_ImageSize] PRIMARY KEY CLUSTERED 
(
	[picSizeType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic](
	[PicCategoryType] [int] IDENTITY(1,1) NOT NULL,
	[PicCategoryTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_UploaderStructure_CategoryPic] PRIMARY KEY CLUSTERED 
(
	[PicCategoryType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_UploadStructure_ImageAddress]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_UploadStructure_ImageAddress](
	[PicID] [int] NOT NULL,
	[PicSizeType] [int] NOT NULL,
	[PicAddress] [nvarchar](max) NOT NULL,
	[PicThumbnailAddress] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Images]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Images]
AS
SELECT        dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeName, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeWidth, dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeTypeHeight, 
                         dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicAddress, dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicThumbnailAddress, 
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryTypeName, dbo.tbl_ADMIN_UploaderStructure.alt, dbo.tbl_ADMIN_UploaderStructure.uploadPicName, dbo.tbl_ADMIN_UploaderStructure.ISDELETE, 
                         dbo.tbl_ADMIN_UploaderStructure.Descriptions, dbo.tbl_ADMIN_UploaderStructure.CreatedDate
FROM            dbo.tbl_ADMIN_UploadStructure_ImageAddress INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_ImageSize ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicSizeType = dbo.tbl_ADMIN_UploaderStructure_ImageSize.picSizeType INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure ON dbo.tbl_ADMIN_UploadStructure_ImageAddress.PicID = dbo.tbl_ADMIN_UploaderStructure.PicID INNER JOIN
                         dbo.tbl_ADMIN_UploaderStructure_CategoryPic ON dbo.tbl_ADMIN_UploaderStructure.PicCategoryType = dbo.tbl_ADMIN_UploaderStructure_CategoryPic.PicCategoryType
GO
/****** Object:  Table [dbo].[tbl_BLOG_Pic_Connector]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Pic_Connector](
	[PostId] [int] NOT NULL,
	[PicId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_Blog_AllImages]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_Blog_AllImages]
AS
SELECT        dbo.tbl_BLOG_Pic_Connector.PicId, dbo.tbl_BLOG_Pic_Connector.PostId, dbo.v_Images.picSizeTypeName, dbo.v_Images.picSizeTypeWidth, dbo.v_Images.picSizeTypeHeight, dbo.v_Images.PicID AS Expr1, 
                         dbo.v_Images.PicAddress, dbo.v_Images.PicThumbnailAddress, dbo.v_Images.PicCategoryTypeName, dbo.v_Images.alt, dbo.v_Images.uploadPicName, dbo.v_Images.ISDELETE, dbo.v_Images.Descriptions
FROM            dbo.v_Images INNER JOIN
                         dbo.tbl_BLOG_Pic_Connector ON dbo.v_Images.PicID = dbo.tbl_BLOG_Pic_Connector.PicId
GO
/****** Object:  Table [dbo].[tbl_ADMIN_types]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types](
	[ad_typeID] [int] IDENTITY(1,1) NOT NULL,
	[ad_type_name] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_types] PRIMARY KEY CLUSTERED 
(
	[ad_typeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[v_ADMIN_mainView]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[v_ADMIN_mainView]
AS
SELECT        dbo.tbl_ADMIN_types.ad_type_name, dbo.tbl_ADMIN_main.ad_typeID, dbo.tbl_ADMIN_main.id_Admin, dbo.tbl_ADMIN_main.ad_username, dbo.tbl_ADMIN_main.ad_password, dbo.tbl_ADMIN_main.ad_firstname, 
                         dbo.tbl_ADMIN_main.ad_lastname, dbo.tbl_ADMIN_main.ad_avatarprofile, dbo.tbl_ADMIN_main.ad_email, dbo.tbl_ADMIN_main.ad_NickName, dbo.tbl_ADMIN_main.AdminModeID, dbo.tbl_ADMIN_main.ad_personalColorHexa, 
                         dbo.tbl_ADMIN_main.ad_loginIP, dbo.tbl_ADMIN_main.ad_regdate, dbo.tbl_ADMIN_main.ad_lastlogin, dbo.tbl_ADMIN_main.ad_lastseen, dbo.tbl_ADMIN_main.ad_isDelete, dbo.tbl_ADMIN_main.ad_isActive, 
                         dbo.tbl_ADMIN_main.ad_has2stepSecurity, dbo.tbl_ADMIN_main.ad_mobile, dbo.tbl_ADMIN_main.ad_phone
FROM            dbo.tbl_ADMIN_main INNER JOIN
                         dbo.tbl_ADMIN_types ON dbo.tbl_ADMIN_main.ad_typeID = dbo.tbl_ADMIN_types.ad_typeID
GO
/****** Object:  Table [dbo].[tbl_ADMIN_adminMode]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_adminMode](
	[AdminModeID] [int] IDENTITY(1,1) NOT NULL,
	[adminModeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_adminMode] PRIMARY KEY CLUSTERED 
(
	[AdminModeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Category]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Category](
	[CatId] [int] IDENTITY(1,1) NOT NULL,
	[R_CatName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Category] PRIMARY KEY CLUSTERED 
(
	[CatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_ruleRoutes_Main]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_ruleRoutes_Main](
	[rulerouteID] [int] IDENTITY(1,1) NOT NULL,
	[ruleRouteURL] [nvarchar](max) NOT NULL,
	[ruleRouteName] [nvarchar](max) NULL,
	[ruleRouteCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_ADMIN_ruleRoutes_Main] PRIMARY KEY CLUSTERED 
(
	[rulerouteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_ADMIN_types_ruleRoute_Connection]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_ADMIN_types_ruleRoute_Connection](
	[ad_typeID] [int] NOT NULL,
	[rulerouteID] [int] NOT NULL,
	[HasAccess] [tinyint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Comment]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Comment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[PostId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Comment_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_CustomersMessge]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_CustomersMessge](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](max) NULL,
	[Job] [nvarchar](max) NULL,
	[message] [nvarchar](max) NULL,
	[star] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_CustomersMessge_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailModule]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailModule](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailModule_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_EmailTemplate]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_EmailTemplate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TemplateName] [nvarchar](50) NULL,
	[HtmlCode] [nvarchar](max) NULL,
 CONSTRAINT [PK_EmailTemplate_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_PostType]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_PostType](
	[B_TypeId] [int] IDENTITY(1,1) NOT NULL,
	[B_TypeToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_BLOG_PostType] PRIMARY KEY CLUSTERED 
(
	[B_TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Reply]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Reply](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](100) NULL,
	[Message] [nvarchar](max) NULL,
	[commentId] [int] NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
	[Date] [int] NULL,
 CONSTRAINT [PK_Reply_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TagConnector]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TagConnector](
	[Post_Id] [int] NOT NULL,
	[Tag_Id] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_Tags]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_Tags](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[CtegoryId] [int] NULL,
	[Is_Disabled] [tinyint] NULL,
	[Is_Deleted] [tinyint] NULL,
 CONSTRAINT [PK_Tags_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_BLOG_TeamMembers]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_BLOG_TeamMembers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[Job] [nvarchar](100) NULL,
	[Tozihat] [nvarchar](max) NULL,
	[github] [nvarchar](max) NULL,
	[Linkedin] [nvarchar](max) NULL,
	[Instagram] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[ImageValue] [varbinary](max) NULL,
 CONSTRAINT [PK_TeamMembers_tbl] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_CotactUs]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_CotactUs](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[Subject] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_CotactUs] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Address]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Address](
	[id_CAddress] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NOT NULL,
	[ID_Shahr] [int] NOT NULL,
	[C_AddressHint] [nvarchar](max) NOT NULL,
	[C_FullAddress] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Customer_Address] PRIMARY KEY CLUSTERED 
(
	[id_CAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Favorites]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Favorites](
	[CustomerId] [int] NOT NULL,
	[ProductId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Customer_Main]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Customer_Main](
	[id_Customer] [int] IDENTITY(1,1) NOT NULL,
	[C_regDate] [datetime] NOT NULL,
	[C_Mobile] [nvarchar](max) NOT NULL,
	[C_FirstName] [nvarchar](max) NULL,
	[C_LastNAme] [nvarchar](max) NULL,
	[C_Description] [nvarchar](max) NULL,
	[C_ISActivate] [int] NULL,
	[C_ActivationToken] [int] NULL,
	[C_ActivateDate] [datetime] NULL,
	[C_Password] [nvarchar](max) NULL,
	[C_Email] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Customer_Main] PRIMARY KEY CLUSTERED 
(
	[id_Customer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Enum_Shahr]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Enum_Shahr](
	[ID_Shahr] [int] NULL,
	[Shahr_Name] [nvarchar](max) NULL,
	[Shahr_OstanConnection] [int] NULL,
	[Ostan_name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_FACTOR_Items]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FACTOR_Items](
	[ItemId] [int] IDENTITY(1,1) NOT NULL,
	[Pro_Id] [int] NULL,
	[number] [int] NULL,
	[PriceDateId] [int] NULL,
	[FactorId] [int] NULL,
 CONSTRAINT [PK_tbl_FACTOR_Items] PRIMARY KEY CLUSTERED 
(
	[ItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_FACTOR_Main]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_FACTOR_Main](
	[Factor_Id] [int] IDENTITY(1,1) NOT NULL,
	[Customer_Id] [int] NULL,
	[AddressId] [int] NULL,
	[date] [datetime] NULL,
	[Off_Code] [nvarchar](max) NULL,
	[toality] [bigint] NULL,
	[deposit_price] [bigint] NULL,
	[IsDeleted] [tinyint] NULL,
	[delete_by_Id] [int] NULL,
	[delete_UserType] [tinyint] NULL,
	[EditedFactorId] [int] NULL,
	[EditedByUserId] [int] NULL,
	[Done] [tinyint] NULL,
	[PaymentSerial] [nvarchar](max) NULL,
	[PaymentToken] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_FACTOR_Main] PRIMARY KEY CLUSTERED 
(
	[Factor_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product]    Script Date: 7/5/2020 1:55:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product](
	[id_MProduct] [int] IDENTITY(1,1) NOT NULL,
	[IS_AVAILABEL] [tinyint] NOT NULL,
	[id_CreatedByAdmin] [int] NOT NULL,
	[id_DraftLevel] [int] NULL,
	[id_Type] [int] NOT NULL,
	[id_MainCategory] [int] NOT NULL,
	[id_SubCategory] [int] NOT NULL,
	[idMPC_WhichTomainPrice] [int] NULL,
	[Description] [nvarchar](max) NULL,
	[DateCreated] [datetime] NOT NULL,
	[Title] [nvarchar](max) NOT NULL,
	[Seo_Description] [nvarchar](max) NOT NULL,
	[Seo_KeyWords] [nvarchar](max) NOT NULL,
	[IS_AD] [tinyint] NOT NULL,
	[Search_Gravity] [int] NOT NULL,
	[Is_IntheDraft] [tinyint] NOT NULL,
	[ISDELETE] [tinyint] NOT NULL,
 CONSTRAINT [PK_tbl_Product] PRIMARY KEY CLUSTERED 
(
	[id_MProduct] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Comment]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Comment](
	[CommentId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[ProductId] [int] NULL,
	[date] [datetime] NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_ProductComment] PRIMARY KEY CLUSTERED 
(
	[CommentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ConnectorSCOK_Product]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ConnectorSCOK_Product](
	[id_MProduct] [int] NOT NULL,
	[id_SCOK] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_connectorToMPC_SCOV]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_connectorToMPC_SCOV](
	[id_MPC] [int] NOT NULL,
	[id_SCOV] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainCategory]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainCategory](
	[id_MC] [int] IDENTITY(1,1) NOT NULL,
	[id_PT] [int] NOT NULL,
	[MCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_MainCategory] PRIMARY KEY CLUSTERED 
(
	[id_MC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MainStarTags]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MainStarTags](
	[id_MainStarTag] [int] IDENTITY(1,1) NOT NULL,
	[MST_Description] [nvarchar](max) NOT NULL,
	[MST_Name] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_MainStarTags] PRIMARY KEY CLUSTERED 
(
	[id_MainStarTag] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_MoneyType]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_MoneyType](
	[MoneyId] [int] IDENTITY(1,1) NOT NULL,
	[MoneyTypeName] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_MoneyType] PRIMARY KEY CLUSTERED 
(
	[MoneyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_OffType]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_OffType](
	[OffType] [int] NOT NULL,
	[OffType_Description] [nvarchar](max) NOT NULL,
	[OffType_Symbol] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_OffType] PRIMARY KEY CLUSTERED 
(
	[OffType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Opinion]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Opinion](
	[id_Opinion] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[id_Customer] [int] NOT NULL,
	[id_AccByAdmin] [int] NULL,
	[CreateDate] [datetime] NOT NULL,
	[DateAccepted] [datetime] NULL,
	[Is_Accepted] [tinyint] NOT NULL,
	[OpinionDescription] [nvarchar](max) NOT NULL,
	[Rate] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PastProductHistory]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PastProductHistory](
	[id_PPH] [int] IDENTITY(1,1) NOT NULL,
	[id_MPC] [int] NOT NULL,
	[PriceXquantity] [bigint] NOT NULL,
	[PricePerquantity] [bigint] NOT NULL,
	[PriceOff] [bigint] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ChangedDate] [datetime] NOT NULL,
	[OffTypeValue] [bigint] NULL,
 CONSTRAINT [PK_tbl_Product_PastProductHistory] PRIMARY KEY CLUSTERED 
(
	[id_PPH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Pic]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Pic](
	[PicID] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[BigPicAddress] [nvarchar](max) NOT NULL,
	[ThumbnailPicAddress] [nvarchar](max) NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[alt] [nvarchar](max) NULL,
	[uploadPicName] [nvarchar](max) NULL,
	[Descriptions] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_Pic] PRIMARY KEY CLUSTERED 
(
	[PicID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PicConnector]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PicConnector](
	[id_MProduct] [int] NOT NULL,
	[PicID] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_PriceShow]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_PriceShow](
	[PriceShowId] [int] IDENTITY(1,1) NOT NULL,
	[PriceShowformat] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Product_PriceShow] PRIMARY KEY CLUSTERED 
(
	[PriceShowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_ProductQuantityType]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_ProductQuantityType](
	[id_PQT] [int] IDENTITY(1,1) NOT NULL,
	[PQT_Description] [nvarchar](max) NULL,
	[PQT_Demansion] [nvarchar](10) NOT NULL,
	[PQT_Quantom] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_ProductQuantityType] PRIMARY KEY CLUSTERED 
(
	[id_PQT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Reply]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Reply](
	[RepId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](max) NULL,
	[Name] [nvarchar](max) NULL,
	[ImagePath] [nvarchar](max) NULL,
	[Message] [nvarchar](max) NULL,
	[ProductId] [int] NULL,
	[CommentId] [int] NULL,
	[date] [datetime] NULL,
	[CustomerId] [int] NULL,
 CONSTRAINT [PK_ProductReply] PRIMARY KEY CLUSTERED 
(
	[RepId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategory]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategory](
	[id_SC] [int] IDENTITY(1,1) NOT NULL,
	[id_MC] [int] NOT NULL,
	[SCName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategory] PRIMARY KEY CLUSTERED 
(
	[id_SC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionKey]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionKey](
	[id_SCOK] [int] IDENTITY(1,1) NOT NULL,
	[id_SC] [int] NOT NULL,
	[SCOKName] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryKey] PRIMARY KEY CLUSTERED 
(
	[id_SCOK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_SubCategoryOptionValue]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_SubCategoryOptionValue](
	[id_SCOV] [int] IDENTITY(1,1) NOT NULL,
	[id_SCOK] [int] NOT NULL,
	[SCOVValueName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_SubCategoryOptionValue] PRIMARY KEY CLUSTERED 
(
	[id_SCOV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tagConnector]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tagConnector](
	[id_MPC] [int] NOT NULL,
	[id_TE] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_TagEnums]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_TagEnums](
	[id_TE] [int] IDENTITY(1,1) NOT NULL,
	[TE_name] [nvarchar](max) NOT NULL,
	[SubCatId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_Product_TagEnums] PRIMARY KEY CLUSTERED 
(
	[id_TE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_tblOptions]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_tblOptions](
	[id_Op] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[KeyName] [nvarchar](max) NOT NULL,
	[Value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_Product_tblOptions] PRIMARY KEY CLUSTERED 
(
	[id_Op] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Product_Type]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Product_Type](
	[id_PT] [int] IDENTITY(1,1) NOT NULL,
	[PTname] [nvarchar](max) NOT NULL,
	[ISDESABLED] [tinyint] NULL,
	[ISDelete] [tinyint] NULL,
	[DateDesabled] [datetime] NULL,
	[DateDeleted] [datetime] NULL,
 CONSTRAINT [PK_tbl_Product_Type] PRIMARY KEY CLUSTERED 
(
	[id_PT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionEnums]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionEnums](
	[idSecurityQuestion] [int] IDENTITY(1,1) NOT NULL,
	[Question] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_SecurityQuestionEnums] PRIMARY KEY CLUSTERED 
(
	[idSecurityQuestion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_SecurityQuestionUserAns]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_SecurityQuestionUserAns](
	[id_User] [int] NOT NULL,
	[userTypesID] [int] NOT NULL,
	[idSecurityQuestion] [int] NOT NULL,
	[userANS] [nvarchar](max) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_APIvals]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_APIvals](
	[sms_irUserAPIKey] [nvarchar](max) NULL,
	[sms_irSecretKey] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_CustomerKeys]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_CustomerKeys](
	[sms_irSentKeyID] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NOT NULL,
	[sms_irKeyType] [int] NULL,
	[sms_irSentKey] [nvarchar](max) NULL,
	[sms_irKeyGeneratedDate] [datetime] NULL,
	[sms_irIsKeyAlive] [tinyint] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_KeyTypes]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_KeyTypes](
	[sms_irKeyType] [int] IDENTITY(1,1) NOT NULL,
	[sms_irKeyTypeName] [nvarchar](max) NULL,
	[sms_irKeyTypeAliveTimer] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_LOG]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_LOG](
	[id_Customer] [int] IDENTITY(1,1) NOT NULL,
	[sms_irLogID] [int] NOT NULL,
	[sms_irMessageType] [int] NULL,
	[sms_irMessage] [nvarchar](max) NULL,
	[sms_irSendDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_ir_Template]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_ir_Template](
	[sms_irTemplate] [int] IDENTITY(1,1) NOT NULL,
	[sms_irMessageType] [int] NULL,
	[sms_irTemplateAPIKey] [int] NULL,
	[TemplatePandaToken] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_sms_irMessageType]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_sms_irMessageType](
	[sms_irMessageType] [int] IDENTITY(1,1) NOT NULL,
	[sms_irMessageTypeName] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UserController_UserTypes]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UserController_UserTypes](
	[UserTypeID] [int] IDENTITY(1,1) NOT NULL,
	[UserTypeName] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_tbl_UserController_UserTypes] PRIMARY KEY CLUSTERED 
(
	[UserTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tlb_Product_MainProductConnector]    Script Date: 7/5/2020 1:55:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tlb_Product_MainProductConnector](
	[id_MPC] [int] IDENTITY(1,1) NOT NULL,
	[id_MProduct] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[PriceXquantity] [bigint] NOT NULL,
	[PricePerquantity] [bigint] NOT NULL,
	[PriceOff] [bigint] NULL,
	[offTypeValue] [bigint] NULL,
	[OffType] [int] NULL,
	[id_MainStarTag] [int] NOT NULL,
	[ISDELETE] [tinyint] NULL,
	[OutOfStock] [tinyint] NULL,
	[id_PQT] [int] NULL,
	[DateToRelease] [datetime] NULL,
	[PriceModule] [int] NULL,
	[PriceShow] [int] NULL,
	[describtion] [nvarchar](max) NULL,
 CONSTRAINT [PK_tlb_Product_ConnectorToMainProductID] PRIMARY KEY CLUSTERED 
(
	[id_MPC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_main] ON 

INSERT [dbo].[tbl_ADMIN_main] ([id_Admin], [ad_typeID], [ad_username], [ad_password], [ad_firstname], [ad_lastname], [ad_avatarprofile], [ad_email], [ad_phone], [ad_mobile], [ad_has2stepSecurity], [ad_isActive], [ad_isDelete], [ad_lastseen], [ad_lastlogin], [ad_loginIP], [ad_regdate], [ad_personalColorHexa], [AdminModeID], [ad_NickName]) VALUES (1, 1, N'OMD@Ad', N'2db419d05d3ef58e578bac949c795126', N'محمدرضا', N'موسوی نیا', N'/AdminDesignResource/app/media/img/users/user4.jpg', N'asd.dasd@dsakj.gfh', N'2223445', N'11111122223', 0, 1, 0, CAST(N'2020-04-25T00:09:30.420' AS DateTime), CAST(N'2020-04-25T00:09:30.420' AS DateTime), NULL, CAST(N'2020-04-25T00:09:30.420' AS DateTime), NULL, 0, N'مس31231ds43434a2')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_main] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (1, N'تمامی دسته بندی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (2, N'سر دسته ی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (3, N'گروه اصلی محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (4, N'گروه محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (5, N'ویژگی های محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (6, N'جزئیات ویژگی ها')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (7, N'برچسب های اصلی')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (8, N'برچسب محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (9, N'صفحه ساز')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (10, N'محصولات')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (11, N'ادمین')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (1002, N'بلاگ')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (2002, N'فاکتور')
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] ([CatId], [R_CatName]) VALUES (2003, N'مشتریان')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Category] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ON 

INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2002, N'ProductGroup/AddType', N'نمایش صفحه ی سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2003, N'ProductGroup/TypeTbl', N'نمایش جدول سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2004, N'ProductGroup/Add_Update_Type', N'افزودن و ویرایش سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2005, N'ProductGroup/Type_Actions', N'حذف ، فعال و غیر فعال کردن سردسته ی محصولات', 2)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2006, N'ProductGroup/AddMainCat', N'نمایش صفحه ی گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2007, N'ProductGroup/MainCatTbl', N'نمایش جدول گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2008, N'ProductGroup/Add_Update_MainCat', N'افزودن و ویرایش گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2009, N'ProductGroup/Main_Actions', N'حذف ، فعال و غیر فعال کردن گروه اصلی محصولات', 3)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2010, N'ProductGroup/AddSubCat', N'نمایش صفحه ی گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2011, N'ProductGroup/SubCatTbl', N'نمایش جدول گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2012, N'ProductGroup/Add_Update_SubCat', N'افزودن و ویرایش گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2013, N'ProductGroup/Sub_Actions', N'حذف ، فعال و غیر فعال کردن گروه محصولات', 4)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2014, N'ProductGroup/AddSubCatKey', N'نمایش صفحه ی ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2015, N'ProductGroup/SubCatKeyTbl', N'نمایش جدول ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2016, N'ProductGroup/Add_Update_SubCatKey', N'افزودن و ویرایش ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2017, N'ProductGroup/SubKey_Actions', N'حذف ، فعال و غیر فعال کردن ویژگی محصولات', 5)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2018, N'ProductGroup/AddSubCatValue', N'نمایش صفحه ی جزئیات ویژگی', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2019, N'ProductGroup/SubCatValueTbl', N'نمایش جدول جزئیات ویژگی ', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2020, N'ProductGroup/Add_Update_SubCatValue', N'افزودن و ویرایش جزئیات ویژگی ', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2021, N'ProductGroup/SubValue_Actions', N'حذف ، فعال و غیر فعال کردن جزئیات ویژگی ', 6)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2022, N'ProductGroup/AddProductTag', N'نمایش صفحه ی برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2023, N'ProductGroup/ProTagsTbl', N'نمایش جدول برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2024, N'ProductGroup/Add_Update_Tag', N'افزودن و ویرایش برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2026, N'ProductGroup/ProductTag_Actions', N'حذف کردن برچسب محصولات', 8)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2027, N'ProductGroup/AddMainTag', N'نمایش صفحه ی برچسب های اصلی محصولات', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2028, N'ProductGroup/MainTagsTbl', N'نمایش جدول برچسب های اصلی محصولات', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2029, N'ProductGroup/Add_Update_MainTag', N'افزودن و ویرایش برچسب های اصلی محصولات', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2030, N'ProductGroup/MainTag_Actions', N'حذف کردن برچسب های اصلی محصولات', 7)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2031, N'Product/Product_List', N'نمایش صفحه ی لیست محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2032, N'Product/Product_table', N'نمایش جدول محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2033, N'Product/Add_Product', N'نمایش صفحه ی افزودن و ویرایش محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2034, N'Product/Add_Page1', N'نمایش صفحه ی افزودن و ویرایش محصولات_گام1', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2035, N'Product/Add_Page2', N'نمایش صفحه ی افزودن و ویرایش محصولات_گام2', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2036, N'Product/Add_Page3', N'نمایش صفحه ی افزودن و ویرایش محصولات_گام3', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2037, N'Product/Add_Page4', N'نمایش صفحه ی افزودن و ویرایش محصولات_گام4', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2038, N'Product/Add_Page5', N'نمایش صفحه ی افزودن و ویرایش محصولات_گام5', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2039, N'Product/DropListFiller', N'انتخاب دسته بندی محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2041, N'Product/Options_Table', N'نمایش جدول ویژگی های کلی محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2042, N'Product/Op_delete_edit', N'حذف ، افزودن و ویرایش ویژگی های کلی محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2043, N'Product/UploadPage', N'نمایش صفحه ی آپلود عکس', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2044, N'Product/UploaderIFRAME', N'صفحه ی آپلود عکس', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2045, N'Product/loadGallery', N'نمایش عکس های آپلود شده', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2046, N'Product/UploadEditorResultActions', N'ویرایش عکس ها', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2047, N'Product/GetImageInformation', N' دریافت اطلاعات عکس', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2048, N'Product/Save_Step1', N'افزودن و ویرایش محصولات_گام 1', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2049, N'Product/Save_Step2', N'افزودن و ویرایش محصولات_گام 2', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2050, N'Product/Save_Step3', N'افزودن و ویرایش محصولات_گام 3', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2051, N'Product/Save_Step4', N'افزودن و ویرایش محصولات_گام 4', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2052, N'Product/Save_Step5', N'افزودن و ویرایش محصولات_گام 5', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2053, N'Product/Login', N'ورود به پنل', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2054, N'Product/ShowCatTree', N'نمایش همه ی دسته بندی ها', 1)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2055, N'Product/Update_Product', N'ویرایش محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2056, N'Product/ProductDetails', N'نمایش صفحه ی جزئیات محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2057, N'Product/Product_Actions', N'حذف ، فعال و غیر فعال کردن محصولات', 10)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2058, N'Factor/FactorTable', N'نمایش لیست فاکتور ها', 2002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2059, N'Factor/Factor_Actions', N'حذف کردن فاکتور', 2002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2060, N'Factor/FactorView', N'نمایش جزئیات فاکتور', 2002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2061, N'Factor/ProductSaleList', N'نمایش لیست میزان فروش محصولات', 2002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2062, N'Factor/Customers', N'نمایش لیست مشتریان', 2003)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2063, N'Factor/User_Actions', N'فعال و غیر فعال کردن مشتریان', 2003)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2064, N'Factor/Customer_Profile', N'نمایش پروفایل مشتری', 2003)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2065, N'Factor/Customers_Buy', N'نمایش لیست مجموع پرداختی مشتریان', 2003)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2066, N'BlogMain/NewBlogPost', N'نمایش صفحه ی افزودن پست ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2067, N'BlogMain/Add_Edit_Post', N'افزودن و ویرایش پست ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2068, N'BlogMain/TagFiller', N'انتخاب برچسب ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2069, N'BlogMain/Add_Update_Category', N'افزودن و ویرایش دسته بندی پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2070, N'BlogMain/Add_Blog_Category', N'نمایش صفحه ی دسته بندی پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2072, N'BlogMain/Add_Blog_Group', N'نمایش صفحه ی گروه پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2073, N'BlogMain/Add_Update_Group', N'افزودن و ویرایش گروه پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2074, N'BlogMain/Add_Update_Tags', N'افزودن و ویرایش برچسب پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2075, N'BlogMain/Add_Blog_Group', N'نمایش صفحه ی گروه پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2076, N'BlogMain/Add_Blog_Tags', N'نمایش صفحه ی برچسب پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2077, N'BlogMain/Blog_catTable', N'نمایش جدول دسته بندی پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2078, N'BlogMain/Blog_GroupTable', N'نمایش جدول گروه پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2079, N'BlogMain/Blog_TagTable', N'نمایش جدول برچسب پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2080, N'BlogMain/BlogTag_Actions', N'حذف ، فعال و غیر فعال کردن برچسب پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2081, N'BlogMain/BlogGroup_Actions', N'حذف ، فعال و غیر فعال کردن گروه پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2082, N'BlogMain/BlogCat_Actions', N'حذف ، فعال و غیر فعال کردن دسته بندی پست ها  ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2083, N'BlogMain/PostTable', N'نمایش لیست پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2084, N'BlogMain/Post_Actions', N'حذف ، فعال و غیر فعال کردن پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2085, N'BlogMain/EditPost', N'نمایش صفحه ی ویرایش کردن پست ها ', 1002)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2086, N'Admin/ModalTree', N'نمایش صفحه ی دسترسی ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2087, N'Admin/AdminTbl', N'نمایش جدول انواع ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2088, N'Admin/Add_Update_AdminType', N'افزودن و ویرایش انواع ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2089, N'Admin/Add_Admin', N'نمایش صفحه افزودن ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2090, N'Admin/Save_admin', N'افزودن ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2092, N'Admin/Admin_Actions', N'حذف ، فعال و غیر فعال کردن ادمین ', 11)
INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] ([rulerouteID], [ruleRouteURL], [ruleRouteName], [ruleRouteCatId]) VALUES (2093, N'Admin/ShowAdmins', N'لیست همه ی ادمین ها', 11)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_ruleRoutes_Main] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_types] ON 

INSERT [dbo].[tbl_ADMIN_types] ([ad_typeID], [ad_type_name]) VALUES (1, N'ادمین اصلی')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_types] OFF
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2043, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2044, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2045, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2046, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2047, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2053, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2054, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2002, 1)
GO
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2003, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2004, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2005, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2006, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2007, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2008, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2009, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2010, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2011, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2012, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2013, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2014, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2015, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2016, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2017, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2018, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2019, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2020, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2021, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2027, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2028, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2029, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2030, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2022, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2023, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2024, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2026, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2031, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2032, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2033, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2034, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2035, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2036, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2037, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2038, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2039, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2041, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2042, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2048, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2049, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2050, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2051, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2052, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2055, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2056, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2057, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2086, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2087, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2088, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2089, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2090, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2092, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2093, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2066, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2067, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2068, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2069, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2070, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2072, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2073, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2074, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2075, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2076, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2077, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2078, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2079, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2080, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2081, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2082, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2083, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2084, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2085, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2058, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2059, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2060, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2061, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2062, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2063, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2064, 1)
INSERT [dbo].[tbl_ADMIN_types_ruleRoute_Connection] ([ad_typeID], [rulerouteID], [HasAccess]) VALUES (1, 2065, 1)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] ON 

INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] ([PicCategoryType], [PicCategoryTypeName]) VALUES (1, N'Normal')
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_CategoryPic] OFF
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] ON 

INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] ([picSizeType], [picSizeTypeName], [picSizeTypeWidth], [picSizeTypeHeight]) VALUES (1, N'Regular', 400, 400)
SET IDENTITY_INSERT [dbo].[tbl_ADMIN_UploaderStructure_ImageSize] OFF
SET IDENTITY_INSERT [dbo].[tbl_BLOG_PostType] ON 

INSERT [dbo].[tbl_BLOG_PostType] ([B_TypeId], [B_TypeToken]) VALUES (1, N'بلاگ')
INSERT [dbo].[tbl_BLOG_PostType] ([B_TypeId], [B_TypeToken]) VALUES (2, N'مقاله')
INSERT [dbo].[tbl_BLOG_PostType] ([B_TypeId], [B_TypeToken]) VALUES (3, N'صفحات')
SET IDENTITY_INSERT [dbo].[tbl_BLOG_PostType] OFF
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (100, N'بوشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (101, N'اهرم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (102, N'برازجان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (103, N'تنگستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (104, N'خارک', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (105, N'خورموج', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (106, N'دشتستان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (107, N'دشتی', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (108, N'دیر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (109, N'دیلم', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (110, N'ریشهر', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (111, N'کنگان', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (112, N'گناوه', 7, N'بوشهر')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (113, N'تهران', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (114, N'آسارا', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (115, N'اسلامشهر', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (116, N'اشتهارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (117, N'بومهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (118, N'تجریش', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (119, N'دماوند', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (120, N'رباط کریم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (121, N'رودهن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (122, N'ری', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (123, N'شریف آباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (124, N'شهریار', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (125, N'طالقان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (126, N'فشم', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (127, N'فیروزکوه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (128, N'قدس', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (129, N'قرچک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (130, N'لواسان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (131, N'ملارد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (132, N'نظرآباد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (133, N'هشتگرد', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (134, N'ورامین', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (135, N'پاکدشت', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (136, N'چهاردانگه', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (137, N'کن', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (138, N'کهریزک', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (139, N'گلستان', 8, N'تهران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (140, N'خراسان جنوبی', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (141, N'بیرجند', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (142, N'سرپیشه', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (143, N'نهبندان', 9, N'خراسان جنوبی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (144, N'خراسان رضوی', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (145, N'بردسکن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (146, N'تایباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (147, N'تربت جام', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (148, N'تربت حیدریه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (149, N'خواف', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (150, N'درگز', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (151, N'سبزوار', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (152, N'سرخس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (153, N'طرقبه', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (154, N'فردوس', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (155, N'فریمان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (156, N'قائن', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (157, N'قوچان', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (158, N'مشهد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (159, N'نیشابور', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (160, N'چناران', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (161, N'کاشمهر', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (162, N'کلات', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (163, N'گناباد', 10, N'خراسان رضوی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (164, N'خراسان شمالی', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (165, N'آشخانه', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (166, N'اسفراین', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (167, N'بجنورد', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (168, N'جاجرم', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (169, N'شیروان', 11, N'خراسان شمالی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (170, N'خوزستان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (171, N'آبادان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (172, N'امیدیه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (173, N'اندیمشک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (174, N'اهواز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (175, N'ایذه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (176, N'ایرانشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (177, N'باغ ملک', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (178, N'بندر ماهشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (179, N'بندرامام خمینی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (180, N'بهبهان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (181, N'خرمشهر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (182, N'دزفول', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (183, N'رامهرمز', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (184, N'سوسنگرد', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (185, N'شادگان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (186, N'شوش', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (187, N'شوشتر', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (188, N'لالی', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (189, N'مسجدسلیمان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (190, N'هندیجان', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (191, N'هویزه', 12, N'خوزستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (192, N'زنجان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (193, N'اب بر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (194, N'ابهر', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (195, N'ایجرود', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (196, N'خدابنده', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (197, N'خرمدره', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (198, N'زرین آباد', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (199, N'قیدار', 13, N'زنجان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (200, N'ماهنشان', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (201, N'کارم', 13, N'زنجان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (202, N'سمنان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (203, N'ایوانکی', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (204, N'بسطام', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (205, N'دامغان', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (206, N'شاهرود', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (207, N'گرمسار', 14, N'سمنان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (208, N'سیستان و بلوچستان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (209, N'ایرانشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (210, N'خاش', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (211, N'راسک', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (212, N'زابل', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (213, N'زاهدان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (214, N'سراوان', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (215, N'سرباز', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (216, N'میرجاوه', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (217, N'نیکشهر', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (218, N'چابهار', 15, N'سیستان و بلوچستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (219, N'فارس', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (220, N'آباده', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (221, N'اردکان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (222, N'ارسنجان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (223, N'استهبان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (224, N'اقلید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (225, N'جهرم', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (226, N'حاجی آباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (227, N'خرم بید', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (228, N'داراب', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (229, N'سوریان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (230, N'سپیدان', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (231, N'شیراز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (232, N'صفا شهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (233, N'فراشبند', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (234, N'فسا', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (235, N'فیروزآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (236, N'قیروکارزین', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (237, N'لار', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (238, N'لامرد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (239, N'مرودشت', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (240, N'ممسنی', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (241, N'مهر', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (242, N'نورآباد', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (243, N'نی ریز', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (244, N'کازرون', 16, N'فارس')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (245, N'قزوین', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (246, N'آبیک', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (247, N'بوئین زهرا', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (248, N'تاکستان', 17, N'قزوین')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (249, N'قم', 18, N'قم')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (250, N'لرستان', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (251, N'ازنا', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (252, N'الشتر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (253, N'الیگودرز', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (254, N'بروجرد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (255, N'خرم آباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (256, N'دزفول', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (257, N'دورود', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (258, N'ماهشهر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (259, N'نورآباد', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (260, N'پلدختر', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (261, N'کوهدشت', 19, N'لرستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (262, N'مازندران', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (263, N'آمل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (264, N'بابل', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (265, N'بابلسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (266, N'بلده', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (267, N'بهشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (268, N'تنکابن', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (269, N'جویبار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (270, N'رامسر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (271, N'ساری', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (272, N'سواد کوه', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (273, N'فریدون کنار', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (274, N'قائم شهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (275, N'محمود آباد', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (276, N'نور', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (277, N'نوشهر', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (278, N'نکا', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (279, N'پل سفید', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (280, N'چالوس', 20, N'مازندران')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (281, N'مرکزی', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (282, N'آشتیان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (283, N'اراک', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (284, N'تفرش', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (285, N'خمین', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (286, N'دلیجان', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (287, N'ساوه', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (288, N'سربند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (289, N'شازند', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (290, N'محلات', 21, N'مرکزی')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (291, N'هرمزگان', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (292, N'ابوموسی', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (293, N'انگهران', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (294, N'بستک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (295, N'بندر جاسک', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (296, N'بندر عباس', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (297, N'بندرلنگه', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (298, N'تنب بزرگ', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (299, N'حاجی آباد', 22, N'هرمزگان')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (300, N'دهبا رز', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (301, N'قشم', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (302, N'میناب', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (303, N'کیش', 22, N'هرمزگان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (304, N'همدان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (305, N'اسدآباد', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (306, N'بهار', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (307, N'تویسرکان', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (308, N'رزن', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (309, N'ملایر', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (310, N'نهاوند', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (311, N'کبودراهنگ', 23, N'همدان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (312, N'چهارمحال و بختیاری', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (313, N'اردل', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (314, N'بروجن', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (315, N'سامان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (316, N'شهرکرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (317, N'فارسان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (318, N'لردگان', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (319, N'چلگرد', 24, N'چهارمحال و بختیاری')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (320, N'کردستان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (321, N'بانه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (322, N'بیجار', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (323, N'دیواندره', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (324, N'سقز', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (325, N'سنندج', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (326, N'قروه', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (327, N'مریوان', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (328, N'کامیاران', 25, N'کردستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (329, N'کرمان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (330, N'بابک', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (331, N'بافت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (332, N'بردسیر', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (333, N'بم', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (334, N'جیرفت', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (335, N'راور', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (336, N'رفسنجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (337, N'زرند', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (338, N'سیرجان', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (339, N'قصرشیرین', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (340, N'کهنوج', 26, N'کرمان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (341, N'کرمانشاه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (342, N'اسلام آبا د غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (343, N'جوانرود', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (344, N'سرپل ذهاب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (345, N'سنقر', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (346, N'صحنه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (347, N'هرسین', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (348, N'پاوه', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (349, N'کنگاور', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (350, N'گیلان غرب', 27, N'کرمانشاه')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (351, N'کهکلویه و بویراحمد', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (352, N'دنا', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (353, N'دهدشت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (354, N'دوگنبدان', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (355, N'سی سخت', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (356, N'گچساران', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (357, N'یاسوج', 28, N'کهکلویه و بویراحمد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (358, N'گلستان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (359, N'آزادشهر', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (360, N'آق قلا', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (361, N'بندر گز', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (362, N'ترکمن', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (363, N'رامیان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (364, N'علی آباد کتول', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (365, N'مینودشت', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (366, N'کردکوی', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (367, N'کلاله', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (368, N'گرگان', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (369, N'گنبد کاووس', 29, N'گلستان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (370, N'گیلان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (371, N'آستارا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (372, N'آستانه اشرفیه', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (373, N'املش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (374, N'بندر انزلی', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (375, N'تالش', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (376, N'خشکبیجار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (377, N'خمام', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (378, N'رحیم آباد', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (379, N'رشت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (380, N'رضوان شهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (381, N'رودبار', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (382, N'رودسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (383, N'سنگر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (384, N'سیاهکل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (385, N'شفت', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (386, N'صومعه سرا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (387, N'فومن', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (388, N'لاهیجان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (389, N'لشت نشا', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (390, N'لنگرود', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (391, N'ماسال', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (392, N'ماسوله', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (393, N'منجیل', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (394, N'هشتپر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (395, N'چابکسر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (396, N'کلاچای', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (397, N'کوچصفهان', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (398, N'کیاشهر', 30, N'گیلان')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (399, N'یزد', 31, N'یزد')
GO
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (400, N'ابرکوه', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (401, N'اردکان', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (402, N'اشکذر', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (403, N'بافق', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (404, N'تفت', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (405, N'طبس', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (406, N'مهریز', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (407, N'میبد', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (408, N'هرات', 31, N'یزد')
INSERT [dbo].[tbl_Enum_Shahr] ([ID_Shahr], [Shahr_Name], [Shahr_OstanConnection], [Ostan_name]) VALUES (409, N'*نامشخص*', 32, N'*نامشخص*')
SET IDENTITY_INSERT [dbo].[tbl_Product_MainStarTags] ON 

INSERT [dbo].[tbl_Product_MainStarTags] ([id_MainStarTag], [MST_Description], [MST_Name]) VALUES (1, N'فروش ویژه', N'فروش ویژه')
INSERT [dbo].[tbl_Product_MainStarTags] ([id_MainStarTag], [MST_Description], [MST_Name]) VALUES (2, N'', N'بدون تگ')
SET IDENTITY_INSERT [dbo].[tbl_Product_MainStarTags] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_MoneyType] ON 

INSERT [dbo].[tbl_Product_MoneyType] ([MoneyId], [MoneyTypeName]) VALUES (1, N'ریال')
SET IDENTITY_INSERT [dbo].[tbl_Product_MoneyType] OFF
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (1, N'تخفیف ندارد', N' بدون تخفیف')
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (2, N'%', N'درصدی')
INSERT [dbo].[tbl_Product_OffType] ([OffType], [OffType_Description], [OffType_Symbol]) VALUES (3, N'ثابت', N'مقدار ثابت')
SET IDENTITY_INSERT [dbo].[tbl_Product_PriceShow] ON 

INSERT [dbo].[tbl_Product_PriceShow] ([PriceShowId], [PriceShowformat]) VALUES (1, N'قیمت واحد')
INSERT [dbo].[tbl_Product_PriceShow] ([PriceShowId], [PriceShowformat]) VALUES (1002, N'قیمت واحد ضربدر تعداد محصول ')
SET IDENTITY_INSERT [dbo].[tbl_Product_PriceShow] OFF
SET IDENTITY_INSERT [dbo].[tbl_Product_ProductQuantityType] ON 

INSERT [dbo].[tbl_Product_ProductQuantityType] ([id_PQT], [PQT_Description], [PQT_Demansion], [PQT_Quantom]) VALUES (1, NULL, N'کارتن', 6)
SET IDENTITY_INSERT [dbo].[tbl_Product_ProductQuantityType] OFF
ALTER TABLE [dbo].[tbl_ADMIN_UploaderStructure] ADD  CONSTRAINT [DF_tbl_ADMIN_UploaderStructure_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "tbl_ADMIN_UploadStructure_ImageAddress"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure_ImageSize"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 136
               Right = 466
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_ADMIN_UploaderStructure_CategoryPic"
            Begin Extent = 
               Top = 138
               Left = 254
               Bottom = 234
               Right = 464
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Images'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'v_Images'
GO
