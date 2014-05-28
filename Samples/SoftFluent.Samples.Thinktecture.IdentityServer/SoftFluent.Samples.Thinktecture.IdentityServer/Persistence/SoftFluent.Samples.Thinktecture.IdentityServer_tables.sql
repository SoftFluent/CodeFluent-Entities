/* CodeFluent Generated Tuesday, 27 May 2014 10:59. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Login]
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

/* no fk for 'PK_Log_Log_Log', tableName='Login' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Log_Log_Log]') AND parent_obj = object_id(N'[dbo].[Login]'))
 ALTER TABLE [dbo].[Login] DROP CONSTRAINT [PK_Log_Log_Log]
GO
CREATE TABLE [dbo].[Login] (
 [Login_Id] [uniqueidentifier] NOT NULL,
 [Login_ProviderName] [nvarchar] (256) NOT NULL,
 [Login_ProviderKey] [nvarchar] (256) NOT NULL,
 [Login_User_Id] [uniqueidentifier] NOT NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Log__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Log__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Log_Log_Log] PRIMARY KEY NONCLUSTERED
 (

  [Login_Id]
 ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Rol_Rol_Rol', tableName='Role' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
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

/* no fk for 'PK_Use_Use_Use', tableName='User' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
CREATE TABLE [dbo].[User] (
 [User_Id] [uniqueidentifier] NOT NULL,
 [User_UserName] [nvarchar] (256) NOT NULL,
 [User_CreationDateUTC] [datetime] NOT NULL,
 [User_Email] [nvarchar] (256) NULL,
 [User_EmailConfirmed] [bit] NOT NULL,
 [User_PhoneNumber] [nvarchar] (256) NULL,
 [User_PhoneNumberConfirmed] [bit] NOT NULL,
 [User_Password] [nvarchar] (256) NULL,
 [User_LastPasswordChangeDate] [datetime] NULL,
 [User_FailedPasswordAttemptCount] [int] NOT NULL,
 [User_FailedPasswordAttemptWindowStart] [datetime] NULL,
 [User_LockoutEnabled] [bit] NOT NULL,
 [User_LockoutEndDateUtc] [datetime] NULL,
 [User_LastProfileUpdateDate] [datetime] NULL,
 [User_SecurityStamp] [nvarchar] (256) NOT NULL,
 [User_TwoFactorEnabled] [bit] NOT NULL,
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

  [User_UserName] ) ON [PRIMARY]
)
GO

/* no fk for 'PK_Usr_Use_Usr', tableName='UserClaim' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [PK_Usr_Use_Usr]
GO
CREATE TABLE [dbo].[UserClaim] (
 [UserClaim_Id] [uniqueidentifier] NOT NULL,
 [UserClaim_Type] [nvarchar] (256) NOT NULL,
 [UserClaim_Value] [nvarchar] (256) NULL,
 [UserClaim_ValueType] [nvarchar] (256) NULL,
 [UserClaim_Issuer] [nvarchar] (256) NULL,
 [UserClaim_OriginalIssuer] [nvarchar] (256) NULL,
 [UserClaim_User_Id] [uniqueidentifier] NOT NULL,
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

/* no fk for 'PK_Roe_Rol_Use_Roe', tableName='Role_Users_User_Roles' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Roe_Rol_Use_Roe]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [PK_Roe_Rol_Use_Roe]
GO
CREATE TABLE [dbo].[Role_Users_User_Roles] (
 [Role_Id] [uniqueidentifier] NOT NULL,
 [User_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Roe_Rol_Use_Roe] PRIMARY KEY NONCLUSTERED
 (

  [Role_Id],
  [User_Id]
 ) ON [PRIMARY]
)
GO

