/* CodeFluent Generated Tuesday, 03 February 2015 11:18. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Product] WHERE [Product_Id]='13108f62-11f7-40ab-9887-c845cc6018bb'
EXECUTE [dbo].[Product_Save] @Product_Id='13108f62-11f7-40ab-9887-c845cc6018bb', @Product_Name=N'Bronze cover', @Product_Price=50, @Product_Star=1, @Product_Description=N'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Product] WHERE [Product_Id]='b640c6dc-50a7-4068-abf7-95bff59b4308'
EXECUTE [dbo].[Product_Save] @Product_Id='b640c6dc-50a7-4068-abf7-95bff59b4308', @Product_Name=N'Platinum cover', @Product_Price=120, @Product_Star=4, @Product_Description=N'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Product] WHERE [Product_Id]='fe75feb1-2f9c-4271-a8d6-8fcad285b02f'
EXECUTE [dbo].[Product_Save] @Product_Id='fe75feb1-2f9c-4271-a8d6-8fcad285b02f', @Product_Name=N'Silver cover', @Product_Price=20, @Product_Star=3, @Product_Description=N'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit...', @_trackLastWriteUser=@su, @_rowVersion=@rv
