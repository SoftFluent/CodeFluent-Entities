<%@ Page Title="default Form" Language="C#" MasterPageFile="~/Dialog.master" AutoEventWireup="true" CodeBehind="AddressLoadAllDefaultForm.aspx.cs" Inherits="ContactManager.Web.AddressLoadAllDefaultForm" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div class="dialogtitle">
		Load All
	</div>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
	<div class="dialogcontent">
		<cfe:FreeFormView runat="server" ID="FreeForm" AutoBind="true" DecamelizeOptions="None">
			<ItemTemplate>
				<table width="100%" class="fields">				
					<tr><td>There is no data than can be edited for this instance.</td></tr></table>
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
