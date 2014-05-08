/* CodeFluent Generated Thursday, 08 May 2014 21:28. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vDirectory' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vDirectory]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vDocument' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vDocument]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vPage' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vPage]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vRole' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vRole]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUser' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUser]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUserRole' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUserRole]
GO

CREATE VIEW [dbo].[vDirectory]
AS
SELECT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_rowVersion], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationUser], [Directory].[_trackLastWriteUser] 
    FROM [Directory]
GO

CREATE VIEW [dbo].[vDocument]
AS
SELECT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_rowVersion], [Document].[_trackCreationTime], [Document].[_trackLastWriteTime], [Document].[_trackCreationUser], [Document].[_trackLastWriteUser] 
    FROM [Document]
GO

CREATE VIEW [dbo].[vPage]
AS
SELECT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_rowVersion], [Page].[_trackCreationTime], [Page].[_trackLastWriteTime], [Page].[_trackCreationUser], [Page].[_trackLastWriteUser] 
    FROM [Page]
GO

CREATE VIEW [dbo].[vRole]
AS
SELECT [Role].[Role_Id], [Role].[Role_Name], [Role].[_rowVersion], [Role].[_trackCreationTime], [Role].[_trackLastWriteTime], [Role].[_trackCreationUser], [Role].[_trackLastWriteUser] 
    FROM [Role]
GO

CREATE VIEW [dbo].[vUser]
AS
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_rowVersion], [User].[_trackCreationTime], [User].[_trackLastWriteTime], [User].[_trackCreationUser], [User].[_trackLastWriteUser] 
    FROM [User]
GO

CREATE VIEW [dbo].[vUserRole]
AS
SELECT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_rowVersion], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationUser], [UserRole].[_trackLastWriteUser] 
    FROM [UserRole]
GO

