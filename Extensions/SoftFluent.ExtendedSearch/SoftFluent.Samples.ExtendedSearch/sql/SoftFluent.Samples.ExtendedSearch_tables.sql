/* CodeFluent Generated Tuesday, 30 June 2015 10:23. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [dbo].[Customer]
GO

/* no fk for 'PK_Cus_Cus_Cus', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
CREATE TABLE [dbo].[Customer] (
 [Customer_Id] [int] IDENTITY (1, 1) NOT NULL,
 [Customer_FullName] [nvarchar] (256) NULL,
 [Customer_DateOfBirth] [datetime] NULL,
 CONSTRAINT [PK_Cus_Cus_Cus] PRIMARY KEY NONCLUSTERED
 (

  [Customer_Id]
 ) ON [PRIMARY]
)
GO

