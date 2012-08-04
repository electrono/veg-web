<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Poll.ascx.cs" Inherits="SageFrame.Modules.Poll.Poll" %>

<asp:Panel ID="pnlOption" runat="server" Visible="true">
    <asp:HiddenField ID="hdnQuestionID" runat="server" Visible="false" />
    <asp:HiddenField ID="hdnPollSettingValueID" runat="server" Visible="false" />
    <asp:HiddenField ID="hdnusername" runat="server" />
    
    <div class=" cssClassContentOutsideWrapper">
        <h2 class="cssClassFormHeading">
            <asp:Label ID="lblQuestion" runat="server" Text='<%# Eval("Question") %>' CssClass="cssClassVoteQuestion"></asp:Label></h2>
        <asp:RadioButtonList ID="rdopollanswerlist" runat="server" AutoPostBack="False" CssClass="cssClassRadioButton">
        </asp:RadioButtonList>
    </div>
    <div class="cssClassButtonWrapper">
        <asp:Button ID="btnvote" runat="server" Text="Vote" OnClick="btnvote_Click" CssClass="cssClassVote" />
        <asp:Button ID="btnviewresult" runat="server" Text="View Result" OnClick="btnviewresult_Click" CssClass="cssClassVote" />
    </div>
</asp:Panel>
<asp:Panel ID="pnlViewResult" runat="server" Visible="false">
    <div class="cssClassColorScheme" id="divResult" runat="server">
    </div>
    <asp:Label ID="lblPollTotalVoteCount" runat="server" Text='<%# Eval("TotalVotes") %>' CssClass="cssClassFormLabel"></asp:Label>
    <div class="cssClassButtonWrapper">
        <asp:ImageButton ID="imbGoBack" runat="server" CausesValidation="false" Style="width: 14px"
                         OnClick="imbGoBack_Click" ImageUrl="~/Modules/Poll/Image/btnback.png" />
        <asp:Label ID="lblGoBack" runat="server" Text="Back" AssociatedControlID="imbGoBack" CssClass="cssClassFormLabel"></asp:Label>
    </div>
</asp:Panel>