/* CodeFluent Generated Wednesday, 30 April 2014 16:17. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'PK_Ext_Ext_Ext', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ext_Ext_Ext]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [PK_Ext_Ext_Ext]
GO
/* no fk for 'PK_Ext_Ext_Ext', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ext_Ext_Ext]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [PK_Ext_Ext_Ext]
GO
ALTER TABLE [dbo].[ExternalLogin] ADD CONSTRAINT [PK_Ext_Ext_Ext] PRIMARY KEY NONCLUSTERED
(

 [ExternalLogin_ProviderKey]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [PK_Rol_Rol_Rol] PRIMARY KEY NONCLUSTERED
(

 [Role_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Rol_Roe_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [IX_Rol_Roe_Rol]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [IX_Rol_Roe_Rol] UNIQUE
(

  [Role_Name] ) ON [PRIMARY]
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
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_Use_Use_Use] PRIMARY KEY NONCLUSTERED
(

 [User_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ext_Exr_Use_Use]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [FK_Ext_Exr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usl_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usl_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Use_Us__Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [IX_Use_Us__Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [IX_Use_Us__Use] UNIQUE
(

  [User_UserName] ) ON [PRIMARY]
/* no fk for 'PK_Usr_Use_Usr', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [PK_Usr_Use_Usr]
GO
/* no fk for 'PK_Usr_Use_Usr', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [PK_Usr_Use_Usr]
GO
ALTER TABLE [dbo].[UserClaim] ADD CONSTRAINT [PK_Usr_Use_Usr] PRIMARY KEY NONCLUSTERED
(

 [UserClaim_Id]
 ) ON [PRIMARY]
/* no fk for 'PK_Roe_Rol_Use_Roe', tableName='Role_Users_User_Roles' table='Role_Users_User_Roles' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Roe_Rol_Use_Roe]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [PK_Roe_Rol_Use_Roe]
GO
/* no fk for 'PK_Roe_Rol_Use_Roe', tableName='Role_Users_User_Roles' table='Role_Users_User_Roles' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Roe_Rol_Use_Roe]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [PK_Roe_Rol_Use_Roe]
GO
ALTER TABLE [dbo].[Role_Users_User_Roles] ADD CONSTRAINT [PK_Roe_Rol_Use_Roe] PRIMARY KEY NONCLUSTERED
(

 [Role_Id],
 [User_Id]
 ) ON [PRIMARY]
