<%@ Page Title="default Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="UserSearchDefaultForm.aspx.cs" Inherits="ContactManager.Web.UserSearchDefaultForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
		Search
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:FreeFormView runat="server" ID="FreeForm" AutoBind="true" DecamelizeOptions="None">
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><cfe:NumericTextBox runat="server" ID="i37" Value='<%#Bind("Id")%>' TargetTypeName="System.Int32" Format="" /></td></tr>				
					<tr><td>Email</td><td><asp:TextBox runat="server" ID="i38" Text='<%#Bind("Email")%>' MaxLength="256" /></td></tr>				
					<tr><td>FirstName</td><td><asp:TextBox runat="server" ID="i39" Text='<%#Bind("FirstName")%>' MaxLength="256" /></td></tr>				
					<tr><td>LastName</td><td><asp:TextBox runat="server" ID="i40" Text='<%#Bind("LastName")%>' MaxLength="256" /></td></tr>				
					</table>
				<div class="dialogbuttons">
					<asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Run" />
					<input type="button" onclick="window.returnValue=false;window.close();" value="Close" />
				</div>
			</ItemTemplate>
		</cfe:FreeFormView>
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Footer">
</asp:Content>
