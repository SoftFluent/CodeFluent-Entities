<%@ Page Title="User Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="User.aspx.cs" Inherits="ContactManager.Web.User" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="headerhide"><p>&nbsp;</p></div>
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/default.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, Home %>" /></a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserForm.aspx?mode=Insert');"><img runat="server" alt="Add" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserLoadDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>UserList.aspx?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/UserList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserLoadByEmailDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>UserList.aspx?Method=LoadByEmail');">Load By Email</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserSearchDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>UserList.aspx?Method=Search');">Search</a></li>
			
			</ul></div>
		<div class="header">User<asp:literal runat="server" Text="<%$ Resources:WebResources, ManagementPage %>" /></div></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="content">
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation"), "User") %>
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation2"), "ContactManager.User", ResolveUrl("~/Images/ContactManager.User.png")) %>
    </div>
</asp:Content>
