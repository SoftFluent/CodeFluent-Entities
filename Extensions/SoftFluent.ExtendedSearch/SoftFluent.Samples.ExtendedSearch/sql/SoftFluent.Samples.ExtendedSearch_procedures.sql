/* CodeFluent Generated Tuesday, 30 June 2015 10:23. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
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

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_Search]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_Search]
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Customer_SearchFromView]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Customer_SearchFromView]
GO

CREATE PROCEDURE [dbo].[Customer_Delete]
(
 @Customer_Id [int]
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
 @Customer_Id [int] = NULL,
 @Customer_FullName [nvarchar] (256) = NULL,
 @Customer_DateOfBirth [datetime] = NULL
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
 [Customer].[Customer_FullName] = @Customer_FullName,
 [Customer].[Customer_DateOfBirth] = @Customer_DateOfBirth
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
        [Customer].[Customer_FullName],
        [Customer].[Customer_DateOfBirth])
    VALUES (
        @Customer_FullName,
        @Customer_DateOfBirth)
    SELECT @error = @@ERROR, @rowcount = @@ROWCOUNT
    IF(@error != 0)
    BEGIN
        IF @tran = 1 ROLLBACK TRANSACTION
        RETURN
    END
    SELECT DISTINCT @Customer_Id = SCOPE_IDENTITY() 
    SELECT DISTINCT @Customer_Id AS 'Customer_Id' 
        FROM [Customer]
        WHERE ([Customer].[Customer_Id] = @Customer_Id)
END
IF @tran = 1 COMMIT TRANSACTION

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_Load]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
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
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
    FROM [Customer]

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_LoadById]
(
 @Id [int]
)
AS
SET NOCOUNT ON
SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
    FROM [Customer]
    WHERE ([Customer].[Customer_Id] = @Id)

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_Search]
(
 @FullName [nvarchar] (256) = NULL,
 @FullNameFilterFunction [int],
 @DateOfBirth [datetime] = NULL,
 @DateOfBirthFilterFunction [int],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
DECLARE @sql nvarchar(max), @paramlist nvarchar(max)

SELECT @sql=
'SELECT DISTINCT [Customer].[Customer_Id], [Customer].[Customer_FullName], [Customer].[Customer_DateOfBirth] 
    FROM [Customer]
    WHERE (((1 = 1) AND (1 = 1)) AND (1 = 1))'
SELECT @paramlist = '@FullName nvarchar (256), 
    @FullNameFilterFunction int, 
    @DateOfBirth datetime, 
    @DateOfBirthFilterFunction int, 
    @_orderBy0 nvarchar (64), 
    @_orderByDirection0 bit'
IF @FullName IS NOT NULL
    SELECT @sql = @sql + ' AND (((((((((((((@FullNameFilterFunction = 0) AND (1 = 1)) OR (((@FullNameFilterFunction & 1) = 1) AND ([Customer].[Customer_FullName] = @FullName))) OR (((@FullNameFilterFunction & 2) = 2) AND ([Customer].[Customer_FullName] != @FullName))) OR (((@FullNameFilterFunction & 4) = 4) AND ([Customer].[Customer_FullName] LIKE (@FullName + ''%'')))) OR (((@FullNameFilterFunction & 8) = 8) AND ([Customer].[Customer_FullName] LIKE (''%'' + @FullName)))) OR (((@FullNameFilterFunction & 16) = 16) AND ([Customer].[Customer_FullName] LIKE ((''%'' + @FullName) + ''%'')))) OR (((@FullNameFilterFunction & 32) = 32) AND NOT(([Customer].[Customer_FullName] LIKE ((''%'' + @FullName) + ''%''))))) OR (((@FullNameFilterFunction & 64) = 64) AND ([Customer].[Customer_FullName] < @FullName))) OR (((@FullNameFilterFunction & 128) = 128) AND ([Customer].[Customer_FullName] <= @FullName))) OR (((@FullNameFilterFunction & 256) = 256) AND ([Customer].[Customer_FullName] > @FullName))) OR (((@FullNameFilterFunction & 512) = 512) AND ([Customer].[Customer_FullName] >= @FullName))))'
IF @DateOfBirth IS NOT NULL
    SELECT @sql = @sql + ' AND (((((((((@DateOfBirthFilterFunction = 0) AND (1 = 1)) OR (((@DateOfBirthFilterFunction & 1) = 1) AND ([Customer].[Customer_DateOfBirth] = @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 2) = 2) AND ([Customer].[Customer_DateOfBirth] != @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 64) = 64) AND ([Customer].[Customer_DateOfBirth] < @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 128) = 128) AND ([Customer].[Customer_DateOfBirth] <= @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 256) = 256) AND ([Customer].[Customer_DateOfBirth] > @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 512) = 512) AND ([Customer].[Customer_DateOfBirth] >= @DateOfBirth))))'
EXEC sp_executesql @sql, @paramlist,
    @FullName, 
    @FullNameFilterFunction, 
    @DateOfBirth, 
    @DateOfBirthFilterFunction, 
    @_orderBy0, 
    @_orderByDirection0

RETURN
GO

CREATE PROCEDURE [dbo].[Customer_SearchFromView]
(
 @FullName [nvarchar] (256) = NULL,
 @FullNameFilterFunction [int],
 @DateOfBirth [datetime] = NULL,
 @DateOfBirthFilterFunction [int],
 @_orderBy0 [nvarchar] (64) = NULL,
 @_orderByDirection0 [bit] = 0
)
AS
SET NOCOUNT ON
DECLARE @sql nvarchar(max), @paramlist nvarchar(max)

SELECT @sql=
'SELECT DISTINCT [vCustomerCustomerView].[Customer_FullName], [vCustomerCustomerView].[Customer_DateOfBirth] 
    FROM [vCustomerCustomerView]
    WHERE (((1 = 1) AND (1 = 1)) AND (1 = 1))'
SELECT @paramlist = '@FullName nvarchar (256), 
    @FullNameFilterFunction int, 
    @DateOfBirth datetime, 
    @DateOfBirthFilterFunction int, 
    @_orderBy0 nvarchar (64), 
    @_orderByDirection0 bit'
IF @FullName IS NOT NULL
    SELECT @sql = @sql + ' AND (((((((((((((@FullNameFilterFunction = 0) AND (1 = 1)) OR (((@FullNameFilterFunction & 1) = 1) AND ([vCustomerCustomerView].[Customer_FullName] = @FullName))) OR (((@FullNameFilterFunction & 2) = 2) AND ([vCustomerCustomerView].[Customer_FullName] != @FullName))) OR (((@FullNameFilterFunction & 4) = 4) AND ([vCustomerCustomerView].[Customer_FullName] LIKE (@FullName + ''%'')))) OR (((@FullNameFilterFunction & 8) = 8) AND ([vCustomerCustomerView].[Customer_FullName] LIKE (''%'' + @FullName)))) OR (((@FullNameFilterFunction & 16) = 16) AND ([vCustomerCustomerView].[Customer_FullName] LIKE ((''%'' + @FullName) + ''%'')))) OR (((@FullNameFilterFunction & 32) = 32) AND NOT(([vCustomerCustomerView].[Customer_FullName] LIKE ((''%'' + @FullName) + ''%''))))) OR (((@FullNameFilterFunction & 64) = 64) AND ([vCustomerCustomerView].[Customer_FullName] < @FullName))) OR (((@FullNameFilterFunction & 128) = 128) AND ([vCustomerCustomerView].[Customer_FullName] <= @FullName))) OR (((@FullNameFilterFunction & 256) = 256) AND ([vCustomerCustomerView].[Customer_FullName] > @FullName))) OR (((@FullNameFilterFunction & 512) = 512) AND ([vCustomerCustomerView].[Customer_FullName] >= @FullName))))'
IF @DateOfBirth IS NOT NULL
    SELECT @sql = @sql + ' AND (((((((((@DateOfBirthFilterFunction = 0) AND (1 = 1)) OR (((@DateOfBirthFilterFunction & 1) = 1) AND ([vCustomerCustomerView].[Customer_DateOfBirth] = @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 2) = 2) AND ([vCustomerCustomerView].[Customer_DateOfBirth] != @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 64) = 64) AND ([vCustomerCustomerView].[Customer_DateOfBirth] < @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 128) = 128) AND ([vCustomerCustomerView].[Customer_DateOfBirth] <= @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 256) = 256) AND ([vCustomerCustomerView].[Customer_DateOfBirth] > @DateOfBirth))) OR (((@DateOfBirthFilterFunction & 512) = 512) AND ([vCustomerCustomerView].[Customer_DateOfBirth] >= @DateOfBirth))))'
EXEC sp_executesql @sql, @paramlist,
    @FullName, 
    @FullNameFilterFunction, 
    @DateOfBirth, 
    @DateOfBirthFilterFunction, 
    @_orderBy0, 
    @_orderByDirection0

RETURN
GO

