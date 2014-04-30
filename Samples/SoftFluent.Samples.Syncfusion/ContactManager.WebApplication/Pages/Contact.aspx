<%@ Page Title="Contact Management" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="ContactManager.Web.Contact" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="headerhide"><p>&nbsp;</p></div>
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/default.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, Home %>" /></a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactForm.aspx?mode=Insert');"><img runat="server" alt="Add" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactList.aspx?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/ContactList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByAddressDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactList.aspx?Method=LoadByAddress');">Load By Address</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByContactSourceDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactList.aspx?Method=LoadByContactSource');">Load By Contact Source</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByEmailDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactList.aspx?Method=LoadByEmail');">Load By Email</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByUserDefaultForm.aspx', '<%=ResolveUrl("~/Pages/")%>ContactList.aspx?Method=LoadByUser');">Load By User</a></li>
			
			</ul></div>
		<div class="header">Contact<asp:literal runat="server" Text="<%$ Resources:WebResources, ManagementPage %>" /></div></asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="content">
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation"), "Contact") %>
    <%=string.Format((string)GetGlobalResourceObject("WebResources", "EntityPresentation2"), "ContactManager.Contact", ResolveUrl("~/Images/ContactManager.Contact.png")) %>
    </div>
</asp:Content>
