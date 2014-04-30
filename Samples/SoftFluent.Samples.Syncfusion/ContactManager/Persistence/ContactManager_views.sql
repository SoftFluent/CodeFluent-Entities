/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vAddress' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vAddress]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vContact' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vContact]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vContactMyView' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vContactMyView]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vContactSource' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vContactSource]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUser' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUser]
GO

CREATE VIEW [dbo].[vAddress]
AS
SELECT [Address].[Address_Id], [Address].[Address_Line1], [Address].[Address_Line2], [Address].[Address_City], [Address].[Address_Zip], [Address].[Address_Country], [Address].[Address_Contact_Id], [Address].[_rowVersion], [Address].[_trackCreationTime], [Address].[_trackLastWriteTime], [Address].[_trackCreationUser], [Address].[_trackLastWriteUser] 
    FROM [Address]
GO

CREATE VIEW [dbo].[vContact]
AS
SELECT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_rowVersion], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationUser], [Contact].[_trackLastWriteUser] 
    FROM [Contact]
GO

CREATE VIEW [dbo].[vContactMyView]
AS
SELECT [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Address].[Address_City] AS 'City', [Contact].[_rowVersion], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationUser], [Contact].[_trackLastWriteUser] 
    FROM [Contact]
        LEFT OUTER JOIN [Address] ON ([Contact].[Contact_Id] = [Address].[Address_Contact_Id])
GO

CREATE VIEW [dbo].[vContactSource]
AS
SELECT [ContactSource].[ContactSource_Id], [ContactSource].[ContactSource_Name], [ContactSource].[_rowVersion], [ContactSource].[_trackCreationTime], [ContactSource].[_trackLastWriteTime], [ContactSource].[_trackCreationUser], [ContactSource].[_trackLastWriteUser] 
    FROM [ContactSource]
GO

CREATE VIEW [dbo].[vUser]
AS
SELECT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_rowVersion], [User].[_trackCreationTime], [User].[_trackLastWriteTime], [User].[_trackCreationUser], [User].[_trackLastWriteUser] 
    FROM [User]
GO

