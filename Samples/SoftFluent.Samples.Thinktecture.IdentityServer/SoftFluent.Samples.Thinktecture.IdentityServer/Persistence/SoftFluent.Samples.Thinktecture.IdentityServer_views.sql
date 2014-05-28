/* CodeFluent Generated Tuesday, 27 May 2014 11:00. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_NAME = 'vLogin' AND TABLE_SCHEMA = 'dbo')
DROP VIEW [dbo].[vLogin]
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

CREATE VIEW [dbo].[vLogin]
AS
SELECT [Login].[Login_Id], [Login].[Login_ProviderName], [Login].[Login_ProviderKey], [Login].[Login_User_Id], [Login].[_rowVersion], [Login].[_trackCreationTime], [Login].[_trackLastWriteTime], [Login].[_trackCreationUser], [Login].[_trackLastWriteUser] 
    FROM [Login]
GO

CREATE VIEW [dbo].[vRole]
AS
SELECT [Role].[Role_Id], [Role].[Role_Name], [Role].[_rowVersion], [Role].[_trackCreationTime], [Role].[_trackLastWriteTime], [Role].[_trackCreationUser], [Role].[_trackLastWriteUser] 
    FROM [Role]
GO

CREATE VIEW [dbo].[vUser]
AS
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_rowVersion], [User].[_trackCreationTime], [User].[_trackLastWriteTime], [User].[_trackCreationUser], [User].[_trackLastWriteUser] 
    FROM [User]
GO

CREATE VIEW [dbo].[vUserClaim]
AS
SELECT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_ValueType], [UserClaim].[UserClaim_Issuer], [UserClaim].[UserClaim_OriginalIssuer], [UserClaim].[UserClaim_User_Id], [UserClaim].[_rowVersion], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationUser], [UserClaim].[_trackLastWriteUser] 
    FROM [UserClaim]
GO

