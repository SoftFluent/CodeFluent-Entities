<%@ Page Title="Contact Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="ContactForm.aspx.cs" Inherits="ContactManager.Web.ContactForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
	<% switch (EntityFormView.ModeFromArg(Request["mode"])) {
		case FormViewMode.Edit:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, Modify %>" /> Contact
		<%break;
		case FormViewMode.ReadOnly:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, View %>" /> Contact
		<%break;
		default:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /> Contact
		<%break;}%>
		
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:EntityDataSource runat="server" ID="DataSource" TypeName="ContactManager.Contact" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" Method="LoadByEntityKey" />
		
		
		<cfe:EntityFormView runat="server" ID="defaultForm" Visible="false" DefaultMode="Insert" Width="100%" DataSourceID="DataSource" AutoChangeMode="true" AutoChangeModeParameter="mode" DataKeyNames="EntityKey,RowVersion"
			AutoBind="true"
			OnItemInserted="OnItemInserted" OnItemUpdated="OnItemUpdated">
			<InsertItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Email</td><td><asp:TextBox runat="server" ID="i9" Text='<%#Bind("Email")%>' MaxLength="256" /></td></tr>				
					<tr><td>FirstName</td><td><asp:TextBox runat="server" ID="i10" Text='<%#Bind("FirstName")%>' MaxLength="256" /></td></tr>				
					<tr><td>LastName</td><td><asp:TextBox runat="server" ID="i11" Text='<%#Bind("LastName")%>' MaxLength="256" /></td></tr>				
					<tr><td>ContactSource</td><td><cfe:EntityDropDownList runat="server" ID="i12" AutoPostBack="true" EntityTypeName="ContactManager.ContactSource" NewSelectedValue='<%#Bind("ContactSource.EntityKey")%>' SelectedValue='<%#Eval("ContactSource.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>Status</td><td><cfe:EnumDropDownList runat="server" cssClass="cf-combobox" ID="i13" EnumTypeName="ContactManager.Status" Value='<%#Bind("Status")%>' /></td></tr>				
					<tr><td>Address</td><td><cfe:EntityDropDownList runat="server" ID="i14" AutoPostBack="true" EntityTypeName="ContactManager.Address" NewSelectedValue='<%#Bind("Address.EntityKey")%>' SelectedValue='<%#Eval("Address.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>User</td><td><cfe:EntityDropDownList runat="server" ID="i15" AutoPostBack="true" EntityTypeName="ContactManager.User" NewSelectedValue='<%#Bind("User.EntityKey")%>' SelectedValue='<%#Eval("User.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>Description</td><td><asp:TextBox runat="server" ID="i16" Text='<%#Bind("Description")%>' MaxLength="256" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</InsertItemTemplate>
			<EditItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Email</td><td><asp:TextBox runat="server" ID="e9" Text='<%#Bind("Email")%>' MaxLength="256" /></td></tr>				
					<tr><td>FirstName</td><td><asp:TextBox runat="server" ID="e10" Text='<%#Bind("FirstName")%>' MaxLength="256" /></td></tr>				
					<tr><td>LastName</td><td><asp:TextBox runat="server" ID="e11" Text='<%#Bind("LastName")%>' MaxLength="256" /></td></tr>				
					<tr><td>ContactSource</td><td><cfe:EntityDropDownList runat="server" ID="e12" AutoPostBack="true" EntityTypeName="ContactManager.ContactSource" NewSelectedValue='<%#Bind("ContactSource.EntityKey")%>' SelectedValue='<%#Eval("ContactSource.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>Status</td><td><cfe:EnumDropDownList runat="server" cssClass="cf-combobox" ID="e13" EnumTypeName="ContactManager.Status" Value='<%#Bind("Status")%>' /></td></tr>				
					<tr><td>Address</td><td><cfe:EntityDropDownList runat="server" ID="e14" AutoPostBack="true" EntityTypeName="ContactManager.Address" NewSelectedValue='<%#Bind("Address.EntityKey")%>' SelectedValue='<%#Eval("Address.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>User</td><td><cfe:EntityDropDownList runat="server" ID="e15" AutoPostBack="true" EntityTypeName="ContactManager.User" NewSelectedValue='<%#Bind("User.EntityKey")%>' SelectedValue='<%#Eval("User.EntityKey")%>' ChoiceMethodName="" /></td></tr>				
					<tr><td>Description</td><td><asp:TextBox runat="server" ID="e16" Text='<%#Bind("Description")%>' MaxLength="256" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</EditItemTemplate>
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><asp:Label runat="server" ID="r17" Text='<%#Eval("Id", "")%>' /></td></tr>				
					<tr><td>Email</td><td><asp:Label runat="server" ID="r9" Text='<%#Eval("Email", "")%>' /></td></tr>				
					<tr><td>FirstName</td><td><asp:Label runat="server" ID="r10" Text='<%#Eval("FirstName", "")%>' /></td></tr>				
					<tr><td>LastName</td><td><asp:Label runat="server" ID="r11" Text='<%#Eval("LastName", "")%>' /></td></tr>				
					<tr><td>ContactSource</td><td><asp:Label runat="server" ID="r12" Text='<%#Eval("ContactSource", "")%>' /></td></tr>				
					<tr><td>Status</td><td><asp:Label runat="server" ID="r13" Text='<%#Eval("Status", "")%>' /></td></tr>				
					<tr><td>Address</td><td><asp:Label runat="server" ID="r14" Text='<%#Eval("Address", "")%>' /></td></tr>				
					<tr><td>User</td><td><asp:Label runat="server" ID="r15" Text='<%#Eval("User", "")%>' /></td></tr>				
					<tr><td>Description</td><td><asp:Label runat="server" ID="r16" Text='<%#Eval("Description", "")%>' /></td></tr>				
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
