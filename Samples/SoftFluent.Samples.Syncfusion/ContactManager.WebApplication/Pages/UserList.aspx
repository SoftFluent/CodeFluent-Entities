<%@ Page Title="User List" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="ContactManager.Web.UserList" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/Pages/User.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" />User</a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserForm.aspx?mode=Insert');"><img alt="Add" runat="server" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserLoadDefaultForm.aspx', '?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/UserList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserLoadByEmailDefaultForm.aspx', '?Method=LoadByEmail');">Load By Email</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>UserSearchDefaultForm.aspx', '?Method=Search');">Search</a></li>
			
			</ul>
			
			</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <cfe:EntityDataSource runat="server" TypeName="ContactManager.User" ID="DataSource" Method="~Method" OnError="OnError" PageSize="11" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" />
    
    
    <div class='contentgrid'><div class='widthgrid'>
    <asp:GridView runat="server" ID="defaultGrid" CssClass="grid" AllowPaging="true" CellPadding="5" CellSpacing="0" AllowSorting="true"
        EmptyDataText="No data" AutoGenerateColumns="false" DataKeyNames="EntityKey,RowVersion" GridLines="None" PagerStyle-CssClass="gridpager" PageSize="10">
        <Columns>
            <cfe:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" ButtonType="Button" EditUrl="UserForm.aspx?mode=Update&_p_key={0}" OnClickFormat="javascript:return cfeDialog('{0}');" />
            
            <cfe:EvalBoundField HeaderText="Id" DataField="Id" SortExpression="[User].[Id]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Email" DataField="Email" SortExpression="[User].[Email]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="First Name" DataField="FirstName" SortExpression="[User].[FirstName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Last Name" DataField="LastName" SortExpression="[User].[LastName]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Full Name" DataField="FullName" SortExpression="[User].[FullName]" DataFormatString="" />
            
            <cfe:BlobField HeaderText="Photo" DataField="Photo" Format="HtmlAutoThumbBlank" />
            
            <cfe:EvalBoundField HeaderText="Contacts" DataField="Contacts" SortExpression="[User].[Contacts]" DataFormatString="" />
            
        </Columns>
        </asp:GridView>
    </div></div>
    
</asp:Content>
