<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TimeZoneEditor.ascx.cs"
            Inherits="Modules_Language_TimeZoneEditor" %>

<h2 class="cssClassFormHeading">
    <asp:Label ID="lblTimeZoneEditor" runat="server" Text="Time Zone Editor" 
               meta:resourcekey="lblTimeZoneEditorResource1"></asp:Label>
</h2>
<div class="cssClassFormWrapper">
    <div class="cssClassAvailableLanguage"><asp:Label ID="lblAvailableLocales" runat="server" CssClass="cssClassFormLabel" 
                                                      Text="Available Locales" meta:resourcekey="lblAvailableLocalesResource1"></asp:Label>
        <asp:DropDownList ID="ddlAvailableLocales" runat="server" CssClass="cssClassDropDown"
                          AutoPostBack="True" 
                          OnSelectedIndexChanged="ddlAvailableLocales_SelectedIndexChanged" 
                          meta:resourcekey="ddlAvailableLocalesResource1"> </asp:DropDownList>
        <asp:Image ID="imgFlag" runat="server" meta:resourcekey="imgFlagResource1" />
    </div>
    <br />
    <div class="cssClassGridWrapper">
        <div class="cssClassTimeZoneEditorWrapper"><asp:GridView ID="gdvTimeZoneEditor" runat="server" AutoGenerateColumns="False" 
                                                                 Width="100%" meta:resourcekey="gdvTimeZoneEditorResource1">
                                                       <Columns>
                                                           <asp:TemplateField HeaderText="Name" meta:resourcekey="TemplateFieldResource1">
                                                               <ItemTemplate>
                                                                   <asp:TextBox ID="txtTimeZoneName" CssClass="cssClassNormalTextBox" runat="server"
                                                                                Text='<%# Eval("name") %>' meta:resourcekey="txtTimeZoneNameResource1"></asp:TextBox>
                                                               </ItemTemplate>
                                                           </asp:TemplateField>
                                                           <asp:BoundField DataField="key" HeaderText="Key" 
                                                                           meta:resourcekey="BoundFieldResource1" />
                                                           <asp:BoundField DataField="name" HeaderText="DefaultValue" 
                                                                           meta:resourcekey="BoundFieldResource2" />
                                                       </Columns>
                                                       <PagerStyle CssClass="cssClassPageNumber" />
                                                       <HeaderStyle CssClass="cssClassHeadingOne" />
                                                       <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                                                   </asp:GridView></div>
    </div>
</div>
<div class="cssClassButtonWrapper cssClassbutton">
    <asp:ImageButton ID="imbUpdate" runat="server" ImageUrl="~/Templates/Default/images/admin/btnsave.png"
                     Style="width: 16px" OnClick="imbUpdate_Click" 
                     meta:resourcekey="imbUpdateResource1" />
    <asp:Label ID="lblAddLanguage" runat="server" Text="Update" CssClass="cssClassFormLabel"
               AssociatedControlID="imbUpdate" Style="cursor: pointer;" 
               meta:resourcekey="lblAddLanguageResource1"></asp:Label>
    <asp:ImageButton ID="imbCancel" runat="server" ImageUrl="~/Templates/Default/images/admin/btncancel.png"
                     OnClick="imbCancel_Click" meta:resourcekey="imbCancelResource1" />
    <asp:Label ID="lblInstallLang" runat="server" CssClass="cssClassFormLabel" Text="Cancel"
               AssociatedControlID="imbCancel" Style="cursor: pointer;" 
               meta:resourcekey="lblInstallLangResource1"></asp:Label>
</div>