<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PollEdit.ascx.cs" Inherits="Modules_Poll_PollEdit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:HiddenField ID="hdnOptionID" runat="server" Visible="false" Value='<%# Eval("PollOptionID") %>' />
<div class="cssClassPoolPage">
    <div class="cssClassFormWrapper">
        <h2 class="cssClassFormHeading">
            <asp:Label ID="lblQuestionandAnswer" runat="server" Text="Poll Question and Answer:"></asp:Label></h2>
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td width="20%">
                    <asp:Label ID="lblPollQuestion" runat="server" Text="Question of the Poll:" CssClass="cssClassFormlabel"></asp:Label>
                </td>
                <td width="20%">
                    <asp:TextBox ID="txtPollQues" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td width="60%">
                    <asp:RequiredFieldValidator ID="revPollQuestion" runat="server" ErrorMessage="*"
                                                ControlToValidate="txtPollQues" CssClass="cssClassNormalRed"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPollActiveFrom" runat="server" Text="Poll Active From:" CssClass="cssClassFormlabel"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPollActiveFrom" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <ajax:CalendarExtender ID="cmdPollActiveFromCalendar" runat="server" CssClass="CssClassCalendar"
                                           Enabled="True" PopupButtonID="imbPollActiveFromCalender" PopupPosition="BottomRight"
                                           TargetControlID="txtPollActiveFrom" />
                    <div class="cssClassCalendarBtn">
                        <asp:ImageButton ID="imbPollActiveFromCalender" runat="server" AlternateText="Click here to display calendar"
                                         CausesValidation="False" ImageUrl="~/Modules/Poll/Image/btncalendar.png" />
                        <asp:RequiredFieldValidator ID="revPollActiveFrom" runat="server" ErrorMessage="*"
                                                    CssClass="cssClassNormalRed" ControlToValidate="txtPollActiveFrom" ></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="valtxtStartDate" runat="server" CssClass="cssClassNormalRed"
                                              ControlToValidate="txtPollActiveFrom" Display="Dynamic" ErrorMessage="Invalid Date"
                                              Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblPollActiveTo" runat="server" Text="Poll Active To:" CssClass="cssClassFormlabel"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtPollActiveTo" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <ajax:CalendarExtender ID="cmdPollActiveToCalender" runat="server" CssClass="CssClassCalendar"
                                           Enabled="True" PopupButtonID="imbPollActiveToCalender" PopupPosition="BottomRight"
                                           TargetControlID="txtPollActiveTo" />
                    <div class="cssClassCalendarBtn">
                        <asp:ImageButton ID="imbPollActiveToCalender" runat="server" AlternateText="Click here to display calendar"
                                         CausesValidation="False" ImageUrl="~/Modules/Poll/Image/btncalendar.png" />
                        <asp:RequiredFieldValidator ID="revPollActiveTo" runat="server" ErrorMessage="*"
                                                    CssClass="cssClassNormalRed" ControlToValidate="txtPollActiveTo" ></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="valtxtEndDate" runat="server" CssClass="cssClassNormalRed"
                                              ControlToValidate="txtPollActiveTo" Display="Dynamic" ErrorMessage="Invalid Date!"
                                              Operator="DataTypeCheck" SetFocusOnError="True" Type="Date" />
                        <asp:CompareValidator ID="val2txtEndDate" runat="server" ControlToCompare="txtPollActiveFrom"
                                              ControlToValidate="txtPollActiveTo" ErrorMessage="End Date must be greater than Start Date"
                                              Operator="GreaterThan" Type="Date" />
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <br />
    <div class="cssClassFormWrapper cssClassFormWrapperAnswer">
        <asp:Repeater ID="RepeaterAnswers" runat="server" OnItemCommand="RepeaterAnswers_ItemCommand">
            <HeaderTemplate>
                <div class=" cssClassPollAnswerHeading">
                    <asp:Label ID="lblAnswer" runat="server" Text="Answers:" ></asp:Label>
                </div>
            </HeaderTemplate>
            <ItemTemplate>
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="19%">
                            <asp:Label ID="lblID" runat="server" Text='<%# Eval("ID") + "." %>' Font-Bold="True" CssClass="cssClassFormlabel"></asp:Label>
                        </td>
                        <td width="30%">
                            <asp:TextBox ID="txtAnswer" runat="server" Text='<%# Eval("Answer") %>' CssClass="cssClassNormalTextBox"></asp:TextBox>
                            <asp:HiddenField ID="hdnPollOptionID" runat="server" Value='<%# Eval("PollOptionID") %>' />
                        </td>
                        <td width="68%">
                            <asp:ImageButton ID="btnAddAnother" runat="server" ToolTip='<%# Eval("Button") %>'
                                             CommandName='<%# Eval("Button") %>' Font-Bold="True" ForeColor="#0066FF" />
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <div class="cssClassButtonWrapper">
        <asp:ImageButton ID="imbSave" runat="server" CausesValidation="false" Style="width: 14px; height: 16px;" ToolTip="Save" OnClick="imbSave_Click" ImageUrl="~/Modules/Poll/Image/btnsave.png" />
        <asp:Label ID="lblSave" runat="server" Text="Save" AssociatedControlID="imbSave"></asp:Label>
    </div>
    <div class="cssClassButtonWrapper">
        <asp:ImageButton ID="imbUpdate" runat="server" CausesValidation="false" Style="width: 14px; height: 16px;" ToolTip="Update" OnClick="imbUpdate_Click" ImageUrl="~/Modules/Poll/Image/btnsave.png" />
        <asp:Label ID="lblUpdate" runat="server" Text="Update" AssociatedControlID="imbUpdate"></asp:Label>
    </div>
    <div class="cssClassGridWrapper cssClassFormWrapperAnswerDetails">
        <asp:GridView ID="gdvPollEdit" runat="server" AutoGenerateColumns="False" Width="100%"
                      AllowPaging="True" PageSize="20" OnRowDataBound="gdvPollEdit_RowDataBound" OnRowCommand="gdvPollEdit_RowCommand"
                      OnPageIndexChanging="gdvPollEdit_PageIndexChanging" OnRowDeleting="gdvPollEdit_RowDeleting"
                      OnRowEditing="gdvPollEdit_RowEditing" OnRowUpdating="gdvPollEdit_RowUpdating" ShowHeader="false">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        <div>
                            <asp:HiddenField ID="hdnPollQuestionID" runat="server" Value='<%# Eval("PollQuestionID") %>' />
                            <asp:Label ID="lblPollQuestion" runat="server" Text='<%# Eval("Question") %>' CssClass="cssClassPoolQuestion" />
                        </div>
                        <asp:Label ID="lblOptions" runat="server" Text="" ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:ImageButton ID="imgEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("PollQuestionID") %>'
                                         CommandName="Edit" ImageUrl='<%# GetTemplateImageUrl("imgedit.png", true) %>'
                                         ToolTip="Edit" CssClass="cssClassColumnEdit" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("PollQuestionID") %>'
                                         CommandName="Delete" ImageUrl='<%# GetTemplateImageUrl("imgdelete.png", true) %>'
                                         ToolTip="Delete" CssClass="cssClassColumnDelete" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle/>
            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
        </asp:GridView>
    </div>
</div>