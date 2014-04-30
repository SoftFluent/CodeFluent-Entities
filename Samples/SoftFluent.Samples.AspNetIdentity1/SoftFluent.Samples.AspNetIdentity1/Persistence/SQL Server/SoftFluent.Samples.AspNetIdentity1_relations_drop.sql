/* CodeFluent Generated Wednesday, 30 April 2014 16:17. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'FK_Ext_Exr_Use_Use', tableName='ExternalLogin' table='ExternalLogin' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ext_Exr_Use_Use]') AND parent_obj = object_id(N'[dbo].[ExternalLogin]'))
 ALTER TABLE [dbo].[ExternalLogin] DROP CONSTRAINT [FK_Ext_Exr_Use_Use]
GO
/* no fk for 'FK_Usr_Usl_Use_Use', tableName='UserClaim' table='UserClaim' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usl_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usl_Use_Use]
GO
/* no fk for 'FK_Roe_Rol_Rol_Rol', tableName='Role_Users_User_Roles' table='Role_Users_User_Roles' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
GO
/* no fk for 'FK_Roe_Use_Use_Use', tableName='Role_Users_User_Roles' table='Role_Users_User_Roles' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
GO
