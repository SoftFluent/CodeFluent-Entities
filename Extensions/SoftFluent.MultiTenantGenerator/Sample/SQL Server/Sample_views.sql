/* CodeFluent Generated Thursday, 04 December 2014 14:37. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCustomer]
GO

CREATE VIEW [dbo].[vCustomer]
AS
SELECT [Customer].[Customer_Id], [Customer].[Customer_Name], [Customer].[_rowVersion], [Customer].[_trackCreationTime], [Customer].[_trackLastWriteTime], [Customer].[_trackCreationUser], [Customer].[_trackLastWriteUser] 
    FROM [Customer]
GO

