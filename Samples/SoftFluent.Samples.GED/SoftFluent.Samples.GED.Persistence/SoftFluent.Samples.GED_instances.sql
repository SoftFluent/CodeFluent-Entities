/* CodeFluent Generated Thursday, 08 May 2014 20:42. TargetVersion:Sql2012. Culture:en-US. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
DECLARE @rv rowversion
DECLARE @su nvarchar(64)
SELECT @su=SYSTEM_USER
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[Directory] WHERE [Directory_Id]='07e0c262-c293-4d78-9ddd-4da37823df75'
EXECUTE [dbo].[Directory_Save] @Directory_Id='07e0c262-c293-4d78-9ddd-4da37823df75', @Directory_Title=N'Général', @Directory_User_Id=default, @Directory_Parent_Id=default, @_trackLastWriteUser=@su, @_rowVersion=@rv
SELECT @rv=null
SELECT @rv=_rowVersion FROM [dbo].[User] WHERE [User_Id]='0a99e356-29ee-459a-9923-fbc7bf0b04bf'
EXECUTE [dbo].[User_Save] @User_Id='0a99e356-29ee-459a-9923-fbc7bf0b04bf', @User_UserName=N'test', @User_Email=N'test@softfluent.com', @User_FailedPasswordAttemptCount=default, @User_FailedPasswordAttemptWindowStart=default, @User_IsLockedOut=default, @User_LastActivityDate=default, @User_LastLockoutDate=default, @User_LastLoginDate=default, @User_LastPasswordChangeDate=default, @User_Password=N'9dOljD3bX32KzSfKW8TEJzTmnac=', @User_PasswordSalt=N'OYiHvucgT2Sdp5uJbw7O4Q==', @User_Properties=default, @User_IsAnonymous=0, @_trackLastWriteUser=@su, @_rowVersion=@rv
