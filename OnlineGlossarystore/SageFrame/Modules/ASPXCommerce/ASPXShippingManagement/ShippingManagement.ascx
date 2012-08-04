<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShippingManagement.ascx.cs"
            Inherits="Modules_ASPXShippingManagement_ShippingManagement" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    // var methodId = $("#hdnShippingMethodID").val();

    $(document).ready(function() {
        $("#btnReset").click(function() {
            ResetForm();
        });

        $("#txtCost").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgCost").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtCostRateValue").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgRateValue").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtWeight").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgWeight").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtWeightRateValue").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgWeightRateValue").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtQuantity").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgQty").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtQuantityRateValue").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgQtyRateValue").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtDisplayOrder").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errdisplayOrder").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtWeightLimitFrom").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#lblNotificationlf").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtWeightLimitTo").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which > 31 && (e.which < 48 || e.which > 57)) {
                $("#lblNotificationlt").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;

            }
        });

        $('#txtWeightLimitFrom').change(function() {
            if (eval($("#txtWeightLimitFrom").val()) >= eval($("#txtWeightLimitTo").val())) {
                //alert('Weight Limit To must be greater than Weight Limit From.');
                $('#lblNotificationlf').html('Weight Limit From must be less than Weight Limit To.');
                $("#txtWeightLimitFrom").val('');
            } else {
                $('#lblNotificationlf').html('');
            }
            return false;
        });

        $('#txtWeightLimitTo').change(function() {
            if (eval($("#txtWeightLimitTo").val()) <= eval($("#txtWeightLimitFrom").val())) {
                $('#lblNotificationlt').html('Weight Limit To must be greater than Weight Limit From.');
                //alert('Weight Limit From must be less than Weight Limit To.');
                $("#txtWeightLimitTo").val('');
            } else {
                $('#lblNotificationlt').html('');
            }
            return false;
        });

        $("#form1").validate({
        //ignore: ":hidden",
            messages: {
                name: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                displayOrder: {
                    required: '*',
                    minlength: "* (at least 1 chars)",
                    digits: '*'
                },
                deliveryTime: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                weightFrom: {
                    required: '*',
                    minlength: "* (at least 1 chars)",
                    maxlength: "* (no more than 5 chars)",
                    number: '*'
                },
                weightTo: {
                    required: '*',
                    minlength: "* (at least 1 chars)",
                    maxlength: "* (no more than 5 chars)",
                    number: '*'
                }
            },
            submitHandler: function(form) {
                SaveAndUpdateShippingMethod();
            }
        });
        LoadShippingMgmtStaticImage();
        BindShippingMethodGrid(null, null, null, null, null);
        BindShippingProviderList();
        ImageUploader();
        HideAll();
        $("#divShowShippingMethodGrid").show();

        $('#btnDeleteSelected').click(function() {
            var shippingMethos_Ids = '';
            //Get the multiple Ids of the item selected
            $(".ShippingChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shippingMethos_Ids += $(this).val() + ',';
                }
            });
            if (shippingMethos_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleShippings(shippingMethos_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected shipping methods?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        });

        $("#btnAddNewShippingMethod").click(function() {
            ClearForm();
            HideAll();
            $("#divAddNewShippingMethodForm").show();
            $("#liShippingSettingChanges").hide();
            $("#btnReset").show();
        });

        $("#btnCancel").click(function() {
            ClearForm();
            HideAll();
            $("#divShowShippingMethodGrid").show();
        });

        $(".cssClassClose").click(function() {
            $("#tblcostdependencies tr:gt(0)").next().remove();
            $("#tblWeightDependencies tr:gt(0)").next().remove();
            $("#tblItemDependencies tr:gt(0)").next().remove();
            $('#fade, #popuprel').fadeOut();
        });

        $("#btnAddCostDependencies").click(function() {
            HideTables();
            $("#lblTitleDependencies").html('Add Cost Dependencies');
            $("#tblcostdependencies").show();
            $("#CostDependencyButtonWrapper").show();
            ClearAddDependencies();
            $("#tblcostdependencies tr:gt(0)").next().remove();
            ShowPopup(this);
        });

        $("#tblcostdependencies").find("img.cssClassDeleteRow").hide();

        $("img.cssClassAddRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblcostdependencies");
            $(cloneRow).find("input[type='text']").val('');
            $(cloneRow).find(".cssClassDeleteRow").show();
        });

        $("img.cssClassCloneRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblcostdependencies");
            $(cloneRow).find(".cssClassDeleteRow").show();
        });

        $("img.cssClassDeleteRow").click(function() {
            var parentRow = $(this).closest('tr');
            if (parentRow.is(":first-child")) {
                return false;
            } else {
                $(parentRow).remove();
            }
        });

        $("#btnCreateCost").click(function() {
            var costInput = eval($('#tblcostdependencies input.cssClassCost, input.cssClassCostRateValue'));
            var count = 0;
            $.each(costInput, function(index, item) {
                if ($(this).val() <= '') {
                    alert("Enter cost and rate");
                    count = 1;
                    return false;
                }
            });
            if (count == 0)
                SaveCostDependenciesValues();
        });

        $("#btnCancelCostDependencies").click(function() {
            $("#tblcostdependencies tr:gt(0)").next().remove();
            $('#fade, #popuprel').fadeOut();
            return false;
        });

        $('#btnDeleteCostDependencies').click(function() {
            var shippingProductCost_Ids = '';
            $(".CostChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shippingProductCost_Ids += $(this).val() + ',';
                }
            });
            if (shippingProductCost_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleShippingCostDependencies(shippingProductCost_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });

        $("#btnAddWeightDependencies").click(function() {
            HideTables();
            $("#lblTitleDependencies").html('Add Weight Dependencies');
            $("#tblWeightDependencies").show();
            $("#WeightDependencyButtonWrapper").show();
            ClearAddDependencies();
            $("#tblWeightDependencies tr:gt(0)").next().remove();
            ShowPopup(this);
        });

        $("#tblWeightDependencies").find("img.cssClassWeightDeleteRow").hide();

        $("img.cssClassWeightAddRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblWeightDependencies");
            $(cloneRow).find("input[type='text']").val('');
            $(cloneRow).find("#ddlWeightDependencies").val('');
            $(cloneRow).find("#chkPerLbs").removeAttr('checked');
            $(cloneRow).find(".cssClassWeightDeleteRow").show();
        });

        $("img.cssClassWeightCloneRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblWeightDependencies");
            $(cloneRow).find(".cssClassWeightDeleteRow").show();
        });

        $("img.cssClassWeightDeleteRow").click(function() {
            var parentRow = $(this).closest('tr');
            if (parentRow.is(":first-child")) {
                return false;
            } else {
                $(parentRow).remove();
            }
        });

        $("#btnCreateWeight").click(function() {
            var weightInput = eval($('#tblWeightDependencies input.cssClassWeight, input.cssClassWeightRateValue'));
            var count = 0;
            $.each(weightInput, function(index, item) {
                if ($(this).val() <= '') {
                    alert("Enter weight and rate");
                    count = 1;
                    return false;
                }
            });
            if (count == 0)
                SaveWeightDependenciesValues();
        });

        $("#btnCancelWeightDependencies").click(function() {
            $("#tblWeightDependencies tr:gt(0)").next().remove();
            $('#fade, #popuprel').fadeOut();
            return false;
        });

        $('#btnDeleteWeightDependencies').click(function() {
            var shippingProductWeight_Ids = '';
            $(".WeightChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shippingProductWeight_Ids += $(this).val() + ',';
                }
            });
            if (shippingProductWeight_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleShippingWeightDependencies(shippingProductWeight_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });

        $("#btnAddItemDependencies").click(function() {
            HideTables();
            $("#lblTitleDependencies").html('Add Item Dependencies');
            $("#tblItemDependencies").show();
            $("#ItemDependencyButtonWrapper").show();
            ClearAddDependencies();
            $("#tblItemDependencies tr:gt(0)").next().remove();
            ShowPopup(this);
        });

        $("#tblItemDependencies").find("img.cssClassItemDeleteRow").hide();

        $("img.cssClassItemAddRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblItemDependencies");
            $(cloneRow).find("input[type='text']").val('');
            $(cloneRow).find("#ddlItemDependencies").val('');
            $(cloneRow).find("#chkPerItems").removeAttr('checked');
            $(cloneRow).find(".cssClassItemDeleteRow").show();
        });

        $("img.cssClassItemCloneRow").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblItemDependencies");
            $(cloneRow).find(".cssClassItemDeleteRow").show();
        });

        $("img.cssClassItemDeleteRow").click(function() {
            var parentRow = $(this).closest('tr');
            if (parentRow.is(":first-child")) {
                return false;
            } else {
                $(parentRow).remove();
            }
        });

        $('#btnDeleteItemDependencies').click(function() {
            var shippimgItem_Ids = '';
            $(".ItemChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shippimgItem_Ids += $(this).val() + ',';
                }
            });
            if (shippimgItem_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleShippingItemDependencies(shippimgItem_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });

        $("#btnCreateItem").click(function() {
            var itemInput = $('#tblItemDependencies input.cssClassQuantity, input.cssClassQuantityRateValue');
            var count = 0;
            $.each(itemInput, function(index, item) {
                if ($(this).val() <= '') {
                    alert("Enter quantity and rate");
                    count = 1;
                    return false;
                }
            });
            if (count == 0)
                SaveItemDependenciesValues();
        });

        $("#btnCancelItemDependencies").click(function() {
            $("#tblItemDependencies tr:gt(0)").next().remove();
            $('#fade, #popuprel').fadeOut();
            return false;
        });
    });

    function LoadShippingMgmtStaticImage() {

        $('.cssClassAddRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_add.gif');
        $('.cssClassCloneRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif');
        $('.cssClassDeleteRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif');

        $('.cssClassItemAddRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_add.gif');
        $('.cssClassItemCloneRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif');
        $('.cssClassItemDeleteRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif');

        $('.cssClassWeightAddRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_add.gif');
        $('.cssClassWeightCloneRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif');
        $('.cssClassWeightDeleteRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif');

        $('#ajaxShippingMgmtImage1').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxShippingMgmtImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxShippingMgmtImage3').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxShippingMgmtImage4').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ResetForm() {
        $('input[type="text"]').val('');
        $('#txtShippingMethodName').removeClass('error');
        $('#txtShippingMethodName').parents('td').find('label').remove();
        $('#txtDeliveryTime').removeClass('error');
        $('#txtDeliveryTime').parents('td').find('label').remove();
        $('#txtAlternateText').removeClass('error');
        $('#txtAlternateText').parents('td').find('label').remove();
        $('#txtWeightLimitFrom').removeClass('error');
        $('#txtWeightLimitFrom').parents('td').find('label').remove();
        $('#txtWeightLimitTo').removeClass('error');
        $('#txtWeightLimitTo').parents('td').find('label').remove();
        $('#txtDisplayOrder').removeClass('error');
        $('#txtDisplayOrder').parents('td').find('label').remove();
        $("#ddlShippingService").val(1);
        $('#chkIsActive').removeAttr('checked');
        $("#shippingIcon").html('');
    }

    function ImageUploader() {
        maxFileSize = '<%= maxFileSize %>';
        var upload = new AjaxUpload($('#fileUpload'), {
            action: aspxShippingModulePath + "MultipleFileUploadHandler.aspx",
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
                    //alert(res.Message);
                    AddNewImages(res);
                    return false;
                } else {
                    csscody.error('<h1>Error Message</h1><p>' + res.Message + '</p>');
                    return false;
                }
            }
        });
    }

    function AddNewImages(response) {
        $("#shippingIcon").html('<img src="' + aspxRootPath + response.Message + '" class="uploadImage" height="90px" width="100px"/>');
    }

    function SelectFirstTab() {
        var $tabs = $('#container-7').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function BindShippingProviderList() {
        var param = JSON2.stringify({ StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetShippingProviderList",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindShipingProvider(item);
                });
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function BindShipingProvider(item) {
        $("#ddlShippingService").append("<option value=" + item.ShippingProviderID + ">" + item.ShippingProviderServiceCode + "</option>");
    }

    function SaveAndUpdateShippingMethod() {
        var prevFilePath = $("#hdnPrevFilePath").val();
        var newFilePath = "";
        if ($("#shippingIcon>img").length > 0) {
            newFilePath = $("#shippingIcon>img").attr("src").replace(aspxRootPath, "");
        }
        var AlternateText = $("#txtAlternateText").val();

        var shippingMethodId = $("#hdnShippingMethodID").val();
        var ShippingMethodName = $("#txtShippingMethodName").val();

        var DisplayOrder = $("#txtDisplayOrder").val();
        var DeliveryTime = $("#txtDeliveryTime").val();
        var WeightLimitFrom = $("#txtWeightLimitFrom").val();
        var WeightLimitTo = $("#txtWeightLimitTo").val();
        var shippingService = $("#ddlShippingService option:selected").val();
        var IsActive = $("#chkIsActive").attr("checked");

        var param = JSON2.stringify({ shippingMethodID: shippingMethodId, shippingMethodName: ShippingMethodName, prevFilePath: prevFilePath, newFilePath: newFilePath, alternateText: AlternateText, displayOrder: DisplayOrder, deliveryTime: DeliveryTime, weightLimitFrom: WeightLimitFrom, weightLimitTo: WeightLimitTo, shippingProviderID: shippingService, storeID: storeId, portalID: portalId, isActive: IsActive, userName: userName, cultureName: cultureName });
        if (shippingService != null) {
            $("#ddlShippingService ").removeClass('error');
            $("#ddlShippingService").parent('td').find('.cssClassRequired').html('');

            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateShippingMethods",
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindShippingMethodGrid(null, null, null, null, null);
                    HideAll();
                    $("#divShowShippingMethodGrid").show();
                },
                error: function() {
                    alert("Error!");
                }
            });
        } else {
            $("#ddlShippingService ").addClass('error');
            $("#ddlShippingService").parent('td').find('.cssClassRequired').html('you need to create shipping service provider before adding shipping method.');
        }
    }

    function BindShippingMethodGrid(shippingMethodNm, deliveryTime, weightFrom, weightTo, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShippingMethod_pagesize").length > 0) ? $("#gdvShippingMethod_pagesize :selected").text() : 10;

        $("#gdvShippingMethod").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetShippingMethodList',
            colModel: [
                { display: 'ShippingMethodID', name: 'shippingmethod_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'ShippingChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Shipping Method Name', name: 'shipping_method_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Shipping PrividerID', name: 'shipping_providerId', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Image Path', name: 'image_path', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Alternate Text', name: 'alternate_text', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Display Order', name: 'display_order', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Delivery Time', name: 'delivery_time', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Weight Limit From', name: 'weight_limit_from', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Weight Limit To', name: 'weight_limit_to', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active', name: 'isActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Shipping Cost', name: 'ShippingCost', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditShippingMethod', arguments: '1,2,3,4,5,6,7,8,9,10,11' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteShippingMethod', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { shippingMethodName: shippingMethodNm, deliveryTime: deliveryTime, weightLimitFrom: weightFrom, weightLimitTo: weightTo, isActive: isAct, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 13: { sorter: false } }
        });
    }

    function EditShippingMethod(tblID, argus) {
        switch (tblID) {
        case "gdvShippingMethod":
            SelectFirstTab();
            $("#ddlShippingService").val(argus[4]);
            $("#hdnPrevFilePath").val(argus[5]);
            $("#shippingIcon").html('<img src="' + aspxRootPath + argus[5] + '" class="uploadImage" height="90px" width="100px"/>');
            $("#txtAlternateText").val(argus[6]);
            $("#hdnShippingMethodID").val(argus[0]);
            $("#txtShippingMethodName").val(argus[3]);
            $("#txtDisplayOrder").val(argus[7]);
            $("#txtDeliveryTime").val(argus[8]);
            $("#txtWeightLimitFrom").val(argus[9]);
            $("#txtWeightLimitTo").val(argus[10]);
            $("#chkIsActive").attr('checked', $.parseJSON(argus[11].toLowerCase()));
            $("#lblHeading").html("Editing shipping method:" + argus[3]);
            HideAll();
            $("#divAddNewShippingMethodForm").show();
            $("#generalSettings").show();
            $("#liShippingSettingChanges").show();
            $("#btnReset").hide();

                //Binding dependencies grids
            BindShippingCostDependencies(argus[0]);
            BindShippingWeightDependencies(argus[0]);
            BindShippingItemDependencies(argus[0]);
            break;
        default:
            break;
        }
    }

    function DeleteShippingMethod(tblID, argus) {
        switch (tblID) {
        case "gdvShippingMethod":
            var properties = {
                onComplete: function(e) {
                    DeleteShippingInfo(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultipleShippings(Ids, event) {
        DeleteShippingInfo(Ids, event);
    }

    function DeleteShippingInfo(_shippingMethod_Ids, event) {
        if (event) {
            var params = { shippingMethodIds: _shippingMethod_Ids, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteShippingByShippingMethodID",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindShippingMethodGrid(null, null, null, null, null);
                }
            });
        }
        return false;
    }

    function HideAll() {
        $("#divShowShippingMethodGrid").hide();
        $("#divAddNewShippingMethodForm").hide();
    }

    function ClearForm() {
        $("#txtShippingMethodName").val('');
        $('#txtShippingMethodName').removeClass('error');
        $('#txtShippingMethodName').parents('td').find('label').remove();
        $("#txtDeliveryTime").val('');
        $('#txtDeliveryTime').removeClass('error');
        $('#txtDeliveryTime').parents('td').find('label').remove();
        $("#txtAlternateText").val('');
        $('#txtAlternateText').removeClass('error');
        $('#txtAlternateText').parents('td').find('label').remove();
        $("#txtWeightLimitFrom").val('');
        $('#txtWeightLimitFrom').removeClass('error');
        $('#txtWeightLimitFrom').parents('td').find('label').remove();
        $("#txtWeightLimitTo").val('');
        $('#txtWeightLimitTo').removeClass('error');
        $('#txtWeightLimitTo').parents('td').find('label').remove();
        $("#txtDisplayOrder").val('');
        $('#txtDisplayOrder').removeClass('error');
        $('#txtDisplayOrder').parents('td').find('label').remove();
        $("#ddlShippingService").val('');
        $('#chkIsActive').removeAttr('checked');
        $("#fileUpload").val('');
        $("#shippingIcon").html('');
        $("#lblHeading").html('Add New Shipping Method:');
        $("#hdnShippingMethodID").val(0);
        $("#hdnPrevFilePath").val("");
        SelectFirstTab();
    }

    function ClearAddDependencies() {
        $("#txtCost").val('');
        $("#txtCostRateValue").val('');
        $("#ddlCostDependencies").val('');
        $("#txtWeight").val('');
        $("#txtWeightRateValue").val('');
        $("#ddlWeightDependencies").val('');
        $('#chkPerLbs').removeAttr('checked');
        $("#txtQuantity").val('');
        $("#txtQuantityRateValue").val('');
        $("#ddlItemDependencies").val('');
        $('#chkPerItems').removeAttr('checked');
    }

    function HideTables() {
        $("#tblcostdependencies").hide();
        $("#tblWeightDependencies").hide();
        $("#tblItemDependencies").hide();
        $("#CostDependencyButtonWrapper").hide();
        $("#WeightDependencyButtonWrapper").hide();
        $("#ItemDependencyButtonWrapper").hide();
    }

    function BindShippingCostDependencies(methodId) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAddCostDependencies_pagesize").length > 0) ? $("#gdvAddCostDependencies_pagesize :selected").text() : 10;

        $("#gdvAddCostDependencies").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCostDependenciesListInfo',
            colModel: [
                { display: 'ShippingProductCostID', name: 'shippingproductcost_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'CostChkbox', elemDefault: false, controlclass: 'costHeaderChkbox' },
                { display: 'Shipping Method ID', name: 'shipping_method_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Product Cost (More than $)', name: 'cost', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Rate Value ', name: 'rate_value', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Rate In Percentage', name: 'is_price_in_percentage', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCostDependencies', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, shippingMethodId: methodId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function DeleteCostDependencies(tblID, argus) {
        switch (tblID) {
        case "gdvAddCostDependencies":
            var properties = {
                onComplete: function(e) {
                    DeleteShippingCostInfo(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultipleShippingCostDependencies(Ids, event) {
        DeleteShippingCostInfo(Ids, event);
    }

    function DeleteShippingCostInfo(ShippingProductCost_Ids, event) {
        if (event) {
            var methodId = $("#hdnShippingMethodID").val();
            var params = { shippingProductCostIds: ShippingProductCost_Ids, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCostDependencies",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindShippingCostDependencies(methodId);
                }
            });
        }
        return false;
    }

    function SaveCostDependenciesValues() {
        var methodId = $("#hdnShippingMethodID").val();
        var shippingProductCost_ID = 0;
        var _CostDependenciesOptions = '';
        $('#tblcostdependencies>tbody tr').each(function() {
            _CostDependenciesOptions += $(this).find(".cssClassCost").val() + ',';
            _CostDependenciesOptions += $(this).find(".cssClassCostRateValue").val() + ',';
            var selectedCostStatus = $(this).find('#ddlCostDependencies option:selected').val();
            _CostDependenciesOptions += selectedCostStatus + '#';
        });
        var param = JSON2.stringify({ shippingProductCostID: shippingProductCost_ID, shippingMethodID: methodId, costDependenciesOptions: _CostDependenciesOptions, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveCostDependencies",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindShippingCostDependencies(methodId);
                $("#tblcostdependencies tr:gt(0)").next().remove();
                $('#fade, #popuprel').fadeOut();
                return false;
            },
            error: function() {
                alert("Error!");
                return false;
            }
        });
    }

    function BindShippingWeightDependencies(methodId) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAddWeightDependencies_pagesize").length > 0) ? $("#gdvAddWeightDependencies_pagesize :selected").text() : 10;

        $("#gdvAddWeightDependencies").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetWeightDependenciesListInfo',
            colModel: [
                { display: 'ShippingProductWeightID', name: 'shippingproductweight_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'WeightChkbox', elemDefault: false, controlclass: 'weightHeaderChkbox' },
                { display: 'Shipping Method ID', name: 'shipping_method_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Product Weight (More than lbs)', name: 'produst_weight', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Rate Value', name: 'rate_value_from', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Rate In Percentage', name: 'is_price_in_percentage', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Per Lbs', name: 'Per_Lbs', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteWeightDependencies', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, shippingMethodId: methodId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 8: { sorter: false } }
        });

    }

    function DeleteWeightDependencies(tblID, argus) {
        switch (tblID) {
        case "gdvAddWeightDependencies":
            var properties = {
                onComplete: function(e) {
                    DeleteShippingWeightInfo(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultipleShippingWeightDependencies(weight_Ids, event) {
        DeleteShippingWeightInfo(weight_Ids, event);
    }

    function DeleteShippingWeightInfo(_shippingProductWeight_Ids, event) {
        if (event) {
            var methodId = $("#hdnShippingMethodID").val();
            var params = { shippingProductWeightIds: _shippingProductWeight_Ids, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteWeightDependencies",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindShippingWeightDependencies(methodId);
                }
            });
        }
        return false;
    }

    function SaveWeightDependenciesValues() {
        var methodId = $("#hdnShippingMethodID").val();
        var shippingProductWeight_ID = 0;
        var _WeightDependenciesOptions = '';
        $('#tblWeightDependencies>tbody tr').each(function() {
            _WeightDependenciesOptions += $(this).find(".cssClassWeight").val() + ',';
            _WeightDependenciesOptions += $(this).find(".cssClassWeightRateValue").val() + ',';
            var selectedWeightStatus = $(this).find('#ddlWeightDependencies option:selected').val();
            _WeightDependenciesOptions += selectedWeightStatus + ',';
            _WeightDependenciesOptions += $(this).find(".cssClassWeightIsActive").attr('checked') + '#';
        });
        var param = JSON2.stringify({ shippingProductWeightID: shippingProductWeight_ID, shippingMethodID: methodId, weightDependenciesOptions: _WeightDependenciesOptions, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveWeightDependencies",
            data: param,
            contentType: "application/json; chatset=utf-8",
            dataType: "json",
            success: function() {
                BindShippingWeightDependencies(methodId);
                $("#tblWeightDependencies tr:gt(0)").next().remove();
                $('#fade, #popuprel').fadeOut();
                return false;
            },
            error: function() {
                alert("Error!");
                return false;
            }
        });
    }

    function BindShippingItemDependencies(methodId) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAddItemDependencies_pagesize").length > 0) ? $("#gdvAddItemDependencies_pagesize :selected").text() : 10;

        $("#gdvAddItemDependencies").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetItemDependenciesListInfo',
            colModel: [
                { display: 'ShippingItemID', name: 'shippingitem_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'ItemChkbox', elemDefault: false, controlclass: 'itemHeaderChkbox' },
                { display: 'Shipping Method ID', name: 'shipping_method_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Product Quantity (More than item(s))', name: 'produst_quantity', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Rate Value', name: 'rate_value_from', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Rate In Percentage', name: 'is_price_in_percentage', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Per Item', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteItemDependencies', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, shippingMethodId: methodId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 8: { sorter: false } }
        });
    }

    function DeleteItemDependencies(tblID, argus) {
        switch (tblID) {
        case "gdvAddItemDependencies":
            var properties = {
                onComplete: function(e) {
                    DeleteShippingItemInfo(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultipleShippingItemDependencies(Ids, event) {
        DeleteShippingItemInfo(Ids, event);
    }

    function DeleteShippingItemInfo(_ShippingItem_Ids, event) {
        if (event) {
            var methodId = $("#hdnShippingMethodID").val();
            var params = { shippingItemIds: _ShippingItem_Ids, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteItemDependencies",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindShippingItemDependencies(methodId);
                }
            });
        }
        return false;
    }

    function SaveItemDependenciesValues() {
        var methodId = $("#hdnShippingMethodID").val();
        var shippingItem_ID = 0;
        var _ItemDependenciesOptions = '';
        $('#tblItemDependencies>tbody tr').each(function() {
            _ItemDependenciesOptions += $(this).find(".cssClassQuantity").val() + ',';
            _ItemDependenciesOptions += $(this).find(".cssClassQuantityRateValue").val() + ',';
            var selectedItemStatus = $(this).find('#ddlItemDependencies option:selected').val();
            _ItemDependenciesOptions += selectedItemStatus + ',';
            _ItemDependenciesOptions += $(this).find(".cssClassItemIsActive").attr('checked') + '#';
        });
        var param = JSON2.stringify({ shippingItemID: shippingItem_ID, shippingMethodID: methodId, itemDependenciesOptions: _ItemDependenciesOptions, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveItemDependencies",
            data: param,
            contentType: "application/json; chatset=utf-8",
            dataType: "json",
            success: function() {
                BindShippingItemDependencies(methodId);
                $("#tblItemDependencies tr:gt(0)").next().remove();
                $('#fade, #popuprel').fadeOut();
                return false;
            },
            error: function() {
                alert("Error!");
                return false;
            }
        });
    }

    function SearchShippingMethods() {
        var shippingMethodNm = $.trim($("#txtMethodName").val());
        var deliveryTime = $.trim($("#txtSearchDeliveryTime").val());
        var weightFrom = $.trim($("#txtWeightFrom").val());
        var weightTo = $.trim($("#txtWeightTo").val());
        var isAct = $.trim($("#ddlIsActive").val()) == "" ? null : $.trim($("#ddlIsActive").val()) == 0 ? true : false;
        if (shippingMethodNm.length < 1) {
            shippingMethodNm = null;
        }
        if (deliveryTime.length < 1) {
            deliveryTime = null;
        }

        if (weightFrom.length < 1) {
            weightFrom = null;
        }


        if (weightTo.length < 1) {
            weightTo = null;
        }

        if (weightTo < weightFrom) {
            csscody.alert('<h1>Alert Message</h1><p>Invalid Weight range! Weight From should be less than Weight To..</p>');
            return false;
        }
        BindShippingMethodGrid(shippingMethodNm, deliveryTime, weightFrom, weightTo, isAct);
    }
</script>

<!-- Grid -->
<div id="divShowShippingMethodGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitleShippingMethods" runat="server" Text="Shipping Methods"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewShippingMethod">
                            <span><span>Add New Shipping Method</span></span></button>
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
                                    Shipping Method Name:</label>
                                <input type="text" id="txtMethodName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Delivery Time:</label>
                                <input type="text" id="txtSearchDeliveryTime" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Weight Limit From:</label>
                                <input type="text" id="txtWeightFrom" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Weight Limit To:</label>
                                <input type="text" id="txtWeightTo" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    IsActive:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="0">True</option>
                                    <option value="1">False</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchShippingMethods() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxShippingMgmtImage1"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvShippingMethod" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End of Grid -->
<!-- form -->
<div id="divAddNewShippingMethodForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblHeading" runat="server" Text="Add New Shipping Method"></asp:Label>
            </h2>
        </div>
        <div class="cssClassTabPanelTable">
            <div class="cssClassTabpanelContent" id="container-7">
                <ul>
                    <li><a href="#fragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="General Settings"></asp:Label>
                        </a></li>
                    <li id="liShippingSettingChanges"><a href="#fragment-2">
                                                          <asp:Label ID="lblTabTitle2" runat="server" Text="Shipping Charges Settings"></asp:Label>
                                                      </a></li>
                </ul>
                <div id="fragment-1">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab1Info" runat="server" Text="General Information"></asp:Label>
                        </h3>
                        <table border="0" width="100%" id="tblShippingMethodForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingMethodName" Text="Name:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtShippingMethodName" name="name" class="cssClassNormalTextBox required"
                                           minlength="2" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingMethodIcon" runat="server" Text="Icon:" CssClass="cssClassLabel"></asp:Label>
                                    <%--<span class="cssClassRequired">*</span>--%>
                                </td>
                                <td>
                                    <input id="fileUpload" type="file" class="cssClassBrowse" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;
                                </td>
                                <td>
                                    <div id="shippingIcon">
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingAlternateText" runat="server" Text="AlternateText:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtAlternateText" class="cssClassNormalTextBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingDisplayOrder" runat="server" Text="Display Order:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtDisplayOrder" name="displayOrder" class="cssClassNormalTextBox required digits"
                                           minlength="1" /> <span id="errdisplayOrder"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingDeliveryTime" runat="server" Text="Delivery Time:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtDeliveryTime" name="deliveryTime" class="cssClassNormalTextBox required"
                                           minlength="2" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblWeightLimitFrom" runat="server" Text="Weight Limit From:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtWeightLimitFrom" name="weightFrom" maxlength="5" class="cssClassNormalTextBox required number"
                                           minlength="1" /><span id='lblNotificationlf' style="color: #FF0000;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblWeightLimitTo" runat="server" Text="Weight Limit To:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtWeightLimitTo" name="weightTo" maxlength="5" class="cssClassNormalTextBox required number"
                                           minlength="1" /><span id='lblNotificationlt' style="color: #FF0000;"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingService" runat="server" Text="Shipping Service:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <select id="ddlShippingService" class="cssClassDropDown" name="" title="Shipping Method List">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblIsActive" runat="server" Text="IsActive:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="checkbox" id="chkIsActive" class="cssClassCheckBox" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="fragment-2">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab2Info" runat="server" Text="Shipping Charges Settings"></asp:Label>
                        </h3>
                        <div>
                            <div class="cssClassCommonBox Curve">
                                <div class="cssClassHeader">
                                    <h2>
                                        <asp:Label ID="lblTitle1" runat="server" Text="Cost Dependencies:"></asp:Label>
                                    </h2>
                                    <div class="cssClassHeaderRight">
                                        <div class="cssClassButtonWrapper">
                                            <p>
                                                <button type="button" id="btnDeleteCostDependencies">
                                                    <span><span>Delete Selected Cost Dependencies</span></span></button>
                                            </p>
                                            <p>
                                                <button type="button" id="btnAddCostDependencies" rel="popuprel">
                                                    <span><span>Add Cost Dependencies</span></span></button>
                                            </p>
                                            <div class="cssClassClear">
                                            </div>
                                        </div>
                                        <div class="cssClassClear">
                                        </div>
                                    </div>
                                </div>
                                <div class="cssClassGridWrapper">
                                    <div class="cssClassGridWrapperContent">
                                        <div class="loading">
                                            <img id="ajaxShippingMgmtImage4"/>
                                        </div>
                                        <div class="log">
                                        </div>
                                        <table id="gdvAddCostDependencies" width="100%" border="0" cellpadding="0" cellspacing="0">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div>
                            <div class="cssClassCommonBox Curve">
                                <div class="cssClassHeader">
                                    <h2>
                                        <asp:Label ID="lblWtDependencyTitle" runat="server" Text="Weight Dependencies:"></asp:Label>
                                    </h2>
                                    <div class="cssClassHeaderRight">
                                        <div class="cssClassButtonWrapper">
                                            <p>
                                                <button type="button" id="btnDeleteWeightDependencies">
                                                    <span><span>Delete Selected Weight Dependencies</span></span></button>
                                            </p>
                                            <p>
                                                <button type="button" id="btnAddWeightDependencies" rel="popuprel">
                                                    <span><span>Add Weight Dependencies</span></span></button>
                                            </p>
                                            <div class="cssClassClear">
                                            </div>
                                        </div>
                                        <div class="cssClassClear">
                                        </div>
                                    </div>
                                </div>
                                <div class="cssClassGridWrapper">
                                    <div class="cssClassGridWrapperContent">
                                        <div class="loading">
                                            <img id="ajaxShippingMgmtImage3" />
                                        </div>
                                        <div class="log">
                                        </div>
                                        <table id="gdvAddWeightDependencies" width="100%" border="0" cellpadding="0" cellspacing="0">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cssClassClear">
                    </div>
                    <div>
                        <div class="cssClassCommonBox Curve">
                            <div class="cssClassHeader">
                                <h2>
                                    <asp:Label ID="lblItemDepTitle" runat="server" Text="Item Dependencies:"></asp:Label>
                                </h2>
                                <div class="cssClassHeaderRight">
                                    <div class="cssClassButtonWrapper">
                                        <p>
                                            <button type="button" id="btnDeleteItemDependencies">
                                                <span><span>Delete Selected Item Dependencies</span></span></button>
                                        </p>
                                        <p>
                                            <button type="button" id="btnAddItemDependencies" rel="popuprel">
                                                <span><span>Add Item Dependencies</span></span></button>
                                        </p>
                                        <div class="cssClassClear">
                                        </div>
                                    </div>
                                    <div class="cssClassClear">
                                    </div>
                                </div>
                            </div>
                            <div class="cssClassGridWrapper">
                                <div class="cssClassGridWrapperContent">
                                    <div class="loading">
                                        <img id="ajaxShippingMgmtImage2"/>
                                    </div>
                                    <div class="log">
                                    </div>
                                    <table id="gdvAddItemDependencies" width="100%" border="0" cellpadding="0" cellspacing="0">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnCancel">
                        <span><span>Cancel</span></span></button>
                </p>
                <p>
                    <input type="button" id="btnReset" value="Reset" class="cssClassButtonSubmit" />
                </p>
                <p>
                    <input type="submit" id="btnSave" value="Save" class="cssClassButtonSubmit" />
                </p>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hdnShippingMethodID" />
<input type="hidden" id="hdnPrevFilePath" />
<!-- End form -->
<!--PopUP-->
<div class="popupbox" id="popuprel">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <label id="lblTitleDependencies">
        </label>
    </h2>
    <table border="0" width="100%" cellpadding="0" cellspacing="0" id="tblcostdependencies">
        <thead>
            <th>
                &nbsp;
            </th>
            <th>
                Cost
            </th>
            <th>
                Rate Value
            </th>
            <th>
                Rate Type
            </th>
            <th>
                &nbsp;
            </th>
        </thead>
        <tr>
            <td>
                <label id="lblCostDedendencies" class="cssClassLabel">
                    More Than $</label>
            </td>
            <td>
                <input type="text" id="txtCost" name="cost" maxlength="5" class="cssClassCost" minlength="1" />
                <span class="cssClassRequired">*</span><span id="errmsgCost"></span>
            </td>
            <td>
                <input type="text" id="txtCostRateValue" name="rateValue" maxlength="5" class="cssClassCostRateValue"
                       minlength="1" />
                <span class="cssClassRequired">*</span><span id="errmsgRateValue"></span>
            </td>
            <td>
                <select id="ddlCostDependencies" class="cssClassDropDownCostDependencies">
                    <option value="0">Absolute ($)</option>
                    <option value="1">Percent (%)</option>
                </select>
            </td>
            <td>
                <span class="nowrap">
                    <img width="13" height="18" border="0" align="top" class="cssClassAddRow" title="Add empty item"
                         alt="Add empty item" name="add" >&nbsp;
                    <img width="13" height="18" border="0" align="top" class="cssClassCloneRow" alt="Clone this item"
                         title="Clone this item" name="clone" >&nbsp;
                    <img width="12" height="18" border="0" align="top" class="cssClassDeleteRow" alt="Remove this item"
                         name="remove" >&nbsp;
                </span>
            </td>
        </tr>
    </table>
    <div class="cssClassButtonWrapper" id="CostDependencyButtonWrapper">
        <p>
            <button type="button" id="btnCancelCostDependencies">
                <span><span>Cancel</span></span></button>
        </p>
        <p>
            <button type="button" id="btnCreateCost">
                <span><span>Create</span></span></button>
        </p>
    </div>
    <table border="0" width="100%" cellpadding="0" cellspacing="0" id="tblWeightDependencies">
        <thead>
            <th>
                &nbsp;
            </th>
            <th>
                Weight
            </th>
            <th>
                Rate Value
            </th>
            <th>
                Rate Type
            </th>
            <th>
                Is Per Lbs?
            </th>
            <th>
                &nbsp;
            </th>
        </thead>
        <tr>
            <td>
                <label id="lblWeightDedendencies" class="cssClassLabel">
                    More Than
                </label>
            </td>
            <td>
                <input type="text" id="txtWeight" name="weight" class="cssClassWeight" />
                lbs<span class="cssClassRequired">*</span> <span id="errmsgWeight"></span>
            </td>
            <td>
                <input type="text" id="txtWeightRateValue" name="weightRateValue" class="cssClassWeightRateValue" />
                <span class="cssClassRequired">*</span><span id="errmsgWeightRateValue"></span>
            </td>
            <td>
                <select id="ddlWeightDependencies" class="cssClassDropDownCostDependencies">
                    <option value="0">Absolute ($)</option>
                    <option value="1">Percent (%)</option>
                </select>
            </td>
            <td>
                <input type="checkbox" id="chkPerLbs" class="cssClassWeightIsActive" />
            </td>
            <td>
                <span class="nowrap">
                    <img width="13" height="18" border="0" align="top" class="cssClassWeightAddRow" title="Add empty item"
                         alt="Add empty item" name="add" >&nbsp;
                    <img width="13" height="18" border="0" align="top" class="cssClassWeightCloneRow"
                         alt="Clone this item" title="Clone this item" name="clone" >&nbsp;
                    <img width="12" height="18" border="0" align="top" class="cssClassWeightDeleteRow"
                         alt="Remove this item" name="remove">&nbsp;
                </span>
            </td>
        </tr>
    </table>
    <div class="cssClassButtonWrapper" id="WeightDependencyButtonWrapper">
        <p>
            <button type="button" id="btnCancelWeightDependencies">
                <span><span>Cancel</span></span></button>
        </p>
        <p>
            <button type="button" id="btnCreateWeight">
                <span><span>Create</span></span></button>
        </p>
    </div>
    <table border="0" width="100%" cellpadding="0" cellspacing="0" id="tblItemDependencies">
        <thead>
            <th>
                &nbsp;
            </th>
            <th>
                Quantity
            </th>
            <th>
                Rate Value
            </th>
            <th>
                Rate Type
            </th>
            <th>
                Is Per Items?
            </th>
            <th>
                &nbsp;
            </th>
        </thead>
        <tr>
            <td>
                <label id="lblItemDedendencies" class="cssClassLabel">
                    More Than
                </label>
            </td>
            <td>
                <input type="text" id="txtQuantity" name="quantity" class="cssClassQuantity" />
                item(s)<span class="cssClassRequired">*</span> <span id="errmsgQty"></span>
            </td>
            <td>
                <input type="text" id="txtQuantityRateValue" name="quantityRateValue" class="cssClassQuantityRateValue" />
                <span class="cssClassRequired">*</span><span id="errmsgQtyRateValue"></span>
            </td>
            <td>
                <select id="ddlItemDependencies" class="cssClassDropDownCostDependencies">
                    <option value="0">Absolute ($)</option>
                    <option value="1">Percent (%)</option>
                </select>
            </td>
            <td>
                <input type="checkbox" id="chkPerItems" class="cssClassItemIsActive" />
            </td>
            <td>
                <span class="nowrap">
                    <img width="13" height="18" border="0" align="top" class="cssClassItemAddRow" title="Add empty item"
                         alt="Add empty item" name="add" >&nbsp;
                    <img width="13" height="18" border="0" align="top" class="cssClassItemCloneRow" alt="Clone this item"
                         title="Clone this item" name="clone" >&nbsp;
                    <img width="12" height="18" border="0" align="top" class="cssClassItemDeleteRow"
                         alt="Remove this item" name="remove">&nbsp;
                </span>
            </td>
        </tr>
    </table>
    <div class="cssClassButtonWrapper" id="ItemDependencyButtonWrapper">
        <p>
            <button type="button" id="btnCancelItemDependencies">
                <span><span>Cancel</span></span></button>
        </p>
        <p>
            <button type="button" id="btnCreateItem">
                <span><span>Create</span></span></button>
        </p>
    </div>
</div>
<!-- End PopUP -->