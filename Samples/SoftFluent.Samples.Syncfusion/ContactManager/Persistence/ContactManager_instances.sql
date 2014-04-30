/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]=1
EXECUTE [dbo].[Contact_Save] @Contact_Id=1, @Contact_Email=N'john.lenado@contoso.com', @Contact_FirstName=N'John', @Contact_LastName=N'Lenado', @Contact_ContactSource_Id=1, @Contact_Status=0, @Contact_Address_Id=default, @Contact_User_Id=1, @Contact_Description=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]=2
EXECUTE [dbo].[Contact_Save] @Contact_Id=2, @Contact_Email=N'sarah.bennett@mycorp.com', @Contact_FirstName=N'Sarah', @Contact_LastName=N'Bennett', @Contact_ContactSource_Id=1, @Contact_Status=0, @Contact_Address_Id=default, @Contact_User_Id=1, @Contact_Description=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[ContactSource] WHERE [ContactSource_Id]=1
EXECUTE [dbo].[ContactSource_Save] @ContactSource_Id=1, @ContactSource_Name=N'Direct Call', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[ContactSource] WHERE [ContactSource_Id]=2
EXECUTE [dbo].[ContactSource_Save] @ContactSource_Id=2, @ContactSource_Name=N'Network', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[ContactSource] WHERE [ContactSource_Id]=3
EXECUTE [dbo].[ContactSource_Save] @ContactSource_Id=3, @ContactSource_Name=N'Event', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[User] WHERE [User_Id]=1
EXECUTE [dbo].[User_Save] @User_Id=1, @User_Email=N'example@mail.com', @User_FirstName=N'John', @User_LastName=N'Doe', @User_Photo_FileName=default, @User_Photo_ContentType=default, @User_Photo_Attributes=default, @User_Photo_Size=default, @User_Photo_LastWriteTimeUtc=default, @User_Photo_LastAccessTimeUtc=default, @User_Photo_CreationTimeUtc=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
