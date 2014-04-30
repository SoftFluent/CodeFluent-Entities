<%@ Page Title="Contact List" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ContactList.aspx.cs" Inherits="ContactManager.Web.ContactList" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/Pages/Contact.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" />Contact</a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactForm.aspx?mode=Insert');"><img alt="Add" runat="server" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadDefaultForm.aspx', '?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/ContactList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByAddressDefaultForm.aspx', '?Method=LoadByAddress');">Load By Address</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByContactSourceDefaultForm.aspx', '?Method=LoadByContactSource');">Load By Contact Source</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByEmailDefaultForm.aspx', '?Method=LoadByEmail');">Load By Email</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactLoadByUserDefaultForm.aspx', '?Method=LoadByUser');">Load By User</a></li>
			
			</ul>
			
			<br />
			<div class="cfe"><img alt="Home" runat="server" class="lefticon" src="~/Images/view16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, Views %>" /></div>
			<ul class="views">
			
			<li><a href='ContactList.aspx?Method=<%=Request["Method"]%>&view=default'>Default</a></li>
			
			<li><a href='ContactList.aspx?Method=<%=Request["Method"]%>&view=MyView'>My View</a></li>
			
			</ul>
			
			</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <cfe:EntityDataSource runat="server" TypeName="ContactManager.Contact" ID="DataSource" Method="~Method" OnError="OnError" PageSize="11" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" />
    
    
    <div class='contentgrid'><div class='widthgrid'>
    <asp:GridView runat="server" ID="defaultGrid" CssClass="grid" AllowPaging="true" CellPadding="5" CellSpacing="0" AllowSorting="true"
        EmptyDataText="No data" AutoGenerateColumns="false" DataKeyNames="EntityKey,RowVersion" GridLines="None" PagerStyle-CssClass="gridpager" PageSize="10">
        <Columns>
            <cfe:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" ButtonType="Button" EditUrl="ContactForm.aspx?mode=Update&_p_key={0}" OnClickFormat="javascript:return cfeDialog('{0}');" />
            
            <cfe:EvalBoundField HeaderText="Id" DataField="Id" SortExpression="[Contact].[Id]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Email" DataField="Email" SortExpression="[Contact].[Email]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="First Name" DataField="FirstName" SortExpression="[Contact].[FirstName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Last Name" DataField="LastName" SortExpression="[Contact].[LastName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Contact Source" DataField="ContactSource" SortExpression="[Contact].[ContactSource]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Status" DataField="Status" SortExpression="[Contact].[Status]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Address" DataField="Address" SortExpression="[Contact].[Address]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="User" DataField="User" SortExpression="[Contact].[User]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Description" DataField="Description" SortExpression="[Contact].[Description]" DataFormatString="" />
            
        </Columns>
        </asp:GridView>
    </div></div>
    
    <div class='contentgrid'><div class='widthgrid'>
    <asp:GridView runat="server" ID="MyViewGrid" CssClass="grid" AllowPaging="true" CellPadding="5" CellSpacing="0" AllowSorting="true"
        EmptyDataText="No data" AutoGenerateColumns="false" DataKeyNames="EntityKey,RowVersion" GridLines="None" PagerStyle-CssClass="gridpager" PageSize="10">
        <Columns>
            <cfe:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" ButtonType="Button" EditUrl="ContactForm.aspx?mode=Update&_p_key={0}" OnClickFormat="javascript:return cfeDialog('{0}');" />
            
            <cfe:EvalBoundField HeaderText="First Name" DataField="FirstName" SortExpression="[Contact].[FirstName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Last Name" DataField="LastName" SortExpression="[Contact].[LastName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="City" DataField="Address.City" SortExpression="[Contact].[City]" DataFormatString="" />
            
        </Columns>
        </asp:GridView>
    </div></div>
    
</asp:Content>
