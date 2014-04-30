<%@ Page Title="default Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="ContactLoadByUserDefaultForm.aspx.cs" Inherits="ContactManager.Web.ContactLoadByUserDefaultForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
		Load By User
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:FreeFormView runat="server" ID="FreeForm" AutoBind="true" DecamelizeOptions="None">
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>User</td><td><cfe:EntityDropDownList runat="server" ID="i32" AutoPostBack="true" EntityTypeName="ContactManager.User" NewSelectedValue='<%#Bind("User")%>' SelectedValue='<%#Eval("User")%>' ChoiceMethodName="" /></td></tr>				
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
