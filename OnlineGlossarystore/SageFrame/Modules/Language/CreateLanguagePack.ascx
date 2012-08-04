<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CreateLanguagePack.ascx.cs"
            Inherits="Localization_CreateLanguagePack" %>
<script type="text/javascript">
    $(document).ready(function() {
        if ($('.cssClassLanguagePackCreaterModule ul li input').length < 2) {
            $('#chkSelectAll').css("display", "none");
            $('#<%= lblSelectAll.ClientID %>').css("display", "none");
        }
        $('#chkSelectAll').bind("click", function() {

            if ($(this).attr("checked") == true) {
                CheckAll();
            } else {
                UnCheckAll();
            }


        });
    });

    function CheckAll() {
        var checks = $('.cssClassLanguagePackCreaterModule ul li input');
        $.each(checks, function(index, item) {

            $(this).attr("checked", true);
        });
    }

    function UnCheckAll() {
        var checks = $('.cssClassLanguagePackCreaterModule ul li input');
        $.each(checks, function(index, item) {

            $(this).attr("checked", false);
        });
    }

</script>

<h2 class="cssClassFormHeading">
    <asp:Label ID="lblLanguagePackCreator" runat="server" Text="Language Pack Creator" 
               meta:resourcekey="lblTimeZoneEditorResource1"></asp:Label>
</h2>
<div class="cssClassFormWrapper">
    <table width="100%" cellpadding="0" cellspacing="0">
        <tr>
            <td width="20%"><asp:Label runat="server" ID="lblResoucreLocale" CssClass="cssClassFormLabel" 
                                       meta:resourcekey="lblResoucreLocaleResource1" Text="Resource Locale:"></asp:Label></td>
            <td width="80%"><asp:DropDownList ID="ddlResourceLocale" CssClass="cssClassDropDown"  
                                              runat="server" AutoPostBack="True"
                                              OnSelectedIndexChanged="ddlResourceLocale_SelectedIndexChanged" 
                                              meta:resourcekey="ddlResourceLocaleResource1"> </asp:DropDownList></td>
        </tr>
        <tr>
            <td><asp:Label runat="server" ID="lblResoucrePackType" CssClass="cssClassFormLabel" 
                           meta:resourcekey="lblResoucrePackTypeResource1" Text="Resource Pack Type:"></asp:Label></td>
            <td class="cssClassButtonListWrapper"><asp:RadioButtonList ID="rbResourcePackType" CssClass="cssClassRadioButtonList" 
                                                                       RepeatDirection="Horizontal" runat="server" AutoPostBack="True" 
                                                                       OnSelectedIndexChanged="rbResourcePackType_SelectedIndexChanged" 
                                                                       meta:resourcekey="rbResourcePackTypeResource1">
                                                      <asp:ListItem Text="Core" Selected="True" Value="Core" 
                                                                    meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                      <asp:ListItem Text="Module" Value="Module" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                      <%-- <asp:ListItem Text="Provider" Value="Provider"></asp:ListItem>
                        <asp:ListItem Text="Authentication System" Value="Authentication"></asp:ListItem>--%>
                                                      <asp:ListItem Text="Full" Value="Full" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                  </asp:RadioButtonList></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td><div id="divModuleDetails" runat="server" class="cssClassLanguagePackCreaterModule">
                    <h2> Please select the modules to include in the language pack</h2>
                    <input type="checkbox" ID="chkSelectAll" />
                    <asp:Label ID="lblSelectAll" runat="server" CssClass="cssClassFormLabel" 
                               meta:resourcekey="lblSelectAllResource1">Select All</asp:Label>
                    <ul><asp:Repeater ID="rptrModules" runat="server">
                            <ItemTemplate>
              
                                <li><asp:CheckBox ID="chkSelect" runat="server" 
                                                  meta:resourcekey="chkSelectResource1" />
                                    <asp:Label ID="lblModuleName" runat="server" Text='<%# Eval("ModuleName") %>' 
                                               meta:resourcekey="lblModuleNameResource1"></asp:Label></li>
              
                            </ItemTemplate>
                        </asp:Repeater></ul>
                </div></td>
        </tr>
        <tr>
            <td><asp:Label runat="server" ID="lblResourcePackName" CssClass="cssClassFormLabel" 
                           meta:resourcekey="lblResourcePackNameResource1" Text="Resource Pack Name"></asp:Label></td>
            <td> ResourcePack
                <asp:TextBox ID="txtResourcePackName" runat="server" Width="120px" 
                             meta:resourcekey="txtResourcePackNameResource1" Text="Core" CssClass="cssClassNormalTextBox"></asp:TextBox>
                .&lt;version&gt;.&lt;locale&gt;.zip </td>
        </tr>
        <tr>
            <td>
                <asp:Label runat="server" ID="lblDownLoadPathLabel" CssClass="cssClassFormLabel" 
                           meta:resourcekey="lblDownLoadPathLabelResource1">Download Package:</asp:Label> 
            </td>
            <td>
                <asp:LinkButton ID="lnkBtnDownloadPackage" runat="server" 
                                onclick="lnkBtnDownloadPackage_Click" 
                                meta:resourcekey="lnkBtnDownloadPackageResource1"></asp:LinkButton>
            </td>
        </tr>
    </table>
</div>
<div class="cssClassButtonWrapper cssClassbutton">
    <asp:ImageButton ID="imbCreatePackage" runat="server" ImageUrl="~/Templates/Default/images/admin/btncreatepackage.png"
                     OnClick="imbCreatePackage_Click" 
                     meta:resourcekey="imbCreatePackageResource1" />
    <asp:Label ID="lblAddLanguage" runat="server" Text="Create" CssClass="cssClassFormLabel"
               AssociatedControlID="imbCreatePackage" Style="cursor: pointer;" 
               meta:resourcekey="lblAddLanguageResource1"></asp:Label>
    <asp:ImageButton ID="imbCancel" runat="server" OnClick="imbCancel_Click" 
                     ImageUrl="~/Templates/Default/images/admin/btncancel.png" 
                     meta:resourcekey="imbCancelResource1" />
    <asp:Label ID="lblInstallLang" runat="server" CssClass="cssClassFormLabel" Text="Cancel"
               AssociatedControlID="imbCancel" Style="cursor: pointer;" 
               meta:resourcekey="lblInstallLangResource1"></asp:Label>
</div>