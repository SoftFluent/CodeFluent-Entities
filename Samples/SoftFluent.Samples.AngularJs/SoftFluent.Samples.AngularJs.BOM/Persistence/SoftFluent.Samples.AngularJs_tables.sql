/* CodeFluent Generated Tuesday, 03 February 2015 11:18. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Customer]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Order]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Product]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_Products_Product_Orders]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Order_Products_Product_Orders]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cus__tc]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [DF_Cus__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cus__tk]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [DF_Cus__tk]
GO
CREATE TABLE [dbo].[Customer] (
 [Customer_Id] [uniqueidentifier] NOT NULL,
 [Customer_FirstName] [nvarchar] (256) NULL,
 [Customer_LastName] [nvarchar] (256) NULL,
 [Customer_DateOfBirth] [datetime] NULL,
 [Customer_PassportNumber] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Cus__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Cus__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Cus_Cus_Cus] PRIMARY KEY NONCLUSTERED
 (

  [Customer_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [PK_Ord_Ord_Ord]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Ord__tc]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF_Ord__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Ord__tk]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [DF_Ord__tk]
GO
CREATE TABLE [dbo].[Order] (
 [Order_Id] [uniqueidentifier] NOT NULL,
 [Order_Customer_Id] [uniqueidentifier] NULL,
 [Order_Date] [datetime] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Ord__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Ord__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Ord_Ord_Ord] PRIMARY KEY NONCLUSTERED
 (

  [Order_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pro__tc]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF_Pro__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pro__tk]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF_Pro__tk]
GO
CREATE TABLE [dbo].[Product] (
 [Product_Id] [uniqueidentifier] NOT NULL,
 [Product_Name] [nvarchar] (256) NULL,
 [Product_Price] [real] NULL,
 [Product_Star] [int] NULL,
 [Product_Description] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Pro__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Pro__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Pro_Pro_Pro] PRIMARY KEY NONCLUSTERED
 (

  [Product_Id]
 ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Ore_Ord_Pro_Ore', tableName='Order_Products_Product_Orders' table='Order_Products_Product_Orders' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ore_Ord_Pro_Ore]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [PK_Ore_Ord_Pro_Ore]
GO
CREATE TABLE [dbo].[Order_Products_Product_Orders] (
 [Order_Id] [uniqueidentifier] NOT NULL,
 [Product_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Ore_Ord_Pro_Ore] PRIMARY KEY NONCLUSTERED
 (

  [Order_Id],
  [Product_Id]
 ) ON [PRIMARY]
)
GO

