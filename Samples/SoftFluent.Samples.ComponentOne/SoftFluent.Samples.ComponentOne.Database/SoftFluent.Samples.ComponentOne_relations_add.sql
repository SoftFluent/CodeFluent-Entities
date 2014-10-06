/* CodeFluent Generated Monday, 06 October 2014 17:27. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Con_Co__Use_Use] FOREIGN KEY (
 [Contact_User_Id]
) REFERENCES [dbo].[User](

 [User_Id]
)
ALTER TABLE [dbo].[Contact] NOCHECK CONSTRAINT [FK_Con_Co__Use_Use]
