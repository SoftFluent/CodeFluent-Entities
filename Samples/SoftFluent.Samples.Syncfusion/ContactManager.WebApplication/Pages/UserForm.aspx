<%@ Page Title="User Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="UserForm.aspx.cs" Inherits="ContactManager.Web.UserForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
	<% switch (EntityFormView.ModeFromArg(Request["mode"])) {
		case FormViewMode.Edit:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, Modify %>" /> User
		<%break;
		case FormViewMode.ReadOnly:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, View %>" /> User
		<%break;
		default:%>
		<asp:literal runat="server" Text="<%$ Resources:WebResources, AddNew %>" /> User
		<%break;}%>
		
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:EntityDataSource runat="server" ID="DataSource" TypeName="ContactManager.User" AutoParametersModes="Form, QueryString" AutoParametersPrefix="_p_" Method="LoadByEntityKey" />
		
		
		<cfe:EntityFormView runat="server" ID="defaultForm" Visible="false" DefaultMode="Insert" Width="100%" DataSourceID="DataSource" AutoChangeMode="true" AutoChangeModeParameter="mode" DataKeyNames="EntityKey,RowVersion"
			AutoBind="true"
			OnItemInserted="OnItemInserted" OnItemUpdated="OnItemUpdated">
			<InsertItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Email</td><td><asp:TextBox runat="server" ID="i20" Text='<%#Bind("Email")%>' MaxLength="256" /></td></tr>				
					<tr><td>FirstName</td><td><asp:TextBox runat="server" ID="i21" Text='<%#Bind("FirstName")%>' MaxLength="256" /></td></tr>				
					<tr><td>LastName</td><td><asp:TextBox runat="server" ID="i22" Text='<%#Bind("LastName")%>' MaxLength="256" /></td></tr>				
					<tr><td>Photo</td><td><asp:FileUpload runat="server" ID="i23Upload" PostedFile='<%#Bind("Photo")%>'/></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</InsertItemTemplate>
			<EditItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Email</td><td><asp:TextBox runat="server" ID="e20" Text='<%#Bind("Email")%>' MaxLength="256" /></td></tr>				
					<tr><td>FirstName</td><td><asp:TextBox runat="server" ID="e21" Text='<%#Bind("FirstName")%>' MaxLength="256" /></td></tr>				
					<tr><td>LastName</td><td><asp:TextBox runat="server" ID="e22" Text='<%#Bind("LastName")%>' MaxLength="256" /></td></tr>				
					<tr><td>Photo</td><td><cfe:BlobControl runat="server" ID="e23" UrlProperties='<%#Eval("Photo", "{0:UrlProperties}")%>' />					                 
					                 <asp:FileUpload runat="server" ID="e23Upload" PostedFile='<%#Bind("Photo")%>'/></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Save" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Cancel" />
				</div>
			</EditItemTemplate>
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><asp:Label runat="server" ID="r24" Text='<%#Eval("Id", "")%>' /></td></tr>				
					<tr><td>Email</td><td><asp:Label runat="server" ID="r20" Text='<%#Eval("Email", "")%>' /></td></tr>				
					<tr><td>FirstName</td><td><asp:Label runat="server" ID="r21" Text='<%#Eval("FirstName", "")%>' /></td></tr>				
					<tr><td>LastName</td><td><asp:Label runat="server" ID="r22" Text='<%#Eval("LastName", "")%>' /></td></tr>				
					<tr><td>FullName</td><td><asp:Label runat="server" ID="r25" Text='<%#Eval("FullName", "")%>' /></td></tr>				
					<tr><td>Photo</td><td><cfe:BlobControl runat="server" ID="r23" UrlProperties='<%#Eval("Photo", "{0:UrlProperties}")%>' /></td></tr>				
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
