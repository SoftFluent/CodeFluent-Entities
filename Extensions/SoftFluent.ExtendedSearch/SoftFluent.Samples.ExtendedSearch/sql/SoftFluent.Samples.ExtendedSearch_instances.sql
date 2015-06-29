/* CodeFluent Generated Monday, 29 June 2015 17:49. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
EXECUTE [dbo].[Customer_Save] @Customer_Id=1, @Customer_FullName=N'John Doe', @Customer_DateOfBirth='19851201 00:00:00.000'
EXECUTE [dbo].[Customer_Save] @Customer_Id=2, @Customer_FullName=N'Jane Doe', @Customer_DateOfBirth='19880402 00:00:00.000'
