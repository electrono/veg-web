<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LanguageSetUp.ascx.cs"
            Inherits="Modules_Language_LanguageSetUp" %>

<h2 class="cssClassFormHeading">
    <asp:Label ID="lblTimeZoneEditor" runat="server" Text="Language Editor" 
               meta:resourcekey="lblTimeZoneEditorResource1"></asp:Label>
</h2>
<div class="cssClassFormWrapper">
    <table>
        <tr>
            <td width="11%"><asp:Label ID="lblLanguage" CssClass="cssClassFormLabel" runat="server" 
                                       Text="Select Language" meta:resourcekey="lblLanguageResource1"></asp:Label></td>
            <td width="30%">
      
                <div class="cssClassAvailableLanguage"><asp:DropDownList ID="ddlLanguage" runat="server" CssClass="cssClassDropDown" AutoPostBack="True"
                                                                         OnSelectedIndexChanged="ddlLanguage_SelectedIndexChanged" 
                                                                         meta:resourcekey="ddlLanguageResource1"> </asp:DropDownList>
                    <asp:Image ID="imgFlagLanguage" runat="server" 
                               meta:resourcekey="imgFlagLanguageResource1" /></div>
                    
            </td>
            <td><div class="cssClassButtonListWrapper">
                    <asp:RadioButtonList ID="rbLanguageType" CssClass="cssClassRadioButtonList" RepeatDirection="Horizontal"
                                         runat="server" AutoPostBack="True" 
                                         OnSelectedIndexChanged="rbLanguageType_SelectedIndexChanged" 
                                         meta:resourcekey="rbLanguageTypeResource1">
                        <asp:ListItem Text="English" Value="0" Selected="True" 
                                      meta:resourcekey="ListItemResource1"></asp:ListItem>
                        <asp:ListItem Text="Native" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                    </asp:RadioButtonList>
                </div></td>
        </tr>
        <%-- <tr>
            <td>
                <asp:Label ID="lblFallBackLanguage" runat="server" CssClass="cssClassFormLabel" 
                    Text="FallBack Language:" meta:resourcekey="lblFallBackLanguageResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlFallBack" runat="server" CssClass="cssClassDropDown" AutoPostBack="True"
                    OnSelectedIndexChanged="ddlFallBack_SelectedIndexChanged" 
                    meta:resourcekey="ddlFallBackResource1">
                </asp:DropDownList>
                <asp:Image ID="imgFallback" runat="server" 
                    meta:resourcekey="imgFallbackResource1" />
            </td>
        </tr>
    <tr>
      <td>&nbsp;</td>
      <td><div class="cssClassButtonListWrapper">
          <asp:RadioButtonList ID="rbLanguageType" CssClass="cssClassRadioButtonList" RepeatDirection="Horizontal"
                        runat="server" AutoPostBack="True" 
                        OnSelectedIndexChanged="rbLanguageType_SelectedIndexChanged" 
                        meta:resourcekey="rbLanguageTypeResource1">
            <asp:ListItem Text="English" Value="0" Selected="True" 
                            meta:resourcekey="ListItemResource1"></asp:ListItem>
            <asp:ListItem Text="Native" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
          </asp:RadioButtonList>
        </div></td>
    </tr>--%>
    </table>
</div>
<div class="cssClassButtonWrapper cssClassbutton">
    <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Templates/Default/images/admin/btnSave.png"
                     OnClick="imbUpdate_Click" meta:resourcekey="imbUpdateResource1" />
    <asp:Label ID="lblAddLanguage" runat="server" Text="Save" CssClass="cssClassFormLabel"
               AssociatedControlID="imbUpdate" Style="cursor: pointer;" 
               meta:resourcekey="lblAddLanguageResource1"></asp:Label>
    <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/Templates/Default/images/admin/btncancel.png"
                     OnClick="imbCancel_Click" meta:resourcekey="imbCancelResource1" />
    <asp:Label ID="lblInstallLang" runat="server" CssClass="cssClassFormLabel" Text="Cancel"
               AssociatedControlID="imbCancel" Style="cursor: pointer;" 
               meta:resourcekey="lblInstallLangResource1"></asp:Label>
</div>