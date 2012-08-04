<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LanguageManager.ascx.cs"
            Inherits="Localization_Language" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="~/Modules/Language/CreateLanguagePack.ascx" TagName="CreateLanguagePack"
             TagPrefix="uc1" %>
<%@ Register Src="~/Modules/Language/LanguagePackInstaller.ascx" TagName="LanguagePackInstaller"
             TagPrefix="uc2" %>
<%@ Register Src="~/Modules/Language/LanguageSetUp.ascx" TagName="LanguageSetUp"
             TagPrefix="uc3" %>
<%@ Register Src="~/Modules/Language/TimeZoneEditor.ascx" TagName="TimeZoneEditor"
             TagPrefix="uc4" %>
<%@ Register Src="~/Modules/Language/LocalPage.ascx" TagName="MenuEditor"
             TagPrefix="uc5" %>
  
    
<script type="text/javascript">
    $.Localization = {
        TextAreaID: 0,
        FilePath: "",
        ID: 0,
        GridID: '<%= gdvResxKeyValue.ClientID %>'
    };
    $(document).ready(function() {
        BindList();
        $('#' + $.Localization.GridID + ' img[class="cssClassTranslate"]').live("click", function() {
            var index = $(this).attr("alt");
            $.Localization.ID = index;
            var data = $('#' + $.Localization.GridID + ' textarea[title="' + index + '"]').val();
            $('#sourceTxt').val(data);
            ShowPopUp("translatorDiv");
        });

        $('#' + $.Localization.GridID + ' img[class="cssClassEdit"]').live("click", function() {
            var index = $(this).attr("alt");
            $.Localization.ID = index;
            var data = $('#' + $.Localization.GridID + ' textarea[title="' + index + '"]').val();
            $('#txtResxValueEditor').val(data);
            ShowPopUp("editorDiv");

        });
        //$('#txtResxValueEditor').CKEDITOR("config");    
        var html = "Initially Text if necessary";
        var config = { };
        editor = CKEDITOR.appendTo('txtResxValueEditor', config, html);
        BindEvents();

    });

    function BindEvents() {
        $('#fade').click(function() {
            $('#fade,#editorDiv,#translatorDiv,#divMessagePopUp,#divConfirmPopUp').fadeOut();
        });
        $('#btnCloseFB').bind("click", function() {
            var id = $.Localization.ID;
            $('#' + $.Localization.GridID + ' textarea[title="' + id + '"]').val($('#txtResxValueEditor').val());
            $('#editorDiv,#fade').fadeOut();
        });
        $('.closePopUp').bind("click", function() {
            $('#fade,#editorDiv,#translatorDiv,#divMessagePopUp,#divConfirmPopUp').fadeOut();
        });

        $('#btnSave').bind("click", function() {
            var id = $.Localization.ID;
            $('#' + $.Localization.GridID + ' textarea[title="' + id + '"]').val($('#translatedTxt').val());
            $('#translatorDiv,#fade').fadeOut();
        });


    }

    function ShowPopUp(popupid) {

        $('#' + popupid).fadeIn();
        $('body').append('<div id="fade"></div>');
        $('#fade').css({ 'filter': 'alpha(opacity=80)' }).fadeIn();
        var popuptopmargin = ($('#' + popupid).height() + 10) / 2;
        var popupleftmargin = ($('#' + popupid).width() + 10) / 2;
        $('#' + popupid).css({
            'margin-top': -popuptopmargin,
            'margin-left': -popupleftmargin
        });

        switch (popupid) {
        case "uploadFilePopUp":
            ImageUploader();
            break;
        }

    }

    function translate() {
        var source = $('#sourceTxt').val();
        var to = $('#ddlTranslateTo option:selected').val();
        var from = $('#ddlCultureSelect option:selected').val();
        var code = from + "|" + to;
        $.ajax({
            url: 'https://ajax.googleapis.com/ajax/services/language/translate',
            dataType: 'jsonp',
            data: {
                q: source,  // text to translate
                v: '1.0',
                langpair: code
            },
            success: function(result) {
                var translated = result.responseData.translatedText;
                $('#translatedTxt').val(translated);

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("error in translation");
            }
        });
    }
</script>


      
<div id="divActivityIndicator">
 
</div>
<div id="fade"></div>    
<div id="langEditFirstDiv" runat="server">
    <h2 class="cssClassFormHeading">
        <asp:Label ID="lblTimeZoneEditor" runat="server" Text="Language Manager" meta:resourcekey="lblTimeZoneEditorResource1"></asp:Label>
    </h2>
    <div class="cssClassFormWrapper">
        <asp:HiddenField ID="hdnCultureCode" runat="server" Value="en-US" />
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblSysDefault" runat="server" Text="System Default:" CssClass="cssClassFormLabel"
                               meta:resourcekey="lblSysDefaultResource1"></asp:Label>
                </td>
                <td>
                    <asp:Image ID="imgFlagSystemDefault" runat="server" 
                               meta:resourcekey="imgFlagSystemDefaultResource2" />
                    <asp:Label ID="lblSystemDefault" runat="server" meta:resourcekey="lblSystemDefaultResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCurrentCultureLbl" runat="server" Text="Current Culture:" CssClass="cssClassFormLabel"
                               meta:resourcekey="lblCurrentCultureLblResource1"></asp:Label>
                </td>
                <td>
                    <asp:Image ID="imgFlagCurrentCulture" runat="server" meta:resourcekey="imgFlagCurrentCultureResource1" />
                    <asp:Label ID="lblCurrentCulture" runat="server" meta:resourcekey="lblSiteDefaultResource1"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <!--<label style="font-weight: bold; color: Red">
                            The default site language cannot be disabled</label>-->
                    <span class="cssClassDefaultLanguage">The default site language cannot be disabled</span>
                </td>
                <td>
                </td>
                <td width="110">
                    <asp:Label ID="lblPageSize" runat="server" Text="Page Size:" CssClass="cssClassFormLabel"
                               meta:resourcekey="lblPageSizeResource1"></asp:Label>
                    <asp:DropDownList ID="ddlPageSize" runat="server" CssClass="cssClasslistddl" AutoPostBack="True"
                                      OnSelectedIndexChanged="ddlPageSize_SelectedIndexChanged1" meta:resourcekey="ddlPageSizeResource1">
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
        <div class="cssClassGridWrapper">
            <asp:GridView ID="gdvLangList" runat="server" GridLines="None" AllowPaging="True"
                          Width="100%" AutoGenerateColumns="False" OnRowCommand="gdvLangList_RowCommand"
                          OnRowDataBound="gdvLangList_RowDataBound" meta:resourcekey="gdvLangListResource1"
                          OnPageIndexChanging="gdvLangList_PageIndexChanging" DataKeyNames="LanguageID">
                <Columns>
                    <asp:TemplateField HeaderText="Language" meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <asp:Image ID="imgFlag" runat="server" meta:resourcekey="imgFlagResource2" />
                            <span class="cssClassLangName">
                                <asp:Label ID="lblLanguageName" runat="server" Text='<%# Eval("LanguageN") %>' meta:resourcekey="lblLanguageNameResource1"></asp:Label></span>
                            <span class="cssClassCountry">(<asp:Label ID="lblCountryName" runat="server" 
                                                                      Text='<%# Eval("Country") %>' meta:resourcekey="lblCountryNameResource1"></asp:Label>)
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="LanguageCode" HeaderText="Code" meta:resourcekey="BoundFieldResource1">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:TemplateField HeaderText="IsEnabled" meta:resourcekey="TemplateFieldResource2">
                        <ItemTemplate>
                            <asp:CheckBox ID="chkIsEnabled" runat="server" meta:resourcekey="chkIsEnabledResource2"
                                          OnCheckedChanged="chkIsEnabled_CheckedChanged" AutoPostBack="True" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle CssClass="cssClassIsLangEnabled" />
                    </asp:TemplateField>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnLanguageDel" runat="server" ImageUrl="~/Templates/Default/images/admin/btnedit.png"
                                             CommandName="EditResources" CommandArgument='<%# Container.DataItemIndex %>'
                                             meta:resourcekey="btnLanguageDelResource1" />
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Center" />
                        <HeaderStyle CssClass="cssClassColumnEdit" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="LanguageID" meta:resourcekey="BoundFieldResource2" />
                </Columns>
                <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                <HeaderStyle CssClass="cssClassHeadingOne" />
                <PagerStyle CssClass="cssClassPageNumber" />
                <RowStyle CssClass="cssClassAlternativeOdd" />
            </asp:GridView>
        </div>
        <div class="cssClassButtonWrapper cssClassbutton">
            <asp:ImageButton ID="imbAddLanguage" runat="server" OnClick="imbAddLanguage_Click"
                             meta:resourcekey="imbAddLanguageResource1" />
            <asp:Label ID="lblAddLanguage" runat="server" Text="Add Language" AssociatedControlID="imbAddLanguage"
                       Style="cursor: pointer;" meta:resourcekey="lblAddLanguageResource1"></asp:Label>
            <asp:ImageButton ID="imbInstallLang" runat="server" OnClick="imbInstallLang_Click"
                             meta:resourcekey="imbInstallLangResource1" />
            <asp:Label ID="lblInstallLang" runat="server" Text="Install Language Pack" AssociatedControlID="imbInstallLang"
                       Style="cursor: pointer;" meta:resourcekey="lblInstallLangResource1"></asp:Label>
            <asp:ImageButton ID="imbCreateLangPack" runat="server" OnClick="imbCreateLangPack_Click"
                             meta:resourcekey="imbCreateLangPackResource1" />
            <asp:Label ID="lblCreateLangPack" runat="server" Text="Create Language Pack" AssociatedControlID="imbCreateLangPack"
                       Style="cursor: pointer;" meta:resourcekey="lblCreateLangPackResource1"></asp:Label>
            <asp:ImageButton ID="imbEditTimeZone" runat="server" OnClick="imbEditTimeZone_Click"
                             meta:resourcekey="imbEditTimeZoneResource1" />
            <asp:Label ID="lblEditTimeZone" runat="server" Text="Time Zone Editor" AssociatedControlID="imbEditTimeZone"
                       Style="cursor: pointer;" meta:resourcekey="lblEditTimeZoneResource1"></asp:Label>
            <asp:ImageButton ID="imbLocalizeMenu" OnClick="imbLocalizeMenu_Click" runat="server" 
                             meta:resourcekey="imbEditTimeZoneResource1" style="width: 14px" />
            <asp:Label ID="Label1" runat="server" Text="Localize Menu" AssociatedControlID="imbLocalizeMenu"
                       Style="cursor: pointer;"></asp:Label>
        </div>
    </div>
</div>
<%--       </ContentTemplate>
    <Triggers>
        <asp:PostBackTrigger ControlID="imbInstallLang" />
    </Triggers>
</asp:UpdatePanel>--%>
        
<div id="langEditSecondDiv" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <h2 class="cssClassFormHeading">
                <asp:Label ID="lblLanguageResourceEditor" runat="server" Text="Language Resource Editor"
                           meta:resourcekey="lblLanguageResourceEditorResource1"></asp:Label>
            </h2>
            <div class="myFormWrapper">
                <div class="cssClassLocTreeViewWrapper">
                    <asp:TreeView ID="tvList" SelectedNodeStyle-CssClass="cssClassSelectedNode" 
                                  runat="server" ImageSet="Msdn" 
                                  OnSelectedNodeChanged="tvList_SelectedNodeChanged" 
                                  meta:resourcekey="tvListResource1">
                        <SelectedNodeStyle CssClass="cssClassSelectedNode"></SelectedNodeStyle>
                    </asp:TreeView>
                </div>
                <div class="cssClassResourceEditorOuter">
                    <div class="cssClassLanguageEditTopInfo">
                        <ul class="cssClassSelectLanguage">
                            <li class="cssClassFirst">Selected Language:</li>
                            <li><span>
                                    <asp:Image ID="imgSelectedLang" runat="server" alt="image" 
                                               meta:resourcekey="imgSelectedLangResource1" /></span></li>
                            <li><span id="spnSelLang"><b>
                                                          <asp:Label ID="lblSelectedLanguage" runat="server" CssClass="cssClassFormLabel" 
                                                                     meta:resourcekey="lblSelectedLanguageResource1"></asp:Label></b></span><b></li>
                        </ul>
                        <ul class="cssClassSelectFolder">
                            <li class="cssClassFirst"><span>Selected Folder:</span></li>
                            <li><span id="spnFold">
                                    <asp:Label ID="lblSelectedFolder" runat="server" CssClass="cssClassFormLabel" 
                                               meta:resourcekey="lblSelectedFolderResource1"></asp:Label></span></li>
                        </ul>
                        <ul class="cssClassResourcesFile">
                            <li class="cssClassFirst">Resource File:</li>
                            <li><span id="spnResx">
                                    <asp:Label ID="lblSelectedFile" runat="server" CssClass="cssClassFormLabel" 
                                               meta:resourcekey="lblSelectedFileResource1"></asp:Label></span></li>
                            <li><span id="spnDefaultFlag" class="cssClassDisplayNone">[Default File]</span></li>
                        </ul>
                        <!--<p class="cssClassSelectedLanguage"> <span>Selected Language:</span> <span><img id="imgSelectedLang" alt="image" src="" /></span> <span id="spnSelLang"></span><span id="spnLanguageName"></span></p>-->
                        <!--<p class="cssClassSelectedFolder"> <span>Selected Folder:</span><span id="spnFold"></span></p>-->
                        <!--<p class="cssClassSelectedFiles"> Resource File: <span id="spnResx"></span><span id="spnDefaultFlag" class="cssClassDisplayNone"> [Default File]</span> </p>-->
                        <div class="cssClassclear">
                        </div>
                    </div>
                    <br />
                    <div class="cssClassGridWrapper">
                        <asp:GridView ID="gdvResxKeyValue" class="cssClassKeyValueGrid" runat="server" Width="100%" AutoGenerateColumns="False"
                                      OnRowDataBound="gdvResxKeyValue_RowDataBound" 
                                      meta:resourcekey="gdvResxKeyValueResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="Default Values" 
                                                   meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <div class="cssClassResxDefKey">
                                            <ul>
                                                <li>
                                                    <asp:Label runat="server" ID="lblKey" Text='<%# Eval("Key") %>' 
                                                               class="cssClassKeyValue" meta:resourcekey="lblKeyResource1"></asp:Label>
                                                </li>
                                                <li class="cssClassResxDefValue">
                                                    <%# Eval("DefaultValue") %></li>
                                            </ul>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Local Values" 
                                                   meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <div class="cssClassLocalValueDiv">
                                            <ul>
                                                <li style="height: 15px"></li>
                                                <li>
                                                    <asp:TextBox ID="txtResxValue" ToolTip="<%# Container.DataItemIndex + 1 %>"
                                                                 runat="server" TextMode="MultiLine" CssClass="cssClassResxValueTxt" 
                                                                 Text='<%# Eval("Value") %>'></asp:TextBox>
                                                
                                               
                                                </li>
                                            </ul>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <ul class="cssClassLocButtons">
                                            <li style="height: 18px"></li>
                                            <li>
                                                <asp:Image ID="imgEditResxValue" CssClass="cssClassEdit" AlternateText="<%# Container.DataItemIndex + 1 %>"
                                                           runat="server" ImageUrl="~/Templates/Default/images/admin/btnedit.png" 
                                                           meta:resourcekey="imgEditResxValueResource1" />
                                            </li>
                                            <li>
                                                <asp:Image ID="Image1" runat="server" CssClass="cssClassTranslate" AlternateText="<%# Container.DataItemIndex + 1 %>"
                                                           ImageUrl="~/Modules/Language/css/images/table_refresh.png" 
                                                           meta:resourcekey="Image1Resource1" />
                                            </li>
                                        </ul>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="cssClassHeadingOne" />
                            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />                       
                       
                            <RowStyle CssClass="cssClassAlternativeOdd" />
                        </asp:GridView>
                        <%-- <asp:Panel CssClass="cssClassNoData" id="divNoData" runat="server">
                No Data Present
                </asp:Panel>--%>
                    </div>
                    <div class="cssClassButtonWrapper cssClassbutton">
                        <asp:ImageButton ID="imbUpdate" runat="server" 
                                         onclick="imbUpdate_Click" meta:resourcekey="imbUpdateResource1" />
                        <asp:Label ID="lblUpdateResxFile" runat="server" Text="Save" CssClass="cssClassFormLabel"
                                   AssociatedControlID="imbUpdate" Style="cursor: pointer;" 
                                   meta:resourcekey="lblUpdateResxFileResource1"></asp:Label>
                        <asp:ImageButton ID="imbCancel" runat="server" 
                                         onclick="imbCancel_Click" meta:resourcekey="imbCancelResource1" />
                        <asp:Label ID="Label2" runat="server" CssClass="cssClassFormLabel" Text="Back"
                                   AssociatedControlID="imbCancel" Style="cursor: pointer;" 
                                   meta:resourcekey="Label2Resource1"></asp:Label>
                        <asp:ImageButton ID="imbDeleteResxFile" runat="server" 
                                         onclick="imbDeleteResxFile_Click" meta:resourcekey="imbDeleteResxFileResource1" 
                            />
                        <asp:Label ID="lblDeleteResx" runat="server" CssClass="cssClassFormLabel" Text="Delete File"
                                   AssociatedControlID="imbDeleteResxFile" Style="cursor: pointer;" 
                                   meta:resourcekey="lblDeleteResxResource1"></asp:Label>
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="imbCancel" />
        </Triggers>
    </asp:UpdatePanel>
    
    <div id="editorDiv" class="invisibleDiv">
        <div class="cssClassResxEditorPopUP">
            <span class="closePopUp">
                <img src="<%= path %>images/closelabel.png" id="imgCancelCopy" /></span>
            <textarea id="txtResxValueEditor" class="editor"></textarea>
            <input type="button" id="btnCloseFB" value="Save" class="cssClassPopUpBtn" />
        </div>
    </div>
    <div id="translatorDiv" class="invisibleDiv">
        <div class="cssClassResxEditorPopUP">
            <span class="closePopUp">
                <img src="<%= path %>images/closelabel.png" id="img1" /></span>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td colspan="3">
                        <span class="cssClassFormLabel">Translate Text: </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <textarea id="sourceTxt" rows="4" cols="50"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <select id="ddlCultureSelect">
                        </select>
                    </td>
                    <td class="cssClassTranslate">
                        <span onclick=" translate() " id="imbTranslate">Translate</span>
                        <!--<img src="/Sageframe/Modules/Language/images/googletranslate.png" alt="Translate" onclick=" translate() "
                                 id="imbTranslate" />-->
                    </td>
                    <td>
                        <select id="ddlTranslateTo">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <span class="cssClassFormLabel">Translated Text: </span>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <textarea id="translatedTxt" rows="4" cols="50"></textarea>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <input type="button" id="btnSave" value="Save" class="cssClassPopUpBtn" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>
<uc3:LanguageSetUp runat="server" ID="ctrl_LanguagePackSetup" />
<uc1:CreateLanguagePack runat="server" ID="CreateLanguagePack1" />
<uc4:TimeZoneEditor ID="ctrl_TimeZoneEditor" runat="server" />
<uc5:MenuEditor ID="ctrl_MenuEditor" runat="server"/>
        
<br />

<uc2:LanguagePackInstaller runat="server" ID="LanguagePackInstaller1" />

<div id="divMessagePopUp" class="popupbox">
    <div class="cssClassLocalizationPopUp" style="text-align: center">
        <span class="closePopUp">
            <img src="<%= path %>images/closelabel.png" id="img2" /></span> <span class="cssClassMessage cssClassLabel">
                                                                          </span>
    </div>
</div>   
<div id="divConfirmPopUp" class="popupbox">
    <div class="cssClassLocalizationPopUp" style="text-align: center">
        <span class="closePopUp">
            <img src="<%= path %>images/closelabel.png" id="imgConfirmDelete" /></span><span class="cssClassConfirmMessage cssClassLabel">
                                                                                     </span>
        <div class="cssClassButtonWrapper" style="text-align: center">
            <input type="button" id="btnConfirmYes" value="Yes" class="cssClassBtn" />
            <input type="button" id="btnConfirmNo" value="No" class="cssClassBtn" />
        </div>
    </div>
</div>