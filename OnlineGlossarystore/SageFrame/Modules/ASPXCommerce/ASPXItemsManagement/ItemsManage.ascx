<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemsManage.ascx.cs" Inherits="Modules_ASPXItemsManagement_ItemsManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var DatePickerIDs = new Array();
    var FileUploaderIDs = new Array();
    var htmlEditorIDs = new Array();
    var editorList = new Array();
    var rowCount = 0;
    var contents = '';
    var isSaved = false;
    var ix = 0;
    var c = 0;
    $(document).ready(function() {
        $("#btnSaveItemVariantOption").click(function() {
            var variantsProperties = $("#tblVariantTable tr:gt(1)").find("input.cssClassDisplayOrder,input.cssClassVariantValueName,inpur.cssClassPriceModifier,input.cssClassWeightModifier");
            var count = 0;
            $.each(variantsProperties, function(index, item) {
                if ($(this).val() <= '') {
                    alert("Enter Variants Properties");
                    count++;
                    return false;
                }
            });
            var counter = 0
            $('#tblVariantTable>tbody tr').each(function() {
                if ($(this).find('inpur.cssClassPriceModifier,input.cssClassWeightModifier').val() != '' && $(this).find('input.cssClassDisplayOrder,input.cssClassVariantValueName').val() == '') {
                    alert("Enter Variants Properties");
                    counter++;
                    return false;
                }
            });
            if (count == 0 && counter == 0)
                SaveItemCostVariantsInfo();
        });

        $('#ddlAttributeType').change(function() {
            HideAllCostVariantImages();
        });
        LoadItemStaticImage();
        BindCostVariantsInputType();

        InitializeVariantTable();

        BindItemsGrid(null, null, null, null, null, null);
        BindItemType();
        BindAttributeSet();
        //CreateCategoryTree();
        $("#gdvItems_grid").show();
        $("#gdvItems_form").hide();
        $("#gdvItems_accordin").hide();
        //$("#ItemMgt_itemID").val(0);

        $('#btnDeleteSelected').click(function() {
            var item_ids = '';
            //Get the multiple Ids of the item selected
            $(".itemsChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    item_ids += $(this).val() + ',';
                }
            });
            if (item_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultiple(item_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        })

        $('#btnReset').click(function() {
            ClearForm();
        })


        $('#btnContinue').click(function() {
            $('#Todatevalidation').attr('class', '');
            $('#Fromdatevalidation').attr('class', '');
            c = 0;
            $("#ItemMgt_itemID").val(0);
            var attributeSetId = '';
            var itemTypeId = '';
            attributeSetId = $("#ddlAttributeSet").val();
            itemTypeId = $("#ddlItemType").val();
            $("#spanSample").html("");
            $("#spanActual").html("");
            ContinueForm(false, attributeSetId, itemTypeId, 0);
        })

        $("#btnAddNew").click(function() {
            $("#btnDelete").hide();
            ClearAttributeForm();
            $("#gdvItems_grid").hide();
            $("#gdvItems_form").show();
            $("#gdvItems_accordin").hide();
            //            $("#ddlSearchItemType>option").remove();
            //            $("#ddlAttributeSetName>option").remove();
            $("#ddlSearchItemType>option").val(1);
            $("#ddlAttributeSetName>option").val(1);
        })

        $("#btnBack").click(function() {
            $("#gdvItems_grid").show();
            $("#gdvItems_form").hide();
            $("#gdvItems_accordin").hide();
        });

        $(".cssClassClose").click(function() {
            $('#fade, #popuprel').fadeOut();
        });

        $("#btnResetVariantOptions").click(function() {
            OnInit();
            ClearVariantForm();
        });

        //validate name on focus lost
        $('#txtCostVariantName').blur(function() {
            // Validate name
            var errors = '';
            var costVariantName = $(this).val();
            var variant_id = $('#btnSaveItemVariantOption').attr("name");
            if (variant_id == '') {
                variant_id = 0;
            }
            if (!costVariantName) {
                errors += ' - Please enter cost variant name';
            }
                //check uniqueness
            else if (!IsUnique(costVariantName, variant_id)) {
                errors += ' - Please enter unique cost variant name! "' + costVariantName.trim() + '" already exists.<br/>';
            }

            if (errors) {
                $('.cssClassCostVarRight').hide();
                $('.cssClassCostVarError').show();
                $(".cssClassCostVarError").parent('div').addClass("diverror");
                $('.cssClassCostVarError').prevAll("input:first").addClass("error");
                $('.cssClassCostVarError').html(errors);
                return false;
            } else {
                $('.cssClassCostVarRight').show();
                $('.cssClassCostVarError').hide();
                $(".cssClassCostVarError").parent('div').removeClass("diverror");
                $('.cssClassCostVarError').prevAll("input:first").removeClass("error");
            }
        });

        $('#btnApplyExisingOption').click(function() {
            var variant_Id = $('#ddlExistingOptions').val();
            var item_Id = $("#ItemMgt_itemID").val();
            if (variant_Id != null && item_Id != null) {
                var params = { itemId: item_Id, costVariantID: variant_Id, storeId: storeId, portalId: portalId, cultureName: cultureName, userName: userName };
                var mydata = JSON2.stringify(params);
                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/AddItemCostVariant",
                    data: mydata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function() {
                        $('#fade, #popuprel').fadeOut();
                        BindItemCostVariantInGrid(item_Id);
                        BindCostVariantsOptions(item_Id);
                        alert('Success');
                    },
                    error: function() {
                        csscody.error('<h1>Error Message</h1><p>Failed to save item cost variant</p>');
                    }
                });
            }
        });
    });

    function LoadItemStaticImage() {
        $('.cssClassAddRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_add.gif');
        $('.cssClassCloneRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif');
        $('.cssClassDeleteRow').attr('src', '' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif');
        $('.cssClassSuccessImg').attr('src', '' + aspxTemplateFolderPath + '/images/right.jpg');
        $('#ajaxImageLoader').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function BindTaxManageRule() {
        var isActive = true;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllTaxRules",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, isActive: isActive }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var option = '<option value=0>--select one--</option>';
                $.each(msg.d, function(ind, item) {
                    option += '<option value="' + item.TaxManageRuleID + '">' + item.TaxManageRuleName + '</option>';
                });
                $("#ddlTax").append(option);
                return true;
            },
            error: function() {
                alert("error");
                return false;
            }
        });
    }

    function BindItemQuantityDiscountsByItemID(itemId) {
        var functionName = 'GetItemQuantityDiscountsByItemID';
        var params = { itemId: itemId, storeID: storeId, portalID: portalId, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblQuantityDiscount>tbody").html('');
                if (msg.d.length > 0) {
                    var arrItems = new Array();
                    $.each(msg.d, function(index, item) {
                        var newQuantityDiscountRow = '';
                        newQuantityDiscountRow += '<tr><td><input type="hidden" size="3" class="cssClassQuantityDiscount" value="' + item.QuantityDiscountID + '"><input type="text" size="3" class="cssClassQuantity" value="' + item.Quantity + '"></td>';
                        newQuantityDiscountRow += '<td><input type="text" size="5" class="cssClassPrice" value="' + item.Price + '"></td>';
                        newQuantityDiscountRow += '<td><div class="cssClassUsersInRoleCheckBox"></div></td>';
                        newQuantityDiscountRow += '<td><span class="nowrap">';
                        newQuantityDiscountRow += '<img width="13" height="18" border="0" align="top" class="cssClassAddDiscountRow" title="Add empty item" alt="Add empty item" name="add" src="' + aspxTemplateFolderPath + '/images/admin/icon_add.gif" >&nbsp;';
                        newQuantityDiscountRow += '<img width="13" height="18" border="0" align="top" class="cssClassCloneDiscountRow" alt="Clone this item" title="Clone this item" name="clone" src="' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif" >&nbsp;';
                        newQuantityDiscountRow += '<img width="12" height="18" border="0" align="top" class="cssClassDeleteDiscountRow" alt="Remove this item" name="remove" src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" >&nbsp;';
                        newQuantityDiscountRow += '</span></td></tr>';
                        $("#tblQuantityDiscount>tbody").append(newQuantityDiscountRow);
                        arrItems.push(item.RoleIDs);
                    });
                    GetUserInRoleList(arrItems);
                } else {
                    var arrItems = new Array();
                    var newQuantityDiscountRow = '';
                    newQuantityDiscountRow += '<tr><td><input type="hidden" size="3" class="cssClassQuantityDiscount" value="0"><input type="text" size="3" class="cssClassQuantity"></td>';
                    newQuantityDiscountRow += '<td><input type="text" size="5" class="cssClassPrice"></td>';
                    newQuantityDiscountRow += '<td><div class="cssClassUsersInRoleCheckBox"></div></td>';
                    newQuantityDiscountRow += '<td><span class="nowrap">';
                    newQuantityDiscountRow += '<img width="13" height="18" border="0" align="top" class="cssClassAddDiscountRow" title="Add empty item" alt="Add empty item" name="add" src="' + aspxTemplateFolderPath + '/images/admin/icon_add.gif" >&nbsp;';
                    newQuantityDiscountRow += '<img width="13" height="18" border="0" align="top" class="cssClassCloneDiscountRow" alt="Clone this item" title="Clone this item" name="clone" src="' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif" >&nbsp;';
                    newQuantityDiscountRow += '<img width="12" height="18" border="0" align="top" class="cssClassDeleteDiscountRow" alt="Remove this item" name="remove" src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" >&nbsp;';
                    newQuantityDiscountRow += '</span></td></tr>';
                    $("#tblQuantityDiscount>tbody").append(newQuantityDiscountRow);
                    GetUserInRoleList(arrItems);
                }
                $("#tblQuantityDiscount>tbody tr:even").addClass("cssClassAlternativeEven");
                $("#tblQuantityDiscount>tbody tr:odd").addClass("cssClassAlternativeOdd");
                $("#tblQuantityDiscount>tbody").find("tr:eq(0)").find("img.cssClassDeleteDiscountRow").hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Cost Variant Values</p>');
            }
        });
    }

    function GetUserInRoleList(arrRoles) {
        var IsAll = true;
        var param = JSON2.stringify({ portalID: portalId, isAll: IsAll, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindRoles",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindRolesList(item);
                });
                if (arrRoles.length > 0) {
                    var divData = $('div.cssClassUsersInRoleCheckBox');
                    $.each(divData, function(index, item) {
                        $.each(arrRoles, function(i) {
                            if (i == index) {
                                var arr = arrRoles[i].split(",");
                                $.each(arr, function(j) {
                                    $(item).find("input[value=" + arr[j] + "]").attr("checked", "checked");
                                });
                            }
                        });
                    });
                }
            }
        });
    }

    function BindRolesList(item) {
        var RoleInCheckbox = '<input type="checkbox" class="cssClassCheckBox"  value="' + item.RoleID + '" /><label>' + item.RoleName + '</label>';
        $('.cssClassUsersInRoleCheckBox').append(RoleInCheckbox);
    }

    function SaveItemDiscountQuantity() {
        var _DiscountQuantityOptions = '';
        var item_Id = $("#ItemMgt_itemID").val();
        $("#tblQuantityDiscount>tbody tr").each(function() {
            _DiscountQuantityOptions += $(this).find(".cssClassQuantityDiscount").val() + ',';
            if ($(this).find(".cssClassQuantity").val() != '') {
                _DiscountQuantityOptions += $(this).find(".cssClassQuantity").val() + ',';
            } else {
                _DiscountQuantityOptions += '0' + ',';
            }
            if ($(this).find(".cssClassPrice").val() != '') {
                _DiscountQuantityOptions += $(this).find(".cssClassPrice").val() + '%';
            } else {
                _DiscountQuantityOptions += '0' + '%';
            }
            var check = $(this).find("input[type='checkbox']:checked");
            if (check.length != 0) {
                $.each(check, function() {
                    _DiscountQuantityOptions += $(this).val() + ',';
                });
                _DiscountQuantityOptions = _DiscountQuantityOptions.substring(0, _DiscountQuantityOptions.length - 1);
            } else {
                _DiscountQuantityOptions += '0';
            }
            _DiscountQuantityOptions += '#';
        });

        var param = JSON2.stringify({ discountQuantity: _DiscountQuantityOptions, itemID: item_Id, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveItemDiscountQuantity",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                var item_Id = $("#ItemMgt_itemID").val();
                BindItemQuantityDiscountsByItemID(item_Id);
                alert("Save Successfully!");
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function HideAllCostVariantImages() {
        var selectedVal = $("#ddlAttributeType").val();
        if (selectedVal == 9 || selectedVal == 11) { //Radio //CheckBox
            $("#tblVariantTable>tbody").find("tr:gt(0)").remove();
            $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassAddRow").hide();
            $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassCloneRow").hide();
        } else {
            $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassAddRow").show();
            $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassCloneRow").show();
        }
    }

    function InitializeVariantTable() {
        $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassDeleteRow").hide();

        $("img.cssClassAddRow").live("click", function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblVariantTable");
            $(cloneRow).find("input[type='text']").val('');
            $(cloneRow).find("input[type='hidden']").val('0');
            $(cloneRow).find(".cssClassDeleteRow").show();
        });

        $("img.cssClassCloneRow").live("click", function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblVariantTable");
            $(cloneRow).find("input[type='hidden']").val('0');
            $(cloneRow).find(".cssClassDeleteRow").show();
        });

        $("img.cssClassDeleteRow").live("click", function() {
            var parentRow = $(this).closest('tr');
            if (parentRow.is(":first-child")) {
                return false;
            } else {
                var itemCostVariantValueId = $(parentRow).find("input[type='hidden']").val();
                if (itemCostVariantValueId > 0) {
                    var item_Id = $("#ItemMgt_itemID").val();
                    DeleteItemCostVaraiantValue(itemCostVariantValueId, item_Id, parentRow);
                } else {
                    $(parentRow).remove();
                }
            }
        });

        //FOR Item Quantity Discount
        $("img.cssClassAddDiscountRow").live("click", function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblQuantityDiscount");
            $(cloneRow).find("input[type='text']").val('');
            $(cloneRow).find("input[type='hidden']").val('0');
            $(cloneRow).find("input[type='checkbox']").removeAttr('checked');
            $(cloneRow).find("img.cssClassDeleteDiscountRow").show();
        });
        $("img.cssClassCloneDiscountRow").live("click", function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#tblQuantityDiscount");
            $(cloneRow).find("input[type='hidden']").val('0');
            $(cloneRow).find("img.cssClassDeleteDiscountRow").show();
        });

        $("img.cssClassDeleteDiscountRow").live("click", function() {
            var parentRow = $(this).closest('tr');
            if (parentRow.is(":first-child")) {
                return false;
            } else {
                var quantityDiscountID = $(parentRow).find("input[type='hidden']").val();
                if (quantityDiscountID > 0) {
                    DeleteItemQuantityDiscount(quantityDiscountID, parentRow);
                } else {
                    $(parentRow).remove();
                }
            }
        });
    }

    //For item quantity discount

    function DeleteItemQuantityDiscount(quantityDiscountID, parentRow) {
        var properties = {
            onComplete: function(e) {
                ConfirmDeleteItemQuantityDiscount(quantityDiscountID, storeId, portalId, userName, parentRow, e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item quatity discount Value?</p>", properties);
    }

    function ConfirmDeleteItemQuantityDiscount(quantityDiscountID, storeId, portalId, userName, parentRow, event) {
        if (event) {
            var _itemId = $("#ItemMgt_itemID").val();
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteItemQuantityDiscount",
                data: JSON2.stringify({ quantityDiscountID: quantityDiscountID, itemID: _itemId, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    $(parentRow).remove();
                    alert("success");
                    return false;
                },
                error: function() {
                    alert("error");
                    return false;
                }
            });
        }
    }

    function DeleteItemCostVaraiantValue(itemCostVariantValueId, itemId, parentRow) {
        var properties = {
            onComplete: function(e) {
                ConfirmDeleteItemCostVariantValue(itemCostVariantValueId, itemId, storeId, portalId, userName, cultureName, parentRow, e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item Cost Variant Value?</p>", properties);
    }

    function ConfirmDeleteItemCostVariantValue(itemCostVariantValueId, itemId, storeId, portalId, userName, cultureName, parentRow, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteItemCostVariantValue",
                data: JSON2.stringify({ itemCostVariantValueID: itemCostVariantValueId, itemId: itemId, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    $(parentRow).remove();
                    alert("success");
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }

    function BindItemCostVariantInGrid(itemId) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvItemCostVariantGrid_pagesize").length > 0) ? $("#gdvItemCostVariantGrid_pagesize :selected").text() : 10;

        $("#gdvItemCostVariantGrid").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetItemCostVariants',
            colModel: [
                { display: 'Item Cost Variant ID', name: 'item_costvariant_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Cost Variant ID', name: 'cost_variant_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Cost Variant Name', name: 'cost_variant_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditItemCostVariant', arguments: '1,2,3' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteItemCostVariant', arguments: '1' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, cultureName: cultureName, itemID: itemId },
            current: current_,
            pnew: offset_,
            sortcol: { 4: { sorter: false } }
        });
    }

    function EditItemCostVariant(tblID, argus) {
        $(".cssClassDisplayOrder").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                //$(".classDisplaoOrder").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $(".cssClassPriceModifier").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                //$("#errmsgCost").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $(".cssClassWeightModifier").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                //$("#errmsgCost").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });
        switch (tblID) {
        case "gdvItemCostVariantGrid":
            ClearVariantForm();
            OnInit();
            $("#tabFrontDisplay").hide();

            $("#hdnItemCostVar").val(argus[0]);

            $("#btnSaveItemVariantOption").attr("name", argus[4]);
            $("#lblHeading").html('Edit Cost variant Option: ' + argus[5]);

            var functionName = 'GetItemCostVariantInfoByCostVariantID';
            var params = { itemCostVariantId: argus[0], itemId: argus[3], costVariantID: argus[4], storeID: storeId, portalID: portalId, cultureName: cultureName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    FillForm(msg);
                    //varinants Tab
                    BindItemCostVariantValueByCostVariantID(argus[0], argus[3], argus[4]);
                    HideAllVariantDivs();
                    $("#divNewVariant").show();
                    ShowPopupControl('popuprel');
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to edit Options</p>');
                }
            });
            break;
        default:
            break;
        }
    }

    function FillForm(response) {
        $.each(response.d, function(index, item) {

            //General properties Tab
            $('#txtCostVariantName').val(item.CostVariantName);
            $('#txtCostVariantName').attr('disabled', 'disabled');
            $('#ddlAttributeType').val(item.InputTypeID);
            $('#ddlAttributeType').attr('disabled', 'disabled');
            $('#txtDisplayOrder').val(item.DisplayOrder);
            $("#txtDescription").val(item.Description);
            $("#txtDescription").attr('disabled', 'disabled');
            $('input[name=chkActive]').attr('checked', item.IsActive);

            //frontend properties tab  
            //$('input[name=chkShowInSearch]').attr('checked', item.ShowInSearch);
            //$('input[name=chkShowInGrid]').attr('checked', item.ShowInGrid);
            $('input[name=chkUseInAdvancedSearch]').attr('checked', item.ShowInAdvanceSearch);

            $('input[name=chkComparable]').attr('checked', item.ShowInComparison);
            $('input[name=chkUseForPriceRule]').attr('checked', item.IsIncludeInPriceRule);
            //$('input[name=chkUseForPromoRule]').attr('checked', item.IsIncludeInPromotions);
            //$('input[name=chkIsEnableSorting]').attr('checked', item.IsEnableSorting);
            //$('input[name=chkIsUseInFilter]').attr('checked', item.IsUseInFilter);
            //$('input[name=chkUseForRating]').attr('checked', item.IsShownInRating);
        });
    }

    function BindItemCostVariantValueByCostVariantID(itemCostVariantId, itemId, costVariantId) {
        var functionName = 'GetItemCostVariantValuesByCostVariantID';
        var params = { itemCostVariantId: itemCostVariantId, itemId: itemId, costVariantID: costVariantId, storeID: storeId, portalID: portalId, cultureName: cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $("#tblVariantTable>tbody").html('');
                    $.each(msg.d, function(index, item) {
                        if (item.DisplayOrder == null) {
                            item.DisplayOrder = '';
                        }
                        var newVariantRow = '';
                        newVariantRow += '<tr><td><input type="hidden" size="3" class="cssClassVariantValue" value="' + item.CostVariantsValueID + '"><input type="text" size="3" class="cssClassDisplayOrder" value="' + item.DisplayOrder + '"></td>';
                        newVariantRow += '<td><input type="text" class="cssClassItemCostVariantValueName" value="' + item.CostVariantsValueName + '"></td>';
                        newVariantRow += '<td><input type="text" size="5" class="cssClassPriceModifier" value="' + item.CostVariantsPriceValue + '">&nbsp;/&nbsp;';
                        newVariantRow += '<select class="cssClassPriceModifierType priceModifierType_' + item.CostVariantsValueID + '"><option value="false">$</option><option value="true">%</option></select></td>';
                        newVariantRow += '<td><input type="text" size="5" class="cssClassWeightModifier" value="' + item.CostVariantsWeightValue + '">&nbsp;/&nbsp;';
                        newVariantRow += '<select class="cssClassWeightModifierType weightModifierType_' + item.CostVariantsValueID + '"><option value="false">lbs</option><option value="true">%</option></select></td>';
                        newVariantRow += '<td><select class="cssClassIsActive isActive_' + item.CostVariantsValueID + '"><option value="true">Active</option><option value="false">Disabled</option></select></td>';
                        newVariantRow += '<td><span class="nowrap">';
                        newVariantRow += '<img width="13" height="18" border="0" align="top" class="cssClassAddRow" title="Add empty item" alt="Add empty item" name="add" src="' + aspxTemplateFolderPath + '/images/admin/icon_add.gif" >&nbsp;';
                        newVariantRow += '<img width="13" height="18" border="0" align="top" class="cssClassCloneRow" alt="Clone this item" title="Clone this item" name="clone" src="' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif" >&nbsp;';
                        newVariantRow += '<img width="12" height="18" border="0" align="top" class="cssClassDeleteRow" alt="Remove this item" name="remove" src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" >&nbsp;';
                        newVariantRow += '</span></td></tr>';
                        $("#tblVariantTable>tbody").append(newVariantRow);

                        $('.priceModifierType_' + item.CostVariantsValueID).val('' + item.IsPriceInPercentage + '');
                        $('.weightModifierType_' + item.CostVariantsValueID).val('' + item.IsWeightInPercentage + '');
                        $('.isActive_' + item.CostVariantsValueID).val('' + item.IsActive + '');
                    });
                    $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassDeleteRow").hide();
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Cost Variant Values</p>');
            }
        });
    }

    function DeleteItemCostVariant(tblID, argus) {
        switch (tblID) {
        case "gdvItemCostVariantGrid":
            DeleteItemCostVariantByID(argus[0], argus[3], storeId, portalId, userName);
            break;
        default:
            break;
        }
    }

    function DeleteItemCostVariantByID(_itemCostVariantId, _itemId, _storeId, _portalId, _userName) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDeleteItemCostVariant(_itemCostVariantId, _itemId, _storeId, _portalId, _userName, e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this Item Cost Variant option?</p>", properties);
    }

    function ConfirmSingleDeleteItemCostVariant(itemCostVariantID, itemId, storeId, portalId, userName, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteSingleItemCostVariant",
                data: JSON2.stringify({ itemCostVariantID: itemCostVariantID, itemId: itemId, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindCostVariantsOptions(itemId);
                    BindItemCostVariantInGrid(itemId);
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }

    function BindCostVariantsInputType() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCostVariantInputTypeList",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                //$("#ddlAttributeType").get(0).options.length = 0;
                $.each(msg.d, function(index, item) {
                    BindInputTypeDropDown(item);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attributes input type</p>');
            }
        });
    }

    function BindInputTypeDropDown(item) {
        //$("#ddlAttributeType").get(0).options[$("#ddlAttributeType").get(0).options.length] = new Option(item.InputType, item.InputTypeID);
        $("#ddlAttributeType").append("<option value=" + item.InputTypeID + ">" + item.InputType + "</option>");
    }

    function BindCostVariantsOptions(itemId) {
        var params = { itemId: itemId, storeId: storeId, portalId: portalId, cultureName: cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCostVariantsOptionsList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $('#lblExistingOptions').html('Existing Cost Variant Options:');
                    $("select[id$=ddlExistingOptions] > option").remove();
                    $.each(msg.d, function(index, item) {
                        BindCostVariantsDropDown(item);
                    });
                    $("#divExisitingDropDown").show();
                } else {
                    $("#divExisitingDropDown").hide();
                    $("#lblExistingOptions").html('There is not any existing Cost Variant Options available!');
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attributes input type</p>');
            }
        });
    }

    function BindCostVariantsDropDown(item) {
        //$("#ddlExistingOptions").get(0).options[$("#ddlExistingOptions").get(0).options.length] = new Option(item.InputType, item.InputTypeID);
        $("#ddlExistingOptions").append("<option value=" + item.CostVariantID + ">" + item.CostVariantName + "</option>");
    }

    function ClearVariantForm() {
        $("#btnSaveItemVariantOption").removeAttr("name");
        $("#btnResetVariantOptions").show();

        $("#txtCostVariantName").val('');
        $('#txtCostVariantName').removeAttr('disabled');
        $("#txtDescription").val('');
        $("#txtDescription").removeAttr('disabled');
        $('#ddlAttributeType').val(1);
        $('#ddlAttributeType').removeAttr('disabled');
        $('#txtDisplayOrder').val('');
        $('input[name=chkActive]').attr('checked', 'checked');

        $("#lblHeading").html('Add New Cost Variant Option');

        //Next Tab
        //$('input[name=chkShowInSearch]').removeAttr('checked');
        //$('input[name=chkShowInGrid]').removeAttr('checked');
        $('input[name=chkUseInAdvancedSearch]').removeAttr('checked');
        $('input[name=chkComparable]').removeAttr('checked');
        $('input[name=chkUseForPriceRule]').removeAttr('checked');
        //$('input[name=chkUseForPromoRule]').removeAttr('checked');
        //$('input[name=chkIsEnableSorting]').removeAttr('checked');
        //$('input[name=chkIsUseInFilter]').removeAttr('checked');
        //$('input[name=chkUseForRating]').removeAttr('checked');

        //Clear variant tab
        $("#tblVariantTable>tbody").find("tr:gt(0)").remove();
        $("#tblVariantTable>tbody").find("input[type='text']").val('');
        $("#tblVariantTable>tbody").find("select").val(1);
        $("#tblVariantTable>tbody").find("input[type='hidden']").val('0');
        $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassDeleteRow").hide();

        return false;
    }

    function OnInit() {
        $('#btnResetVariantOptions').hide();
        $("#hdnItemCostVar").val('0');
        $('.cssClassCostVarRight').hide();
        $('.cssClassCostVarError').hide();
        SelectFirstTab();
    }

    function SelectFirstTab() {
        var $tabs = $('#container-7').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function IsUnique(costVariantName, costVariantId) {
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckUniqueCostVariantName",
            data: JSON2.stringify({ costVariantName: costVariantName, costVariantId: costVariantId, storeId: storeId, portalId: portalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isUnique = data.d;
            }
        });
        return isUnique;
    }

    function SaveItemCostVariantsInfo() {
        var variant_id = $('#btnSaveItemVariantOption').attr("name");

        if (variant_id != '') {
            SaveItemCostVariant(variant_id, storeId, portalId, userName, cultureName, false);
        } else {
            SaveItemCostVariant(0, storeId, portalId, userName, cultureName, true);
        }
    }

    function SaveItemCostVariant(_costVariantId, _storeId, _portalId, _userName, _cultureName, _isNewflag) {
        var validateErrorMessage = '';
        // Validate name
        var costVariantName = $('#txtCostVariantName').val();
        if (!costVariantName) {
            validateErrorMessage += ' - Please enter cost variant name<br/>';
        } else if (!IsUnique(costVariantName, _costVariantId)) {
            validateErrorMessage += ' - Please enter unique cost variant name! "' + costVariantName.trim() + '" already exists.<br/>';
        }

        // Validate cost variant Display Order
        var costVariantDisplayOrder = $("#txtDisplayOrder").val();
        if (!costVariantDisplayOrder) {
            $("#txtDisplayOrder").focus();
            validateErrorMessage += ' - Please enter cost variant display order<br/>';
        } else {
            var value = costVariantDisplayOrder.replace( /^\s\s*/ , '').replace( /\s\s*$/ , '');
            var intRegex = /^\d+$/ ;
            if (!intRegex.test(value)) {
                $("#txtDisplayOrder").focus();
                validateErrorMessage += ' - Cost variant display order must be numeric only.<br/>';
            }
        }

        if (validateErrorMessage) {
            validateErrorMessage = 'The following errors occurred:<br/>' + validateErrorMessage;
            csscody.alert('<h1>Information Alert</h1><p>' + validateErrorMessage + '</p>');
            return false;
        } else {
            var _StoreID = _storeId;
            var _PortalID = _portalId;
            var _CultureName = _cultureName;
            var _UserName = _userName;
            var _itemId = $("#ItemMgt_itemID").val();

            var _costVariantName = $('#txtCostVariantName').val();
            var _inputTypeID = $('#ddlAttributeType').val();

            var selectedCostVariantType = $("#ddlAttributeType :selected").val();

            var _Description = $('#txtDescription').val();
            var _DisplayOrder = $('#txtDisplayOrder').val();
            var _ShowInGrid = false; //$('input[name=chkShowInGrid]').attr('checked');
            var _ShowInSearch = false; //$('input[name=chkShowInSearch]').attr('checked');
            var _ShowInAdvanceSearch = false; //$('input[name=chkUseInAdvancedSearch]').attr('checked');
            var _ShowInComparison = false; //$('input[name=chkComparable]').attr('checked');
            var _IsEnableSorting = false; //$('input[name=chkIsEnableSorting]').attr('checked');
            var _IsUseInFilter = false; //$('input[name=chkIsUseInFilter]').attr('checked');
            var _IsIncludeInPriceRule = false; //$('input[name=chkUseForPriceRule]').attr('checked');
            var _IsIncludeInPromotions = false; //$('input[name=chkUseForPromoRule]').attr('checked');
            var _IsShownInRating = false; //$('input[name=chkUseForRating]').attr('checked');
            var _IsActive = $('input[name=chkActive]').attr('checked');
            var _IsModified = !(_isNewflag);
            var _IsNewflag = _isNewflag;

            var _VariantOptions = '';
            //if ($('#variantTab').is(':visible')) {
            $('#tblVariantTable>tbody tr').each(function() {
                _VariantOptions += $(this).find(".cssClassVariantValue").val() + ',';
                _VariantOptions += $(this).find(".cssClassDisplayOrder").val() + ','; //{required:true,digits:true,minlength:1}
                _VariantOptions += $(this).find(".cssClassItemCostVariantValueName").val() + ','; //{required:true,minlength:2}
                if ($(this).find(".cssClassVariantValueName").val() != '' && $(this).find(".cssClassPriceModifier").val() == '') {
                    _VariantOptions += 0.00 + ',';
                } else {
                    _VariantOptions += $(this).find(".cssClassPriceModifier").val() + ','; //{required:true,number:true,minlength:1}
                }
                _VariantOptions += $(this).find(".cssClassPriceModifierType").val() + ',';
                if ($(this).find(".cssClassVariantValueName").val() != '' && $(this).find(".cssClassWeightModifier").val() == '') {
                    _VariantOptions += 0.00 + ',';
                } else {
                    _VariantOptions += $(this).find(".cssClassWeightModifier").val() + ','; //{required:true,number:true,minlength:1}
                }
                _VariantOptions += $(this).find(".cssClassWeightModifierType").val() + ',';
                _VariantOptions += $(this).find(".cssClassIsActive").val() + '%';
            });
            //}
            //TODO:: validation HERE First
            //            // Validate cost variant options 
            //            var costVariantDisplayOrder = $("#txtDisplayOrder").val();
            //            if (!costVariantDisplayOrder) {
            //                $("#txtDisplayOrder").focus();
            //                validateErrorMessage += ' - Please enter cost variant display order<br/>';
            //            }
            //            else {
            //                var value = costVariantDisplayOrder.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
            //                var intRegex = /^\d+$/;
            //                if (!intRegex.test(value)) {
            //                    $("#txtDisplayOrder").focus();
            //                    validateErrorMessage += ' - Cost variant display order must be numeric only.<br/>';
            //                }
            //            }

            AddItemCostVariantInfo(_costVariantId, _costVariantName, _Description, _CultureName, _itemId, _inputTypeID, _DisplayOrder, _ShowInGrid, _ShowInSearch,
                _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter, _IsIncludeInPriceRule, _IsIncludeInPromotions, _IsShownInRating,
                _StoreID, _PortalID, _IsActive, _IsModified, _UserName, _VariantOptions, _IsNewflag);

        }
        return false;
    }

    function AddItemCostVariantInfo(_costVariantId, _costVariantName, _Description, _CultureName, _itemId, _inputTypeID, _DisplayOrder, _ShowInGrid, _ShowInSearch,
        _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter, _IsIncludeInPriceRule, _IsIncludeInPromotions, _IsShownInRating,
        _StoreID, _PortalID, _IsActive, _IsModified, _UserName, _VariantOptions, _IsNewflag) {

        var params = {
            costVariantID: _costVariantId,
            costVariantName: _costVariantName,
            description: _Description,
            cultureName: _CultureName,
            itemId: _itemId,
            inputTypeID: _inputTypeID,
            displayOrder: _DisplayOrder,
            showInGrid: _ShowInGrid,
            showInSearch: _ShowInSearch,
            showInAdvanceSearch: _ShowInAdvanceSearch,
            showInComparison: _ShowInComparison,
            isEnableSorting: _IsEnableSorting,
            isUseInFilter: _IsUseInFilter,
            isIncludeInPriceRule: _IsIncludeInPriceRule,
            isIncludeInPromotions: _IsIncludeInPromotions,
            isShownInRating: _IsShownInRating,
            storeId: _StoreID,
            portalId: _PortalID,
            isActive: _IsActive,
            isModified: _IsModified,
            userName: _UserName,
            variantOptions: _VariantOptions,
            isNewflag: _IsNewflag
        };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateItemCostVariant",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                alert("success");
                BindItemCostVariantInGrid(_itemId);
                $('#fade, #popuprel').fadeOut();
            }
        });
    }

    function ClickToDeleteImage(objImg) {
        $(objImg).closest('span').html('');
        return false;
    }

    function ConfirmDeleteMultiple(item_ids, event) {
        if (event) {
            DeleteMultipleItems(item_ids, storeId, portalId, userName);
        }
        return false;
    }

    function DeleteMultipleItems(_itemIds, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { itemIds: _itemIds, storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleItemsByItemID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindItemsGrid(null, null, null, null, null, null);
            }
        });
    }

    function BindItemsGrid(sku, Nm, itemType, attributeSetNm, visibility, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvItems_pagesize").length > 0) ? $("#gdvItems_pagesize :selected").text() : 10;

        $("#gdvItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'itemsChkbox', elemDefault: false, controlclass: 'classClassCheckBox' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'ItemType ID', name: 'itemtype_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Type', name: 'item_type', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AttributeSet ID', name: 'attributeset_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Attribute Set Name', name: 'attribute_set_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'List Price', name: 'listprice', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'qty', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Visibility', name: 'visibility', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active?', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'IDTobeChecked', name: 'id_to_check', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditItems', arguments: '4,6' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteItems', arguments: '' },
                { display: 'Active', name: 'active', enable: true, _event: 'click', trigger: '4', callMethod: 'ActiveItems', arguments: '' },
                { display: 'Deactive', name: 'deactive', enable: true, _event: 'click', trigger: '5', callMethod: 'DeactiveItems', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { Sku: sku, name: Nm, itemType: itemType, attributesetName: attributeSetNm, visibility: visibility, isActive: isAct, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 14: { sorter: false }, 15: { sorter: false } }
        });
    }

    function EditItems(tblID, argus) {
        $('#Todatevalidation').attr('class', '');
        $('#Fromdatevalidation').attr('class', '');
        c = 0;
        //alert(argus);
        //        $.each(data.d, function(i, row) {
        //        });
        switch (tblID) {
        case "gdvItems":
            ContinueForm(true, argus[4], argus[3], argus[0]);
            $("#ItemMgt_itemID").val(argus[0]);
            BindCostVariantsOptions(argus[0]);
            break;
        default:
            break;
        }
    }

    function ClickToDelete(itemId) {
        DeleteItemByID(itemId, storeId, portalId, userName);
    }

    function DeleteItems(tblID, argus) {
        switch (tblID) {
        case "gdvItems":
            DeleteItemByID(argus[0], storeId, portalId, userName);
            break;
        default:
            break;
        }
    }

    function DeleteItemByID(_itemId, _storeId, _portalId, _userName) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(_itemId, _storeId, _portalId, _userName, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item?</p>", properties);
    }

    function ConfirmSingleDelete(item_id, _storeId, _portalId, _userName, event) {
        if (event) {
            DeleteSingleItem(item_id, _storeId, _portalId, _userName);
        }
        return false;
    }

    function DeleteSingleItem(_itemId, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { itemId: parseInt(_itemId), storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteItemByItemID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindItemsGrid(null, null, null, null, null, null);
                $("#gdvItems_form").hide();
                $("#gdvItems_accordin").hide();
                $("#ItemMgt_itemID").val(0);
                $("#gdvItems_grid").show();
            }
        });
    }

    function ActiveItems(tblID, argus) {
        switch (tblID) {
        case "gdvItems":
            ActivateItemID(argus[0], storeId, portalId, userName, true);
            break;
        default:
            break;
        }
    }

    function DeactiveItems(tblID, argus) {
        switch (tblID) {
        case "gdvItems":
            DeActivateItemID(argus[0], storeId, portalId, userName, false);
            break;
        default:
            break;
        }
    }

    function DeActivateItemID(_itemId, _storeId, _portalId, _userName, _isActive) {
        //Pass the selected attribute id and other parameters
        var params = { itemId: parseInt(_itemId), storeId: _storeId, portalId: _portalId, userName: _userName, isActive: _isActive };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateItemIsActiveByItemID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindItemsGrid(null, null, null, null, null, null);
            }
        });
        return false;
    }

    function ActivateItemID(_itemId, _storeId, _portalId, _userName, _isActive) {
        //Pass the selected attribute id and other parameters
        var params = { itemId: parseInt(_itemId), storeId: _storeId, portalId: _portalId, userName: _userName, isActive: _isActive };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateItemIsActiveByItemID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindItemsGrid(null, null, null, null, null, null);
            }
        });
        return false;
    }

    function BindRelatedItemsGrid(selfItemID) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvRelatedItems_pagesize").length > 0) ? $("#gdvRelatedItems_pagesize :selected").text() : 10;

        $("#gdvRelatedItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetRelatedItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'chkRelatedControls', controlclass: 'classClassCheckBox', checkedItems: '14' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'ItemType ID', name: 'itemtype_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Type', name: 'item_type', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AttributeSet ID', name: 'attributeset_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Attribute Set Name', name: 'attribute_set_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'List Price', name: 'listprice', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'qty', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Visibility', name: 'visibility', cssclass: 'cssClassHeadBoolean', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active?', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'IDTobeChecked', name: 'id_to_check', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, selfItemId: selfItemID, userName: userName, culture: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 14: { sorter: false } }
        });
    }

    function BindUpSellItemsGrid(selfItemID) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvUpSellItems_pagesize").length > 0) ? $("#gdvUpSellItems_pagesize :selected").text() : 10;

        $("#gdvUpSellItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetUpSellItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'chkUpSellControls', controlclass: 'classClassCheckBox', checkedItems: '14' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'ItemType ID', name: 'itemtype_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Type', name: 'item_type', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AttributeSet ID', name: 'attributeset_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Attribute Set Name', name: 'attribute_set_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'List Price', name: 'listprice', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'qty', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Visibility', name: 'visibility', cssclass: 'cssClassHeadBoolean', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active?', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'IDTobeChecked', name: 'id_to_check', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, selfItemId: selfItemID, userName: userName, culture: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 14: { sorter: false } }
        });
    }

    function BindCrossSellItemsGrid(selfItemID) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCrossSellItems_pagesize").length > 0) ? $("#gdvCrossSellItems_pagesize :selected").text() : 10;

        $("#gdvCrossSellItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCrossSellItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'chkCrossSellControls', controlclass: 'classClassCheckBox', checkedItems: '14' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'ItemType ID', name: 'itemtype_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Type', name: 'item_type', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AttributeSet ID', name: 'attributeset_id', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Attribute Set Name', name: 'attribute_set_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'List Price', name: 'listprice', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'qty', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Visibility', name: 'visibility', cssclass: 'cssClassHeadBoolean', hide: true, controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active?', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'IDTobeChecked', name: 'id_to_check', cssclass: 'cssClassHeadNumber', hide: true, controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, selfItemId: selfItemID, userName: userName, culture: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 14: { sorter: false } }
        });
    }

    function BindAttributeSet() {
        var params = { storeId: storeId, portalId: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributeSetList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#ddlAttributeSet").get(0).options.length = 0;
                $.each(msg.d, function(index, item) {
                    $("#ddlAttributeSet").get(0).options[$("#ddlAttributeSet").get(0).options.length] = new Option(item.AttributeSetName, item.AttributeSetID);
                    $("#ddlAttributeSetName").get(0).options[$("#ddlAttributeSetName").get(0).options.length] = new Option(item.AttributeSetName, item.AttributeSetID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attribute set</p>');
            }
        });
    }

    function BindItemType() {
        var params = { storeId: storeId, portalId: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributesItemTypeList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $('#ddlItemType').get(0).options.length = 0;
                $.each(msg.d, function(index, item) {
                    $("#ddlItemType").get(0).options[$("#ddlItemType").get(0).options.length] = new Option(item.ItemTypeName, item.ItemTypeID);
                    $("#ddlSearchItemType").get(0).options[$("#ddlSearchItemType").get(0).options.length] = new Option(item.ItemTypeName, item.ItemTypeID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load item type</p>');
            }
        });
    }

    function ClearForm() {
        $('#ddlAttributeSet').val('Default');
        $('#ddlItemType').val('1');
    }

    function ContinueForm(showDeleteBtn, attributeSetId, itemTypeId, itemId) {
        ResetHTMLEditors();
        GetFormFieldList(attributeSetId, itemTypeId, showDeleteBtn, itemId);
    }

    function FillItemAttributes(itemId, item) {
        var attNameNoSpace = "_" + item.AttributeName.replace(new RegExp(" ", "g"), '-');
        var id = item.AttributeID + '_' + item.InputTypeID + '_' + item.ValidationTypeID + '_' + item.IsRequired + '_' + item.GroupID
            + '_' + item.IsIncludeInPriceRule + '_' + item.IsIncludeInPromotions + '_' + item.DisplayOrder;

        var val = '';
        //alert(htmlEditorIDs.length + '::' + editorList.length);
        switch (item.InputTypeID) {
        case 1:
//TextField
            if (item.ValidationTypeID == 3) {
                $("#" + id).val(item.DECIMALValue);
                break;
            } else if (item.ValidationTypeID == 5) {
                $("#" + id).val(item.INTValue);
                break;
            } else {
                //alert(item.NVARCHARValue);
                $("#" + id).val(unescape(item.NVARCHARValue));
                break;
            }
        //$("#" + id).removeClass('hint');
        case 2:
//TextArea
            $("#" + id).val(item.TEXTValue);
                //alert(item.TEXTValue + '::' + editorList.length);
                //$("#" + id).removeClass('hint');
            for (var i = 0; i < editorList.length; i++) {
                if (editorList[i].ID == id + "_editor") {
                    editorList[i].Editor.setData(Encoder.htmlDecode(item.TEXTValue));
                }
            }
            break;
        case 3:
//Date
            $("#" + id).val(formatDate(new Date(item.DATEValue), "yyyy/M/d"));
                //$("#" + id).val(formatDate(new Date(DateDeserialize(item.DATEValue)), "yyyy/M/d"));
                //$("#" + id).removeClass('hint');
            break;
        case 4:
//Boolean
            if (item.BooleanValue.toLowerCase() == "true") {
                $("#" + id).attr("checked", "checked");
            } else if (item.BooleanValue.toLowerCase() == "false") {
                $("#" + id).removeAttr("checked");
            }
            break;
        case 5:
//MultipleSelect
            $("#" + id).val('');
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("#" + id + " option[value=" + vals[i] + "]").attr("selected", "selected");
            });
            break;
        case 6:
//DropDown
            $("#" + id).val('');
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("#" + id + " option[value=" + vals[i] + "]").attr("selected", "selected");
            });
            break;
        case 7:
//Price
            $("#" + id).val(item.DECIMALValue);
                //$("#" + id).removeClass('hint');
            break;
        case 8:
//File
//alert(item.FILEValue);
            var d = $("#" + id).parent();
            var filePath = item.FILEValue;
            var fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
            if (filePath != "") {
                var fileExt = (-1 !== filePath.indexOf('.')) ? filePath.replace( /.*[.]/ , '') : '';
                myregexp = new RegExp("(jpg|jpeg|jpe|gif|bmp|png|ico)", "i");
                if (myregexp.test(fileExt)) {
                    $(d).find('span.response').html('<div class="cssClassLeft"><img src="' + aspxRootPath + filePath + '" class="uploadImage" /></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    //alert($(d).find('span.response').html());
                } else {
                    $(d).find('span.response').html('<div class="cssClassLeft"><a href="' + aspxRootPath + filePath + '" class="uploadFile" target="_blank">' + fileName + '</a></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                }
                $(d).find('input[type="hidden"]').val(filePath);
            }
            break;
        case 9:
//Radio
            if (item.OPTIONValues == "") {
                $("#" + id).removeAttr("checked");
            } else {
                $("#" + id).attr("checked", "checked");
            }
            break;
        case 10:
//RadioButtonList
            $("input[value=" + item.OPTIONValues + "]:radio").attr("checked", "checked");
            break;
        case 11:
//CheckBox
            if (item.OPTIONValues == "") {
                $("#" + id).removeAttr("checked");
            } else {
                $("#" + id).attr("checked", "checked");
            }
            break;
        case 12:
//CheckBoxList
            var inputs = $("input[name=" + id + "]");
            $.each(inputs, function(i) {
                $(this).removeAttr("checked");
            });
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("input[value=" + vals[i] + "]").attr("checked", "checked");
            });
            break;
        case 13:
//Password  
            $("#" + id).val(item.NVARCHARValue);
                //$("#" + id).removeClass('hint');  
            break;
        }
    }

    function DateDeserialize(dateStr) {
        //return eval(dateStr.replace(/\//g, ' '));
        return dateStr.replace(new RegExp("\/", "g"), ' ');
    }

    var FormCount = new Array();

    function GetFormFieldList(attributeSetId, itemTypeId, showDeleteBtn, itemId) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemFormAttributes",
            data: JSON2.stringify({ attributeSetID: attributeSetId, itemTypeID: itemTypeId, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                maxFileSize = '<%= maximumFileSize %>';
                CreateForm(data.d, attributeSetId, itemTypeId, showDeleteBtn, itemId);
                if (itemId > 0) {
                    BindDataInAccordin(itemId, attributeSetId, itemTypeId);
                    BindDataInImageTab(itemId);
                    BindItemCostVariantInGrid(itemId);
                    BindItemQuantityDiscountsByItemID(itemId);
                    if (itemTypeId == 2) {
                        BindDownloadableForm(itemId);
                    }
                }
                if (itemTypeId == 2) {
                    //actual and sample file uploader                    
                    SampleFileUploader(maxFileSize);
                    ActualFileUploader(maxFileSize);
                }
                //Multiple Image Uploader
                ImageUploader(maxFileSize);
                $("#gdvItems_grid").hide();
                $("#gdvItems_form").hide();
                $("#gdvItems_accordin").show();

                $("#txtDownloadTitle").keypress(function(e) {
                    if (e.which == 37 || e.which == 44) {
                        return false;
                    }
                });
                $("#txtMaxDownload").keypress(function(e) {
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                });
                $("#txtDownDisplayOrder").keypress(function(e) {
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                });

                $(".cssClassDisplayOrder").keypress(function(e) {
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                });

                $(".cssClassPriceModifier").keypress(function(e) {
                    if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                });

                $(".cssClassWeightModifier").keypress(function(e) {
                    if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                });
                $(".cssClassSKU").keypress(function(e) {
                    if (e.which == 39 || e.which == 34) {
                        return false;
                    }
                });
            }
        });
    }

    function BindDataInImageTab(itemId) {
        //alert(itemId);
        if (itemId > 0) {
            //  alert("Reached");
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/GetImageContents",
                data: JSON2.stringify({ itemID: itemId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    //alert(msg.d.length);
                    //rowCount = 0;
                    if (msg.d.length > 0) {
                        BindToTable(msg);
                    }
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to load item images</p>');
                }
            });
        }
    }

    function BindToTable(msg) {
        //RemoveHtml();
        //CreateHtml();
        CreateTableHeader();
        //rowCount = msg.d.length;
        $.each(msg.d, function(index, item) {
            // create table elements
            rowCount = index;
            var j = rowCount + 1;
            var newRowImage = '';
            newRowImage += '<tr class="classRowData' + j + '">';
            newRowImage += '<td><img src="' + aspxRootPath + item.ImagePath.replace('uploads', 'uploads/Small') + '" class="uploadImage"/></td>';
            newRowImage += '<td><div class="field required"><input type="textbox" class="cssClassNormalTextBox cssClassImageDiscription" maxlength="256" value="' + item.AlternateText + '"/><span class="iferror"></span></div></td>';
            newRowImage += '<td><div class="field required"><input type="textbox" class="cssClassDisplayOrder" maxlength="3" value="' + item.DisplayOrder + '"/><span class="iferror">Integer Number</span></div></td>';
            newRowImage += '<td><input type="radio" name="itemimage_' + j + '" value="Base Image" class="notTest" /></td>';
            newRowImage += '<td><input type="radio" name="itemimage_' + j + '" value="Small Image" class="notTest" /></td>';
            newRowImage += '<td><input type="radio" name="itemimage_' + j + '"  value="ThumbNail" class="notTest" /></td>';
            newRowImage += '<td><input type="checkbox" class="notTest" id="chkIsActive_' + j + '" /></td>';
            newRowImage += '<td><img class="imgDelete" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png" id="btn' + j + '" onclick="DeleteImage(this)" /></td>';
            newRowImage += '</tr>';
            $("#multipleUpload .classTableWrapper > tbody").append(newRowImage);

            if (item.IsActive) {
                $('#chkIsActive_' + j + '').attr('checked', item.IsActive);
            }

            // alert("Image type is " + item.ImageType);
            if (item.ImageType == "Base Image") {
                $("tbody>tr.classRowData" + j + ">td:eq(3) input:radio").attr("checked", "checked");
            } else if (item.ImageType == "Small Image") {
                $("tbody>tr.classRowData" + j + ">td:eq(4) input:radio").attr("checked", "checked");
            } else if (item.ImageType == "ThumbNail") {
                $("tbody>tr.classRowData" + j + ">td:eq(5) input:radio").attr("checked", "checked");
            }
            //code to delete row
            $("img.imgDelete").click(function() {
                $(this).parent().parent().remove();
                //  DeleteSelectedItemImage(index,);
                $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeEven");
                $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeOdd");
                $("#multipleUpload .classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                $("#multipleUpload .classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
            });
            rowCount++;
        });
        $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeEven");
        $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeOdd");
        $("#multipleUpload .classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
        $("#multipleUpload .classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
        $(".cssClassImageDiscription").keypress(function(e) {
            if (e.which == 35 || e.which == 37) {
                return false;
            }
        });
    }

    function ImageUploader(maxFileSize) {
        var upload = new AjaxUpload($('#fileUpload'), {
            action: aspxItemModulePath + "MultipleFileUploadHandler.aspx",
            name: 'myfile[]',
            multiple: true,
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
                    CreateTableHeader();
                    //          CreateTableElements(response);
                    //$('#btnUpload').show();
                    AddNewImages(res);
                    $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeEven");
                    $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeOdd");
                    $("#multipleUpload .classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $("#multipleUpload .classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                    $(".cssClassDisplayOrder").keypress(function(e) {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    });
                    // var code = (e.keyCode ? e.keyCode : e.which);
                    $(".cssClassDescription").keypress(function(e) {
                        if (e.which == 35 || e.which == 37) {
                            return false;
                        }
                    });

                } else {
                    csscody.error('<h1>Error Message</h1><p>' + res.Message + '</p>');
                    return false;
                }
            }
        });
    }

    function AddNewImages(response) {
        // create table elements
        var j = rowCount + 1;
        var newRowImage = '';

        newRowImage += '<tr class="classRowData' + j + '">';
        newRowImage += '<td><img src="' + aspxRootPath + response.Message + '" class="uploadImage" height="93px" width="125px"/></td>';
        newRowImage += '<td><div class="field required"><input type="textbox" class="cssClassNormalTextBox cssClassDescription" maxlength="256" /><span class="iferror"></span></div></td>';
        newRowImage += '<td><div class="field required"><input type="textbox" class="cssClassDisplayOrder" maxlength="3" /><span class="iferror">Integer Number</span></div></td>';
        newRowImage += '<td><input type="radio" name="itemimage_' + j + '" value="Base Image" class="notTest" /></td>';
        newRowImage += '<td><input type="radio" name="itemimage_' + j + '" value="Small Image" class="notTest" /></td>';
        newRowImage += '<td><input type="radio" name="itemimage_' + j + '"  value="ThumbNail" class="notTest" checked="checked" /></td>';
        newRowImage += '<td><input type="checkbox" class="notTest" checked="checked"/></td>';
        newRowImage += '<td><img class="imgDelete" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"  id="btn' + j + '" onclick="DeleteImage(this)" /></td>';
        newRowImage += '</tr>';
        $("#multipleUpload .classTableWrapper > tbody").append(newRowImage);
        if (j == 1) {
            $('input[value="Base Image"]').attr("checked", "checked");
        }
        rowCount++;
        $(".cssClassDescription").keypress(function(e) {
            if (e.which == 35 || e.which == 37) {
                return false;
            }
        });
    }

    function DeleteImage(onjImg) { //code to delete row
        $(onjImg).parent().parent().remove();
        $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeEven");
        $("#multipleUpload .classTableWrapper > tbody tr").removeClass("cssClassAlternativeOdd");
        $("#multipleUpload .classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
        $("#multipleUpload .classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
    }

    function CreateForm(itemFormFields, attributeSetId, itemTypeId, showDeleteBtn, itemId) {
        var strDynRow = '';
        var attGroup = new Array();
        attGroup.length = 0;
        $.each(itemFormFields, function(index, item) {
            var isGroupExist = false;
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == item.GroupID) {
                    isGroupExist = true;
                    break;
                }
            }
            if (!isGroupExist) {
                attGroup.push({ key: item.GroupID, value: item.GroupName, html: '' });
            }
        });
        FileUploaderIDs = new Array();
        $.each(itemFormFields, function(index, item) {
            strDynRow = createRow(itemId, itemTypeId, item.AttributeID, item.AttributeName, item.InputTypeID, item.InputTypeValues != "" ? eval(item.InputTypeValues) : '', item.DefaultValue, item.ToolTip, item.Length, item.ValidationTypeID, item.IsEnableEditor, item.IsUnique, item.IsRequired, item.GroupID, item.IsIncludeInPriceRule, item.IsIncludeInPromotions, item.DisplayOrder);
            //strDynRow = '<table width="100%" border="0" cellpadding="0" cellspacing="0">' + strDynRow + '</table>';
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == item.GroupID) {
                    attGroup[i].html += strDynRow;
                }
            }
        });
        CreateAccordion(attGroup, attributeSetId, itemTypeId, showDeleteBtn);
        BindTaxManageRule();
        //Functions for static Tree and Grid Binding

        CreateCategoryMultiSelect(itemId);
        BindRelatedItemsGrid(itemId);
        BindUpSellItemsGrid(itemId);
        BindCrossSellItemsGrid(itemId);

        //Hide all blur Error and Success divs
        $('.cssClassRight').hide();
        $('.cssClassError').hide();
        $('.cssClassError').html('');
        BindPopUP();
        BindTierPriceCommand();
    }

    function BindDownloadableForm(itemId) {
        var functionName = 'GetDownloadableItem';
        var params = { storeId: storeId, portalId: portalId, cultureName: cultureName, userName: userName, ItemID: itemId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    FillDownlodableItemForm(msg);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to edit Order Status</p>');
            }
        });
    }

    function FillDownlodableItemForm(response) {
        $.each(response.d, function(index, msg) {
            $("#txtDownloadTitle").val(msg.Title);
            if (msg.MaxDownload == 0) {
                $("#txtMaxDownload").val('');
            } else {
                $("#txtMaxDownload").val(msg.MaxDownload);
            }
            //$('input[name=chkIsSharable]').attr('checked', msg.IsSharable);
            $("#fileSample").attr("title", msg.SampleFile);
            if (msg.SampleFile == '') {
                $("#spanSample").append("X");
            } else
                $("#spanSample").append(msg.SampleFile);
            $("#fileActual").attr("title", msg.ActualFile);
            if (msg.ActualFile == '') {
                $("#spanActual").append("X");
            } else
                $("#spanActual").append(msg.ActualFile);
            if (msg.DisplayOrder == 0) {

                $("#txtDownDisplayOrder").val('');
            } else {
                $("#txtDownDisplayOrder").val(msg.DisplayOrder);
            }
            $("#btnSave").attr("name", msg.DownloadableID);
        });
    }

    function BindPopUP() {
        $('#btnAddExistingOption').bind('click', function() {
            HideAllVariantDivs();
            $("#divExistingVariant").show();
            ShowPopup(this);
        });
        $('#btnAddNewOption').bind('click', function() {
            OnInit();
            ClearVariantForm();
            HideAllVariantDivs();
            $("#divNewVariant").show();
            $("#tabFrontDisplay").show();
            ShowPopup(this);
        });
    }

    function BindTierPriceCommand() {
        $("#btnSaveQuantityDiscount").bind("click", function() {
            SaveItemDiscountQuantity();
        });
    }

    function HideAllVariantDivs() {
        $("#divExistingVariant").hide();
        $("#divNewVariant").hide();
    }

    function BindDataInAccordin(itemId, attributeSetId, itemTypeId) {
        //alert(itemId + '::' + attributeSetId + '::' + itemTypeId);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemFormAttributesValuesByItemID",
            data: JSON2.stringify({ itemID: itemId, attributeSetID: attributeSetId, itemTypeID: itemTypeId, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                //alert(data.d);
                $.each(data.d, function(index, item) {
                    FillItemAttributes(itemId, item);
                    if (index == 0) {
                        $('#ddlTax').val(item.ItemTaxRule);
                    }
                });
            }
        });
    }

    function CreateCategoryMultiSelect(itemId) {
        var functionName = 'GetCategoryList';
        var params = { prefix: '---', isActive: true, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, itemId: itemId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                FillMultiSelect(msg);
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load categories</p>');
            }
        });
    }

    function FillMultiSelect(msg) {
        $('#lstCategories').get(0).options.length = 0;
        $('#lstCategories').attr('multiple', 'multiple');
        $('#lstCategories').attr('size', '5');
        $.each(msg.d, function(index, item) {
            $("#lstCategories").get(0).options[$("#lstCategories").get(0).options.length] = new Option(item.LevelCategoryName, item.CategoryID);
            if (item.IsChecked) {
                $("#lstCategories option[value=" + item.CategoryID + "]").attr("selected", "selected");
            }
        });
    }

    function createRow(itemId, itemTypeId, attID, attName, attType, attTypeValue, attDefVal, attToolTip, attLen, attValType, isEditor, isUnique, isRequired, groupId, isIncludeInPriceRule, isIncludeInPromotions, displayOrder) {
        var retString = '';
        //var attNameNoSpace = attName.replace(new RegExp("_", "g"), '%')--> this gives probelm in loading calender
        //var attNameNoSpace = "_" + attName.replace(new RegExp(" ", "g"), '-');
        //searchval.replace(/ /g, '+')
        //date.replace(/\//g, '*'); -->> replace / -->> *
        retString += '<tr><td><label class="cssClassLabel">' + attName + ': </label></td>';
        switch (attType) {
        case 1:
//TextField
//alert(attID);
            if (attID == 4) {
                $("#hdnSKUTxtBox").val(attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder);
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox cssClassSKU dynFormItem ' + createValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + '" onblur="CheckUniqueness(this.value, ' + itemId + ' )"/>';
                retString += '<span class="cssClassRight"><img class="cssClassSuccessImg" height="13" width="18" alt="Right" src="' + aspxTemplateFolderPath + '/images/right.jpg"></span><b class="cssClassError">Ops! found something error, must be unique with no spaces</b>';
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else if (attID == 5 && itemTypeId == 2) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + '" readonly="readonly"/>';
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else if (attID == 15 && itemTypeId == 2) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + '" readonly="readonly"/>';
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + '"/>';
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            }

            break;
        case 2:
//TextArea
            var editorDiv = '';
            if (isEditor) {
                htmlEditorIDs[htmlEditorIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + "_editor";
                editorDiv = '<div id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_editor"></div>';
            }
            retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><textarea id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" ' + ((isEditor == true) ? ' style="display: none !important;" ' : '') + ' rows="' + attLen + '"  class="cssClassTextArea dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" title="' + attToolTip + GetValidationTypeErrorMessage(attValType) + '">' + attDefVal + '</textarea>' + editorDiv + '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
                //alert(retString);
            break;
        case 4:
//Boolean
            retString += '<td class="cssClassTableRightCol"><div class="cssClassCheckBox ' + (isRequired == true ? "required" : "") + '">';
            if (attDefVal == 1) {
                retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '" checked="checked"/>';
            } else {
                retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/>';
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 3:
//Date
            DatePickerIDs[DatePickerIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder;
            if (attID == 6) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classNewFrom ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 7) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classNewTo ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 22) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classActiveFrom ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 23) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classActiveTo ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 30) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classFeaturedFrom ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 31) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classFeaturedTo ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 33) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classSpecialFrom ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else if (attID == 34) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classSpecialTo ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
            } else {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            }
            break;
        case 5:
//MultipleSelect
            retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '"  title="' + attToolTip + '" size="' + attLen + '" class="cssClassMultiSelect dynFormItem" multiple>';
            if (attTypeValue.length > 0) {
                for (var i = 0; i < attTypeValue.length; i++) {
                    var val = attTypeValue[i];
                    //alert(val.text);
                    //var vals = attTypeValue[i].split(':');
                    if (val.isdefault == 1) {
                        retString += '<option value="' + val.value + '" selected="selected">' + val.text + '</option>';
                    } else {
                        retString += '<option value="' + val.value + '">' + val.text + '</option>';
                    }
                }
            }
            retString += '</select><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 6:
//DropDown
            if (attID == 29) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '"  title="' + attToolTip + '" class="cssClassDropDown dynFormItem FeaturedDropDown">';
            } else if (attID == 32) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '"  title="' + attToolTip + '" class="cssClassDropDown dynFormItem SpecialDropDown">';
            } else {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '"  title="' + attToolTip + '" class="cssClassDropDown dynFormItem">';
            }
            for (var i = 0; i < attTypeValue.length; i++) {
                var val = attTypeValue[i];
                if (val.isdefault == 1) {
                    retString += '<option value="' + val.value + '" selected="selected">' + val.text + '</option>';
                } else {
                    retString += '<option value="' + val.value + '">' + val.text + '</option>';
                }
            }
            retString += '</select><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';

            break;
        case 7:
//Price
            if (attID == 8) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classItemPrice ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" maxlength="' + attLen + '" title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else if (attID == 13) {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem classItemListPrice ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" maxlength="' + attLen + '" title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" maxlength="' + attLen + '" title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            }
            break;
        case 8:
//File
            FileUploaderIDs[FileUploaderIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder;
            retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><div class="' + attDefVal + '" name="Upload/temp" lang="' + attLen + '"><input type="hidden" id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_hidden" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_hidden" value="" class="cssClassBrowse dynFormItem"/>';
            retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="file" class="cssClassBrowse dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" title="' + attToolTip + '" />';
                //retString += '<span id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_span" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="file" class="cssClassBrowse">Browse</span>';
            retString += ' <span class="response"></span></div><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 9:
//Radio
            if (attTypeValue.length > 0) {
                retString += '<td class="cssClassTableRightCol"><div class="cssClassRadioBtn ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">';
                for (var i = 0; i < attTypeValue.length; i++) {
                    var val = attTypeValue[i];
                    if (val.isdefault == 1) {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="radio"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" checked="checked" title="' + attToolTip + '"/><label>' + val.text + '</label>';
                    } else {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="radio"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" title="' + attToolTip + '"/><label>' + val.text + '</label>';
                    }
                }
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            }
            break;
        case 10:
//RadioButtonList
            retString += '<td class="cssClassTableRightCol"><div class="cssClassRadioBtn ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">'
            for (var i = 0; i < attTypeValue.length; i++) {
                var val = attTypeValue[i];
                if (val.isdefault == 1) {
                    retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_' + i + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="radio"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" checked="checked"/><label>' + val.text + '</label>';
                } else {
                    retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_' + i + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="radio"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '"/><label>' + val.text + '</label>';
                }
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 11:
//CheckBox
            retString += '<td class="cssClassTableRightCol"><div class="cssClassCheckBox ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">';
            if (attTypeValue.length > 0) {
                for (var i = 0; i < attTypeValue.length; i++) {
                    var val = attTypeValue[i];
                    if (val.isdefault == 1) {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + val.value + '" checked="checked"/><label>' + val.text + '</label>';
                    } else {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" value="' + val.value + '"/><label>' + val.text + '</label>';
                    }
                }
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 12:
//CheckBoxList
            retString += '<td class="cssClassTableRightCol"><div class="cssClassCheckBox ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">';
            if (attTypeValue.length > 0) {
                for (var i = 0; i < attTypeValue.length; i++) {
                    var val = attTypeValue[i];
                    if (val.isdefault == 1) {
                        //var vals = attTypeValue[i].split(':');
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_' + i + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '" checked="checked"/><label>' + val.text + '</label>';
                    } else {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '_' + i + '" value="' + val.value + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="checkbox"  class="text dynFormItem ' + createValidation(attID, attType, attValType, isUnique, isRequired) + '"/><label>' + val.text + '</label>';
                    }
                }
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 13:
//Password
            retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + createValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + ' Password" value="' + attDefVal + '" title="' + attToolTip + '"/>'
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        default:
            break;
        }
        retString += '</tr>';
        return retString;
    }


    function SampleFileUploader(maxFileSize) {
        var upload = new AjaxUpload($('#fileSample'), {
            action: aspxItemModulePath + "MultipleFileUploadHandler.aspx",
            name: 'myfile[]',
            multiple: true,
            data: { },
            autoSubmit: true,
            responseType: 'json',
            onChange: function(file, ext) {
                //alert('changed');
            },
            onSubmit: function(file, ext) {
                if (ext != "exe") {
                    this.setData({
                        'MaxFileSize': maxFileSize
                    });
                } else {
                    csscody.alert('<h1>Alert Message</h1><p>Not a valid File!</p>');
                    return false;
                }
            },
            onComplete: function(file, response) {
                var res = eval(response);
                if (res.Message != null) {
                    // alert(res.Message);
                    showSampleLoadedFile(res);
                    return false;
                } else {
                    csscody.error('<h1>Error Message</h1><p>Can\'t upload the file!</p>');
                    return false;
                }
            }
        });
    }

    function showSampleLoadedFile(response) {
        //alert(response.Message);
        $("#spanSample").html('LoadedFile: ');
        $("#spanSample").append(response.Message);
        $("#fileSample").attr('name', response.Message);

    }

    function showActualLoadedFile(response) {
        // alert(response.Message);
        $("#spanActual").html('LoadedFile: ');
        $("#spanActual").append(response.Message);
        $("#fileActual").attr('name', response.Message);
    }

    function ActualFileUploader(maxFileSize) {
        var upload = new AjaxUpload($('#fileActual'), {
            action: aspxItemModulePath + "MultipleFileUploadHandler.aspx",
            name: 'myfile[]',
            multiple: true,
            data: { },
            autoSubmit: true,
            responseType: 'json',
            onChange: function(file, ext) {
                //alert('changed');
            },
            onSubmit: function(file, ext) {
                if (ext != "exe") {
                    this.setData({
                        'MaxFileSize': maxFileSize
                    });
                } else {
                    csscody.alert('<h1>Alert Message</h1><p>Not a valid File!</p>');
                    return false;
                }
            },
            onComplete: function(file, response) {
                var res = eval(response);
                if (res.Message != null) {
                    //   alert(res.Message);
                    showActualLoadedFile(res);
                    return false;
                } else {
                    csscody.error('<h1>Error Message</h1><p>Can\'t upload the image!</p>');
                    return false;
                }
            }
        });
    }

//    function FileUpload(FileUploaderID) {
//        var previousFile = $(FileUploaderID).attr("title");
//        var downlodablefileuploaderID = $(FileUploaderID).attr('id');
//        alert(downlodablefileuploaderID);

    //        var upload = new AjaxUpload(String(downlodablefileuploaderID), {
    //            action: aspxItemModulePath + "MultipleFileUploadHandler.aspx",
    //            name: 'myfile[]',
    //          //  multiple: false,
    //          //  data: {},
    //            autoSubmit: true,
    //           // responseType: 'json',
    //           // onChange: function(file, ext) {
    //                //alert('changed');
    //           // },
    //            onSubmit: function(file, ext) {
    //                if (ext != "exe") {
    //                    alert("load");
    //                    //                    if (ext && /^(jpg|jpeg|jpe|gif|bmp|png|ico)$/i.test(ext)) {
    //                    //                    } else {
    //                    //                        csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
    //                    //                        return false;
    //                    //                    }
    //                }
    //                else {
    //                    csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
    //                    return false;
    //                }
    //            },
    //            onComplete: function(file, response) {
    //                var res = eval(response);
    //                if (res.Message != null) {
    //                   alert(res.Message);
    //                }
    //                else {
    //                    csscody.error('<h1>Error Message</h1><p>Can\'t upload the file!</p>');
    //                }
    //            }
    //        });

    //    }

    function CreateAccordion(attGroup, attributeSetId, itemTypeId, showDeleteBtn) {
        //alert($("#dynItemForm").html());
        if (FormCount) {
            FormCount = new Array();
        }
        var FormID = "form_" + (FormCount.length * 10 + Math.floor(Math.random() * 10));
        FormCount[FormCount.length] = FormID;
        var dynHTML = '';
        var tabs = '';

        for (var i = 0; i < attGroup.length; i++) {
            tabs += '<div class="accordionHeading"><h3><a href="#" name="' + attGroup[i].key + '">' + attGroup[i].value + '</a></h3></div>';
            tabs += '<div><table width="100%" border="0" cellpadding="0" cellspacing="0">' + attGroup[i].html + '</table></div>';
        }
        //Add Static sections here
        //In Add New:: need to add some static accordin tabs :: Image, Inventory, Categories, Related Products, Up-sells, Cross-sells, Custom Options
        //In edit:: Product Reviews, Product Tags, Customers Tagged Product
        if (itemTypeId == 2) {
            tabs += '<div class="accordionHeading"><h3><a href="#">Download Informations</a></h3></div>';
            tabs += '<div id="divDownloadInfo">';
            tabs += '<table class="cssClassFormWrapper" width="100%" border="0" cellpadding="o" cellspacing="0">';
            tabs += '<tbody>';
            tabs += '<tr><td><span class="cssClassLabel">Title: </span></td><td class="cssClassTableRightCol"><div class="field required"><input type="textbox" id="txtDownloadTitle" class="cssClassNormalTextBox" maxlength="256"/><span class="iferror"></span></div></td></tr>';
            tabs += '<tr><td><span class="cssClassLabel">Maximum Download: </span></td><td class="cssClassTableRightCol"><div class="field required"><input type="textbox" id="txtMaxDownload" class="cssClassNormalTextBox" maxlength="3"/><span class="iferror">Integer Number</span></div></td></tr>';
            //tabs += '<tr><td><span class="cssClassLabel">Is Sharable? </span></td><td class="cssClassTableRightCol"><input type="checkbox" name="chkIsSharable" class="cssClassCheckBox notTest" /></td></tr>';
            tabs += '<tr><td><span class="cssClassLabel">Sample File: </span></td><td class="cssClassTableRightCol"><input id="fileSample" type="file" class="cssClassBrowse notTest" /><span id="spanSample" class="cssClassLabel">Previous: </span></td></tr>';
            tabs += '<tr><td><span class="cssClassLabel">Actual File: </span></td><td class="cssClassTableRightCol"><input id="fileActual" type="file" class="cssClassBrowse notTest" /><span id="spanActual" class="cssClassLabel">Previous: </span></td></tr>';
            tabs += '<tr><td><span class="cssClassLabel">Display Order: </span></td><td class="cssClassTableRightCol"><div class="field required"><input type="textbox" id="txtDownDisplayOrder" class="cssClassNormalTextBox" maxlength="3"/><span class="iferror">Integer Number</span></div></td></tr>';
            tabs += '</tbody>';
            tabs += '</table></div>';
        }
        tabs += '<div class="accordionHeading"><h3><a href="#">Tax</a></h3></div><div id="divTax"><span class="cssClassLabel">Tax Rule ID: </span><select id="ddlTax" class="cssClassDropDown" /></div>';
        tabs += '<div class="accordionHeading"><h3><a href="#">Images</a></h3></div><div id="multipleUpload"><div id="divUploader"><input id="fileUpload" type="file" class="cssClassBrowse" /></div>';
        tabs += '<div id="divTableWrapper" class="cssClassGridWrapperContent"><table class="classTableWrapper" width="100%" border="0" cellpadding="o" cellspacing="0"><thead></thead><tbody></tbody></table></div></div>';
        tabs += '<div class="accordionHeading"><h3><a href="#">Categories</a></h3></div><div id="tblCategoryTree" width="100%" border="0" cellpadding="0" cellspacing="0"><select id="lstCategories" class="cssClassMultiSelect"></select><span id="spanNoCat" class="cssClassLabel"></span></div>';
        if (showDeleteBtn) {
            tabs += '<div class="accordionHeading"><h3><a href="#">Cost Variant Options</a></h3></div><div class="cssClassGridWrapper"><table id="gdvItemCostVariantGrid" width="100%" border="0" cellpadding="0" cellspacing="0"></table>';
            tabs += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnAddExistingOption" rel="popuprel" ><span><span>Add Existing Option</span></span></button></p><P><button type="button" id="btnAddNewOption" rel="popuprel"><span><span>Add New Option</span></span></button></p></div></div>';

            //Item Quantity Discounts
            tabs += '<div class="accordionHeading"><h3><a href="#">Item Quantity Discounts (Tier Price Options)</a></h3></div><div class="cssClassFormWrapper"><table width="100%" cellspacing="0" cellpadding="0" id="tblQuantityDiscount"><thead><tr class="cssClassHeading"><td>Quantity More Than:</td><td>Unit Price($):</td><td>User In Role:</td><td>&nbsp;</td></tr></thead><tbody></tbody></table>';
            tabs += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnSaveQuantityDiscount" ><span><span>Save</span></span></button></p></div></div>';
        }

        tabs += '<div class="accordionHeading"><h3><a href="#">Related Items</a></h3></div><div class="cssClassGridWrapper"><table id="gdvRelatedItems" width="100%" border="0" cellpadding="0" cellspacing="0"></table></div>';
        tabs += '<div class="accordionHeading"><h3><a href="#">Up-sells</a></h3></div><div class="cssClassGridWrapper"><table id="gdvUpSellItems" width="100%" border="0" cellpadding="0" cellspacing="0"></table></div>';
        tabs += '<div class="accordionHeading"><h3><a href="#">Cross-sells</a></h3></div><div class="cssClassGridWrapper"><table id="gdvCrossSellItems" width="100%" border="0" cellpadding="0" cellspacing="0"></table></div>';
        dynHTML += tabs;
        var frmIDQuoted = "'" + FormID + "'";
        //Create buttons
        var buttons = '<div class="cssClassButtonWrapper"><p><button type="button" id="btnReturn" onclick="BackToItemGrid()"><span><span>Back</span></span></button></p>';
        if (!showDeleteBtn) {
            buttons += '<p><button type="reset" id="btnResetForm" onclick="ClearAttributeForm()"><span><span>Reset</span></span> </button></p>';
        } else {
            buttons += '<p><button type="button" id="btnDelete" class="delbutton" onclick="ClickToDelete(' + $("#ItemMgt_itemID").val() + ')"><span><span>Delete Item</span></span> </button></p>';
        }
        buttons += '<p><button type="button" id="saveForm"  onclick="SubmitForm(' + frmIDQuoted + ',' + attributeSetId + ',' + itemTypeId + ',' + $("#ItemMgt_itemID").val() + ')" ><span><span>Save Item</span></span></button></p>';
        buttons += '<div class="cssClassClear"></div></div>'
        $("#dynItemForm").html('<div id="' + FormID + '" class="cssClassFormWrapper"><div id="accordion" class="cssClassAccordion">' + dynHTML + '</div>' + buttons + '</div>');
        EnableAccordion();
        EnableFormValidation(FormID);
        EnableDatePickers();
        EnableFileUploaders();
        EnableHTMLEditors();
        // activatedatetimevalidation();

    }

    function EnableAccordion() {
        //set icon and autoheight and active index
        $("#accordion").accordion({
            autoHeight: false,
            icons: { 'header': 'ui-icon-triangle-1-e', 'headerSelected': 'ui-icon-triangle-1-s' },
            //animated: 'bounceslide',
            active: 0
        });
        //alert($("#dynItemForm").html());
    }

    function EnableFormValidation(frmID) {
        mustCheck = true;
        $("#" + frmID + " ." + classprefix + "Cancel").click(function(event) {
            mustCheck = false;
        });
        var fe = $("#" + frmID + " input");
        for (var j = 0; j < fe.length; j++) {
            if ((fe[j]).title.indexOf("**") == 0) {
                if ((fe[j]).value == "" || (fe[j]).value == titleHint) {
                    var titleHint = (fe[j]).title.substring(2);
                    (fe[j]).value = titleHint;
                }
            } else if (((fe[j]).type == "text" || (fe[j]).type == "password" || (fe[j]).type == "textarea") && (fe[j]).title.indexOf("*") == 0) {
                addHint((fe[j]));
                $(fe[j]).blur(function(event) { addHint(this); });
                $(fe[j]).focus(function(event) { removeHint(this); });
            }
        }
    }

    function EnableDatePickers() {
        for (var i = 0; i < DatePickerIDs.length; i++) {
            //$(selector).datepicker($.datepicker.regional['fr']);
            $("#" + DatePickerIDs[i]).datepicker({ dateFormat: 'yy/mm/dd' });
        }
    }

    function HTMLEditor(editorID, editorObject) {
        this.ID = editorID;
        this.Editor = editorObject;
    }

    function EnableHTMLEditors() {
        for (var i = 0; i < htmlEditorIDs.length; i++) {
            config = { skin: "v2" };
            var html = "Initially Text if necessary";

            var editorID = htmlEditorIDs[i];
            //alert(editorID + '::' + htmlEditorIDs.length + '::' + editorList.length);
            var instance = CKEDITOR.instances[editorID];
            if (instance) {
                CKEDITOR.remove(instance);
                //delete instance;
            }
            var editor = CKEDITOR.replace(editorID, config, html);

            var obj = new HTMLEditor(editorID, editor);
            //obj.enterMode == CKEDITOR.ENTER_BR //CKEDITOR.ENTER_DIV CKEDITOR.ENTER_P
            editorList[editorList.length] = obj;
        }
    }

    function ResetHTMLEditors() {
        htmlEditorIDs.length = 0;
        editorList.length = 0;
    }

    function EnableFileUploaders() {
        for (var i = 0; i < FileUploaderIDs.length; i++) {
            CreateFileUploader(String(FileUploaderIDs[i]));
        }
    }

    function GetValidationTypeClasses(attValType, isUnique, isRequired) {
        var returnClass = ''
        if (isRequired == true) {
            returnClass = "required";
        }
        return returnClass;
    }

    function GetValidationTypeErrorMessage(attValType) {
        var retString = ''
        switch (attValType) {
        case 1:
//AlphabetsOnly
            retString = 'Alphabets Only';
            break;
        case 2:
//AlphaNumeric
            retString = 'AlphaNumeric';
            break;
        case 3:
//DecimalNumber
            retString = 'Decimal Number';
            break;
        case 4:
//Email
            retString = 'Email Address';
            break;
        case 5:
//IntegerNumber
            retString = 'Integer Number';
            break;
        case 6:
//Price
            retString = 'Price';
            break;
        case 7:
//WebURL
            retString = 'Web URL';
            break;
        }
        return retString;
    }

    function CheckUniqueness(sku, itemId) {
        var errors = '';
        sku = $.trim(sku);
        if (!sku) {
            errors += ' - Please enter Item SKU Code';
            $('.cssClassRight').hide();
            $('.cssClassError').show();
            $('.cssClassError').html(' - Please enter SKU code.<br/>');
        }
            //check uniqueness
        else if (!IsUnique(sku, itemId)) {
            errors += ' - Please enter unique Item SKU Code! "' + sku.trim() + '" already exists.<br/>';
            $('.cssClassRight').hide();
            $('.cssClassError').show();
            $('.cssClassError').html(' - Please enter unique SKU code! "' + sku.trim() + '" already exists.<br/>');
            $(".cssClassError").parent('div').addClass("diverror");
            $('.cssClassError').prevAll("input:first").addClass("error");
        }

        if (errors) {
            csscody.alert('<h1>Information Alert</h1><p>' + errors + '</p>');
            return false;
        } else {
            $('.cssClassRight').show();
            $('.cssClassError').html('');
            $('.cssClassError').hide();
            $(".cssClassError").parent('div').removeClass("diverror");
            $('.cssClassError').prevAll("input:first").removeClass("error");
            return true;
        }
    }

    function IsUnique(sku, itemId) {
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckUniqueItemSKUCode",
            data: JSON2.stringify({ SKU: sku, itemId: itemId, storeId: storeId, portalId: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isUnique = data.d;
            }
        });
        return isUnique;
    }

    function CheckUnique(id) {
        var val = $('#' + id).val();
        if (val) {
            var arrID = id.split('_');
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/" + 'IsUnique',
                data: JSON2.stringify({ storeID: storeId, portalID: portalId, ItemID: 1, AttributeID: arrID[0], AttributeType: arrID[1], AttributeValue: val }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(data) {
                    return data.d;
                }
            });
        } else {
            return false;
        }
    }

    function createValidation(id, attType, attValType, isUnique, isRequired) {
        var retString = '';
        var validationClass = '';

        switch (attValType) {
        case 1:
//AlphabetsOnly
            validationClass += 'verifyAlphabetsOnly" ';
            break;
        case 2:
//AlphaNumeric
            validationClass += 'verifyAlphaNumeric" ';
            break;
        case 3:
//DecimalNumber
            validationClass += 'verifyDecimal" ';
            break;
        case 4:
//Email
            validationClass += 'verifyEmail';
            break;
        case 5:
//IntegerNumber
            validationClass += 'verifyInteger';
            break;
        case 6:
//Price
            validationClass += 'verifyPrice';
            break;
        case 7:
// URL
            validationClass += 'verifyUrl';
            break;
        }

        retString = validationClass;
        return retString;
    }

    function BackToItemGrid() {
        ResetHTMLEditors();
        var n = $("#btnDelete").length;
        if (n != 0) {
            $("#gdvItems_grid").show();
            $("#gdvItems_form").hide();
            $("#gdvItems_accordin").hide();
        } else {
            $("#gdvItems_form").show();
            $("#gdvItems_grid").hide();
            $("#gdvItems_accordin").hide();
        }
    }

    function ValidateExtraField(cssClassFirst, cssClassSecond, validateType, ErrorMessage) {
        var valFirst = $('.' + cssClassFirst + '').val();
        var valSecond = $('.' + cssClassSecond + '').val();
        var prevFirstDiv = $('.' + cssClassFirst + '').parent('div');
        var prevSecondDiv = $('.' + cssClassSecond + '').parent('div');
        if (prevFirstDiv.length > 0 && prevSecondDiv.length > 0) {
            switch (validateType) {
            case "price":
                valFirst = parseFloat(valFirst);
                valSecond = parseFloat(valSecond);
                break;
            case "date":
                valFirst = Date.parse(valFirst);
                valSecond = Date.parse(valSecond);
                break;
            default:
                valFirst = eval(valFirst);
                valSecond = eval(valSecond);
            }

            if (valSecond >= valFirst) {
                $('.' + cssClassFirst + '').removeClass('error');
                $('.' + cssClassSecond + '').removeClass('error');
                prevFirstDiv.removeClass('diverror');
                prevSecondDiv.removeClass('diverror');
                return true;
            } else {
                $('.' + cssClassSecond + '').next('span').html(ErrorMessage);
                $('.' + cssClassFirst + '').addClass('error');
                prevFirstDiv.addClass('diverror');
                $('.' + cssClassSecond + '').addClass('error');
                prevSecondDiv.addClass('diverror');
                return false;
            }
        } else {
            prevFirstDiv.removeClass('diverror');
            prevSecondDiv.removeClass('diverror');
            return true;
        }
    }

    function SubmitForm(frmID, attributeSetId, itemTypeId, itemId) {
        var frm = $("#" + frmID);
        for (var i = 0; i < editorList.length; i++) {
            var id = String(editorList[i].ID);
            var textArea = $("#" + id.replace("_editor", ""));
            textArea.val(Encoder.htmlEncode(editorList[i].Editor.getData()));
        }

        // Prevent submit if validation fails
        var itemSKUTxtBoxID = $("#hdnSKUTxtBox").val();
        var itemSKU = $("#" + itemSKUTxtBoxID).val();
        var validPrice = false;
        var validNewDate = false;
        var validActiveDate = false;
        var validFeaturedDate = false;
        var validSpecialDate = false;

        validPrice = ValidateExtraField("classItemPrice", "classItemListPrice", "price", "List Price should be equal or greater than Price!");
        validNewDate = ValidateExtraField("classNewFrom", "classNewTo", "date", "To date must be higher date than From date!");
        validActiveDate = ValidateExtraField("classActiveFrom", "classActiveTo", "date", "Active To date must be higher date than Active From date!");

        if ($('.FeaturedDropDown').val() == 7) {
            validFeaturedDate = ValidateExtraField("classFeaturedFrom", "classFeaturedTo", "date", "Featured To date must be higher date than Featured From date!");
        } else {
            $('.classFeaturedFrom').removeClass('error');
            $('.classFeaturedTo').removeClass('error');
            $('.classFeaturedFrom').parent('div').removeClass('diverror');
            $('.classFeaturedTo').parent('div').removeClass('diverror');
            validFeaturedDate = true;
        }

        if ($('.SpecialDropDown').val() == 9) {
            validSpecialDate = ValidateExtraField("classSpecialFrom", "classSpecialTo", "date", "Special To date must be higher date than Special From date!");
        } else {
            $('.classSpecialFrom').removeClass('error');
            $('.classSpecialTo').removeClass('error');
            $('.classSpecialFrom').parent('div').removeClass('diverror');
            $('.classSpecialFrom').parent('div').removeClass('diverror');
            validSpecialDate = true;
        }

        if (checkForm(frm) && CheckUniqueness(itemSKU, itemId) && validPrice && validNewDate && validActiveDate && validFeaturedDate && validSpecialDate) {
            SaveItem("#" + frmID, attributeSetId, itemTypeId, itemId);
        } else {
            var errorAccr = $("#accordion").find('.diverror:first').parents('div').prev('.accordionHeading').html();
            //alert($("#accordion").find('.diverror').parents('table').prev('.accordionHeading').html());
            //alert(errorAccr);
            var accrHeading = $("#accordion").find('.accordionHeading');

            //alert(accrHeading.length);
            $.each(accrHeading, function(i, item) {
                //alert($(item).html() + '::' + errorAccr);
                if ($(item).html() == errorAccr) {
                    $("#accordion").accordion("option", "active", i);
                }
            });
            return false;
        }
    }

    function ClearAttributeForm() {
        var inputs = $("#accordion").find('INPUT, SELECT, TEXTAREA');
        $.each(inputs, function(i, item) {
            rmErrorClass(item);
            $(this).val('');
        });

        $('.cssClassRight').hide();
        $('.cssClassError').hide();
        $('.cssClassError').html('');
        ResetImageTab();
        return false;
    }

    function ResetImageTab() {
        $("#divTableWrapper>table>thead").html('');
        $("#divTableWrapper>table>tbody").html('');
    }

    function SaveItem(formID, attributeSetId, itemTypeId, itemId) {
        //        var arForm = { storeID: storeId, portalID: portalId, userName: userName, culture: cultureName, isActive: 1, isModified: 0, itemID: itemID, itemTypeID: itemTypeId, attributeSetID: attributeSetId, updateFlag: 0, formVars: SerializeForm(formID)};
        //        arForm = JSON2.stringify(arForm);

        //Image tab save here
        var sourceFileCollection = '';
        var filepath = '';
        var contents = '';
        var counter = 0;
        //no need to validate image 
        //        if ($("#multipleUpload .classTableWrapper > tbody >tr ").length >= 1) {

        //            if ($("#multipleUpload .classTableWrapper > tbody >tr ").length == 1) {
        //                $("#multipleUpload .classTableWrapper > tbody >tr:first td:eq(3) input:radio ").attr('checked', true);
        //            }
        //        }

        //        else {
        //            csscody.alert('<h1>Information Alert</h1><p>You need to upload at least one Base Image first!</p>');
        //            return false;
        //        }

        $("#multipleUpload .classTableWrapper > tbody >tr").each(function() {
            // filepath = $(this).find(" td:first >img").attr("src").replace(aspxRootPath, "");
            if (aspxRootPath != "/") {
                filepath = $(this).find(" td:first >img").attr("src").split(aspxRootPath)[1];
            } else {
                filepath = $(this).find(" td:first >img").attr("src").replace('/', '')
            }
            //var replacedpath = filepath.replace("../", "");
            // alert("File after replacing is " + replacedpath);
            filepath = filepath.replace("/Small", "");
            filepath = filepath.replace("/Medium", "");
            filepath = filepath.replace("/Large", "");
            var path_array = filepath.split('/');
            var sizeofArray = path_array.length;

            var fileName = path_array[sizeofArray - 1];

            sourceFileCollection += fileName + '%';
            contents += filepath + "%"; //aspxRootPath + '/Modules/ASPXCommerce/ASPXItemsManagement/uploads/' + fileName + ','; // +$(this).find(" td:eq(3) input:radio:checked").attr("value");
            //DestFilePathCol += aspxRootPath + '/Modules/ASPXCommerce/ASPXItemsManagement/uploads/' + fileName + ',';
            // alert(contents);
            if ($(this).find(" td:eq(6) input:checkbox").is(":checked")) {
                contents += 1;
                contents += '%';
            } else {
                contents += 0;
                contents += '%';
            }
            if ($(this).find(" td:eq(3) input:radio").is(":checked")) {
                counter += 1;
                contents += $(this).find(" td:eq(3) input:radio:checked").attr("value");
                contents += '%';
            } else if ($(this).find(" td:eq(4) input:radio").is(":checked")) {
                contents += $(this).find(" td:eq(4) input:radio:checked").attr("value");
                contents += '%';
            } else if ($(this).find(" td:eq(5) input:radio").is(":checked")) {
                contents += $(this).find(" td:eq(5) input:radio:checked").attr("value");
                contents += '%';
            } else {
                contents += "None";
                contents += '%';
            }
            if ($(this).find(" td:eq(1) input").attr("value") != null) {
                contents += $(this).find(" td:eq(1) input").attr("value");
                contents += '%';
            } else {
                contents += " ";
                contents += '%';
            }
            if ($(this).find(" td:eq(2) input").attr("value") != null) {
                contents += $(this).find(" td:eq(2) input").attr("value");
            }
            contents += '#';
        });

        //alert(sourceFileCollection + '::' + DestFilePathCol + '::' + contents + '::' + counter);

        //RemoveHtml();
        //CreateHtml();
        //CreateTableHeader();
        //BindData()
        if (counter <= 1) {

            var relatedItems_ids = '';
            $("#gdvRelatedItems .chkRelatedControls").each(function(i) {
                if ($(this).attr("checked")) {
                    relatedItems_ids += $(this).val() + ',';
                }
            });

            var upSellItems_ids = '';
            $("#gdvUpSellItems .chkUpSellControls").each(function(i) {
                if ($(this).attr("checked")) {
                    upSellItems_ids += $(this).val() + ',';
                }
            });

            var crossSellItems_ids = '';
            $("#gdvCrossSellItems .chkCrossSellControls").each(function(i) {
                if ($(this).attr("checked")) {
                    crossSellItems_ids += $(this).val() + ',';
                }
            });
            if ($('#ddlTax').val() > 0) {
                var taxRuleId = $('#ddlTax').val();
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Tax Rule first!</p>');
                return false;
            }

            var categoriesSelectedID = "";
            $("#lstCategories").each(function() {
                if ($("#lstCategories :selected").length != 0) {

                    categoriesSelected = true;
                    $("#lstCategories option:selected").each(function(i) {
                        categoriesSelectedID += $(this).val() + ',';
                    });
                    //save downloadable items
                    arForm = '{"storeID":"' + storeId + '","portalID":"' + portalId + '","userName":"' + userName + '","culture":"' + cultureName + '","taxRuleID":"' + taxRuleId + '","itemID":"' + itemId + '","itemTypeID":"' + itemTypeId + '","attributeSetID":"' + attributeSetId + '","categoriesIds":"' + categoriesSelectedID + '","relatedItemsIds":"' + relatedItems_ids + '","upSellItemsIds":"' + upSellItems_ids + '","crossSellItemsIds":"' + crossSellItems_ids + '","downloadItemsValue":"' + GetDownloadableFormData(itemTypeId) + '","sourceFileCol":"' + sourceFileCollection + '","dataCollection":"' + contents + '","formVars":' + SerializeForm(formID) + '}';
                    //alert(arForm);           
                    var url = aspxservicePath + "ASPXCommerceWebService.asmx/SaveItemAndAttributes";
                    PostData(arForm, url, "Post", successFn, errorFn);
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Category first where this item belongs!</p>');
                    return false;
                }
            });
        } else {
            csscody.alert('<h1>Information Alert</h1><p>You need to select only one base image for an item!</p>');
            return false;
        }
    }

    function GetDownloadableFormData(itemTypeId) {
        var downloadabelItem = "";
        if (itemTypeId == 2) {
            var titleHead = $("#txtDownloadTitle").val();
            var maxDownload = $("#txtMaxDownload").val();
            var isSharable = false; //$('input[name=chkIsSharable]').attr('checked');
            var fileSamplePrevious = $("#fileSample").attr("title"); //$("#fileSample").val();
            var fileSampleNewPath = $("#fileSample").attr('name');
            var fileActualPrevious = $("#fileActual").attr("title"); //$("#fileActual").val();
            var fileActualNewPath = $("#fileActual").attr('name');
            var displayorder = $("#txtDownDisplayOrder").val();

            downloadabelItem = '' + titleHead + '%' + maxDownload + '%' + isSharable + '%' + fileSamplePrevious + '%' + fileSampleNewPath + '%' + fileActualPrevious + '%' + fileActualNewPath + '%' + displayorder + '';
        }
        return downloadabelItem;
    }

    function RemoveHtml() {
        $('#multipleUpload div.cssClassGridWrapperContent>table>tbody').html('');
        // $('table.classTableWrapper').remove();
        //  alert("Given value is " + $("#multipleUpload .classTableWrapper > tbody >trtd:first >img").attr("src"));
    }

    function CreateHtml() {
        $('#multipleUpload div.cssClassGridWrapperContent').html("<table class=\"classTableWrapper\" width=\"100%\" border=\"0\" cellpadding=\"o\" cellspacing=\"0\"> <thead></thead><tbody></tbody></table>");
    }

    function CreateTableHeader() {
        if ($("#multipleUpload .classTableWrapper > thead>tr").val() == null) {
            $("<tr class=\"cssClassHeading\"><td>Image</td><td>Description</td><td>Display Order</td><td>Base Image</td><td>Small Image</td><td>Thumbnail</td><td>IsActive</td><td>Remove</td></tr>").appendTo("#multipleUpload .classTableWrapper > thead");
            //$("<tr><input type=\"button\" value=\"Upload\" id=\"btnUpload\"/></tr>").appendTo("#multipleUpload .classTableWrapper > tfoot");
        }
    }

    function PostData(data, url, method, successFn, errorFn) {
        $.ajax({
            url: url,
            type: method,
            contentType: "application/json",
            data: data,
            dataType: "json",
            success: successFn,
            error: errorFn
        });
    }

    function successFn(result) {
        //        var jEl = $("#divMessage");
        //        jEl.html(result.d).fadeIn(1000);
        //        setTimeout(function() { jEl.fadeOut(1000) }, 5000);    
        $("#dynItemForm").html('');
        $("#gdvItems_form").hide();
        $("#gdvItems_accordin").hide();
        //alert(perpage);
        BindItemsGrid(null, null, null, null, null, null);
        $("#gdvItems_grid").show();

        RemoveHtml();
        //CreateHtml();
        //CreateTableHeader();
    }

    function errorFn(xhr, status) {
        var err = null;
        if (xhr.readyState == 4) {
            var res = xhr.responseText;
            if (res && res.charAt(0) == '{' && status != "parsererror")
                var err = JSON.parse(res);
            if (!err) {
                if (xhr.status && xhr.status != 200)
                    err = new CallbackException(xhr.status + " " + xhr.statusText);
                else {
                    if (status == "parsererror")
                        status = "Unable to parse JSON response.";
                    else if (status == "timeout")
                        status = "Request timed out.";
                    else if (status == "error")
                        status = "Unknown error";
                    err = new CallbackException("Callback Error: " + status);
                }
                err.detail = res;
            }
        }
        if (!err)
            err = new CallbackException("Callback Error: " + status);

        //        if (errorHandler)
        //            errorHandler(err, _I, xhr);
        csscody.error('<h1>Error Message</h1><p>Failed to save item. ' + err + '</p>');
    }

    function SerializeForm(formID) {
        var jsonStr = '';
        var frmValues = new Array();
        radioGroups = new Array();
        checkboxGroups = new Array();
        selectGroups = new Array();
        inputs = $(formID).find('INPUT, SELECT, TEXTAREA');
        $.each(inputs, function(i, item) {
            input = $(item);
            if (input.hasClass("dynFormItem")) {
                var found = false;
                switch (input.attr('type')) {
                case 'text':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    break;
                case 'select-multiple':
                    for (var i = 0; i < selectGroups.length; i++) {
                        if (selectGroups[i] == input.attr('name')) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        selectGroups[selectGroups.length] = input.attr('name');
                    }
                    break;
                case 'select-one':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + input.get(0)[input.attr('selectedIndex')].value + '"},';
                    break;
                case 'checkbox':
                    var ids = String(input.attr('name')).split("_");
                    if (ids[1] == 4) {
                        jsonStr += '{"name":"' + input.attr('name') + '","value":"' + input.is(':checked') + '"},';
                    } else {
                        for (var i = 0; i <= checkboxGroups.length; i++) {
                            if (checkboxGroups[i] == input.attr('name')) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            checkboxGroups[checkboxGroups.length] = input.attr('name');
                        }
                    }
                    break;
                case 'radio':
                    for (var i = 0; i < radioGroups.length; i++) {
                        if (radioGroups[i] == input.attr('name')) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        radioGroups[radioGroups.length] = input.attr('name');
                    }
                    break;
                case 'file':
                    var d = input.parent();
                    var img = $(d).find('span.response img.uploadImage');
                    if (img.length > 0) {
                        var imgToUpload = "";
                        if (img.attr("src") != undefined) {
                            imgToUpload = img.attr("src");
                        }
                        jsonStr += '{"name":"' + input.attr('name') + '","value":"' + imgToUpload.replace(aspxRootPath, "") + '"},';
                    } else {
                        var a = $(d).find('span.response a.uploadFile');
                        var fileToUpload = "";
                        if (a.attr("href") != undefined) {
                            fileToUpload = a.attr("href");
                        }
                        if (a) {
                            jsonStr += '{"name":"' + input.attr('name') + '","value":"' + fileToUpload.replace(aspxRootPath, "") + '"},';
                        }
                    }
                    var hdn = $(d).find('input[type="hidden"]');
                    if (hdn) {
                        jsonStr += '{"name":"' + hdn.attr('name') + '","value":"' + hdn.val() + '"},';
                    }
                    break;
                case 'password':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    break;
                case 'textarea':
                        // jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val().replace( /(&nbsp;)*/g , "")) + '"},';

                    break;
                default:
                    break;
                }
            }
        });
        for (var i = 0; i < selectGroups.length; i++) {
            var selIDs = '';
            $('#' + selectGroups[i] + ' :selected').each(function(i, selected) {
                selIDs += $(selected).val() + ",";
            });
            selIDs = selIDs.substr(0, selIDs.length - 1);
            jsonStr += '{"name":"' + selectGroups[i] + '","value":"' + selIDs + '"},';
        }

        for (var i = 0; i < checkboxGroups.length; i++) {
            var chkValues = '';
            $('input[name=' + checkboxGroups[i] + ']').each(function(i, item) {
                if ($(this).is(':checked')) {
                    chkValues += $(this).val() + ",";
                }
            });
            chkValues = chkValues.substr(0, chkValues.length - 1);
            jsonStr += '{"name":"' + checkboxGroups[i] + '","value":"' + chkValues + '"},';
        }

        for (var i = 0; i < radioGroups.length; i++) {
            var radValues = '';
            radValues = $('input[name=' + radioGroups[i] + ']:checked').val();
            jsonStr += '{"name":"' + radioGroups[i] + '","value":"' + radValues + '"},';
        }
        jsonStr = jsonStr.substr(0, jsonStr.length - 1);
        return '[' + jsonStr + ']';
    }

    function CreateFileUploader(uploaderID) {
        //alert(d.html());
        new AjaxUpload(String(uploaderID), {
            action: aspxItemModulePath + 'FileUploader.aspx',
            name: 'myfile',
            onSubmit: function(file, ext) {
                d = $('#' + uploaderID).parent();
                baseLocation = d.attr("name");
                validExt = d.attr("class");
                maxFileSize = d.attr("lang");
                var regExp = /\s+/g ;
                myregexp = new RegExp("(" + validExt.replace(regExp, "|") + ")", "i");
                if (ext != "exe") {
                    if (ext && myregexp.test(ext)) {
                        this.setData({
                            'BaseLocation': baseLocation,
                            'ValidExtension': validExt,
                            'MaxFileSize': maxFileSize
                        });
                    } else {
                        csscody.alert('<h1>Information Alert</h1><p>You are trying to upload invalid File!</p>');
                        return false;
                    }
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You are trying to upload invalid File!</p>');
                    return false;
                }
            },
            onComplete: function(file, ajaxFileResponse) {
                d = $('#' + uploaderID).parent();
                var res = eval(ajaxFileResponse);
                if (res.Status > 0) {
                    baseLocation = d.attr("name");
                    validExt = d.attr("class");
                    var fileExt = (-1 !== file.indexOf('.')) ? file.replace( /.*[.]/ , '') : '';
                    myregexp = new RegExp("(jpg|jpeg|jpe|gif|bmp|png|ico)", "i");
                    if (myregexp.test(fileExt)) {
                        $(d).find('span.response').html('<div class="cssClassLeft"><img src="' + aspxRootPath + res.UploadedPath + '" class="uploadImage" height="90px" width="100px" /></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    } else {
                        $(d).find('span.response').html('<div class="cssClassLeft"><a href="' + aspxRootPath + res.UploadedPath + '" class="uploadFile" target="_blank">' + file + '</a></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    }
                } else {
                    csscody.error('<h1>Error Message</h1><p>' + res.Message + '</p>');
                }
            }
        });
    }

    function SearchItems() {
        var sku = $.trim($("#txtSearchSKU").val());
        var Nm = $.trim($("#txtSearchName").val());
        if (sku.length < 1) {
            sku = null;
        }
        if (Nm.length < 1) {
            Nm = null;
        }
        var itemType = '';
        if ($("#ddlSearchItemType").val() != 0) {
            itemType = $.trim($("#ddlSearchItemType").val());
        } else {
            itemType = null;
        }
        var attributeSetNm = '';
        if ($("#ddlAttributeSetName").val() != 0) {
            attributeSetNm = $.trim($("#ddlAttributeSetName").val());
        } else {
            attributeSetNm = null;
        }
        //  var visibility = $.trim($("#ddlVisibitity").val()) == "" ? null : ($.trim($("#ddlVisibitity").val()) == "True" ? true : false);
        var visibility = ''
        if ($("#ddlVisibitity").val() != 0) {
            visibility = $.trim($("#ddlVisibitity :selected").text());
        } else {
            visibility = null;
        }
        var isAct = $.trim($("#ddlIsActive").val()) == "" ? null : ($.trim($("#ddlIsActive").val()) == "True" ? true : false);
        BindItemsGrid(sku, Nm, itemType, attributeSetNm, visibility, isAct);
    }

</script>

<!-- Grid -->
<div id="gdvItems_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Manage Items"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNew">
                            <span><span>Add New Item</span></span></button>
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
                                    SKU:</label>
                                <input type="text" id="txtSearchSKU" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Name:</label>
                                <input type="text" id="txtSearchName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Item Type:</label>
                                <select id="ddlSearchItemType" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Attribute Set Name:</label>
                                <select id="ddlAttributeSetName" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Visibility:</label>
                                <select id="ddlVisibitity" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    IsActive:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">True</option>
                                    <option value="False">False</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchItems() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxImageLoader"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End of Grid -->
<!-- Add New Item -->
<div id="gdvItems_form">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblHeading" runat="server" Text="New Item"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <h3>
                <asp:Label ID="lblTabInfo" runat="server" Text="Create Item Settings"></asp:Label>
            </h3>
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblAttributeSet" runat="server" Text="Attribute Set:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="ddlAttributeSet" class="cssClassDropDown" name="D1">
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblItemType" runat="server" Text="Item Type:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="ddlItemType" class="cssClassDropDown" name="D2">
                        </select>
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
                <button type="button" id="btnContinue">
                    <span><span>Continue</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<div id="gdvItems_accordin">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblNewItem" runat="server" Text="New Item"></asp:Label>
            </h2>
        </div>
        <input type="hidden" id="ItemMgt_itemID" value="0" />
        <div id="dynItemForm" class="cssClassAccordionWrapper">
        </div>
    </div>
</div>
<input type="hidden" id="hdnSKUTxtBox" />
<!-- End of Add New Item  -->
<div class="popupbox cssClassItemCostVariant" id="popuprel">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblCostVariantOptionTitle" runat="server" Text="Item Cost Variant Option"></asp:Label>
    </h2>
    <div id="divExistingVariant" class="cssClassFormWrapper">
        <label for="ddlExistingOptions" id="lblExistingOptions" class="cssClassLabel">
            Existing Cost Variant Options:</label>
        <div id="divExisitingDropDown">
            <select id="ddlExistingOptions" class="cssClassDropDown">
            </select>
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnApplyExisingOption">
                        <span><span>Apply</span></span></button>
                </p>
            </div>
        </div>
    </div>
    <div id="divNewVariant">
        <input type="hidden" id="hdnItemCostVar" value="0" />
        <div id="divAddNewOptions">
            <div id="container-7" class="cssClassTabpanelContent">
                <ul>
                    <li><a href="#fragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="Cost Variant Option
                                                                                Properties"></asp:Label>
                        </a></li>
                    <%-- <li id="tabFrontDisplay"><a href="#fragment-2">
                        <asp:Label ID="lblTabTitle2" runat="server" Text="Frontend Properties"></asp:Label>
                    </a></li>--%>
                    <li><a href="#fragment-3">
                            <asp:Label ID="lblTabTitle3" runat="server" Text="Variants Properties"></asp:Label>
                        </a></li>
                </ul>
                <div id="fragment-1">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassFormWrapper">
                        <tr>
                            <td>
                                <asp:Label ID="lblCostVariantName" runat="server" Text="Cost Variant Name:" CssClass="cssClassLabel"></asp:Label>
                                <span class="cssClassRequired">*</span>
                            </td>
                            <td class="cssClassTableRightCol">
                                <input type="text" id="txtCostVariantName" class="cssClassNormalTextBox">
                                <span class="cssClassCostVarRight">
                                    <img class="cssClassSuccessImg" height="13" width="18" alt="Right"></span>
                                <b class="cssClassCostVarError">Ops! found something error, must be unique with no spaces</b>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblCostVariantDescription" runat="server" Text="Description:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <textarea id="txtDescription" name="txtDescription" title="Cost Variant Description"
                                          rows="2" cols="15" class="cssClassTextArea"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblType" runat="server" Text="Type:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <select id="ddlAttributeType" class="cssClassDropDown" name="" title="Cost Variant Input Type">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblDisplayOrder" runat="server" Text="Display Order:" CssClass="cssClassLabel"></asp:Label>
                                <span class="cssClassRequired">*</span>
                            </td>
                            <td class="cssClassTableRightCol">
                                <input class="cssClassNormalTextBox" id="txtDisplayOrder" type="text" /><span id="displayOrder"></span>
                            </td>
                        </tr>
                        <%--<tr>
                                                                            <td>
                                                                                <asp:Label ID="lblIsSystemUse" runat="server" Text="Is System Use:" CssClass="cssClassLabel"></asp:Label>
                                                                            </td>
                                                                            <td>
                                                                                <div id="" class="cssClassCheckBox">
                                                                                    <input type="checkbox" name="chkIsSystemUse" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>--%>
                        <tr>
                            <td>
                                <asp:Label ID="lblActive" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td>
                                <div id="" class="cssClassCheckBox">
                                    <input type="checkbox" name="chkActive" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <%--<div id="fragment-2">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassFormWrapper">
                       <%-- <tr>
                            <td width="50%">
                                <asp:Label ID="lblShowInGrid" runat="server" Text="Show in Grid:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkShowInGrid" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblIsEnableSorting" runat="server" Text="Is Enable Sorting:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkIsEnableSorting" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblIsUseInFilter" runat="server" Text="Is Use in Filter:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkIsUseInFilter" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblShowInSearch" runat="server" Text="Use in Search:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkShowInSearch" />
                                </div>
                            </td>
                        </tr>--%>
                <%-- <tr>
                            <td>
                                <asp:Label ID="lblUseInAdvancedSearch" runat="server" Text="Use in Advanced Search:"
                                    CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkUseInAdvancedSearch" />
                                </div>
                            </td>
                        </tr>--%>
                <%--<tr>                                            </tr>--%>
                <%--  <tr>
                            <td>
                                <asp:Label ID="lblComparable" runat="server" Text="Comparable on Front-end:" CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkComparable" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblUseForPriceRule" runat="server" Text="Use for Price Rule Conditions:"
                                    CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkUseForPriceRule" />
                                </div>
                            </td>
                        </tr>--%>
                <%--<tr>
                            <td>
                                <asp:Label ID="lblUseForPromoRule" runat="server" Text="Use for Promo Rule Conditions:"
                                    CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td>
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkUseForPromoRule" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblUseForRating" runat="server" Text="Use for Rating Conditions:"
                                    CssClass="cssClassLabel"></asp:Label>
                            </td>
                            <td class="cssClassTableRightCol">
                                <div class="cssClassCheckBox">
                                    <input type="checkbox" name="chkUseForRating" />
                                </div>
                            </td>
                        </tr>--%>
                <%--</table>
                </div>--%>
                <div id="fragment-3">
                    <table width="100%" cellspacing="0" cellpadding="0" id="tblVariantTable">
                        <thead>
                            <th>
                                Pos.
                            </th>
                            <th>
                                Name
                            </th>
                            <th>
                                Modifier&nbsp;/Type
                            </th>
                            <th>
                                Weight modifier&nbsp;/&nbsp;Type
                            </th>
                            <th>
                                Status
                            </th>
                            <th>
                                &nbsp;
                            </th>
                        </thead>
                        <tr>
                            <td>
                                <input type="hidden" size="3" class="cssClassVariantValue" value="0">
                                <input type="text" size="3" class="cssClassDisplayOrder">
                            </td>
                            <td>
                                <input type="text" class="cssClassItemCostVariantValueName">
                            </td>
                            <td>
                                <input type="text" size="5" class="cssClassPriceModifier">
                                &nbsp;/&nbsp;
                                <select class="cssClassPriceModifierType">
                                    <option value="false">$</option>
                                    <option value="true">%</option>
                                </select>
                            </td>
                            <td>
                                <input type="text" size="5" class="cssClassWeightModifier">
                                &nbsp;/&nbsp;
                                <select class="cssClassWeightModifierType">
                                    <option value="false">lbs</option>
                                    <option value="true">%</option>
                                </select>
                            </td>
                            <td>
                                <select class="cssClassIsActive">
                                    <option value="true">Active</option>
                                    <option value="false">Disabled</option>
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
                </div>
            </div>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnResetVariantOptions">
                    <span><span>Reset</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSaveItemVariantOption">
                    <span><span>Save Option</span></span></button>
            </p>
            <div class="cssClassClear">
            </div>
        </div>
    </div>
</div>