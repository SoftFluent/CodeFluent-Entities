/* CodeFluent Generated Sunday, 16 November 2014 12:44. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'FK_Pro_Pru_Cat_Cat', tableName='Product' table='Product' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Pro_Pru_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Pro_Pru_Cat_Cat]
GO
/* no fk for 'FK_Cae_Cat_Cat_Cat', tableName='CategoryLocalized' table='CategoryLocalized' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Cae_Cat_Cat_Cat]') AND parent_obj = object_id(N'[dbo].[CategoryLocalized]'))
 ALTER TABLE [dbo].[CategoryLocalized] DROP CONSTRAINT [FK_Cae_Cat_Cat_Cat]
GO
