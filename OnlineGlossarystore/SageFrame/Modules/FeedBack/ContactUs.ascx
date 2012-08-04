<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ContactUs.ascx.cs" Inherits="SageFrame.Modules.FeedBack.ContactUs" %>
<div class="cssClassContactFormDetails" id="divContactFormDetails" runat="server">
    <div class="cssClassContactInformation" id="ContactInformation" runat="server">
    </div>
    <div class="cssClassFormWrapper">
        <asp:Panel ID="pnlFormView" runat="server" 
                   meta:resourcekey="pnlFormViewResource1">
        </asp:Panel>
        <div class="cssClassButtonWrapper">
            <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" 
                        ValidationGroup="Feedback" CssClass="cssClassContactSendBtn" 
                        meta:resourcekey="btnSendResource1" />
        </div>
    </div>
</div>