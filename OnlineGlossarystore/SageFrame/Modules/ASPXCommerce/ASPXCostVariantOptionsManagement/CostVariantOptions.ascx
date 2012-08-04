<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CostVariantOptions.ascx.cs"
            Inherits="Modules_ASPXCostVariantOptionsManagement_CostVariantOptions" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadAllImages();
        BindCostVariantInGrid(null);
        HideAllDiv();
        $("#divShowOptionDetails").show();
        BindCostVariantsInputType();

        InitializeVariantTable();

        $('#btnDeleteSelected').click(function() {
            var costVariant_ids = '';
            $(".costVariantChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    costVariant_ids += $(this).val() + ',';
                }
            });
            if (costVariant_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleCostVariants(costVariant_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });

        $("#btnSaveVariantOption").click(function() {
            var counter = 0
            $('#tblVariantTable>tbody tr:eq(0)').each(function() {
                if ($(this).find('inpur.cssClassPriceModifier,input.cssClassWeightModifier').val() != '' && $(this).find('input.cssClassDisplayOrder,input.cssClassVariantValueName').val() == '' || $(this).find('input.cssClassDisplayOrder').val() != '' && $(this).find('input.cssClassVariantValueName').val() == '' || $(this).find('input.cssClassDisplayOrder').val() == '' && $(this).find('input.cssClassVariantValueName').val() != '') {
                    alert("Enter Variants Properties");
                    counter++;
                    return false;
                }
            });
            var variantsProperties = $("#tblVariantTable tr:gt(1)").find("input.cssClassDisplayOrder,input.cssClassVariantValueName,inpur.cssClassPriceModifier,input.cssClassWeightModifier");
            var count = 0;
            $.each(variantsProperties, function(index, item) {
                if ($(this).val() <= '') {
                    alert("Enter Variants Properties");
                    count++;
                    return false;
                }
            });
            if (count == 0 && counter == 0)
                SaveCostVariantsInfo();
        });

        $('#ddlAttributeType').change(function() {
            HideAllCostVariantImages();
        });

        $("#btnAddNewVariantOption").click(function() {
            OnInit();
            ClearForm();
            //$("#btnSaveVariantOption").attr("name", "0");
            HideAllDiv();

            $("#divAddNewOptions").show();
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
        });

        $("#btnBack").click(function() {
            HideAllDiv();
            $("#divShowOptionDetails").show();
        });

        $("#btnReset").click(function() {
            OnInit();
            ClearForm();
        });
        $("#txtDisplayOrder").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#dispalyOrder").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        //validate name on focus lost
        $('#txtCostVariantName').blur(function() {
            // Validate name
            var errors = '';
            var costVariantName = $(this).val();
            var variant_id = $('#btnSaveVariantOption').attr("name");
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
                $('.cssClassRight').hide();
                $('.cssClassError').show();
                $(".cssClassError").parent('div').addClass("diverror");
                $('.cssClassError').prevAll("input:first").addClass("error");
                $('.cssClassError').html(errors);
                return false;
            } else {
                $('.cssClassRight').show();
                $('.cssClassError').hide();
                $(".cssClassError").parent('div').removeClass("diverror");
                $('.cssClassError').prevAll("input:first").removeClass("error");
            }

        });

        $(".delbutton").click(function() {
            //Get the Id of the option to delete
            var costVariantId = $(this).attr("id").replace( /[^0-9]/gi , '');
            DeleteCostVariants(costVariantId);
            HideAllDiv();
            $("#divShowOptionDetails").show();
        });

    });

    function LoadAllImages() {
        $("#ajaxLoad").attr("src", '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('.cssClassSuccessImg').attr("src", '' + aspxTemplateFolderPath + '/images/right.jpg');
        $('.cssClassAddRow').attr("src", '' + aspxTemplateFolderPath + '/images/admin/icon_add.gif');
        $('.cssClassCloneRow').attr("src", '' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif');
        $('.cssClassDeleteRow').attr("src", '' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif');
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
                var costVariantValueId = $(parentRow).find("input[type='hidden']").val();
                if (costVariantValueId > 0) {
                    DeleteCostVaraiantValue(costVariantValueId, parentRow);
                } else {
                    $(parentRow).remove();
                }
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

    function DeleteCostVaraiantValue(costVariantValueId, parentRow) {
        var properties = {
            onComplete: function(e) {
                ConfirmDeleteCostVariantValue(costVariantValueId, storeId, portalId, userName, cultureName, parentRow, e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this CostVariant Value?</p>", properties);
    }

    function ConfirmDeleteCostVariantValue(costVariantValueId, storeId, portalId, userName, cultureName, parentRow, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCostVariantValue",
                data: JSON2.stringify({ costVariantValueID: costVariantValueId, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
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

    function BindCostVariantInGrid(costVariantNm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCostVariantGrid_pagesize").length > 0) ? $("#gdvCostVariantGrid_pagesize :selected").text() : 10;

        $("#gdvCostVariantGrid").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCostVariants',
            colModel: [
                { display: 'Cost Variant ID', name: 'costvariant_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'costVariantChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Cost Variant Name', name: 'cost_variant_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCostVariant', arguments: '1' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCostVariant', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { variantName: costVariantNm, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 2: { sorter: false } }
        });
    }

    function EditCostVariant(tblID, argus) {
        switch (tblID) {
        case "gdvCostVariantGrid":
            ClearForm();
            OnInit();
            $(".delbutton").attr("id", 'variantid_' + argus[0]);
            $(".delbutton").show();

            $("#btnSaveVariantOption").attr("name", argus[0]);
            $("#<%= lblCostVarFormHeading.ClientID %>").html("Edit Cost variant Option: '" + argus[3] + "'");

            var functionName = 'GetCostVariantInfoByCostVariantID';
            var params = { costVariantID: argus[0], storeID: storeId, portalID: portalId, cultureName: cultureName };
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
                    BindCostVariantValueByCostVariantID(argus[0]);
                    HideAllDiv();
                    $("#divAddNewOptions").show();
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
            $('#ddlAttributeType').val(item.InputTypeID);
            $('#ddlAttributeType').attr('disabled', 'disabled');
            $('#txtDisplayOrder').val(item.DisplayOrder);
            $("#txtDescription").val(item.Description);
            $('input[name=chkActive]').attr('checked', item.IsActive);
            //frontend properties tab  
            //$('input[name=chkShowInSearch]').attr('checked', item.ShowInSearch);
            //$('input[name=chkShowInGrid]').attr('checked', item.ShowInGrid);
            //h        $('input[name=chkUseInAdvancedSearch]').attr('checked', item.ShowInAdvanceSearch);
            //h        $('input[name=chkComparable]').attr('checked', item.ShowInComparison);
            //h        $('input[name=chkUseForPriceRule]').attr('checked', item.IsIncludeInPriceRule);
            //$('input[name=chkUseForPromoRule]').attr('checked', item.IsIncludeInPromotions);
            //$('input[name=chkIsEnableSorting]').attr('checked', item.IsEnableSorting);
            //$('input[name=chkIsUseInFilter]').attr('checked', item.IsUseInFilter);
            //$('input[name=chkUseForRating]').attr('checked', item.IsShownInRating);
        });
    }

    function BindCostVariantValueByCostVariantID(costVariantId) {
        var functionName = 'GetCostVariantValuesByCostVariantID';
        var params = { costVariantID: costVariantId, storeID: storeId, portalID: portalId, cultureName: cultureName };
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
                        newVariantRow += '<td><input type="text" class="cssClassVariantValueName" value="' + item.CostVariantsValueName + '"></td>';
                        newVariantRow += '<td><input type="text" size="5" class="cssClassPriceModifier" value="' + item.CostVariantsPriceValue + '">&nbsp;/&nbsp;';
                        newVariantRow += '<select class="cssClassPriceModifierType priceModifierType_' + item.CostVariantsValueID + '"><option value="false">$</option><option value="true">%</option></select></td>';
                        newVariantRow += '<td><input type="text" size="5" class="cssClassWeightModifier" value="' + item.CostVariantsWeightValue + '">&nbsp;/&nbsp;';
                        newVariantRow += '<select class="cssClassWeightModifierType weightModifierType_' + item.CostVariantsValueID + '"><option value="false">lbs</option><option value="true">%</option></select></td>';
                        newVariantRow += '<td><select class="cssClassIsActive isActive_' + item.CostVariantsValueID + '"><option value="true">Active</option><option value="false">Disabled</option></select></td>';
                        newVariantRow += '<td><span class="nowrap">';
                        newVariantRow += '<img width="13" height="18" border="0" align="top" class="cssClassAddRow" title="Add empty item" alt="Add empty item" name="add" src="' + aspxTemplateFolderPath + '/images/admin/icon_add.gif">&nbsp;';
                        newVariantRow += '<img width="13" height="18" border="0" align="top" class="cssClassCloneRow" alt="Clone this item" title="Clone this item" name="clone" src="' + aspxTemplateFolderPath + '/images/admin/icon_clone.gif">&nbsp;';
                        newVariantRow += '<img width="12" height="18" border="0" align="top" class="cssClassDeleteRow" alt="Remove this item" name="remove" src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif">&nbsp;';
                        newVariantRow += '</span></td></tr>';
                        $("#tblVariantTable>tbody").append(newVariantRow);

                        $('.priceModifierType_' + item.CostVariantsValueID).val('' + item.IsPriceInPercentage + '');
                        $('.weightModifierType_' + item.CostVariantsValueID).val('' + item.IsWeightInPercentage + '');
                        $('.isActive_' + item.CostVariantsValueID).val('' + item.IsActive + '');
                        $("#divAddNewOptions").show();
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
                    });
                    $("#tblVariantTable>tbody").find("tr:eq(0)").find("img.cssClassDeleteRow").hide();
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Cost Variant Values</p>');
            }
        });
    }

    function DeleteCostVariant(tblID, argus) {
        switch (tblID) {
        case "gdvCostVariantGrid":
            DeleteCostVariants(argus[0]);
            break;
        default:
            break;
        }
    }

    function DeleteCostVariants(_costVariantId) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDeleteCostVariant(_costVariantId, e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this CostVariant option?</p>", properties);
    }

    function ConfirmSingleDeleteCostVariant(costVariantID, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteSingleCostVariant",
                data: JSON2.stringify({ CostVariantID: costVariantID, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindCostVariantInGrid(null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }

    function ConfirmDeleteMultipleCostVariants(costVariant_ids, event) {
        if (event) {
            DeleteMultipleCostVariants(costVariant_ids, storeId, portalId, userName);
        }
    }

    function DeleteMultipleCostVariants(_costVariant_ids, _storeId, _portalId, userName) {
        var params = { costVariantIDs: _costVariant_ids, storeId: _storeId, portalId: _portalId, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleCostVariants",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindCostVariantInGrid(null);
            }
        });
        return false;
    }


    function HideAllDiv() {
        $("#divShowOptionDetails").hide();
        $("#divAddNewOptions").hide();
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

    function ClearForm() {
        $(".delbutton").removeAttr("id");
        $("#btnSaveVariantOption").removeAttr("name");
        $(".delbutton").hide();
        $("#btnReset").show();

        $("#txtCostVariantName").val('');
        $("#txtDescription").val('');
        $('#ddlAttributeType').val(1);
        $('#ddlAttributeType').removeAttr('disabled');
        $('#txtDisplayOrder').val('');
        $('input[name=chkActive]').attr('checked', 'checked');

        $("#<%= lblCostVarFormHeading.ClientID %>").html("Add New Cost Variant Option");

        //Next Tab
        //$('input[name=chkShowInSearch]').removeAttr('checked');
        //$('input[name=chkShowInGrid]').removeAttr('checked');
        //h     $('input[name=chkUseInAdvancedSearch]').removeAttr('checked');
        //h     $('input[name=chkComparable]').removeAttr('checked');
        //h     $('input[name=chkUseForPriceRule]').removeAttr('checked');
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
        $('#btnReset').hide();
        $('.cssClassRight').hide();
        $('.cssClassError').hide();
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

    function SaveCostVariantsInfo() {
        var variant_id = $('#btnSaveVariantOption').attr("name");
        if (variant_id != '') {
            SaveCostVariant(variant_id, storeId, portalId, userName, cultureName, false);
        } else {
            SaveCostVariant(0, storeId, portalId, userName, cultureName, true);
        }
    }

    function SaveCostVariant(_costVariantId, _storeId, _portalId, _userName, _cultureName, _isNewflag) {
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

            var _costVariantName = $('#txtCostVariantName').val();
            var _inputTypeID = $('#ddlAttributeType').val();

            var selectedCostVariantType = $("#ddlAttributeType :selected").val();

            var _Description = $('#txtDescription').val();
            var _DisplayOrder = $('#txtDisplayOrder').val();
            var _ShowInGrid = false; //$('input[name=chkShowInGrid]').attr('checked');
            var _ShowInSearch = false; //$('input[name=chkShowInSearch]').attr('checked');
            var _ShowInAdvanceSearch = false; //$('input[name=chkUseInAdvancedSearch]').attr('checked'); //h
            var _ShowInComparison = false; //$('input[name=chkComparable]').attr('checked'); //h
            var _IsEnableSorting = false; //$('input[name=chkIsEnableSorting]').attr('checked');
            var _IsUseInFilter = false; //$('input[name=chkIsUseInFilter]').attr('checked');
            var _IsIncludeInPriceRule = false; //$('input[name=chkUseForPriceRule]').attr('checked'); //h 
            var _IsIncludeInPromotions = false; //$('input[name=chkUseForPromoRule]').attr('checked');
            var _IsShownInRating = false; //$('input[name=chkUseForRating]').attr('checked');
            var _IsActive = $('input[name=chkActive]').attr('checked');
            var _IsModified = !(_isNewflag);
            var _IsNewflag = _isNewflag;

            var _VariantOptions = '';
            //if ($('#variantTab').is(':visible')) {
            $('#tblVariantTable>tbody tr').each(function() {
                _VariantOptions += $(this).find(".cssClassVariantValue").val() + '%';
                _VariantOptions += $(this).find(".cssClassDisplayOrder").val() + '%'; //{required:true,digits:true,minlength:1}
                _VariantOptions += $(this).find(".cssClassVariantValueName").val() + '%'; //{required:true,minlength:2}
                if ($(this).find(".cssClassVariantValueName").val() != '' && $(this).find(".cssClassPriceModifier").val() == '') {
                    _VariantOptions += 0.00 + '%';
                } else {
                    _VariantOptions += $(this).find(".cssClassPriceModifier").val() + '%'; //{required:true,number:true,minlength:1}
                }
                _VariantOptions += $(this).find(".cssClassPriceModifierType").val() + '%';
                if ($(this).find(".cssClassVariantValueName").val() != '' && $(this).find(".cssClassWeightModifier").val() == '') {
                    _VariantOptions += 0.00 + '%';
                } else {
                    _VariantOptions += $(this).find(".cssClassWeightModifier").val() + '%'; //{required:true,number:true,minlength:1}
                }
                _VariantOptions += $(this).find(".cssClassWeightModifierType").val() + '%';
                _VariantOptions += $(this).find(".cssClassIsActive").val() + '#';
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

            AddCostVariantInfo(_costVariantId, _costVariantName, _Description, _CultureName, _inputTypeID, _DisplayOrder, _ShowInGrid, _ShowInSearch,
                _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter, _IsIncludeInPriceRule, _IsIncludeInPromotions, _IsShownInRating,
                _StoreID, _PortalID, _IsActive, _IsModified, _UserName, _VariantOptions, _IsNewflag);
        }
        return false;
    }

    function AddCostVariantInfo(_costVariantId, _costVariantName, _Description, _CultureName, _inputTypeID, _DisplayOrder, _ShowInGrid, _ShowInSearch,
        _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter, _IsIncludeInPriceRule, _IsIncludeInPromotions, _IsShownInRating,
        _StoreID, _PortalID, _IsActive, _IsModified, _UserName, _VariantOptions, _IsNewflag) {
        var params = {
            costVariantID: _costVariantId,
            costVariantName: _costVariantName,
            description: _Description,
            cultureName: _CultureName,
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
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateCostVariant",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindCostVariantInGrid(null);
                HideAllDiv();
                $("#divShowOptionDetails").show();
                alert("success");
            }
        });
    }

    function SearchCostVariantName() {
        var costVariantNm = $.trim($("#txtVariantName").val());
        if (costVariantNm.length < 1) {
            costVariantNm = null;
        }
        BindCostVariantInGrid(costVariantNm);
    }

</script>

<!-- Grid -->
<div id="divShowOptionDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCostVarGridHeading" runat="server" Text="Existing Cost Variant Options"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewVariantOption">
                            <span><span>Add New Cost Variant Option</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Cost Variant Name:</label>
                                <input type="text" id="txtVariantName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCostVariantName() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxLoad" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCostVariantGrid" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End of Grid -->
<!-- form -->
<div id="divAddNewOptions">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCostVarFormHeading" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassTabPanelTable">
            <div id="container-7" class="cssClassMargin">
                <ul>
                    <li><a href="#fragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="Cost Variant Option
                                                                                Properties"></asp:Label>
                        </a></li>
                    <%-- <li><a href="#fragment-2">
                        <asp:Label ID="lblTabTitle2" runat="server" Text="Frontend Properties"></asp:Label>
                    </a></li>--%>
                    <li><a href="#fragment-3">
                            <asp:Label ID="lblTabTitle3" runat="server" Text="Variants Properties"></asp:Label>
                        </a></li>
                </ul>
                <div id="fragment-1">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab1Info" runat="server" Text="General Information"></asp:Label>
                        </h3>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="tdpadding">
                            <tr>
                                <td>
                                    <asp:Label ID="lblCostVariantName" runat="server" Text="Cost Variant Name:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="text" id="txtCostVariantName" class="cssClassNormalTextBox">
                                    <span class="cssClassRight">
                                        <img class="cssClassSuccessImg" height="13" width="18" alt="Right" ></span>
                                    <b class="cssClassError">Ops! found something error, must be unique with no spaces</b>
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
                                    <input class="cssClassNormalTextBox" id="txtDisplayOrder" type="text"><span id="dispalyOrder"></span>
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
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkActive" class="cssClassCheckBox" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <%--  <div id="fragment-2">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab2Info" runat="server" Text="Frontend Display Settings"></asp:Label>
                        </h3>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="tdpadding">--%>
                <%--<tr>
                                <td>
                                    <asp:Label ID="lblShowInGrid" runat="server" Text="Show in Grid:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkShowInGrid" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblIsEnableSorting" runat="server" Text="Is Enable Sorting:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkIsEnableSorting" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblIsUseInFilter" runat="server" Text="Is Use in Filter:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkIsUseInFilter" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                <%--<tr>
                                <td>
                                    <asp:Label ID="lblShowInSearch" runat="server" Text="Use in Search:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkShowInSearch" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                <%--h  <tr>
                                <td>
                                    <asp:Label ID="lblUseInAdvancedSearch" runat="server" Text="Use in Advanced Search:"
                                        CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUseInAdvancedSearch" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                <%--<tr>
                                                                            <td>
                                                                                <asp:Label ID="lblVisibleOnFrontend" runat="server" Text="Visible on Item View Page on Front-end:"
                                                                                    CssClass="cssClassLabel"></asp:Label>
                                                                            </td>
                                                                            <td class="cssClassTableRightCol">
                                                                                <div class="cssClassCheckBox">
                                                                                    <input type="checkbox" name="chkVisibleOnFrontend" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:Label ID="lblUsedInItemListing" runat="server" Text="Used in Item Listing:"
                                                                                    CssClass="cssClassLabel"></asp:Label>
                                                                            </td>
                                                                            <td class="cssClassTableRightCol">
                                                                                <div class="cssClassCheckBox">
                                                                                    <input type="checkbox" name="chkUsedInItemListing" />
                                                                                </div>
                                                                            </td>
                                                                        </tr>--%>
                <%-- h<tr>
                                <td>
                                    <asp:Label ID="lblComparable" runat="server" Text="Comparable on Front-end:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkComparable" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblUseForPriceRule" runat="server" Text="Use for Price Rule Conditions:"
                                        CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUseForPriceRule" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                <%--<tr>
                                <td>
                                    <asp:Label ID="lblUseForPromoRule" runat="server" Text="Use for Promo Rule Conditions:"
                                        CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUseForPromoRule" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblUseForRating" runat="server" Text="Use for Rating Conditions:"
                                        CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUseForRating" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                <%-- </table>
                    </div>
                </div>--%>
                <div id="fragment-3">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab3Info" runat="server" Text="Cost Variants Settings"></asp:Label>
                        </h3>
                        <div class="cssClassGridWrapper">
                            <div class="cssClassGridWrapperContent cssClassPadding">
                                <table width="100%" cellspacing="0" cellpadding="0" id="tblVariantTable" class="tdpadding">
                                    <thead>
                                        <tr class="cssClassHeading">
                                            <th align="left">
                                                Pos.
                                            </th>
                                            <th align="left">
                                                Name
                                            </th>
                                            <th align="left">
                                                Modifier&nbsp;/Type
                                            </th>
                                            <th align="left">
                                                Weight modifier&nbsp;/&nbsp;Type
                                            </th>
                                            <th align="left">
                                                Status
                                            </th>
                                            <th align="left">
                                                &nbsp;
                                            </th>
                                        </tr>
                                    </thead>
                                    <tr>
                                        <td>
                                            <input type="hidden" size="3" class="cssClassVariantValue" value="0">
                                            <input type="text" size="3" class="cssClassDisplayOrder">
                                        </td>
                                        <td>
                                            <input type="text" class="cssClassVariantValueName">
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
                </div>
            </div>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnBack">
                    <span><span>Back</span></span>
                </button>
            </p>
            <p>
                <button type="button" id="btnReset" />
                <span><span>Reset</span></span> </button>
            </p>
            <p>
                <button type="button" id="btnSaveVariantOption" />
                <span><span>Save Option</span></span> </button>
            </p>
            <p>
                <button type="button" class="delbutton" />
                <span><span>Delete Option</span></span> </button>
            </p>
        </div>
    </div>
</div>
<!-- End form -->