/* CodeFluent Generated Monday, 03 November 2014 12:12. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
EXECUTE [dbo].[Customer_Save] @Customer_Id='7bc2a129-3cbb-4c8b-9375-ae6f484886d0', @Customer_FirstName=N'Scrooge', @Customer_LastName=N'McDuck'
EXECUTE [dbo].[Customer_Save] @Customer_Id='94d38ad9-4309-4952-b1ab-1be674da1326', @Customer_FirstName=N'Donald', @Customer_LastName=N'Duck'
