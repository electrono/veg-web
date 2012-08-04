<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PollSetting.ascx.cs" Inherits="SageFrame.Modules.Poll.PollSetting" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<ajax:TabContainer ID="TabContainerPollSetting" runat="server" ActiveTabIndex="0">
    <ajax:TabPanel ID="TabPanelPollSetting" runat="server">
        <HeaderTemplate>
            Poll Setting
        </HeaderTemplate>
        <ContentTemplate>
            <asp:Label ID="lblPollSettingsHelp" runat="server" CssClass="cssClassHelpTitle"
                       Text="In this section, you can set up the Poll Settings for the Poll Module"></asp:Label>
            <div class="cssClassFormWrapper">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="15%">
                            <asp:Label ID="lblNumberOfAnswer" runat="server" CssClass="cssClassFormlabel" Text="Number of Answer:"
                                       Font-Bold="True"></asp:Label>
                        </td>
                        <td width="33%">
                            <asp:TextBox ID="txtNumberOfAnswer" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNumberOfAnswer" runat="server" ControlToValidate="txtNumberOfAnswer"
                                                        ErrorMessage="*" ValidationGroup="FirstControl"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:RegularExpressionValidator ID="revumberOfAnswer" runat="server" ControlToValidate="txtNumberOfAnswer"
                                                            ErrorMessage="Number Required." ValidationExpression="^\d+$" ValidationGroup="FirstControl"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="cssClassFormWrapper cssClassPoolSetting">
                <div class="cssClassGridWrapper">
                    <h2 class="cssClassFormHeading">
                        <asp:Label ID="lblColor" runat="server" Text="Choose the Color:" CssClass="cssClassFormLabel"></asp:Label></h2>
                    <asp:GridView ID="gdvColorSetting" runat="server" AutoGenerateColumns="False" GridLines="None"
                                  OnRowCommand="gdvColorSetting_RowCommand" OnRowDataBound="gdvColorSetting_RowDataBound">
                        <Columns>
                            <asp:TemplateField HeaderText="Color">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnColorLocalName" runat="server" Value='<%# Eval("ColorLocalName") %>' />
                                    <asp:Label ID="lblColor" runat="server" Text='<%# Eval("ColorLocalName") %>' CssClass="cssClassFormlabel"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Color Order">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtColorOrder" runat="server" Text='<%# Eval("OrderNumber") %>' CssClass="cssClassNormalTextBox"></asp:TextBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="IsActive">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdnIsActiveColor" runat="server" Value='<%# Eval("ColorIsActive") %>' />
                                    <asp:CheckBox ID="chkColorIsActive" runat="server" CssClass="cssClassCheckBox"></asp:CheckBox>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <div>
                                        <asp:ImageButton ID="imbMoveUp" ImageUrl='<%# GetTemplateImageUrl("imgup.png", true) %>'
                                                         runat="server" CommandName="Up" AlternateText="Move Up" CommandArgument='<%# Eval("SN") %>' />
                                    </div>
                                    <div>
                                        <asp:ImageButton ID="imbMoveDown" ImageUrl='<%# GetTemplateImageUrl("imgdown.png", true) %>'
                                                         runat="server" CommandName="Down" AlternateText="Move Down" CommandArgument='<%# Eval("SN") %>' />
                                    </div>
                                </ItemTemplate>
                                <HeaderStyle CssClass="cssClassColumnOrder" />
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle CssClass="cssClassHeadingOne" />
                        <RowStyle CssClass="cssClassAlternativeOdd" />
                        <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                    </asp:GridView>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <asp:ImageButton ID="imbSavePollSettingSave" runat="server" OnClick="imbSavePollSettingSave_Click" ImageUrl ="~/Modules/Poll/Image/btnsave.png" />
                <asp:Label ID="lblSavePollSettingSave" runat="server" Text="Save" AssociatedControlID="imbSavePollSettingSave"
                           Style="cursor: pointer;"></asp:Label>
            </div>
        </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="TabPanelPollVoteControl" runat="server">
        <HeaderTemplate>
            Vote Control
        </HeaderTemplate>
        <ContentTemplate>
            <div class="cssClassFormWrapper cssClassPoolVoteControl">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <asp:RadioButtonList ID="rblPollVoteControl" runat="server" CssClass="cssClassRadioButton">
                            <asp:ListItem Text="Client IP " Value="1" Selected="True"></asp:ListItem>
                            <asp:ListItem Text="Only Once" Value="2"></asp:ListItem>
                            <asp:ListItem Text="No Control" Value="3"></asp:ListItem>
                            <asp:ListItem Text="For Anonymous User" Value="4"></asp:ListItem>
                        </asp:RadioButtonList>
                    </tr>
                </table>
            </div>
            <div class="cssClassButtonWrapper">
                <asp:ImageButton ID="imbPollVoteControl" runat="server" OnClick="imbPollVoteControl_Click" ImageUrl="~/Modules/Poll/Image/btnsave.png" />
                <asp:Label ID="lblPollVoteControl" runat="server" Text="Save" AssociatedControlID="imbPollVoteControl"
                           Style="cursor: pointer;"></asp:Label>
            </div>
        </ContentTemplate>
    </ajax:TabPanel>
</ajax:TabContainer>