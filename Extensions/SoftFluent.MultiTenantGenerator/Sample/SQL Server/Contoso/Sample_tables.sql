/* CodeFluent Generated Thursday, 04 December 2014 12:02. TargetVersion:Default. Culture:fr-FR. UiCulture:en-GB. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[Contoso].[Customer]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE [Contoso].[Customer]
GO

/* no fk for 'PK_Cus_Cus_Cus', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[Customer1].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[Customer1].[Customer]'))
 ALTER TABLE [Customer1].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
/* no fk for 'DF_Cus__tc', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[Customer1].[DF_Cus__tc]') AND parent_obj = object_id(N'[Customer1].[Customer]'))
 ALTER TABLE [Customer1].[Customer] DROP CONSTRAINT [DF_Cus__tc]
GO
/* no fk for 'DF_Cus__tk', tableName='Customer' table='Customer' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[Customer1].[DF_Cus__tk]') AND parent_obj = object_id(N'[Customer1].[Customer]'))
 ALTER TABLE [Customer1].[Customer] DROP CONSTRAINT [DF_Cus__tk]
GO
CREATE TABLE [Contoso].[Customer] (
 [Customer_Id] [uniqueidentifier] NOT NULL,
 [Customer_Name] [nvarchar] (256) NULL,
 [_trackLastWriteTime] [datetime] NOT NULL CONSTRAINT [DF_Cus__tc] DEFAULT (GETDATE()),
 [_trackCreationTime] [datetime] NOT NULL CONSTRAINT [DF_Cus__tk] DEFAULT (GETDATE()),
 [_trackLastWriteUser] [nvarchar] (64) NOT NULL,
 [_trackCreationUser] [nvarchar] (64) NOT NULL,
 [_rowVersion] [rowversion] NOT NULL,
 CONSTRAINT [PK_Cus_Cus_Cus] PRIMARY KEY NONCLUSTERED
 (

  [Customer_Id]
 ) ON [PRIMARY]
)
GO

