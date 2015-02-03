/* CodeFluent Generated Tuesday, 03 February 2015 15:19. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Delete]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Delete]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_DeleteOrderProducts]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_DeleteOrderProducts]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Save]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Save]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_SaveOrderProducts]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_SaveOrderProducts]
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_LoadByCustomer]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_LoadByCustomer]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Order_LoadOrdersProductsByProduct]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Order_LoadOrdersProductsByProduct]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_Load]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_Load]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadAll]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadAll]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadById]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadById]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Product_LoadProductsOrdersByOrder]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Product_LoadProductsOrdersByOrder]
GO

CREATE PROCEDURE [dbo].[Customer_Delete]
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
UPDATE [Order] SET
 [Order].[Order_Customer_Id] = NULL
    WHERE ([Order].[Order_Customer_Id] = @Customer_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
DELETE FROM [Customer]
    WHERE (([Customer].[Customer_Id] = @Customer_Id) AND ([Customer].[_rowVersion] = @_rowVersion))
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

CREATE PROCEDURE [dbo].[Customer_Save]
(
 @Customer_Id [uniqueidentifier],
 @Customer_FirstName [nvarchar] (256) = NULL,
 @Customer_LastName [nvarchar] (256) = NULL,
 @Customer_DateOfBirth [datetime] = NULL,
 @Customer_PassportNumber [nvarchar] (256) = NULL,
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
    UPDATE [Customer] SET
     [Customer].[Customer_FirstName] = @Customer_FirstName,
     [Customer].[Customer_LastName] = @Customer_LastName,
     [Customer].[Customer_DateOfBirth] = @Customer_DateOfBirth,
     [Customer].[Customer_PassportNumber] = @Customer_PassportNumber,
     [Customer].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Customer].[_trackLastWriteTime] = GETDATE()
        WHERE (([Customer].[Customer_Id] = @Customer_Id) AND ([Customer].[_rowVersion] = @_rowVersion))
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
    SELECT DISTINCT [Customer].[_rowVersion] 
        FROM [Customer]
        WHERE ([Customer].[Customer_Id] = @Customer_Id)
END
ELSE
BEGIN
    INSERT INTO [Customer] (
        [Customer].[Customer_Id],
        [Customer].[Customer_FirstName],
        [Customer].[Customer_LastName],
        [Customer].[Customer_DateOfBirth],
        [Customer].[Customer_PassportNumber],
        [Customer].[_trackCreationUser],
        [Customer].[_trackLastWriteUser])
    VALUES (
        @Customer_Id,
        @Customer_FirstName,
        @Customer_LastName,
        @Customer_DateOfBirth,
        @Customer_PassportNumber,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Customer].[_rowVersion] 
        FROM [Customer]
        WHERE ([Customer].[Customer_Id] = @Customer_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Order_Delete]
(
 @Order_Id [uniqueidentifier],
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
DELETE FROM [Order_Products_Product_Orders]
    WHERE ([Order_Products_Product_Orders].[Order_Id] = @Order_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
DELETE FROM [Order]
    WHERE (([Order].[Order_Id] = @Order_Id) AND ([Order].[_rowVersion] = @_rowVersion))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@rowcount = 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RAISERROR (50001, 16, 1, 'Order_Delete')
    RETURN
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Order_Save]
(
 @Order_Id [uniqueidentifier],
 @Order_Customer_Id [uniqueidentifier] = NULL,
 @Order_Date [datetime] = NULL,
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
    UPDATE [Order] SET
     [Order].[Order_Customer_Id] = @Order_Customer_Id,
     [Order].[Order_Date] = @Order_Date,
     [Order].[_trackLastWriteUser] = @_trackLastWriteUser,
     [Order].[_trackLastWriteTime] = GETDATE()
        WHERE (([Order].[Order_Id] = @Order_Id) AND ([Order].[_rowVersion] = @_rowVersion))
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    IF(@rowcount = 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RAISERROR (50001, 16, 1, 'Order_Save')
        RETURN
    END
    SELECT DISTINCT [Order].[_rowVersion] 
        FROM [Order]
        WHERE ([Order].[Order_Id] = @Order_Id)
END
ELSE
BEGIN
    INSERT INTO [Order] (
        [Order].[Order_Id],
        [Order].[Order_Customer_Id],
        [Order].[Order_Date],
        [Order].[_trackCreationUser],
        [Order].[_trackLastWriteUser])
    VALUES (
        @Order_Id,
        @Order_Customer_Id,
        @Order_Date,
        @_trackLastWriteUser,
        @_trackLastWriteUser)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT [Order].[_rowVersion] 
        FROM [Order]
        WHERE ([Order].[Order_Id] = @Order_Id)
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
DELETE FROM [Order_Products_Product_Orders]
    WHERE ([Order_Products_Product_Orders].[Product_Id] = @Product_Id)
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
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

CREATE PROCEDURE [dbo].[Product_DeleteOrderProducts]
(
 @Order_Id [uniqueidentifier] = NULL,
 @Product_Id [uniqueidentifier]
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
DELETE FROM [Order_Products_Product_Orders]
    WHERE (([Order_Products_Product_Orders].[Product_Id] = @Product_Id) AND ([Order_Products_Product_Orders].[Order_Id] = @Order_Id))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Product_Save]
(
 @Product_Id [uniqueidentifier],
 @Product_Name [nvarchar] (256) = NULL,
 @Product_Price [real] = NULL,
 @Product_Star [int] = NULL,
 @Product_Description [nvarchar] (256) = NULL,
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
     [Product].[Product_Price] = @Product_Price,
     [Product].[Product_Star] = @Product_Star,
     [Product].[Product_Description] = @Product_Description,
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
        [Product].[Product_Price],
        [Product].[Product_Star],
        [Product].[Product_Description],
        [Product].[_trackCreationUser],
        [Product].[_trackLastWriteUser])
    VALUES (
        @Product_Id,
        @Product_Name,
        @Product_Price,
        @Product_Star,
        @Product_Description,
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

CREATE PROCEDURE [dbo].[Product_SaveOrderProducts]
(
 @Order_Id [uniqueidentifier],
 @Product_Id [uniqueidentifier]
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
SELECT DISTINCT TOP 1 [Order_Products_Product_Orders].[Order_Id] 
    FROM [Order_Products_Product_Orders]
    WHERE (([Order_Products_Product_Orders].[Product_Id] = @Product_Id) AND ([Order_Products_Product_Orders].[Order_Id] = @Order_Id))
SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
IF(@error != 0)
BEGIN
    IF @tran = 1 ROLLBACK TRANSACTION
    RETURN
END
IF(@rowcount = 0)
BEGIN
    INSERT INTO [Order_Products_Product_Orders] (
        [Order_Products_Product_Orders].[Order_Id],
        [Order_Products_Product_Orders].[Product_Id])
    VALUES (
        @Order_Id,
        @Product_Id)
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
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName], [Customer].[Customer_DateOfBirth], [Customer].[Customer_PassportNumber], [Customer].[_trackLastWriteTime], [Customer].[_trackCreationTime], [Customer].[_trackLastWriteUser], [Customer].[_trackCreationUser], [Customer].[_rowVersion] 
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
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName], [Customer].[Customer_DateOfBirth], [Customer].[Customer_PassportNumber], [Customer].[_trackLastWriteTime], [Customer].[_trackCreationTime], [Customer].[_trackLastWriteUser], [Customer].[_trackCreationUser], [Customer].[_rowVersion] 
    FROM [Customer]

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FirstName], [Customer].[Customer_LastName], [Customer].[Customer_DateOfBirth], [Customer].[Customer_PassportNumber], [Customer].[_trackLastWriteTime], [Customer].[_trackCreationTime], [Customer].[_trackLastWriteUser], [Customer].[_trackCreationUser], [Customer].[_rowVersion] 
    FROM [Customer]
    WHERE ([Customer].[Customer_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Order_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_trackLastWriteTime], [Order].[_trackCreationTime], [Order].[_trackLastWriteUser], [Order].[_trackCreationUser], [Order].[_rowVersion] 
    FROM [Order]
    WHERE ([Order].[Order_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Order_LoadAll]
(
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_trackLastWriteTime], [Order].[_trackCreationTime], [Order].[_trackLastWriteUser], [Order].[_trackCreationUser], [Order].[_rowVersion] 
    FROM [Order]

RETURN
GO

CREATE PROCEDURE [dbo].[Order_LoadByCustomer]
(
 @CustomerId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_trackLastWriteTime], [Order].[_trackCreationTime], [Order].[_trackLastWriteUser], [Order].[_trackCreationUser], [Order].[_rowVersion] 
    FROM [Order]
    WHERE ([Order].[Order_Customer_Id] = @CustomerId)

RETURN
GO

CREATE PROCEDURE [dbo].[Order_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_trackLastWriteTime], [Order].[_trackCreationTime], [Order].[_trackLastWriteUser], [Order].[_trackCreationUser], [Order].[_rowVersion] 
    FROM [Order]
    WHERE ([Order].[Order_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Order_LoadOrdersProductsByProduct]
(
 @ProductId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Order].[Order_Id], [Order].[Order_Customer_Id], [Order].[Order_Date], [Order].[_trackLastWriteTime], [Order].[_trackCreationTime], [Order].[_trackLastWriteUser], [Order].[_trackCreationUser], [Order].[_rowVersion] 
    FROM [Order]
        LEFT OUTER JOIN [Order_Products_Product_Orders] ON ([Order].[Order_Id] = [Order_Products_Product_Orders].[Order_Id])
                LEFT OUTER JOIN [Product] ON ([Order_Products_Product_Orders].[Product_Id] = [Product].[Product_Id])
    WHERE ([Order_Products_Product_Orders].[Product_Id] = @ProductId)

RETURN
GO

CREATE PROCEDURE [dbo].[Product_Load]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Price], [Product].[Product_Star], [Product].[Product_Description], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
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
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Price], [Product].[Product_Star], [Product].[Product_Description], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]

RETURN
GO

CREATE PROCEDURE [dbo].[Product_LoadById]
(
 @Id [uniqueidentifier]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Price], [Product].[Product_Star], [Product].[Product_Description], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]
    WHERE ([Product].[Product_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Product_LoadProductsOrdersByOrder]
(
 @OrderId [uniqueidentifier],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Product].[Product_Id], [Product].[Product_Name], [Product].[Product_Price], [Product].[Product_Star], [Product].[Product_Description], [Product].[_trackLastWriteTime], [Product].[_trackCreationTime], [Product].[_trackLastWriteUser], [Product].[_trackCreationUser], [Product].[_rowVersion] 
    FROM [Product]
        LEFT OUTER JOIN [Order_Products_Product_Orders] ON ([Product].[Product_Id] = [Order_Products_Product_Orders].[Product_Id])
                LEFT OUTER JOIN [Order] ON ([Order_Products_Product_Orders].[Order_Id] = [Order].[Order_Id])
    WHERE ([Order_Products_Product_Orders].[Order_Id] = @OrderId)

RETURN
GO

