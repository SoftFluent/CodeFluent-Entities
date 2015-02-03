/* CodeFluent Generated Tuesday, 03 February 2015 11:18. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
GO
/* no fk for 'FK_Ore_Ord_Ord_Ord', tableName='Order_Products_Product_Orders' table='Order_Products_Product_Orders' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
GO
/* no fk for 'FK_Ore_Pro_Pro_Pro', tableName='Order_Products_Product_Orders' table='Order_Products_Product_Orders' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
GO
