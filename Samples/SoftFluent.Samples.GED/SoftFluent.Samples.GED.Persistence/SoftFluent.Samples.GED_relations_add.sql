/* CodeFluent Generated Thursday, 08 May 2014 21:28. TargetVersion:Sql2012. Culture:fr-FR. UiCulture:en-US. Encoding:utf-8 (http://www.softfluent.com) */
set quoted_identifier OFF
GO
ALTER TABLE [dbo].[Directory] WITH NOCHECK ADD CONSTRAINT [FK_Dir_Dic_Use_Use] FOREIGN KEY (
 [Directory_User_Id]
) REFERENCES [dbo].[User](

 [User_Id]
)
ALTER TABLE [dbo].[Directory] NOCHECK CONSTRAINT [FK_Dir_Dic_Use_Use]
ALTER TABLE [dbo].[Directory] WITH NOCHECK ADD CONSTRAINT [FK_Dir_Dit_Dir_Dir] FOREIGN KEY (
 [Directory_Parent_Id]
) REFERENCES [dbo].[Directory](

 [Directory_Id]
)
ALTER TABLE [dbo].[Directory] NOCHECK CONSTRAINT [FK_Dir_Dit_Dir_Dir]
ALTER TABLE [dbo].[Document] WITH NOCHECK ADD CONSTRAINT [FK_Doc_Dos_Use_Use] FOREIGN KEY (
 [Document_User_Id]
) REFERENCES [dbo].[User](

 [User_Id]
)
ALTER TABLE [dbo].[Document] NOCHECK CONSTRAINT [FK_Doc_Dos_Use_Use]
ALTER TABLE [dbo].[Document] WITH NOCHECK ADD CONSTRAINT [FK_Doc_DoD_Dir_Dir] FOREIGN KEY (
 [Document_Directory_Id]
) REFERENCES [dbo].[Directory](

 [Directory_Id]
)
ALTER TABLE [dbo].[Document] NOCHECK CONSTRAINT [FK_Doc_DoD_Dir_Dir]
ALTER TABLE [dbo].[Page] WITH NOCHECK ADD CONSTRAINT [FK_Pag_PaD_Doc_Doc] FOREIGN KEY (
 [Page_Document_Id]
) REFERENCES [dbo].[Document](

 [Document_Id]
)
ALTER TABLE [dbo].[Page] NOCHECK CONSTRAINT [FK_Pag_PaD_Doc_Doc]
ALTER TABLE [dbo].[UserRole] WITH NOCHECK ADD CONSTRAINT [FK_Usr_Use_Rol_Rol] FOREIGN KEY (
 [UserRole_Role_Id]
) REFERENCES [dbo].[Role](

 [Role_Id]
)
ALTER TABLE [dbo].[UserRole] NOCHECK CONSTRAINT [FK_Usr_Use_Rol_Rol]
ALTER TABLE [dbo].[UserRole] WITH NOCHECK ADD CONSTRAINT [FK_Usr_Usr_Use_Use] FOREIGN KEY (
 [UserRole_User_Id]
) REFERENCES [dbo].[User](

 [User_Id]
)
ALTER TABLE [dbo].[UserRole] NOCHECK CONSTRAINT [FK_Usr_Usr_Use_Use]
