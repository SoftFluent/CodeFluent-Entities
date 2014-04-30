/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Address]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Contact]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[ContactSource]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[User]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Add_Add_Add]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [PK_Add_Add_Add]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Add__tc]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF_Add__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Add__tk]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [DF_Add__tk]
GO
CREATE TABLE [dbo].[Address] (
 [Address_Id] [int] IDENTITY (1, 1) NOT NULL,
 [Address_Line1] [nvarchar] (256) NULL,
 [Address_Line2] [nvarchar] (256) NULL,
 [Address_City] [nvarchar] (256) NULL,
 [Address_Zip] [nvarchar] (256) NULL,
 [Address_Country] [nvarchar] (256) NULL,
 [Address_Contact_Id] [int] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Add__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Add__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Add_Add_Add] PRIMARY KEY NONCLUSTERED
 (

  [Address_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Con_Con_Con]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [PK_Con_Con_Con]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Con__tc]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [DF_Con__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Con__tk]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [DF_Con__tk]
GO
CREATE TABLE [dbo].[Contact] (
 [Contact_Id] [int] IDENTITY (1, 1) NOT NULL,
 [Contact_Email] [nvarchar] (256) NOT NULL,
 [Contact_FirstName] [nvarchar] (256) NULL,
 [Contact_LastName] [nvarchar] (256) NULL,
 [Contact_ContactSource_Id] [int] NULL,
 [Contact_Status] [int] NULL,
 [Contact_Address_Id] [int] NULL,
 [Contact_User_Id] [int] NULL,
 [Contact_Description] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Con__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Con__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Con_Con_Con] PRIMARY KEY NONCLUSTERED
 (

  [Contact_Id]
 ) ON [PRIMARY],
 CONSTRAINT [IX_Con_Cot_Con] UNIQUE
 (

  [Contact_Email] ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cot_Con_Cot]') AND parent_obj = object_id(N'[dbo].[ContactSource]'))
 ALTER TABLE [dbo].[ContactSource] DROP CONSTRAINT [PK_Cot_Con_Cot]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cot__tc]') AND parent_obj = object_id(N'[dbo].[ContactSource]'))
 ALTER TABLE [dbo].[ContactSource] DROP CONSTRAINT [DF_Cot__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Cot__tk]') AND parent_obj = object_id(N'[dbo].[ContactSource]'))
 ALTER TABLE [dbo].[ContactSource] DROP CONSTRAINT [DF_Cot__tk]
GO
CREATE TABLE [dbo].[ContactSource] (
 [ContactSource_Id] [int] IDENTITY (1, 1) NOT NULL,
 [ContactSource_Name] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Cot__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Cot__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Cot_Con_Cot] PRIMARY KEY NONCLUSTERED
 (

  [ContactSource_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tc]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tk]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tk]
GO
CREATE TABLE [dbo].[User] (
 [User_Id] [int] IDENTITY (1, 1) NOT NULL,
 [User_Email] [nvarchar] (256) NOT NULL,
 [User_FirstName] [nvarchar] (256) NULL,
 [User_LastName] [nvarchar] (256) NULL,
 [User_Photo] [varbinary] (max) NULL,
 [User_Photo_FileName] [nvarchar] (256) NULL,
 [User_Photo_ContentType] [nvarchar] (128) NULL,
 [User_Photo_Attributes] [int] NULL,
 [User_Photo_Size] [bigint] NULL,
 [User_Photo_LastWriteTimeUtc] [datetime] NULL,
 [User_Photo_LastAccessTimeUtc] [datetime] NULL,
 [User_Photo_CreationTimeUtc] [datetime] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Use__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Use__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Use_Use_Use] PRIMARY KEY NONCLUSTERED
 (

  [User_Id]
 ) ON [PRIMARY],
 CONSTRAINT [IX_Use_Usr_Use] UNIQUE
 (

  [User_Email] ) ON [PRIMARY]
)
GO

