/* CodeFluent Generated Tuesday, 03 February 2015 15:19. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
ALTER TABLE [dbo].[Order] WITH NOCHECK ADD CONSTRAINT [FK_Ord_Orr_Cus_Cus] FOREIGN KEY (
 [Order_Customer_Id]
) REFERENCES [dbo].[Customer](

 [Customer_Id]
)
ALTER TABLE [dbo].[Order] NOCHECK CONSTRAINT [FK_Ord_Orr_Cus_Cus]
ALTER TABLE [dbo].[Order_Products_Product_Orders] WITH NOCHECK ADD CONSTRAINT [FK_Ore_Ord_Ord_Ord] FOREIGN KEY (
 [Order_Id]
) REFERENCES [dbo].[Order](

 [Order_Id]
)
ALTER TABLE [dbo].[Order_Products_Product_Orders] NOCHECK CONSTRAINT [FK_Ore_Ord_Ord_Ord]
ALTER TABLE [dbo].[Order_Products_Product_Orders] WITH NOCHECK ADD CONSTRAINT [FK_Ore_Pro_Pro_Pro] FOREIGN KEY (
 [Product_Id]
) REFERENCES [dbo].[Product](

 [Product_Id]
)
ALTER TABLE [dbo].[Order_Products_Product_Orders] NOCHECK CONSTRAINT [FK_Ore_Pro_Pro_Pro]
