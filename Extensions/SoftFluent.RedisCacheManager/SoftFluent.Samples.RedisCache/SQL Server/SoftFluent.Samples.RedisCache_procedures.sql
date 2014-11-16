/* CodeFluent Generated Sunday, 16 November 2014 12:44. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Category_SaveLocalizedValues]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Category_SaveLocalizedValues]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadByCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadByCategory]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadById]
GO

CREATE PROCEDURE [dbo].[Category_Delete]
(
 @Category_Id [uniqueidentifier],
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
DELETE FROM [CategoryLocalized]
    WHERE ([CategoryLocalized].[Category_Id] = @Category_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
UPDATE [Product] SET
 [Product].[Product_Category_Id] = NULL
    WHERE ([Product].[Product_Category_Id] = @Category_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
DELETE [CategoryLocalized] FROM [CategoryLocalized]
    RIGHT OUTER JOIN [Category] ON ([CategoryLocalized].[Category_Id] = [Category].[Category_Id])
    WHERE ([Category].[Category_Id] = @Category_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE FROM [Category]
    WHERE (([Category].[Category_Id] = @Category_Id) AND ([Category].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Category_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Category_Save]
(
 @Category_Id [uniqueidentifier],
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
    UPDATE [Category] SET
     [Category].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Category].[_trackLastWriteTime] = GETDATE()
        WHERE (([Category].[Category_Id] = @Category_Id) AND ([Category].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Category_Save')
        RETURN
    END
    SELECT DISTINCT [Category].[_rowVersion] 
        FROM [Category]
        WHERE ([Category].[Category_Id] = @Category_Id)
END
ELSE
BEGIN
    INSERT INTO [Category] (
        [Category].[Category_Id],
        [Category].[_trackCreationUser],
        [Category].[_trackLastWriteUser])
    VALUES (
        @Category_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Category].[_rowVersion] 
        FROM [Category]
        WHERE ([Category].[Category_Id] = @Category_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Product_Delete]
(
 @Product_Id [uniqueidentifier],
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
DELETE FROM [Product]
    WHERE (([Product].[Product_Id] = @Product_Id) AND ([Product].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Product_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Product_Save]
(
 @Product_Id [uniqueidentifier],
 @Product_Name [nvarchar] (256) = NULL,
 @Product_Category_Id [uniqueidentifier] = NULL,
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
    UPDATE [Product] SET
     [Product].[Product_Name] = @Product_Name,
     [Product].[Product_Category_Id] = @Product_Category_Id,
     [Product].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Product].[_trackLastWriteTime] = GETDATE()
        WHERE (([Product].[Product_Id] = @Product_Id) AND ([Product].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Product_Save')
        RETURN
    END
    SELECT DISTINCT [Product].[_rowVersion] 
        FROM [Product]
        WHERE ([Product].[Product_Id] = @Product_Id)
END
ELSE
BEGIN
    INSERT INTO [Product] (
        [Product].[Product_Id],
        [Product].[Product_Name],
        [Product].[Product_Category_Id],
        [Product].[_trackCreationUser],
        [Product].[_trackLastWriteUser])
    VALUES (
        @Product_Id,
        @Product_Name,
        @Product_Category_Id,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Product].[_rowVersion] 
        FROM [Product]
        WHERE ([Product].[Product_Id] = @Product_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Category_Load]
(
 @Id [uniqueidentifier],
 @Lcid [int] = 1033
)
AS
SET NOCOUNT ON
IF(@Lcid IS NULL)
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE (([vCategoryLocalized].[Category_Id] = @Id) AND ([vCategoryLocalized].[Lcid] = 65536))
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END
ELSE
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE (([vCategoryLocalized].[Category_Id] = @Id) AND ((@Lcid = [vCategoryLocalized].[Lcid]) OR ([vCategoryLocalized].[Lcid] = 65536)))
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END

RETURN
GO

CREATE PROCEDURE [dbo].[Category_LoadAll]
(
 @Lcid [int] = 1033,
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
IF(@Lcid IS NULL)
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE ([vCategoryLocalized].[Lcid] = 65536)
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END
ELSE
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE ((@Lcid = [vCategoryLocalized].[Lcid]) OR ([vCategoryLocalized].[Lcid] = 65536))
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END

RETURN
GO

CREATE PROCEDURE [dbo].[Category_LoadById]
(
 @Id [uniqueidentifier],
 @Lcid [int] = 1033
)
AS
SET NOCOUNT ON
IF(@Lcid IS NULL)
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE (([vCategoryLocalized].[Category_Id] = @Id) AND ([vCategoryLocalized].[Lcid] = 65536))
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END
ELSE
BEGIN
    SELECT DISTINCT [vCategoryLocalized].[Category_Id], [vCategoryLocalized].[Category_Name], [vCategoryLocalized].[Lcid], [vCategoryLocalized].[_rowVersion], [vCategoryLocalized].[_trackCreationTime], [vCategoryLocalized].[_trackLastWriteTime], [vCategoryLocalized].[_trackCreationUser], [vCategoryLocalized].[_trackLastWriteUser] 
        FROM [vCategoryLocalized]
        WHERE (([vCategoryLocalized].[Category_Id] = @Id) AND ((@Lcid = [vCategoryLocalized].[Lcid]) OR ([vCategoryLocalized].[Lcid] = 65536)))
        ORDER BY [vCategoryLocalized].[Lcid] ASC
END

RETURN
GO

CREATE PROCEDURE [dbo].[Category_SaveLocalizedValues]
(
 @entityId [uniqueidentifier],
 @Lcid [int] = NULL,
 @IsDefault [bit],
 @Name [nvarchar] (256) = NULL
)
AS
SET NOCOUNT ON
IF (@IsDefault = 1)
BEGIN
 UPDATE [Category] SET [Category_Name] = @Name WHERE 1 = 1 AND [Category_Id] = @entityId
 SELECT [_rowVersion] FROM [Category] WHERE 1 = 1 AND [Category_Id] = @entityId
END
ELSE
BEGIN
 UPDATE [CategoryLocalized] SET [Category_Name] = @Name WHERE [Lcid] = @Lcid AND [Category_Id] = @entityId
 IF @@ROWCOUNT = 0
  INSERT INTO [CategoryLocalized] ([Lcid], [Category_Id], [Category_Name]) VALUES (@Lcid, @entityId, @Name)
END

RETURN
GO

CREATE PROCEDURE [dbo].[Product_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Category_Id], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]
    WHERE ([Product].[Product_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Product_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Category_Id], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]

RETURN
GO

CREATE PROCEDURE [dbo].[Product_LoadByCategory]
(
 @CategoryId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Category_Id], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]
    WHERE ([Product].[Product_Category_Id] = @CategoryId)

RETURN
GO

CREATE PROCEDURE [dbo].[Product_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Category_Id], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]
    WHERE ([Product].[Product_Id] = @Id)

RETURN
GO

