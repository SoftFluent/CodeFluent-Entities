/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Address_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Address_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ContactSource_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ContactSource_Save]
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Address_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Address_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Address_LoadByContact]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Address_LoadByContact]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadByAddress]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadByAddress]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadByContactSource]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadByContactSource]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadByEmail]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadByEmail]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Contact_LoadByUser]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Contact_LoadByUser]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ContactSource_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ContactSource_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[ContactSource_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[ContactSource_LoadById]
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[User_Search]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[User_Search]
GO

CREATE PROCEDURE [dbo].[Address_Delete]
(
 @Address_Id [int],
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
DELETE [Address] FROM [Address] 
    WHERE (([Address].[Address_Id] = @Address_Id) AND ([Address].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Address_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Address_Save]
(
 @Address_Id [int] = NULL,
 @Address_Line1 [nvarchar] (256) = NULL,
 @Address_Line2 [nvarchar] (256) = NULL,
 @Address_City [nvarchar] (256) = NULL,
 @Address_Zip [nvarchar] (256) = NULL,
 @Address_Country [nvarchar] (256) = NULL,
 @Address_Contact_Id [int] = NULL,
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
    UPDATE [Address] SET
     [Address].[Address_Line1] = @Address_Line1,
     [Address].[Address_Line2] = @Address_Line2,
     [Address].[Address_City] = @Address_City,
     [Address].[Address_Zip] = @Address_Zip,
     [Address].[Address_Country] = @Address_Country,
     [Address].[Address_Contact_Id] = @Address_Contact_Id,
     [Address].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Address].[_trackLastWriteTime] = GETDATE()
        WHERE (([Address].[Address_Id] = @Address_Id) AND ([Address].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Address_Save')
        RETURN
    END
    SELECT DISTINCT [Address].[_rowVersion], @Address_Id AS 'Address_Id' 
        FROM [Address] 
        WHERE ([Address].[Address_Id] = @Address_Id)
END
ELSE
BEGIN
    INSERT INTO [Address] (
        [Address].[Address_Line1],
        [Address].[Address_Line2],
        [Address].[Address_City],
        [Address].[Address_Zip],
        [Address].[Address_Country],
        [Address].[Address_Contact_Id],
        [Address].[_trackCreationUser],
        [Address].[_trackLastWriteUser])
    VALUES (
        @Address_Line1,
        @Address_Line2,
        @Address_City,
        @Address_Zip,
        @Address_Country,
        @Address_Contact_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT @Address_Id = SCOPE_IDENTITY()  
    SELECT DISTINCT [Address].[_rowVersion], @Address_Id AS 'Address_Id' 
        FROM [Address] 
        WHERE ([Address].[Address_Id] = @Address_Id)
END
IF(@Address_Contact_Id IS NOT NULL)
BEGIN
    UPDATE [Contact] SET
     [Contact].[Contact_Address_Id] = @Address_Id
        WHERE ([Contact].[Contact_Id] = @Address_Contact_Id)
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

CREATE PROCEDURE [dbo].[Contact_Delete]
(
 @Contact_Id [int],
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
 @Contact_Id [int] = NULL,
 @Contact_Email [nvarchar] (256),
 @Contact_FirstName [nvarchar] (256) = NULL,
 @Contact_LastName [nvarchar] (256) = NULL,
 @Contact_ContactSource_Id [int] = NULL,
 @Contact_Status [int] = NULL,
 @Contact_Address_Id [int] = NULL,
 @Contact_User_Id [int] = NULL,
 @Contact_Description [nvarchar] (256) = NULL,
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
     [Contact].[Contact_Email] = @Contact_Email,
     [Contact].[Contact_FirstName] = @Contact_FirstName,
     [Contact].[Contact_LastName] = @Contact_LastName,
     [Contact].[Contact_ContactSource_Id] = @Contact_ContactSource_Id,
     [Contact].[Contact_Status] = @Contact_Status,
     [Contact].[Contact_Address_Id] = @Contact_Address_Id,
     [Contact].[Contact_User_Id] = @Contact_User_Id,
     [Contact].[Contact_Description] = @Contact_Description,
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
    SELECT DISTINCT [Contact].[_rowVersion], @Contact_Id AS 'Contact_Id' 
        FROM [Contact] 
        WHERE ([Contact].[Contact_Id] = @Contact_Id)
END
ELSE
BEGIN
    INSERT INTO [Contact] (
        [Contact].[Contact_Email],
        [Contact].[Contact_FirstName],
        [Contact].[Contact_LastName],
        [Contact].[Contact_ContactSource_Id],
        [Contact].[Contact_Status],
        [Contact].[Contact_Address_Id],
        [Contact].[Contact_User_Id],
        [Contact].[Contact_Description],
        [Contact].[_trackCreationUser],
        [Contact].[_trackLastWriteUser])
    VALUES (
        @Contact_Email,
        @Contact_FirstName,
        @Contact_LastName,
        @Contact_ContactSource_Id,
        @Contact_Status,
        @Contact_Address_Id,
        @Contact_User_Id,
        @Contact_Description,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT @Contact_Id = SCOPE_IDENTITY()  
    SELECT DISTINCT [Contact].[_rowVersion], @Contact_Id AS 'Contact_Id' 
        FROM [Contact] 
        WHERE ([Contact].[Contact_Id] = @Contact_Id)
END
IF(@Contact_Address_Id IS NOT NULL)
BEGIN
    UPDATE [Address] SET
     [Address].[Address_Contact_Id] = @Contact_Id
        WHERE ([Address].[Address_Id] = @Contact_Address_Id)
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

CREATE PROCEDURE [dbo].[ContactSource_Delete]
(
 @ContactSource_Id [int],
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
UPDATE [Contact] SET
 [Contact].[Contact_ContactSource_Id] = NULL
    WHERE ([Contact].[Contact_ContactSource_Id] = @ContactSource_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
DELETE [ContactSource] FROM [ContactSource] 
    WHERE (([ContactSource].[ContactSource_Id] = @ContactSource_Id) AND ([ContactSource].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'ContactSource_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[ContactSource_Save]
(
 @ContactSource_Id [int] = NULL,
 @ContactSource_Name [nvarchar] (256) = NULL,
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
    UPDATE [ContactSource] SET
     [ContactSource].[ContactSource_Name] = @ContactSource_Name,
     [ContactSource].[_trackLastWriteUser] = @_trackLastWriteUser,
     [ContactSource].[_trackLastWriteTime] = GETDATE()
        WHERE (([ContactSource].[ContactSource_Id] = @ContactSource_Id) AND ([ContactSource].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'ContactSource_Save')
        RETURN
    END
    SELECT DISTINCT [ContactSource].[_rowVersion], @ContactSource_Id AS 'ContactSource_Id' 
        FROM [ContactSource] 
        WHERE ([ContactSource].[ContactSource_Id] = @ContactSource_Id)
END
ELSE
BEGIN
    INSERT INTO [ContactSource] (
        [ContactSource].[ContactSource_Name],
        [ContactSource].[_trackCreationUser],
        [ContactSource].[_trackLastWriteUser])
    VALUES (
        @ContactSource_Name,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT @ContactSource_Id = SCOPE_IDENTITY()  
    SELECT DISTINCT [ContactSource].[_rowVersion], @ContactSource_Id AS 'ContactSource_Id' 
        FROM [ContactSource] 
        WHERE ([ContactSource].[ContactSource_Id] = @ContactSource_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_Delete]
(
 @User_Id [int],
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
UPDATE [Contact] SET
 [Contact].[Contact_User_Id] = NULL
    WHERE ([Contact].[Contact_User_Id] = @User_Id)
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

CREATE PROCEDURE [dbo].[User_LoadBlobUser_Photo]
(
 @User_Id [int]
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
 @User_Id [int] = NULL,
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
    SELECT DISTINCT [User].[_rowVersion], @User_Id AS 'User_Id' 
        FROM [User] 
        WHERE ([User].[User_Id] = @User_Id)
END
ELSE
BEGIN
    INSERT INTO [User] (
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
    SELECT DISTINCT @User_Id = SCOPE_IDENTITY()  
    SELECT DISTINCT [User].[_rowVersion], @User_Id AS 'User_Id' 
        FROM [User] 
        WHERE ([User].[User_Id] = @User_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_SaveBlobChunkUser_Photo]
(
 @User_Id [int],
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
            [User].[User_Photo])
        VALUES (
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
SELECT DISTINCT [User].[_rowVersion], [User].[User_Id] 
    FROM [User] 
    WHERE ([User].[User_Id] = @User_Id)
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[User_SaveBlobUser_Photo]
(
 @User_Id [int],
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
SELECT DISTINCT [User].[_rowVersion], [User].[User_Id] 
    FROM [User] 
    WHERE ([User].[User_Id] = @User_Id)
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Address_Load]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Address].[Address_Id], [Address].[Address_Line1], [Address].[Address_Line2], [Address].[Address_City], [Address].[Address_Zip], [Address].[Address_Country], [Address].[Address_Contact_Id], [Address].[_trackLastWriteTime], [Address].[_trackCreationTime], [Address].[_trackLastWriteUser], [Address].[_trackCreationUser], [Address].[_rowVersion] 
    FROM [Address] 
    WHERE ([Address].[Address_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Address_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Address].[Address_Id], [Address].[Address_Line1], [Address].[Address_Line2], [Address].[Address_City], [Address].[Address_Zip], [Address].[Address_Country], [Address].[Address_Contact_Id], [Address].[_trackLastWriteTime], [Address].[_trackCreationTime], [Address].[_trackLastWriteUser], [Address].[_trackCreationUser], [Address].[_rowVersion] 
    FROM [Address] 

RETURN
GO

CREATE PROCEDURE [dbo].[Address_LoadByContact]
(
 @ContactId [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Address].[Address_Id], [Address].[Address_Line1], [Address].[Address_Line2], [Address].[Address_City], [Address].[Address_Zip], [Address].[Address_Country], [Address].[Address_Contact_Id], [Address].[_trackLastWriteTime], [Address].[_trackCreationTime], [Address].[_trackLastWriteUser], [Address].[_trackCreationUser], [Address].[_rowVersion] 
    FROM [Address] 
    WHERE ([Address].[Address_Contact_Id] = @ContactId)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_Load]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
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
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact] 

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadByAddress]
(
 @AddressId [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact] 
    WHERE ([Contact].[Contact_Address_Id] = @AddressId)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadByContactSource]
(
 @ContactSourceId [int],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact] 
    WHERE ([Contact].[Contact_ContactSource_Id] = @ContactSourceId)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadByEmail]
(
 @Email [nvarchar] (256)
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact] 
    WHERE ([Contact].[Contact_Email] = @Email)

RETURN
GO

CREATE PROCEDURE [dbo].[Contact_LoadByUser]
(
 @UserId [int],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Contact].[Contact_Id], [Contact].[Contact_Email], [Contact].[Contact_FirstName], [Contact].[Contact_LastName], [Contact].[Contact_ContactSource_Id], [Contact].[Contact_Status], [Contact].[Contact_Address_Id], [Contact].[Contact_User_Id], [Contact].[Contact_Description], [Contact].[_trackLastWriteTime], [Contact].[_trackCreationTime], [Contact].[_trackLastWriteUser], [Contact].[_trackCreationUser], [Contact].[_rowVersion] 
    FROM [Contact] 
    WHERE ([Contact].[Contact_User_Id] = @UserId)

RETURN
GO

CREATE PROCEDURE [dbo].[ContactSource_Load]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [ContactSource].[ContactSource_Id], [ContactSource].[ContactSource_Name], [ContactSource].[_trackLastWriteTime], [ContactSource].[_trackCreationTime], [ContactSource].[_trackLastWriteUser], [ContactSource].[_trackCreationUser], [ContactSource].[_rowVersion] 
    FROM [ContactSource] 
    WHERE ([ContactSource].[ContactSource_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[ContactSource_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [ContactSource].[ContactSource_Id], [ContactSource].[ContactSource_Name], [ContactSource].[_trackLastWriteTime], [ContactSource].[_trackCreationTime], [ContactSource].[_trackLastWriteUser], [ContactSource].[_trackCreationUser], [ContactSource].[_rowVersion] 
    FROM [ContactSource] 

RETURN
GO

CREATE PROCEDURE [dbo].[ContactSource_LoadById]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [ContactSource].[ContactSource_Id], [ContactSource].[ContactSource_Name], [ContactSource].[_trackLastWriteTime], [ContactSource].[_trackCreationTime], [ContactSource].[_trackLastWriteUser], [ContactSource].[_trackCreationUser], [ContactSource].[_rowVersion] 
    FROM [ContactSource] 
    WHERE ([ContactSource].[ContactSource_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[User_Load]
(
 @Id [int]
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

CREATE PROCEDURE [dbo].[User_Search]
(
 @Id [int] = NULL,
 @Email [nvarchar] (256) = NULL,
 @FirstName [nvarchar] (256) = NULL,
 @LastName [nvarchar] (256) = NULL,
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
DECLARE @sql nvarchar(max), @paramlist nvarchar(max)

SELECT @sql=
'SELECT DISTINCT [User].[User_Id], [User].[User_Email], [User].[User_FirstName], [User].[User_LastName], [User].[User_Photo_FileName], [User].[User_Photo_ContentType], [User].[User_Photo_Attributes], [User].[User_Photo_Size], [User].[User_Photo_LastWriteTimeUtc], [User].[User_Photo_LastAccessTimeUtc], [User].[User_Photo_CreationTimeUtc], [User].[_trackLastWriteTime], [User].[_trackCreationTime], [User].[_trackLastWriteUser], [User].[_trackCreationUser], [User].[_rowVersion] 
    FROM [User] 
    WHERE ((1 = 1) AND (1 = 1))'
SELECT @paramlist = '@Id int, 
    @Email nvarchar (256), 
    @FirstName nvarchar (256), 
    @LastName nvarchar (256), 
    @_orderBy0 nvarchar (64), 
    @_orderByDirection0 bit'
IF @Id IS NOT NULL
    SELECT @sql = @sql + ' AND @Id = [User].[User_Id]'
IF @Email IS NOT NULL
    SELECT @sql = @sql + ' AND ([User].[User_Email] LIKE (@Email + ''%''))'
IF @FirstName IS NOT NULL
    SELECT @sql = @sql + ' AND ([User].[User_FirstName] LIKE (@FirstName + ''%''))'
IF @LastName IS NOT NULL
    SELECT @sql = @sql + ' AND ([User].[User_LastName] LIKE (@LastName + ''%''))'
EXEC sp_executesql @sql, @paramlist,
    @Id, 
    @Email, 
    @FirstName, 
    @LastName, 
    @_orderBy0, 
    @_orderByDirection0

RETURN
GO

