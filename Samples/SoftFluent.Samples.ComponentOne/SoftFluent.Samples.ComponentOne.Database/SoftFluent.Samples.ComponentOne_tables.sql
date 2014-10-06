/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Contact]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[User]
GO

/* no fk for 'PK_Con_Con_Con', tableName='Contact' table='Contact' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Con_Con_Con]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [PK_Con_Con_Con]
GO
/* no fk for 'DF_Con__tc', tableName='Contact' table='Contact' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Con__tc]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [DF_Con__tc]
GO
/* no fk for 'DF_Con__tk', tableName='Contact' table='Contact' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Con__tk]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [DF_Con__tk]
GO
CREATE TABLE [dbo].[Contact] (
 [Contact_Id] [uniqueidentifier] NOT NULL,
 [Contact_FirstName] [nvarchar] (256) NULL,
 [Contact_LastName] [nvarchar] (256) NULL,
 [Contact_Description] [nvarchar] (256) NULL,
 [Contact_User_Id] [uniqueidentifier] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Con__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Con__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Con_Con_Con] PRIMARY KEY NONCLUSTERED
 (

  [Contact_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Co__Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Co__Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Co__Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Co__Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tc]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Co__Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Co__Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tk]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tk]
GO
CREATE TABLE [dbo].[User] (
 [User_Id] [uniqueidentifier] NOT NULL,
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

