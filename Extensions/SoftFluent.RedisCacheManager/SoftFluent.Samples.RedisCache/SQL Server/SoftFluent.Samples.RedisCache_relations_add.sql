/* CodeFluent Generated Sunday, 16 November 2014 12:44. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
ALTER TABLE [dbo].[Product] WITH NOCHECK ADD CONSTRAINT [FK_Pro_Pru_Cat_Cat] FOREIGN KEY (
 [Product_Category_Id]
) REFERENCES [dbo].[Category](

 [Category_Id]
)
ALTER TABLE [dbo].[Product] NOCHECK CONSTRAINT [FK_Pro_Pru_Cat_Cat]
ALTER TABLE [dbo].[CategoryLocalized] WITH NOCHECK ADD CONSTRAINT [FK_Cae_Cat_Cat_Cat] FOREIGN KEY (
 [Category_Id]
) REFERENCES [dbo].[Category](

 [Category_Id]
)
ALTER TABLE [dbo].[CategoryLocalized] NOCHECK CONSTRAINT [FK_Cae_Cat_Cat_Cat]
