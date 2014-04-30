/* CodeFluent Generated Wednesday, 30 April 2014 11:48. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_DeleteRoleUsers]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_DeleteRoleUsers]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_SaveRoleUsers]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_SaveRoleUsers]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_DeleteByUserAndProviderKey]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_DeleteByUserAndProviderKey]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Login_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Login_LoadByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_LoadByName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_LoadByName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Role_LoadRolesUsersByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Role_LoadRolesUsersByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadByEmail]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadByEmail]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadByProviderKey]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadByProviderKey]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadByUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadByUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadUsersRolesByRole]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadUsersRolesByRole]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_DeleteByTypeAndValue]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_DeleteByTypeAndValue]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserClaim_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserClaim_LoadByUser]
GO

CREATE PROCEDURE [dbo].[Login_Delete]
(
 @Login_Id [uniqueidentifier],
 @_rowVersion [rowversion]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
DELETE FROM [Login]
    WHERE (([Login].[Login_Id] = @Login_Id) AND ([Login].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Login_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Login_Save]
(
 @Login_Id [uniqueidentifier],
 @Login_ProviderName [nvarchar] (256),
 @Login_ProviderKey [nvarchar] (256),
 @Login_User_Id [uniqueidentifier],
 @_trackLastWriteUser [nvarchar] (64) = NULL,
 @_rowVersion [rowversion] = NULL
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
IF(@_trackLastWriteUser IS NULL)
BEGIN
    SELECT DISTINCT @_trackLastWriteUser = SYSTEM_USER 
END
IF(@_rowVersion IS NOT NULL)
BEGIN
    UPDATE [Login] SET
     [Login].[Login_ProviderName] = @Login_ProviderName,
     [Login].[Login_ProviderKey] = @Login_ProviderKey,
     [Login].[Login_User_Id] = @Login_User_Id,
     [Login].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Login].[_trackLastWriteTime] = GETDATE()
        WHERE (([Login].[Login_Id] = @Login_Id) AND ([Login].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Login_Save')
        RETURN
    END
    SELECT DISTINCT [Login].[_rowVersion] 
        FROM [Login]
        WHERE ([Login].[Login_Id] = @Login_Id)
END
ELSE
BEGIN
    INSERT INTO [Login] (
        [Login].[Login_Id],
        [Login].[Login_ProviderName],
        [Login].[Login_ProviderKey],
        [Login].[Login_User_Id],
        [Login].[_trackCreationUser],
        [Login].[_trackLastWriteUser])
    VALUES (
        @Login_Id,
        @Login_ProviderName,
        @Login_ProviderKey,
        @Login_User_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Login].[_rowVersion] 
        FROM [Login]
        WHERE ([Login].[Login_Id] = @Login_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Role_Delete]
(
 @Role_Id [uniqueidentifier],
 @_rowVersion [rowversion]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
DELETE FROM [Role_Users_User_Roles]
    WHERE ([Role_Users_User_Roles].[Role_Id] = @Role_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE FROM [Role]
    WHERE (([Role].[Role_Id] = @Role_Id) AND ([Role].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Role_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Role_Save]
(
 @Role_Id [uniqueidentifier],
 @Role_Name [nvarchar] (256),
 @_trackLastWriteUser [nvarchar] (64) = NULL,
 @_rowVersion [rowversion] = NULL
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
IF(@_trackLastWriteUser IS NULL)
BEGIN
    SELECT DISTINCT @_trackLastWriteUser = SYSTEM_USER 
END
IF(@_rowVersion IS NOT NULL)
BEGIN
    UPDATE [Role] SET
     [Role].[Role_Name] = @Role_Name,
     [Role].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Role].[_trackLastWriteTime] = GETDATE()
        WHERE (([Role].[Role_Id] = @Role_Id) AND ([Role].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Role_Save')
        RETURN
    END
    SELECT DISTINCT [Role].[_rowVersion] 
        FROM [Role]
        WHERE ([Role].[Role_Id] = @Role_Id)
END
ELSE
BEGIN
    INSERT INTO [Role] (
        [Role].[Role_Id],
        [Role].[Role_Name],
        [Role].[_trackCreationUser],
        [Role].[_trackLastWriteUser])
    VALUES (
        @Role_Id,
        @Role_Name,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Role].[_rowVersion] 
        FROM [Role]
        WHERE ([Role].[Role_Id] = @Role_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_Delete]
(
 @User_Id [uniqueidentifier],
 @_rowVersion [rowversion]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
DELETE FROM [Role_Users_User_Roles]
    WHERE ([Role_Users_User_Roles].[User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE [UserClaim] FROM [UserClaim]
    INNER JOIN [User] ON ([UserClaim].[UserClaim_User_Id] = [User].[User_Id])
            LEFT OUTER JOIN [UserClaim] [UserClaim$1] ON ([User].[User_Id] = [UserClaim$1].[UserClaim_User_Id])
    WHERE ([User].[User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE [Login] FROM [Login]
    INNER JOIN [User] ON ([Login].[Login_User_Id] = [User].[User_Id])
    WHERE ([User].[User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE FROM [User]
    WHERE (([User].[User_Id] = @User_Id) AND ([User].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'User_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_DeleteRoleUsers]
(
 @Role_Id [uniqueidentifier] = NULL,
 @User_Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
DELETE FROM [Role_Users_User_Roles]
    WHERE (([Role_Users_User_Roles].[User_Id] = @User_Id) AND ([Role_Users_User_Roles].[Role_Id] = @Role_Id))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_Save]
(
 @User_Id [uniqueidentifier],
 @User_UserName [nvarchar] (256),
 @User_CreationDateUTC [datetime],
 @User_Email [nvarchar] (256) = NULL,
 @User_EmailConfirmed [bit],
 @User_PhoneNumber [nvarchar] (256) = NULL,
 @User_PhoneNumberConfirmed [bit],
 @User_Password [nvarchar] (256) = NULL,
 @User_LastPasswordChangeDate [datetime] = NULL,
 @User_FailedPasswordAttemptCount [int],
 @User_FailedPasswordAttemptWindowStart [datetime] = NULL,
 @User_LockoutEnabled [bit],
 @User_LockoutEndDateUtc [datetime] = NULL,
 @User_LastProfileUpdateDate [datetime] = NULL,
 @User_SecurityStamp [nvarchar] (256),
 @User_TwoFactorEnabled [bit],
 @_trackLastWriteUser [nvarchar] (64) = NULL,
 @_rowVersion [rowversion] = NULL
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
IF(@_trackLastWriteUser IS NULL)
BEGIN
    SELECT DISTINCT @_trackLastWriteUser = SYSTEM_USER 
END
IF(@_rowVersion IS NOT NULL)
BEGIN
    UPDATE [User] SET
     [User].[User_UserName] = @User_UserName,
     [User].[User_CreationDateUTC] = @User_CreationDateUTC,
     [User].[User_Email] = @User_Email,
     [User].[User_EmailConfirmed] = @User_EmailConfirmed,
     [User].[User_PhoneNumber] = @User_PhoneNumber,
     [User].[User_PhoneNumberConfirmed] = @User_PhoneNumberConfirmed,
     [User].[User_Password] = @User_Password,
     [User].[User_LastPasswordChangeDate] = @User_LastPasswordChangeDate,
     [User].[User_FailedPasswordAttemptCount] = @User_FailedPasswordAttemptCount,
     [User].[User_FailedPasswordAttemptWindowStart] = @User_FailedPasswordAttemptWindowStart,
     [User].[User_LockoutEnabled] = @User_LockoutEnabled,
     [User].[User_LockoutEndDateUtc] = @User_LockoutEndDateUtc,
     [User].[User_LastProfileUpdateDate] = @User_LastProfileUpdateDate,
     [User].[User_SecurityStamp] = @User_SecurityStamp,
     [User].[User_TwoFactorEnabled] = @User_TwoFactorEnabled,
     [User].[_trackLastWriteUser] = @_trackLastWriteUser,
     [User].[_trackLastWriteTime] = GETDATE()
        WHERE (([User].[User_Id] = @User_Id) AND ([User].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'User_Save')
        RETURN
    END
    SELECT DISTINCT [User].[_rowVersion] 
        FROM [User]
        WHERE ([User].[User_Id] = @User_Id)
END
ELSE
BEGIN
    INSERT INTO [User] (
        [User].[User_Id],
        [User].[User_UserName],
        [User].[User_CreationDateUTC],
        [User].[User_Email],
        [User].[User_EmailConfirmed],
        [User].[User_PhoneNumber],
        [User].[User_PhoneNumberConfirmed],
        [User].[User_Password],
        [User].[User_LastPasswordChangeDate],
        [User].[User_FailedPasswordAttemptCount],
        [User].[User_FailedPasswordAttemptWindowStart],
        [User].[User_LockoutEnabled],
        [User].[User_LockoutEndDateUtc],
        [User].[User_LastProfileUpdateDate],
        [User].[User_SecurityStamp],
        [User].[User_TwoFactorEnabled],
        [User].[_trackCreationUser],
        [User].[_trackLastWriteUser])
    VALUES (
        @User_Id,
        @User_UserName,
        @User_CreationDateUTC,
        @User_Email,
        @User_EmailConfirmed,
        @User_PhoneNumber,
        @User_PhoneNumberConfirmed,
        @User_Password,
        @User_LastPasswordChangeDate,
        @User_FailedPasswordAttemptCount,
        @User_FailedPasswordAttemptWindowStart,
        @User_LockoutEnabled,
        @User_LockoutEndDateUtc,
        @User_LastProfileUpdateDate,
        @User_SecurityStamp,
        @User_TwoFactorEnabled,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [User].[_rowVersion] 
        FROM [User]
        WHERE ([User].[User_Id] = @User_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_SaveRoleUsers]
(
 @Role_Id [uniqueidentifier],
 @User_Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
SELECT DISTINCT TOP 1 [Role_Users_User_Roles].[Role_Id] 
    FROM [Role_Users_User_Roles]
    WHERE (([Role_Users_User_Roles].[User_Id] = @User_Id) AND ([Role_Users_User_Roles].[Role_Id] = @Role_Id))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
IF(@rowcount = 0)
BEGIN
    INSERT INTO [Role_Users_User_Roles] (
        [Role_Users_User_Roles].[Role_Id],
        [Role_Users_User_Roles].[User_Id])
    VALUES (
        @Role_Id,
        @User_Id)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_Delete]
(
 @UserClaim_Id [uniqueidentifier],
 @_rowVersion [rowversion]
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
DELETE FROM [UserClaim]
    WHERE (([UserClaim].[UserClaim_Id] = @UserClaim_Id) AND ([UserClaim].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'UserClaim_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_Save]
(
 @UserClaim_Id [uniqueidentifier],
 @UserClaim_Type [nvarchar] (256),
 @UserClaim_Value [nvarchar] (256) = NULL,
 @UserClaim_ValueType [nvarchar] (256) = NULL,
 @UserClaim_Issuer [nvarchar] (256) = NULL,
 @UserClaim_OriginalIssuer [nvarchar] (256) = NULL,
 @UserClaim_User_Id [uniqueidentifier],
 @_trackLastWriteUser [nvarchar] (64) = NULL,
 @_rowVersion [rowversion] = NULL
)
AS
SET NOCOUNT ON
DECLARE @error int, @rowcount int
DECLARE @tran bit; SELECT @tran = 0
IF @@TRANCOUNT = 0
BEGIN
 SELECT @tran = 1
 BEGIN TRANSACTION
END
IF(@_trackLastWriteUser IS NULL)
BEGIN
    SELECT DISTINCT @_trackLastWriteUser = SYSTEM_USER 
END
IF(@_rowVersion IS NOT NULL)
BEGIN
    UPDATE [UserClaim] SET
     [UserClaim].[UserClaim_Type] = @UserClaim_Type,
     [UserClaim].[UserClaim_Value] = @UserClaim_Value,
     [UserClaim].[UserClaim_ValueType] = @UserClaim_ValueType,
     [UserClaim].[UserClaim_Issuer] = @UserClaim_Issuer,
     [UserClaim].[UserClaim_OriginalIssuer] = @UserClaim_OriginalIssuer,
     [UserClaim].[UserClaim_User_Id] = @UserClaim_User_Id,
     [UserClaim].[_trackLastWriteUser] = @_trackLastWriteUser,
     [UserClaim].[_trackLastWriteTime] = GETDATE()
        WHERE (([UserClaim].[UserClaim_Id] = @UserClaim_Id) AND ([UserClaim].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'UserClaim_Save')
        RETURN
    END
    SELECT DISTINCT [UserClaim].[_rowVersion] 
        FROM [UserClaim]
        WHERE ([UserClaim].[UserClaim_Id] = @UserClaim_Id)
END
ELSE
BEGIN
    INSERT INTO [UserClaim] (
        [UserClaim].[UserClaim_Id],
        [UserClaim].[UserClaim_Type],
        [UserClaim].[UserClaim_Value],
        [UserClaim].[UserClaim_ValueType],
        [UserClaim].[UserClaim_Issuer],
        [UserClaim].[UserClaim_OriginalIssuer],
        [UserClaim].[UserClaim_User_Id],
        [UserClaim].[_trackCreationUser],
        [UserClaim].[_trackLastWriteUser])
    VALUES (
        @UserClaim_Id,
        @UserClaim_Type,
        @UserClaim_Value,
        @UserClaim_ValueType,
        @UserClaim_Issuer,
        @UserClaim_OriginalIssuer,
        @UserClaim_User_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [UserClaim].[_rowVersion] 
        FROM [UserClaim]
        WHERE ([UserClaim].[UserClaim_Id] = @UserClaim_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Login_DeleteByUserAndProviderKey]
(
 @UserId [uniqueidentifier],
 @ProviderKey [nvarchar] (256)
)
AS
SET NOCOUNT ON
DECLARE @deletedcount int
DELETE FROM [Login]
    WHERE (([Login].[Login_User_Id] = @UserId) AND ([Login].[Login_ProviderKey] = @ProviderKey))
SELECT @deletedcount = @@ROWCOUNT

SELECT @deletedcount 
RETURN
GO

CREATE PROCEDURE [dbo].[Login_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Login].[Login_Id], [Login].[Login_ProviderName], [Login].[Login_ProviderKey], [Login].[Login_User_Id], [Login].[_trackLastWriteTime], [Login].[_trackCreationTime], [Login].[_trackLastWriteUser], [Login].[_trackCreationUser], [Login].[_rowVersion] 
    FROM [Login]
    WHERE ([Login].[Login_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Login_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Login].[Login_Id], [Login].[Login_ProviderName], [Login].[Login_ProviderKey], [Login].[Login_User_Id], [Login].[_trackLastWriteTime], [Login].[_trackCreationTime], [Login].[_trackLastWriteUser], [Login].[_trackCreationUser], [Login].[_rowVersion] 
    FROM [Login]

RETURN
GO

CREATE PROCEDURE [dbo].[Login_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Login].[Login_Id], [Login].[Login_ProviderName], [Login].[Login_ProviderKey], [Login].[Login_User_Id], [Login].[_trackLastWriteTime], [Login].[_trackCreationTime], [Login].[_trackLastWriteUser], [Login].[_trackCreationUser], [Login].[_rowVersion] 
    FROM [Login]
    WHERE ([Login].[Login_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Login_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Login].[Login_Id], [Login].[Login_ProviderName], [Login].[Login_ProviderKey], [Login].[Login_User_Id], [Login].[_trackLastWriteTime], [Login].[_trackCreationTime], [Login].[_trackLastWriteUser], [Login].[_trackCreationUser], [Login].[_rowVersion] 
    FROM [Login]
    WHERE ([Login].[Login_User_Id] = @UserId)

RETURN
GO

CREATE PROCEDURE [dbo].[Role_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Role].[Role_Id], [Role].[Role_Name], [Role].[_trackLastWriteTime], [Role].[_trackCreationTime], [Role].[_trackLastWriteUser], [Role].[_trackCreationUser], [Role].[_rowVersion] 
    FROM [Role]
    WHERE ([Role].[Role_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Role_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Role].[Role_Id], [Role].[Role_Name], [Role].[_trackLastWriteTime], [Role].[_trackCreationTime], [Role].[_trackLastWriteUser], [Role].[_trackCreationUser], [Role].[_rowVersion] 
    FROM [Role]

RETURN
GO

CREATE PROCEDURE [dbo].[Role_LoadByName]
(
 @Name [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Role].[Role_Id], [Role].[Role_Name], [Role].[_trackLastWriteTime], [Role].[_trackCreationTime], [Role].[_trackLastWriteUser], [Role].[_trackCreationUser], [Role].[_rowVersion] 
    FROM [Role]
    WHERE ([Role].[Role_Name] = @Name)

RETURN
GO

CREATE PROCEDURE [dbo].[Role_LoadRolesUsersByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Role].[Role_Id], [Role].[Role_Name], [Role].[_trackLastWriteTime], [Role].[_trackCreationTime], [Role].[_trackLastWriteUser], [Role].[_trackCreationUser], [Role].[_rowVersion] 
    FROM [Role]
        LEFT OUTER JOIN [Role_Users_User_Roles] ON ([Role].[Role_Id] = [Role_Users_User_Roles].[Role_Id])
                LEFT OUTER JOIN [User] ON ([Role_Users_User_Roles].[User_Id] = [User].[User_Id])
    WHERE ([Role_Users_User_Roles].[User_Id] = @UserId)

RETURN
GO

CREATE PROCEDURE [dbo].[User_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByEmail]
(
 @Email [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_Email] = @Email)

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByProviderKey]
(
 @providerKey [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
        LEFT OUTER JOIN [Login] ON ([User].[User_Id] = [Login].[Login_User_Id])
    WHERE ([Login].[Login_ProviderKey] = @providerKey)

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByUserName]
(
 @UserName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_UserName] = @UserName)

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadUsersRolesByRole]
(
 @RoleId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_UserName], [User].[User_CreationDateUTC], [User].[User_Email], [User].[User_EmailConfirmed], [User].[User_PhoneNumber], [User].[User_PhoneNumberConfirmed], [User].[User_Password], [User].[User_LastPasswordChangeDate], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_LockoutEnabled], [User].[User_LockoutEndDateUtc], [User].[User_LastProfileUpdateDate], [User].[User_SecurityStamp], [User].[User_TwoFactorEnabled], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
        LEFT OUTER JOIN [Role_Users_User_Roles] ON ([User].[User_Id] = [Role_Users_User_Roles].[User_Id])
                LEFT OUTER JOIN [Role] ON ([Role_Users_User_Roles].[Role_Id] = [Role].[Role_Id])
    WHERE ([Role_Users_User_Roles].[Role_Id] = @RoleId)

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_DeleteByTypeAndValue]
(
 @Type [nvarchar] (256),
 @Value [nvarchar] (256)
)
AS
SET NOCOUNT ON
DECLARE @deletedcount int
DELETE FROM [UserClaim]
    WHERE (([UserClaim].[UserClaim_Type] = @Type) AND ([UserClaim].[UserClaim_Value] = @Value))
SELECT @deletedcount = @@ROWCOUNT

SELECT @deletedcount 
RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_ValueType], [UserClaim].[UserClaim_Issuer], [UserClaim].[UserClaim_OriginalIssuer], [UserClaim].[UserClaim_User_Id], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteUser], [UserClaim].[_trackCreationUser], [UserClaim].[_rowVersion] 
    FROM [UserClaim]
    WHERE ([UserClaim].[UserClaim_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_ValueType], [UserClaim].[UserClaim_Issuer], [UserClaim].[UserClaim_OriginalIssuer], [UserClaim].[UserClaim_User_Id], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteUser], [UserClaim].[_trackCreationUser], [UserClaim].[_rowVersion] 
    FROM [UserClaim]

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_ValueType], [UserClaim].[UserClaim_Issuer], [UserClaim].[UserClaim_OriginalIssuer], [UserClaim].[UserClaim_User_Id], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteUser], [UserClaim].[_trackCreationUser], [UserClaim].[_rowVersion] 
    FROM [UserClaim]
    WHERE ([UserClaim].[UserClaim_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[UserClaim_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserClaim].[UserClaim_Id], [UserClaim].[UserClaim_Type], [UserClaim].[UserClaim_Value], [UserClaim].[UserClaim_ValueType], [UserClaim].[UserClaim_Issuer], [UserClaim].[UserClaim_OriginalIssuer], [UserClaim].[UserClaim_User_Id], [UserClaim].[_trackLastWriteTime], [UserClaim].[_trackCreationTime], [UserClaim].[_trackLastWriteUser], [UserClaim].[_trackCreationUser], [UserClaim].[_rowVersion] 
    FROM [UserClaim]
    WHERE ([UserClaim].[UserClaim_User_Id] = @UserId)

RETURN
GO

