/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vContact' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vContact]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUser' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUser]
GO

CREATE VIEW [dbo].[vContact]
AS
SELECT [Contact].[Contact_Id], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_Description], [Contact].[Contact_User_Id], [Contact].[_rowVersion], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationUser], [Contact].[_trackLastWriteUser] 
    FROM [Contact]
GO

CREATE VIEW [dbo].[vUser]
AS
SELECT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_rowVersion], [User].[_trackCreationTime], [User].[_trackLastWriteTime], [User].[_trackCreationUser], [User].[_trackLastWriteUser] 
    FROM [User]
GO

