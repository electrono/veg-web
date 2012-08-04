<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CatalogPriceRule.ascx.cs"
            Inherits="Modules_ASPXCatalogPricingRule_CatalogPriceRule" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var plusButtonTemplate = '';
    var masterConditionTemplate = '';
    var pricingRuleTemplate = new Array();
    var clickonce = 0;

    function JSONDateToString(jsonDate, dateFormat) {
        if (jsonDate) {
            var dateStr = 'new ' + jsonDate.replace( /[/]/gi , '');
            var date = eval(dateStr);
            return formatDate(date, dateFormat);
        } else {
            return jsonDate;
        }
    }

    $(function() {
        LoadStaticImage();
        GetPricingRules(null, null, null, null);
        GetRoles();
        InitializePricingRuleConditions();
        $('#CatalogPriceRule-TabContainer').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        HideShowPrincingRulePanel(true, false);
        $("#CatalogPriceRule-txtFromDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#CatalogPriceRule-txtToDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtPricingRuleStartDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtPricingRuleEndDate").datepicker({ dateFormat: 'yy/mm/dd' });

        var v = $("#form1").validate({
        //  event: "keyup,change",
            rules: {
                Description: {
                    required: true
                },
                Priority: {
                    required: true,
                    number: true
                },
                Value: {
                    required: true,
                    number: true
                }
            },
            submitHandler: function() {

            }
        });

        $("#btnSavePricingRule").click(function() {

            if (v.form()) {

                if (Date.parse($('.from').val()) >= Date.parse($('.to').val())) {
                    $('.to').parents('td').find('input').css({ "background-color": "#FCC785" });
                    $('#created').html('').html('To Date Must be higher Than From Date');
                    SetTabActive(0, "CatalogPriceRule-TabContainer");

                } else {
                    $('#created').html('');
                    $('.to').parents('td').find('input').attr("style", '');
                    if (clickonce == 0) {
                        clickonce++;
                        var pricingRuleID = $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val().replace( /[^0-9]/gi , '') * 1;
                        if (!CheckPriorityUniqueness(pricingRuleID)) {
                            $("#priority").html("priority already assigned.");
                            $('#CatalogPriceRule-txtPriority').removeClass('valid').addClass('error');
                            clickonce = 0;
                            var errorCatalogTab = $("#CatalogPriceRule-TabContainer").find('div .error').not('label').parents('div:eq(0)');
                            if (errorCatalogTab.length > 0) {
                                var errorCatalogTabName = errorCatalogTab.attr('id');
                                var $tabs = $('#CatalogPriceRule-TabContainer').tabs();
                                $tabs.tabs('select', errorCatalogTabName);
                            }
                            return false;
                        } else {
                            $('#CatalogPriceRule-txtPriority').removeClass('valid').removeClass('error');
                            $("#priority").html("");
                            SavePricingRule();
                        }
                    }
                }
            } else {
                //FOR Catalog Rule TAB
                var errorCatalogTab = $("#CatalogPriceRule-TabContainer").find('div .error').not('label').parents('div:eq(0)');
                if (errorCatalogTab.length > 0) {
                    var errorCatalogTabName = errorCatalogTab.attr('id');
                    var $tabs = $('#CatalogPriceRule-TabContainer').tabs();
                    $tabs.tabs('select', errorCatalogTabName);
                }
            }
        });

        $('#CatalogPriceRule-txtPriority').keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#priority").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#CatalogPriceRule-txtToDate").bind("change", function() {
            $('#created').html('');
            $('.to').parents('td').find('input').attr("style", '');
            $(this).removeClass('error');
            $('.to').parents('td').find('label').remove();

        });
        $("#CatalogPriceRule-txtFromDate").bind("change", function() {
            if ($(this).val() != "") {
                $('#created').html('');
                $('.to').parents('td').find('input').attr("style", '');
                $(this).removeClass('error');
                $('.to').parents('td').find('label').remove();
            }
            $(this).removeClass('error');
            $('.from').parents('td').find('label').remove();

        });


        $('#btnDeleteCatRules').click(function() {
            var catRule_ids = '';
            $(".attrCatPricingChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    catRule_ids += $(this).val() + ',';
                }
            });
            if (catRule_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        CatPricingRulesMultipleDelete(catRule_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Catalog Rules?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Catalog Rule before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        })

        $("#btnAddNewCatRule").click(function() {
            AddPricingRule();
        });

        (function($) {
            $.fn.numeric = function(options) {
                return this.each(function() {
                    var $this = $(this);
                    $this.keypress(options, function(e) {
                        // allow backspace and delete 
                        if (e.which == 8 || e.which == 0 || e.which == 46)
                            return true;
                        //if the letter is not digit 
                        if (e.which < 48 || e.which > 57)
                            return false;
                        // check max range 
                        var dest = e.which - 48;
                        var result = this.value + dest.toString();
                        if (result > e.data.max) {
                            return false;
                        }
                    });
                });
            };
        })(jQuery);
        $("#CatalogPriceRule-txtValue").keypress(function() {
            if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
            }
        });

        $("#CatalogPriceRule-cboApply").change(function() {
            if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                $('#CatalogPriceRule-txtValue').unbind();
                $('#CatalogPriceRule-txtValue').numeric({ max: 100 });
                $('#CatalogPriceRule-txtValue').attr("maxlength", "5");
                $('#CatalogPriceRule-txtValue').bind('select', function() {
                    $(this).val('');
                });
                bindfocusout();
                if ($("#CatalogPriceRule-txtValue").val() >= 100) {
                    $("#CatalogPriceRule-txtValue").val('');
                }
            } else {
                $('#CatalogPriceRule-txtValue').unbind();
                $('#CatalogPriceRule-txtValue').attr("maxlength", "8");
                // $('#CatalogPriceRule-txtValue').numeric({ max: 99999999 });
                bindfocusout();
            }

        });

        $("#CatalogPriceRule-txtValue").change(function() {
            if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                $('#CatalogPriceRule-txtValue').unbind();
                $('#CatalogPriceRule-txtValue').numeric({ max: 100 });
                $('#CatalogPriceRule-txtValue').attr("maxlength", "5");
                $('#CatalogPriceRule-txtValue').bind('select', function() {
                    $(this).val('');
                });
                bindfocusout();
                if ($("#CatalogPriceRule-txtValue").val() >= 100) {
                    $("#CatalogPriceRule-txtValue").val('');
                }
            } else {
                $('#CatalogPriceRule-txtValue').unbind();
                $('#CatalogPriceRule-txtValue').attr("maxlength", "8");
                //  $('#CatalogPriceRule-txtValue').numeric({ max: 99999999 });
                bindfocusout();

            }

        });

        if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
            $('#CatalogPriceRule-txtValue').unbind();
            $('#CatalogPriceRule-txtValue').numeric({ max: 100 });
            $('#CatalogPriceRule-txtValue').attr("maxlength", "5");
            $('#CatalogPriceRule-txtValue').bind('select', function() {
                $(this).val('');
            });
            bindfocusout();
        } else {
            $('#CatalogPriceRule-txtValue').attr("maxlength", "8");
            // $('#CatalogPriceRule-txtValue').numeric({ max: 99999999 });
        }
        // $('#CatalogPriceRule-txtPriority').numeric({ max: 999 });
        bindfocusout();

    });

    function bindfocusout() {

        $("#CatalogPriceRule-txtValue").focusout(function() {
            if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
                if ($("#CatalogPriceRule-txtValue").val() >= 100) {
                    $("#CatalogPriceRule-txtValue").val('');
                    $("#percError").show();
                    $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                }
            }
        });
    }

    function LoadStaticImage() {
        $('#ajaxCatalogPriceImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function CatPricingRulesMultipleDelete(catRule_ids, event) {
        if (event) {
            var params = { catRulesIds: catRule_ids, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleCatPricingRules",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetPricingRules(null, null, null, null);
                }
            });
        }
        return false;
    }

    function Edit(obj) {
        $(self).closest('.cssClassFieldSetLabel').val($(self).val());
        $(obj).parent('SPAN').addClass("cssClassOnClickEdit");
        $(obj).siblings('SELECT').val();
        $(obj).siblings('SELECT').focus();
        $(obj).parent().find('a.cssClassOnClickApply').html('<span class="cssClassRightGreen"></span>');
    }

    function GetDropdownValue(self) {
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        $(self).siblings('input').val($(self).val());
        $(self).parent().parent('SPAN').find("a.cssClassFieldSetLabel").html($(self).val());
    }

    function GetDropdownText(self) {
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        var selectedText = $(self).find("option:selected").text();
        $(self).siblings('input').val($(self).find("option:selected").text());
        $(self).parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(selectedText);
        $(self).parent().parent('SPAN').find('a.cssClassFieldSetLabel').attr('title', $(self).val());

        if ($(self).attr('title') != "" && $(self).attr('title') != "operator" && $(self).attr('title') != "aggregator" && $(self).attr('title') != "value" && $(self).attr('title') != "type" && $(self).attr('title') != "attribute") {
            $(self).parents('li:eq(0)').next('li').find('span a:eq(0)').html($(self).parents('li').next('li:eq(0)').find('span select:first option:selected').text());
        }
    }

    function GetTextBoxValue(self) {
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        var val = $(self).parent().parent('SPAN').find("input.input-text").val();
        val = $.trim(val);
        $(self).parent().parent('SPAN').find("input.input-text").val(val);
        if (val != null && val.length > 0) {
            $(self).siblings('input').val(val);
            $(self).parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(val);
        }
        ValidateConditionFields($(self));
    }

    function ValidateConditionFields(obj) {
        if (parseInt($(obj).closest('li').find('input[title="attribute"]').val()) == 8 || parseInt($(obj).closest('li').find('input[title="attribute"]').val()) == 13 || parseInt($(obj).closest('li').find('input[title="attribute"]').val()) == 15 || parseInt($(obj).closest('li').find('input[title="attribute"]').val()) == 5) {
            var inputVal = $(obj).parent().parent('SPAN').find("input.input-text").val();
            var numericReg = /^\d*[0-9](|.\d*[0-9]|,\d*[0-9])?$/ ;
            if (!numericReg.test(inputVal)) {
                alert('Please Enter Numeric characters only.');
                return false;
            }
        }
    }

    function GetMultipleValue(self) {
        var multiSelectObject = $(self);
        var selectedValue = '';
        var selectedText = '';
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        for (var i = 0; i < self.options.length; i++) {
            if (self.options[i].selected == true) {
                selectedValue += ' ' + self.options[i].value + ',';
                selectedText += ' ' + self.options[i].text + ',';
            }
        }
        if (selectedValue.length > 0) {
            selectedValue = selectedValue.substring(0, selectedValue.length - 1);
            selectedText = selectedText.substring(0, selectedText.length - 1);
        }
        $(self).parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(selectedText);
        $(self).siblings('input').val(selectedValue);
    }

    function GetRoles() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + 'GetAllRoles',
            data: JSON2.stringify({ isActive: 1, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                var options = '';
                $.each(response.d, function(i, item) {
                    options += '<option value="' + item.RoleID + '"> ' + item.RoleName + ' </option>';
                });
                $("#CatalogPriceRule-mulRoles").html(options);
            }
        });
    }

    function GetCategoryValue(self) {
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        var selectedCategories = '';
        $(self).siblings('div.pricingRuleCategoryList').find('ul').each(function(i, item) {
            $(this).find('li').each(function(j, li) {
                if ($(this).hasClass("selected")) {
                    var cat_id = $(this).attr("class").replace( /[^0-9]/gi , '');
                    selectedCategories += ' ' + cat_id + ',';
                }
            });
        });
        if (selectedCategories.length > 0) {
            selectedCategories = selectedCategories.substring(0, selectedCategories.length - 1);
        }
        //$(self).parent().find('input').val(selectedCategories);
        $(self).parent().parent().find("a.cssClassFieldSetLabel").attr('title', selectedCategories);
    }

    function ConditionSelected(self) {
        var priority = $(self).closest('ul').find('>li').length;
        var path = $(self).attr("title");
        var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: ($(self).attr("title") * 1 + 1), AttributeID: $(self).val(), value: "", valueText: "..." }];
        if ($(self).val() == "35") {
            $("#PricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
            $(self).closest('li').parent().find(".MultipleSelectBox_PricingRule").multipleSelectBox(
                {
                    onSelectEnd: function(e, resultList) {
                        $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                        $(this).parent().siblings('input').val(resultList.join(", "));
                    }
                });
            Delete(self);
        } else if ($(self).val() == 0) {
            GetDropdownValue(self);
            $("#PricingRuleTemplate_master").render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
            Delete(self);
        } else if ($(self).val() > 0) {
            $("#PricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
            GetDropdownText(self);
            $(self).closest('li').parent().find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });
            Delete(self);
        } else {
            $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        }
    }

    function Delete(self) {
        $(self).closest('li').remove();
    }

    function InitializePricingRuleConditions() {
        var treeHTML = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + 'GetCategoryAll',
            data: JSON2.stringify({ isActive: true, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                CategoryList = data.d;
                treeHTML += '<ul class="MultipleSelectBox_PricingRule">';
                var deepLevel = 0;
                $.each(CategoryList, function(i, item) {
                    if (item.CategoryLevel == 0) {
                        treeHTML += '<li class="category_' + item.CategoryID + '" style="padding-left:' + item.CategoryLevel * 15 + 'px;">' + item.CategoryName + '</li>';
                        htmlChild = BindTreeViewChild(item.CategoryID, item.CategoryName, item.CategoryID, item.CategoryLevel + 1, deepLevel);
                        if (htmlChild != "") {
                            treeHTML += htmlChild;
                        }
                        treeHTML += "";
                    }
                });
                treeHTML += '</ul>';

                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/" + 'GetPricingRuleAttributes',
                    data: JSON2.stringify({ isActive: 1, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(response) {
                        var template = '';
                        masterConditionTemplate = '<li><input type="hidden" name="{{= ChildRulePath }}" title="type" value="combination" /> If <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)">ALL</a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="ALL" selected="selected">ALL</option><option value="ANY">ANY</option></select></span></span>&nbsp; of these conditions are <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)">TRUE</a><span class="cssClassElement"><select name="value_{{= ChildRulePath }}" title="value" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="TRUE" selected="selected">TRUE</option><option value="FALSE">FALSE</option></select></span></span>&nbsp;: <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span><ul class="cssClassOnClickChildren" id=""><li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= ChildRulePath }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';
                        plusButtonTemplate = '<li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= Level }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';

                        //---------------- Category Template --------------------------------------
                        plusButtonTemplate += '<option value="35"> Category </option>';
                        masterConditionTemplate += '<option value="35"> Category </option>';
                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="35"/> Category <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        template += '<div class="pricingRuleCategoryList">' + treeHTML + '</div><a href="#" class="cssClassOnClickApply" onclick="GetCategoryValue(this)"><span class="cssClassRightGreen"></span></a></span></span><span class="cssClassOnClick"><a href="javascript:void(0)" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        template = '<script id="PricingRuleTemplate_35" type="text/html">' + template + '<\/script>';
                        $('#placeholder-templates').append(template);
                        //------------------------- End of Category Template -------------------------------
                        //<input  class="element-value-changer input-text" name="value_{{= RulePath }}" title="value" value="{{= value }}" />
                        $.each(response.d, function(i, item) {
                            var options = '';
                            var operators = '';
                            var template = '';
                            plusButtonTemplate += '<option value="' + item.AttributeID + '"> ' + item.AttributeNameAlias + ' </option>';
                            masterConditionTemplate += '<option value="' + item.AttributeID + '"> ' + item.AttributeNameAlias + ' </option>';

                            if (item.InputTypeID == 1) //TextBox, Qty
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="{{= AttributeID}}"/>' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" name="operator_{{= RulePath }}" id="operator_{{= RulePath }}" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        if (item.AttributeID != 1 || item.AttributeID != 4) {
                                            if (i < 2 || i > 5) { //To NOT bind {value:3,text:"Equals or Greater Than"},{value:4,text:"Equals or Less Than"},{value:5,text:"Greater Than"},{value:6,text:"Less Than"},
                                                var val = oprts[i];
                                                if (i == 0) {
                                                    operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                                } else {
                                                    operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                                }
                                            }
                                        }
                                    }
                                }
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            } else if (item.InputTypeID == 2) //TextArea
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="{{= AttributeID}}"/>' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" name="operator_{{= RulePath }}" id="operator_{{= RulePath }}" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        var val = oprts[i];
                                        if (i == 0) {
                                            operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                        } else {
                                            operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                        }
                                    }
                                }
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            } else if (item.InputTypeID == 7) //Price
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="{{= AttributeID}}"/>' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" name="operator_{{= RulePath }}" id="operator_{{= RulePath }}" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        var val = oprts[i];
                                        if (i == 0) {
                                            operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                        } else {
                                            operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                        }
                                    }
                                }
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            } else if (item.InputTypeID == 3) //Date
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" id="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" id="attribute_{{= RulePath }}" title="attribute" value="{{= AttributeID}}"/>' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        var val = oprts[i];
                                        operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                    }
                                }
                                var d = new Date();
                                template += operators + '</select> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> ' + d.getFullYear() + '/' + (d.getMonth() * 1 + 1) + '/' + d.getDate() + ' </a><span class="cssClassElement"><input class="element-value-changer input-text datepicker" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            } else if (item.InputTypeID == 4 || item.InputTypeID == 6 || item.InputTypeID == 9 || item.InputTypeID == 10) //DropDown
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" id="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" id="attribute_{{= RulePath }}" value="{{= AttributeID}}" title="attribute" />' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> IS </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        var val = oprts[i];
                                        if (i == 0) {
                                            operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                        } else {
                                            operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                        }
                                    }
                                }
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><select class="element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)">';
                                var opts = eval(item.Values);
                                if (opts != undefined && opts.length > 0) {
                                    for (var i = 0; i < opts.length; i++) {
                                        var val = opts[i];
                                        options += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                    }
                                }
                                template += options + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            } else if (item.InputTypeID == 5 || item.InputTypeID == 11 || item.InputTypeID == 12) //MultiSelect
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" id="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" id="attribute_{{= RulePath }}" value="{{= AttributeID}}" title="attribute" />' + item.AttributeNameAlias + ' <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        var val = oprts[i];
                                        if (i == 0) {
                                            operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                        } else {
                                            operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                        }
                                    }
                                }
                                template += operators + '</select></span></span> &nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><select class="element-value-changer select" multiple="multiple"   onblur="GetMultipleValue(this)">';
                                var opts = eval(item.Values);
                                if (opts != undefined && opts.length > 0) {
                                    for (var i = 0; i < opts.length; i++) {
                                        var val = opts[i];
                                        options += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                    }
                                }
                                template += options + '</select><a href="#" class="cssClassOnClickApply"></span></span><span class="cssClassOnClick"><a href="javascript:void(0)" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'

                                template = '<script id="PricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            }
                        });
                        plusButtonTemplate += '</optgroup></select></span></span>&nbsp;</li>';
                        masterConditionTemplate += '</optgroup></select></span></span></li></ul></li>';
                        masterConditionTemplate = '<script id="PricingRuleTemplate_master" type="text/html">' + masterConditionTemplate + '<\/script>';
                        $('#placeholder-templates').append(masterConditionTemplate);
                        plusButtonTemplate = '<script id="PricingRuleTemplate_plus" type="text/html">' + plusButtonTemplate + '<\/script>';
                        $('#placeholder-templates').append(plusButtonTemplate);
                        var ruleInfo = [{ Level: 0, RulePath: 0, value: "", valueText: "..." }];
                        $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo('.cssClassOnClickChildren');
                    }
                });
            },
            error: function(err) {
                csscody.error('<h1>Error Message</h1><p>' + JSON2.stringify(err) + '</p>');
            }
        });
        return treeHTML;
    }

    function BindTreeViewChild(CategoryID, CategoryName, ParentID, CategoryLevel, deepLevel) {
        deepLevel = deepLevel + 1;
        var hasChild = false;
        var html = '';
        $.each(CategoryList, function(index, item) {
            if (item.CategoryLevel == CategoryLevel) {
                if (item.ParentID == ParentID) {
                    html += '<li class="category_' + item.CategoryID + '" style="padding-left:' + item.CategoryLevel * 10 + 'px;">' + item.CategoryName + '</li>';
                    htmlChild = BindTreeViewChild(item.CategoryID, item.CategoryName, item.CategoryID, item.CategoryLevel + 1, deepLevel);
                    if (htmlChild != "") {
                        html += htmlChild;
                    }
                }
            }
        });
        return html;
    }

    function isObject(x) {
        switch (typeof x) {
        case "function":
            return false;
        case "object":
            if (x != null)
                return true;
            else
                return false;
            break;
        default:
            return false;
        }
    }

    function isFunction(x) {
        switch (typeof x) {
        case "function":
            return true;
        case "object":
            if ("function" !== typeof x.toString)
                return (x + "").match( /function/ ) !== null;
            else
                return Object.prototype.toString.call(x) === "[object Function]";
            break;
        default:
            return false;
        }
    }

    function SavePricingRule() {
        var pricingRuleID = $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val().replace( /[^0-9]/gi , '') * 1;
        var txtName = $('#CatalogPriceRule-txtName').val();
        var txtDescription = $('#CatalogPriceRule-txtDescription').val();
        var lstCartPriceRuleRole = [];
        $('#CatalogPriceRule-mulRoles option:selected').each(function(i, option) {
            lstCartPriceRuleRole[i] = { CatalogPriceRuleID: pricingRuleID, RoleID: $(option).val() };
        });
        var txtFromDate = $('#CatalogPriceRule-txtFromDate').val();
        var txtToDate = $('#CatalogPriceRule-txtToDate').val();
        var txtPriority = $('#CatalogPriceRule-txtPriority').val() * 1;
        var chkIsActive = $('#CatalogPriceRule-chkIsActive').attr('checked') ? true : false;
        var ddlApply = $('#CatalogPriceRule-cboApply').val() * 1;
        var txtApplyValue = $('#CatalogPriceRule-txtValue').val().replace( /[^0-9.]/gi , '');
        var chkIsFurtherProcess = $('#CatalogPriceRule-chkFurtherRuleProcessing').attr('checked') ? true : false;
        var isAll = $('div.cssClassFieldSetContent > span:nth-child(1) > span > select.element-value-changer').parent().parent().find('a.cssClassFieldSetLabel').text();
        if (String(isAll).toUpperCase() == "ALL") {
            isAll = true;
        } else {
            isAll = false;
        }
        var isTrue = $('div.cssClassFieldSetContent > span:nth-child(2) > span > select.element-value-changer').parent().parent().find('a.cssClassFieldSetLabel').text();
        if (String(isTrue).toUpperCase() == "TRUE") {
            isTrue = true;
        } else {
            isTrue = false;
        }
        var lstRuleConditions = new Array();
        var lstConditionDetails = new Array();
        lstRuleConditions[lstRuleConditions.length] = { IsAll: isAll, IsTrue: isTrue, ParentID: 0, CatalogConditionDetail: lstConditionDetails };

        $.each($('div.cssClassFieldSetContent > ul > li'), function(i, listItem) {
            var type = $(listItem).find('input[title="type"]').val();
            if (String(type).toLowerCase() == 'attribute') {
                var att_op = '';
                var att_val = '';
                var att_id = $(listItem).find('input[title="attribute"]').val() * 1;

                if ($(listItem).find('a.cssClassFieldSetLabel').attr('title').length > 0)
                    att_op = $(listItem).find('a.cssClassFieldSetLabel').attr('title');
                else
                    att_op = $(listItem).find('> span > span > select[title="operator"]').val() * 1;

                if ($(listItem).find('> span > span > input[title="value"]').length > 0) {
                    att_val = $(listItem).find('> span > span > input[title="value"]').val();
                    if (att_val == "" && $(listItem).find('> span:eq(1)>span>input').hasClass('hasDatepicker')) {
                        att_val = $(listItem).find('> span:eq(1) > a').text();
                    }
                } else if ($(listItem).find('> span:eq(1) > a').attr('title').length > 0) {
                    att_val = $(listItem).find('> span:eq(1) > a').attr('title');
                }

                var name = $(listItem).find('input[title="attribute"]').attr('name');
                var nameparts = String(name).split('_');
                var attrs = nameparts[1].split('-');
                var att_priority = attrs[1] * 1;

                lstConditionDetails[i] = { AttributeID: att_id, Priority: att_priority, RuleOperatorID: att_op, Value: $.trim(att_val) };
            } else if (String(type).toLowerCase() == 'combination') {
                GetChildPricingRule(lstRuleConditions, (listItem));
            }
        });

        $('div.cssClassFieldSetContent').find('ul').each(function(index) {
            $(this).attr('id', index + 1);
        });

        var arrParent = new Array();
        arrParent.push(0);

        $('div.cssClassFieldSetContent').find('ul li').find('input[value="combination"]').each(function() {
            arrParent.push($(this).parent().parent('ul').attr('id'));
        });

        var PriceRule = {
            CatalogPriceRule: {
                CatalogPriceRuleID: pricingRuleID,
                CatalogPriceRuleName: txtName,
                CatalogPriceRuleDescription: txtDescription,
                Apply: ddlApply,
                Value: txtApplyValue,
                IsFurtherProcessing: chkIsFurtherProcess,
                FromDate: txtFromDate,
                ToDate: txtToDate,
                Priority: txtPriority,
                IsActive: chkIsActive
            }
        };

        var objCatalogPricingRule = {
            CatalogPricingRuleInfo: {
                CatalogPriceRule: PriceRule.CatalogPriceRule,
                CatalogPriceRuleConditions: lstRuleConditions,
                CatalogPriceRuleRoles: lstCartPriceRuleRole
            }
        };

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SavePricingRule",
            contentType: "application/json; charset=utf-8",
            data: JSON2.stringify({ "objCatalogPricingRuleInfo": objCatalogPricingRule.CatalogPricingRuleInfo, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName, "parentID": arrParent }),
            dataType: "json",
            success: function(response) {
                var notificationText = "";
                switch (response.d) {
                case "success":
                    notificationText = "Catalog pricing rule is saved successfully."
                    break;
                case "notify":
                    notificationText = "No more than 3 rules are allowed in Free version of AspxCommerce!"
                    break;
                }
                if (notificationText != "") {
                    alert(notificationText);
                    arrParent = new Array();
                    var jEl = $("#divMessage");
                    jEl.html(notificationText).fadeIn(1000);
                    setTimeout(function() { jEl.fadeOut(1000) }, 5000);
                    GetPricingRules(null, null, null, null);
                    SetTabActive(0, "CatalogPriceRule-TabContainer");
                    HideShowPrincingRulePanel(true, false);
                }
                clickonce = 0;
            },
            error: function(msg) {
                clickonce = 0;
            }
        });
    }

    function GetChildPricingRule(lstRuleConditions, parent) {
        var pricingRuleID = $(parent).find('input[value="combination"]').attr('name').replace( /[^0-9]/gi , '') * 1;
        var isAll = $(parent).find('> span > span > select[title="aggregator"]').parent().parent().find('a.cssClassFieldSetLabel').text();
        if (String(isAll).toUpperCase() == "ALL") {
            isAll = true;
        } else {
            isAll = false;
        }
        var isTrue = $(parent).find('> span > span > select[title="value"]').parent().parent().find('a.cssClassFieldSetLabel').text();
        if (String(isTrue).toUpperCase() == "TRUE") {
            isTrue = true;
        } else {
            isTrue = false;
        }
        var lstConditionDetails = new Array();
        lstRuleConditions[lstRuleConditions.length] = { IsAll: isAll, IsTrue: isTrue, ParentID: 0, CatalogConditionDetail: lstConditionDetails };

        $.each($(parent).find('> ul > li'), function(i, childListItem) {
            var type = $(childListItem).find('input[title="type"]').val();
            if (String(type).toLowerCase() == 'attribute') {
                var att_op = '';
                var att_val = '';
                var att_id = $(childListItem).find('input[title="attribute"]').val() * 1;

                if ($(childListItem).find('a.cssClassFieldSetLabel').attr('title').length > 0)
                    att_op = $(childListItem).find('a.cssClassFieldSetLabel').attr('title');
                else
                    att_op = $(childListItem).find('> span > span > select[title="operator"]').val() * 1;
                if ($(childListItem).find('> span > span > input[title="value"]').length > 0) {
                    att_val = $(childListItem).find('> span > span > input[title="value"]').val();
                    if (att_val == "" && $(childListItem).find('> span:eq(1)>span>input').hasClass('hasDatepicker')) {
                        att_val = $(childListItem).find('> span:eq(1) > a').text();
                    }
                } else if ($(childListItem).find('> span:eq(1) > a').attr('title').length > 0) {
                    att_val = $(childListItem).find('> span:eq(1) > a').attr('title');
                }
                var name = $(childListItem).find('input[title="attribute"]').attr('name');
                var nameparts = String(name).split('_');
                var attrs = nameparts[1].split('-');
                var att_priority = attrs[1] * 1;

                lstConditionDetails[i] = { AttributeID: att_id, Priority: att_priority, RuleOperatorID: att_op, Value: att_val };

            } else if (String(type).toLowerCase() == 'combination') {
                GetChildPricingRule(lstRuleConditions, $(childListItem))
            }
        });
    }

    function GetPricingRules(ruleNm, startDt, endDt, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCatalogPricingRules_pagesize").length > 0) ? $("#gdvCatalogPricingRules_pagesize :selected").text() : 10;

        $("#gdvCatalogPricingRules").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetPricingRules',
            colModel: [
                { display: 'Catalog Pricing Rule ID', cssclass: 'cssClassHeadCheckBox', name: 'CatalogPriceRuleID', coltype: 'checkbox', align: 'center', elemClass: 'attrCatPricingChkbox', elemDefault: false, controlclass: 'catPricingHeaderChkbox' },
                { display: 'Rule Name', name: 'CatalogPriceRuleName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'From Date', name: 'FromDate', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'To Date', name: 'ToDate', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Is Active', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', type: 'boolean', format: 'True/False', align: 'left' },
                { display: 'Priority', name: 'priority', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCatalogPricingRule', arguments: '0' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCatalogPricingRule', arguments: '0' }
            ],
            txtClass: 'cssClassNormalTextBox',
            rp: perpage,
            nomsg: "No Records Found!",
            param: { ruleName: ruleNm, startDate: startDt, endDate: endDt, isActive: isAct, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 6: { sorter: false } }
        });
    }

    function EditCatalogPricingRule(tblID, argus) {
        switch (tblID) {
        case "gdvCatalogPricingRules":
            $("#resetPricngRule").hide();
            GetPricingRuleByPricingRuleID(argus[3]);

            break;
        default:
            break;
        }
    }

    function DeleteCatalogPricingRule(tblID, argus) {
        switch (tblID) {
        case "gdvCatalogPricingRules":
            if (argus[3]) {
                var properties = { onComplete: function(e) { PricingRuleDelete(argus[0], storeId, portalId, userName, cultureName, e); } }
                csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this catalog pricing rule?</p>", properties);
            }
            break;
        default:
            break;
        }
    }

    function PricingRuleDelete(priceRuleID, storeId, portalId, userName, cultureName, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeletePricingRule",
                data: JSON2.stringify({ catalogPricingRuleID: priceRuleID, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetPricingRules(null, null, null, null);
                }
            });
        }
        return false;
    }

    function GetPricingRuleByPricingRuleID(pricingRuleID) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetPricingRule",
            contentType: "application/json; charset=utf-8",
            data: JSON2.stringify({ catalogPriceRuleID: pricingRuleID, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            dataType: "json",
            success: function(response) {
                $('div.cssClassFieldSetContent > ul > li').not('li:last').remove();
                var dsData = eval(response.d);
                var catalogPriceRule = dsData.CatalogPriceRule;
                var arrCatalogPriceRuleCondition = dsData.CatalogPriceRuleConditions;
                var arrCatalogPriceRuleRole = dsData.CatalogPriceRuleRoles;
                $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val(catalogPriceRule.CatalogPriceRuleID)
                $('#CatalogPriceRule-txtName').val(catalogPriceRule.CatalogPriceRuleName);
                $('#CatalogPriceRule-txtDescription').val(catalogPriceRule.CatalogPriceRuleDescription);
                $('#CatalogPriceRule-txtFromDate').val(JSONDateToString(catalogPriceRule.FromDate, "yyyy/MM/dd"));
                $('#CatalogPriceRule-txtToDate').val(JSONDateToString(catalogPriceRule.ToDate, "yyyy/MM/dd"));
                $('#CatalogPriceRule-txtPriority').val(catalogPriceRule.Priority);
                $('#CatalogPriceRule-chkIsActive').attr("checked", catalogPriceRule.IsActive);
                $('#CatalogPriceRule-cboApply').val(catalogPriceRule.Apply);
                $('#CatalogPriceRule-txtValue').val(catalogPriceRule.Value);
                $('#CatalogPriceRule-chkFurtherRuleProcessing').attr("checked", catalogPriceRule.IsFurtherProcessing);
                $('#CatalogPriceRule-mulRoles').find('option').each(function() {
                    $(this).removeAttr("selected");
                });
                if ($("#CatalogPriceRule-cboApply").val() == 1 || $("#CatalogPriceRule-cboApply").val() == 3) {
                    $('#CatalogPriceRule-txtValue').unbind();
                    $('#CatalogPriceRule-txtValue').numeric({ max: 100 });
                    $('#CatalogPriceRule-txtValue').attr("maxlength", "5");
                    $('#CatalogPriceRule-txtValue').bind('select', function() {
                        $(this).val('');
                    });
                    bindfocusout();
                } else {
                    $('#CatalogPriceRule-txtValue').unbind();
                    $('#CatalogPriceRule-txtValue').attr("maxlength", "8");
                    // $('#CatalogPriceRule-txtValue').numeric({ max: 99999999 });
                    bindfocusout();
                }
                for (var r = 0; r < arrCatalogPriceRuleRole.length; r++) {
                    $('#CatalogPriceRule-mulRoles').find('option').each(function() {
                        if ($(this).val() == arrCatalogPriceRuleRole[r].RoleID) {
                            $(this).attr("selected", "selected");
                        }
                    });
                }
                var catalogPriceRuleCondition = arrCatalogPriceRuleCondition[0];
                if (catalogPriceRuleCondition.ParentID == 0) {
                    $('div.cssClassFieldSetContent > span:nth-child(1) > span > select.element-value-changer').val(catalogPriceRuleCondition.IsAll ? "ALL" : "ANY");
                    $('div.cssClassFieldSetContent > span:nth-child(1) > a.cssClassFieldSetLabel').text(catalogPriceRuleCondition.IsAll ? "ALL" : "ANY");
                    $('div.cssClassFieldSetContent > span:nth-child(2) > span > select.element-value-changer').val(catalogPriceRuleCondition.IsTrue ? "TRUE" : "FALSE");
                    $('div.cssClassFieldSetContent > span:nth-child(2) > a.cssClassFieldSetLabel').text(catalogPriceRuleCondition.IsTrue ? "TRUE" : "FALSE");


                    for (var d = 0; d < catalogPriceRuleCondition.CatalogConditionDetail.length; d++) {
                        var catalogConditionDetail = catalogPriceRuleCondition.CatalogConditionDetail[d];
                        var attr_ID = catalogConditionDetail.AttributeID;
                        var self = $('div.cssClassFieldSetContent > ul > li:last > span > span > select.element-value-changer ');

                        var priority = $(self).attr('title') * 1 + 1;
                        var path = $(self).attr('title') * 1;
                        var valueText = "...";
                        if (catalogConditionDetail.Value == "") {
                            valueText = "...";
                        } else {
                            valueText = catalogConditionDetail.Value;
                        }
                        var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (catalogPriceRuleCondition.ParentID), AttributeID: attr_ID, value: catalogConditionDetail.Value, valueText: valueText }];

                        if (attr_ID == "35") {
                            $("#PricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
                            $(self).closest('li').parent().find(".MultipleSelectBox_PricingRule").multipleSelectBox(
                                {
                                    onSelectEnd: function(e, resultList) {
                                        $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                        $(this).parent().siblings('input').val(resultList.join(", "));
                                    }
                                });
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(catalogConditionDetail.RuleOperatorID));
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', catalogConditionDetail.RuleOperatorID);

                            var arrCategoryID = catalogConditionDetail.Value.split(",");
                            if (arrCategoryID != "") {
                                var catName = '';
                                $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList > ul > li').each(function() {
                                    for (var i = 0; i < arrCategoryID.length; i++) {
                                        if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {
                                            if (catName != "")
                                                catName += ', ' + $(this).html();
                                            else
                                                catName += $(this).html();
                                        }
                                        $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                        $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                                    }
                                });
                            } else {
                                $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                            }
                            Delete(self);
                        } else if (attr_ID > 0) {
                            $("#PricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());

                            var arrValues = valueText.split(",");
                            var seconLast = $(self).closest('ul').find('>li').length * 1 - 1;

                            GetDropdownText(self);

                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(catalogConditionDetail.RuleOperatorID));
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', catalogConditionDetail.RuleOperatorID);


                            $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('select.element-value-changer option').each(function() {
                                for (var i = 0; i < arrValues.length; i++) {
                                    if ($(this).val() == $.trim(arrValues[i])) {
                                        $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                        $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $.trim(arrValues[i]));
                                    }
                                }
                            });
                            Delete(self);
                        } else {
                            $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                        }
                    }
                    BindChildCondition(arrCatalogPriceRuleCondition);
                }
                SetTabActive(0, "CatalogPriceRule-TabContainer");
            }
        });
        HideShowPrincingRulePanel(false, true);


    }

    function BindChildCondition(arrCatalogPriceRuleCondition) {
        var parentself = '';
        var self = '';
        for (var c = 1; c < arrCatalogPriceRuleCondition.length; c++) {
            var catalogPriceRuleCondition = arrCatalogPriceRuleCondition[c];

            parentself = $('div.cssClassFieldSetContent > ul select[title="' + (c - 1) + '"]');
            $('div.cssClassFieldSetContent ul').each(function(i, item) {
                if ($(item).attr('id') == catalogPriceRuleCondition.ParentID) {
                    parentself = $(item).children('li:last').find('select');
                    return false;
                }
            });

            GetDropdownValue(parentself);
            var nchild = $(parentself).closest('ul').find('> li').length + 1;
            var priority = $(parentself).attr('title') * 1 + 1;
            var path = $(parentself).attr('title') * 1;
            var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: c, AttributeID: 0, value: "", valueText: "..." }];
            $("#PricingRuleTemplate_master").render(ruleInfo).appendTo($(parentself).closest('li').parent());
            $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(parentself).closest('li').parent());
            $(parentself).closest('ul').attr('id', catalogPriceRuleCondition.ParentID);

            $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(0) > a.cssClassFieldSetLabel').text(catalogPriceRuleCondition.IsAll ? "ALL" : "ANY");
            $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > a.cssClassFieldSetLabel').text(catalogPriceRuleCondition.IsTrue ? "TRUE" : "FALSE");
            Delete(parentself);

            for (var d = 0; d < catalogPriceRuleCondition.CatalogConditionDetail.length; d++) {
                var catalogConditionDetail = catalogPriceRuleCondition.CatalogConditionDetail[d];
                var attr_ID = catalogConditionDetail.AttributeID;
                var self = $('div.cssClassFieldSetContent > ul select[title="' + c + '"]');
                var priority = $(self).attr('title') * 1;
                var path = $(self).attr('title') * 1;
                var valueText = "...";
                if (catalogConditionDetail.Value == "") {
                    valueText = "...";
                } else {
                    valueText = catalogConditionDetail.Value;
                }

                var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (path * 1 + 1), AttributeID: attr_ID, value: catalogConditionDetail.Value, valueText: valueText }];

                if (attr_ID == "35") {
                    $("#PricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                    $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
                    $(self).closest('li').parent().find(".MultipleSelectBox_PricingRule").multipleSelectBox(
                        {
                            onSelectEnd: function(e, resultList) {
                                $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                $(this).parent().siblings('input').val(resultList.join(", "));
                            }
                        });
                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(catalogConditionDetail.RuleOperatorID));
                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', catalogConditionDetail.RuleOperatorID);


                    var arrCategoryID = catalogConditionDetail.Value.split(",");
                    if (arrCategoryID != "") {
                        var catName = '';
                        $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList > ul > li').each(function() {
                            for (var i = 0; i < arrCategoryID.length; i++) {
                                if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {
                                    if (catName != "")
                                        catName += ', ' + $(this).html();
                                    else
                                        catName += $(this).html();
                                }
                                $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                            }
                        });
                    } else {
                        $(self).closest('li').parent('ul').find('div.pricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                    }
                    Delete(self);
                } else if (attr_ID > 0) {
                    $("#PricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                    $("#PricingRuleTemplate_plus").render(ruleInfo).appendTo($(self).closest('li').parent());
                    GetDropdownText(self);
                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(catalogConditionDetail.RuleOperatorID));
                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', catalogConditionDetail.RuleOperatorID);

                    var arrValues = catalogConditionDetail.Value.split(",");
                    var seconLast = $(self).closest('ul').find('>li').length * 1 - 1;
                    $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('select.element-value-changer option').each(function() {
                        for (var i = 0; i < arrValues.length; i++) {
                            if ($(this).val() == $.trim(arrValues[i])) {
                                $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                $(self).closest('ul').find('> li:nth-child(' + seconLast + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $.trim(arrValues[i]));
                            }
                        }
                    });
                    Delete(self);
                } else {
                    $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                }
            }
        }
    }

    function setOperators(RuleOperatorID) {
        var opt = '';
        if (RuleOperatorID == 1)
            opt = 'IS';
        else if (RuleOperatorID == 2)
            opt = 'Is Not';
        else if (RuleOperatorID == 3)
            opt = 'Equals or Greater Than';
        else if (RuleOperatorID == 4)
            opt = 'Equals or Less Than';
        else if (RuleOperatorID == 5)
            opt = 'Greater Than';
        else if (RuleOperatorID == 6)
            opt = 'Less Than';
        else if (RuleOperatorID == 7)
            opt = 'Contains';
        else if (RuleOperatorID == 8)
            opt = 'Does Not Contain';
        else if (RuleOperatorID == 9)
            opt = 'Is One Of';
        else if (RuleOperatorID == 10)
            opt = 'Is Not One Of';
        return opt;
    }

    function SetTabActive(index, tabContainerID) {
        var $tabs = $("#" + tabContainerID).tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', index);
    }

    function HideShowPrincingRulePanel(showGrid, showTabMenu) {
        if (showGrid) {
            $('#pricingRuleGrid').show();
        } else {
            $('#pricingRuleGrid').hide();
        }
        if (showTabMenu) {
            $('#pricingRuleTabMenu').show();
        } else {
            $('#pricingRuleTabMenu').hide();
        }
    }

    function DeleteSelectedCatRules() {
    }

    function AddPricingRule() {
        ResetPricingRule();
        $("#resetPricngRule").show();
        HideShowPrincingRulePanel(false, true);
    }

    function CancelPricingRule() {
        HideShowPrincingRulePanel(true, false);
        $('#CatalogPriceRule-txtPriority').removeClass('valid').removeClass('error');
        $("#priority").html("");
        $('#created').html('');
        $('.to').parents('td').find('input').attr("style", '');
        $('label.error').html('');
        $('.error').removeClass("error");
    }

    function ResetPricingRule() {
        $('div.cssClassFieldSetContent > ul > li').not('li:last').remove();
        $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val(0)
        $('#CatalogPriceRule-txtName').val('');
        $('#CatalogPriceRule-txtDescription').val('');
        $('#CatalogPriceRule-txtFromDate').val('');
        $('#CatalogPriceRule-txtToDate').val('');
        $('#CatalogPriceRule-txtPriority').val('');
        $('#CatalogPriceRule-chkIsActive').attr("checked", "checked");
        $('#CatalogPriceRule-cboApply').val(1);
        $('#CatalogPriceRule-txtValue').val('');
        $('#CatalogPriceRule-chkFurtherRuleProcessing').removeAttr("checked");
        $('#CatalogPriceRule-mulRoles').find('option').each(function() {
            $(this).removeAttr("selected");
        });
        $('label.error').html('');
        $('.error').removeClass("error");
        $('#created').html('');
        $('.to').parents('td').find('input').attr('style', '');
        SetTabActive(0, "CatalogPriceRule-TabContainer");
        if ($("#CatalogPriceRule-cboApply option:selected").val() == 1 || $("#CatalogPriceRule-cboApply option:selected").val() == 3) {
            $('#CatalogPriceRule-txtValue').unbind();
            $('#CatalogPriceRule-txtValue').numeric({ max: 100 });
            $('#CatalogPriceRule-txtValue').attr("maxlength", "5");
            $('#CatalogPriceRule-txtValue').bind('select', function() {
                $(this).val('');
            });
            bindfocusout();
        } else {
            $('#CatalogPriceRule-txtValue').unbind();
            $('#CatalogPriceRule-txtValue').attr("maxlength", "8");
            // $('#CatalogPriceRule-txtValue').numeric({ max: 99999999 });
            bindfocusout();
        }
        $('#CatalogPriceRule-txtPriority').removeClass('valid').removeClass('error');
        $("#priority").html("");
    }

    function SearchPricingRule() {
        var ruleNm = $.trim($("#txtCatalogPriceRuleSrc").val());
        var startDt = $.trim($("#txtPricingRuleStartDate").val());
        var endDt = $.trim($('#txtPricingRuleEndDate').val());
        var isAct = $.trim($('#ddlPricingRuleIsActive').val()) == "" ? null : ($.trim($('#ddlPricingRuleIsActive').val()) == "True" ? true : false);
        //		if (startDt) {
        //            var splitFromDate = String(startDt).split('/');
        //            startDt = new Date(Date.UTC(splitFromDate[0], splitFromDate[1] * 1 - 1, splitFromDate[2], 12, 0, 0, 0));           
        //            startDt = startDt.toMSJSON();
        //        }
        //        if (endDt) {
        //            var splitToDate = String(endDt).split('/');
        //            endDt = new Date(Date.UTC(splitToDate[0], splitToDate[1] * 1 - 1, splitToDate[2], 12, 0, 0, 0));
        //            endDt = endDt.toMSJSON();
        //        }
        if (ruleNm.length < 1) {
            ruleNm = null;
        }

        if (startDt.length < 1) {
            startDt = null;
        }

        if (endDt.length < 1) {
            endDt = null;
        }

        GetPricingRules(ruleNm, startDt, endDt, isAct);
    }

/*============= End of Pricing Rules ===============================*/

    function CheckPriorityUniqueness(catalogPriceRuleID) {
        var priorityVal = $('#CatalogPriceRule-txtPriority').val();
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckCatalogPriorityUniqueness",
            data: JSON2.stringify({ CatalogPriceRuleID: catalogPriceRuleID, Priority: priorityVal, StoreID: storeId, PortalID: portalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isUnique = data.d;
            }
        });
        return isUnique;
    }

</script>

<div class="cssClassTabMenu" id="pricingRuleTabMenu">
    <div id="divCatalogPricingRuleForm" class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCatalogPricingRuleFormHeading" runat="server" Text="Catalog Pricing Rule"></asp:Label>
            </h2>
        </div>        
        <div id="placeholder-templates">
        </div>
        <div class="cssClassTabPanelTable">
            <div id="CatalogPriceRule-TabContainer" class="cssClassTabpanelContent">
                <ul>
                    <li><a href="#CatalogPriceRule-1"><span id="lblRuleInformation">Rule Information</span>
                        </a></li>
                    <li class="ui-tabs"><a href="#CatalogPriceRule-2"><span id="lblCondition">Condition</span>
                                        </a></li>
                    <li><a href="#CatalogPriceRule-3"><span id="lblAction">Action</span></a></li>
                </ul>
                <div id="CatalogPriceRule-1" class="cssClassFormWrapper">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblName" class="cssClassLabel">Rule Name:</span>
                            </td>
                            <td>
                                <input type="text" id="CatalogPriceRule-txtName" name="RuleName" class="cssClassNormalTextBox required" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblDescription" class="cssClassLabel">Description:</span>
                            </td>
                            <td>
                                <textarea id="CatalogPriceRule-txtDescription" rows="2" cols="80" name="Description" class="cssClassTextArea"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblRoles" class="cssClassLabel">Roles:</span>
                            </td>
                            <td>
                                <select id="CatalogPriceRule-mulRoles" multiple="multiple" name="Roles" class="cssClassMultiSelect required">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblFromDate" class="cssClassLabel">From Date:</span>
                            </td>
                            <td>
                                <input type="text" id="CatalogPriceRule-txtFromDate" name="FromDate" class="from cssClassNormalTextBox required" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblToDate" class="cssClassLabel">To Date:</span>
                            </td>
                            <td>
                                <input type="text" id="CatalogPriceRule-txtToDate" name="ToDate" class="to cssClassNormalTextBox required" />
                                <span id ="created" style="color: #ED1C24;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblPriority" class="cssClassLabel">Priority:</span>
                            </td>
                            <td>
                                <input type="text" id="CatalogPriceRule-txtPriority" name="name="Priority" class="cssClassNormalTextBox required" maxlength="2"/>
                                <span id="priority" style="color: Red;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CatalogPriceRule-lblIsActive" class="cssClassLabel">Is Active:</span>
                            </td>
                            <td>
                                <input type="checkbox" id="CatalogPriceRule-chkIsActive" class="cssClassCheckBox" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="CatalogPriceRule-2">
                    <div class="cssClassFieldSet">
                        <h2>
                            Conditions (leave blank for all products)</h2>
                        <div class="cssClassFieldSetContent">
                            <span class="cssClassOnClick">IF
                                <input type="hidden" name="type_0" id="type_0" title="type" value="combination" />
                                <input type="hidden" name="pricingRuleID" id="pricingRuleID" value="0" />
                                <a class="cssClassFieldSetLabel" href="#" onclick=" Edit(this) ">ALL</a> <span class="cssClassElement">
                                                                                                           <select name="aggregator_0" id="aggregator_0" class="element-value-changer select"
                                                                                                                   onblur="GetDropdownValue(this)" onchange="GetDropdownValue(this)">
                                                                                                               <option value="ALL" selected="selected">ALL</option>
                                                                                                               <option value="ANY">ANY</option>
                                                                                                           </select>
                                                                                                       </span></span>&nbsp; of these conditions are <span class="cssClassOnClick"><a class="cssClassFieldSetLabel"
                                                                                                                                                                                     onclick=" Edit(this) ">TRUE</a><span class="cssClassElement">
                                                                                                                                                                                                                      <select name="value_0" id="value_0" title="value" class="element-value-changer select"
                                                                                                                                                                                                                              onblur="GetDropdownValue(this)" onchange="GetDropdownValue(this)">
                                                                                                                                                                                                                          <option value="TRUE" selected="selected">TRUE</option>
                                                                                                                                                                                                                          <option value="FALSE">FALSE</option>
                                                                                                                                                                                                                      </select>
                                                                                                                                                                                                                  </span></span>&nbsp;
                            <ul class="cssClassOnClickChildren" id="1">
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="CatalogPriceRule-3" class="cssClassFormWrapper">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CatalogPriceRule-lblApply" class="cssClassLabel">Apply:</span>
                            </td>
                            <td>
                                <select id="CatalogPriceRule-cboApply" class="cssClassDropDown">
                                    <option value="1">By Percentage of the Original Price</option>
                                    <option value="2">By Fixed Amount</option>
                                    <option value="3">To Percentage of the Original Price</option>
                                    <option value="4">To Fixed Amount</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CatalogPriceRule-lblValue" class="cssClassLabel">Value:</span>
                            </td>
                            <td>
                                <input type="text" id="CatalogPriceRule-txtValue" name="Value" class="cssClassNormalTextBox required"/>
                                <span id="percError" style="color: #ED1C24;" ></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="Span3" class="cssClassLabel">Further Rule Processing:</span>
                            </td>
                            <td>
                                <input type="checkbox" id="CatalogPriceRule-chkFurtherRuleProcessing" class="cssClassCheckBox" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="submit" id="btnSavePricingRule">
                        <span>Save</span></button>
                </p>
                <p>
                    <button type="button" onclick=" CancelPricingRule() ">
                        <span>Cancel</span></button>
                </p>
                <p>
                    <button type="button" onclick=" ResetPricingRule() " id="resetPricngRule">
                        <span>Reset</span></button>
                </p>
            </div>
        </div>
    </div>
</div>
<div id="pricingRuleGrid" class="cssClassCommonBox Curve">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblPricingRuleGridHeading" runat="server" Text="Catalog Price Rules"></asp:Label>
        </h2>
        <div class="cssClassHeaderRight">
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnDeleteCatRules">
                        <span><span>Delete All Selected</span></span></button>
                </p>
                <p>
                    <button type="button" id="btnAddNewCatRule">
                        <span><span>Add Pricing Rule</span></span></button>
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
            <div id="divMessage">
            </div>
            <div class="cssClassSearchPanel cssClassFormWrapper">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td>
                            <label class="cssClassLabel">
                                Rule Name:</label>
                            <input type="text" id="txtCatalogPriceRuleSrc" class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                Start Date:</label>
                            <input type="text" id="txtPricingRuleStartDate" class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                End Date:</label>
                            <input type="text" id="txtPricingRuleEndDate" class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                Status:</label>
                            <select id="ddlPricingRuleIsActive">
                                <option value="">-- All --</option>
                                <option value="True">Active</option>
                                <option value="False">Inactive</option>
                            </select>
                        </td>
                        <td>
                            <div class="cssClassButtonWrapper cssClassPaddingNone">
                                <p>
                                    <button type="button" onclick=" SearchPricingRule() ">
                                        <span><span>Search</span></span></button>
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="loading">
                <img id="ajaxCatalogPriceImageLoad"/>
            </div>
            <div class="log">
            </div>
            <table id="gdvCatalogPricingRules" width="100%" border="0" cellpadding="0" cellspacing="0">
            </table>
        </div>
    </div>
</div>