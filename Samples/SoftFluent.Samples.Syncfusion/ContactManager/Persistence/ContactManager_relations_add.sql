/* CodeFluent Generated Thursday, 13 February 2014 19:31. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
ALTER TABLE [dbo].[Address] WITH NOCHECK ADD CONSTRAINT [FK_Add_Ado_Con_Con] FOREIGN KEY (
 [Address_Contact_Id]
) REFERENCES [dbo].[Contact](

 [Contact_Id]
)
ALTER TABLE [dbo].[Address] NOCHECK CONSTRAINT [FK_Add_Ado_Con_Con]
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Con_Coo_Con_Cot] FOREIGN KEY (
 [Contact_ContactSource_Id]
) REFERENCES [dbo].[ContactSource](

 [ContactSource_Id]
)
ALTER TABLE [dbo].[Contact] NOCHECK CONSTRAINT [FK_Con_Coo_Con_Cot]
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Con_Cor_Add_Add] FOREIGN KEY (
 [Contact_Address_Id]
) REFERENCES [dbo].[Address](

 [Address_Id]
)
ALTER TABLE [dbo].[Contact] NOCHECK CONSTRAINT [FK_Con_Cor_Add_Add]
ALTER TABLE [dbo].[Contact] WITH NOCHECK ADD CONSTRAINT [FK_Con_CoU_Use_Use] FOREIGN KEY (
 [Contact_User_Id]
) REFERENCES [dbo].[User](

 [User_Id]
)
ALTER TABLE [dbo].[Contact] NOCHECK CONSTRAINT [FK_Con_CoU_Use_Use]
