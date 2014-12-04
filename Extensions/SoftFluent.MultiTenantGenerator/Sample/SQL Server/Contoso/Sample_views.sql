/* CodeFluent Generated Thursday, 04 December 2014 12:02. TargetVersion:Default. Culture:fr-FR. UiCulture:en-GB. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'Contoso')
DROP VIEW [Contoso].[vCustomer]
GO

CREATE VIEW [Contoso].[vCustomer]
AS
SELECT [Contoso].[Customer].[Customer_Id], [Contoso].[Customer].[Customer_Name], [Contoso].[Customer].[_rowVersion], [Contoso].[Customer].[_trackCreationTime], [Contoso].[Customer].[_trackLastWriteTime], [Contoso].[Customer].[_trackCreationUser], [Contoso].[Customer].[_trackLastWriteUser] 
    FROM [Contoso].[Customer]
GO

