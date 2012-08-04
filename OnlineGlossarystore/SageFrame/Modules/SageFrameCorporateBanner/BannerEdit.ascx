<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BannerEdit.ascx.cs" Inherits="Modules_SageFrameCorporateBanner_BannerEdit" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>
<%@ Register Namespace="SageFrameAJaxEditorControls" Assembly="SageFrame.Core" TagPrefix="CustomEditor" %>
<h2 class="cssClassFormHeading">
    <asp:Label ID="lblBannerEdit" runat="server" Text="Banner Edit Management"></asp:Label></h2>
<asp:Panel ID="pnlBannerEditForm" runat="server" Width="100%">
    <div class="cssClassFormWrapper">
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblBannerTitle" runat="server" Text="Banner Title:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtBannerTitle" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBannerTitle" runat="server" ErrorMessage="Title is Required."
                                                Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                ControlToValidate="txtBannerTitle"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblBannerDescription" runat="server" Text="Banner Description:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <CustomEditor:Lite ID="txtBannerDescription" runat="server" ActiveMode="Design" Height="100px"
                                       Width="465px" />
                    <%--<asp:TextBox ID="txtBannerDescription" runat="server" CssClass="cssClassNormalTextBox"
                                    TextMode="MultiLine"></asp:TextBox>--%>
                    <%--<asp:RequiredFieldValidator ID="rfvBannerDescription" runat="server" ErrorMessage="Banner Description is Required."
                                    Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                    ControlToValidate="txtBannerDescription"></asp:RequiredFieldValidator>--%>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblBannerNavigationTitle" runat="server" Text="Banner Navigation Title:"
                               CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtBannerNavigationTitle" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvBannerNavigationTitle" runat="server" ErrorMessage="Side Navigation Title is Required."
                                                Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                ControlToValidate="txtBannerNavigationTitle"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblBannerNavigationImage" runat="server" Text="Banner Navigation Image:"
                               CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:FileUpload ID="fluBannerNavigationImage" runat="server" CssClass="cssClassNormalFileUpload" />
                    <br />
                    <asp:Image ID="imgEditNavImage" runat="server" Visible="false" />
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblBannerImage" runat="server" Text="Banner Image:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:FileUpload ID="fluBannerImage" runat="server" CssClass="cssClassNormalFileUpload" />
                    <br />
                    <asp:Image ID="imgEditBannerImage" runat="server" Visible="false" />
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblImageToolTip" runat="server" Text="Image ToolTip:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtImageToolTip" runat="server" CssClass="cssClassNormalTextBox"
                                 MaxLength="20"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvImageToolTip" runat="server" ErrorMessage="Image ToolTip is Required."
                                                Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                ControlToValidate="txtImageToolTip"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblReadButtonText" runat="server" Text="Read Button Text:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtReadButtonText" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvReadButtonText" runat="server" ErrorMessage="Text is Required."
                                                Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                ControlToValidate="txtReadButtonText"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblReadMorePage" runat="server" Text="Read More Page:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <%--<asp:TextBox ID="txtReadMorePage" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>--%>
                    <asp:DropDownList ID="ddlReadMorePage" runat="server" CssClass="cssClassDropDown">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblDisplayOrder" runat="server" Text="Display Order:" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:TextBox ID="txtDisplayOrder" runat="server" CssClass="cssClassNormalTextBox"
                                 MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvDisplayOrder" runat="server" ErrorMessage="Display Order is Required."
                                                Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                ControlToValidate="txtDisplayOrder"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revDisplayOrder" runat="server" ErrorMessage="Only Integer Allowed!"
                                                    Display="Dynamic" CssClass="cssClasssNormalRed" SetFocusOnError="True" ValidationGroup="banneredit"
                                                    ValidationExpression="[0-9]*" ControlToValidate="txtDisplayOrder"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 175px" valign="top">
                    <asp:Label ID="lblIsActive" runat="server" Text="Is Active?" CssClass="cssClassFormLabel"></asp:Label>
                </td>
                <td valign="top">
                    <asp:CheckBox ID="chkIsActive" runat="server" Checked="True" CssClass="cssClassCheckBox" />
                </td>
            </tr>
        </table>        
    </div>
    <div class="cssClassButtonWrapper">
        <asp:ImageButton ID="imbSave" runat="server" ValidationGroup="banneredit" CausesValidation="true"
                         OnClick="imbSave_Click" />
        <asp:Label ID="lblSave" runat="server" Text="Save" AssociatedControlID="imbSave"
                   Style="cursor: pointer;"></asp:Label>
        <asp:ImageButton ID="imbCancel" runat="server" OnClick="imbCancel_Click" />
        <asp:Label ID="lblCancel" runat="server" Text="Cancel" AssociatedControlID="imbCancel"
                   Style="cursor: pointer;"></asp:Label>
    </div>
</asp:Panel>
<asp:Panel ID="pnlBannerInGrid" runat="server" Width="100%">
    <div class="cssClassButtonWrapper">
        <asp:ImageButton ID="imbAddBanner" runat="server" CausesValidation="False" OnClick="imbAddBanner_Click" />
        <asp:Label ID="lblAddBanner" runat="server" Text="Add Banner" AssociatedControlID="imbAddBanner"
                   Style="cursor: pointer;"></asp:Label>
    </div>
    <div class="cssClassGridWrapper">
        <asp:GridView ID="gdvManageBanner" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                      EmptyDataText="---Banner Not Available---" OnPageIndexChanged="gdvManageBanner_PageIndexChanged"
                      OnPageIndexChanging="gdvManageBanner_PageIndexChanging" OnRowCommand="gdvManageBanner_RowCommand"
                      OnRowDataBound="gdvManageBanner_RowDataBound" OnRowDeleting="gdvManageBanner_RowDeleting"
                      OnRowEditing="gdvManageBanner_RowEditing" OnRowUpdating="gdvManageBanner_RowUpdating"
                      OnSelectedIndexChanged="gdvManageBanner_SelectedIndexChanged" Width="100%">
            <Columns>
                <asp:TemplateField HeaderText="Banner Title">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkBannerTitle" runat="server" CommandArgument='<%# Eval("BannerID") %>'
                                        CommandName="Edit" Text='<%# Eval("Title") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Banner Description">
                    <ItemTemplate>
                        <asp:Label ID="lblBannerDesc" runat="server" Text='<%# Server.HtmlDecode(Eval("Description").ToString()) %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Navigation Image">
                    <ItemTemplate>
                        <asp:Literal ID="litNavigationImage" runat="server"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Navigation Title">
                    <ItemTemplate>
                        <asp:Label ID="lblNavigationTitle" runat="server" Text='<%# Eval("NavigationTitle") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Banner Image">
                    <ItemTemplate>
                        <asp:HiddenField ID="hdnImage" runat="server" Value='<%# Eval("BannerImage").ToString() + "," + Eval("ImageToolTip").ToString() + "," +
                              Eval("NavigationImage").ToString() %>' />
                        <asp:Literal ID="litBannerImage" runat="server"></asp:Literal>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Banner Order">
                    <ItemTemplate>
                        <asp:Label ID="lblBannerOrder" runat="server" Text='<%# Eval("BannerOrder") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="imbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("BannerID") %>'
                                         CommandName="Edit" ImageUrl='<%# GetTemplateImageUrl("imgedit.png", true) %>'
                                         ToolTip="Edit Banner" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="cssClassColumnEdit" />
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ID="imbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("BannerID") %>'
                                         CommandName="Delete" ImageUrl='<%# GetTemplateImageUrl("imgdelete.png", true) %>'
                                         ToolTip="Delete Banner" />
                    </ItemTemplate>
                    <HeaderStyle CssClass="cssClassColumnDelete" />
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="cssClassHeadingOne" />
            <RowStyle CssClass="cssClassAlternativeOdd" />
            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
        </asp:GridView>
    </div>
</asp:Panel>