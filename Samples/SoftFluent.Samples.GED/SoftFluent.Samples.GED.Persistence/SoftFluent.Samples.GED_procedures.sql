/* CodeFluent Generated Thursday, 08 May 2014 20:42. TargetVersion:Sql2012. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_Save]
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadByParent]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadByParent]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadByUserCount]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadByUserCount]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Directory_LoadParentByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Directory_LoadParentByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadByDirectory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadByDirectory]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadByDirectoryUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadByDirectoryUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadByDirectoryUserCount]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadByDirectoryUserCount]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadQueueByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadQueueByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadQueueByUserCount]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadQueueByUserCount]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_LoadTopByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_LoadTopByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_SearchByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_SearchByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Document_SearchByUserCount]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Document_SearchByUserCount]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_LoadByDocument]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_LoadByDocument]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_LoadByDocumentOrdered]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_LoadByDocumentOrdered]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Page_LoadOneToProcess]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Page_LoadOneToProcess]
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_CountInactiveProfiles]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_CountInactiveProfiles]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_CountOnline]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_CountOnline]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_DeleteInactiveProfiles]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_DeleteInactiveProfiles]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_FindByEmail]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_FindByEmail]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_FindByRoleAndUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_FindByRoleAndUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_FindByUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_FindByUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_FindInactiveProfilesByUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_FindInactiveProfilesByUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_FindProfilesByUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_FindProfilesByUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadAllInactiveProfiles]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadAllInactiveProfiles]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadAllProfiles]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadAllProfiles]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadByEmail]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadByEmail]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadByUserName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadByUserName]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_UpdateActivity]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_UpdateActivity]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_LoadByRole]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_LoadByRole]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_LoadByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[UserRole_LoadByUserUserNameAndRoleName]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[UserRole_LoadByUserUserNameAndRoleName]
GO

CREATE PROCEDURE [dbo].[Directory_Delete]
(
 @Directory_Id [uniqueidentifier],
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
UPDATE [Document] SET
 [Document].[Document_Directory_Id] = NULL
    WHERE ([Document].[Document_Directory_Id] = @Directory_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
UPDATE [Directory] SET
 [Directory].[Directory_Parent_Id] = NULL
    WHERE ([Directory].[Directory_Parent_Id] = @Directory_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
DELETE [Directory] FROM [Directory] 
    WHERE (([Directory].[Directory_Id] = @Directory_Id) AND ([Directory].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Directory_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_Save]
(
 @Directory_Id [uniqueidentifier],
 @Directory_Title [nvarchar] (256) = NULL,
 @Directory_User_Id [uniqueidentifier] = NULL,
 @Directory_Parent_Id [uniqueidentifier] = NULL,
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
    UPDATE [Directory] SET
     [Directory].[Directory_Title] = @Directory_Title,
     [Directory].[Directory_User_Id] = @Directory_User_Id,
     [Directory].[Directory_Parent_Id] = @Directory_Parent_Id,
     [Directory].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Directory].[_trackLastWriteTime] = GETDATE()
        WHERE (([Directory].[Directory_Id] = @Directory_Id) AND ([Directory].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Directory_Save')
        RETURN
    END
    SELECT DISTINCT [Directory].[_rowVersion] 
        FROM [Directory] 
        WHERE ([Directory].[Directory_Id] = @Directory_Id)
END
ELSE
BEGIN
    INSERT INTO [Directory] (
        [Directory].[Directory_Id],
        [Directory].[Directory_Title],
        [Directory].[Directory_User_Id],
        [Directory].[Directory_Parent_Id],
        [Directory].[_trackCreationUser],
        [Directory].[_trackLastWriteUser])
    VALUES (
        @Directory_Id,
        @Directory_Title,
        @Directory_User_Id,
        @Directory_Parent_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Directory].[_rowVersion] 
        FROM [Directory] 
        WHERE ([Directory].[Directory_Id] = @Directory_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Document_Delete]
(
 @Document_Id [uniqueidentifier],
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
DELETE [Page] FROM [Page]
    LEFT OUTER JOIN [Document] ON ([Page].[Page_Document_Id] = [Document].[Document_Id])
            LEFT OUTER JOIN [Page] [Page$1] ON ([Document].[Document_Id] = [Page$1].[Page_Document_Id]) 
    WHERE ([Document].[Document_Id] = @Document_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE [Document] FROM [Document] 
    WHERE (([Document].[Document_Id] = @Document_Id) AND ([Document].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Document_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Document_Save]
(
 @Document_Id [uniqueidentifier],
 @Document_Text [nvarchar] (max) = NULL,
 @Document_User_Id [uniqueidentifier] = NULL,
 @Document_Title [nvarchar] (256) = NULL,
 @Document_Directory_Id [uniqueidentifier] = NULL,
 @Document_Reference [nvarchar] (256) = NULL,
 @Document_Token [nvarchar] (256) = NULL,
 @Document_IsProcessed [bit] = NULL,
 @Document_IsReady [bit] = NULL,
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
    UPDATE [Document] SET
     [Document].[Document_Text] = @Document_Text,
     [Document].[Document_User_Id] = @Document_User_Id,
     [Document].[Document_Title] = @Document_Title,
     [Document].[Document_Directory_Id] = @Document_Directory_Id,
     [Document].[Document_Reference] = @Document_Reference,
     [Document].[Document_Token] = @Document_Token,
     [Document].[Document_IsProcessed] = @Document_IsProcessed,
     [Document].[Document_IsReady] = @Document_IsReady,
     [Document].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Document].[_trackLastWriteTime] = GETDATE()
        WHERE (([Document].[Document_Id] = @Document_Id) AND ([Document].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Document_Save')
        RETURN
    END
    SELECT DISTINCT [Document].[_rowVersion] 
        FROM [Document] 
        WHERE ([Document].[Document_Id] = @Document_Id)
END
ELSE
BEGIN
    INSERT INTO [Document] (
        [Document].[Document_Id],
        [Document].[Document_Text],
        [Document].[Document_User_Id],
        [Document].[Document_Title],
        [Document].[Document_Directory_Id],
        [Document].[Document_Reference],
        [Document].[Document_Token],
        [Document].[Document_IsProcessed],
        [Document].[Document_IsReady],
        [Document].[_trackCreationUser],
        [Document].[_trackLastWriteUser])
    VALUES (
        @Document_Id,
        @Document_Text,
        @Document_User_Id,
        @Document_Title,
        @Document_Directory_Id,
        @Document_Reference,
        @Document_Token,
        @Document_IsProcessed,
        @Document_IsReady,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Document].[_rowVersion] 
        FROM [Document] 
        WHERE ([Document].[Document_Id] = @Document_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Page_Delete]
(
 @Page_Id [uniqueidentifier],
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
DELETE [Page] FROM [Page] 
    WHERE (([Page].[Page_Id] = @Page_Id) AND ([Page].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Page_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Page_Save]
(
 @Page_Id [uniqueidentifier],
 @Page_Document_Id [uniqueidentifier] = NULL,
 @Page_Text [nvarchar] (256) = NULL,
 @Page_IsProcessed [bit] = NULL,
 @Page_IsReady [bit] = NULL,
 @Page_Token [nvarchar] (256) = NULL,
 @Page_Order [int] = NULL,
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
    UPDATE [Page] SET
     [Page].[Page_Document_Id] = @Page_Document_Id,
     [Page].[Page_Text] = @Page_Text,
     [Page].[Page_IsProcessed] = @Page_IsProcessed,
     [Page].[Page_IsReady] = @Page_IsReady,
     [Page].[Page_Token] = @Page_Token,
     [Page].[Page_Order] = @Page_Order,
     [Page].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Page].[_trackLastWriteTime] = GETDATE()
        WHERE (([Page].[Page_Id] = @Page_Id) AND ([Page].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Page_Save')
        RETURN
    END
    SELECT DISTINCT [Page].[_rowVersion] 
        FROM [Page] 
        WHERE ([Page].[Page_Id] = @Page_Id)
END
ELSE
BEGIN
    INSERT INTO [Page] (
        [Page].[Page_Id],
        [Page].[Page_Document_Id],
        [Page].[Page_Text],
        [Page].[Page_IsProcessed],
        [Page].[Page_IsReady],
        [Page].[Page_Token],
        [Page].[Page_Order],
        [Page].[_trackCreationUser],
        [Page].[_trackLastWriteUser])
    VALUES (
        @Page_Id,
        @Page_Document_Id,
        @Page_Text,
        @Page_IsProcessed,
        @Page_IsReady,
        @Page_Token,
        @Page_Order,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Page].[_rowVersion] 
        FROM [Page] 
        WHERE ([Page].[Page_Id] = @Page_Id)
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
DELETE [UserRole] FROM [UserRole] 
    WHERE ([UserRole].[UserRole_Role_Id] = @Role_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE [Role] FROM [Role] 
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
DELETE [UserRole] FROM [UserRole] 
    WHERE ([UserRole].[UserRole_User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
UPDATE [Document] SET
 [Document].[Document_User_Id] = NULL
    WHERE ([Document].[Document_User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
UPDATE [Directory] SET
 [Directory].[Directory_User_Id] = NULL
    WHERE ([Directory].[Directory_User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
DELETE [User] FROM [User] 
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

CREATE PROCEDURE [dbo].[User_Save]
(
 @User_Id [uniqueidentifier],
 @User_UserName [nvarchar] (256),
 @User_Email [nvarchar] (256) = NULL,
 @User_FailedPasswordAttemptCount [int] = NULL,
 @User_FailedPasswordAttemptWindowStart [datetime] = NULL,
 @User_IsLockedOut [bit] = NULL,
 @User_LastActivityDate [datetime] = NULL,
 @User_LastLockoutDate [datetime] = NULL,
 @User_LastLoginDate [datetime] = NULL,
 @User_LastPasswordChangeDate [datetime] = NULL,
 @User_Password [nvarchar] (256) = NULL,
 @User_PasswordSalt [nvarchar] (256) = NULL,
 @User_Properties [varbinary] (max) = NULL,
 @User_IsAnonymous [bit],
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
     [User].[User_Email] = @User_Email,
     [User].[User_FailedPasswordAttemptCount] = @User_FailedPasswordAttemptCount,
     [User].[User_FailedPasswordAttemptWindowStart] = @User_FailedPasswordAttemptWindowStart,
     [User].[User_IsLockedOut] = @User_IsLockedOut,
     [User].[User_LastActivityDate] = @User_LastActivityDate,
     [User].[User_LastLockoutDate] = @User_LastLockoutDate,
     [User].[User_LastLoginDate] = @User_LastLoginDate,
     [User].[User_LastPasswordChangeDate] = @User_LastPasswordChangeDate,
     [User].[User_Password] = @User_Password,
     [User].[User_PasswordSalt] = @User_PasswordSalt,
     [User].[User_Properties] = @User_Properties,
     [User].[User_IsAnonymous] = @User_IsAnonymous,
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
        [User].[User_Email],
        [User].[User_FailedPasswordAttemptCount],
        [User].[User_FailedPasswordAttemptWindowStart],
        [User].[User_IsLockedOut],
        [User].[User_LastActivityDate],
        [User].[User_LastLockoutDate],
        [User].[User_LastLoginDate],
        [User].[User_LastPasswordChangeDate],
        [User].[User_Password],
        [User].[User_PasswordSalt],
        [User].[User_Properties],
        [User].[User_IsAnonymous],
        [User].[_trackCreationUser],
        [User].[_trackLastWriteUser])
    VALUES (
        @User_Id,
        @User_UserName,
        @User_Email,
        @User_FailedPasswordAttemptCount,
        @User_FailedPasswordAttemptWindowStart,
        @User_IsLockedOut,
        @User_LastActivityDate,
        @User_LastLockoutDate,
        @User_LastLoginDate,
        @User_LastPasswordChangeDate,
        @User_Password,
        @User_PasswordSalt,
        @User_Properties,
        @User_IsAnonymous,
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

CREATE PROCEDURE [dbo].[UserRole_Delete]
(
 @UserRole_Role_Id [uniqueidentifier],
 @UserRole_User_Id [uniqueidentifier],
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
DELETE [UserRole] FROM [UserRole] 
    WHERE ((([UserRole].[UserRole_Role_Id] = @UserRole_Role_Id) AND ([UserRole].[UserRole_User_Id] = @UserRole_User_Id)) AND ([UserRole].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'UserRole_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_Save]
(
 @UserRole_Role_Id [uniqueidentifier],
 @UserRole_User_Id [uniqueidentifier],
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
    UPDATE [UserRole] SET
     [UserRole].[_trackLastWriteUser] = @_trackLastWriteUser,
     [UserRole].[_trackLastWriteTime] = GETDATE()
        WHERE ((([UserRole].[UserRole_Role_Id] = @UserRole_Role_Id) AND ([UserRole].[UserRole_User_Id] = @UserRole_User_Id)) AND ([UserRole].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'UserRole_Save')
        RETURN
    END
    SELECT DISTINCT [UserRole].[_rowVersion] 
        FROM [UserRole] 
        WHERE (([UserRole].[UserRole_Role_Id] = @UserRole_Role_Id) AND ([UserRole].[UserRole_User_Id] = @UserRole_User_Id))
END
ELSE
BEGIN
    INSERT INTO [UserRole] (
        [UserRole].[UserRole_Role_Id],
        [UserRole].[UserRole_User_Id],
        [UserRole].[_trackCreationUser],
        [UserRole].[_trackLastWriteUser])
    VALUES (
        @UserRole_Role_Id,
        @UserRole_User_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [UserRole].[_rowVersion] 
        FROM [UserRole] 
        WHERE (([UserRole].[UserRole_Role_Id] = @UserRole_Role_Id) AND ([UserRole].[UserRole_User_Id] = @UserRole_User_Id))
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 
    WHERE ([Directory].[Directory_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 
    WHERE ([Directory].[Directory_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadByParent]
(
 @ParentId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 
    WHERE ([Directory].[Directory_Parent_Id] = @ParentId)

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 
    WHERE (([Directory].[Directory_User_Id] = @UserId) OR NOT(([Directory].[Directory_User_Id] IS NOT NULL)))
    ORDER BY [Directory].[Directory_Title] ASC

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadByUserCount]
(
 @UserId [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [Directory] 
    WHERE (([Directory].[Directory_User_Id] = @UserId) OR NOT(([Directory].[Directory_User_Id] IS NOT NULL)))

RETURN
GO

CREATE PROCEDURE [dbo].[Directory_LoadParentByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Directory].[Directory_Id], [Directory].[Directory_Title], [Directory].[Directory_User_Id], [Directory].[Directory_Parent_Id], [Directory].[_trackLastWriteTime], [Directory].[_trackCreationTime], [Directory].[_trackLastWriteUser], [Directory].[_trackCreationUser], [Directory].[_rowVersion] 
    FROM [Directory] 
    WHERE ((([Directory].[Directory_User_Id] = @UserId) OR NOT(([Directory].[Directory_User_Id] IS NOT NULL))) AND NOT(([Directory].[Directory_Parent_Id] IS NOT NULL)))
    ORDER BY [Directory].[Directory_Title] ASC

RETURN
GO

CREATE PROCEDURE [dbo].[Document_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE ([Document].[Document_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadByDirectory]
(
 @DirectoryId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE ([Document].[Document_Directory_Id] = @DirectoryId)

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadByDirectoryUser]
(
 @DirectoryId [uniqueidentifier],
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE (([Document].[Document_Directory_Id] = @DirectoryId) AND ([Document].[Document_User_Id] = @UserId))

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadByDirectoryUserCount]
(
 @DirectoryId [uniqueidentifier],
 @UserId [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [Document] 
    WHERE (([Document].[Document_Directory_Id] = @DirectoryId) AND ([Document].[Document_User_Id] = @UserId))

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE ([Document].[Document_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE ([Document].[Document_User_Id] = @UserId)
    ORDER BY [Document].[Document_Title] ASC

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadQueueByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE (([Document].[Document_User_Id] = @UserId) AND (([Document].[Document_IsProcessed] = 0) AND ([Document].[Document_IsReady] = 1)))

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadQueueByUserCount]
(
 @UserId [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [Document] 
    WHERE (([Document].[Document_User_Id] = @UserId) AND (([Document].[Document_IsProcessed] = 0) AND ([Document].[Document_IsReady] = 1)))

RETURN
GO

CREATE PROCEDURE [dbo].[Document_LoadTopByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT TOP 10 [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE (([Document].[Document_User_Id] = @UserId) AND ([Document].[Document_IsProcessed] = 1))

RETURN
GO

CREATE PROCEDURE [dbo].[Document_SearchByUser]
(
 @UserId [uniqueidentifier] = NULL,
 @s [nvarchar] (256) = NULL,
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
DECLARE @sql nvarchar(max), @paramlist nvarchar(max)

SELECT @sql=
'SELECT DISTINCT [Document].[Document_Id], [Document].[Document_Text], [Document].[Document_User_Id], [Document].[Document_Title], [Document].[Document_Directory_Id], [Document].[Document_Reference], [Document].[Document_Token], [Document].[Document_IsProcessed], [Document].[Document_IsReady], [Document].[_trackLastWriteTime], [Document].[_trackCreationTime], [Document].[_trackLastWriteUser], [Document].[_trackCreationUser], [Document].[_rowVersion] 
    FROM [Document] 
    WHERE (((1 = 1) AND ((1 = 1) AND ([Document].[Document_IsProcessed] = 1))) AND (1 = 1))'
SELECT @paramlist = '@UserId uniqueidentifier, 
    @s nvarchar (256), 
    @_orderBy0 nvarchar (64), 
    @_orderByDirection0 bit'
IF @UserId IS NOT NULL
    SELECT @sql = @sql + ' AND ([Document].[Document_User_Id] = @UserId)'
IF @s IS NOT NULL
    SELECT @sql = @sql + ' AND ([Document].[Document_Text] LIKE ((''%'' + @s) + ''%''))'
SELECT @sql = @sql + ' ORDER BY [Document].[Document_Title] ASC'
EXEC sp_executesql @sql, @paramlist,
    @UserId, 
    @s, 
    @_orderBy0, 
    @_orderByDirection0

RETURN
GO

CREATE PROCEDURE [dbo].[Document_SearchByUserCount]
(
 @UserId [uniqueidentifier],
 @s [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [Document] 
    WHERE (([Document].[Document_User_Id] = @UserId) AND (([Document].[Document_Text] LIKE (('%' + @s) + '%')) AND ([Document].[Document_IsProcessed] = 1)))

RETURN
GO

CREATE PROCEDURE [dbo].[Page_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    WHERE ([Page].[Page_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Page_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    ORDER BY CASE
        WHEN @_orderBy0 = '[Page].[Order]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Order]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Order]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Order]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Token]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Token]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsReady]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsReady]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsProcessed]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsProcessed]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Text]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Text]
    END DESC

RETURN
GO

CREATE PROCEDURE [dbo].[Page_LoadByDocument]
(
 @DocumentId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    WHERE ([Page].[Page_Document_Id] = @DocumentId)
    ORDER BY CASE
        WHEN @_orderBy0 = '[Page].[Order]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Order]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Order]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Order]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Token]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Token]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsReady]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsReady]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsProcessed]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsProcessed]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Text]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Text]
    END DESC

RETURN
GO

CREATE PROCEDURE [dbo].[Page_LoadByDocumentOrdered]
(
 @DocumentId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    WHERE ([Page].[Page_Document_Id] = @DocumentId)
    ORDER BY CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Token]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Token]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Token]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsReady]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsReady]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsReady]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 0 THEN [Page].[Page_IsProcessed]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[IsProcessed]' AND @_orderByDirection0 = 1 THEN [Page].[Page_IsProcessed]
    END DESC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 0 THEN [Page].[Page_Text]
    END ASC,
    CASE
        WHEN @_orderBy0 = '[Page].[Text]' AND @_orderByDirection0 = 1 THEN [Page].[Page_Text]
    END DESC,
    [Page].[Page_Order] ASC

RETURN
GO

CREATE PROCEDURE [dbo].[Page_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    WHERE ([Page].[Page_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Page_LoadOneToProcess]

AS
SET NOCOUNT ON
SELECT DISTINCT [Page].[Page_Id], [Page].[Page_Document_Id], [Page].[Page_Text], [Page].[Page_IsProcessed], [Page].[Page_IsReady], [Page].[Page_Token], [Page].[Page_Order], [Page].[_trackLastWriteTime], [Page].[_trackCreationTime], [Page].[_trackLastWriteUser], [Page].[_trackCreationUser], [Page].[_rowVersion] 
    FROM [Page] 
    WHERE (([Page].[Page_IsProcessed] = 0) AND ([Page].[Page_IsReady] = 1))

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

CREATE PROCEDURE [dbo].[User_CountInactiveProfiles]
(
 @option [int],
 @userInactiveSinceDate [datetime]
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [User] 
    WHERE (([User].[User_LastActivityDate] <= @userInactiveSinceDate) AND ((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0)))))

RETURN
GO

CREATE PROCEDURE [dbo].[User_CountOnline]
(
 @sessionTime [int]
)
AS
SET NOCOUNT ON
SELECT COUNT(*) FROM [User] 
    WHERE DATEDIFF(mi, User_LastActivityDate, GETUTCDATE()) < @sessionTime

RETURN
GO

CREATE PROCEDURE [dbo].[User_DeleteInactiveProfiles]
(
 @option [int],
 @userInactiveSinceDate [datetime]
)
AS
SET NOCOUNT ON
DECLARE @deletedcount int
DELETE [User] FROM [User] 
    WHERE (([User].[User_LastActivityDate] <= @userInactiveSinceDate) AND ((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0)))))
SELECT @deletedcount = @@ROWCOUNT

SELECT @deletedcount 
RETURN
GO

CREATE PROCEDURE [dbo].[User_FindByEmail]
(
 @Email [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ([User].[User_Email] LIKE @Email)

RETURN
GO

CREATE PROCEDURE [dbo].[User_FindByRoleAndUserName]
(
 @roleName [nvarchar] (256),
 @UserName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
        LEFT OUTER JOIN [UserRole] ON ([User].[User_Id] = [UserRole].[UserRole_User_Id])
                INNER JOIN [Role] ON ([UserRole].[UserRole_Role_Id] = [Role].[Role_Id]) 
    WHERE (([User].[User_UserName] LIKE @UserName) AND ([Role].[Role_Name] = @roleName))

RETURN
GO

CREATE PROCEDURE [dbo].[User_FindByUserName]
(
 @UserName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ([User].[User_UserName] LIKE @UserName)

RETURN
GO

CREATE PROCEDURE [dbo].[User_FindInactiveProfilesByUserName]
(
 @option [int],
 @UserName [nvarchar] (256),
 @userInactiveSinceDate [datetime]
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE (([User].[User_LastActivityDate] <= @userInactiveSinceDate) AND (((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0)))) AND ([User].[User_UserName] LIKE @UserName)))

RETURN
GO

CREATE PROCEDURE [dbo].[User_FindProfilesByUserName]
(
 @option [int],
 @UserName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE (((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0)))) AND ([User].[User_UserName] LIKE @UserName))

RETURN
GO

CREATE PROCEDURE [dbo].[User_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
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
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadAllInactiveProfiles]
(
 @option [int],
 @userInactiveSinceDate [datetime]
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE (([User].[User_LastActivityDate] <= @userInactiveSinceDate) AND ((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0)))))

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadAllProfiles]
(
 @option [int]
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ((@option = 2) OR (((@option = 0) AND ([User].[User_IsAnonymous] = 1)) OR ((@option = 1) AND ([User].[User_IsAnonymous] = 0))))

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByEmail]
(
 @Email [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ([User].[User_Email] = @Email)

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByUserName]
(
 @UserName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT [User].[User_Id], [User].[User_UserName], [User].[User_Email], [User].[User_FailedPasswordAttemptCount], [User].[User_FailedPasswordAttemptWindowStart], [User].[User_IsLockedOut], [User].[User_LastActivityDate], [User].[User_LastLockoutDate], [User].[User_LastLoginDate], [User].[User_LastPasswordChangeDate], [User].[User_Password], [User].[User_PasswordSalt], [User].[User_Properties], [User].[User_IsAnonymous], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ([User].[User_UserName] = @UserName)

RETURN
GO

CREATE PROCEDURE [dbo].[User_UpdateActivity]
(
 @Id [uniqueidentifier],
 @LastActivityDate [datetime],
 @LastLoginDate [datetime]
)
AS
SET NOCOUNT ON
UPDATE [User] SET [User_LastActivityDate] = @LastActivityDate, [User_LastLoginDate] = @LastLoginDate WHERE [User_Id] = @Id
RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_Load]
(
 @RoleId [uniqueidentifier],
 @UserId [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteUser], [UserRole].[_trackCreationUser], [UserRole].[_rowVersion] 
    FROM [UserRole] 
    WHERE (([UserRole].[UserRole_Role_Id] = @RoleId) AND ([UserRole].[UserRole_User_Id] = @UserId))

RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteUser], [UserRole].[_trackCreationUser], [UserRole].[_rowVersion] 
    FROM [UserRole] 

RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_LoadByRole]
(
 @RoleId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteUser], [UserRole].[_trackCreationUser], [UserRole].[_rowVersion] 
    FROM [UserRole] 
    WHERE ([UserRole].[UserRole_Role_Id] = @RoleId)

RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteUser], [UserRole].[_trackCreationUser], [UserRole].[_rowVersion] 
    FROM [UserRole] 
    WHERE ([UserRole].[UserRole_User_Id] = @UserId)

RETURN
GO

CREATE PROCEDURE [dbo].[UserRole_LoadByUserUserNameAndRoleName]
(
 @userUserName [nvarchar] (256),
 @roleName [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [UserRole].[UserRole_Role_Id], [UserRole].[UserRole_User_Id], [UserRole].[_trackLastWriteTime], [UserRole].[_trackCreationTime], [UserRole].[_trackLastWriteUser], [UserRole].[_trackCreationUser], [UserRole].[_rowVersion] 
    FROM [UserRole]
        INNER JOIN [User] ON ([UserRole].[UserRole_User_Id] = [User].[User_Id])
        INNER JOIN [Role] ON ([UserRole].[UserRole_Role_Id] = [Role].[Role_Id]) 
    WHERE (([User].[User_UserName] = @userUserName) AND ([Role].[Role_Name] = @roleName))

RETURN
GO

