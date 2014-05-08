/* CodeFluent Generated Thursday, 08 May 2014 21:28. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Directory]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Document]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Page]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Role]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[User]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[UserRole]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Dir_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [PK_Dir_Dir_Dir]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Dir__tc]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [DF_Dir__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Dir__tk]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [DF_Dir__tk]
GO
CREATE TABLE [dbo].[Directory] (
 [Directory_Id] [uniqueidentifier] NOT NULL,
 [Directory_Title] [nvarchar] (256) NULL,
 [Directory_User_Id] [uniqueidentifier] NULL,
 [Directory_Parent_Id] [uniqueidentifier] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Dir__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Dir__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Dir_Dir_Dir] PRIMARY KEY NONCLUSTERED
 (

  [Directory_Id]
 ) ON [PRIMARY],
 CONSTRAINT [IX_Dir_Dir_Dir] UNIQUE
 (

  [Directory_Id] ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Doc_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [PK_Doc_Doc_Doc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Doc__tc]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [DF_Doc__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Doc__tk]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [DF_Doc__tk]
GO
CREATE TABLE [dbo].[Document] (
 [Document_Id] [uniqueidentifier] NOT NULL,
 [Document_Text] [nvarchar] (max) NULL,
 [Document_User_Id] [uniqueidentifier] NULL,
 [Document_Title] [nvarchar] (256) NULL,
 [Document_Directory_Id] [uniqueidentifier] NULL,
 [Document_Reference] [nvarchar] (256) NULL,
 [Document_Token] [nvarchar] (256) NULL,
 [Document_IsProcessed] [bit] NULL,
 [Document_IsReady] [bit] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Doc__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Doc__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Doc_Doc_Doc] PRIMARY KEY NONCLUSTERED
 (

  [Document_Id]
 ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Pag_Pag_Pag', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pag_Pag_Pag]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [PK_Pag_Pag_Pag]
GO
/* no fk for 'DF_Pag__tc', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pag__tc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [DF_Pag__tc]
GO
/* no fk for 'DF_Pag__tk', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Pag__tk]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [DF_Pag__tk]
GO
CREATE TABLE [dbo].[Page] (
 [Page_Id] [uniqueidentifier] NOT NULL,
 [Page_Document_Id] [uniqueidentifier] NULL,
 [Page_Text] [nvarchar] (256) NULL,
 [Page_IsProcessed] [bit] NULL,
 [Page_IsReady] [bit] NULL,
 [Page_Token] [nvarchar] (256) NULL,
 [Page_Order] [int] NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Pag__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Pag__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Pag_Pag_Pag] PRIMARY KEY NONCLUSTERED
 (

  [Page_Id]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Rol__tc]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF_Rol__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Rol__tk]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF_Rol__tk]
GO
CREATE TABLE [dbo].[Role] (
 [Role_Id] [uniqueidentifier] NOT NULL,
 [Role_Name] [nvarchar] (256) NOT NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Rol__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Rol__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Rol_Rol_Rol] PRIMARY KEY NONCLUSTERED
 (

  [Role_Id]
 ) ON [PRIMARY],
 CONSTRAINT [IX_Rol_Roe_Rol] UNIQUE
 (

  [Role_Name] ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tc]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tk]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tk]
GO
CREATE TABLE [dbo].[User] (
 [User_Id] [uniqueidentifier] NOT NULL,
 [User_UserName] [nvarchar] (256) NOT NULL,
 [User_Email] [nvarchar] (256) NULL,
 [User_FailedPasswordAttemptCount] [int] NULL,
 [User_FailedPasswordAttemptWindowStart] [datetime] NULL,
 [User_IsLockedOut] [bit] NULL,
 [User_LastActivityDate] [datetime] NULL,
 [User_LastLockoutDate] [datetime] NULL,
 [User_LastLoginDate] [datetime] NULL,
 [User_LastPasswordChangeDate] [datetime] NULL,
 [User_Password] [nvarchar] (256) NULL,
 [User_PasswordSalt] [nvarchar] (256) NULL,
 [User_Properties] [varbinary] (max) NULL,
 [User_IsAnonymous] [bit] NOT NULL,
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

  [User_UserName] ) ON [PRIMARY],
 CONSTRAINT [IX_Use_Us__Use] UNIQUE
 (

  [User_Email] ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Usr_Use_Usr_Usr', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr_Usr]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [PK_Usr_Use_Usr_Usr]
GO
/* no fk for 'DF_Usr__tc', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Usr__tc]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [DF_Usr__tc]
GO
/* no fk for 'DF_Usr__tk', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Usr__tk]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [DF_Usr__tk]
GO
CREATE TABLE [dbo].[UserRole] (
 [UserRole_Role_Id] [uniqueidentifier] NOT NULL,
 [UserRole_User_Id] [uniqueidentifier] NOT NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Usr__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Usr__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Usr_Use_Usr_Usr] PRIMARY KEY NONCLUSTERED
 (

  [UserRole_Role_Id],
  [UserRole_User_Id]
 ) ON [PRIMARY]
)
GO

