/* CodeFluent Generated Thursday, 08 May 2014 20:42. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
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
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Dir_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [PK_Dir_Dir_Dir]
GO
ALTER TABLE [dbo].[Directory] ADD CONSTRAINT [PK_Dir_Dir_Dir] PRIMARY KEY NONCLUSTERED
(

 [Directory_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dit_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dit_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_DoD_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_DoD_Dir_Dir]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Dir_Dir_Dir]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [IX_Dir_Dir_Dir]
GO
ALTER TABLE [dbo].[Directory] ADD CONSTRAINT [IX_Dir_Dir_Dir] UNIQUE
(

  [Directory_Id] ) ON [PRIMARY]
/* column 'Document_Text', old length:-1, new length: 2147483647*/
ALTER TABLE [dbo].[Document] ALTER COLUMN [Document_Text] [nvarchar] (max) NULL
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Doc_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [PK_Doc_Doc_Doc]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pag_PaD_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [FK_Pag_PaD_Doc_Doc]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Doc_Doc_Doc]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [PK_Doc_Doc_Doc]
GO
ALTER TABLE [dbo].[Document] ADD CONSTRAINT [PK_Doc_Doc_Doc] PRIMARY KEY NONCLUSTERED
(

 [Document_Id]
 ) ON [PRIMARY]
/* no fk for 'PK_Pag_Pag_Pag', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pag_Pag_Pag]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [PK_Pag_Pag_Pag]
GO
/* no fk for 'PK_Pag_Pag_Pag', tableName='Page' table='Page' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pag_Pag_Pag]') AND parent_obj = object_id(N'[dbo].[Page]'))
 ALTER TABLE [dbo].[Page] DROP CONSTRAINT [PK_Pag_Pag_Pag]
GO
ALTER TABLE [dbo].[Page] ADD CONSTRAINT [PK_Pag_Pag_Pag] PRIMARY KEY NONCLUSTERED
(

 [Page_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Rol_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [PK_Rol_Rol_Rol]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [PK_Rol_Rol_Rol] PRIMARY KEY NONCLUSTERED
(

 [Role_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Use_Rol_Rol]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Use_Rol_Rol]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Rol_Roe_Rol]') AND parent_obj = object_id(N'[dbo].[Role]'))
 ALTER TABLE [dbo].[Role] DROP CONSTRAINT [IX_Rol_Roe_Rol]
GO
ALTER TABLE [dbo].[Role] ADD CONSTRAINT [IX_Rol_Roe_Rol] UNIQUE
(

  [Role_Name] ) ON [PRIMARY]
/* column 'User_Properties', old length:-1, new length: 2147483647*/
ALTER TABLE [dbo].[User] ALTER COLUMN [User_Properties] [varbinary] (max) NULL
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
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_Use_Use_Use] PRIMARY KEY NONCLUSTERED
(

 [User_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Use_Usr_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [IX_Use_Usr_Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [IX_Use_Usr_Use] UNIQUE
(

  [User_UserName] ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Dir_Dic_Use_Use]') AND parent_obj = object_id(N'[dbo].[Directory]'))
 ALTER TABLE [dbo].[Directory] DROP CONSTRAINT [FK_Dir_Dic_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Doc_Dos_Use_Use]') AND parent_obj = object_id(N'[dbo].[Document]'))
 ALTER TABLE [dbo].[Document] DROP CONSTRAINT [FK_Doc_Dos_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Usr_Usr_Use_Use]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [FK_Usr_Usr_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Use_Us__Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [IX_Use_Us__Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [IX_Use_Us__Use] UNIQUE
(

  [User_Email] ) ON [PRIMARY]
/* no fk for 'PK_Usr_Use_Usr_Usr', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr_Usr]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [PK_Usr_Use_Usr_Usr]
GO
/* no fk for 'PK_Usr_Use_Usr_Usr', tableName='UserRole' table='UserRole' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Usr_Use_Usr_Usr]') AND parent_obj = object_id(N'[dbo].[UserRole]'))
 ALTER TABLE [dbo].[UserRole] DROP CONSTRAINT [PK_Usr_Use_Usr_Usr]
GO
ALTER TABLE [dbo].[UserRole] ADD CONSTRAINT [PK_Usr_Use_Usr_Usr] PRIMARY KEY NONCLUSTERED
(

 [UserRole_Role_Id],
 [UserRole_User_Id]
 ) ON [PRIMARY]
