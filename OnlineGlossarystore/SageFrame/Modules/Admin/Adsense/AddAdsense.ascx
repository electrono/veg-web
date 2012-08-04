<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddAdsense.ascx.cs" Inherits="SageFrame.Modules.Admin.Adsense.AddAdsense" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="Adsense.ascx" TagName="Adsense" TagPrefix="uc1" %>
<%@ Register Assembly="SFE.GoogleAdUnit" Namespace="SFE.GoogleAdUnit" TagPrefix="wwc" %>
<asp:Panel ID="pnlAdsenseEdit" runat="server">
    <h2 class="cssClassFormHeading">
        <asp:Label ID="lblHeading" runat="server" CssClass="cssClassFormLabel" Text="Adsense Settings" /></h2>
    <div align="center" class="cssClassFormWrapper">
        <table>
            <tr>
                <td colspan="3">
                    <asp:HiddenField ID="hdfAdsenseID" runat="server" />
                </td>
            </tr>
            <tr>
                <td width="25%">
                    <asp:Label ID="lblShowinUserModule" runat="server" CssClass="cssClassFormLabel" Text=" Show In UserModule:" />
                </td>
                <td width="27%">
                    <asp:CheckBox ID="chkShow" runat="server" CssClass="cssClassCheckBox" Checked="true" />
                </td>
                <td width="48%">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblFormat" runat="server" CssClass="cssClassFormLabel" Text="Format:"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlUnitFormat" runat="server" CssClass="cssClassDropDown" DataTextField="Key"
                                      DataValueField="Value">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:HyperLink ID="hplHelp" runat="server" NavigateUrl="https://www.google.com/adsense/static/en_US/AdFormats.html?hl=en_US&amp;gsessionid=HqT8clPax7R_NzPVDDj_zw"
                                   Target="_blank" Text="Learn More"></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblAddUnitType" runat="server" CssClass="cssClassFormLabel" Text="Add Unit Type:"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:DropDownList DataTextField="Key" DataValueField="Value" ID="ddlAddType" CssClass="cssClassDropDown"
                                      runat="server">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblChannelID" runat="server" CssClass="cssClassFormLabel" Text="Channel ID:"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtChannelID" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblBorderColor" runat="server" CssClass="cssClassFormLabel" Text="Border Color:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtBorder" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imbBorder" runat="server" />
                    <cc1:ColorPickerExtender ID="cpBackGround" runat="server" TargetControlID="txtBorder"
                                             PopupButtonID="imbBorder" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblBackColor" runat="server" CssClass="cssClassFormLabel" Text="Back Color:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtbackcolor" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imbBack" runat="server" />
                    <cc1:ColorPickerExtender ID="cpBack" runat="server" TargetControlID="txtbackcolor"
                                             PopupButtonID="imbBack" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblLinkColor" runat="server" CssClass="cssClassFormLabel" Text="Link Color:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtLink" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imblink" runat="server" />
                    <cc1:ColorPickerExtender ID="cpLink" runat="server" TargetControlID="txtLink" PopupButtonID="imblink" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblTextColor" runat="server" CssClass="cssClassFormLabel" Text="Text Color:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtText" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imbText" runat="server" />
                    <cc1:ColorPickerExtender ID="ColorPickerExtender3" runat="server" TargetControlID="txtText"
                                             PopupButtonID="imbText" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblURLColor" runat="server" CssClass="cssClassFormLabel" Text="URL Color:"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtURL" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imbURL" runat="server" />
                    <cc1:ColorPickerExtender ID="ColorPickerExtender4" runat="server" TargetControlID="txtURL"
                                             PopupButtonID="imbURL" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblAlternate" runat="server" CssClass="cssClassFormLabel" Text="Alternate ads:"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:DropDownList ID="ddlAlternateAds" DataTextField="Key" DataValueField="Value"
                                      CssClass="cssClassDropDown" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlAlternateAds_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr id="solidFill" runat="server" visible="false">
                <td>
                    <asp:Label ID="Label7" runat="server" CssClass="cssClassFormLabel" Text="Solid Fill Color:"></asp:Label>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="txtSolidFill" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                </td>
                <td>
                    <asp:ImageButton ID="imbSolidFill" runat="server" />
                    <cc1:ColorPickerExtender ID="ColorPickerExtender1" runat="server" TargetControlID="txtSolidFill"
                                             PopupButtonID="imbSolidFill" />
                </td>
            </tr>
            <tr id="anotherURL" runat="server" visible="false">
                <td>
                    <asp:Label ID="lblURLLink" runat="server" CssClass="cssClassFormLabel" Text="URL:"></asp:Label>
                </td>
                <td colspan="2" style="text-align: left">
                    <asp:TextBox ID="txtanotherURL" runat="server" CssClass="cssClassNormalTextBox"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtanotherURL"
                                                    ErrorMessage="Invalid" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?"
                                                    ValidationGroup="adsense" CssClass="cssClasssNormalRed"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblIsActive" runat="server" CssClass="cssClassFormLabel" Text="Is Active:"></asp:Label>
                </td>
                <td colspan="2" style="text-align: left">
                    <asp:CheckBox ID="chkActive" runat="server" CssClass="cssClassCheckBox" Checked="true" />
                </td>
            </tr>
            <tr>
                <td colspan="3" height="10">
                </td>
            </tr>
        </table>
        <div class="cssClassButtonWrapper">
            <asp:ImageButton ID="ImbPreview" ToolTip="Preview" runat="server" OnClick="Preview_Click" />
            <asp:Label ID="lblPreview" runat="server" Text="Preview" AssociatedControlID="ImbPreview"
                       Style="cursor: pointer;"></asp:Label>
            <asp:ImageButton ID="ImbSave" runat="server" ToolTip="Save" OnClick="btnSave_Click" />
            <asp:Label ID="lblSave" runat="server" Text="Save" AssociatedControlID="ImbSave"
                       Style="cursor: pointer;"></asp:Label>
            <asp:ImageButton ID="imbDelete" Visible="false" ToolTip="Delete" runat="server" OnClick="imbDelete_Click" />
            <asp:Label ID="lblDelete" runat="server" Text="Delete" AssociatedControlID="imbDelete"
                       Style="cursor: pointer;" Visible="False"></asp:Label>
        </div>
        <wwc:AdUnit ID="AdUnit1" runat="server" Visible="false">
        </wwc:AdUnit>
    </div>
</asp:Panel>