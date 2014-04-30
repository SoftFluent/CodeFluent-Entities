/* CodeFluent Generated Wednesday, 30 April 2014 16:17. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ExternalLogin]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[ExternalLogin]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Role]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[User]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[UserClaim]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_Users_User_Roles]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Role_Users_User_Roles]
GO

/* no fk for 'PK_Ext_Ext_Ext', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ext_Ext_Ext]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [PK_Ext_Ext_Ext]
GO
/* no fk for 'DF_Ext__tc', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Ext__tc]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [DF_Ext__tc]
GO
/* no fk for 'DF_Ext__tk', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Ext__tk]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [DF_Ext__tk]
GO
CREATE TABLE [dbo].[ExternalLogin] (
 [ExternalLogin_ProviderKey] [nvarchar] (256) NOT NULL,
 [ExternalLogin_ProviderName] [nvarchar] (256) NULL,
 [ExternalLogin_User_Id] [nvarchar] (256) NOT NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Ext__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Ext__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Ext_Ext_Ext] PRIMARY KEY NONCLUSTERED
 (

  [ExternalLogin_ProviderKey]
 ) ON [PRIMARY]
)
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Rol__tc]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF_Rol__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Rol__tk]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [DF_Rol__tk]
GO
CREATE TABLE [dbo].[Role] (
 [Role_Id] [nvarchar] (256) NOT NULL,
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ext_Exr_Use_Use]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [FK_Ext_Exr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usl_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usl_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ext_Exr_Use_Use]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [FK_Ext_Exr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usl_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usl_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tc]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ext_Exr_Use_Use]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [FK_Ext_Exr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usl_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usl_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Use__tk]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [DF_Use__tk]
GO
CREATE TABLE [dbo].[User] (
 [User_Id] [nvarchar] (256) NOT NULL,
 [User_Password] [nvarchar] (256) NULL,
 [User_UserName] [nvarchar] (256) NOT NULL,
 [User_SecurityStamp] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Use__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Use__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Use_Use_Use] PRIMARY KEY NONCLUSTERED
 (

  [User_Id]
 ) ON [PRIMARY],
 CONSTRAINT [IX_Use_Us__Use] UNIQUE
 (

  [User_UserName] ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Usr_Use_Usr', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [PK_Usr_Use_Usr]
GO
/* no fk for 'DF_Usr__tc', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Usr__tc]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [DF_Usr__tc]
GO
/* no fk for 'DF_Usr__tk', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[DF_Usr__tk]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [DF_Usr__tk]
GO
CREATE TABLE [dbo].[UserClaim] (
 [UserClaim_Id] [uniqueidentifier] NOT NULL,
 [UserClaim_Type] [nvarchar] (256) NOT NULL,
 [UserClaim_Value] [nvarchar] (256) NULL,
 [UserClaim_User_Id] [nvarchar] (256) NOT NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Usr__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Usr__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Usr_Use_Usr] PRIMARY KEY NONCLUSTERED
 (

  [UserClaim_Id]
 ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Roe_Rol_Use_Roe', tableName='Role_Users_User_Roles' table='Role_Users_User_Roles' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Roe_Rol_Use_Roe]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [PK_Roe_Rol_Use_Roe]
GO
CREATE TABLE [dbo].[Role_Users_User_Roles] (
 [Role_Id] [nvarchar] (256) NOT NULL,
 [User_Id] [nvarchar] (256) NOT NULL,
 CONSTRAINT [PK_Roe_Rol_Use_Roe] PRIMARY KEY NONCLUSTERED
 (

  [Role_Id],
  [User_Id]
 ) ON [PRIMARY]
)
GO

