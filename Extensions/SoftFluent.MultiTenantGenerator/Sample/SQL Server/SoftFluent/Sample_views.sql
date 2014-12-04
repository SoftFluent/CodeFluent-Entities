/* CodeFluent Generated Thursday, 04 December 2014 12:02. TargetVersion:Default. Culture:fr-FR. UiCulture:en-GB. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'SoftFluent')
DROP VIEW [SoftFluent].[vCustomer]
GO

CREATE VIEW [SoftFluent].[vCustomer]
AS
SELECT [SoftFluent].[Customer].[Customer_Id], [SoftFluent].[Customer].[Customer_Name], [SoftFluent].[Customer].[_rowVersion], [SoftFluent].[Customer].[_trackCreationTime], [SoftFluent].[Customer].[_trackLastWriteTime], [SoftFluent].[Customer].[_trackCreationUser], [SoftFluent].[Customer].[_trackLastWriteUser] 
    FROM [SoftFluent].[Customer]
GO

