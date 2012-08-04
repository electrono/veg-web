<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LocalPage.ascx.cs" Inherits="Modules_LocalPage_LocalPage" %>

<script type="text/javascript">
    var Localization = {
        TextAreaID: 0,
        FilePath: "",
        ID: 0,
        GridID: '<%= gdvLocalPage.ClientID %>'
    };

    $(document).ready(function() {
        BindListMenu();
        $('#' + Localization.GridID + ' img[class="cssClassTranslate"]').live("click", function() {
            var index = $(this).attr("alt");
            Localization.ID = index;
            var data = $('#' + Localization.GridID + ' input[title="' + index + '"]').val();
            $('#MenuSourceTxt').val(data);
            ShowPopUp("MenuTranslatorDiv");
        });

        $('#' + Localization.GridID + ' img[class="cssClassEdit"]').live("click", function() {
            var index = $(this).attr("alt");
            Localization.ID = index;
            var data = $('#' + Localization.GridID + ' input[title="' + index + '"]').val();
            $('#txtPageValueEditor').val(data);
            ShowPopUp("MenuEditorDiv");

        });
        $('#txtPageValueEditor').ckeditor("config");
        BindEvents();

    });

    function BindEvents() {
        $('#fade').click(function() {
            $('#fade,#MenuEditorDiv,#MenuTranslatorDiv').fadeOut();
        });
        $('#MenubtnCloseFB').bind("click", function() {
            var id = Localization.ID;
            $('#' + Localization.GridID + ' input[title="' + id + '"]').val($('#txtPageValueEditor').val());
            $('#MenuEditorDiv,#fade').fadeOut();
        });
        $('.closePopUp').bind("click", function() {
            $('#fade,#MenuEditorDiv,#MenuTranslatorDiv').fadeOut();
        });

        $('#MenubtnSave').bind("click", function() {
            var id = Localization.ID;
            $('#' + Localization.GridID + ' input[title="' + id + '"]').val($('#MenutranslatedTxt').val());
            $('#MenuTranslatorDiv,#fade').fadeOut();
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


    }

    function translate() {
        var source = $('#MenuSourceTxt').val();
        var to = $('#MenuddlTranslateTo option:selected').val();
        var from = $('#MenuddlCultureSelect option:selected').val();
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
                $('#MenutranslatedTxt').val(translated);

            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("error in translation");
            }
        });
    }

    function BindListMenu() {
        $.each(Languages, function(key, value) {
            if (value == "en") {
                $("#MenuddlCultureSelect").append($("<option selected='selected'></option>").val(value).html(key));
            } else {
                $("#MenuddlCultureSelect").append($("<option></option>").val(value).html(key));
            }
            $("#MenuddlTranslateTo").append($("<option></option>").val(value).html(key));
        });

    }
</script>

<div id="fade">
</div>
<div class="cssClassFormWrapper">
    <div class="cssClassAvailableLanguage">
        <asp:Label ID="lblAvailableLocales" runat="server" CssClass="cssClassFormLabel" Text="Available Locales"
                   meta:resourcekey="lblAvailableLocalesResource1"></asp:Label>
        <asp:DropDownList ID="ddlAvailableLocales" runat="server" CssClass="cssClassDropDown"
                          AutoPostBack="True" OnSelectedIndexChanged="ddlAvailableLocales_SelectedIndexChanged"
                          meta:resourcekey="ddlAvailableLocalesResource1">
        </asp:DropDownList>
        <asp:Image ID="imgFlag" runat="server" meta:resourcekey="imgFlagResource1" />
    </div>
    <div class="cssClassGridWrapper">
        <asp:GridView ID="gdvLocalPage" class="cssClassKeyValueGrid" DataKeyNames="PageID"
                      runat="server" Width="100%" AutoGenerateColumns="False"
                      OnSelectedIndexChanged="gdvLocalPage_SelectedIndexChanged" OnSelectedIndexChanging="gdvLocalPage_SelectedIndexChanging"
                      OnPageIndexChanging="gdvLocalPage_PageIndexChanging">
            <Columns>
                <asp:TemplateField HeaderText="S.N">
                    <ItemTemplate>
                        <%# Container.DataItemIndex + 1 %>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Default Values">
                    <ItemTemplate>
                        <asp:Label ID="lbldefaultValue" runat="server" Text='<%# Eval("PageName") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Local Values" meta:resourcekey="TemplateFieldResource6">
                    <ItemTemplate>
                        <asp:TextBox ID="txtLocalPageName" ToolTip="<%# Container.DataItemIndex + 1 %>" runat="server"
                                     CssClass="cssClassNormalTextBox" Text='<%# Eval("LocalPageName") %>'></asp:TextBox>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField meta:resourcekey="TemplateFieldResource7">
                    <ItemTemplate>
                        <ul class="cssClassLocButtons">
                            <li>
                                <asp:Image ID="imgEditResxValue" CssClass="cssClassEdit" AlternateText="<%# Container.DataItemIndex + 1 %>"
                                           runat="server" ImageUrl="~/Templates/Default/images/admin/btnedit.png" meta:resourcekey="imgEditResxValueResource1" />
                            </li>
                            <li>
                                <asp:Image ID="Image1" runat="server" CssClass="cssClassTranslate" AlternateText="<%# Container.DataItemIndex + 1 %>"
                                           ImageUrl="~/Modules/Language/css/images/table_refresh.png" meta:resourcekey="Image1Resource1" />
                            </li>
                        </ul>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle CssClass="cssClassHeadingOne" />
            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
            <RowStyle CssClass="cssClassAlternativeOdd" />
        </asp:GridView>
    </div>
    <div class="cssClassButtonWrapper cssClassbutton">
        <asp:ImageButton ID="imbUpdate" runat="server" meta:resourcekey="imbUpdateResource1"
                         OnClick="imbUpdate_Click" Style="height: 16px" />
        <asp:Label ID="lblUpdateResxFile" runat="server" Text="Save" CssClass="cssClassFormLabel"
                   AssociatedControlID="imbUpdate" Style="cursor: pointer;" meta:resourcekey="lblUpdateResxFileResource1"></asp:Label>
        <asp:ImageButton ID="imbCancel" runat="server" 
                         meta:resourcekey="imbCancelResource1" onclick="imbCancel_Click" />
        <asp:Label ID="Label2" runat="server" CssClass="cssClassFormLabel" Text="Back" AssociatedControlID="imbCancel"
                   Style="cursor: pointer;" meta:resourcekey="Label2Resource1"></asp:Label>
    </div>
</div>
<div id="MenuEditorDiv" class="invisibleDiv">
    <div class="cssClassResxEditorPopUP">
        <span class="closePopUp">
            <img src="<%= path %>images/closelabel.png" id="imgCancelCopy" /></span>
        <textarea id="txtPageValueEditor" class="editor"></textarea>
        <input type="button" id="MenubtnCloseFB" value="Save" class="cssClassPopUpBtn" />
    </div>
</div>
<div id="MenuTranslatorDiv" class="invisibleDiv">
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
                    <textarea id="MenuSourceTxt" rows="4" cols="50"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <select id="MenuddlCultureSelect">
                    </select>
                </td>
                <td class="cssClassTranslate">
                    <span onclick=" translate() " id="MenuimbTranslate">Translate</span>
                    <!--<img src="/Sageframe/Modules/Language/images/googletranslate.png" alt="Translate" onclick=" translate() "
                             id="imbTranslate" />-->
                </td>
                <td>
                    <select id="MenuddlTranslateTo">
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
                    <textarea id="MenutranslatedTxt" rows="4" cols="50"></textarea>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <input type="button" id="MenubtnSave" value="Save" class="cssClassPopUpBtn" />
                </td>
            </tr>
        </table>
    </div>
</div>