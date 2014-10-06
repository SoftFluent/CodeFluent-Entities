/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_LoadBlobUser_Photo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_LoadBlobUser_Photo]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_SaveBlobChunkUser_Photo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_SaveBlobChunkUser_Photo]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_SaveBlobUser_Photo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_SaveBlobUser_Photo]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadByUser]
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

CREATE PROCEDURE [dbo].[Contact_Delete]
(
 @Contact_Id [uniqueidentifier],
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
DELETE FROM [Contact]
    WHERE (([Contact].[Contact_Id] = @Contact_Id) AND ([Contact].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Contact_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_Save]
(
 @Contact_Id [uniqueidentifier],
 @Contact_FirstName [nvarchar] (256) = NULL,
 @Contact_LastName [nvarchar] (256) = NULL,
 @Contact_Description [nvarchar] (256) = NULL,
 @Contact_User_Id [uniqueidentifier] = NULL,
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
    UPDATE [Contact] SET
     [Contact].[Contact_FirstName] = @Contact_FirstName,
     [Contact].[Contact_LastName] = @Contact_LastName,
     [Contact].[Contact_Description] = @Contact_Description,
     [Contact].[Contact_User_Id] = @Contact_User_Id,
     [Contact].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Contact].[_trackLastWriteTime] = GETDATE()
        WHERE (([Contact].[Contact_Id] = @Contact_Id) AND ([Contact].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Contact_Save')
        RETURN
    END
    SELECT DISTINCT [Contact].[_rowVersion] 
        FROM [Contact]
        WHERE ([Contact].[Contact_Id] = @Contact_Id)
END
ELSE
BEGIN
    INSERT INTO [Contact] (
        [Contact].[Contact_Id],
        [Contact].[Contact_FirstName],
        [Contact].[Contact_LastName],
        [Contact].[Contact_Description],
        [Contact].[Contact_User_Id],
        [Contact].[_trackCreationUser],
        [Contact].[_trackLastWriteUser])
    VALUES (
        @Contact_Id,
        @Contact_FirstName,
        @Contact_LastName,
        @Contact_Description,
        @Contact_User_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Contact].[_rowVersion] 
        FROM [Contact]
        WHERE ([Contact].[Contact_Id] = @Contact_Id)
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
DELETE [Contact] FROM [Contact]
    LEFT OUTER JOIN [User] ON ([Contact].[Contact_User_Id] = [User].[User_Id])
            LEFT OUTER JOIN [Contact] [Contact$1] ON ([User].[User_Id] = [Contact$1].[Contact_User_Id])
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

CREATE PROCEDURE [dbo].[User_LoadBlobUser_Photo]
(
 @User_Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT [User].[User_Photo] 
    FROM [User]
    WHERE ([User].[User_Id] = @User_Id)

RETURN
GO

CREATE PROCEDURE [dbo].[User_Save]
(
 @User_Id [uniqueidentifier],
 @User_Email [nvarchar] (256),
 @User_FirstName [nvarchar] (256) = NULL,
 @User_LastName [nvarchar] (256) = NULL,
 @User_Photo_FileName [nvarchar] (256) = NULL,
 @User_Photo_ContentType [nvarchar] (128) = NULL,
 @User_Photo_Attributes [int] = NULL,
 @User_Photo_Size [bigint] = NULL,
 @User_Photo_LastWriteTimeUtc [datetime] = NULL,
 @User_Photo_LastAccessTimeUtc [datetime] = NULL,
 @User_Photo_CreationTimeUtc [datetime] = NULL,
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
     [User].[User_Email] = @User_Email,
     [User].[User_FirstName] = @User_FirstName,
     [User].[User_LastName] = @User_LastName,
     [User].[User_Photo_FileName] = @User_Photo_FileName,
     [User].[User_Photo_ContentType] = @User_Photo_ContentType,
     [User].[User_Photo_Attributes] = @User_Photo_Attributes,
     [User].[User_Photo_Size] = @User_Photo_Size,
     [User].[User_Photo_LastWriteTimeUtc] = @User_Photo_LastWriteTimeUtc,
     [User].[User_Photo_LastAccessTimeUtc] = @User_Photo_LastAccessTimeUtc,
     [User].[User_Photo_CreationTimeUtc] = @User_Photo_CreationTimeUtc,
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
        [User].[User_Email],
        [User].[User_FirstName],
        [User].[User_LastName],
        [User].[User_Photo_FileName],
        [User].[User_Photo_ContentType],
        [User].[User_Photo_Attributes],
        [User].[User_Photo_Size],
        [User].[User_Photo_LastWriteTimeUtc],
        [User].[User_Photo_LastAccessTimeUtc],
        [User].[User_Photo_CreationTimeUtc],
        [User].[_trackCreationUser],
        [User].[_trackLastWriteUser])
    VALUES (
        @User_Id,
        @User_Email,
        @User_FirstName,
        @User_LastName,
        @User_Photo_FileName,
        @User_Photo_ContentType,
        @User_Photo_Attributes,
        @User_Photo_Size,
        @User_Photo_LastWriteTimeUtc,
        @User_Photo_LastAccessTimeUtc,
        @User_Photo_CreationTimeUtc,
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

CREATE PROCEDURE [dbo].[User_SaveBlobChunkUser_Photo]
(
 @User_Id [uniqueidentifier],
 @Pointer [binary] (16) = NULL OUTPUT,
 @Offset [int],
 @Bytes [varbinary] (max)
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
IF(@Pointer IS NULL)
BEGIN
    UPDATE [User] SET
     [User].[User_Photo] = 0x
        WHERE ([User].[User_Id] = @User_Id)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        INSERT INTO [User] (
            [User].[User_Id],
            [User].[User_Photo])
        VALUES (
            @User_Id,
            0x)
        SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
        IF(@error != 0)
        BEGIN
            IF @tran = 1 ROLLBACK TRANSACTION
            RETURN
        END
    END
    SELECT @Pointer = 0
END
UPDATE [User] SET [User_Photo].WRITE(@Bytes, NULL, NULL)
    WHERE ([User].[User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
SELECT DISTINCT [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_Id] = @User_Id)
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_SaveBlobUser_Photo]
(
 @User_Id [uniqueidentifier],
 @User_Photo [varbinary] (max) = NULL
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
UPDATE [User] SET
 [User].[User_Photo] = @User_Photo
    WHERE ([User].[User_Id] = @User_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
SELECT DISTINCT [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_Id] = @User_Id)
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_Description], [Contact].[Contact_User_Id], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact]
    WHERE ([Contact].[Contact_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_Description], [Contact].[Contact_User_Id], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact]

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_Description], [Contact].[Contact_User_Id], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact]
    WHERE ([Contact].[Contact_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadByUser]
(
 @UserId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_Description], [Contact].[Contact_User_Id], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact]
    WHERE ([Contact].[Contact_User_Id] = @UserId)

RETURN
GO

CREATE PROCEDURE [dbo].[User_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
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
SELECT DISTINCT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]

RETURN
GO

CREATE PROCEDURE [dbo].[User_LoadByEmail]
(
 @Email [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User]
    WHERE ([User].[User_Email] = @Email)

RETURN
GO

