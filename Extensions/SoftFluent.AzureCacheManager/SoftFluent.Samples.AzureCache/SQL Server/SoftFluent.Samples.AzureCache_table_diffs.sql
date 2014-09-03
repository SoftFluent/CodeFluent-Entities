/* CodeFluent Generated Wednesday, 27 August 2014 12:34. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Prc_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Prc_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Category]'))
 ALTER TABLE [dbo].[Category] DROP CONSTRAINT [PK_Cat_Cat_Cat]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Prc_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Prc_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Category]'))
 ALTER TABLE [dbo].[Category] DROP CONSTRAINT [PK_Cat_Cat_Cat]
GO
ALTER TABLE [dbo].[Category] ADD CONSTRAINT [PK_Cat_Cat_Cat] PRIMARY KEY NONCLUSTERED
(

 [Category_Id]
 ) ON [PRIMARY]
/* no fk for 'PK_Pro_Pro_Pro', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
/* no fk for 'PK_Pro_Pro_Pro', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK_Pro_Pro_Pro] PRIMARY KEY NONCLUSTERED
(

 [Product_Id]
 ) ON [PRIMARY]
/* no fk for 'PK_Cae_Cat_Lci_Cae', tableName='CategoryLocalized' table='CategoryLocalized' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cae_Cat_Lci_Cae]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [PK_Cae_Cat_Lci_Cae]
GO
/* no fk for 'PK_Cae_Cat_Lci_Cae', tableName='CategoryLocalized' table='CategoryLocalized' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cae_Cat_Lci_Cae]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [PK_Cae_Cat_Lci_Cae]
GO
ALTER TABLE [dbo].[CategoryLocalized] ADD CONSTRAINT [PK_Cae_Cat_Lci_Cae] PRIMARY KEY NONCLUSTERED
(

 [Category_Id],
 [Lcid]
 ) ON [PRIMARY]
