[%@ template inherits="CodeFluent.Producers.UI.BaseTemplate" %]
[%@ namespace name="System" %]
[%@ namespace name="CodeFluent.Model" %]
[%@ namespace name="CodeFluent.Runtime" %]
[%@ namespace name="CodeFluent.Runtime.Utilities" %]
<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="[%=Producer.WebAssemblyNamespace%]._Default" %>
<asp:Content runat="server" ContentPlaceHolderID="Header">
	<div id="dialog">
	<div class="cfe2"><img class="cfeimg2" src="images/cfmetrowhite32.png"/>[%=Producer.Project.DefaultNamespace%]<div class="login"><img style="vertical-align:-20%;" src="images/next16.png"/> <cfe:CultureDropDownList CultureCookieName="culture" AutoPostBack="true" style="margin:2px 0px 0px 0px" id="cultures" runat="server" TitleMemberName="NativeName" TextMemberName="Name" /></div></div>
	<table style="margin:-10px;width:820px;	border-collapse:collapse">
	<tr style="height:40px"><td class="cfetd" colspan="2" style="background:#37A7EA;width:200px">&nbsp;</td><td class="cfetd" colspan="2" style="background:#69BDEF;width:200px">&nbsp;</td><td class="cfetd" style="background:#178DD5;width:100px">&nbsp;</td>
		<td class="cfetd" style="background:#71C0F0;width:100px">&nbsp;</td><td class="cfetd" style="background:#4AAFEC;width:100px">&nbsp;</td><td class="cfetdl" style="background:#168CD3;width:100px">&nbsp;</td>
		</tr>
	<tr style="height:40px"><td class="cfetd" style="background:#A0D6F5;width:100px">&nbsp;</td><td class="cfetd" style="background:#168ED6;width:100px">&nbsp;</td><td class="cfetd" colspan="2" style="background:#43ACEB;width:200px">&nbsp;</td>
		<td class="cfetd" style="background:#1898E4;width:100px">&nbsp;</td><td class="cfetd" style="background:#58B6ED;width:100px">&nbsp;</td><td class="cfetdl" colspan="2" style="background:#1899E7;width:200px">&nbsp;</td>
		</tr>
	</table>
	<div class="cfe2" style="margin-top:10px;padding:5px;font:0px arial">&nbsp;</div>			
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Content">
[%foreach(VisibleNamespace vns in Producer.VisibleNamespaces) { %]
<hr />
<div class="ns">[%=vns.DisplayName%]</div>
<div class="entities">
[%for(int i = 0; i < vns.Entities.Count; i++) { if (i == 0) Writer.Write("<img src='images/entity.png' />");%]
<a href="Pages/[%=RelativeUrl(vns.Entities[i])%].aspx">[%=Decamelize(vns.Entities[i].Name)%]</a>[% if (i < (vns.Entities.Count - 1)) Writer.Write(", "); }%]
</div>
<div class="enumerations">
[%for(int i = 0; i < vns.Enumerations.Count; i++) { if (i == 0) Writer.Write("<img src='images/enumeration.png' />");%]
[%=Decamelize(vns.Enumerations[i].Name)%][% if (i < (vns.Enumerations.Count - 1)) Writer.Write(", "); }%]
</div>
[%}%]
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="Footer">
    <div class="footerleft"><%=string.Format((string)GetGlobalResourceObject("WebResources", "CFEGenerated2"), DateTime.Parse("[%=System.DateTime.Now.ToString("o")%]", null, System.Globalization.DateTimeStyles.RoundtripKind))%></div>
    <div class="footerright"><asp:literal runat="server" Text="<%$ Resources:WebResources, CFEPowered %>" /> &copy; 2005 - <%=DateTime.Now.Year %> SoftFluent S.A.S. All rights reserved.</div>
    </div>
</asp:Content>
