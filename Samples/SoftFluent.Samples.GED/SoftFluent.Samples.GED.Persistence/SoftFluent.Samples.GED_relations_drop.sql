/* CodeFluent Generated Thursday, 08 May 2014 21:28. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
GO
/* no fk for 'FK_Pag_PaD_Doc_Doc', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
GO
/* no fk for 'FK_Usr_Use_Rol_Rol', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
GO
/* no fk for 'FK_Usr_Usr_Use_Use', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
GO
