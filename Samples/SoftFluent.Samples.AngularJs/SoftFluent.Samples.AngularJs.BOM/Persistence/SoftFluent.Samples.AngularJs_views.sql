/* CodeFluent Generated Tuesday, 03 February 2015 11:18. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCustomer' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCustomer]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vOrder' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vOrder]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vProduct' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vProduct]
GO

CREATE VIEW [dbo].[vCustomer]
AS
SELECT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName], [Customer].[Customer_DateOfBirth], [Customer].[Customer_PassportNumber], [Customer].[_rowVersion], [Customer].[_trackCreationTime], [Customer].[_trackLastWriteTime], [Customer].[_trackCreationUser], [Customer].[_trackLastWriteUser] 
    FROM [Customer]
GO

CREATE VIEW [dbo].[vOrder]
AS
SELECT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_rowVersion], [Order].[_trackCreationTime], [Order].[_trackLastWriteTime], [Order].[_trackCreationUser], [Order].[_trackLastWriteUser] 
    FROM [Order]
GO

CREATE VIEW [dbo].[vProduct]
AS
SELECT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Price], [Product].[Product_Star], [Product].[Product_Description], [Product].[_rowVersion], [Product].[_trackCreationTime], [Product].[_trackLastWriteTime], [Product].[_trackCreationUser], [Product].[_trackLastWriteUser] 
    FROM [Product]
GO

