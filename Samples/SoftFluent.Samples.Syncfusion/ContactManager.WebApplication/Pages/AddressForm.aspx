<%@ Page Title="Address Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="AddressForm.aspx.cs" Inherits="ContactManager.Web.AddressForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
	<% switch (EntityFormView.ModeFromArg(Request["mode"])) {
		case FormViewMode.Edit:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, Modify %>" /> Address
		<%break;
		case FormViewMode.ReadOnly:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, View %>" /> Address
		<%break;
		default:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /> Address
		<%break;}%>
		
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:EntityDataSource runat="server" ID="DataSource" TypeName="ContactManager.Address" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" Method="LoadByEntityKey" />
		
		
		<cfe:EntityFormView runat="server" ID="defaultForm" Visible="false" DefaultMode="Insert" Width="100%" DataSourceID="DataSource" AutoChangeMode="true" AutoChangeModeParameter="mode" DataKeyNames="EntityKey,RowVersion"
			AutoBind="true"
			OnItemInserted="OnItemInserted" OnItemUpdated="OnItemUpdated">
			<InsertItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Line1</td><td><asp:TextBox runat="server" ID="i0" Text='<%#Bind("Line1")%>' MaxLength="256" /></td></tr>				
					<tr><td>Line2</td><td><asp:TextBox runat="server" ID="i1" Text='<%#Bind("Line2")%>' MaxLength="256" /></td></tr>				
					<tr><td>City</td><td><asp:TextBox runat="server" ID="i2" Text='<%#Bind("City")%>' MaxLength="256" /></td></tr>				
					<tr><td>Zip</td><td><asp:TextBox runat="server" ID="i3" Text='<%#Bind("Zip")%>' MaxLength="256" /></td></tr>				
					<tr><td>Country</td><td><asp:TextBox runat="server" ID="i4" Text='<%#Bind("Country")%>' MaxLength="256" /></td></tr>				
					<tr><td>Contact</td><td><cfe:EntityDropDownList runat="server" ID="i5" AutoPostBack="true" EntityTypeName="ContactManager.Contact" NewSelectedValue='<%#Bind("Contact.EntityKey")%>' SelectedValue='<%#Eval("Contact.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</InsertItemTemplate>
			<EditItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Line1</td><td><asp:TextBox runat="server" ID="e0" Text='<%#Bind("Line1")%>' MaxLength="256" /></td></tr>				
					<tr><td>Line2</td><td><asp:TextBox runat="server" ID="e1" Text='<%#Bind("Line2")%>' MaxLength="256" /></td></tr>				
					<tr><td>City</td><td><asp:TextBox runat="server" ID="e2" Text='<%#Bind("City")%>' MaxLength="256" /></td></tr>				
					<tr><td>Zip</td><td><asp:TextBox runat="server" ID="e3" Text='<%#Bind("Zip")%>' MaxLength="256" /></td></tr>				
					<tr><td>Country</td><td><asp:TextBox runat="server" ID="e4" Text='<%#Bind("Country")%>' MaxLength="256" /></td></tr>				
					<tr><td>Contact</td><td><cfe:EntityDropDownList runat="server" ID="e5" AutoPostBack="true" EntityTypeName="ContactManager.Contact" NewSelectedValue='<%#Bind("Contact.EntityKey")%>' SelectedValue='<%#Eval("Contact.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</EditItemTemplate>
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><asp:Label runat="server" ID="r6" Text='<%#Eval("Id", "")%>' /></td></tr>				
					<tr><td>Line1</td><td><asp:Label runat="server" ID="r0" Text='<%#Eval("Line1", "")%>' /></td></tr>				
					<tr><td>Line2</td><td><asp:Label runat="server" ID="r1" Text='<%#Eval("Line2", "")%>' /></td></tr>				
					<tr><td>City</td><td><asp:Label runat="server" ID="r2" Text='<%#Eval("City", "")%>' /></td></tr>				
					<tr><td>Zip</td><td><asp:Label runat="server" ID="r3" Text='<%#Eval("Zip", "")%>' /></td></tr>				
					<tr><td>Country</td><td><asp:Label runat="server" ID="r4" Text='<%#Eval("Country", "")%>' /></td></tr>				
					<tr><td>Contact</td><td><asp:Label runat="server" ID="r5" Text='<%#Eval("Contact", "")%>' /></td></tr>				
					<tr><td>GoogleMapUrl</td><td><asp:Label runat="server" ID="r7" Text='<%#Eval("GoogleMapUrl", "")%>' /></td></tr>				
					<tr><td>LiveMapUrl</td><td><asp:Label runat="server" ID="r8" Text='<%#Eval("LiveMapUrl", "")%>' /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<input type="button" onclick="window.returnValue=false;window.close();" value="Close" />
				</div>
			</ItemTemplate>
		</cfe:EntityFormView>
		
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Footer">
</asp:Content>
