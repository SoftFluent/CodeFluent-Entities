/* CodeFluent Generated Tuesday, 27 May 2014 11:00. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'FK_Log_Lo__Use_Use', tableName='Login' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Log_Lo__Use_Use]') AND parent_obj = object_id(N'[dbo].[Login]'))
 ALTER TABLE [dbo].[Login] DROP CONSTRAINT [FK_Log_Lo__Use_Use]
GO
/* no fk for 'FK_Usr_Usm_Use_Use', tableName='UserClaim' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usm_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserClaim]'))
 ALTER TABLE [dbo].[UserClaim] DROP CONSTRAINT [FK_Usr_Usm_Use_Use]
GO
/* no fk for 'FK_Roe_Rol_Rol_Rol', tableName='Role_Users_User_Roles' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Rol_Rol_Rol]
GO
/* no fk for 'FK_Roe_Use_Use_Use', tableName='Role_Users_User_Roles' table='null' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Roe_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[Role_Users_User_Roles]'))
 ALTER TABLE [dbo].[Role_Users_User_Roles] DROP CONSTRAINT [FK_Roe_Use_Use_Use]
GO
