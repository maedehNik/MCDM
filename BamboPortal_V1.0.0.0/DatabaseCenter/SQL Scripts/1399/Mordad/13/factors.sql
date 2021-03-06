USE [_BamBoPortalEditedFullyDatabase]
GO
/****** Object:  Table [dbo].[tbl_Factor_ChildFactor]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_ChildFactor](
	[id_ChildFactor] [int] IDENTITY(1,1) NOT NULL,
	[id_MainFactor] [int] NOT NULL,
	[ChildFactor_DeleteTypeID] [int] NULL,
	[ChildFactor_DeletedByAdminID] [int] NULL,
	[ChildFactor_ISDELETED] [tinyint] NULL,
	[ChildFactor_DeleteDate] [datetime] NULL,
	[ChildFactor_CreateDate] [datetime] NULL,
	[ChildFactor_CreatedByUserTypeID] [int] NULL,
	[ChildFactor_CreatorID] [int] NULL,
	[ChildFactor_ProductModuleType] [int] NULL,
	[ChildFactor_ProductID] [int] NULL,
	[ChildFactor_PastProductHistoryID] [int] NULL,
	[ChildFactor_HasOff] [tinyint] NULL,
	[ChildFactor_OffID] [int] NULL,
	[ChildFactor_OffCode] [nvarchar](max) NULL,
	[ChildFactor_OffPrice] [bigint] NULL,
	[ChildFactor_PurePrice] [bigint] NULL,
	[ChildFactor_PriceAfterOff] [bigint] NULL,
	[ChildFactor_ProductReturnTypeID] [int] NULL,
	[ChildFactor_ISCERTIFIED] [tinyint] NULL,
	[ChildFactor_ISEDITED] [tinyint] NULL,
	[ChildFactor_EditedByAdminID] [int] NULL,
	[ChildFactor_EditDate] [datetime] NULL,
	[ChildFactor_EditedTo_id_ChildFactor] [int] NULL,
 CONSTRAINT [PK_tbl_Factor_ChildFactor] PRIMARY KEY CLUSTERED 
(
	[id_ChildFactor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_ChildFactor_CreatedByUserType]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_ChildFactor_CreatedByUserType](
	[ChildFactor_CreatedByUserTypeID] [int] NULL,
	[ChildFactor_CreatedByUserType] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_ChildFactor_DeleteType]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_ChildFactor_DeleteType](
	[ChildFactor_DeleteTypeID] [int] NULL,
	[ChildFactor_DeleteType] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_ChildFactor_ProductReturnTypeID]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_ChildFactor_ProductReturnTypeID](
	[ChildFactor_ProductReturnTypeID] [int] NOT NULL,
	[ChildFactor_ProductReturnType] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Factor_ChildFactor_ProductReturnTypeID] PRIMARY KEY CLUSTERED 
(
	[ChildFactor_ProductReturnTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_FactorInStock]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_FactorInStock](
	[id_ChildFactor] [int] NOT NULL,
	[FactorInStock_FirstShopID] [int] NULL,
	[FactorInStock_SecondShopID] [int] NULL,
	[FactorInStock_CreatedDate] [datetime] NULL,
	[FactorInStock_TransActionByAdminID] [int] NULL,
	[FactorInStock_HasTransAction] [tinyint] NULL,
	[FactorInStock_TransActionDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_Main]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_Main](
	[id_MainFactor] [int] IDENTITY(1,1) NOT NULL,
	[id_Customer] [int] NULL,
	[MainFactor_CreateDate] [datetime] NULL,
	[MainFactor_Code] [nvarchar](max) NULL,
	[MainFactor_Price] [bigint] NULL,
	[MainFactor_IsPay] [tinyint] NULL,
	[MainFactor_PayMessage] [nvarchar](max) NULL,
	[MainFactor_PaymentCode] [nvarchar](max) NULL,
	[MainFactor_Tax] [bigint] NULL,
	[MainFactor_TotalOff] [bigint] NULL,
	[MainFactor_CreatedByUserType] [int] NULL,
	[MainFactor_CreatorID] [int] NULL,
	[MainFactor_ISEDITED] [int] NULL,
	[MainFactor_EditedDate] [datetime] NULL,
	[MainFactor_EditedByAdminID] [int] NULL,
	[MainFactor_EditedTo_id_MainFactor] [int] NULL,
	[MainFactor_IsDeleted] [tinyint] NULL,
	[MainFactor_IsReturnedMoney] [tinyint] NULL,
	[MainFactor_DeleteDate] [datetime] NULL,
	[MainFactor_MoneyReturnDate] [datetime] NULL,
 CONSTRAINT [PK_tbl_Factor_Main] PRIMARY KEY CLUSTERED 
(
	[id_MainFactor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Factor_PayType]    Script Date: 8/3/2020 1:22:57 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Factor_PayType](
	[id_PayType] [int] NOT NULL,
	[PayType] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_Factor_PayType] PRIMARY KEY CLUSTERED 
(
	[id_PayType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[tbl_Factor_ChildFactor_CreatedByUserType] ([ChildFactor_CreatedByUserTypeID], [ChildFactor_CreatedByUserType]) VALUES (1, N'ادمین')
INSERT [dbo].[tbl_Factor_ChildFactor_CreatedByUserType] ([ChildFactor_CreatedByUserTypeID], [ChildFactor_CreatedByUserType]) VALUES (2, N'مشتری')
INSERT [dbo].[tbl_Factor_ChildFactor_DeleteType] ([ChildFactor_DeleteTypeID], [ChildFactor_DeleteType]) VALUES (1, N'حذف بدلیل عدم موجودی')
INSERT [dbo].[tbl_Factor_ChildFactor_DeleteType] ([ChildFactor_DeleteTypeID], [ChildFactor_DeleteType]) VALUES (2, N'حذف بدلیل درخواست کاربر')
INSERT [dbo].[tbl_Factor_ChildFactor_DeleteType] ([ChildFactor_DeleteTypeID], [ChildFactor_DeleteType]) VALUES (3, N'حذف به درخواست ادمین کل')
INSERT [dbo].[tbl_Factor_ChildFactor_ProductReturnTypeID] ([ChildFactor_ProductReturnTypeID], [ChildFactor_ProductReturnType]) VALUES (1, N'مرجوع به درخواست کاربر')
INSERT [dbo].[tbl_Factor_ChildFactor_ProductReturnTypeID] ([ChildFactor_ProductReturnTypeID], [ChildFactor_ProductReturnType]) VALUES (2, N'مرجوع به صلاحدید ادمین کل')
INSERT [dbo].[tbl_Factor_PayType] ([id_PayType], [PayType]) VALUES (1, N'پرداخت از طریق درگاه')
INSERT [dbo].[tbl_Factor_PayType] ([id_PayType], [PayType]) VALUES (2, N'پرداخت حظوری')
ALTER TABLE [dbo].[tbl_Factor_ChildFactor] ADD  CONSTRAINT [DF_tbl_Factor_ChildFactor_ChildFactor_CreateDate]  DEFAULT (getdate()) FOR [ChildFactor_CreateDate]
GO
ALTER TABLE [dbo].[tbl_Factor_FactorInStock] ADD  CONSTRAINT [DF_tbl_Factor_FactorInStock_FactorInStock_CreatedDate]  DEFAULT (getdate()) FOR [FactorInStock_CreatedDate]
GO
ALTER TABLE [dbo].[tbl_Factor_Main] ADD  CONSTRAINT [DF_tbl_Factor_Main_MainFactor_CreateDate]  DEFAULT (getdate()) FOR [MainFactor_CreateDate]
GO
