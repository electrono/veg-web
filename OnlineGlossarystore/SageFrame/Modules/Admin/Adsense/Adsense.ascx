<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Adsense.ascx.cs" Inherits="SageFrame.Modules.Admin.Adsense.Adsense" %>
<%@ Register Assembly="SFE.GoogleAdUnit" Namespace="SFE.GoogleAdUnit" TagPrefix="wwc" %>
<asp:HiddenField ID="hdnUserModuleID" runat="server" Value="0" />
<wwc:AdUnit ID="AdsenseDisplay" runat="server" Visible="False">
</wwc:AdUnit>