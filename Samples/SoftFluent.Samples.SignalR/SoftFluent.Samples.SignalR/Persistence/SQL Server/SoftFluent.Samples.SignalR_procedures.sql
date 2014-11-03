/* CodeFluent Generated Monday, 03 November 2014 12:12. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_LoadById]
GO

CREATE PROCEDURE [dbo].[Customer_Delete]
(
 @Customer_Id [uniqueidentifier]
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
DELETE FROM [Customer]
    WHERE ([Customer].[Customer_Id] = @Customer_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_Save]
(
 @Customer_Id [uniqueidentifier],
 @Customer_FirstName [nvarchar] (256) = NULL,
 @Customer_LastName [nvarchar] (256) = NULL
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
UPDATE [Customer] SET
 [Customer].[Customer_FirstName] = @Customer_FirstName,
 [Customer].[Customer_LastName] = @Customer_LastName
    WHERE ([Customer].[Customer_Id] = @Customer_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
IF(@rowcount = 0)
BEGIN
    INSERT INTO [Customer] (
        [Customer].[Customer_Id],
        [Customer].[Customer_FirstName],
        [Customer].[Customer_LastName])
    VALUES (
        @Customer_Id,
        @Customer_FirstName,
        @Customer_LastName)
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

CREATE PROCEDURE [dbo].[Customer_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName] 
    FROM [Customer]
    WHERE ([Customer].[Customer_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName] 
    FROM [Customer]

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName] 
    FROM [Customer]
    WHERE ([Customer].[Customer_Id] = @Id)

RETURN
GO

