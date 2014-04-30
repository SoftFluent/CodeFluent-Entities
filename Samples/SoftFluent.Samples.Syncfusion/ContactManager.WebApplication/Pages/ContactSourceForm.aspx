<%@ Page Title="ContactSource Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="ContactSourceForm.aspx.cs" Inherits="ContactManager.Web.ContactSourceForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
	<% switch (EntityFormView.ModeFromArg(Request["mode"])) {
		case FormViewMode.Edit:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, Modify %>" /> ContactSource
		<%break;
		case FormViewMode.ReadOnly:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, View %>" /> ContactSource
		<%break;
		default:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /> ContactSource
		<%break;}%>
		
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:EntityDataSource runat="server" ID="DataSource" TypeName="ContactManager.ContactSource" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" Method="LoadByEntityKey" />
		
		
		<cfe:EntityFormView runat="server" ID="defaultForm" Visible="false" DefaultMode="Insert" Width="100%" DataSourceID="DataSource" AutoChangeMode="true" AutoChangeModeParameter="mode" DataKeyNames="EntityKey,RowVersion"
			AutoBind="true"
			OnItemInserted="OnItemInserted" OnItemUpdated="OnItemUpdated">
			<InsertItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Name</td><td><asp:TextBox runat="server" ID="i18" Text='<%#Bind("Name")%>' MaxLength="256" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</InsertItemTemplate>
			<EditItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Name</td><td><asp:TextBox runat="server" ID="e18" Text='<%#Bind("Name")%>' MaxLength="256" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</EditItemTemplate>
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><asp:Label runat="server" ID="r19" Text='<%#Eval("Id", "")%>' /></td></tr>				
					<tr><td>Name</td><td><asp:Label runat="server" ID="r18" Text='<%#Eval("Name", "")%>' /></td></tr>				
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
