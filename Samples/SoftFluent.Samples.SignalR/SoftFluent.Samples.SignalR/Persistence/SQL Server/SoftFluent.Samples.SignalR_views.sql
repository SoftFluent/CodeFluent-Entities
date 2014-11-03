/* CodeFluent Generated Monday, 03 November 2014 12:12. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCustomer]
GO

CREATE VIEW [dbo].[vCustomer]
AS
SELECT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName] 
    FROM [Customer]
GO

