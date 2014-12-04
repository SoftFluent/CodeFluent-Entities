/* CodeFluent Generated Thursday, 04 December 2014 12:02. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[SoftFluent].[Customer_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [SoftFluent].[Customer_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[SoftFluent].[Customer_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [SoftFluent].[Customer_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[SoftFluent].[Customer_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [SoftFluent].[Customer_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[SoftFluent].[Customer_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [SoftFluent].[Customer_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[SoftFluent].[Customer_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [SoftFluent].[Customer_LoadById]
GO

CREATE PROCEDURE [SoftFluent].[Customer_Delete]
(
 @Customer_Id [uniqueidentifier],
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
DELETE FROM [SoftFluent].[Customer]
    WHERE (([SoftFluent].[Customer].[Customer_Id] = @Customer_Id) AND ([SoftFluent].[Customer].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Customer_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [SoftFluent].[Customer_Save]
(
 @Customer_Id [uniqueidentifier],
 @Customer_Name [nvarchar] (256) = NULL,
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
    UPDATE [SoftFluent].[Customer] SET
     [SoftFluent].[Customer].[Customer_Name] = @Customer_Name,
     [SoftFluent].[Customer].[_trackLastWriteUser] = @_trackLastWriteUser,
     [SoftFluent].[Customer].[_trackLastWriteTime] = GETDATE()
        WHERE (([SoftFluent].[Customer].[Customer_Id] = @Customer_Id) AND ([SoftFluent].[Customer].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Customer_Save')
        RETURN
    END
    SELECT DISTINCT [SoftFluent].[Customer].[_rowVersion] 
        FROM [SoftFluent].[Customer]
        WHERE ([SoftFluent].[Customer].[Customer_Id] = @Customer_Id)
END
ELSE
BEGIN
    INSERT INTO [SoftFluent].[Customer] (
        [SoftFluent].[Customer].[Customer_Id],
        [SoftFluent].[Customer].[Customer_Name],
        [SoftFluent].[Customer].[_trackCreationUser],
        [SoftFluent].[Customer].[_trackLastWriteUser])
    VALUES (
        @Customer_Id,
        @Customer_Name,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [SoftFluent].[Customer].[_rowVersion] 
        FROM [SoftFluent].[Customer]
        WHERE ([SoftFluent].[Customer].[Customer_Id] = @Customer_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [SoftFluent].[Customer_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [SoftFluent].[Customer].[Customer_Id], [SoftFluent].[Customer].[Customer_Name], [SoftFluent].[Customer].[_trackLastWriteTime], [SoftFluent].[Customer].[_trackCreationTime], [SoftFluent].[Customer].[_trackLastWriteUser], [SoftFluent].[Customer].[_trackCreationUser], [SoftFluent].[Customer].[_rowVersion] 
    FROM [SoftFluent].[Customer]
    WHERE ([SoftFluent].[Customer].[Customer_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [SoftFluent].[Customer_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [SoftFluent].[Customer].[Customer_Id], [SoftFluent].[Customer].[Customer_Name], [SoftFluent].[Customer].[_trackLastWriteTime], [SoftFluent].[Customer].[_trackCreationTime], [SoftFluent].[Customer].[_trackLastWriteUser], [SoftFluent].[Customer].[_trackCreationUser], [SoftFluent].[Customer].[_rowVersion] 
    FROM [SoftFluent].[Customer]

RETURN
GO

CREATE PROCEDURE [SoftFluent].[Customer_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [SoftFluent].[Customer].[Customer_Id], [SoftFluent].[Customer].[Customer_Name], [SoftFluent].[Customer].[_trackLastWriteTime], [SoftFluent].[Customer].[_trackCreationTime], [SoftFluent].[Customer].[_trackLastWriteUser], [SoftFluent].[Customer].[_trackCreationUser], [SoftFluent].[Customer].[_rowVersion] 
    FROM [SoftFluent].[Customer]
    WHERE ([SoftFluent].[Customer].[Customer_Id] = @Id)

RETURN
GO

