/* CodeFluent Generated Tuesday, 03 February 2015 15:19. TargetVersion:Default. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ord_Orr_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [FK_Ord_Orr_Cus_Cus]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Cus_Cus_Cus]') AND parent_obj = object_id(N'[dbo].[Customer]'))
 ALTER TABLE [dbo].[Customer] DROP CONSTRAINT [PK_Cus_Cus_Cus]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Cus_Cus_Cus] PRIMARY KEY NONCLUSTERED
(

 [Customer_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [PK_Ord_Ord_Ord]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Ord_Ord_Ord]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ord_Ord_Ord]') AND parent_obj = object_id(N'[dbo].[Order]'))
 ALTER TABLE [dbo].[Order] DROP CONSTRAINT [PK_Ord_Ord_Ord]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK_Ord_Ord_Ord] PRIMARY KEY NONCLUSTERED
(

 [Order_Id]
 ) ON [PRIMARY]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[FK_Ore_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [FK_Ore_Pro_Pro_Pro]
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Pro_Pro_Pro]') AND parent_obj = object_id(N'[dbo].[Product]'))
 ALTER TABLE [dbo].[Product] DROP CONSTRAINT [PK_Pro_Pro_Pro]
GO
ALTER TABLE [dbo].[Product] ADD CONSTRAINT [PK_Pro_Pro_Pro] PRIMARY KEY NONCLUSTERED
(

 [Product_Id]
 ) ON [PRIMARY]
/* no fk for 'PK_Ore_Ord_Pro_Ore', tableName='Order_Products_Product_Orders' table='Order_Products_Product_Orders' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ore_Ord_Pro_Ore]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [PK_Ore_Ord_Pro_Ore]
GO
/* no fk for 'PK_Ore_Ord_Pro_Ore', tableName='Order_Products_Product_Orders' table='Order_Products_Product_Orders' */
IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[PK_Ore_Ord_Pro_Ore]') AND parent_obj = object_id(N'[dbo].[Order_Products_Product_Orders]'))
 ALTER TABLE [dbo].[Order_Products_Product_Orders] DROP CONSTRAINT [PK_Ore_Ord_Pro_Ore]
GO
ALTER TABLE [dbo].[Order_Products_Product_Orders] ADD CONSTRAINT [PK_Ore_Ord_Pro_Ore] PRIMARY KEY NONCLUSTERED
(

 [Order_Id],
 [Product_Id]
 ) ON [PRIMARY]
