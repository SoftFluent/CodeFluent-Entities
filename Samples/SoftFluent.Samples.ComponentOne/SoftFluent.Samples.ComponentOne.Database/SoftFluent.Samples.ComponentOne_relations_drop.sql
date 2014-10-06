/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'FK_Con_Co__Use_Use', tableName='Contact' table='Contact' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Con_Co__Use_Use]') AND parent_obj = object_id(N'[dbo].[Contact]'))
 ALTER TABLE [dbo].[Contact] DROP CONSTRAINT [FK_Con_Co__Use_Use]
GO
