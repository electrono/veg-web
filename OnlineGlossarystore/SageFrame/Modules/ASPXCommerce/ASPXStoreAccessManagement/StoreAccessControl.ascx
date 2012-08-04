<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreAccessControl.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXStoreAccessManagement_StoreAccessControl" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var lblStoreAccessValueID = '<%= lblStoreAccessValueID %>';
    var lblAddEditStoreAccessTitleID = '<%= lblAddEditStoreAccessTitleID %>';
    var userName = '<%= userName %>';
    var Edit = 0;
    var isActive = false;
    var StoreAccessKeyID = 0;
    var StoreAccessData = '';
    var isIP = false;
    var auto = false;

    $(document).ready(function() {
        var $tabs = $('#dvTabPanel').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
        // $('#dvMultipleAddress').tabs({ fx: [null, { height: 'show', opacity: 'show'}] });
        //$("#editAdd").hide();
        SelectFirstTab();
        LoadStoreAccessMgmtStaticImage();
        bindAll();
        $("#txtsrchIPDate,#txtsrchDomainDate,#txtsrchEmailDate,#txtsrchCreditCardDate,#txtsrchCustomerDate").datepicker({ dateFormat: 'yy/mm/dd' });

        $(".cssClassClose").click(function() {
            $('#fade, #popuprel').fadeOut();
            ClearEditAddForm();
            $('#IPTO').remove();
            auto = false;
            Edit = 0;
            $('#txtStoreAccessValue').autocomplete("disable");
            ClearPopUpError();
        });

        $("#btnCancelSaveUpdate").click(function() {

            $('#fade, #popuprel').fadeOut();
            ClearEditAddForm();
            $('#IPTO').remove();
            auto = false;
            Edit = 0;
            ClearPopUpError();
        });

        $('#btnDeleteSelectedIP,#btnDeleteSelectedDomain,#btnDeleteSelectedEmail,#btnDeleteSelectedCreditCard,#btnDeleteSelectedCustomer').click(function() {
            var attribute_ids = new Array;
            attribute_ids = [];
            switch ($(this).attr('id')) {
            case "btnDeleteSelectedIP":
                $("#gdvIP .attrChkbox").each(function(i) {
                    if ($(this).attr("checked")) {
                        attribute_ids.push($(this).val());
                    }
                });
                if (attribute_ids != "") {
                    var properties = {
                        onComplete: function(e) {
                            ConfirmDeleteMultiple(attribute_ids, e);
                        }
                    }
                    csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
                }
                break;
            case "btnDeleteSelectedDomain":
                $("#gdvDomain .attrChkbox").each(function(i) {
                    if ($(this).attr("checked")) {
                        attribute_ids.push($(this).val());
                    }
                });
                if (attribute_ids != "") {
                    var properties = {
                        onComplete: function(e) {
                            ConfirmDeleteMultiple(attribute_ids, e);
                        }
                    }
                    csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
                }
                break;
            case "btnDeleteSelectedEmail":
                $("#gdvEmail .attrChkbox").each(function(i) {
                    if ($(this).attr("checked")) {
                        attribute_ids.push($(this).val());
                    }
                });
                if (attribute_ids != "") {
                    var properties = {
                        onComplete: function(e) {
                            ConfirmDeleteMultiple(attribute_ids, e);
                        }
                    }
                    csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
                }
                break;
            case "btnDeleteSelectedCreditCard":
                $("#gdvCreditCard .attrChkbox").each(function(i) {
                    if ($(this).attr("checked")) {
                        attribute_ids.push($(this).val());
                    }
                });
                if (attribute_ids != "") {
                    var properties = {
                        onComplete: function(e) {
                            ConfirmDeleteMultiple(attribute_ids, e);
                        }
                    }
                    csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
                }
                break;
            case "btnDeleteSelectedCustomer":
                $("#gdvCustomer .attrChkbox").each(function(i) {
                    if ($(this).attr("checked")) {
                        attribute_ids.push($(this).val());
                    }
                });
                if (attribute_ids != "") {
                    var properties = {
                        onComplete: function(e) {
                            ConfirmDeleteMultiple(attribute_ids, e);
                        }
                    }
                    csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
                }
                break;
            default:
                break;
            }
        });

        $('#btnAddIP,#btnAddDomain,#btnAddEmail,#btnAddCustomer,#btnAddCreditCard').click(function() {
            ClearPopUpError();
            $('#txtStoreAccessValue').autocomplete("disable");
            $('#IPTO').remove();
            Edit = 0;
            var btn = $(this).attr('id');
            switch (btn) {
            case "btnAddIP":
                isIP = true;
                StoreAccessKeyID = $('input[ name="IP"]').val();
                $('<tr id="IPTO"><td><asp:Label ID="lblIpRangeTo" Text="To" runat="server" CssClass="cssClassLabel"></asp:Label> </td><td class="cssClassTableRightCol"><input type="text" id="txtStoreAccessValueTo" class="cssClassNormalTextBox" /></td></tr>').insertAfter('#forIPonly');
                $('#' + lblStoreAccessValueID).html("Add new IP Range ");
                $('#' + lblAddEditStoreAccessTitleID).html("Add new IP Range ");
                ClearEditAddForm();
                $('#chkStatusActive').attr('checked', true);
                ShowPopupControl("popuprel"); // $("#editAdd").popUp();

                break;
            case "btnAddDomain":
                isIP = false;
                StoreAccessKeyID = $('input[ name="Domain"]').val();
                $('#' + lblStoreAccessValueID).html("Add new Domain ");
                $('#' + lblAddEditStoreAccessTitleID).html("Add new Domain ");
                ClearEditAddForm();
                $('#chkStatusActive').attr('checked', true);
                ShowPopupControl("popuprel"); // $("#editAdd").popUp();

                break;
            case "btnAddEmail":
                isIP = false;
                StoreAccessKeyID = $('input[ name="Email"]').val();
                $('#' + lblStoreAccessValueID).html("Add new Email ");
                $('#' + lblAddEditStoreAccessTitleID).html("Add new Email  ");
                ClearEditAddForm();
                $('#chkStatusActive').attr('checked', true);
                ShowPopupControl("popuprel"); // $("#editAdd").popUp();
                $('#txtStoreAccessValue').autocomplete("enable");
                $('#txtStoreAccessValue').autocomplete({
                    source: function(req, res) {
                        $.ajax({
                            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetASPXUserEmail",
                            data: JSON2.stringify({ email: $('#txtStoreAccessValue').val(), StoreID: storeId, PortalID: portalId }),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(da) { return da; },
                            success: function(da) {

                                res($.map(da.d, function(item) {
                                    return {
                                        value: item.Email
                                    }
                                }))

                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 1
                });

                break;
            case "btnAddCreditCard":
                isIP = false;
                StoreAccessKeyID = $('input[ name="CreditCard"]').val();
                $('#' + lblStoreAccessValueID).html("Add new CreditCard ");
                $('#' + lblAddEditStoreAccessTitleID).html("Add new CreditCard ");
                ClearEditAddForm();
                $('#chkStatusActive').attr('checked', true);
                ShowPopupControl("popuprel"); // $("#editAdd").popUp();

                break;
            case "btnAddCustomer":
                isIP = false;
                auto = true;
                StoreAccessKeyID = $('input[ name="Customer"]').val();
                $('#' + lblStoreAccessValueID).html("Add new Customer ");
                $('#' + lblAddEditStoreAccessTitleID).html("Add new Customer");
                ClearEditAddForm();
                $('#chkStatusActive').attr('checked', true);
                ShowPopupControl("popuprel"); // $("#editAdd").popUp();
                $('#txtStoreAccessValue').autocomplete("enable");
                $('#txtStoreAccessValue').autocomplete({
                    source: function(request, response) {
                        $.ajax({
                            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetASPXUser",
                            data: JSON2.stringify({ userName: $('#txtStoreAccessValue').val(), StoreID: storeId, PortalID: portalId }),
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            dataFilter: function(data) { return data; },
                            success: function(data) {
                                if (auto) {
                                    response($.map(data.d, function(item) {
                                        return {
                                            value: item.UserName
                                        }
                                    }))
                                }
                            },
                            error: function(XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus);
                            }
                        });
                    },
                    minLength: 2
                });

                break;
            default:
                break;
            }
        });

        $('#btnSubmit').click(function() {

            var v = $("#form1").validate({
                messages: {
                    txtNameValidate: {
                        required: '*'
                    },
                    msg: {
                        required: '*'
                    },
                    status: {
                        required: 'required'
                    }
                }
            });

            if (v.form()) {
                $('#fade, #popuprel').fadeOut();
                SaveUpdate();
                ClearEditAddForm();
                $('#IPTO').remove();
                auto = false;
            } else {
                return false;
            }

            //            if ($('#txtStoreAccessValue').val() == '') {
            //                alert("Please Fill Required Field");
            //            }
            //            else if ($('#txtReason').val() == '') {
            //                alert("Please Fill Required Field");
            //            }
            //            else {
            //                if ($('#chkStatusActive').attr('checked')) {
            //                    isActive = true;
            //                }
            //                else {
            //                    isActive = false;
            //                }
            //                SaveUpdate();
            //                $('#fade, #popuprel').fadeOut();
            //                ClearEditAddForm();
            //                $('#IPTO').remove();
            //                auto = false;
            //            }
        });
    });

    function ClearPopUpError() {
        $('#txtStoreAccessValue').removeClass('error');
        $('#txtStoreAccessValue').parents('td').find('label').remove();
        $('#txtReason').removeClass('error');
        $('#txtReason').parents('td').find('label').remove();
    }

    function ConfirmDeleteMultiple(attribute_ids, event) {
        if (event) {

            for (var id in attribute_ids) {
                DeleteStoreAccessByID(attribute_ids[id], event);
            }
            attribute_ids = [];
            bindAll();
        }
    }

    function LoadStoreAccessMgmtStaticImage() {
        $('#ajaxStoreAccessImage1').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxStoreAccessImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxStoreAccessImage3').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxStoreAccessImage4').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxStoreAccessImage5').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function SelectFirstTab() {
        var $tabs = $('#dvMultipleAddress').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function bindAll() {
        LoadStoreAccessIPs(null, null, null);
        LoadStoreAccessDomains(null, null, null);
        LoadStoreAccessEmails(null, null, null);
        LoadStoreAccessCreditCards(null, null, null);
        LoadStoreAccessCustomers(null, null, null);
        loadkey();
    }

    function ClearEditAddForm() {
        $('#txtStoreAccessValue').val('');
        $('#txtReason').val('');
        $('#editAdd input[type="radio"]').attr('checked', false);
        // $('#chkStatusActive').attr('checked', true);
    }

    function SaveUpdate() {
        if (isIP) {

            if ($.trim($('#txtStoreAccessValueTo').val()) == "") {
                StoreAccessData = $('#txtStoreAccessValue').val();
            } else {
                StoreAccessData = $('#txtStoreAccessValue').val() + '-' + $('#txtStoreAccessValueTo').val();
            }

        } else {
            StoreAccessData = $('#txtStoreAccessValue').val();
        }

        if ($('#chkStatusActive').attr('checked')) {
            isActive = true;
        } else {
            isActive = false;
        }

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveUpdateStoreAccess",
            data: JSON2.stringify({ Edit: Edit, StoreAccessKeyID: StoreAccessKeyID, StoreAccessData: StoreAccessData, Reason: $('#txtReason').val(), IsActive: isActive, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                bindAll();
                Edit = 0;
                StoreAccessData = '';
            },
            error: function() {
                alert("error");
            }
        });
    }

    function loadkey() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStoreKeyID",
            data: ({ }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {

                    $.each(msg.d, function(index, item) {
                        $('#hdnField').append('<input type="hidden" name=' + item.StoreAccessKeyValue + ' value=' + item.StoreAccessKeyID + ' />');
                    });
                }
            },
            error: function() {
                alert("error");
            }
        });
    }

    function searchStoreAccess(Id) {
        switch ($(Id).attr('id')) {
        case "btnSrchIP":
            var Search = $.trim($('#txtsrchIP').val());
            var Addedon = $.trim($('#txtsrchIPDate').val());
            var Status = $.trim($('#SelectStatusIP').val()) == "" ? null : ($.trim($('#SelectStatusIP').val()) == "True" ? true : false);
            if (Addedon) {
                var splitFromDate = String(Addedon).split('/');
                Addedon = new Date(Date.UTC(splitFromDate[2], splitFromDate[0] * 1 - 1, splitFromDate[1], 12, 0, 0, 0));
                Addedon = Addedon.toMSJSON();
            }
            if (Search.length < 1) {
                Search = null;
            }
            if (Addedon.length < 1) {
                Addedon = null;
            }
            LoadStoreAccessIPs(Search, Addedon, Status);
            break;
        case "btnSrchDomain":
            var Search = $.trim($('#txtsrchDomain').val());
            var Addedon = $.trim($('#txtsrchDomainDate').val());
            var Status = $.trim($('#SelectStatusDomain').val()) == "" ? null : ($.trim($('#SelectStatusDomain').val()) == "True" ? true : false);
            if (Addedon) {
                var splitFromDate = String(Addedon).split('/');
                Addedon = new Date(Date.UTC(splitFromDate[2], splitFromDate[0] * 1 - 1, splitFromDate[1], 12, 0, 0, 0));
                Addedon = Addedon.toMSJSON();
            }
            if (Search.length < 1) {
                Search = null;
            }
            if (Addedon.length < 1) {
                Addedon = null;
            }
            LoadStoreAccessDomains(Search, Addedon, Status);
            break;
        case "btnSrchEmail":
            var Search = $.trim($('#txtsrchEmail').val());
            var Addedon = $.trim($('#txtsrchEmailDate').val());
            var Status = $.trim($('#SelectStatusEmail').val()) == "" ? null : ($.trim($('#SelectStatusEmail').val()) == "True" ? true : false);
            if (Addedon) {
                var splitFromDate = String(Addedon).split('/');
                Addedon = new Date(Date.UTC(splitFromDate[2], splitFromDate[0] * 1 - 1, splitFromDate[1], 12, 0, 0, 0));
                Addedon = Addedon.toMSJSON();
            }
            if (Search.length < 1) {
                Search = null;
            }
            if (Addedon.length < 1) {
                Addedon = null;
            }
            LoadStoreAccessEmails(Search, Addedon, Status);
            break;
        case "btnSrchCreditCard":
            var Search = $.trim($('#txtsrchCreditCard').val());
            var Addedon = $.trim($('#txtsrchCreditCardDate').val());
            var Status = $.trim($('#SelectStatusCreditCard').val()) == "" ? null : ($.trim($('#SelectStatusCreditCard').val()) == "True" ? true : false);
            if (Addedon) {
                var splitFromDate = String(Addedon).split('/');
                Addedon = new Date(Date.UTC(splitFromDate[2], splitFromDate[0] * 1 - 1, splitFromDate[1], 12, 0, 0, 0));
                Addedon = Addedon.toMSJSON();
            }
            if (Search.length < 1) {
                Search = null;
            }
            if (Addedon.length < 1) {
                Addedon = null;
            }
            LoadStoreAccessCreditCards(Search, Addedon, Status);
            break;
        case "btnSrchCustomer":
            var Search = $.trim($('#txtsrchCustomer').val());
            var Addedon = $.trim($('#txtsrchCustomerDate').val());
            var Status = $.trim($('#SelectStatusCustomer').val()) == "" ? null : ($.trim($('#SelectStatusCustomer').val()) == "True" ? true : false);
            if (Addedon) {
                var splitFromDate = String(Addedon).split('/');
                Addedon = new Date(Date.UTC(splitFromDate[2], splitFromDate[0] * 1 - 1, splitFromDate[1], 12, 0, 0, 0));
                Addedon = Addedon.toMSJSON();
            }
            if (Search.length < 1) {
                Search = null;
            }
            if (Addedon.length < 1) {
                Addedon = null;
            }
            LoadStoreAccessCustomers(Search, Addedon, Status);
            break;
        default:
            break;
        }
    }

    function LoadStoreAccessIPs(search, addedon, status) {

        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("gdvIP_pagesize").length > 0) ? $("#gdvIP_pagesize :selected").text() : 10;

        $("#gdvIP").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'LoadStoreAccessIPs',
            colModel: [
                { display: 'Ids', name: 'Ids', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'IP', name: 'IPRange', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Reason', name: 'Reason', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'Added On', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Status', name: 'Status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'KeyType', name: 'KeyType', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'KeyID', name: 'KeyID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '1' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { search: search, addedon: addedon, status: status, storeID: storeId, portalID: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function LoadStoreAccessDomains(search, addedon, status) {

        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("gdvDomain_pagesize").length > 0) ? $("#gdvDomain_pagesize :selected").text() : 10;

        $("#gdvDomain").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'LoadStoreAccessDomains',
            colModel: [
                { display: 'Ids', name: 'Ids', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Domain', name: 'Domain', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Reason', name: 'Reason', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'Added On', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Status', name: 'Status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'KeyType', name: 'KeyType', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'KeyID', name: 'KeyID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '1' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { search: search, addedon: addedon, status: status, storeID: storeId, portalID: portalId, search: search, addedon: addedon, status: status },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function LoadStoreAccessEmails(search, addedon, status) {

        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("gdvEmail_pagesize").length > 0) ? $("#gdvEmail_pagesize :selected").text() : 10;

        $("#gdvEmail").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'LoadStoreAccessEmails',
            colModel: [
                { display: 'Ids', name: 'Ids', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Email', name: 'Email', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Reason', name: 'Reason', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'Added On', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Status', name: 'Status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'KeyType', name: 'KeyType', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'KeyID', name: 'KeyID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { search: search, addedon: addedon, status: status, storeID: storeId, portalID: portalId, search: search, addedon: addedon, status: status },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function EditCoupons(tblID, argus) {
        $('#txtStoreAccessValue').autocomplete("disable");
        $('#IPTO').remove();
        Edit = 0;
        switch (tblID) {
        case "gdvIP":
            isIP = true;
            $('#' + lblStoreAccessValueID).html("Edit IP Range From:");
            $('#' + lblAddEditStoreAccessTitleID).html("Edit IP Range");
            $('<tr id="IPTO"><td><asp:Label ID="lblIpRange2To" Text="To" runat="server" CssClass="cssClassLabel"></asp:Label></td><td class="cssClassTableRightCol"><input type="text" id="txtStoreAccessValueTo" class="cssClassNormalTextBox" /></td></tr>').insertAfter('#forIPonly');
            Edit = argus[0];
            StoreAccessKeyID = argus[8];
            $('#txtStoreAccessValue').val(argus[3].split('-')[0]);
            $('#txtStoreAccessValueTo').val(argus[3].split('-')[1]);
            $('#txtReason').val(argus[4]);
            if (argus[6].toLowerCase() == 'true' || argus[6].toLowerCase() == "yes") {
                $('#chkStatusActive').attr('checked', true);
            } else if (argus[6].toLowerCase() == 'false' || argus[6].toLowerCase() == "no") {
                $('#chkStarusDisActive').attr('checked', true);
            }
            ShowPopupControl("popuprel");
            break;
        case "gdvEmail":
            isIP = false;
            $('#' + lblStoreAccessValueID).html("Edit Email:");
            $('#' + lblAddEditStoreAccessTitleID).html("Edit Email");
            Edit = argus[0];
            StoreAccessKeyID = argus[8];
            $('#txtStoreAccessValue').val(argus[3]);
            $('#txtReason').val(argus[4]);

            if (argus[6].toLowerCase() == 'true' || argus[6].toLowerCase() == "yes") {
                $('#chkStatusActive').attr('checked', true);
            } else if (argus[6].toLowerCase() == 'false' || argus[6].toLowerCase() == "no") {
                $('#chkStarusDisActive').attr('checked', true);
            }
            ShowPopupControl("popuprel");

            break;
        case "gdvDomain":
            isIP = false;
            $('#' + lblStoreAccessValueID).html("Edit Domain Name: ");
            $('#' + lblAddEditStoreAccessTitleID).html("Edit Domain");
            Edit = argus[0];
            StoreAccessKeyID = argus[8];
            $('#txtStoreAccessValue').val(argus[3]);
            $('#txtReason').val(argus[4]);
            if (argus[6].toLowerCase() == 'true' || argus[6].toLowerCase() == "yes") {
                $('#chkStatusActive').attr('checked', true);
            } else if (argus[6].toLowerCase() == 'false' || argus[6].toLowerCase() == "no") {
                $('#chkStarusDisActive').attr('checked', true);
            }
            ShowPopupControl("popuprel");

            break;
        case "gdvCreditCard":
            isIP = false;
            $('#' + lblStoreAccessValueID).html("Edit Credit Card No: ");
            $('#' + lblAddEditStoreAccessTitleID).html("Edit Credit Card");
            Edit = argus[0];
            StoreAccessKeyID = argus[8];
            $('#txtStoreAccessValue').val(argus[3]);
            $('#txtReason').val(argus[4]);
            if (argus[6].toLowerCase() == 'true' || argus[6].toLowerCase() == "yes") {
                $('#chkStatusActive').attr('checked', true);
            } else if (argus[6].toLowerCase() == 'false' || argus[6].toLowerCase() == "no") {
                $('#chkStarusDisActive').attr('checked', true);
            }
            ShowPopupControl("popuprel");
            break;
        case "gdvCustomer":
            isIP = false;
            $('#' + lblStoreAccessValueID).html("Edit Customer Name: ");
            $('#' + lblAddEditStoreAccessTitleID).html("Edit Customer");
            Edit = argus[0];
            StoreAccessKeyID = argus[8];
            $('#txtStoreAccessValue').val(argus[3]);
            $('#txtReason').val(argus[4]);

            if (argus[6].toLowerCase() == 'true' || argus[6].toLowerCase() == "yes") {
                $('#chkStatusActive').attr('checked', true);
            } else if (argus[6].toLowerCase() == 'false' || argus[6].toLowerCase() == "no") {
                $('#chkStarusDisActive').attr('checked', true);
            }
            ShowPopupControl("popuprel");
            $('#txtStoreAccessValue').autocomplete("enable");
            $('#txtStoreAccessValue').autocomplete({
                source: function(request, response) {
                    $.ajax({
                        url: aspxservicePath + "ASPXCommerceWebService.asmx/GetASPXUser",
                        data: JSON2.stringify({ userName: $('#txtStoreAccessValue').val(), storeID: storeId, portalID: portalId }),
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataFilter: function(data) { return data; },
                        success: function(data) {
                            if (auto) {
                                response($.map(data.d, function(item) {
                                    return {
                                        value: item.UserName
                                    }
                                }))
                            }
                        },
                        error: function(XMLHttpRequest, textStatus, errorThrown) {
                            alert(textStatus);
                        }
                    });
                },
                minLength: 2
            });
            break;
        default:
            break;
        }
    }

    function DeleteCoupons(tblID, argus) {

        var properties = {
            onComplete: function(e) {
                DeleteStoreAccessByID(argus[0], e);
                bindAll();
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
    }

    function DeleteStoreAccessByID(Ids, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeletStoreAccess",
                data: JSON2.stringify({ storeAccessID: Ids, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(msg) {
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function LoadStoreAccessCustomers(search, addedon, status) {

        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("gdvCustomer_pagesize").length > 0) ? $("#gdvCustomer_pagesize :selected").text() : 10;

        $("#gdvCustomer").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'LoadStoreAccessCustomer',
            colModel: [
                { display: 'Ids', name: 'Ids', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Customer Name', name: 'Customer', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Reason', name: 'Reason', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'Added On', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Status', name: 'Status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'KeyType', name: 'KeyType', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'KeyID', name: 'KeyID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '1' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { search: search, addedon: addedon, status: status, storeID: storeId, portalID: portalId, search: search, addedon: addedon, status: status },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function LoadStoreAccessCreditCards(search, addedon, status) {

        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("gdvCreditCard_pagesize").length > 0) ? $("#gdvCreditCard_pagesize :selected").text() : 10;

        $("#gdvCreditCard").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'LoadStoreAccessCreditCards',
            colModel: [
                { display: 'Ids', name: 'Ids', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Credit Card', name: 'Credit Card', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Reason', name: 'Reason', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'Added On', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Status', name: 'Status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'KeyType', name: 'KeyType', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'KeyID', name: 'KeyID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '1' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { search: search, addedon: addedon, status: status, storeID: storeId, portalID: portalId, search: search, addedon: addedon, status: status },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }
</script>

<script type="text/javascript">
    $(function() {
        $('#txtsrchEmail').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/SearchStoreAccess",
                    data: JSON2.stringify({ text: request.term, KeyID: $('input[ name="Email"]').val() }),
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataFilter: function(data) { return data; },
                    success: function(data) {
                        response($.map(data.d, function(item) {
                            return {
                                value: item.StoreAccessData
                            }
                        }))
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus);
                    }
                });
            },
            minLength: 2
        });
        $('#txtStoreAccessValue').autocomplete("disable");

    });
</script>

<div class="cssClassTabPanelTable">
    <div id="dvTabPanel">
        <ul>
            <li><a href="#dvIP">
                    <asp:Label ID="lblIP" runat="server" Text="IP"></asp:Label></a></li>
            <li><a href="#dvDomain">
                    <asp:Label ID="lblDomain" runat="server" Text="Domain"></asp:Label></a></li>
            <li><a href="#dvEmail">
                    <asp:Label ID="lblEmail" runat="server" Text="Email"></asp:Label></a></li>
            <li><a href="#dvCreditCard">
                    <asp:Label ID="lblCreditCard" runat="server" Text="Credit Card"></asp:Label></a></li>
            <li><a href="#dvCustomer">
                    <asp:Label ID="lblCustomer" runat="server" Text="Customer"></asp:Label></a></li>
        </ul>
        <div id="dvIP">
            <div class="cssClassFormWrapper">
                <div id="div1">
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                <asp:Label ID="lblHeaderIP" runat="server" CssClass="cssClassLabel" Text=" List of IP's Blocked"></asp:Label>
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper">
                                    <p>
                                        <button type="button" id="btnDeleteSelectedIP">
                                            <span><span>Delete All Selected</span> </span>
                                        </button>
                                    </p>
                                    <p>
                                        <button type="button" id="btnAddIP">
                                            <span><span>Add New IP</span></span></button>
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
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <label class="cssClassLabel">
                                                    IP:</label>
                                                <input type="text" id="txtsrchIP" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Added On:
                                                </label>
                                                <input type="text" id="txtsrchIPDate" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Status :
                                                </label>
                                                <select id="SelectStatusIP">
                                                    <option value="">-- All -- </option>
                                                    <option value="True">Active </option>
                                                    <option value="False">Inactive </option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                    <p>
                                                        <button type="button" onclick=" searchStoreAccess(this) " id="btnSrchIP">
                                                            <span><span>Search</span></span></button>
                                                    </p>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="loading">
                                    <img id="ajaxStoreAccessImage1" />
                                </div>
                                <div class="log">
                                </div>
                                <table id="gdvIP" cellspacing="0" cellpadding="0" border="0" width="100%">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvDomain">
            <div class="cssClassFormWrapper">
                <div id="div2">
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                <asp:Label ID="lblHeadingDomain" runat="server" CssClass="cssClassLabel" Text=" List of Domain's Blocked"></asp:Label>
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper">
                                    <p>
                                        <button type="button" id="btnDeleteSelectedDomain">
                                            <span><span>Delete All Selected</span> </span>
                                        </button>
                                    </p>
                                    <p>
                                        <button type="button" id="btnAddDomain">
                                            <span><span>Add New Domain</span></span></button>
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
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Domain:</label>
                                                <input type="text" id="txtsrchDomain" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Added On:
                                                </label>
                                                <input type="text" id="txtsrchDomainDate" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Status :
                                                </label>
                                                <select id="SelectStatusDomain">
                                                    <option value="">-- All -- </option>
                                                    <option value="True">Active </option>
                                                    <option value="False">Inactive </option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                    <p>
                                                        <button type="button" onclick=" searchStoreAccess(this) " id="btnSrchDomain">
                                                            <span><span>Search</span></span></button>
                                                    </p>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="loading">
                                    <img id="ajaxStoreAccessImage5" />
                                </div>
                                <div class="log">
                                </div>
                                <table id="gdvDomain" cellspacing="0" cellpadding="0" border="0" width="100%">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvEmail">
            <div class="cssClassFormWrapper">
                <div id="div3">
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                <asp:Label ID="lblHeadingEmail" runat="server" CssClass="cssClassLabel" Text="List of Email's Blocked"></asp:Label>
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper">
                                    <p>
                                        <button type="button" id="btnDeleteSelectedEmail">
                                            <span><span>Delete All Selected</span> </span>
                                        </button>
                                    </p>
                                    <p>
                                        <button type="button" id="btnAddEmail">
                                            <span><span>Add New Email</span></span></button>
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
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Email:</label>
                                                <input type="text" id="txtsrchEmail" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Added On:
                                                </label>
                                                <input type="text" id="txtsrchEmailDate" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Status :
                                                </label>
                                                <select id="SelectStatusEmail">
                                                    <option value="">-- All -- </option>
                                                    <option value="True">Active </option>
                                                    <option value="False">Inactive </option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                    <p>
                                                        <button type="button" onclick=" searchStoreAccess(this) " id="btnSrchEmail">
                                                            <span><span>Search</span></span></button>
                                                    </p>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="loading">
                                    <img id="ajaxStoreAccessImage4" />
                                </div>
                                <div class="log">
                                </div>
                                <table id="gdvEmail" cellspacing="0" cellpadding="0" border="0" width="100%">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvCreditCard">
            <div class="cssClassFormWrapper">
                <div id="div4">
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                <asp:Label ID="lblHeadingCreditCard" runat="server" CssClass="cssClassLabel" Text="List of CreditCard Blocked"></asp:Label>
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper">
                                    <p>
                                        <button type="button" id="btnDeleteSelectedCreditCard">
                                            <span><span>Delete All Selected</span> </span>
                                        </button>
                                    </p>
                                    <p>
                                        <button type="button" id="btnAddCreditCard">
                                            <span><span>Add New CreditCard</span></span></button>
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
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Credit Card No:</label>
                                                <input type="text" id="txtsrchCreditCard" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Added On:
                                                </label>
                                                <input type="text" id="txtsrchCreditCardDate" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Status :
                                                </label>
                                                <select id="SelectStatusCreditCard">
                                                    <option value="">-- All -- </option>
                                                    <option value="True">Active </option>
                                                    <option value="False">Inactive </option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                    <p>
                                                        <button type="button" onclick=" searchStoreAccess(this) " id="btnSrchCreditCard">
                                                            <span><span>Search</span></span></button>
                                                    </p>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="loading">
                                    <img id="ajaxStoreAccessImage3" />
                                </div>
                                <div class="log">
                                </div>
                                <table id="gdvCreditCard" cellspacing="0" cellpadding="0" border="0" width="100%">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="dvCustomer">
            <div class="cssClassFormWrapper">
                <div id="div6">
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                <asp:Label ID="lblHeadingCustomer" runat="server" CssClass="cssClassLabel" Text="List of Customer Blocked"></asp:Label>
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper">
                                    <p>
                                        <button type="button" id="btnDeleteSelectedCustomer">
                                            <span><span>Delete All Selected</span> </span>
                                        </button>
                                    </p>
                                    <p>
                                        <button type="button" id="btnAddCustomer">
                                            <span><span>Add New Customer</span></span></button>
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
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                        <tr>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Customer Name:</label>
                                                <input type="text" id="txtsrchCustomer" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Added On:
                                                </label>
                                                <input type="text" id="txtsrchCustomerDate" class="cssClassTextBoxSmall" />
                                            </td>
                                            <td>
                                                <label class="cssClassLabel">
                                                    Status :
                                                </label>
                                                <select id="SelectStatusCustomer">
                                                    <option value="">-- All -- </option>
                                                    <option value="True">Active </option>
                                                    <option value="False">Inactive </option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                    <p>
                                                        <button type="button" onclick=" searchStoreAccess(this) " id="btnSrchCustomer">
                                                            <span><span>Search</span></span></button>
                                                    </p>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="loading">
                                    <img id="ajaxStoreAccessImage2"/>
                                </div>
                                <div class="log">
                                </div>
                                <table id="gdvCustomer" cellspacing="0" cellpadding="0" border="0" width="100%">
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="popupbox" id="popuprel">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <div id="editAdd">
        <div class="cssClassCommonBox Curve">
            <div class="cssClassHeader">
                <h3>
                    <asp:Label ID="lblAddEditStoreAccessTitle" runat="server" Text=""></asp:Label>
                </h3>
            </div>
            <div class="cssClassFormWrapper">
                <table border="0" width="100%" id="tblAddEditStoreAccessForm" class="cssClassPadding">
                    <tr id="forIPonly">
                        <td>
                            <asp:Label ID="lblStoreAccessValue" Text="" runat="server" CssClass="cssClassLabel"></asp:Label>
                            <span class="cssClassRequired">*</span>
                        </td>
                        <td class="cssClassTableRightCol">
                            <input type="text" id="txtStoreAccessValue" name="txtNameValidate" class="cssClassNormalTextBox required" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblReason" Text="Reason:" runat="server" CssClass="cssClassLabel"></asp:Label>
                            <span class="cssClassRequired">*</span>
                        </td>
                        <td class="cssClassTableRightCol">                         
                            <textarea id="txtReason" cols="30" rows="6" name="msg" class="cssClassTextarea required"></textarea>                            
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblStatus" Text="Status:" runat="server" CssClass="cssClassLabel"></asp:Label>
                            <span class="cssClassRequired">*</span>
                        </td>
                        <td class="cssClassTableRightCol">
                            <input type="radio" id="chkStatusActive" class="cssClassRadioBtn" name="status" checked="checked" />
                            <span>Active</span>
                            <input type="radio" id="chkStarusDisActive" class="cssClassRadioBtn" name="status" />
                            <span>Disable</span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnCancelSaveUpdate" class="cssClassButtonSubmit">
                        <span><span>Cancel</span></span></button>
                </p>
                <p>
                    <button type="button" id="btnSubmit" class="cssClassButtonSubmit">
                        <span><span>Save</span></span></button>
                </p>
            </div>
        </div>
    </div>
</div>
<div id="hdnField">
</div>