<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CartPriceRule.ascx.cs"
            Inherits="Modules_ASPXCartPricingRule_CartPriceRule" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
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
        GetCartPricingRules(null, null, null, null);
        GetRoles();
        GetStores();
        InitializeCartPricingRuleConditions();
        $('#CartPriceRule-TabContainer').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });

        HideShowPrincingRulePanel(true, false);
        $("#CartPriceRule-txtFromDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#CartPriceRule-txtToDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtCartPricingRuleStartDate").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtCartPricingRuleEndDate").datepicker({ dateFormat: 'yy/mm/dd' });

        var v = $("#form1").validate({
        //  event: "keyup",
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
                },
                MaximumQtyDiscountAppliedTo: {
                    number: true
                },
                DiscountQtyStep: {
                    number: true
                }
            },
            submitHandler: function() {

            }
        });

        $("#CartPriceRule-txtToDate").bind("change", function() {
            $('#created').html('');
            $('.to').parents('td').find('input').attr("style", '');
            $(this).removeClass('error');
            $('.to').parents('td').find('label').remove();

        });

        $("#CartPriceRule-txtFromDate").bind("change", function() {
            if ($(this).val() != "") {
                $('#created').html('');
                $('.to').parents('td').find('input').attr("style", '');
                $(this).removeClass('error');
                $('.to').parents('td').find('label').remove();
            }
            $(this).removeClass('error');
            $('.from').parents('td').find('label').remove();

        });

        $("#btnSaveCartPricingRule").click(function() {
            //FOR Cart Rule TAB
            if (v.form()) {

                if (Date.parse($('.from').val()) >= Date.parse($('.to').val())) {
                    $('.to').parents('td').find('input').css({ "background-color": "#FCC785" });
                    $('#created').html('').html('To Date Must be higher Than From Date');
                    SetTabActive(0, "CartPriceRule-TabContainer");

                } else {
                    $('#created').html('');
                    $('.to').parents('td').find('input').attr("style", '');
                    if (clickonce == 0) {
                        clickonce++;
                        //  SaveCartPricingRule();
                        var pricingRuleID = $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val().replace( /[^0-9]/gi , '') * 1;
                        if (!CheckCartPriorityUniqueness(pricingRuleID)) {
                            $("#spanPriority").html("priority already assigned.");
                            $('#CartPriceRule-txtPriority').removeClass('valid').addClass('error');
                            clickonce = 0;
                            var errorCatalogTab = $("#CartPriceRule-TabContainer").find('div .error').not('label').parents('div:eq(0)');
                            if (errorCatalogTab.length > 0) {
                                var errorCatalogTabName = errorCatalogTab.attr('id');
                                var $tabs = $('#CartPriceRule-TabContainer').tabs();
                                $tabs.tabs('select', errorCatalogTabName);
                            }
                            return false;
                        } else {
                            $('#CartPriceRule-txtPriority').removeClass('valid').removeClass('error');
                            $("#spanPriority").html("");
                            SaveCartPricingRule();
                        }
                    }

                }
            } else {
                var errorCatalogTab = $("#CartPriceRule-TabContainer").find('div .error').not('label').parents('div:eq(0)');
                if (errorCatalogTab.length > 0) {
                    var errorCatalogTabName = errorCatalogTab.attr('id');
                    var $tabs = $('#CartPriceRule-TabContainer').tabs();
                    $tabs.tabs('select', errorCatalogTabName);
                }
            }
        });

        // $('#CartPriceRule-txtValue').numeric({ max: 100 });

        // $('#CartPriceRule-txtPriority').numeric({ max: 999 });
        $('#CartPriceRule-txtPriority').keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#spanPriority").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        (function($) {
            $.fn.numeric = function(options) {
                return this.each(function() {
                    var $this = $(this);
                    $this.keypress(options, function(e) {
                        // allow backspace and delete and decimal
                        //if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
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

        $("#CartPriceRule-txtValue").keypress(function() {
            if ($("#CartPriceRule-cboApply option:selected").val() == 1) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
            }
        });


        $("#CartPriceRule-cboApply").change(function() {
            if ($("#CartPriceRule-cboApply option:selected").val() == 1) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                $('#CartPriceRule-txtValue').unbind();
                $('#CartPriceRule-txtValue').numeric({ max: 100 });
                $('#CartPriceRule-txtValue').attr("maxlength", "5");
                $('#CartPriceRule-txtValue').bind('select', function() {
                    $(this).val('');
                });
                bindfocusout();
                if ($("#CartPriceRule-txtValue").val() >= 100) {
                    $("#CartPriceRule-txtValue").val('');
                }
            } else {
                $('#CartPriceRule-txtValue').unbind();
                $('#CartPriceRule-txtValue').attr("maxlength", "8");
                // $('#CartPriceRule-txtValue').numeric({ max: 99999999 });
                bindfocusout();
            }

        });

        $("#CartPriceRule-txtValue").change(function() {
            if ($("#CartPriceRule-cboApply option:selected").val() == 1) {
                $("#percError").show();
                $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                $('#CartPriceRule-txtValue').unbind();
                $('#CartPriceRule-txtValue').numeric({ max: 100 });
                $('#CartPriceRule-txtValue').attr("maxlength", "5");
                $('#CartPriceRule-txtValue').bind('select', function() {
                    $(this).val('');
                });
                bindfocusout();
                if ($("#CartPriceRule-txtValue").val() >= 100) {
                    $("#CartPriceRule-txtValue").val('');
                }
            } else {
                $("#CartPriceRule-txtValue").attr('style', '');
                $('#CartPriceRule-txtValue').attr("maxlength", "8");
                //$('#CartPriceRule-txtValue').numeric({ max: 99999999 });
                bindfocusout();

            }

        });

        $('#CartPriceRule-txtDiscountQuantity').numeric({ max: 999 });
        $('#CartPriceRule-txtDiscountStep').numeric({ max: 999 });
        bindfocusout();

        $('#btnDeleteCartRules').click(function() {
            var cartRule_ids = '';
            //Get the multiple Ids of the attribute selected
            $("#gdvCartPricingRules .attrCartPricingChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    cartRule_ids += $(this).val() + ',';
                }
            });
            if (cartRule_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        CartPricingRulesMultipleDelete(cartRule_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Cart Rules?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Cart Rule before you can do this.<br/> To select one or more Cart Rules, just check the box before each Cart Rule.</p>');
            }
        });
    });

    function bindfocusout() {

        $("#CartPriceRule-txtValue").focusout(function() {
            if ($("#CartPriceRule-cboApply option:selected").val() == 1) {
                if ($("#CartPriceRule-txtValue").val() >= 100) {
                    $("#CartPriceRule-txtValue").val('');
                    $("#percError").show();
                    $("#percError").html('').html("must be lower than 100").fadeOut(5000);
                }
            }
        });
    }

    function LoadStaticImage() {
        $('#ajaxCartPriceImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function CartPricingRulesMultipleDelete(cartRule_ids, event) {
        if (event) {
            var params = { cartRulesIds: cartRule_ids, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleCartPricingRules",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetCartPricingRules(null, null, null, null);
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
        var selectedText = $.trim($(self).find("option:selected").text());
        $(self).siblings('input').val($(self).find("option:selected").val());
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
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllRoles",
            data: JSON2.stringify({ isActive: 1, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                var options = '';
                $.each(response.d, function(i, item) {
                    options += '<option value="' + item.RoleID + '"> ' + item.RoleName + ' </option>';
                });
                $("#CartPriceRule-mulRoles").html(options);
            }
        });
    }

    function GetStores() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllStores",
            data: JSON2.stringify({ isActive: 1, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                var options = '';
                $.each(response.d, function(i, item) {
                    options += '<option value="' + item.StoreID + '"> ' + item.StoreName + ' </option>';
                });
                $("#CartPriceRule-mulStores").html(options);
            }
        });
    }

    function GetCategoryValue(self) {
        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
        var selectedCategories = '';
        $(self).siblings('div.CartPricingRuleCategoryList').find('ul').each(function(i, item) {
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
        $(self).parent().parent().find("a.cssClassFieldSetLabel").attr('title', selectedCategories);
    }

    function ConditionSelected(self) {
        var priority = $(self).closest('ul').find('>li').length;
        var path = $(self).attr("title");
        var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: ($(self).attr("title") * 1 + 1), AttributeID: $(self).val(), value: "", valueText: "..." }];
        if ($(self).val() == "35") {
            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
            $(self).closest('li').parent().find(".MultipleSelectBox_CartPricingRule").multipleSelectBox(
                {
                    onSelectEnd: function(e, resultList) {
                        $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                        $(this).parent().siblings('input').val(resultList.join(", "));
                    }
                });
            Delete(self);

        }
        if ($(self).val() == "37") {

            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            // $(self).closest('li').parent().find('input[value="37"]').parent('li').find('select option[value="7"]').remove();
            // $(self).closest('li').parent().find('input[value="37"]').parent('li').find('select option[value="8"]').remove();            
            Delete(self);
        }
        if ($(self).val() == "38") {
            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            // $(self).closest('li').parent().find('input[value="38"]').parent('li').find('select option').not('option[value="1"],option[value="2"]').remove();
            // $(self).closest('li').parent().find('input[value="38"]').parent('li').find('select option[value="8"]').remove();                 
            Delete(self);
        }
        if ($(self).val() == "39") {
            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            // $(self).closest('li').parent().find('input[value="39"]').parent('li').find('select').find('option[value="7"],option[value="8"]').remove();
            Delete(self);
        }
            //        if ($(self).val() == "40") {
            //            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            //            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());            
            //            Delete(self);
            //            }  
            //        else if ($(self).val() == "41") {
            //            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            //            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());            
            //            Delete(self);
            //            }       
            //         else if ($(self).val() == "44") { 
            //            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            //            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());            
            //            Delete(self);
            //           }  
            //          else if ($(self).val() == "45") { 
            //            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            //            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());            
            //            Delete(self);
            //            }   
        else if ($(self).val() == 'CC') {
            $("#CartPricingRuleTemplate_master").render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            Delete(self);
        } else if ($(self).val() == 0) {
            $("#CartPricingRuleTemplate_master").render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
            Delete(self);
            $('#.cssPAC li').find('span.cssClassOnClickNewChild').each(function() {
                $(this).find('select').html($('#.cssPAC li').children().last().find('select').html());
            });

            $('#.cssPS li').find('span.cssClassOnClickNewChild').each(function() {
                $(this).find('select').html($('#.cssPS li').children().last().find('select').html());
            });
        } else if ($(self).val() == 'PAC') {
            $("#CartPricingRuleTemplate_master_PAC").render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            Delete(self);
        } else if ($(self).val() == 'PS') {

            $("#CartPricingRuleTemplate_master_PS").render(ruleInfo).appendTo($(self).closest('li').parent()).find('select').find('option[value="3"],option[value="4"],option[value="5"],option[value="6"],option[value="7"],option[value="8"],option[value="9"],option[value="10"]').hide();
            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
            // alert($("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).html());
            // $(self).parents('span').next('span').find('select option').not('option[value="1"],option[value="2"]').remove();
            // $(self).closest('li').parent().find('input[value="PS"]').parent('li').find('select option').not('option[value="1"],option[value="2"]').remove();

            Delete(self);
        } else if ($(self).val() > 0 && $(self).val() != "35" && $(self).val() != "37" && $(self).val() != "38" && $(self).val() != "39") {
            $("#CartPricingRuleTemplate_" + $(self).val()).render(ruleInfo).appendTo($(self).closest('li').parent());
            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
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

    function getShippingMethods() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetShippingMethods",
            data: JSON2.stringify({ isActive: true, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                $.each(data.d, function(i, item) {
                    shippingMethods += '<option value=' + item.ShippingMethodID + '>' + item.ShippingMethodName + '</option>';
                });
            }
        });
    }

    function GetCountry() {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCountryList",
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        shippingCountry += '<option value=' + item.Value + '> ' + item.Text + '</option>';
                    });
                }
            },
            error: function(errorMessage) {
                alert('Country Error');
            }
        });
    }

    function GetState() {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindStateList",
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        shippingState += '<option value=' + item.Value + '> ' + item.Text + '</option>';
                    });
                }
            },
            error: function(errorMessage) {
                alert('State Error');
            }
        });
    }

    function InitializeCartPricingRuleConditions() {
        var treeHTML = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryAll",
            data: JSON2.stringify({ isActive: true, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                CategoryList = data.d;
                treeHTML += '<ul class="MultipleSelectBox_CartPricingRule">';
                var deepLevel = 0;
                $.each(CategoryList, function(i, item) {
                    if (item.CategoryLevel == 0) {
                        treeHTML += '<li class="category_' + item.CategoryID + '" style="padding-left:' + item.CategoryLevel * 10 + 'px;">' + item.CategoryName + '</li>';
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
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartPricingRuleAttributes",
                    data: JSON2.stringify({ isActive: 1, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(response) {
                        var template = '';
                        var plusButtonTemplateMaster = '';
                        var plusButtonTemplateChild = '';
                        var masterConditionTemplate = '';
                        var masterProductAttributeConditionTemplate = '';
                        var masterProductSubselectionConditionTemplate = '';
                        var Flag = 0;

                        plusButtonTemplateMaster = '<li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= Level }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="PAC">Item attribute combination..</option><option value="PS">Items subselection..</option><option value="CC">Condition combination..</option><optgroup label="Cart Attribute">';
                        masterConditionTemplate = '<li><input type="hidden" name="{{= ChildRulePath }}" title="type" value="combination" /> If <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)">ALL</a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="ALL" selected="selected">ALL</option><option value="ANY">ANY</option></select></span></span>&nbsp; of these conditions are <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)">TRUE</a><span class="cssClassElement"><select name="value_{{= ChildRulePath }}" title="value" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="TRUE" selected="selected">TRUE</option><option value="FALSE">FALSE</option></select></span></span>&nbsp;: <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span><ul class="cssClassOnClickChildren" id=""><li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= ChildRulePath }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="PAC">Item attribute combination..</option><option value="PS">Items subselection..</option><option value="CC">Condition combination..</option><optgroup label="Cart Attribute">';

                        plusButtonTemplateChild = '<li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= Level }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';
                        masterProductAttributeConditionTemplate = '<li><input type="hidden" name="{{= ChildRulePath }}" title="type" value="combination" /> IF an Item is <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)">Found</a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="Found" selected="selected">Found</option><option value="Not Found">Not Found</option></select></span></span>&nbsp; in the cart with <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)">ALL</a><span class="cssClassElement"><select name="value_{{= ChildRulePath }}" title="value" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="ALL" selected="selected">ALL</option><option value="ANY">ANY</option></select></span></span>&nbsp; of these conditions true: <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span><ul class="cssClassOnClickChildren cssPAC" id=""><li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= ChildRulePath }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';
                        //masterProductSubselectionConditionTemplate = '<li><input type="hidden" name="{{= ChildRulePath }}" title="type" value="combination" /> IF <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"> total quantity </a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="TQ" selected="selected">total quantity</option><option value="TA"> total amount </option></select></span></span> &nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> Is </a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="1" selected="selected"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option></select> </span> </span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; for a subselection of items in cart matching <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)">ALL</a><span class="cssClassElement"><select name="value_{{= ChildRulePath }}" title="value" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="ALL" selected="selected">ALL</option><option value="ANY">ANY</option></select></span></span>&nbsp; of these conditions: <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span><ul class="cssClassOnClickChildren cssPS" id=""><li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= ChildRulePath }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';
                        masterProductSubselectionConditionTemplate = '<li><input type="hidden" name="{{= ChildRulePath }}" title="type" value="combination" /> IF <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"> total quantity </a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="TQ" selected="selected">total quantity</option><option value="TA"> total amount </option></select></span></span> &nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> Is </a><span class="cssClassElement"><select name="{{= ChildRulePath }}" title="aggregator" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="1" selected="selected"> Is </option><option value="2"> Is Not </option><option value="3"> Equals or Greater Than </option><option value="4"> Equals or Less Than </option><option value="5"> Greater Than </option><option value="6"> Less Than </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option></select> </span> </span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; for a subselection of items in cart matching <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)">ALL</a><span class="cssClassElement"><select name="value_{{= ChildRulePath }}" title="value" class=" element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)"><option value="ALL" selected="selected">ALL</option><option value="ANY">ANY</option></select></span></span>&nbsp; of these conditions: <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span><ul class="cssClassOnClickChildren cssPS" id=""><li>&nbsp;<span class="cssClassOnClick cssClassOnClickNewChild"><a href="#" class="cssClassFieldSetLabel" onclick="Edit(this)"><span class="cssClassAdd"></span></a><span class="cssClassElement"><select title="{{= ChildRulePath }}" class="element-value-changer select" onblur="ConditionSelected(this)"><option value="-1" selected="selected">Please choose a condition to add...</option><option value="0">Condition combination..</option><optgroup label="Product Attribute">';

                        //----------------SubTotal Template --------------------------------------                        
                        plusButtonTemplateMaster += '<option value="37"> SubTotal </option>';
                        masterConditionTemplate += '<option value="37"> SubTotal </option>';
                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="37"/> SubTotal <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="3"> Equals or Greater Than </option><option value="4"> Equals or Less Than </option><option value="5"> Greater Than </option><option value="6"> Less Than </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>';
                        template = '<script id="CartPricingRuleTemplate_37" type="text/html">' + template + '<\/script>';
                        $('#placeholder-templates').append(template);
                        //-------------------------End of SubTotal Template ------------------------------- 

                        //----------------Total Items Quantity Template --------------------------------------
                        plusButtonTemplateMaster += '<option value="38"> Total Items Quantity </option>';
                        masterConditionTemplate += '<option value="38"> Total Items Quantity </option>';
                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="38"/> Total Items Quantity <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        template += '<option value="1"> Is </option><option value="2"> Is Not </option>';
                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>';
                        template = '<script id="CartPricingRuleTemplate_38" type="text/html">' + template + '<\/script>';
                        $('#placeholder-templates').append(template);
                        //-------------------------End of Total Items Quantity Template ------------------------------- 

                        //----------------Total Weight Template --------------------------------------
                        plusButtonTemplateMaster += '<option value="39"> Total Weight </option>';
                        masterConditionTemplate += '<option value="39"> Total Weight </option>';
                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="39"/> Total Weight <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="3"> Equals or Greater Than </option><option value="4"> Equals or Less Than </option><option value="5"> Greater Than </option><option value="6"> Less Than </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>';
                        template = '<script id="CartPricingRuleTemplate_39" type="text/html">' + template + '<\/script>';
                        $('#placeholder-templates').append(template);
                        //-------------------------End of Total Weight Template ------------------------------- 

                        //---------------- Payment Method Template --------------------------------------
                        //                        plusButtonTemplateMaster += '<option value="40"> Payment Method </option>';
                        //                        masterConditionTemplate += '<option value="40"> Payment Method </option>';
                        //                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="40"/> Payment Method <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        //                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        //                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        //                        template += '<select class="element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" ><option value="1">Credit Card</option><option value="2">Cheque/MoneyOrder</option></select></span></span><span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        //                        template = '<script id="CartPricingRuleTemplate_40" type="text/html">' + template + '<\/script>';
                        //                        $('#placeholder-templates').append(template);                                             
                        //------------------------- End of Payment Method Template ------------------------------- 


                        //---------------- Shipping Method Template --------------------------------------
                        //                        plusButtonTemplateMaster += '<option value="41"> Shipping Method </option>';
                        //                        masterConditionTemplate += '<option value="41"> Shipping Method </option>';
                        //                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="41"/> Shipping Method <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        //                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        //                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        //                        template += '<select class="element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" >' + shippingMethods + '</select></span></span><span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        //                        template = '<script id="CartPricingRuleTemplate_41" type="text/html">' + template + '<\/script>';
                        //                        $('#placeholder-templates').append(template);                                             
                        //------------------------- End of Shipping Method Template ------------------------------- 

                        //---------------- Shipping Country Template --------------------------------------
                        //                        plusButtonTemplateMaster += '<option value="45"> Shipping Country </option>';
                        //                        masterConditionTemplate += '<option value="45"> Shipping Country </option>';
                        //                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="45"/> Shipping Country <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        //                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        //                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        //                        template += '<select class="element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)">' + shippingCountry + '</select></span></span><span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        //                        template = '<script id="CartPricingRuleTemplate_45" type="text/html">' + template + '<\/script>';
                        //                        $('#placeholder-templates').append(template);                                             
                        //------------------------- End of Shipping Country Template ------------------------------- 

                        //---------------- Shipping State Template --------------------------------------
                        //                        plusButtonTemplateMaster += '<option value="44"> Shipping State/Province </option>';
                        //                        masterConditionTemplate += '<option value="44"> Shipping State/Province </option>';
                        //                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="44"/> Shipping State/Province <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        //                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        //                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        //                        template += '<select class="element-value-changer select" onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" >' + shippingState + '</select></span></span><span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        //                        template = '<script id="CartPricingRuleTemplate_44" type="text/html">' + template + '<\/script>';
                        //                        $('#placeholder-templates').append(template);                                             
                        //------------------------- End of Shipping State Template ------------------------------- 

                        //---------------- Category Template --------------------------------------
                        plusButtonTemplateChild += '<option value="35"> Category </option>';
                        masterProductAttributeConditionTemplate += '<option value="35"> Category </option>';
                        masterProductSubselectionConditionTemplate += '<option value="35"> Category </option>';

                        template = '<li> <input type="hidden" name="type_{{= RulePath }}" value="Attribute" title="type" /><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="35"/> Category <span class="cssClassOnClick"> <a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" title="operator">';
                        template += '<option value="1"> Is </option><option value="2"> Is Not </option><option value="9"> Is One Of </option><option value="10"> Is Not One Of </option>';
                        template += '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement">';
                        template += '<div class="CartPricingRuleCategoryList">' + treeHTML + '</div><a href="#" class="cssClassOnClickApply" onclick="GetCategoryValue(this)"><span class="cssClassRightGreen"></span></a></span></span><span class="cssClassOnClick"><a href="javascript:void(0)" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                        template = '<script id="CartPricingRuleTemplate_35" type="text/html">' + template + '<\/script>';
                        $('#placeholder-templates').append(template);
                        //------------------------- End of Category Template -------------------------------


                        $.each(response.d, function(i, item) {
                            var options = '';
                            var operators = '';
                            var template = '';

                            if (item.AttributeID == 46) {
                                masterProductAttributeConditionTemplate += '<optgroup label="Cart Item Attributes">';
                                masterProductSubselectionConditionTemplate += '<optgroup label="Cart Item Attributes">';
                                plusButtonTemplateChild += '<optgroup label="Cart Item Attributes">';
                                Flag = 1;
                            }

                            masterProductAttributeConditionTemplate += '<option value="' + item.AttributeID + '"> ' + item.AttributeNameAlias + ' </option>';
                            masterProductSubselectionConditionTemplate += '<option value="' + item.AttributeID + '"> ' + item.AttributeNameAlias + ' </option>';
                            plusButtonTemplateChild += '<option value="' + item.AttributeID + '"> ' + item.AttributeNameAlias + ' </option>';

                            if (item.InputTypeID == 1) //TextBox, Qty
                            {
                                template = '<li><input type="hidden" name="type_{{= RulePath }}" title="type" value="Attribute"/><input type="hidden" name="attribute_{{= RulePath }}" title="attribute" value="{{= AttributeID}}"/>' + item.AttributeNameAlias + ' <span class="cssClassOnClick"><a class="cssClassFieldSetLabel" onclick="Edit(this)"> Is </a><span class="cssClassElement"><select class="element-value-changer select"  onblur="GetDropdownText(this)" onchange="GetDropdownText(this)" name="operator_{{= RulePath }}" id="operator_{{= RulePath }}" title="operator">';
                                var oprts = eval(item.Operators)
                                if (oprts != undefined && oprts.length > 0) {
                                    for (var i = 0; i < oprts.length; i++) {
                                        if (item.AttributeID != 47) {
                                            if (i < 2 || i > 5) { //To NOT bind {value:3,text:"Equals or Greater Than"},{value:4,text:"Equals or Less Than"},{value:5,text:"Greater Than"},{value:6,text:"Less Than"},
                                                var val = oprts[i];
                                                if (i == 0) {
                                                    operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                                } else {
                                                    operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                                }
                                            }
                                        } else {
                                            var val = oprts[i];
                                            if (i == 0) {
                                                operators += '<option value="' + val.value + '" selected="selected"> ' + val.text + ' </option>';
                                            } else {
                                                operators += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                            }
                                        }
                                    }
                                }
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
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
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
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
                                template += operators + '</select></span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input class="element-value-changer input-text cssClassNormalTextBox" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
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
                                template += operators + '</select></span></span>&nbsp;<span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> ' + d.getFullYear() + '/' + (d.getMonth() * 1 + 1) + '/' + d.getDate() + ' </a><span class="cssClassElement"><input class="element-value-changer input-text datepicker" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><a href="#" class="cssClassOnClickApply" onclick="GetTextBoxValue(this)"><span class="cssClassRightGreen"></span></a> </span></span>&nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';

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
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
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
                                template += operators + '</select></span></span> &nbsp; <span class="cssClassOnClick"><a href="#" class="cssClassFieldSetLabel"  onclick="Edit(this)"> {{= valueText }} </a><span class="cssClassElement"><input type="hidden" class="element-value-changer input-text" name="value_{{= RulePath }}" id="value_{{= RulePath }}" title="value"  value="{{= value }}" /><select class="element-value-changer select" multiple="multiple"   onblur="GetMultipleValue(this)">';
                                var opts = eval(item.Values);
                                if (opts != undefined && opts.length > 0) {
                                    for (var i = 0; i < opts.length; i++) {
                                        var val = opts[i];
                                        options += '<option value="' + val.value + '"> ' + val.text + ' </option>';
                                    }
                                }
                                template += options + '</select><a href="#" class="cssClassOnClickApply"></span></span><span class="cssClassOnClick"><a href="javascript:void(0)" class="cssClassOnClickRemove" title="Remove" onclick="Delete(this)"><span class="cssClassDelete"></span></a></span></li>'
                                template = '<script id="CartPricingRuleTemplate_' + item.AttributeID + '" type="text/html">' + template + '<\/script>';
                                $('#placeholder-templates').append(template);
                            }

                        });

                        var ruleInfo = [{ Level: 0, RulePath: 0, value: "", valueText: "..." }];
                        if (Flag == 1) {
                            masterProductSubselectionConditionTemplate += '</optgroup></optgroup></select></span></span></li></ul></li>';
                            masterProductSubselectionConditionTemplate = '<script id="CartPricingRuleTemplate_master_PS" type="text/html">' + masterProductSubselectionConditionTemplate + '<\/script>';
                            $('#placeholder-templates').append(masterProductSubselectionConditionTemplate);

                            masterProductAttributeConditionTemplate += '</optgroup></optgroup></select></span></span></li></ul></li>';
                            masterProductAttributeConditionTemplate = '<script id="CartPricingRuleTemplate_master_PAC" type="text/html">' + masterProductAttributeConditionTemplate + '<\/script>';
                            $('#placeholder-templates').append(masterProductAttributeConditionTemplate);

                            plusButtonTemplateChild += '</optgroup></optgroup></select></span></span>&nbsp;</li>';
                            plusButtonTemplateChild = '<script id="CartPricingRuleTemplate_plus_Child" type="text/html">' + plusButtonTemplateChild + '<\/script>';
                            $('#placeholder-templates').append(plusButtonTemplateChild);
                            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo('.cssClassOnClickChildren');
                            Flag = 0;
                        } else {
                            masterProductSubselectionConditionTemplate += '</optgroup></select></span></span></li></ul></li>';
                            masterProductSubselectionConditionTemplate = '<script id="CartPricingRuleTemplate_master_PS" type="text/html">' + masterProductSubselectionConditionTemplate + '<\/script>';
                            $('#placeholder-templates').append(masterProductSubselectionConditionTemplate);

                            masterProductAttributeConditionTemplate += '</optgroup></select></span></span></li></ul></li>';
                            masterProductAttributeConditionTemplate = '<script id="CartPricingRuleTemplate_master_PAC" type="text/html">' + masterProductAttributeConditionTemplate + '<\/script>';
                            $('#placeholder-templates').append(masterProductAttributeConditionTemplate);

                            plusButtonTemplateChild += '</optgroup></select></span></span>&nbsp;</li>';
                            plusButtonTemplateChild = '<script id="CartPricingRuleTemplate_plus_Child" type="text/html">' + plusButtonTemplateChild + '<\/script>';
                            $('#placeholder-templates').append(plusButtonTemplateChild);
                            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo('.cssClassOnClickChildren');
                        }

                        masterConditionTemplate += '</optgroup></select></span></span></li></ul></li>';
                        masterConditionTemplate = '<script id="CartPricingRuleTemplate_master" type="text/html">' + masterConditionTemplate + '<\/script>';
                        $('#placeholder-templates').append(masterConditionTemplate);

                        plusButtonTemplateMaster += '</optgroup></select></span></span>&nbsp;</li>';
                        plusButtonTemplateMaster = '<script id="CartPricingRuleTemplate_plus_Master" type="text/html">' + plusButtonTemplateMaster + '<\/script>';
                        $('#placeholder-templates').append(plusButtonTemplateMaster);
                        $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo('.cssClassOnClickChildren');

                        $('div.cssClassFieldSetContent > ul > li').not('li:last').remove();
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

    function SaveCartPricingRule() {
        var pricingRuleID = $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val().replace( /[^0-9]/gi , '') * 1;
        var txtName = $('#CartPriceRule-txtName').val();
        var txtDescription = $('#CartPriceRule-txtDescription').val();
        var arrCartPriceRuleRoles = new Array();
        $('#CartPriceRule-mulRoles option:selected').each(function(i, option) {
            arrCartPriceRuleRoles[i] = { CartPriceRuleID: pricingRuleID, RoleID: $(option).val() };
        });

        var arrCartPriceRuleStores = new Array();
        $('#CartPriceRule-mulStores option:selected').each(function(i, option) {
            arrCartPriceRuleStores[i] = { CartPriceRuleID: pricingRuleID, StoreID: $(option).val() };
        });

        var txtFromDate = $('#CartPriceRule-txtFromDate').val();
        var txtToDate = $('#CartPriceRule-txtToDate').val();


        var txtPriority = $('#CartPriceRule-txtPriority').val() * 1;
        var chkIsActive = $('#CartPriceRule-chkIsActive').attr('checked') ? true : false;
        var ddlApply = $('#CartPriceRule-cboApply').val() * 1;
        var txtApplyValue = $('#CartPriceRule-txtValue').val().replace( /[^0-9.]/gi , '');
        var txtDiscountQuantity = $('#CartPriceRule-txtDiscountQuantity').val().replace( /[^0-9.]/gi , '');
        var txtDiscountStep = $('#CartPriceRule-txtDiscountStep').val().replace( /[^0-9.]/gi , '');
        var chkApplytoShippingAmount = $('#CartPriceRule-chkApplytoShippingAmount').attr('checked') ? true : false;
        var cboFreeShipping = $('#CartPriceRule-cboFreeShipping').val().replace( /[^0-9.]/gi , '');
        var chkIsFurtherProcess = $('#CartPriceRule-chkFurtherRuleProcessing').attr('checked') ? true : false;

        if (!(txtDiscountQuantity != null && txtDiscountQuantity.length != 0)) {
            txtDiscountQuantity = 0;
        }
        if (!(txtDiscountStep != null && txtDiscountStep.length != 0)) {
            txtDiscountStep = 0;
        }

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
        var PR = {
            CartPriceRule: {
                Apply: ddlApply,
                CartPriceRuleDescription: txtDescription,
                CartPriceRuleID: pricingRuleID,
                CartPriceRuleName: txtName,
                DiscountQuantity: txtDiscountQuantity,
                DiscountStep: txtDiscountStep,
                ApplytoShippingAmount: chkApplytoShippingAmount,
                FreeShipping: cboFreeShipping,
                IsFurtherProcessing: chkIsFurtherProcess,
                Priority: txtPriority,
                FromDate: txtFromDate,
                ToDate: txtToDate,
                Value: txtApplyValue,
                IsActive: chkIsActive
            }
        };

        var arrCartPriceRuleCondition = new Array();
        var arrCartConditionDetail = new Array()
        var arrRuleCondition = new Array();

        arrCartPriceRuleCondition[0] = { IsAll: isAll, IsTrue: isTrue, lstCartConditionDetails: arrCartConditionDetail };
        arrRuleCondition[0] = { RuleConditionType: "CC", lstCartPriceRuleConditions: arrCartPriceRuleCondition };


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
                var att_priority = attrs[0] * 1;

                arrCartConditionDetail[i] = { AttributeID: att_id, CartPriceRuleID: pricingRuleID, Priority: att_priority, RuleOperatorID: att_op, Value: $.trim(att_val) };
            } else if (String(type).toLowerCase() == 'combination') {
                GetChildCartPricingRule(arrRuleCondition, $(listItem));
            }
        });

        var CartPrice = {
            CartPricingRuleInfo: { CartPriceRule: PR.CartPriceRule, lstRuleCondition: arrRuleCondition, lstCartPriceRuleRoles: arrCartPriceRuleRoles, lstCartPriceRuleStores: arrCartPriceRuleStores }
        };

        $('div.cssClassFieldSetContent').find('ul').each(function(index) {
            $(this).attr('id', index + 1);
        });
        var arrParent = new Array();
        arrParent.push(0);

        $('div.cssClassFieldSetContent').find('ul li').find('input[value="combination"]').each(function() {
            arrParent.push($(this).parent().parent('ul').attr('id'));
        });

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveCartPricingRule",
            contentType: "application/json; charset=utf-8",
            data: JSON2.stringify({ "objCartPriceRule": CartPrice.CartPricingRuleInfo, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName, "parentID": arrParent }),
            dataType: "json",
            success: function(response) {
                var notificationText = "";
                switch (response.d) {
                case "success":
                    notificationText = "Cart pricing rule is saved successfully."
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
                    GetCartPricingRules(null, null, null, null);
                    SetTabActive(0, "CartPriceRule-TabContainer");
                    HideShowPrincingRulePanel(true, false);
                }
                clickonce = 0;
            },
            error: function(msg) {
                clickonce = 0;
            }
        });
    }

    function GetChildCartPricingRule(arrRuleCondition, parent) {
        var pricingRuleID = $(parent).find('input[value="combination"]').attr('name').replace( /[^0-9]/gi , '') * 1;
        var arrCartConditionDetail = new Array();

        if ($(parent).find('> ul').hasClass('cssPAC')) {
            var isFound = $(parent).find('> span > span > select[title="aggregator"]').parent().parent().find('a.cssClassFieldSetLabel').text();
            var isAll = $(parent).find('> span > span > select[title="value"]').parent().parent().find('a.cssClassFieldSetLabel').text();

            var arrProductAttributeRuleConditions = new Array();
            arrProductAttributeRuleConditions[0] = {
                IsAll: String(isAll).toUpperCase() == "ALL" ? true : false,
                IsFound: String(isFound).toUpperCase() == "FOUND" ? true : false,
                lstCartConditionDetails: arrCartConditionDetail
            };
            arrRuleCondition[arrRuleCondition.length] = { RuleConditionType: "PAC", lstProductAttributeRuleConditions: arrProductAttributeRuleConditions };
        } else if ($(parent).find('> ul').hasClass('cssPS')) {
            var operatorID = '';
            var isQty = $(parent).find('> span > span > select[title="aggregator"]').val();
            if ($(parent).find('> span:eq(1) a').attr('title').length > 0)
                operatorID = $(parent).find('> span:eq(1) a').attr('title');
            else
                operatorID = $(parent).find('> span:eq(1) select[title="aggregator"]').val() * 1;

            var value = $(parent).find('> span:eq(2) input[title="value"]').parent().parent().find('a.cssClassFieldSetLabel').text();
            var isAll = $(parent).find('> span:eq(3) select[title="value"]').parent().parent().find('a.cssClassFieldSetLabel').text();

            var arrProductSubSelectionRuleConditions = new Array();
            arrProductSubSelectionRuleConditions[0] = { IsQuantity: String(isQty).toUpperCase() == "TQ" ? true : false, IsAll: String(isAll).toUpperCase() == "ALL" ? true : false, Value: value, RuleOperatorID: operatorID, lstCartConditionDetails: arrCartConditionDetail };
            arrRuleCondition[arrRuleCondition.length] = { RuleConditionType: "PS", lstProductSublectionRuleConditions: arrProductSubSelectionRuleConditions };
        } else {
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

            var arrCartPriceRuleCondition = new Array();
            arrCartPriceRuleCondition[0] = { IsAll: isAll, IsTrue: isTrue, lstCartConditionDetails: arrCartConditionDetail };
            arrRuleCondition[arrRuleCondition.length] = { RuleConditionType: "CC", lstCartPriceRuleConditions: arrCartPriceRuleCondition };

        }

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
                var att_priority = attrs[0] * 1;

                arrCartConditionDetail[i] = { AttributeID: att_id, CartPriceRuleID: pricingRuleID, Priority: att_priority, RuleOperatorID: att_op, Value: $.trim(att_val) };
            } else if (String(type).toLowerCase() == 'combination') {
                GetChildCartPricingRule(arrRuleCondition, $(childListItem))
            }
        });
    }

    function GetCartPricingRules(ruleNm, startDt, endDt, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCartPricingRules_pagesize").length > 0) ? $("#gdvCartPricingRules_pagesize :selected").text() : 10;

        $("#gdvCartPricingRules").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCartPricingRules',
            colModel: [
                { display: 'Cart Pricing Rule ID', cssclass: 'cssClassHeadCheckBox', name: 'CartPriceRuleID', controlclass: '', coltype: 'checkbox', align: 'center', elemClass: 'attrCartPricingChkbox', elemDefault: false, controlclass: 'cartPricingHeaderChkbox' },
                { display: 'Rule Name', name: 'CartPriceRuleName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'From Date', name: 'FromDate', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'To Date', name: 'ToDate', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Is Active', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', type: 'boolean', format: 'True/False', align: 'left' },
                { display: 'Priority', name: 'priority', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCartPricingRule', arguments: '0' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCartPricngRule', arguments: '0' }
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

    function EditCartPricingRule(tblID, argus) {
        switch (tblID) {
        case "gdvCartPricingRules":
            $("#btnResetCartPricingRule").hide();
            GetCartPricingRuleByCartPricingRuleID(argus[3]);
            break;
        default:
            break;
        }
    }

    function DeleteCartPricngRule(tblID, argus) {
        switch (tblID) {
        case "gdvCartPricingRules":
            if (argus[3]) {
                var properties = { onComplete: function(e) { CartPricingRuleDelete(argus[0], storeId, portalId, userName, cultureName, e); } }
                csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this attribute?</p>", properties);
            }
            break;
        default:
            break;
        }
    }

    function CartPricingRuleDelete(priceRuleID, storeId, portalId, userName, cultureName, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCartPricingRule",
                data: JSON2.stringify({ cartPricingRuleID: priceRuleID, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetCartPricingRules(null, null, null, null);
                }
            });
        }
        return false;
    }

    function GetCartPricingRuleByCartPricingRuleID(pricingRuleID) {

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartPricingRule",
            contentType: "application/json; charset=utf-8",
            data: JSON2.stringify({ cartPriceRuleID: pricingRuleID, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            dataType: "json",
            success: function(response) {

                $('div.cssClassFieldSetContent > ul > li').not('li:last').remove();
                var dsData = eval(response.d);
                var cartPriceRule = dsData.CartPriceRule;
                var arrRuleCondition = dsData.lstRuleCondition;
                var arrCartPriceRuleRole = dsData.lstCartPriceRuleRoles;
                var arrCartPriceRuleStore = dsData.lstCartPriceRuleStores;
                $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val(cartPriceRule.CartPriceRuleID)
                $('#CartPriceRule-txtName').val(cartPriceRule.CartPriceRuleName);
                $('#CartPriceRule-txtDescription').val(cartPriceRule.CartPriceRuleDescription);
                $('#CartPriceRule-txtFromDate').val(JSONDateToString(cartPriceRule.FromDate, "yyyy/MM/dd"));
                $('#CartPriceRule-txtToDate').val(JSONDateToString(cartPriceRule.ToDate, "yyyy/MM/dd"));
                $('#CartPriceRule-txtPriority').val(cartPriceRule.Priority);
                $('#CartPriceRule-chkIsActive').attr("checked", cartPriceRule.IsActive);
                $('#CartPriceRule-cboApply').val(cartPriceRule.Apply);
                $('#CartPriceRule-txtValue').val(cartPriceRule.Value);
                $('#CartPriceRule-chkFurtherRuleProcessing').attr("checked", cartPriceRule.IsFurtherProcessing);
                $('#CartPriceRule-mulRoles').find('option').each(function() {
                    $(this).removeAttr("selected");
                });
                $('#CartPriceRule-txtDiscountQuantity').val(cartPriceRule.DiscountQuantity)
                $('#CartPriceRule-txtDiscountStep').val(cartPriceRule.DiscountStep)
                $('#CartPriceRule-chkApplytoShippingAmount').attr("checked", cartPriceRule.ApplytoShippingAmount);
                $('#CartPriceRule-cboFreeShipping').val(cartPriceRule.FreeShipping);
                $('#CartPriceRule-mulStores').find('option').each(function() {
                    $(this).removeAttr("selected");
                });
                if ($("#CartPriceRule-cboApply").val() == 1) {
                    $('#CartPriceRule-txtValue').unbind();
                    $('#CartPriceRule-txtValue').numeric({ max: 100 });
                    $('#CartPriceRule-txtValue').attr("maxlength", "5");
                    $('#CartPriceRule-txtValue').bind('select', function() {
                        $(this).val('');
                    });
                    bindfocusout();
                } else {
                    $('#CartPriceRule-txtValue').unbind();
                    $('#CartPriceRule-txtValue').attr("maxlength", "8");
                    // $('#CartPriceRule-txtValue').numeric({ max: 99999999 });
                    bindfocusout();
                }
                for (var s = 0; s < arrCartPriceRuleStore.length; s++) {
                    $('#CartPriceRule-mulStores').find('option').each(function() {
                        if ($(this).val() == arrCartPriceRuleStore[s].StoreID) {
                            $(this).attr("selected", "selected");
                        }
                    });
                }
                for (var r = 0; r < arrCartPriceRuleRole.length; r++) {
                    $('#CartPriceRule-mulRoles').find('option').each(function() {
                        if ($(this).val() == arrCartPriceRuleRole[r].RoleID) {
                            $(this).attr("selected", "selected");
                        }
                    });
                }
                var ruleCondition = arrRuleCondition[0];
                $('div.cssClassFieldSetContent > ul').attr('id', ruleCondition.ParentID);

                if (ruleCondition.ParentID == 0) {
                    var cartPriceRuleCondition = arrRuleCondition[0].lstCartPriceRuleConditions[0];
                    $('div.cssClassFieldSetContent > span:nth-child(1) > span > select.element-value-changer').val(cartPriceRuleCondition.IsAll ? "ALL" : "ANY");
                    $('div.cssClassFieldSetContent > span:nth-child(1) > a.cssClassFieldSetLabel').text(cartPriceRuleCondition.IsAll ? "ALL" : "ANY");
                    $('div.cssClassFieldSetContent > span:nth-child(2) > span > select.element-value-changer').val(cartPriceRuleCondition.IsTrue ? "TRUE" : "FALSE");
                    $('div.cssClassFieldSetContent > span:nth-child(2) > a.cssClassFieldSetLabel').text(cartPriceRuleCondition.IsTrue ? "TRUE" : "FALSE");

                    for (var d = 0; d < cartPriceRuleCondition.lstCartConditionDetails.length; d++) {
                        var cartConditionDetail = cartPriceRuleCondition.lstCartConditionDetails[d];
                        var attr_ID = cartConditionDetail.AttributeID;
                        var self = $('div.cssClassFieldSetContent > ul > li:last > span > span > select.element-value-changer ');
                        var priority = $(self).attr('title') * 1 + 1;
                        var path = $(self).attr('title') * 1;
                        var valueText = "...";
                        if (cartConditionDetail.Value == "") {
                            valueText = "...";
                        } else {
                            valueText = cartConditionDetail.Value;
                        }
                        var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (ruleCondition.ParentID), AttributeID: attr_ID, value: cartConditionDetail.Value, valueText: valueText }];

                        if (attr_ID == "35") {

                            $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                            $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
                            $(self).closest('li').parent().find(".MultipleSelectBox_CartPricingRule").multipleSelectBox(
                                {
                                    onSelectEnd: function(e, resultList) {
                                        $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                        $(this).parent().siblings('input').val(resultList.join(", "));
                                    }
                                });
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                            var arrCategoryID = cartConditionDetail.Value.split(",");
                            if (arrCategoryID != "") {
                                var catName = '';
                                $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList > ul > li').each(function() {
                                    for (var i = 0; i < arrCategoryID.length; i++) {
                                        if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {
                                            if (catName != "")
                                                catName += ', ' + $(this).html();
                                            else
                                                catName += $(this).html();
                                        }
                                        $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                        $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                                    }
                                });
                            } else {
                                $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                            }
                            Delete(self);
                        } else if (attr_ID > 0) {
                            $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                            $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
                            var arrValues = cartConditionDetail.Value.split(",");
                            var seconLast = $(self).closest('ul').find('>li').length * 1 - 1;
                            GetDropdownText(self);
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                            //var arrValues = cartConditionDetail.Value.split(",");
                            $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('select.element-value-changer option').each(function(i, itm) {
                                //for (var i = 0; i < arrValues.length; i++) {                                                               
                                if ($(itm).val() == $.trim(cartConditionDetail.Value)) {
                                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                    $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $(this).val());
                                }
                                // }
                            });
                            Delete(self);
                        } else {
                            $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                        }
                    }
                    BindChildCondition(arrRuleCondition);
                }
                SetTabActive(0, "CartPriceRule-TabContainer");
            }
        });
        HideShowPrincingRulePanel(false, true);
    }

    function BindChildCondition(arrRuleCondition) {

        var parentself = '';
        var self = '';
        for (var c = 1; c < arrRuleCondition.length; c++) {
            var ruleCondition = arrRuleCondition[c];
            if (jQuery.trim(ruleCondition.RuleConditionType.toUpperCase()) == "CC" && ruleCondition.ParentID != 0) {


                parentself = $('div.cssClassFieldSetContent > ul select[title="' + (c - 1) + '"]');
                $('div.cssClassFieldSetContent ul').each(function(i, item) {
                    if ($(item).attr('id') == ruleCondition.ParentID) {
                        parentself = $(item).children('li:last').find('select');
                        return false;
                    }
                });

                var nchild = $(parentself).closest('ul').find('> li').length + 1;
                var priority = $(parentself).attr('title') * 1 + 1;
                var path = $(parentself).attr('title') * 1;
                var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: c, AttributeID: 0, value: "", valueText: "..." }];

                $("#CartPricingRuleTemplate_master").render(ruleInfo).appendTo($(parentself).closest('li').parent());
                $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(parentself).closest('li').parent());
                $(parentself).closest('ul').attr('id', ruleCondition.ParentID);

                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(0) > a.cssClassFieldSetLabel').text(ruleCondition.lstCartPriceRuleConditions[0].IsAll ? "ALL" : "ANY");
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > a.cssClassFieldSetLabel').text(ruleCondition.lstCartPriceRuleConditions[0].IsTrue ? "TRUE" : "FALSE");
                Delete(parentself);

                for (var d = 0; d < ruleCondition.lstCartPriceRuleConditions[0].lstCartConditionDetails.length; d++) {
                    var cartConditionDetail = ruleCondition.lstCartPriceRuleConditions[0].lstCartConditionDetails[d];
                    var attr_ID = cartConditionDetail.AttributeID;
                    self = $('div.cssClassFieldSetContent > ul select[title="' + c + '"]');
                    var priority = $(self).attr('title') * 1;
                    var path = $(self).attr('title') * 1;
                    var valueText = "...";
                    if (cartConditionDetail.Value == "") {
                        valueText = "...";
                    } else {
                        valueText = cartConditionDetail.Value;
                    }
                    var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (path * 1 + 1), AttributeID: attr_ID, value: cartConditionDetail.Value, valueText: valueText }];
                    if (attr_ID == "35") {
                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
                        $(self).closest('li').parent().find(".MultipleSelectBox_CartPricingRule").multipleSelectBox(
                            {
                                onSelectEnd: function(e, resultList) {
                                    $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                    $(this).parent().siblings('input').val(resultList.join(", "));
                                }
                            });
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                        var arrCategoryID = cartConditionDetail.Value.split(",");
                        if (arrCategoryID != "") {
                            var catName = '';
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList > ul > li').each(function() {
                                for (var i = 0; i < arrCategoryID.length; i++) {
                                    if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {

                                        if (catName != "")
                                            catName += ', ' + $(this).html();
                                        else
                                            catName += $(this).html();
                                    }
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                                }
                            });
                        } else {
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                        }
                        Delete(self);
                    } else if (attr_ID > 0) {
                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(self).closest('li').parent());
                        GetDropdownText(self);
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                        //var arrValues = cartConditionDetail.Value.split(",");
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('select.element-value-changer option').each(function(i, itm) {
                            //for (var i = 0; i < arrValues.length; i++) {                                                               
                            if ($(itm).val() == $.trim(cartConditionDetail.Value)) {
                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $(this).val());
                            }
                            // }
                        });
                        Delete(self);
                    } else {
                        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                    }
                }
            }

            if (jQuery.trim(ruleCondition.RuleConditionType.toUpperCase()) == "PAC") {

                parentself = $('div.cssClassFieldSetContent > ul select[title="' + (c - 1) + '"]');
                $('div.cssClassFieldSetContent ul').each(function(i, item) {
                    if ($(item).attr('id') == ruleCondition.ParentID) {
                        parentself = $(item).children('li:last').find('select');
                        return false;
                    }
                });
                var nchild = $(parentself).closest('ul').find('> li').length + 1;
                var priority = $(parentself).attr('title') * 1 + 1;
                var path = $(parentself).attr('title') * 1;
                var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: c, AttributeID: 0, value: "", valueText: "..." }];

                $("#CartPricingRuleTemplate_master_PAC").render(ruleInfo).appendTo($(parentself).closest('li').parent());
                $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(parentself).closest('li').parent());
                $(parentself).closest('ul').attr('id', ruleCondition.ParentID);
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > a.cssClassFieldSetLabel').text(ruleCondition.lstProductAttributeRuleConditions[0].IsAll ? "ALL" : "ANY");
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(0) > a.cssClassFieldSetLabel').text(ruleCondition.lstProductAttributeRuleConditions[0].IsFound ? "Found" : "Not Found");
                Delete(parentself);

                for (var d = 0; d < ruleCondition.lstProductAttributeRuleConditions[0].lstCartConditionDetails.length; d++) {
                    var cartConditionDetail = ruleCondition.lstProductAttributeRuleConditions[0].lstCartConditionDetails[d];
                    var attr_ID = cartConditionDetail.AttributeID;
                    self = $('div.cssClassFieldSetContent > ul select[title="' + c + '"]');
                    var priority = $(self).attr('title') * 1;
                    var path = $(self).attr('title') * 1;
                    var valueText = "...";
                    if (cartConditionDetail.Value == "") {
                        valueText = "...";
                    } else {
                        valueText = cartConditionDetail.Value;
                    }
                    var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (path * 1 + 1), AttributeID: attr_ID, value: cartConditionDetail.Value, valueText: valueText }];
                    if (attr_ID == "35") {
                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
                        $(self).closest('li').parent().find(".MultipleSelectBox_CartPricingRule").multipleSelectBox(
                            {
                                onSelectEnd: function(e, resultList) {
                                    $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                    $(this).parent().siblings('input').val(resultList.join(", "));
                                }
                            });
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                        var arrCategoryID = valueText.split(",");
                        if (arrCategoryID != "...") {
                            var catName = '';
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList > ul > li').each(function() {
                                for (var i = 0; i < arrCategoryID.length; i++) {
                                    if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {

                                        if (catName != "")
                                            catName += ', ' + $(this).html();
                                        else
                                            catName += $(this).html();
                                    }
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                                }
                            });
                        } else {
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                        }
                        Delete(self);
                    } else if (attr_ID > 0) {
                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
                        GetDropdownText(self);
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);


                        //var arrValues = cartConditionDetail.Value.split(",");
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('select.element-value-changer option').each(function(i, itm) {
                            //for (var i = 0; i < arrValues.length; i++) {
                            // alert($(itm).val()+' == '+ $.trim(cartConditionDetail.Value));                                                               
                            if ($(itm).val() == $.trim(cartConditionDetail.Value)) {
                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $(this).val());
                            }
                            // }
                        });
                        Delete(self);
                    } else {
                        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                    }
                }
            }

            if (jQuery.trim(ruleCondition.RuleConditionType.toUpperCase()) == "PS") {
                parentself = $('div.cssClassFieldSetContent > ul select[title="' + (c - 1) + '"]');
                $('div.cssClassFieldSetContent ul').each(function(i, item) {
                    if ($(item).attr('id') == ruleCondition.ParentID) {
                        parentself = $(item).children('li:last').find('select');
                        return false;
                    }
                });

                var nchild = $(parentself).closest('ul').find('> li').length + 1;
                var priority = $(parentself).attr('title') * 1 + 1;
                var path = $(parentself).attr('title') * 1;
                var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: c, AttributeID: 0, value: "", valueText: "..." }];

                $("#CartPricingRuleTemplate_master_PS").render(ruleInfo).appendTo($(parentself).closest('li').parent()).find('select').find('option[value="3"],option[value="4"],option[value="5"],option[value="6"],option[value="7"],option[value="8"],option[value="9"],option[value="10"]').hide();
                ;
                $("#CartPricingRuleTemplate_plus_Master").render(ruleInfo).appendTo($(parentself).closest('li').parent());
                $(parentself).closest('ul').attr('id', ruleCondition.ParentID);
                var ruleOperator = '';
                if (ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID == 1)
                    ruleOperator = 'IS';
                else if (ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID == 2)
                    ruleOperator = 'IS Not';
                else if (ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID == 9)
                    ruleOperator = 'IS One Of';
                else if (ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID == 10)
                    ruleOperator = 'IS Not One Of';

                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(0) > a.cssClassFieldSetLabel').text(ruleCondition.lstProductSublectionRuleConditions[0].IsQuantity ? "total quantity" : "total amount");
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > select[title="aggregator"]').val(ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID);
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > a.cssClassFieldSetLabel').text(ruleOperator); //dropdown first element
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(1) > a.cssClassFieldSetLabel').attr('title', ruleCondition.lstProductSublectionRuleConditions[0].RuleOperatorID);
                //var ruleConditionVal="...";
                //if(ruleCondition.lstProductSublectionRuleConditions[0].Value!="")
                //{
                //ruleConditionVal=ruleCondition.lstProductSublectionRuleConditions[0].Value;
                //}
                //else
                //{
                //ruleConditionVal="...";
                //}
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(2) input[title="value"]').val(ruleCondition.lstProductSublectionRuleConditions[0].Value);
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(2) > a.cssClassFieldSetLabel').text(ruleCondition.lstProductSublectionRuleConditions[0].Value);
                $(parentself).closest('ul').find('> li:nth-child(' + nchild + ') > span:eq(3) > a.cssClassFieldSetLabel').text(ruleCondition.lstProductSublectionRuleConditions[0].IsAll ? "ALL" : "ANY");

                Delete(parentself);

                for (var d = 0; d < ruleCondition.lstProductSublectionRuleConditions[0].lstCartConditionDetails.length; d++) {
                    var cartConditionDetail = ruleCondition.lstProductSublectionRuleConditions[0].lstCartConditionDetails[d];
                    var attr_ID = cartConditionDetail.AttributeID;
                    self = $('div.cssClassFieldSetContent > ul select[title="' + c + '"]');
                    var priority = $(self).attr('title') * 1;
                    var path = $(self).attr('title') * 1;
                    var valueText = "...";
                    if (cartConditionDetail.Value == "") {
                        valueText = "...";
                    } else {
                        valueText = cartConditionDetail.Value;
                    }
                    var ruleInfo = [{ Level: path, RulePath: (path + '-' + priority), ChildRulePath: (path * 1 + 1), AttributeID: attr_ID, value: cartConditionDetail.Value, valueText: valueText }];
                    if (attr_ID == "35") {
                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
                        $(self).closest('li').parent().find(".MultipleSelectBox_CartPricingRule").multipleSelectBox(
                            {
                                onSelectEnd: function(e, resultList) {
                                    $(this).parent().parent().parent('SPAN').find("a.cssClassFieldSetLabel").html(resultList.join(", "));
                                    $(this).parent().siblings('input').val(resultList.join(", "));
                                }
                            });
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                        var arrCategoryID = cartConditionDetail.Value.split(",");
                        if (arrCategoryID != "") {
                            var catName = '';
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList > ul > li').each(function() {
                                for (var i = 0; i < arrCategoryID.length; i++) {
                                    if ($(this).hasClass("category_" + $.trim(arrCategoryID[i]))) {

                                        if (catName != "")
                                            catName += ', ' + $(this).html();
                                        else
                                            catName += $(this).html();
                                    }
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(catName);
                                    $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').attr('title', arrCategoryID);
                                }
                            });
                        } else {
                            $(self).closest('li').parent('ul').find('div.CartPricingRuleCategoryList').parent().parent().find('a.cssClassFieldSetLabel').text(valueText);
                        }
                        Delete(self);
                    } else if (attr_ID > 0) {

                        $("#CartPricingRuleTemplate_" + attr_ID).render(ruleInfo).appendTo($(self).closest('li').parent());
                        $("#CartPricingRuleTemplate_plus_Child").render(ruleInfo).appendTo($(self).closest('li').parent());
                        GetDropdownText(self);

                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').parent().parent().find('a').html($(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').val());
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('.datepicker').datepicker({ dateFormat: 'yy/mm/dd' });

                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').text(setOperators(cartConditionDetail.RuleOperatorID));
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(0)').find('a.cssClassFieldSetLabel').attr('title', cartConditionDetail.RuleOperatorID);

                        //var arrValues = cartConditionDetail.Value.split(",");
                        $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('select.element-value-changer option').each(function(i, itm) {
                            //for (var i = 0; i < arrValues.length; i++) {                                                               
                            if ($(itm).val() == $.trim(cartConditionDetail.Value)) {

                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').text($(this).html());
                                $(self).closest('li').parent().children('li:eq(' + (d + 1) + ')').find('span:eq(2)').find('a.cssClassFieldSetLabel').attr('title', $(this).val());
                            }
                            // }
                        });
                        Delete(self);
                    } else {
                        $(self).parent().parent('SPAN').removeClass("cssClassOnClickEdit");
                    }
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
            $('#cartPricingRuleGrid').show();
        } else {
            $('#cartPricingRuleGrid').hide();
        }
        if (showTabMenu) {
            $('#cartPricingRuleTabMenu').show();
        } else {
            $('#cartPricingRuleTabMenu').hide();
        }
    }

    function AddCartPricingRule() {
        ResetCartPricingRule();
        $("#btnResetCartPricingRule").show();
        HideShowPrincingRulePanel(false, true);
    }

    function CancelCartPricingRule() {
        HideShowPrincingRulePanel(true, false);
        $('#CartPriceRule-txtPriority').removeClass('valid').removeClass('error');
        $("#spanPriority").html("");
        $('#created').html('');
        $('.to').parents('td').find('input').attr("style", '');
        $('label.error').html('');
        $('.error').removeClass("error");
    }

    function ResetCartPricingRule() {
        $('#CartPriceRule-txtDiscountQuantity').val(0)
        $('#CartPriceRule-txtDiscountStep').val(0)
        $('#CartPriceRule-chkApplytoShippingAmount').removeAttr("checked");
        $('#CartPriceRule-cboFreeShipping').val(0);
        $('div.cssClassFieldSetContent > ul > li').not('li:last').remove();
        $('div.cssClassFieldSetContent > span > input[name="pricingRuleID"]').val(0)
        $('#CartPriceRule-txtName').val('');
        $('#CartPriceRule-txtDescription').val('');
        $('#CartPriceRule-txtFromDate').val('');
        $('#CartPriceRule-txtToDate').val('');
        $('#CartPriceRule-txtPriority').val('');
        $('#CartPriceRule-chkIsActive').attr("checked", "checked");
        $('#CartPriceRule-cboApply').val(1);
        $('#CartPriceRule-txtValue').val('');
        $('#CartPriceRule-chkFurtherRuleProcessing').removeAttr("checked");
        $('#CartPriceRule-mulRoles').find('option').each(function() {
            $(this).removeAttr("selected");
        });
        $('#CartPriceRule-mulStores').find('option').each(function() {
            $(this).removeAttr("selected");
        });
        $('label.error').html('');
        $('.error').removeClass("error");
        $('#created').html('');
        $('.to').parents('td').find('input').attr("style", '');
        SetTabActive(0, "CartPriceRule-TabContainer");
        if ($("#CartPriceRule-cboApply option:selected").val() == 1) {
            $('#CartPriceRule-txtValue').unbind();
            $('#CartPriceRule-txtValue').numeric({ max: 100 });
            $('#CartPriceRule-txtValue').attr("maxlength", "5");
            $('#CartPriceRule-txtValue').bind('select', function() {
                $(this).val('');
            });
            bindfocusout();
        } else {
            $('#CartPriceRule-txtValue').unbind();
            $('#CartPriceRule-txtValue').attr("maxlength", "8");
            // $('#CartPriceRule-txtValue').numeric({ max: 99999999 });
            bindfocusout();
        }
        $('#CartPriceRule-txtPriority').removeClass('valid').removeClass('error');
        $("#spanPriority").html("");
    }

    function SearchCartPricingRule() {
        var ruleNm = $.trim($("#txtCartPriceRuleSrc").val());
        var startDt = $.trim($("#txtCartPricingRuleStartDate").val());
        var endDt = $.trim($('#txtCartPricingRuleEndDate').val());
        var isAct = $.trim($('#ddlCartPricingRuleIsActive').val()) == "" ? null : ($.trim($('#ddlCartPricingRuleIsActive').val()) == "True" ? true : false);
        //        if (startDt) {
        //            var splitFromDate = String(startDt).split('/');
        //            startDt =    new Date(Date.UTC(splitFromDate[0], splitFromDate[1] * 1 - 1, splitFromDate[2], 12, 0, 0, 0));            
        //            startDt = startDt.toMSJSON();
        //            
        //        }
        //        if (endDt) {
        //            var splitToDate = String(endDt).split('/');
        //            endDt =new Date(Date.UTC(splitToDate[2], splitToDate[0] * 1 - 1, splitToDate[1], 12, 0, 0, 0));            
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
        GetCartPricingRules(ruleNm, startDt, endDt, isAct);
    }

/*============= End of Pricing Rules ===============================*/

    function CheckCartPriorityUniqueness(cartPriceRuleID) {
        var cartPriorityVal = $('#CartPriceRule-txtPriority').val();
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckCartPricePriorityUniqueness",
            data: JSON2.stringify({ CartPriceRuleID: cartPriceRuleID, Priority: cartPriorityVal, PortalID: portalId }),
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

<div class="cssClassTabMenu" id="cartPricingRuleTabMenu">
    <div id="divCartPricingRuleForm" class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCartPricingRuleFormHeading" runat="server" Text="Cart Pricing Rule"></asp:Label>
            </h2>
        </div>        
        <div id="placeholder-templates">
        </div>
        <div class="cssClassTabPanelTable">
            <div id="CartPriceRule-TabContainer" class="cssClassTabpanelContent">
                <ul>
                    <li><a href="#CartPriceRule-1"><span id="lblRuleInformation">Cart Rule Information</span>
                        </a></li>
                    <li class="ui-tabs"><a href="#CartPriceRule-2"><span id="lblCondition">Condition</span>
                                        </a></li>
                    <li><a href="#CartPriceRule-3"><span id="lblAction">Action</span></a></li>
                </ul>
                <div id="CartPriceRule-1" class="cssClassFormWrapper">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblName" class="cssClassLabel">Rule Name:</span>
                            </td>
                            <td class="cssClassTableRightCol">
                                <input type="text" id="CartPriceRule-txtName" name="RuleName" class="cssClassNormalTextBox  required" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblDescription" class="cssClassLabel">Description:</span>
                            </td>
                            <td>
                                <textarea id="CartPriceRule-txtDescription" rows="4" cols="80" name="Description"
                                          class="cssClassTextArea"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblStores" class="cssClassLabel">Stores:</span>
                            </td>
                            <td>
                                <select id="CartPriceRule-mulStores" multiple="multiple" name="Stores" class="cssClassMultiSelect required">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblRoles" class="cssClassLabel">Roles:</span>
                            </td>
                            <td>
                                <select id="CartPriceRule-mulRoles" multiple="multiple" name="Roles" class="cssClassMultiSelect required">
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblFromDate" class="cssClassLabel">From Date:</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtFromDate" name="FromDate" class="from cssClassNormalTextBox required" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblToDate" class="cssClassLabel">To Date:</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtToDate" name="ToDate" class="to cssClassNormalTextBox required" />
                                <span id ="created" style="color: #ED1C24;"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblPriority" class="cssClassLabel">Priority:</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtPriority" name="Priority" class="cssClassNormalTextBox required" maxlength="2"/>
                                <span id="spanPriority" style="color: Red"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span id="CartPriceRule-lblIsActive" class="cssClassLabel">Is Active:</span>
                            </td>
                            <td>
                                <input type="checkbox" id="CartPriceRule-chkIsActive" class="cssClassCheckBox" />
                            </td>
                        </tr>
                    </table>
                </div>
                <div id="CartPriceRule-2">
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
                            <ul class="cssClassOnClickChildren" id="">
                            </ul>
                        </div>
                    </div>
                </div>
                <div id="CartPriceRule-3" class="cssClassFormWrapper">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tdbordernone">
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblApply" class="cssClassLabel">Apply:</span>
                            </td>
                            <td class="cssClassTableRightCol">
                                <select id="CartPriceRule-cboApply" class="cssClassDropDown">
                                    <option value="1">Percent of product price discount</option>
                                    <option value="2">Fixed amount discount</option>
                                    <option value="3">Fixed amount discount for whole cart</option>
                                    <option value="4">Buy X get Y free (discount Qty[Y] is Value)</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblValue" class="cssClassLabel">Value:</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtValue" name="Value" class="cssClassNormalTextBox required"/>
                                <span id="percError" style="color: #ED1C24;" ></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblDiscountQuantity" class="cssClassLabel">Maximum Qty Discount
                                    is Applied To:</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtDiscountQuantity" name="MaximumQtyDiscountAppliedTo"
                                       class="cssClassNormalTextBox" />
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblDiscountStep" class="cssClassLabel">Discount Qty Step (Buy
                                    X):</span>
                            </td>
                            <td>
                                <input type="text" id="CartPriceRule-txtDiscountStep" name="DiscountQtyStep" class="cssClassNormalTextBox" />
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblApplytoShippingAmount" class="cssClassLabel">Apply To Shipping
                                    Amount:</span>
                            </td>
                            <td>
                                <input type="checkbox" id="CartPriceRule-chkApplytoShippingAmount" class="cssClassCheckBox" />
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblFreeShipping" class="cssClassLabel">Shipping Discount:</span>
                            </td>
                            <td>
                                <select id="CartPriceRule-cboFreeShipping" class="cssClassDropDown">
                                    <option value="0" selected="selected">By Percentage Off</option>
                                    <option value="1">By Fixed Amount</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="cssClassTableLeftCol">
                                <span id="CartPriceRule-lblFurtherRuleProcessing" class="cssClassLabel">Further Rule
                                    Processing:</span>
                            </td>
                            <td>
                                <input type="checkbox" id="CartPriceRule-chkFurtherRuleProcessing" class="cssClassCheckBox" />
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="submit" id="btnSaveCartPricingRule">
                        <span>Save</span></button>
                </p>
                <p>
                    <button type="button" onclick=" CancelCartPricingRule() ">
                        <span>Cancel</span></button>
                </p>
                <p>
                    <button type="button" id="btnResetCartPricingRule" onclick=" ResetCartPricingRule() ">
                        <span>Reset</span></button>
                </p>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
    </div>
</div>
<div id="cartPricingRuleGrid" class="cssClassCommonBox Curve">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblCartPriceRulesGridHeading" runat="server" Text="Cart Price Rules"></asp:Label>
        </h2>
        <div class="cssClassHeaderRight">
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnDeleteCartRules">
                        <span><span>Delete All Selected</span></span></button>
                </p>
                <p>
                    <button type="button" onclick=" AddCartPricingRule() ">
                        <span>Add Pricing Rule</span></button>
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
                            <input type="text" id="txtCartPriceRuleSrc" class="cssClassTextBoxSmall " class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                Start Date:</label>
                            <input type="text" id="txtCartPricingRuleStartDate" class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                End Date:</label>
                            <input type="text" id="txtCartPricingRuleEndDate" class="cssClassTextBoxSmall" />
                        </td>
                        <td>
                            <label class="cssClassLabel">
                                Status</label>
                            <select id="ddlCartPricingRuleIsActive">
                                <option value="">-- All -- </option>
                                <option value="True">Active </option>
                                <option value="False">Inactive </option>
                            </select>
                        </td>
                        <td class="cssClassNone">
                            <div class="cssClassButtonWrapper cssClassPaddingNone">
                                <p>
                                    <button type="button" onclick=" SearchCartPricingRule() ">
                                        <span>Search</span></button>
                                </p>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="loading">
                <img id="ajaxCartPriceImageLoad" />
            </div>
            <div class="log">
            </div>
            <table id="gdvCartPricingRules" width="100%">
            </table>
        </div>
    </div>
</div>