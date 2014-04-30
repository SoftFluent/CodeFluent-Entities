/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Add_Add_Add]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [PK_Add_Add_Add]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Add_Add_Add]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [PK_Add_Add_Add]
GO
ALTER TABLE [dbo].[Address] ADD CONSTRAINT [PK_Add_Add_Add] PRIMARY KEY NONCLUSTERED
(

 [Address_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Con_Con_Con]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [PK_Con_Con_Con]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Con_Con_Con]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [PK_Con_Con_Con]
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [PK_Con_Con_Con] PRIMARY KEY NONCLUSTERED
(

 [Contact_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Con_Cot_Con]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [IX_Con_Cot_Con]
GO
ALTER TABLE [dbo].[Contact] ADD CONSTRAINT [IX_Con_Cot_Con] UNIQUE
(

  [Contact_Email] ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cot_Con_Cot]') AND parent_obj = object_id(N'[dbo].[ContactSource]'))
 ALTER TABLE [dbo].[ContactSource] DROP CONSTRAINT [PK_Cot_Con_Cot]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cot_Con_Cot]') AND parent_obj = object_id(N'[dbo].[ContactSource]'))
 ALTER TABLE [dbo].[ContactSource] DROP CONSTRAINT [PK_Cot_Con_Cot]
GO
ALTER TABLE [dbo].[ContactSource] ADD CONSTRAINT [PK_Cot_Con_Cot] PRIMARY KEY NONCLUSTERED
(

 [ContactSource_Id]
 ) ON [PRIMARY]
/* column 'User_Photo', old length:-1, new length: 2147483647*/
ALTER TABLE [dbo].[User] ALTER COLUMN [User_Photo] [varbinary] (max) NULL
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Use_Use_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [PK_Use_Use_Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [PK_Use_Use_Use] PRIMARY KEY NONCLUSTERED
(

 [User_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[IX_Use_Usr_Use]') AND parent_obj = object_id(N'[dbo].[User]'))
 ALTER TABLE [dbo].[User] DROP CONSTRAINT [IX_Use_Usr_Use]
GO
ALTER TABLE [dbo].[User] ADD CONSTRAINT [IX_Use_Usr_Use] UNIQUE
(

  [User_Email] ) ON [PRIMARY]
