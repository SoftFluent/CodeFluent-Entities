/* CodeFluent Generated Wednesday, 27 August 2014 12:34. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCategory' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCategory]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vCategoryLocalized' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vCategoryLocalized]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vProduct' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vProduct]
GO

CREATE VIEW [dbo].[vCategory]
AS
SELECT [Category].[Category_Id], [Category].[Category_Name], [Category].[_rowVersion], [Category].[_trackCreationTime], [Category].[_trackLastWriteTime], [Category].[_trackCreationUser], [Category].[_trackLastWriteUser] 
    FROM [Category]
GO

CREATE VIEW [dbo].[vCategoryLocalized]
AS
SELECT [Category].[Category_Id], 'Category_Name' = CASE WHEN ([CategoryLocalized].[Category_Name] IS NULL) THEN [Category].[Category_Name] ELSE [CategoryLocalized].[Category_Name] END, 'Lcid' = CASE WHEN ([CategoryLocalized].[Lcid] IS NULL) THEN 65536 ELSE [CategoryLocalized].[Lcid] END, [Category].[_rowVersion], [Category].[_trackCreationTime], [Category].[_trackLastWriteTime], [Category].[_trackCreationUser], [Category].[_trackLastWriteUser] 
    FROM [CategoryLocalized]
        RIGHT OUTER JOIN [Category] ON ([CategoryLocalized].[Category_Id] = [Category].[Category_Id])
UNION ALL
SELECT [Category].[Category_Id], [Category].[Category_Name], 65536, [Category].[_rowVersion], [Category].[_trackCreationTime], [Category].[_trackLastWriteTime], [Category].[_trackCreationUser], [Category].[_trackLastWriteUser] 
    FROM [CategoryLocalized]
        INNER JOIN [Category] ON ([CategoryLocalized].[Category_Id] = [Category].[Category_Id])
GO

CREATE VIEW [dbo].[vProduct]
AS
SELECT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Description], [Product].[Product_Category_Id], [Product].[_rowVersion], [Product].[_trackCreationTime], [Product].[_trackLastWriteTime], [Product].[_trackCreationUser], [Product].[_trackLastWriteUser] 
    FROM [Product]
GO

