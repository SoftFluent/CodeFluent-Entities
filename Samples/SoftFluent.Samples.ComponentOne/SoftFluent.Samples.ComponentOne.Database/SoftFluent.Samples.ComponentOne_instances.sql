/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='1cce301d-0f99-4105-8184-44829ee64845'
EXECUTE [dbo].[Contact_Save] @Contact_Id='1cce301d-0f99-4105-8184-44829ee64845', @Contact_FirstName=N'Gwendolyn', @Contact_LastName=N'Wheeler', @Contact_Description=default, @Contact_User_Id='ec112046-a139-4adf-b8b9-7ab032b91074', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='1f71872d-7eae-42ca-961d-0b24af6cb7ac'
EXECUTE [dbo].[Contact_Save] @Contact_Id='1f71872d-7eae-42ca-961d-0b24af6cb7ac', @Contact_FirstName=N'Eileen', @Contact_LastName=N'Ingram', @Contact_Description=default, @Contact_User_Id='0b53f3c2-633d-44c5-b911-aa3fae0bbb0f', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='5881971d-4c51-4d61-a226-8ed5aee76d0f'
EXECUTE [dbo].[Contact_Save] @Contact_Id='5881971d-4c51-4d61-a226-8ed5aee76d0f', @Contact_FirstName=N'Carl', @Contact_LastName=N'Anderson', @Contact_Description=default, @Contact_User_Id='ec112046-a139-4adf-b8b9-7ab032b91074', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='98b4a9bc-9776-486c-9838-90c78d32f448'
EXECUTE [dbo].[Contact_Save] @Contact_Id='98b4a9bc-9776-486c-9838-90c78d32f448', @Contact_FirstName=N'Rebecca', @Contact_LastName=N'Jefferson', @Contact_Description=default, @Contact_User_Id='ec112046-a139-4adf-b8b9-7ab032b91074', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='feca0e18-d621-4cd0-b7f4-a94e0338e966'
EXECUTE [dbo].[Contact_Save] @Contact_Id='feca0e18-d621-4cd0-b7f4-a94e0338e966', @Contact_FirstName=N'Harvey', @Contact_LastName=N'Fitzgerald', @Contact_Description=default, @Contact_User_Id='0b53f3c2-633d-44c5-b911-aa3fae0bbb0f', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Contact] WHERE [Contact_Id]='7cc35ab7-38d8-4a5b-81dd-fcecea687933'
EXECUTE [dbo].[Contact_Save] @Contact_Id='7cc35ab7-38d8-4a5b-81dd-fcecea687933', @Contact_FirstName=N'Elena', @Contact_LastName=N'Lawson', @Contact_Description=default, @Contact_User_Id='97472c7c-6b53-4b01-bd75-fdc1ef36d3b2', @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[User] WHERE [User_Id]='0b53f3c2-633d-44c5-b911-aa3fae0bbb0f'
EXECUTE [dbo].[User_Save] @User_Id='0b53f3c2-633d-44c5-b911-aa3fae0bbb0f', @User_Email=N'jane.doe@softfluent.com', @User_FirstName=N'Jane', @User_LastName=N'Doe', @User_Photo_FileName=default, @User_Photo_ContentType=default, @User_Photo_Attributes=default, @User_Photo_Size=default, @User_Photo_LastWriteTimeUtc=default, @User_Photo_LastAccessTimeUtc=default, @User_Photo_CreationTimeUtc=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[User] WHERE [User_Id]='97472c7c-6b53-4b01-bd75-fdc1ef36d3b2'
EXECUTE [dbo].[User_Save] @User_Id='97472c7c-6b53-4b01-bd75-fdc1ef36d3b2', @User_Email=N'sample@softfluent.com', @User_FirstName=N'Sample', @User_LastName=N'SoftFluent', @User_Photo_FileName=default, @User_Photo_ContentType=default, @User_Photo_Attributes=default, @User_Photo_Size=default, @User_Photo_LastWriteTimeUtc=default, @User_Photo_LastAccessTimeUtc=default, @User_Photo_CreationTimeUtc=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[User] WHERE [User_Id]='ec112046-a139-4adf-b8b9-7ab032b91074'
EXECUTE [dbo].[User_Save] @User_Id='ec112046-a139-4adf-b8b9-7ab032b91074', @User_Email=N'john.doe@softfluent.com', @User_FirstName=N'John', @User_LastName=N'Doe', @User_Photo_FileName=N'Penguins.jpg', @User_Photo_ContentType=N'image/jpeg', @User_Photo_Attributes=32, @User_Photo_Size=777835, @User_Photo_LastWriteTimeUtc='20090714 05:32:31.674', @User_Photo_LastAccessTimeUtc='20141006 14:08:20.872', @User_Photo_CreationTimeUtc='20141006 14:08:20.872', @_trackLastWriteUser=@su, @_rowVersion=@rv
