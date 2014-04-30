/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Coo_Con_Cot]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Coo_Con_Cot]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Cor_Add_Add]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Cor_Add_Add]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Add_Ado_Con_Con]') AND parent_obj = object_id(N'[dbo].[Address]'))
 ALTER TABLE [dbo].[Address] DROP CONSTRAINT [FK_Add_Ado_Con_Con]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_CoU_Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_CoU_Use_Use]
GO
