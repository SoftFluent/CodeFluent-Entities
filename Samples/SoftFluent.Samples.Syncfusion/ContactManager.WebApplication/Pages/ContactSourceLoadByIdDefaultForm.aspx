<%@ Page Title="default Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="ContactSourceLoadByIdDefaultForm.aspx.cs" Inherits="ContactManager.Web.ContactSourceLoadByIdDefaultForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
		Load By Id
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:FreeFormView runat="server" ID="FreeForm" AutoBind="true" DecamelizeOptions="None">
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>Id</td><td><cfe:NumericTextBox runat="server" ID="i34" Value='<%#Bind("Id")%>' TargetTypeName="System.Int32" Format="" /></td></tr>				
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
