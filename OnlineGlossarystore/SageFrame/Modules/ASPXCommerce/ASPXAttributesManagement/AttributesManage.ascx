<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttributesManage.ascx.cs"
            Inherits="Modules_ASPXAttributesManagement_AttributesManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    //    var $j = jQuery.noConflict();
    //    $j(document).ready(function(){

    $(document).ready(function() {
        BindAttributeGrid(null, null, null, null);
        LoadAttributeStaticImage();
        $('#divAttribForm').hide();
        $('#divAttribGrid').show();
        BindAttributesInputType();
        BindAttributesValidationType();
        BindAttributesItemType();
        $('.itemTypes').hide();
        $('#ddlApplyTo').change(function() {
            var selectedValue = $(this).val();
            if (selectedValue !== "0") {
                $('.itemTypes').show();
            } else {
                $('.itemTypes').hide();
            }
        });


        $('#btnDeleteSelected').click(function() {
            var attribute_ids = '';
            //Get the multiple Ids of the attribute selected
            $("#gdvAttributes .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    attribute_ids += $(this).val() + ',';
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
        })

        $('#btnAddNew').click(function() {
            $('#divAttribGrid').hide();
            $('#divAttribForm').show();
            ClearForm();
        })

        $('#btnBack').click(function() {
            $('#divAttribForm').hide();
            $('#divAttribGrid').show();
            ClearForm();
        })

        $('#btnReset').click(function() {
            ClearForm();
        })

        $('#btnSaveAttribute').click(function() {
            //check if its update or save new 
            //Get the Id of the attribute to update
            var attribute_id = $(this).attr("name");
            if (attribute_id != '') {
                SaveAttribute(attribute_id, storeId, portalId, userName, cultureName, false);
            } else {
                SaveAttribute(0, storeId, portalId, userName, cultureName, true);
            }
        })

        //validate name on focus lost
        $('#txtAttributeName').blur(function() {
            // Validate name
            var errors = '';
            var attributeName = $(this).val();
            var attribute_id = $('#btnSaveAttribute').attr("name");
            if (attribute_id == '') {
                attribute_id = 0;
            }
            if (!attributeName) {
                errors += ' - Please enter attribute name';
            }
                //check uniqueness
            else if (!IsUnique(attributeName, attribute_id)) {
                errors += ' - Please enter unique attribute name! "' + attributeName.trim() + '" already exists.<br/>';
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
            //Get the Id of the attribute to delete
            var attribute_id = $(this).attr("id").replace( /[^0-9]/gi , '');
            DeleteAttribute(attribute_id, storeId, portalId, userName);
        });

        $("#ddlAttributeType").change(function() {
            //$("#dataTable>tbody tr:not(:first)").remove();
            $("#dataTable tr:gt(1)").remove();
            $("#dataTable>tbody tr").find("input:not(:last)").each(function(i) {
                if (this.name == "value") {
                    $(this).val('');
                } else if (this.name == "position") {
                    $(this).val('');
                } else if ($(this).hasClass("class-isdefault")) {
                    this.checked = false;
                }
            });
            ValidationTypeEnableDisable("", true);
        });

        $("input[type=button].AddOption").click(function() {
            var checkedState = false;
            if ($(this).attr("name") == "DeleteOption") {
                var t = $(this).closest('tr');
                t.find("td")
                    .wrapInner("<div style='DISPLAY: block'/>")
                    .parent().find("td div")
                    .slideUp(300, function() {
                        t.remove();
                    });
            } else if ($(this).attr("name") == "AddMore") {
                checkedState = $('#dataTable>tbody tr:first').find('input[type="radio"]').attr("checked");
                var cloneRow = $(this).closest('tr').clone(true)
                $(cloneRow).find("input").each(function(i) {
                    if (this.name == "value") {
                        $(this).val('');
                    } else if (this.name == "position") {
                        $(this).val('');
                    } else if (this.name == "Alias") {
                        $(this).val('');
                    } else if ($(this).hasClass("class-isdefault")) {
                        this.checked = false;
                    } else if ($(this).hasClass("AddOption")) {
                        $(this).attr("name", "DeleteOption");
                        $(this).attr("value", "Delete Option");
                    }
                });
                $(cloneRow).appendTo("#dataTable");
                $('#dataTable>tbody tr:first').find('input[type="radio"]').attr("checked", checkedState);
                $('#dataTable tr:last').hide();
                $('#dataTable tr:last td').fadeIn('slow');
                $('#dataTable tr:last').show();
                $('#dataTable tr:last td').show();
            }
        });
    });

    function LoadAttributeStaticImage() {
        $('#ajaxAttributeImageLoader').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('.cssClassSuccessImg').attr('src', '' + aspxTemplateFolderPath + '/images/right.jpg');
    }

    function ConfirmDeleteMultiple(attribute_ids, event) {
        if (event) {
            DeleteMultipleAttribute(attribute_ids, storeId, portalId, userName);
        }
    }

    function DeleteMultipleAttribute(_attributeIds, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { attributeIds: _attributeIds, storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleAttributesByAttributeID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindAttributeGrid(null, null, null, null);
            }
        });
        return false;
    }

    function DeleteAttribute(_attributeId, _storeId, _portalId, _userName) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(_attributeId, _storeId, _portalId, _userName, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this attribute?</p>", properties);
    }

    function ConfirmSingleDelete(attribute_id, _storeId, _portalId, _userName, event) {
        if (event) {
            DeleteSingleAttribute(attribute_id, _storeId, _portalId, _userName);
        }
        return false;
    }

    function DeleteSingleAttribute(_attributeId, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { attributeId: parseInt(_attributeId), storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteAttributeByAttributeID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindAttributeGrid(null, null, null, null);
                $('#divAttribForm').hide();
                $('#divAttribGrid').show();
            }
        });
    }

    function ClearOptionTable(btnAddOption) {
        btnAddOption.closest("tr(0)").find("input:not(:last)").each(function(i) {
            $(this).val('');
            $(this).removeAttr('checked');
        });
    }

    function ValidationTypeEnableDisable(fillOptionValues, isChanged) {
        var selectedVal = $("#ddlAttributeType :selected").val();
        switch (selectedVal) {
        case "1":
            $("#ddlTypeValidation").removeAttr('disabled');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#txtLength").removeAttr('disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").show();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "2":
            $("#ddlTypeValidation").removeAttr('disabled');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Rows:");
            if (isChanged) {
                $('#txtLength').val(3);
            }
            $("#txtLength").removeAttr('disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").hide();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").show();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').removeAttr('disabled');
            break;
        case "3":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").hide();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").show();
            $("#default_value_date").datepicker({ dateFormat: 'yy/mm/dd' });
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "4":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").hide();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").show();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "5":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#<%= lblLength.ClientID %>").html("Size:");
            $("#txtLength").removeAttr('disabled');
            if (isChanged) {
                $('#txtLength').val(3);
            }
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();
                //$("input[name=defaultChk]").show();
                //$("input[name=defaultRdo]").hide();
            $("#tddefault").html('<input type=\"checkbox\" name=\"defaultChk\" class=\"class-isdefault\">');
            $(".AddOption").show();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "6":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();
                //$("input[name=defaultChk]").hide();
                //$("input[name=defaultRdo]").show();
            $("#tddefault").html('<input type=\"radio\" name=\"defaultRdo\" class=\"class-isdefault\">');
            $(".AddOption").show();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "7":
            $('#ddlTypeValidation').val('6');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").removeAttr('disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").show();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "8":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblDefaultValue.ClientID %>").html("Allowed File Extension(s):");
            $("#fileDefaultTooltip").html('- Separate each file extensions with space');
            $("#fileDefaultTooltip").show();
            $("#<%= lblLength.ClientID %>").html("Size:(KB)");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").removeAttr('disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").show();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "9":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();

                //$("input[name=defaultChk]").hide();
                //$("input[name=defaultRdo]").show();
            $("#tddefault").html('<input type=\"radio\" name=\"defaultRdo\" class=\"class-isdefault\">');
            $(".AddOption").hide();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "10":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();
                //$("input[name=defaultChk]").hide();
                //$("input[name=defaultRdo]").show();
            $("#tddefault").html('<input type=\"radio\" name=\"defaultRdo\" class=\"class-isdefault\">');
            $(".AddOption").show();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "11":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();
                //$("input[name=defaultChk]").show();
                //$("input[name=defaultRdo]").hide();
            $("#tddefault").html('<input type=\"checkbox\" name=\"defaultChk\" class=\"class-isdefault\">');
            $(".AddOption").hide();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "12":
            $('#ddlTypeValidation').val('8');
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#ddlTypeValidation").attr('disabled', 'disabled');
            $("#txtLength").attr('disabled', 'disabled');
            $("#trdefaultValue").hide();
            $('#trOptionsAdd').show();
                //$("input[name=defaultChk]").show();
                //$("input[name=defaultRdo]").hide();
            $("#tddefault").html('<input type=\"checkbox\" name=\"defaultChk\" class=\"class-isdefault\">');
            $(".AddOption").show();
            BindAttributeOptionsValues(fillOptionValues);
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        case "13":
            $("#ddlTypeValidation").removeAttr('disabled');
            $("#<%= lblDefaultValue.ClientID %>").html("Default Value:");
            $("#<%= lblLength.ClientID %>").html("Length:");
            if (isChanged) {
                $('#txtLength').val('');
            }
            $("#txtLength").removeAttr('disabled');
            $("#trdefaultValue").show();
            $("#default_value_text").show();
            $("#fileDefaultTooltip").html('');
            $("#fileDefaultTooltip").hide();
            $("#default_value_textarea").hide();
            $("#div_default_value_date").hide();
            $("#default_value_yesno").hide();
            $('#trOptionsAdd').hide();
            $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
            break;
        default:
            break;
        }
    }

    function IsUnique(attributeName, attributeId) {
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckUniqueAttributeName",
            data: JSON2.stringify({ attributeName: attributeName, attributeId: attributeId, storeId: storeId, portalId: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isUnique = data.d;
            }
        });
        return isUnique;
    }

    function SaveAttribute(_attributeId, _storeId, _portalId, _userName, _cultureName, _flag) {
        var selectedItemTypeID = '';
        var validateErrorMessage = '';
        var itemSelected = false;
        var isUsedInConfigItem = false;

        // Validate name
        var attributeName = $('#txtAttributeName').val();
        if (!attributeName) {
            validateErrorMessage += ' - Please enter attribute name<br/>';
        } else if (!IsUnique(attributeName, _attributeId)) {
            validateErrorMessage += ' - Please enter unique attribute name! "' + attributeName.trim() + '" already exists.<br/>';
        }
        //Validate ddlApplyTo and lstItemType selected at least one item
        var selectedValue = $("#ddlApplyTo").val();
        if (selectedValue !== "0") {
            $("#lstItemType").each(function() {
                if ($("#lstItemType :selected").length != 0) {
                    itemSelected = true;
                    $("#lstItemType option:selected").each(function(i) {
                        //alert($(this).text() + " : " + $(this).val());
                        selectedItemTypeID += $(this).val() + ',';
                        if ($(this).val() == '3') {
                            isUsedInConfigItem = true;
                        }
                    });
                }
            });
            if (!itemSelected) {
                validateErrorMessage += ' - Please select at least one item type<br/>';
            }
        } else {
            isUsedInConfigItem = true;
            $("#lstItemType option").each(function(i) {
                selectedItemTypeID += $(this).val() + ',';
            });
        }
        ;
        selectedItemTypeID = selectedItemTypeID.substring(0, selectedItemTypeID.length - 1);

        // Validate attribute max length
        var _Length = $("#txtLength").val();
        if (_Length) {
            var value = _Length.replace( /^\s\s*/ , '').replace( /\s\s*$/ , '');
            var intRegex = /^\d+$/ ;
            if (!intRegex.test(value)) {
                $("#txtLength").focus();
                validateErrorMessage += ' - Attribute max length must be numeric only.<br/>';
            }
        } else {
            _Length = null;
        }

        // Validate attribute Display Order
        var attributeDisplayOrder = $("#txtDisplayOrder").val();
        if (!attributeDisplayOrder) {
            $("#txtDisplayOrder").focus();
            validateErrorMessage += ' - Please enter attribute display order<br/>';
        } else {
            var value = attributeDisplayOrder.replace( /^\s\s*/ , '').replace( /\s\s*$/ , '');
            var intRegex = /^\d+$/ ;
            if (!intRegex.test(value)) {
                $("#txtDisplayOrder").focus();
                validateErrorMessage += ' - Attribute display order must be numeric only.<br/>';
            }
        }

        // Validate attribute alias name
        var attributeDescription = $("#txtAliasName").val();
        if (!attributeDescription) {
            $("#txtAliasName").focus();
            validateErrorMessage += ' - Please enter attribute alias name';
        }

        // Validate options value inputs filled
        var selectedVal = $("#ddlAttributeType :selected").val();
        var _saveOptions = '';
        if (selectedVal == 5 || selectedVal == 6 || selectedVal == 9 || selectedVal == 10 || selectedVal == 11 || selectedVal == 12) {
            $("#dataTable").find("tr input").each(function(i) {
                //if ($(this).is(":visible")) {
                //  if (!$(this).attr('name', 'Alias')) {
                var optionsText = $(this).val();
                if ($(this).hasClass("class-text")) {
                    if (!optionsText && $(this).attr("name") != "Alias") {
                        validateErrorMessage = ' - Please enter all option values and display order for your attribute.<br/>';
                        SetFirstTabActive();
                        $(this).focus();
                    } else {
                        if ($(this).attr("name") == "position") {
                            var value = optionsText.replace( /^\s\s*/ , '').replace( /\s\s*$/ , '');
                            var intRegex = /^\d+$/ ;
                            if (!intRegex.test(value)) {
                                validateErrorMessage = ' - Display order must be numeric only.<br/>';
                                SetFirstTabActive();
                                $(this).focus();
                            }
                        }
                        _saveOptions += optionsText + "#!#";
                    }
                } else if ($(this).hasClass("class-isdefault")) { //&& $(this).is(":visible") && $("#container-7 ul li:first").hasClass("ui-tabs-selected")) {
                    var _IsChecked = $(this).attr('checked');
                    _saveOptions += _IsChecked + "!#!";
                }
                // }
                //}           
            });
        }
        _saveOptions = _saveOptions.substring(0, _saveOptions.length - 3);

        if (validateErrorMessage) {
            validateErrorMessage = 'The following errors occurred:<br/>' + validateErrorMessage;
            csscody.alert('<h1>Information Alert</h1><p>' + validateErrorMessage + '</p>');
            return false;
        } else {
            var _StoreID = _storeId;
            var _PortalID = _portalId;
            var _CultureName = _cultureName;
            var _UserName = _userName;

            var _attributeName = $('#txtAttributeName').val();
            var _inputTypeID = $('#ddlAttributeType').val();

            var selectedAttributeType = $("#ddlAttributeType :selected").val();
            var _DefaultValue = "";
            switch (selectedAttributeType) {
            case "1":
                _DefaultValue = $("#default_value_text").val();
                break;
            case "2":
                _DefaultValue = $("textarea#default_value_textarea").val();
                break;
            case "3":
                _DefaultValue = $("#default_value_date").val();
                break;
            case "4":
                _DefaultValue = $("#default_value_yesno").val();
                break;
            case "8":
                _DefaultValue = $("#default_value_text").val();
                break;
            default:
                _DefaultValue = '';
            }

            var _ValidationTypeID = $('#ddlTypeValidation').val();
            var _AliasName = $('#txtAliasName').val();
            var _AliasToolTip = $('#txtAliasToolTip').val();
            var _AliasHelp = $('#txtAliasHelp').val();
            var _DisplayOrder = $('#txtDisplayOrder').val();

            var _IsUnique = $('input[name=chkUniqueValue]').attr('checked');
            var _IsRequired = $('input[name=chkValuesRequired]').attr('checked');
            var _IsEnableEditor = $('input[name=chkIsEnableEditor]').attr('checked');
            var _ShowInGrid = false; //$('input[name=chkShowInGrid]').attr('checked');
            var _ShowInSearch = false; //$('input[name=chkShowInSearch]').attr('checked');
            var _ShowInAdvanceSearch = $('input[name=chkUseInAdvancedSearch]').attr('checked');
            var _ShowInComparison = $('input[name=chkComparable]').attr('checked');
            var _IsEnableSorting = false; //$('input[name=chkIsEnableSorting]').attr('checked');
            var _IsUseInFilter = false; //$('input[name=chkIsUseInFilter]').attr('checked');
            var _IsIncludeInPriceRule = $('input[name=chkUseForPriceRule]').attr('checked');
            var _IsIncludeInPromotions = false; //$('input[name=chkUseForPromoRule]').attr('checked');
            var _IsShownInRating = false; //$('input[name=chkUseForRating]').attr('checked');
            var _IsActive = $('input[name=chkActive]').attr('checked');
            var _IsModified = true;

            var _ItemTypes = selectedItemTypeID;
            var _Flag = _flag;
            var _IsUsedInConfigItem = isUsedInConfigItem;

            AddAttributeInfo(_attributeId, _attributeName, _inputTypeID, _DefaultValue,
                _ValidationTypeID, _Length, _AliasName, _AliasToolTip, _AliasHelp, _DisplayOrder, _IsUnique, _IsRequired,
                _IsEnableEditor, _ShowInGrid, _ShowInSearch, _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter,
                _IsIncludeInPriceRule, _IsIncludeInPromotions, _IsShownInRating, _StoreID, _PortalID, _IsActive, _IsModified, _UserName,
                _CultureName, _ItemTypes, _Flag, _IsUsedInConfigItem, _saveOptions);
        }
        return false;
    }

    function AddAttributeInfo(_attributeId, _attributeName, _inputTypeID, _DefaultValue,
        _ValidationTypeID, _Length, _AliasName, _AliasToolTip, _AliasHelp, _DisplayOrder,
        _IsUnique, _IsRequired, _IsEnableEditor, _ShowInGrid, _ShowInSearch,
        _ShowInAdvanceSearch, _ShowInComparison, _IsEnableSorting, _IsUseInFilter, _IsIncludeInPriceRule, _IsIncludeInPromotions,
        _IsShownInRating, _storeId, _portalId, _IsActive, _IsModified, _userName, _CultureName, _ItemTypes, _flag, _isUsedInConfigItem, _saveOptions) {
        var params = {
            attributeId: parseInt(_attributeId),
            attributeName: _attributeName,
            inputTypeID: _inputTypeID,
            defaultValue: _DefaultValue,
            validationTypeID: _ValidationTypeID,
            length: _Length,
            aliasName: _AliasName,
            aliasToolTip: _AliasToolTip,
            aliasHelp: _AliasHelp,
            displayOrder: _DisplayOrder,
            isUnique: _IsUnique,
            isRequired: _IsRequired,
            isEnableEditor: _IsEnableEditor,
            showInGrid: _ShowInGrid,
            showInSearch: _ShowInSearch,
            showInAdvanceSearch: _ShowInAdvanceSearch,
            showInComparison: _ShowInComparison,
            isEnableSorting: _IsEnableSorting,
            isUseInFilter: _IsUseInFilter,
            isIncludeInPriceRule: _IsIncludeInPriceRule,
            isIncludeInPromotions: _IsIncludeInPromotions,
            isShownInRating: _IsShownInRating,
            storeId: _storeId,
            portalId: _portalId,
            isActive: _IsActive,
            isModified: _IsModified,
            userName: _userName,
            cultureName: _CultureName,
            itemTypes: _ItemTypes,
            flag: _flag,
            isUsedInConfigItem: _isUsedInConfigItem,
            saveOptions: _saveOptions
        };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveUpdateAttributeInfo",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                $('#divAttribForm').hide();
                BindAttributeGrid(null, null, null, null);
                ClearForm();
                $('#divAttribGrid').show();
            }
        });
        return false;
    }

    function ClearForm() {
        onInit();
        $("#<%= lblAttrFormHeading.ClientID %>").html("New Item Attribute");
        $(".delbutton").removeAttr("id");
        $("#btnSaveAttribute").removeAttr("name");
        $("#<%= lblLength.ClientID %>").html("Length:");
        $(".delbutton").hide();
        $("#btnReset").show();

        $('#txtAttributeName').val('');
        $('#ddlAttributeType').val('1');
        $('#ddlAttributeType').removeAttr('disabled');

        $("#default_value_text").val('');
        $("#default_value_textarea").val('');
        $("#default_value_date").val('');
        $("#trdefaultValue").show();
        $("#default_value_text").show();
        $("#fileDefaultTooltip").html('');
        $("#fileDefaultTooltip").hide();
        $("#fileDefaultTooltip").html('');
        $("#default_value_textarea").hide();
        $("#div_default_value_date").hide();
        $("#default_value_yesno").hide();

        $('#default_value_text').val('');
        $("#dataTable tr:gt(1)").remove();
        ClearOptionTable($("input[type='button'].AddOption"));
        $('#trOptionsAdd').hide();

        $('#ddlTypeValidation').val('8');

        $('#ddlTypeValidation').removeAttr('disabled');
        $('#txtLength').val('');
        $('#txtLength').removeAttr('disabled');
        $('#txtAliasName').val('');
        $('#txtAliasToolTip').val('');
        $('#txtAliasHelp').val('');
        $('#txtDisplayOrder').val('');
        $('#ddlApplyTo').val('0');
        $('.itemTypes').hide();

        $('input[name=chkUniqueValue]').removeAttr('checked');
        $('input[name=chkValuesRequired]').removeAttr('checked');
        $('input[name=chkActive]').attr('checked', 'checked');
        $('#activeTR').show();

        //Next Tab
        $('input[name=chkIsEnableEditor]').attr('disabled', 'disabled');
        //$('input[name=chkShowInSearch]').removeAttr('checked');
        //$('input[name=chkShowInGrid]').removeAttr('checked');
        $('input[name=chkUseInAdvancedSearch]').removeAttr('checked');
        $('input[name=chkComparable]').removeAttr('checked');
        $('input[name=chkUseForPriceRule]').removeAttr('checked');
        //$('input[name=chkUseForPromoRule]').removeAttr('checked');
        //$('input[name=chkIsEnableSorting]').removeAttr('checked');
        //$('input[name=chkIsUseInFilter]').removeAttr('checked');
        //$('input[name=chkUseForRating]').removeAttr('checked');
        return false;
    }

    function ActivateAttribute(_attributeId, _storeId, _portalId, _userName, _isActive) {
        //Pass the selected attribute id and other parameters
        var params = { attributeId: parseInt(_attributeId), storeId: _storeId, portalId: _portalId, userName: _userName, isActive: _isActive };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateAttributeIsActiveByAttributeID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindAttributeGrid(null, null, null, null);
            }
        });
        return false;
    }

    function BindAttributeGrid(attributeNm, required, SearchComparable, isSystem) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAttributes_pagesize").length > 0) ? $("#gdvAttributes_pagesize :selected").text() : 10;

        $("#gdvAttributes").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAttributesList',
            colModel: [
                { display: 'Attribute ID', name: 'attr_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '5', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'Attribute Name', name: 'attr_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Attribute Alias', name: 'attr_alias', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'IsRequired', name: 'IsRequired', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'IsActive', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'System', name: 'IsSystemUsed', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Searchable', name: 'ShowInSearch', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No', hide: true },
                { display: 'Used In Configurable Item', name: 'IsUsedInConfigItem:', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No', hide: true },
                { display: 'Comparable', name: 'ShowInComparison', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'AddedOn', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
            //{ display: 'UpdatedOn', name: 'UpdatedOn', cssclass: 'cssClassHeadDate', controlclass:'',coltype: 'label', align: 'left', type: 'date', format: 'dd/MM/yyyy' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditAttributes', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteAttributes', arguments: '5' },
            //{ display: 'View', name: 'view', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewAttributes' },
                { display: 'Active', name: 'active', enable: true, _event: 'click', trigger: '4', callMethod: 'ActiveAttributes', arguments: '5' },
                { display: 'Deactive', name: 'deactive', enable: true, _event: 'click', trigger: '5', callMethod: 'DeactiveAttributes', arguments: '5' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { attributeName: attributeNm, isRequired: required, comparable: SearchComparable, IsSystem: isSystem, storeId: storeId, portalId: portalId, cultureName: cultureName, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 10: { sorter: false } }
        });
    }

    function EditAttributes(tblID, argus) {
        switch (tblID) {
        case "gdvAttributes":
            if (argus[7].toLowerCase() != "yes") {
                $("#<%= lblAttrFormHeading.ClientID %>").html("Edit Item Attribute: '" + argus[3] + "'");
                if (argus[7].toLowerCase() != "yes") {
                    $(".delbutton").attr("id", 'attributeid' + argus[0]);
                    $(".delbutton").show();
                    $('#activeTR').show();
                } else {
                    $(".delbutton").hide();
                    $('#activeTR').hide();
                }
                $("#btnSaveAttribute").attr("name", argus[0]);
                onInit();
                //GlobalClearGrid('gdvAttributes');
                //offset_ = argus[1];
                //current_ = argus[2];

                var functionName = 'GetAttributeDetailsByAttributeID';
                var params = { attributeId: argus[0], storeId: storeId, portalId: portalId, userName: userName };
                var mydata = JSON2.stringify(params);

                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
                    data: mydata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        FillForm(msg);
                        $('#divAttribGrid').hide();
                        $('#divAttribForm').show();
                    },
                    error: function() {
                        csscody.error('<h1>Error Message</h1><p>Failed to edit attributes</p>');
                    }
                });
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t edit System Attribute.</p>');
            }
            break;
        default:
            break;
        }
    }

    function FillForm(response) {
        $.each(response.d, function(index, item) {

            $('#txtAttributeName').val(item.AttributeName);
            $('#ddlAttributeType').val(item.InputTypeID);
            $('#ddlAttributeType').attr('disabled', 'disabled');

            FillDefaultValue(item.DefaultValue);
            //$('#txtDefaultValue').val(item.DefaultValue);

            $('#ddlTypeValidation').val(item.ValidationTypeID);
            $('#txtLength').val(item.Length);
            $('#txtAliasName').val(item.AliasName);
            $('#txtAliasToolTip').val(item.AliasToolTip);
            $('#txtAliasHelp').val(item.AliasHelp);
            $('#txtDisplayOrder').val(item.DisplayOrder);

            $('input[name=chkUniqueValue]').attr('checked', item.IsUnique);
            $('input[name=chkValuesRequired]').attr('checked', item.IsRequired);
            $('input[name=chkActive]').attr('checked', item.IsActive);

            //Next Tab
            $('input[name=chkIsEnableEditor]').attr('checked', item.IsEnableEditor);
            //$('input[name=chkShowInSearch]').attr('checked', item.ShowInSearch);
            //$('input[name=chkShowInGrid]').attr('checked', item.ShowInGrid);
            $('input[name=chkUseInAdvancedSearch]').attr('checked', item.ShowInAdvanceSearch);
            //$('input[name=chkVisibleOnFrontend]').attr('checked', item.ShowInGrid);
            //$('input[name=chkUsedInItemListing]').attr('checked', item.IsActive);
            //chkComparable chkUseForPriceRule chkUseForPromoRule chkUseForRating
            $('input[name=chkComparable]').attr('checked', item.ShowInComparison);
            $('input[name=chkUseForPriceRule]').attr('checked', item.IsIncludeInPriceRule);
            //$('input[name=chkUseForPromoRule]').attr('checked', item.IsIncludeInPromotions);
            //$('input[name=chkIsEnableSorting]').attr('checked', item.IsEnableSorting);
            //$('input[name=chkIsUseInFilter]').attr('checked', item.IsUseInFilter);
            //$('input[name=chkUseForRating]').attr('checked', item.IsShownInRating);

            ValidationTypeEnableDisable(item.FillOptionValues, false);

            //BindAttributeOptionsValues(item.FillOptionValues);

            if (item.ItemTypes.length > 0) {
                $('#ddlApplyTo').val('1');
                $('.itemTypes').show();
                var itemsType = item.ItemTypes;
                var arr = itemsType.split(",");
                $.each(arr, function(i) {
                    $("#lstItemType option[value=" + arr[i] + "]").attr("selected", "selected");
                });
            } else {
                $('#ddlApplyTo').val('0');
            }
        });
    }

    function BindAttributeOptionsValues(_fillOptionValues) {
        var _fillOptions = _fillOptionValues;
        if (_fillOptions != undefined && _fillOptions != "") {
            var arr = _fillOptions.split("!#!");
            var htmlContent = '';
            $.each(arr, function(i) {
                var btnOption = "Add More";
                var btnName = "AddMore";
                if (i > 0) {
                    btnOption = "Delete Option";
                    var btnName = "DeleteOption";
                }
                var arr2 = arr[i].split("#!#");
                var cloneRow = $('#dataTable tbody>tr:last').clone(true);
                $(cloneRow).find("input").each(function(j) {
                    if (this.name == "value") {
                        $(this).val(arr2[0]);
                    } else if (this.name == "position") {
                        $(this).val(arr2[1]);
                    } else if (this.name == "Alias") {
                        $(this).val(arr2[2]);
                    } else if ($(this).hasClass("class-isdefault")) {
                        this.checked = Boolean.parse(arr2[3]);
                    } else if ($(this).hasClass("AddOption")) {
                        $(this).attr("name", btnName);
                        $(this).attr("value", btnOption);
                    }
                });
                $(cloneRow).appendTo("#dataTable");
            });
            $('#dataTable>tbody tr:first').remove();
        }
    }

    Boolean.parse = function(str) {
        switch (str) {
        case "1":
            return true;
        case "0":
            return false;
        default:
        //throw new Error("Boolean.parse: Cannot convert string to boolean.");
        }
    };

    function FillDefaultValue(defaultVal) {
        var selectedAttributeType = $("#ddlAttributeType :selected").val();
        switch (selectedAttributeType) {
        case "1":
            $('#default_value_text').val(defaultVal);
            break;
        case "2":
            $('textarea#default_value_textarea').val(defaultVal);
            break;
        case "3":
                //var formattedDate = formatDate(new Date(DateDeserialize(defaultVal)), "yyyy/M/d");
            $('#default_value_date').val(defaultVal);
            break;
        case "4":
            $('#default_value_yesno').val(defaultVal);
            break;
        case "8":
            $('#default_value_text').val(defaultVal);
            break;
        default:
            break;
        }
    }

    function DateDeserialize(dateStr) {
        return eval('new' + dateStr.replace( /\//g , ' '));
    }

    function DeleteAttributes(tblID, argus) {
        switch (tblID) {
        case "gdvAttributes":
            if (argus[3].toLowerCase() != "yes") {
                DeleteAttribute(argus[0], storeId, portalId, userName);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t delete System Attribute.</p>');
            }
            break;
        default:
            break;
        }
    }

    //    function ViewAttributes(tblID, argus) {
    //        switch (tblID) {
    //            case "gdvAttributes":
    //                alert(argus);
    //                break;
    //            default:
    //                break;
    //        }
    //    }

    function ActiveAttributes(tblID, argus) {
        switch (tblID) {
        case "gdvAttributes":
            if (argus[3].toLowerCase() != "yes") {
                ActivateAttribute(argus[0], storeId, portalId, userName, true);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t activate System Attribute.</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeactiveAttributes(tblID, argus) {
        switch (tblID) {
        case "gdvAttributes":
            if (argus[3].toLowerCase() != "yes") {
                ActivateAttribute(argus[0], storeId, portalId, userName, false);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t deactivate System Attribute.</p>');
            }
            break;
        default:
            break;
        }
    }

    function onInit() {
        SetFirstTabActive();
        $("#ddlApplyTo").val('0');
        $('.itemTypes').hide();
        $('#btnReset').hide();
        $('.cssClassRight').hide();
        $('.cssClassError').hide();
        $("#lstItemType").each(function() {
            $("#lstItemType option").removeAttr("selected");
        });
        //$("#txtAttributeName").focus();
    }

    function SetFirstTabActive() {
        var $tabs = $('#container-7').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function BindAttributesInputType() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributesInputTypeList",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#ddlAttributeType").get(0).options.length = 0;
                //$("#ddlAttributeType").get(0).options[0] = new Option("Select Type", "-1");

                $.each(msg.d, function(index, item) {
                    $("#ddlAttributeType").get(0).options[$("#ddlAttributeType").get(0).options.length] = new Option(item.InputType, item.InputTypeID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attributes input type</p>');
            }
        });
    }

    function BindAttributesValidationType() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributesValidationTypeList",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    $("#ddlTypeValidation").get(0).options[$("#ddlTypeValidation").get(0).options.length] = new Option(item.ValidationType, item.ValidationTypeID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load validation type</p>');
            }
        });
    }

    function BindAttributesItemType() {
        var params = { storeId: storeId, portalId: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributesItemTypeList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $('#lstItemType').get(0).options.length = 0;
                $('#lstItemType').attr('multiple', 'multiple');
                $('#lstItemType').attr('size', '5');
                //$('#lstItemType').removeAttr('multiple');
                $.each(msg.d, function(index, item) {
                    $("#lstItemType").get(0).options[$("#lstItemType").get(0).options.length] = new Option(item.ItemTypeName, item.ItemTypeID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attributes item type</p>');
            }
        });
    }

    function SearchAttributeName() {
        var attributeNm = $.trim($("#txtSearchAttributeName").val());
        var required = $.trim($('#ddlIsRequired').val()) == "" ? null : $.trim($('#ddlIsRequired').val()) == "True" ? true : false;
        var SearchComparable = $.trim($("#ddlComparable").val()) == "" ? null : $.trim($("#ddlComparable").val()) == "True" ? true : false;
        var isSystem = $.trim($("#ddlIsSystem").val()) == "" ? null : $.trim($("#ddlIsSystem").val()) == "True" ? true : false;
        if (attributeNm.length < 1) {
            attributeNm = null;
        }
        BindAttributeGrid(attributeNm, required, SearchComparable, isSystem);
    }
</script>

<!-- Grid -->
<div id="divAttribGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrGridHeading" runat="server" Text="Manage Attributes"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNew">
                            <span><span>Add New Attribute</span> </span>
                        </button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
                <div class="cssClassClear">
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
                                    Attribute Name:</label>
                                <input type="text" id="txtSearchAttributeName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Required:</label>
                                <select id="ddlIsRequired" class="cssClassDropDown">
                                    <option value="">-- All --</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Comparable:</label><select id="ddlComparable" class="cssClassDropDown">
                                                           <option value="">-- All --</option>
                                                           <option value="True">Yes</option>
                                                           <option value="False">No</option>
                                                       </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Is System:</label>
                                <select id="ddlIsSystem" class="cssClassDropDown">
                                    <option value="">-- All --</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchAttributeName() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxAttributeImageLoader" />
                </div>
                <div class="log">
                </div>
                <table id="gdvAttributes" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End of Grid -->
<!-- form -->
<div id="divAttribForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrFormHeading" runat="server" Text="General Information"></asp:Label>
            </h2>
        </div>
        <div class="cssClassTabPanelTable">
            <div id="container-7">
                <ul>
                    <li><a href="#fragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="Attribute Properties"></asp:Label>
                        </a></li>
                    <li><a href="#fragment-2">
                            <asp:Label ID="lblTabTitle2" runat="server" Text="Frontend Properties"></asp:Label>
                        </a></li>
                </ul>
                <div id="fragment-1">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab1Info" runat="server" Text="General Information"></asp:Label>
                        </h3>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblAttributeName" runat="server" Text="Attribute Name:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="text" id="txtAttributeName" class="cssClassNormalTextBox">
                                    <span class="cssClassRight">
                                        <img class="cssClassSuccessImg" height="13" width="18" title="Right" alt="Right"></span>
                                    <b class="cssClassError">Ops! found something error, must be unique with no spaces</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblType" runat="server" Text="Type:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <select id="ddlAttributeType" class="cssClassDropDown" title="Attribute Input Type">
                                    </select>
                                </td>
                            </tr>
                            <tr id="trdefaultValue">
                                <td>
                                    <asp:Label ID="lblDefaultValue" runat="server" Text="Default Value:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="text" class="cssClassNormalTextBox" title="Default Value" value="" name="default_value_text"
                                           id="default_value_text">
                                    <div id="fileDefaultTooltip" style="display: none;" class="cssClassRed">
                                    </div>
                                    <textarea class="cssClassTextArea" cols="15" rows="2" title="Default Value" name="default_value_textarea"
                                              id="default_value_textarea"></textarea>
                                    <div id="div_default_value_date">
                                        <input type="text" class="cssClassNormalTextBox" title="Default Value" value="" id="default_value_date"
                                               name="default_value_date">
                                    </div>
                                    <select class="cssClassDropDown" title="Default Value" name="default_value_yesno"
                                            id="default_value_yesno">
                                        <option value="1">Yes</option>
                                        <option selected="selected" value="0">No</option>
                                    </select>
                                </td>
                            </tr>
                            <tr id="trOptionsAdd">
                                <td>
                                    <asp:Label ID="lblAddOptions" runat="server" Text="Manage Options (values of your attribute):"
                                               CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <table id="dataTable" cellspacing="0" cellpadding="0" border="0" width="100%">
                                        <thead>
                                            <tr>
                                                <th>
                                                    <asp:Label ID="lblValue" runat="server" Text="Value" CssClass="cssClassLabel"></asp:Label>
                                                </th>
                                                <th>
                                                    <asp:Label ID="lblPosition" runat="server" Text="Display Order" CssClass="cssClassLabel"></asp:Label>
                                                </th>
                                                <th>
                                                    <asp:Label ID="lblAlias" runat="server" Text="Alias" CssClass="cssClassLabel"></asp:Label>
                                                </th>
                                                <th>
                                                    <asp:Label ID="lblIsDefault" runat="server" Text="Is Default" CssClass="cssClassLabel"></asp:Label>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tr>
                                            <td>
                                                <input type="text" class="class-text" value="" name="value"/>
                                            </td>
                                            <td>
                                                <input type="text" class="class-text" value="" name="position"/>
                                            </td>
                                            <td>
                                                <input type="text" class="class-text" value="" name="Alias" />
                                            </td>
                                            <td id="tddefault">
                                            </td>
                                            <td>
                                                <input type="Button" value="Add More" name="AddMore" class="AddOption cssClassButtonSubmit">
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblUniqueValue" runat="server" Text="Unique Value:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUniqueValue" value="" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTypeValidation" runat="server" Text="Type Validation:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <select id="ddlTypeValidation" class="cssClassDropDown" name="" title="Attribute Input Validation Type">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblValuesRequired" runat="server" Text="Values Required:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkValuesRequired" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblApplyTo" runat="server" Text="Apply To:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <select id="ddlApplyTo" class="cssClassDropDown" name="">
                                        <option selected="selected" value="0">All Item Types</option>
                                        <option value="1">Selected Item Types</option>
                                    </select>
                                </td>
                            </tr>
                            <tr class="itemTypes">
                                <td>
                                    &nbsp;
                                </td>
                                <td class="cssClassTableRightCol">
                                    <select id="lstItemType" class="cssClassMultiSelect">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblLength" runat="server" Text="Length:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input class="cssClassNormalTextBox" id="txtLength" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAliasName" runat="server" Text="Alias Name:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input class="cssClassNormalTextBox" id="txtAliasName" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAliasToolTip" runat="server" Text="Alias ToolTip:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input class="cssClassNormalTextBox" id="txtAliasToolTip" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAliasHelp" runat="server" Text="Alias Help:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input class="cssClassNormalTextBox" id="txtAliasHelp" type="text">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDisplayOrder" runat="server" Text="Display Order:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input class="cssClassNormalTextBox" id="txtDisplayOrder" type="text">
                                </td>
                            </tr>
                            <tr id="activeTR">
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
                <div id="fragment-2">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab2Info" runat="server" Text="Frontend Display Settings"></asp:Label>
                        </h3>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblIsEnableEditor" runat="server" Text="Is Enable Editor:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkIsEnableEditor" class="cssClassCheckBox" />
                                </td>
                            </tr>
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
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShowInSearch" runat="server" Text="Use in Search:" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkShowInSearch" class="cssClassCheckBox" />
                                </td>
                            </tr>--%>
                            <tr>
                                <td>
                                    <asp:Label ID="lblUseInAdvancedSearch" runat="server" Text="Use in Advanced Search:"
                                               CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="checkbox" name="chkUseInAdvancedSearch" class="cssClassCheckBox" />
                                </td>
                            </tr>
                            <tr>
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
                            </tr>
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
                        </table>
                    </div>
                </div>
            </div>
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
                <button type="button" class="delbutton">
                    <span><span>Delete Attribute</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSaveAttribute">
                    <span><span>Save Attribute</span></span></button>
            </p>
        </div>
    </div>
</div>
<!-- End form -->