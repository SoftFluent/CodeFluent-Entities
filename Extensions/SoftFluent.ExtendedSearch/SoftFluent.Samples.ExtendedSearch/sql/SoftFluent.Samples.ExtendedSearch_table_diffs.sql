/* CodeFluent Generated Monday, 29 June 2015 17:49. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
/* no fk for 'PK_Cus_Cus_Cus', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
/* no fk for 'PK_Cus_Cus_Cus', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Cus_Cus_Cus] PRIMARY KEY NONCLUSTERED
(

 [Customer_Id]
 ) ON [PRIMARY]
