<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FAQSettings.ascx.cs" Inherits="SageFrame.Modules.Admin.FAQs.FAQSettings" %>
<%@ Register Src="~/Controls/sectionheadcontrol.ascx" TagName="sectionheadcontrol"
             TagPrefix="sfe" %>
    
<div class="cssClassFormWrapper">
    <table class="cssClassNormal" id="Table2" cellspacing="3" cellpadding="3" border="0">
        <tr>
            <td>
                <asp:Label ID="lblDefaultSorting" runat="server" Text="Default Sorting:" 
                           CssClass="cssClassFormLabel" meta:resourcekey="lblDefaultSortingResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlDefaultSorting" runat="server" Width="150px" 
                                  CssClass="cssClassDropDown" meta:resourcekey="ddlDefaultSortingResource1">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td valign="top" width="107">
                <asp:Label ID="lblUseAjax" Text=" Enable AJAX:" runat="server" 
                           CssClass="cssClassFormLabel" meta:resourcekey="lblUseAjaxResource1"></asp:Label>
            </td>
            <td>
                <asp:CheckBox ID="chkUseAjax" runat="server" CssClass="cssClassCheckBox" 
                              meta:resourcekey="chkUseAjaxResource1"></asp:CheckBox>
            </td>
        </tr>
    </table>
    <sfe:sectionheadcontrol ID="shcFAQsSettings" runat="server" CssClass="CssClassHead"
                            Section="tblFAQsSettings" IncludeRule="true" IsExpanded="true" Text="FAQs Settings" />
    <table id="tblFAQsSettings" runat="server" style="width: 100%;">
        <tr>
            <td style="width: 25;">
            </td>
            <td>
                <table id="tblFAQsSettingsInfo" runat="server">
                    <tr>
                        <td style="width: 175px" valign="top">
                            <asp:Label ID="lblAvailableQuestionsTokens" runat="server" Text="Available Question Tokens:"
                                       CssClass="cssClassFormLabel" 
                                       meta:resourcekey="lblAvailableQuestionsTokensResource1"></asp:Label>
                        </td>
                        <td valign="top">
                            <asp:DropDownList ID="ddlAvailableQuestionTokens" runat="server" Width="315px" 
                                              CssClass="cssClassDropDown" 
                                              meta:resourcekey="ddlAvailableQuestionTokensResource1">
                            </asp:DropDownList>
                            <asp:ImageButton ID="imgAddQuestionToken" runat="server" ToolTip="Add Question Token"
                                             CausesValidation="False" meta:resourcekey="imgAddQuestionTokenResource1" />
                            <asp:Label ID="lblAddQuestionToken" runat="server" Text="Add Question Token" AssociatedControlID="imgAddQuestionToken"
                                       CssClass="cssClassFormLabel" Style="cursor: pointer;" 
                                       meta:resourcekey="lblAddQuestionTokenResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px" valign="top">
                            <asp:Label ID="lblQuestionTemplate" runat="server" Text="Question Template:" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblQuestionTemplateResource1"></asp:Label>
                        </td>
                        <td style="width: 575px" valign="top">
                            <asp:TextBox ID="txtQuestionTemplate" runat="server" Width="350px" CssClass="cssClassNormalTextBox"
                                         Height="104px" TextMode="MultiLine" 
                                         meta:resourcekey="txtQuestionTemplateResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px" valign="top">
                            <asp:Label ID="lblAvailableAnswerTokens" runat="server" Text="Available Answer Tokens:"
                                       CssClass="cssClassFormLabel" 
                                       meta:resourcekey="lblAvailableAnswerTokensResource1"></asp:Label>
                        </td>
                        <td style="width: 575px" valign="top">
                            <asp:DropDownList ID="ddlAvailableAnswerTokens" runat="server" Width="315px" 
                                              CssClass="cssClassDropDown" 
                                              meta:resourcekey="ddlAvailableAnswerTokensResource1">
                            </asp:DropDownList>
                            <asp:ImageButton ID="imgAddAnswerToken" runat="server" ToolTip="Add Answer Token"
                                             CausesValidation="False" meta:resourcekey="imgAddAnswerTokenResource1" />
                            <asp:Label ID="lblAddAnswerToken" runat="server" Text="Add Answer Token" AssociatedControlID="imgAddAnswerToken"
                                       CssClass="cssClassFormLabel" Style="cursor: pointer;" 
                                       meta:resourcekey="lblAddAnswerTokenResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 175px" valign="top">
                            <asp:Label ID="lblAnswerTemplate" runat="server" Text="Answer Template:" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblAnswerTemplateResource1"></asp:Label>
                        </td>
                        <td style="width: 575px" valign="top">
                            <asp:TextBox ID="txtAnswerTemplate" runat="server" Width="350px" CssClass="cssClassNormalTextBox"
                                         Height="104px" TextMode="MultiLine" 
                                         meta:resourcekey="txtAnswerTemplateResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
                <div class="cssClassButtonWrapper">
                    <asp:ImageButton ID="imbSave" runat="server" OnClick="imbSave_Click" 
                                     meta:resourcekey="imbSaveResource1" />
                    <asp:Label ID="lblSave" runat="server" Text="Save" AssociatedControlID="imbSave"
                               Style="cursor: pointer;" meta:resourcekey="lblSaveResource1"></asp:Label>
                </div>
            </td>
        </tr>
    </table>
    <div id="auditBar" runat="server" class="cssClassAuditBar" visible="false">
        <asp:Label ID="lblCreatedBy" runat="server" CssClass="cssClassFormLabel" 
                   Visible="False" meta:resourcekey="lblCreatedByResource1" /><br />
        <asp:Label ID="lblUpdatedBy" runat="server" CssClass="cssClassFormLabel" 
                   Visible="False" meta:resourcekey="lblUpdatedByResource1" />
    </div>
</div>