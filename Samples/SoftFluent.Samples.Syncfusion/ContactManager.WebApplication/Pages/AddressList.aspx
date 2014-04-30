<%@ Page Title="Address List" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="AddressList.aspx.cs" Inherits="ContactManager.Web.AddressList" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
		<div class="box">
			<div class="cfe"><img alt="Home" class="cfeimg" src="~/Images/cfmetrowhite32.png" runat="server"/><a href="~/Pages/Address.aspx" runat="server" style="color:white"><img alt="Home" runat="server" class="lefticon" src="~/Images/next16.png" />Address</a></div>
			<ul class="methods">
			<li><b><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>AddressForm.aspx?mode=Insert');"><img alt="Add" runat="server" class="lefticon" src="~/Images/add16.png" /><asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /></a></b></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>AddressLoadDefaultForm.aspx', '?Method=Load');">Load</a></li>
			
			<li><a href="~/Pages/AddressList.aspx?Method=PageLoadAll" runat="server">Load All</a></li>
			
			<li><a href="#" onclick="javascript:return cfeDialog('<%=ResolveUrl("~/Pages/")%>AddressLoadByContactDefaultForm.aspx', '?Method=LoadByContact');">Load By Contact</a></li>
			
			</ul>
			
			</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
    <cfe:EntityDataSource runat="server" TypeName="ContactManager.Address" ID="DataSource" Method="~Method" OnError="OnError" PageSize="11" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" />
    
    
    <div class='contentgrid'><div class='widthgrid'>
    <asp:GridView runat="server" ID="defaultGrid" CssClass="grid" AllowPaging="true" CellPadding="5" CellSpacing="0" AllowSorting="true"
        EmptyDataText="No data" AutoGenerateColumns="false" DataKeyNames="EntityKey,RowVersion" GridLines="None" PagerStyle-CssClass="gridpager" PageSize="10">
        <Columns>
            <cfe:CommandField ShowDeleteButton="True" ShowEditButton="True" HeaderText="Actions" ButtonType="Button" EditUrl="AddressForm.aspx?mode=Update&_p_key={0}" OnClickFormat="javascript:return cfeDialog('{0}');" />
            
            <cfe:EvalBoundField HeaderText="Id" DataField="Id" SortExpression="[Address].[Id]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Line 1" DataField="Line1" SortExpression="[Address].[Line1]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Line 2" DataField="Line2" SortExpression="[Address].[Line2]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="City" DataField="City" SortExpression="[Address].[City]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Zip" DataField="Zip" SortExpression="[Address].[Zip]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Country" DataField="Country" SortExpression="[Address].[Country]" DataFormatString="" />
            
            <cfe:EvalBoundField HeaderText="Contact" DataField="Contact" SortExpression="[Address].[Contact]" DataFormatString="" />
            
            <asp:HyperLinkField HeaderText="Google Map Url" Target="_blank" DataNavigateUrlFields="GoogleMapUrl" DataTextField="GoogleMapUrl" />
            
            <asp:HyperLinkField HeaderText="Live Map Url" Target="_blank" DataNavigateUrlFields="LiveMapUrl" DataTextField="LiveMapUrl" />
            
        </Columns>
        </asp:GridView>
    </div></div>
    
</asp:Content>
