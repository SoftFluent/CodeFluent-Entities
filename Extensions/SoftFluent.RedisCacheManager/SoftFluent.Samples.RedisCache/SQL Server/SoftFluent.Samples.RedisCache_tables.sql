/* CodeFluent Generated Sunday, 16 November 2014 12:44. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Category]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Product]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[CategoryLocalized]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[CategoryLocalized]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Pru_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Pru_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Category]'))
 ALTER TABLE [dbo].[Category] DROP CONSTRAINT [PK_Cat_Cat_Cat]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Pru_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Pru_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cat__tc]') AND parent_obj = object_id(N'[dbo].[Category]'))
 ALTER TABLE [dbo].[Category] DROP CONSTRAINT [DF_Cat__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Pru_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Pru_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cat__tk]') AND parent_obj = object_id(N'[dbo].[Category]'))
 ALTER TABLE [dbo].[Category] DROP CONSTRAINT [DF_Cat__tk]
GO
CREATE TABLE [dbo].[Category] (
 [Category_Id] [uniqueidentifier] NOT NULL,
 [Category_Name] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Cat__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Cat__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Cat_Cat_Cat] PRIMARY KEY NONCLUSTERED
 (

  [Category_Id]
 ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Pro_Pro_Pro', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
/* no fk for 'DF_Pro__tc', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pro__tc]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF_Pro__tc]
GO
/* no fk for 'DF_Pro__tk', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pro__tk]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF_Pro__tk]
GO
CREATE TABLE [dbo].[Product] (
 [Product_Id] [uniqueidentifier] NOT NULL,
 [Product_Name] [nvarchar] (256) NULL,
 [Product_Category_Id] [uniqueidentifier] NULL,
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

/* no fk for 'PK_Cae_Cat_Lci_Cae', tableName='CategoryLocalized' table='CategoryLocalized' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cae_Cat_Lci_Cae]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [PK_Cae_Cat_Lci_Cae]
GO
CREATE TABLE [dbo].[CategoryLocalized] (
 [Category_Id] [uniqueidentifier] NOT NULL,
 [Lcid] [int] NOT NULL,
 [Category_Name] [nvarchar] (256) NULL,
 CONSTRAINT [PK_Cae_Cat_Lci_Cae] PRIMARY KEY NONCLUSTERED
 (

  [Category_Id],
  [Lcid]
 ) ON [PRIMARY]
)
GO

