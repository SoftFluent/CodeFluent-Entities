/* CodeFluent Generated Monday, 29 June 2015 17:49. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCustomer]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomerCustomerView' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCustomerCustomerView]
GO

CREATE VIEW [dbo].[vCustomer]
AS
SELECT [Customer].[Customer_Id], [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
    FROM [Customer]
GO

CREATE VIEW [dbo].[vCustomerCustomerView]
AS
SELECT [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
    FROM [Customer]
GO

