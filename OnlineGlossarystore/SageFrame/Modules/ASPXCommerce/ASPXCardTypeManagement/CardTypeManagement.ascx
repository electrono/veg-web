<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CardTypeManagement.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCardTypeManagement_CardTypeManagement" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var CultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAlldiv();
        LoadCardTypeStaticImage();
        $('#divCardTypeDetail').show();
        BindCardTypeInGrid(null, null);

        $("#btnBack").click(function() {
            $("#divCardTypeDetail").show();
            $("#divEditCardType").hide();
        })

        $('#btnAddNew').click(function() {
            $('#divCardTypeDetail').hide();
            $('#divEditCardType').show();
            $("#btnReset").show();
            ClearForm();
        })

        $('#btnReset').click(function() {
            ResetForm();
        })

        $('#btnDeleteSelected').click(function() {
            var _cardTypeIds = '';
            //Get the multiple Ids of the attribute selected
            $("#tblCardTypeDetails .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    _cardTypeIds += $(this).val() + ',';
                }
            });
            if (_cardTypeIds != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultiple(_cardTypeIds, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Card Types?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Card Type before you can do this.<br/> To select one or more Card Type, just check the box before each Card Type.</p>');
            }
        })

        $('#btnSaveCardType').click(function() {

            var validCard = $("#form1").validate({
                messages: {
                    CardTypeName: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    }
                }
            });
            if (validCard.form()) {
                var cardType_id = $(this).attr("name");
                if (cardType_id != '') {
                    SaveCardType(cardType_id, storeId, portalId, userName, CultureName);
                } else {
                    SaveCardType(0, storeId, portalId, userName, CultureName);
                }
            }
        })
        ImageUploader();
    });

    function LoadCardTypeStaticImage() {
        $('#ajaxCardTypeImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ClearForm() {
        $("#btnSaveCardType").removeAttr("name");
        $("#<%= lblHeading.ClientID %>").html("Add New Card ");

        $('#txtCardTypeName').val('');
        $("#chkIsActiveCardType").removeAttr('checked');
        $("#hdnPrevFilePath").val("");
        $('#divCardImage').html('');
        $("#txtCardAlternateText").val('');
        $('#cardTypeImageBrowser').val('');
        RemoveLabel();
    }

    function ResetForm() {
        $('#txtCardTypeName').val('');
        $("#chkIsActiveCardType").removeAttr('checked');
        $('#divCardImage').html('');
        RemoveLabel();
    }

    function RemoveLabel() {
        $('#txtCardTypeName').removeClass('error');
        $('#txtCardTypeName').parents('td').find('label').remove();
    }

    function HideAlldiv() {

        $('#divCardTypeDetail').hide();
        $('#divEditCardType').hide();
    }

    Boolean.parse = function(str) {
        // alert(str.toLowerCase());
        switch (str.toLowerCase()) {
        case "yes":
            return true;
        case "no":
            return false;
        default:
            return false;
        }
    };

    function BindCardTypeInGrid(cardTypeName, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#tblCardTypeDetails_pagesize").length > 0) ? $("#tblCardTypeDetails_pagesize :selected").text() : 10;
        $("#tblCardTypeDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllCardTypeList',
            colModel: [
                { display: 'Card Type ID', name: 'CardTypeID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '2', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'Card Type Name', name: 'CardTypeName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is System Used', name: 'Is_System_Used', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'IsActive', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'IsDeleted', name: 'IsDeleted', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No', hide: true },
                { display: 'ImagePath', name: 'ImagePath', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'AlternateText', name: 'AlternateText', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCardType', arguments: '1,2,3,5,6' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCardType', arguments: '2' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, CultureName: CultureName, CardTypeName: cardTypeName, IsActive: isAct },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function EditCardType(tblID, argus) {
        switch (tblID) {
        case "tblCardTypeDetails":
            if (argus[4].toLowerCase() != "yes") {
                ClearForm();
                $('#divCardTypeDetail').hide();
                $('#divEditCardType').show();
                $("#<%= lblHeading.ClientID %>").html("Edit Card Type: " + argus[3]);
                $('#txtCardTypeName').val(argus[3]);
                $("#chkIsActiveCardType").attr('checked', Boolean.parse(argus[5]));
                $("#btnSaveCardType").attr("name", argus[0]);
                $("#hdnPrevFilePath").val(argus[6]);
                $("#txtCardAlternateText").val(argus[7]);
                if (argus[6] != '') {
                    $("#divCardImage").html('<img src="' + aspxRootPath + argus[6] + '" class="uploadImage" height="90px" width="100px"/></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage()" alt="Delete"/>');
                }
                $("#btnReset").hide();
                $("#cardTypeImageBrowser").removeAttr('name');
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t edit system used Card Type.</p>');
            }
            break;
        default:
            break;
        }
    }

    function SaveCardType(CardTypeId, storeId, portalId, userName, CultureName) {
        var CardTypeName = $('#txtCardTypeName').val();
        var IsActive = $("#chkIsActiveCardType").attr('checked');
        var prevFilePath = $("#hdnPrevFilePath").val();
        var newImagePath = '';
        if ($("#divCardImage>img").length > 0) {

            newImagePath = $("#cardTypeImageBrowser").attr('name');
        }

        var alternateText = $("#txtCardAlternateText").val();

        var functionName = 'AddUpdateCardType';
        var params = { StoreID: storeId, PortalID: portalId, CultureName: CultureName, UserName: userName, CardTypeID: CardTypeId, CardTypeName: CardTypeName, IsActive: IsActive, NewFilePath: newImagePath, PrevFilePath: prevFilePath, AlternateText: alternateText };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {

                BindCardTypeInGrid(null, null);
                ClearForm();
                $('#divCardTypeDetail').show();
                $('#divEditCardType').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to edit Card Type</p>');
            }
        });
    }

    function DeleteCardType(tblID, argus) {
        switch (tblID) {
        case "tblCardTypeDetails":
            if (argus[3].toLowerCase() != "yes") {
                DeleteCardTypeByID(argus[0], storeId, portalId, CultureName, userName);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t delete system used Card Type.</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeleteCardTypeByID(_cardTypeId, _storeId, _portalId, _cultureName, _userName) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(_cardTypeId, _storeId, _portalId, _cultureName, _userName, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this Card Type?</p>", properties);
    }

    function ConfirmSingleDelete(_cardTypeId, _storeId, _portalId, _cultureName, _userName, event) {
        if (event) {
            DeleteSingleCard(_cardTypeId, _storeId, _portalId, _cultureName, _userName);
        }
        return false;
    }

    function DeleteSingleCard(_cardTypeId, _storeId, _portalId, _cultureName, _userName) {
        var functionName = 'DeleteCardTypeByID';
        var params = { CardTypeID: parseInt(_cardTypeId), StoreID: _storeId, PortalID: _portalId, UserName: _userName, CultureName: _cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindCardTypeInGrid(null, null);
                ClearForm();
                $('#divCardTypeDetail').show();
                $('#divEditCardType').hide();
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Card Type!!</p>');
            }
        });
    }

    function ConfirmDeleteMultiple(_cardTypeIds, event) {
        if (event) {
            DeleteMultipleCard(_cardTypeIds, storeId, portalId, userName, CultureName);
        }
    }

    function DeleteMultipleCard(_cardTypeIds, storeId, portalId, UserName, CultureName) {

        var functionName = 'DeleteCardTypeMultipleSelected';
        var params = { CardTypeIDs: _cardTypeIds, StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: CultureName };
        var mydata = JSON2.stringify(params);

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindCardTypeInGrid(null, null);
                ClearForm();
                $('#divCardTypeDetail').show();
                $('#divEditCardType').hide();
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Selectd Card Types!!</p>');
            }
        });
        return false;
    }

    function SearchCardType() {

        var cardTypeName = $.trim($("#txtSearchCardTypeName").val());
        if (cardTypeName.length < 1) {
            cardTypeName = null;
        }
        var isAct = $.trim($("#ddlVisibitity").val()) == "" ? null : ($.trim($("#ddlVisibitity").val()) == "True" ? true : false);
        BindCardTypeInGrid(cardTypeName, isAct);
    }

    function ImageUploader() {
        maxFileSize = '<%= maxFileSize %>';
        var upload = new AjaxUpload($('#cardTypeImageBrowser'), {
            action: aspxCardTypeModulePath + "CardFileUploader.aspx",
            name: 'myfile[]',
            multiple: false,
            data: { },
            autoSubmit: true,
            responseType: 'json',
            onChange: function(file, ext) {
                //alert('changed');
            },
            onSubmit: function(file, ext) {
                if (ext != "exe") {
                    if (ext && /^(jpg|jpeg|jpe|gif|bmp|png|ico)$/i .test(ext)) {
                        this.setData({
                            'MaxFileSize': maxFileSize
                        });
                    } else {
                        csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
                        return false;
                    }
                } else {
                    csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
                    return false;
                }
            },
            onComplete: function(file, response) {
                var res = eval(response);
                if (res.Message != null && res.Status > 0) {
                    AddNewImages(res);
                    return false;
                } else {
                    csscody.error('<h1>Error Message</h1><p>Can\'t upload the image!</p>');
                    return false;
                }
            }
        });
    }

    function AddNewImages(response) {
        $("#cardTypeImageBrowser").attr('name', response.Message);
        $("#divCardImage").html('<img src="' + aspxRootPath + response.Message + '" class="uploadImage" height="90px" width="100px"/></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage()" alt="Delete"/>');
    }

    function ClickToDeleteImage() {
        $('#divCardImage').html('');
        return false;
    }

</script>

<div id="divCardTypeDetail">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCardTypeHeading" runat="server" Text="Card Type"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNew">
                            <span><span>Add New Cart Type</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>
                            <%--                            <td>
                                <asp:Label ID="lblCardTypeID" runat="server" CssClass="cssClassLabel" Text="Card Type ID:"></asp:Label>
                                <input type="text" id="txtCardTypeID" class="cssClassTextBoxSmall" />
                            </td>--%>
                            <td>
                                <asp:Label ID="lblCardTypeName" runat="server" CssClass="cssClassLabel" Text="Card Type Name:"></asp:Label>
                                <input type="text" id="txtSearchCardTypeName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <asp:Label ID="lblCardTypeIsActive" runat="server" CssClass="cssClassLabel" Text="Is Active:"></asp:Label>
                                <select id="ddlVisibitity" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCardType() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxCardTypeImageLoad"/>
                </div>
                <div class="log">
                </div>
                <table id="tblCardTypeDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="divEditCardType">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblHeading" runat="server" Text="Edit Card Type ID:"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblCardTypeName2" runat="server" Text="Card Type Name:" CssClass="cssClassLabel"></asp:Label><span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtCardTypeName" name="CardTypeName" class="cssClassNormalTextBox required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCardImage" Text="Card Image:" runat="server" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input id="cardTypeImageBrowser" type="file" class="cssClassBrowse" />
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td class="cssClassTableRightCol">
                        <div id="divCardImage">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCardAlternateText" runat="server" Text="AlternateText:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <input type="text" id="txtCardAlternateText" class="cssClassNormalTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCardTypeIsActive2" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <div id="divchkIsActiveCardType" class="cssClassCheckBox">
                            <input id="chkIsActiveCardType" type="checkbox" name="chkIsActive" />
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnBack">
                    <span><span>Back</span></span></button>
            </p>
            <p>
                <button type="button" id="btnReset">
                    <span><span>Reset</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSaveCardType">
                    <span><span> Save </span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<input type="hidden" id="hdnPrevFilePath" />