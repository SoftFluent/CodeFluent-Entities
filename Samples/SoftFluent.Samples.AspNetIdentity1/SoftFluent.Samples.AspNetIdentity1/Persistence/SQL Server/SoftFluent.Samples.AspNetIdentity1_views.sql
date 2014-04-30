/* CodeFluent Generated Wednesday, 30 April 2014 16:17. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vExternalLogin' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vExternalLogin]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vRole' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vRole]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUser' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUser]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vUserClaim' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vUserClaim]
GO

CREATE VIEW [dbo].[vExternalLogin]
AS
SELECT [ExternalLogin].[ExternalLogin_ProviderKey], [ExternalLogin].[ExternalLogin_ProviderName], [ExternalLogin].[ExternalLogin_User_Id], [ExternalLogin].[_rowVersion], [ExternalLogin].[_trackCreationTime], [ExternalLogin].[_trackLastWriteTime], [ExternalLogin].[_trackCreationUser], [ExternalLogin].[_trackLastWriteUser] 
    FROM [ExternalLogin]
GO

CREATE VIEW [dbo].[vRole]
AS
SELECT [Role].[Role_Id], [Role].[Role_Name], [Role].[_rowVersion], [Role].[_trackCreationTime], [Role].[_trackLastWriteTime], [Role].[_trackCreationUser], [Role].[_trackLastWriteUser] 
    FROM [Role]
GO

CREATE VIEW [dbo].[vUser]
AS
SELECT [User].[User_Id], [User].[User_Password], [User].[User_UserName], [User].[User_SecurityStamp], [User].[_rowVersion], [User].[_trackCreationTime], [User].[_trackLastWriteTime], [User].[_trackCreationUser], [User].[_trackLastWriteUser] 
    FROM [User]
GO

CREATE VIEW [dbo].[vUserClaim]
AS
SELECT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_User_Id], [UserClaim].[_rowVersion], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationUser], [UserClaim].[_trackLastWriteUser] 
    FROM [UserClaim]
GO

