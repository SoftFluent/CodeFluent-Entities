<%@ Page Title="ContactSource Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ContactSource.aspx.cs" Inherits="ContactManager.Web.ContactSource" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="headerhide"><p>&nbsp;</p></div>
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/default.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, Home %>" /></a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceForm.aspx?mode=Insert');"><img runat="server" alt="Add" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceLoadDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactSourceList.aspx?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/ContactSourceList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceLoadByIdDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactSourceList.aspx?Method=LoadById');">Load By Id</a></li>
			
			</ul></div>
		<div class="header">Contact Source<asp:literal runat="server" Text="<%$ Resources:WebResources, ManagementPage %>" /></div></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="content">
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation"), "ContactSource") %>
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation2"), "ContactManager.ContactSource", ResolveUrl("~/Images/ContactManager.ContactSource.png")) %>
    </div>
</asp:Content>
