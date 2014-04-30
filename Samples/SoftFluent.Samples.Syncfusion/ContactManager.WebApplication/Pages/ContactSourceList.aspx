<%@ Page Title="ContactSource List" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ContactSourceList.aspx.cs" Inherits="ContactManager.Web.ContactSourceList" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/Pages/ContactSource.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" />ContactSource</a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceForm.aspx?mode=Insert');"><img alt="Add" runat="server" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceLoadDefaultForm.aspx', '?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/ContactSourceList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>ContactSourceLoadByIdDefaultForm.aspx', '?Method=LoadById');">Load By Id</a></li>
			
			</ul>
			
			</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <cfe:EntityDataSource runat="server" TypeName="ContactManager.ContactSource" ID="DataSource" Method="~Method" OnError="OnError" PageSize="11" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" />
    
    
    <div class='contentgrid'><div class='widthgrid'>
    <asp:GridView runat="server" ID="defaultGrid" CssClass="grid" AllowPaging="true" CellPadding="5" CellSpacing="0" AllowSorting="true"
        EmptyDataText="No data" AutoGenerateColumns="false" DataKeyNames="EntityKey,RowVersion" GridLines="None" PagerStyle-CssClass="gridpager" PageSize="10">
        <Columns>
            <cfe:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" ButtonType="Button" EditUrl="ContactSourceForm.aspx?mode=Update&_p_key={0}" OnClickFormat="javascript:return cfeDialog('{0}');" />
            
            <cfe:EvalBoundField HeaderText="Id" DataField="Id" SortExpression="[ContactSource].[Id]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Name" DataField="Name" SortExpression="[ContactSource].[Name]" DataFormatString="" />
            
        </Columns>
        </asp:GridView>
    </div></div>
    
</asp:Content>
