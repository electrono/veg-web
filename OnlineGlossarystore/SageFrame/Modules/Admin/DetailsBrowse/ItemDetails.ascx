<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemDetails.ascx.cs" Inherits="Modules_ASPXDetails__ASPXItemDetails_ItemDetails " %>

<script type="text/javascript" language="javascript">
    var userModuleID = '<%= UserModuleID %>';
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';

    var userName = '<%= userName %>';
    var userEmail = '<%= userEmail %>';
    var cultureName = '<%= cultureName %>';
    var userIP = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var itemId = '<%= itemID %>';
    var itemName = '<%= itemName %>';
    var itemSKU = '<%= itemSKU %>';

    var RelatedItems = '';
    var ItemTags = '';
    var TagNames = '';
    var MyTags = '';
    var UserTags = '';

    var ratingValues = '';
    var ItemsReview = '';

    var arrItemDetailsReviewList = new Array();
    var arrItemReviewList = new Array();
    var arrCostVariants;

    var newObject = new Variable(255, 320, 87, 75);

    function Variable(height, width, thumbWidth, thumbHeight) {
        this.height = height;
        this.width = width;
        this.thumbHeight = thumbHeight;
        this.thumbWidth = thumbWidth;
    }

    /**
    * Callback function that displays the content.
    *
    * Gets called every time the user clicks on a pagination link.
    *
    * @param {int}page_index New Page index
    * @param {jQuery} jq the container with the pagination links as a jQuery object
    */

    function pageselectCallback(page_index, jq) {
        // Get number of elements per pagionation page from form
        var items_per_page = $('#ddlPageSize').val();
        var max_elem = Math.min((page_index + 1) * items_per_page, arrItemReviewList.length);
        $("#tblRatingPerUser").html('');
        //alert(arrItemDetailsReviewList.length + '::' + arrItemReviewList.length);
        // Iterate through a selection of the content and build an HTML string
        ItemsReview = '';
        for (var i = page_index * items_per_page; i < max_elem; i++) {
            BindAverageUserRating(arrItemReviewList[i]);
            ItemsReview += arrItemReviewList[i].ItemReviewID;
        }
        $.each(arrItemDetailsReviewList, function(index, item) {
            if (ItemsReview.indexOf(item.ItemReviewID) != -1) {
                BindPerUserIndividualRatings(item.ItemReviewID, item.ItemRatingCriteria, item.RatingValue);
            }
        });

        $('input.star-rate').rating();
        $("#tblRatingPerUser tr:even").addClass("cssClassAlternativeOdd");
        $("#tblRatingPerUser tr:odd").addClass("cssClassAlternativeEven");
        // Prevent click event propagation
        return false;
    }

    // The form contains fields for many pagiantion optiosn so you can 
    // quickly see the resuluts of the different options.
    // This function creates an option object for the pagination function.
    // This will be be unnecessary in your application where you just set
    // the options once.

    function getOptionsFromForm() {
        var opt = { callback: pageselectCallback };
        opt["items_per_page"] = $('#ddlPageSize').val();
        opt["prev_text"] = "Prev";
        opt["next_text"] = "Next";
        opt["prev_show_always"] = false;
        opt["next_show_always"] = false;

        //        // Avoid html injections in this demo
        //        var htmlspecialchars = { "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }
        //        $.each(htmlspecialchars, function(k, v) {
        //            opt.prev_text = opt.prev_text.replace(k, v);
        //            opt.next_text = opt.next_text.replace(k, v);
        //        })
        return opt;
    }

    $(document).ready(function() {
        if (itemName != "") {
            if ('<%= allowWishListItemDetail %>'.toLowerCase() != 'true') {
                $('#addWishListThis').hide();
            }
            if ('<%= allowCompareItemDetail %>'.toLowerCase() != 'true') {
                $('#addCompareListThis').hide();
            }
            var costVariantsData = '';

            if ($.session("ItemCostVariantData")) {
                costVariantsData = $.session("ItemCostVariantData");
                arrCostVariants = costVariantsData.split(',');
            }
            if (userFriendlyURL) {
                $("#lnkContinueShopping").attr("href", '' + aspxRedirectPath + 'Home.aspx');
            } else {
                $("#lnkContinueShopping").attr("href", '' + aspxRedirectPath + 'Home');
            }

            $("#divEmailAFriend").hide();
            if ('<%= enableEmailFriend %>'.toLowerCase() == 'true') {
                $("#divEmailAFriend").show();
            }

            if (customerId <= 0 && userName.toLowerCase() == "anonymoususer") {
                if ('<%= allowAnonymousReviewRate %>'.toLowerCase() == 'true') {
                    $(".cssClassAddYourReview").show();
                } else {
                    $(".cssClassAddYourReview").hide();
                }
            }
            $("#btnAddToMyCart").hide();
            BindItemQuantityDiscountByUserName(itemSKU);
            GetImageLists(itemSKU);
            BindItemBasicByitemSKU(itemSKU);
            GetFormFieldList(itemSKU);
            //        $("#divReadMore").click(function() {
            //            $("#divItemShortDesc").hide();
            //            $("#divItemFullDesc").show();
            //            $("#divReadMore").hide();
            //            $("#divReadLess").show();
            //        });
            //        $("#divReadLess").click(function() {
            //            $("#divItemShortDesc").show();
            //            $("#divItemFullDesc").hide();
            //            $("#divReadMore").show();
            //            $("#divReadLess").hide();
            //        });
            BindItemAverageRating();
            BindDownloadEvent();
            $("#txtQty").bind('focus', function(e) {
                $(this).val('');
                $('#lblNotification').html('');
            });
            $("#txtQty").bind('select', function(e) {
                $(this).val('');
                $('#lblNotification').html('');
            });
            $("#txtQty").bind('blur', function(e) {
                $('#lblNotification').html('');
            });
            $("#txtQty").bind("keypress", function(e) {
                if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                    if ($("#hdnQuantity").val() <= 0) {
                        return false;
                    } else {
                        if ((e.which >= 48 && e.which <= 57)) {
                            var num;
                            if (e.which == 48)
                                num = 0;
                            if (e.which == 49)
                                num = 1;
                            if (e.which == 50)
                                num = 2;
                            if (e.which == 51)
                                num = 3;
                            if (e.which == 52)
                                num = 4;
                            if (e.which == 53)
                                num = 5;
                            if (e.which == 54)
                                num = 6;
                            if (e.which == 55)
                                num = 7;
                            if (e.which == 56)
                                num = 8;
                            if (e.which == 57)
                                num = 9;

                            var itemQuantityInCart = CheckItemQuantityInCart(itemId);
                            if (itemQuantityInCart != 0.1) { //to test if the item is downloadable or simple(0.1 downloadable)

                                if ((eval($("#txtQty").val() + '' + num) + eval(itemQuantityInCart)) > eval($("#hdnQuantity").val())) {
                                    $('#lblNotification').html('The Quantity Is Greater Than The Available Quantity.');
                                    return false;
                                    //$("#txtQty").val('1');
                                    //$('#lblNotification').html('');

                                } else {
                                    $('#lblNotification').html('');
                                }
                            }

                        }
                    }
                }

                if ($(this).val() == "") {
                    if (e.which != 8 && e.which != 0 && (e.which < 49 || e.which > 57)) {
                        return false;
                    }
                } else {
                    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                        return false;
                    }
                }
            });

            $(".cssClassTotalReviews").click(function() {
                $.metadata.setType("class");
                //BindRatingReviewTab();
                //select the Tab for Rating
                var $tabs = $('#ItemDetails_TabContainer').tabs();
                $tabs.tabs('select', "ItemTab-Reviews");
            });

            BindRatingCriteria();

            $('a.popupAddReview').click(function() {
                BindPopUp();
                ShowPopup(this);
            });

            $(".cssClassClose").click(function() {
                $('#fade, #popuprel2').fadeOut();
            });

            $("#btnSubmitReview").click(function() {
                $("#form1").validate({
                    messages: {
                        urname: {
                            required: '*',
                            minlength: "* (at least 2 chars)"
                        },
                        uremail: {
                            required: '*'
                        },
                        fname: {
                            required: '*',
                            minlength: "* (at least 2 chars)"
                        },
                        femail: {
                            required: '*'
                        },
                        subject: {
                            required: '*',
                            minlength: "* (at least 2 chars)"
                        },
                        message: {
                            required: '*',
                            minlength: "* (at least 100 chars)"
                        },
                        name: {
                            required: '*',
                            minlength: "* (at least 2 chars)"
                        },
                        summary: {
                            required: '*',
                            minlength: "* (at least 2 chars)"
                        },
                        review: {
                            required: '*',
                            minlength: "*"
                        }
                    },
                    //success: "valid",
                    submitHandler: function() { SaveItemRatings(); }
                });
            });

            $('a.popupEmailAFriend').click(function() {
                ShowUsingPage();
                //ShowPopup(this);
            });

            $("#addWishListThis").click(function() {
                if (customerId > 0 && userName.toLowerCase() != "anonymoususer") {
                    CheckWishListUniqueness(itemId);
                } else {
                    Login();
                }
            });

            function CheckWishListUniqueness(itemID) {
                var checkparam = { ID: itemID, storeID: storeId, portalID: portalId, userName: userName };
                var checkdata = JSON2.stringify(checkparam);
                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckWishItems",
                    data: checkdata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        if (msg.d) {
                            csscody.alert('<h2>Information Alert</h2><p>The selected item is already in your wish list.</p>');
                        } else {
                            AddToWishListFromJS(itemID, storeId, portalId, userName, userIP, countryName); // AddToList ==> AddToWishList
                        }
                    }
                });
            }

            $("#addCompareListThis").click(function() {
                AddItemsToMyCompare(itemId);
            });

            function AddItemsToMyCompare(itemId) {
                var countCompareItems = GetCompareItemsCount();
                if (countCompareItems >= '<%= maxCompareItemCount %>') {
                    csscody.alert('<h2>Information Alert</h2><p>You cannot add more than <%= maxCompareItemCount %> items to your comparelist!</p>');
                    return false;
                }
                var checkparam = { ID: itemId, storeID: storeId, portalID: portalId, userName: userName, sessionCode: sessionCode };

                var checkdata = JSON2.stringify(checkparam);
                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckCompareItems",
                    data: checkdata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        if (msg.d) {
                            csscody.alert("<h2>Information Alert</h2><p>The selected item is already in your compare list!</p>");
                        } else {
                            AddToMyCompareList(itemId);
                        }
                    },
                    error: function(msg) {
                        csscody.error('<h2>Error Message</h2><p>Error!</p>');
                    }
                });
            }

            function AddToMyCompareList(itemId) {
                var addparam = { ID: itemId, storeID: storeId, portalID: portalId, userName: userName, IP: userIP, countryName: countryName, sessionCode: sessionCode };
                var adddata = JSON2.stringify(addparam);
                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveCompareItems",
                    data: adddata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function(msg) {
                        csscody.alert("<h2>Information Message</h2><p>Item Successfully Added To your Compare List.</p>");
                        if ($("#h2compareitems").length > 0) {
                            GetCompareItemList(); //for MyCompareItem 
                        }
                    },
                    error: function(msg) {
                        csscody.error('<h2>Error Message</h2><p>Error!</p>');
                    }
                });
            }
        } else {
            $('#itemDetails').hide();
            if (userFriendlyURL) {
                window.location = aspxRedirectPath + "Home.aspx";
            } else {
                window.location = aspxRedirectPath + "Home";
            }
        }
    });

    function GetCompareItemsCount() {
        var countCompareItems;
        var param = { storeID: storeId, portalID: portalId, sessionCode: sessionCode };
        var Data = JSON2.stringify(param);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCompareItemsCount",
            data: Data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                countCompareItems = msg.d;
            },
            error: function(msg) {
                csscody.error('<h2>Error Message</h2><p>Error!</p>');
            }
        });
        return countCompareItems;
    }

    function BindDownloadEvent() {
        $(".cssClassLink").jDownload({
            root: '<%= aspxfilePath %>',
            dialogTitle: 'ASPXCommerce Download Sample Item:'
        });
    }

    function BindItemQuantityDiscountByUserName(itemSKU) {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, itemSKU: itemSKU });
        $.ajax({
            type: 'post',
            url: aspxservicePath + 'ASPXCommerceWebService.asmx/GetItemQuantityDiscountByUserName',
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                $("#itemQtyDiscount>tbody").html();
                if (msg.d.length > 0) {
                    $("#bulkDiscount").html('(Bulk Discount available)');
                    var qytDiscount = '';
                    $.each(msg.d, function(index, item) {
                        qytDiscount += "<tr><td>" + item.Quantity + "</td><td><span class='cssClassFormatCurrency'>" + item.Price + "</span></td></tr>";
                    });
                    $("#itemQtyDiscount>tbody").append(qytDiscount);
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                    $("#itemQtyDiscount > tbody tr:even").addClass("cssClassAlternativeEven");
                    $("#itemQtyDiscount > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#bulkDiscount").hide();
                    $("#divQtyDiscount").hide();
                }
            }
        //            ,
        //            error: function(errorMessage) {
        //                csscody.error('<h2>Error Message</h2><p>Error!</p>');
        //            }
        });
    }

    function GetCostVariantsByitemSKU(itemSKU) {
        $('#divCostVariant').html('');
        var param = JSON2.stringify({ _storeID: storeId, _portalID: portalId, _cultureName: cultureName, _userName: userName, _itemSKU: itemSKU });
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCostVariantsByitemSKU",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    var CostVariant = '';
                    $.each(msg.d, function(index, item) {
                        if (CostVariant.indexOf(item.CostVariantID) == -1) {
                            CostVariant += item.CostVariantID;
                            var addSpan = '';
                            addSpan += '<div id="div_' + item.CostVariantID + '" class="cssClassHalfColumn">';
                            addSpan += '<span id="spn_' + item.CostVariantID + '" >' + item.CostVariantName + ': ' + '</span>';
                            addSpan += '</div>';
                            $('#divCostVariant').append(addSpan);
                        }
                        var valueID = '';
                        var itemCostValueName = '';
                        if (item.CostVariantsValueID != -1) {
                            if (item.InputTypeID == 5 || item.InputTypeID == 6) {
                                if ($('#controlCostVariant_' + item.CostVariantID + '').length == 0) {
                                    itemCostValueName += '<div class="cssClassDropDown" id="subDiv' + item.CostVariantID + '">'
                                    valueID = 'controlCostVariant_' + item.CostVariantID;
                                    itemCostValueName += CreateControl(item, valueID, false);

                                    itemCostValueName += "</div>";
                                    $('#div_' + item.CostVariantID + '').append(itemCostValueName);
                                }
                                //Blue (+10%)
                                //Red (+$10.00)

                                optionValues = BindInsideControl(item, valueID);
                                // alert('#controlCostVariant_' + item.CostVariantID + '');
                                $('#controlCostVariant_' + item.CostVariantID + '').append(optionValues);
                                $('#controlCostVariant_' + item.CostVariantID + ' option:first-child').attr("selected", "selected");
                            } else {
                                if ($('#subDiv' + item.CostVariantID + '').length == 0) {
                                    itemCostValueName += '<div class="cssClassRadio" id="subDiv' + item.CostVariantID + '">'
                                    valueID = 'controlCostVariant_' + item.CostVariantID;
                                    itemCostValueName += CreateControl(item, valueID, true);
                                    itemCostValueName += "</div>";
                                    $('#div_' + item.CostVariantID + '').append(itemCostValueName);
                                } else {
                                    valueID = 'controlCostVariant_' + item.CostVariantID;
                                    itemCostValueName += CreateControl(item, valueID, false);
                                    $('#subDiv' + item.CostVariantID + '').append(itemCostValueName);
                                }
                            }
                        }
                    });
                    $('#divCostVariant').append('<div class="cssClassClear"></div>');

                    if ($.session("ItemCostVariantData") != undefined) {
                        $.each(arrCostVariants, function(i, variant) {
                            var itemColl = $("#divCostVariant").find("[Variantname=" + variant + "]");
                            //alert($("#divCostVariant").html());
                            // alert($(itemColl)
                            if ($(itemColl).is("input[type='checkbox'] ,input[type='radio']")) {
                                $("#divCostVariant").find("input:checkbox").removeAttr("checked");
                                $(itemColl).attr("checked", "checked");
                            } else if ($(itemColl).is('select>option')) {
                                $("#divCostVariant").find("select>option").removeAttr("selected");
                                $(itemColl).attr("selected", "selected");
                            }

                        });
                        $.session("ItemCostVariantData", 'empty');
                    }
                    //to bind the item price according to the selection of the cost variant
                    $('#divCostVariant select,input[type=radio],input[type=checkbox]').bind("change", function() {
                        var weightWithVariant = 0;
                        var priceWithVariant = 0;
                        $("#divCostVariant select option:selected").each(function() {
                            if ($(this).attr('variantvalue') != undefined) {
                                priceWithVariant += $(this).attr('variantvalue');
                            }
                            if ($(this).attr('variantwtvalue') != undefined) {
                                weightWithVariant += $(this).attr('variantwtvalue');
                            }
                        });

                        $("#divCostVariant input[type=radio]:checked").each(function() {
                            if ($(this).attr('variantvalue') != undefined) {
                                priceWithVariant += $(this).attr('variantvalue');
                            }
                            if ($(this).attr('variantwtvalue') != undefined) {
                                weightWithVariant += $(this).attr('variantwtvalue');
                            }
                        });

                        $("#divCostVariant input[type=checkbox]:checked").each(function() {
                            if ($(this).attr('variantvalue') != undefined) {
                                priceWithVariant += $(this).attr('variantvalue');
                            }
                            if ($(this).attr('variantwtvalue') != undefined) {
                                weightWithVariant += $(this).attr('variantwtvalue');
                            }
                        });
                        $("#spanPrice").html(eval($("#hdnPrice").val()) + eval(priceWithVariant));
                    }).trigger('change');
                    //end 
                }
            },
            error: function(errorMessage) {
                csscody.error('<h2>Error Message</h2><p>Error!</p>');
            }
        });
    }

    function CreateControl(item, controlID, isChecked) {
        var controlElement = '';
        var costPriceValue = item.CostVariantsPriceValue;
        var weightValue = item.CostVariantsWeightValue;
        //alert(costPriceValue + '::' + weightValue + '::' + $("#hdnWeight").val());
        if (item.InputTypeID == 5) { //MultipleSelect
            //if (isChecked) {
            controlElement = "<select id='" + controlID + "' multiple></select>";
            //}
            //else {
            //    controlElement = "<select id='" + controlID + "' multiple></select>";
            //}
        } else if (item.InputTypeID == 6) { //DropDown
            controlElement = "<select id='" + controlID + "'></select>";
        } else if (item.InputTypeID == 9 || item.InputTypeID == 10) { //Radio //RadioLists
            if (costPriceValue != '' || costPriceValue != 0) {
                if (costPriceValue > 0) {
                    costPriceValue = '+' + costPriceValue;
                }

                if (weightValue > 0) {
                    weightValue = '+' + weightValue;
                }
                if (item.IsPriceInPercentage) {
                    if (item.IsWeightInPercentage) {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' checked='checked' value='" + item.CostVariantsValueID + "' variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' value='" + item.CostVariantsValueID + "'  variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        }
                    } else {
                        if (isChecked) {
                            controlElement = "<input  VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' checked='checked' value='" + item.CostVariantsValueID + "' variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' value='" + item.CostVariantsValueID + "'  variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        }
                    }
                } else {
                    if (item.IsWeightInPercentage) {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' checked='checked' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        }
                    } else {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' checked='checked' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        }
                    }
                }
            } else {
                if (isChecked) {
                    controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' checked='checked' value='" + item.CostVariantsValueID + "'><label>" + item.CostVariantsValueName + "</label>";
                } else {
                    controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='radio' value='" + item.CostVariantsValueID + "'><label>" + item.CostVariantsValueName + "</label>";
                }
            }
        } else if (item.InputTypeID == 11 || item.InputTypeID == 12) { //CheckBox //CheckBoxLists
            if (costPriceValue != '' || costPriceValue != 0) {
                if (costPriceValue > 0) {
                    costPriceValue = '+' + costPriceValue;
                }
                if (weightValue > 0) {
                    weightValue = '+' + weightValue;
                }
                if (item.IsPriceInPercentage) {
                    if (item.IsWeightInPercentage) {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' checked='checked' value='" + item.CostVariantsValueID + "' variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' value='" + item.CostVariantsValueID + "'  variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        }
                    } else {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' checked='checked' value='" + item.CostVariantsValueID + "' variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' value='" + item.CostVariantsValueID + "'  variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</label>";
                        }
                    }
                } else {
                    if (item.IsWeightInPercentage) {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' checked='checked' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        }
                    } else {
                        if (isChecked) {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' checked='checked' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        } else {
                            controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' value='" + item.CostVariantsValueID + "'  variantvalue='" + costPriceValue + "' variantwtvalue='" + weightValue + "'><label>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</label>";
                        }
                    }
                }
            } else {
                if (isChecked) {
                    controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' checked='checked' value='" + item.CostVariantsValueID + "'><label>" + item.CostVariantsValueName + "</label>";
                } else {
                    controlElement = "<input VariantName='" + item.CostVariantsValueName + "' name='" + controlID + "' type='checkbox' value='" + item.CostVariantsValueID + "'><label>" + item.CostVariantsValueName + "</label>";
                }
            }
        }
        return controlElement;
    }

    function BindInsideControl(item, controlID) {
        var optionValues = '';
        var costPriceValue = item.CostVariantsPriceValue;
        var weightValue = item.CostVariantsWeightValue;
        if (item.InputTypeID == 5) { //MultipleSelect 
            if (costPriceValue != '') {
                if (costPriceValue > 0) {
                    costPriceValue = '+' + costPriceValue;
                }
                if (weightValue > 0) {
                    weightValue = '+' + weightValue;
                }
                if (item.IsPriceInPercentage) {
                    if (item.IsWeightInPercentage) {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</option>";

                    } else {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue=" + weightValue + ">" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</option>";
                    }
                } else {
                    if (item.IsWeightInPercentage) {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue=" + costPriceValue + " variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</option>";

                    } else {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue=" + costPriceValue + " variantwtvalue=" + weightValue + ">" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</option>";
                    }
                }
            } else {

                optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + ">" + item.CostVariantsValueName + "</option>";
            }
        } else if (item.InputTypeID == 6) { //DropDown
            if (costPriceValue != '') {
                if (costPriceValue > 0) {
                    costPriceValue = '+' + costPriceValue;
                }
                if (weightValue > 0) {
                    weightValue = '+' + weightValue;
                }
                if (item.IsPriceInPercentage) {
                    if (item.IsWeightInPercentage) {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'>" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</option>";

                    } else {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue='" + '+' + (($("#hdnPrice").val() * costPriceValue) / 100) + "' variantwtvalue=" + weightValue + ">" + item.CostVariantsValueName + ' (' + costPriceValue + '%)' + "</option>";
                    }
                } else {
                    if (item.IsWeightInPercentage) {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue=" + costPriceValue + " variantwtvalue='" + '+' + (($("#hdnWeight").val() * weightValue) / 100) + "'>" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</option>";
                    } else {

                        optionValues = "<option VariantName='" + item.CostVariantsValueName + "' value=" + item.CostVariantsValueID + " variantvalue=" + costPriceValue + " variantwtvalue=" + weightValue + ">" + item.CostVariantsValueName + ' (' + costPriceValue + ')' + "</option>";
                    }
                }
            } else {

                optionValues = "<option VariantName='" + item.CostVariantsValueName + "'  value=" + item.CostVariantsValueID + ">" + item.CostVariantsValueName + "</option>";
            }
        }
        return optionValues;
    }

    function BindRatingReviewTab() {
        $("#tblRatingPerUser").html('');
        GetItemRatingPerUser();
    }

    function BindItemAverageRating() {
        var param = JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemAverageRating",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $(".cssClassAddYourReview").html("Write Your Own Review");
                    $(".cssClassItemRatingBox").addClass('cssClassToolTip');
                    $.each(msg.d, function(index, item) {
                        if (index == 0) {
                            $(".cssClassTotalReviews").html('Read Reviews [' + item.TotalReviewsCount + '] ');
                            BindStarRating(item.TotalRatingAverage);
                        }
                        BindViewDetailsRatingInfo(item.ItemRatingCriteriaID, item.ItemRatingCriteria, item.RatingCriteriaAverage);
                    });
                    $('input.star').rating();
                } else {
                    var avgRating = "<tr><td>Currently there are no reviews</td></tr>";
                    $("#tblAverageRating").append(avgRating);
                    $(".cssClassItemRatingBox").removeClass('cssClassToolTip');

                    $(".cssClassSeparator").hide();
                    $(".cssClassAddYourReview").html("Be the first to review this item");
                }
            }
        //            error: function() {
        //                csscody.error('<h2>Error Message</h2><p>Error!</p>');
        //            }
        });
    }

    function BindStarRating(itemAvgRating) {
        var ratingStars = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        ratingStars += '<tr><td>';
        for (i = 0; i < 10; i++) {
            if (itemAvgRating == ratingText[i]) {
                ratingStars += '<input name="avgItemRating" type="radio" class="star {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
                $(".cssClassRatingTitle").html(ratingTitle[i]);
            } else {
                ratingStars += '<input name="avgItemRating" type="radio" class="star {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        ratingStars += '</td></tr>';
        $("#tblAverageRating").append(ratingStars);
    }

    function BindViewDetailsRatingInfo(itemRatingCriteriaId, itemRatingCriteria, ratingCriteriaAverage) {
        var ratingStarsDetailsInfo = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        ratingStarsDetailsInfo += '<div class="cssClassToolTipDetailInfo">';
        ratingStarsDetailsInfo += '<span class="cssClassCriteriaTitle">' + itemRatingCriteria + ': </span>';
        for (i = 0; i < 10; i++) {
            if (ratingCriteriaAverage == ratingText[i]) {
                ratingStarsDetailsInfo += '<input name="avgItemDetailRating' + itemRatingCriteriaId + '" type="radio" class="star {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
            } else {
                ratingStarsDetailsInfo += '<input name="avgItemDetailRating' + itemRatingCriteriaId + '" type="radio" class="star {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        ratingStarsDetailsInfo += '</div>';
        $("Div.cssClassToolTipInfo").append(ratingStarsDetailsInfo);
    }

    function GetItemRatingPerUser() {
        ItemsReview = '';
        var param = JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingPerUser",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                arrItemDetailsReviewList.length = 0;
                arrItemReviewList.length = 0;
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindItemsRatingByUser(item, index);
                    });
                    // Create pagination element with options from form
                    var optInit = getOptionsFromForm();
                    $("#Pagination").pagination(arrItemReviewList.length, optInit);
                    $("#divSearchPageNumber").show();
                } else {
                    $("#divSearchPageNumber").hide();
                    //alert("No user rating is found!");
                    var avgRating = "<tr><td>Currently there are no reviews</td></tr>";
                    $("#tblRatingPerUser").append(avgRating);
                }
            }
        //            ,
        //            error: function() {
        //                csscody.error('<h2>Error Message</h2><p>Error!</p>');
        //            }
        });
    }

    function BindItemsRatingByUser(item, index) {
        arrItemDetailsReviewList.push(item);

        if (ItemsReview.indexOf(item.ItemReviewID) == -1) {
            ItemsReview += item.ItemReviewID;

            arrItemReviewList.push(item);
        }
    }

    function BindAverageUserRating(item) {
        var userRatings = '';
        userRatings += '<tr><td><div class="cssClassRateReview"><div class="cssClassItemRating">';
        userRatings += '<div class="cssClassItemRatingBox">' + BindStarRatingAveragePerUser(item.ItemReviewID, item.RatingAverage) + '</div>';
        userRatings += '<div class="cssClassRatingInfo"><p>' + Encoder.htmlDecode(item.ReviewSummary) + '<span> Review by <strong>' + item.Username + '</strong></span></p></div></div>';
        userRatings += '<div class="cssClassRatingReviewDesc"><p>' + Encoder.htmlDecode(item.Review) + '</p></div>';
        userRatings += '<div class="cssClassRatingReviewDate"><p> (Posted on <strong>' + formatDate(new Date(item.AddedOn), "yyyy/M/d hh:mm:ssa") + '</strong>)</p></div>';
        userRatings += '</div></td></tr>';
        $("#tblRatingPerUser").append(userRatings);
        var ratingToolTip = $("#hdnRatingTitle" + item.ItemReviewID + "").val();
        $(".cssClassUserRatingTitle_" + item.ItemReviewID + "").html(ratingToolTip);
    }

    function BindStarRatingAveragePerUser(itemReviewID, itemAvgRating) {
        var ratingStars = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        var ratingTitleText = '';
        ratingStars += '<div class="cssClassRatingStar"><div class="cssClassToolTip">';
        ratingStars += '<span class="cssClassRatingTitle cssClassUserRatingTitle_' + itemReviewID + '"></span>';
        for (i = 0; i < 10; i++) {
            if (itemAvgRating == ratingText[i]) {
                ratingStars += '<input name="avgRatePerUser' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
                ratingTitleText = ratingTitle[i];
            } else {
                ratingStars += '<input name="avgRatePerUser' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        ratingStars += '<input type="hidden" value="' + ratingTitleText + '" id="hdnRatingTitle' + itemReviewID + '"></input><span class="cssClassToolTipInfo cssClassReviewId_' + itemReviewID + '"></span></div></div><div class="cssClassClear"></div>';
        return ratingStars;
    }

    function BindPerUserIndividualRatings(itemReviewID, itemRatingCriteria, ratingValue) {
        var userRatingStarsDetailsInfo = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        userRatingStarsDetailsInfo += '<div class="cssClassToolTipDetailInfo">';
        userRatingStarsDetailsInfo += '<span class="cssClassCriteriaTitle">' + itemRatingCriteria + ': </span>';
        for (i = 0; i < 10; i++) {
            if (ratingValue == ratingText[i]) {
                userRatingStarsDetailsInfo += '<input name="avgUserDetailRate' + itemRatingCriteria + '_' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
            } else {
                userRatingStarsDetailsInfo += '<input name="avgUserDetailRate' + itemRatingCriteria + '_' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        userRatingStarsDetailsInfo += '</div>';
        $('#tblRatingPerUser span.cssClassReviewId_' + itemReviewID + '').append(userRatingStarsDetailsInfo);
    }

    function BindPopUp() {
        ClearReviewForm();
        $("#lblYourReviewing").html('You\'re Reviewing: ' + itemName + '');
        if (userName.toLowerCase() != "anonymouseuser") {
            $("#txtUserName").val(userName);
        }
        $.metadata.setType("attr", "validate");
        $('.auto-submit-star').rating({
            required: false,
            focus: function(value, link) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var tip = $('#hover-test' + ratingCriteria_id);
                tip[0].data = tip[0].data || tip.html();
                tip.html(link.title || 'value: ' + value);
                $("#tblRatingCriteria label.error").hide();
            },
            blur: function(value, link) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var tip = $('#hover-test' + ratingCriteria_id);
                tip.html('<span class="cssClassToolTip">' + tip[0].data || '' + '</span>');
                $("#tblRatingCriteria label.error").hide();
            },

            callback: function(value, event) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var starRatingValues = $(this).attr("value");
                var len = ratingCriteria_id.length;
                var isAppend = true;
                if (ratingValues != '') {
                    var stringSplit = ratingValues.split('#');
                    $.each(stringSplit, function(index, item) {
                        if (item.substring(0, item.indexOf('-')) == ratingCriteria_id) {
                            var index = ratingValues.indexOf(ratingCriteria_id + "-");
                            var toReplace = ratingValues.substr(index, 2 + len);
                            ratingValues = ratingValues.replace(toReplace, ratingCriteria_id + "-" + value);
                            isAppend = false;
                        }
                    });
                    if (isAppend) {
                        ratingValues += ratingCriteria_id + "-" + starRatingValues + "#" + '';
                    }
                } else {
                    ratingValues += ratingCriteria_id + "-" + starRatingValues + "#" + '';
                }
            }
        });
    }

    function BindRatingCriteria() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, isFlag: false });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingCriteria",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        RatingCriteria(item);
                    });
                } else {
                    csscody.alert("<h2>Error Message</h2><p>No criteria for rating found!</p>");
                }
            },
            error: function() {
                // csscody.error('<h2>Error Message</h2><p>Error!</p>');
            }
        });
    }

    function RatingCriteria(item) {
        var ratingCriteria = '';
        ratingCriteria += '<tr><td class="cssClassReviewCriteria"><label class="cssClassLabel">' + item.ItemRatingCriteria + ':<span class="cssClassRequired">*</span></label></td><td>';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star" value="1" title="Worst" validate="required:true" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star" value="2" title="Bad" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star" value="3" title="OK" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star" value="4" title="Good" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star" value="5" title="Best" />';
        ratingCriteria += '<span id="hover-test' + item.ItemRatingCriteriaID + '" class="cssClassRatingText"></span>';
        ratingCriteria += '<label for="star' + item.ItemRatingCriteriaID + '" class="error">Please rate for ' + item.ItemRatingCriteria + '</label></td></tr>';
        $("#tblRatingCriteria").append(ratingCriteria);
    }

    function ClearReviewForm() {
        //Clear all Stars checked      
        $('.auto-submit-star').rating('drain');
        $('.auto-submit-star').removeAttr('checked');
        $('.auto-submit-star').rating('select', -1);

        $("#txtUserName").val('');
        $("#txtSummaryReview").val('');
        $("#txtReview").val('');
        $("label.error").hide();
    }

    function SaveItemRatings() {
        var statusId = 2;
        var ratingValue = ratingValues;
        var nickName = $("#txtUserName").val();
        var summaryReview = $("#txtSummaryReview").val();
        var review = $("#txtReview").val();
        var param = JSON2.stringify({ ratingCriteriaValue: ratingValue, statusID: statusId, summaryReview: summaryReview, review: review, userIP: userIP, viewFromCountry: countryName, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, addedBy: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveItemRating",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                csscody.alert("<h2>Information Message</h2><p>Your review has been accepted for moderation!</p>");
                $('#fade, #popuprel2').fadeOut();
                //$('#fade , #popuprel , #popuprel2 , #popuprel3').fadeOut();
                //ClearReviewForm();
            },
            error: function() {
                csscody.error('<h2>Error Message</h2><p>Error!</p>');
            }
        });
    }

    function ShowUsingPage() {
        $.metadata.setType("attr", "validate");
        var ControlName = "Modules/ASPXCommerce/ASPXReferToFriend/ReferAFriend.ascx";
        //var ControlName = rootPath + "Modules/ASPXCommerce/ASPXReferToFriend/ReferAFriend.ascx";         
        $.ajax({
            type: "POST",
            //aspxservicePath + 'ASPXCommerceWebService.asmx/GetItemFormAttributesByitemSKUOnly'
            //url: "ShowDetailsPage.aspx/Result",
            url: aspxservicePath + "LoadControlHandler.aspx/Result",
            data: "{ controlName:'" + aspxRootPath + ControlName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                $('#controlload').html(response.d);
            },
            error: function(msg) {
                $('#controlload').html(msg.d);
            }
        });
    }

    function BindItemBasicByitemSKU(itemSKU) {
        var checkparam = { itemSKU: itemSKU, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName };
        var checkdata = JSON2.stringify(checkparam);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemBasicInfoByitemSKU",
            data: checkdata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d != null) {
                    BindItemsBasicInfo(msg.d);
                    GetCostVariantsByitemSKU(itemSKU);
                    //BindCostVariantOptions(itemSKU);
                    $('.popupEmailAFriend').attr('imagepath', msg.d.ImagePath);
                    //This adds Recently View table and also update item's viewed count table
                    AddUpdateRecentlyViewedItem(itemSKU);

                    GetYouMayAlsoLikeItemsList();
                    //                
                    //                BindRelatedItems(itemSKU);
                    //                BindCrossSellItems(itemSKU);
                    //                BindUpSellItems(itemSKU);    
                }
            }
        //            ,
        //            error: function(msg) {
        //                csscody.alert('<h2>Information Alert</h2><p>Failed to load the item details!</p>');
        //            }
        });
    }

    var FormCount = new Array();

    function GetFormFieldList(itemSKU) {
        var attributeSetId = 0;
        var itemTypeId = 0;
        $.ajax({
            type: "POST",
            url: aspxservicePath + 'ASPXCommerceWebService.asmx/GetItemFormAttributesByitemSKUOnly',
            data: JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                $.each(data.d, function(index, item) {
                    if (index == 0) {
                        attributeSetId = item.AttributeSetID;
                        itemTypeId = item.ItemTypeID;
                    }
                });
                CreateForm(data.d, attributeSetId, itemTypeId, itemSKU);
                if (itemSKU.length > 0) {
                    BindDataInTab(itemSKU, attributeSetId, itemTypeId);
                    BindRatingReviewTab();
                }
            }
        });
    }

    function CreateForm(itemFormFields, attributeSetId, itemTypeId, itemSKU) {
        var strDyn = '';
        var attGroup = new Array();
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
        $.each(itemFormFields, function(index, item) {
            strDynRow = createRow(itemSKU, item.AttributeID, item.AttributeName, item.InputTypeID, item.InputTypeValues != "" ? eval(item.InputTypeValues) : '', item.DefaultValue, item.ToolTip, item.Length, item.ValidationTypeID, item.IsEnableEditor, item.IsUnique, item.IsRequired, item.GroupID, item.IsIncludeInPriceRule, item.IsIncludeInPromotions, item.DisplayOrder);
            //strDynRow = '<table width="100%" border="0" cellpadding="0" cellspacing="0">' + strDynRow + '</table>';
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == item.GroupID) {
                    attGroup[i].html += strDynRow;
                }
            }
        });
        CreateTabPanel(attGroup, attributeSetId, itemTypeId);
    }

    function createRow(itemSKU, attID, attName, attType, attTypeValue, attDefVal, attToolTip, attLen, attValType, isEditor, isUnique, isRequired, groupId, isIncludeInPriceRule, isIncludeInPromotions, displayOrder) {
        var retString = '';
        retString += '<tr><td class="cssClassTableLeftCol"><label class="cssClassLabel">' + attName + ': </label></td>';
        retString += '<td><div id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + '_' + groupId + '_' + isIncludeInPriceRule + '_' + isIncludeInPromotions + '_' + displayOrder + '" title="' + attToolTip + '">';
        retString += '</div></td>';
        retString += '</tr>';
        return retString;
    }

    function CreateTabPanel(attGroup, attributeSetId, itemTypeId) {
        if (FormCount) {
            FormCount = new Array();
        }
        var FormID = "form_" + (FormCount.length * 10 + Math.floor(Math.random() * 10));
        FormCount[FormCount.length] = FormID;
        var dynHTML = '';
        var itemTabs = '';
        var tabBody = '';
        dynHTML += '<div class="cssClassTabPanelTable">';
        dynHTML += '<div id="ItemDetails_TabContainer" class="cssClassTabpanelContent cssClassTabTopBorder">';
        dynHTML += '<ul>';
        for (var i = 0; i < attGroup.length; i++) {
            itemTabs += '<li><a href="#ItemTab-' + attGroup[i].key + '"><span>' + attGroup[i].value + '</span></a>';
            tabBody += '<div id="ItemTab-' + attGroup[i].key + '"><table border="0" cellpadding="0" cellspacing="0">' + attGroup[i].html + '</table></div></li>';
        }
        //Add Static sections here Product Reviews, Product Tags, Customers Tagged Product
        //Tags part Starts HERE
        itemTabs += '<li><a href="#ItemTab-Tags"><span>Tags</span></a>';
        var itemTagsBody = '';
        itemTagsBody += '<div class="cssClassPopularItemTags"><strong>PopularTags:</strong><div id="divItemTags" class="cssClassPopular-Itemstags"></div>';
        //TOSHow only if user is logged in
        if (customerId > 0 && userName.toLowerCase() != "anonymoususer") {
            itemTagsBody += '<strong>My Tags:</strong><div id="divMyTags" class="cssClassMyTags"></div>';
            itemTagsBody += '<table id="AddTagTable"><tr><td>';
            itemTagsBody += '<input type="text" class="classTag" />';
            itemTagsBody += '<button class="cssClassDecrease" type="button"><span>-</span></button>';
            itemTagsBody += '<button class="cssClassIncrease" type="button"><span>+</span></button>';
            itemTagsBody += '</td></tr></table>';
            itemTagsBody += '<div class="cssClassButtonWrapper"><button type="button" id="btnTagSubmit"><span><span>Add Tag</span></span></button></div></div>';
            //Else Show Please log in link
        } else {
            itemTagsBody += '<a href="' + aspxRedirectPath + 'Login.aspx?ReturnUrl=' + aspxRedirectPath + 'item/' + itemSKU + '.aspx" class="cssClassLogIn"><span>Sign in to enter tags</span></a>';
        }
        tabBody += '<div  id="ItemTab-Tags"><table width="100%" border="0" cellpadding="0" cellspacing="0"><tr><td>' + itemTagsBody + '</tr></td></table></div></li>';
        //Tags part Ends HERE

        //Review and Rating Starts Here
        itemTabs += '<li><a href="#ItemTab-Reviews"><span>Ratings & Reviews </span></a>';
        tabBody += '<div id="ItemTab-Reviews"><table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblRatingPerUser"></table>';
        //Paging Parts here
        tabBody += '<div class="cssClassPageNumber" id="divSearchPageNumber"><div class="cssClassPageNumberLeftBg"><div class="cssClassPageNumberRightBg"><div class="cssClassPageNumberMidBg">';
        tabBody += '<div id="Pagination"></div><div class="cssClassViewPerPage">View Per Page<select id="ddlPageSize" class="cssClassDropDown">';
        tabBody += '<option value="5">5</option><option value="10">10</option><option value="15">15</option><option value="20">20</option><option value="25">25</option><option value="40">40</option></select></div>';
        tabBody += '</div></div></div></div></li>';
        //Review and Rating Ends Here

        dynHTML += itemTabs;
        dynHTML += '</ul>';
        dynHTML += tabBody;
        var frmIDQuoted = "'" + FormID + "'";
        var buttons = '<div class="cssClassClear"></div>';
        $("#dynItemDetailsForm").html('<div id="' + FormID + '" class="cssClassFormWrapper">' + dynHTML + buttons + '</div>');
        $("#dynItemDetailsForm").find(".cssClassIncrease").click(function() {
            var cloneRow = $(this).closest('tr').clone(true);
            $(cloneRow).appendTo("#AddTagTable");
            $(cloneRow).find("input[type='text']").val('');
            $(this).remove();
        });

        $("#dynItemDetailsForm").find(".cssClassDecrease").click(function() {
            var cloneRow = $(this).closest('tr');
            if (cloneRow.is(":last-child")) {
                var prevTR = $(cloneRow).prev('tr');
                var prevTagTitle = prevTR.find("input[type='text']").val();
                prevTR.remove();
                $(cloneRow).find("input[type='text']").val(prevTagTitle)
                return false;
            } else {
                $(cloneRow).remove();
            }
        });

        $("#dynItemDetailsForm").find("#btnTagSubmit").click(function() {
            SubmitTag();
        });

        $("#dynItemDetailsForm").find("#ddlPageSize").change(function() {
            // Create pagination element with options from form
            var optInit = getOptionsFromForm();
            $("#Pagination").pagination(arrItemReviewList.length, optInit);
        });

        var $tabs = $('#ItemDetails_TabContainer').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        ; // first tab selected
        $tabs.tabs('select', 0);
    }

    function BindDataInTab(itemSKU, attributeSetId, itemTypeId) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + 'ASPXCommerceWebService.asmx/GetItemDetailsByitemSKU',
            data: JSON2.stringify({ itemSKU: itemSKU, attributeSetID: attributeSetId, itemTypeID: itemTypeId, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                $.each(data.d, function(index, item) {
                    FillItemAttributes(itemSKU, item);
                });
                GetItemTags();
                //BindDownloadUpEvent();
            },
            error: function(msg) {
                //  csscody.alert('<h2>Information Alert</h2><p>Failed to load the item details!</p>');
            }
        });
    }

    function GetItemTags() {
        ItemTags = '';
        TagNames = '';
        MyTags = '';
        UserTags = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemTags",
            data: JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindItemTags(item, index);
                });
                $("#divItemTags").html(ItemTags.substring(0, ItemTags.length - 2));
                $("#divMyTags").html(MyTags.substring(0, MyTags.length - 2));
            },
            error: function(msg) {
                csscody.error('<h2>Error Message</h2><p>Error!</p>');
            }
        });
    }

    function BindItemTags(item, index) {
        if (TagNames.indexOf(item.Tag) == -1) {
            ItemTags += item.Tag + "(" + item.TagCount + "), ";
            TagNames += item.Tag;
        }

        if (item.AddedBy == userName) {
            if (UserTags.indexOf(item.Tag) == -1) {
                MyTags += item.Tag + "<button type=\"button\" class=\"cssClassCross\" value=" + item.ItemTagID + " onclick ='DeleteMyTag(this)'><span>x</span></button>, ";
                UserTags += item.Tag;
            }
        }
    }

    function DeleteMyTag(obj) {
        var itemTagId = $(obj).attr("value");
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteUserOwnTag",
            data: JSON2.stringify({ itemTagID: itemTagId, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                GetItemTags();
            }
        });
    }

    function SubmitTag() {
        var isValid = false;
        var TagValue = '';
        $(".classTag").each(function() {
            if ($(this).val() == '') {
                //  alert('please add tags');
                $(this).parents('td').find('span[class="err"]').html('');
                $('<span class="err" style="color:red;">*<span>').insertAfter(this);
                isValid = false;
                return false;
            } else {
                isValid = true;
                TagValue += $(this).val() + "#";
                $(this).siblings('span').remove();
            }
        });
        if (isValid) {
            TagValue = TagValue.substring(0, TagValue.length - 1);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/AddTagsOfItem",
                data: JSON2.stringify({ itemSKU: itemSKU, Tags: TagValue, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetItemTags();
                    ClearTableContentTags(this);
                    csscody.alert("<h2>Information Message</h2><p>your tag is accepted.</p>");
                },
                error: function() {
                    csscody.error('<h2>Error Message</h2><p>Error!</p>');
                }
            });
        }
    }

    function ClearTableContentTags(obj) {
        $('#AddTagTable tr:not(:last-child)').remove();
        $(".classTag").val('');
    }

    function FillItemAttributes(itemSKU, item) {
        //var attNameNoSpace = "_" + item.AttributeName.replace(new RegExp(" ", "g"), '-');
        var id = item.AttributeID + '_' + item.InputTypeID + '_' + item.ValidationTypeID + '_' + item.IsRequired + '_' + item.GroupID
            + '_' + item.IsIncludeInPriceRule + '_' + item.IsIncludeInPromotions + '_' + item.DisplayOrder;

        var val = '';
        switch (item.InputTypeID) {
        case 1:
//TextField
            if (item.ValidationTypeID == 3) {
                $("#" + id).html(item.DECIMALValue);
                break;
            } else if (item.ValidationTypeID == 5) {
                $("#" + id).html(item.INTValue);
                break;
            } else {
                $("#" + id).html(unescape(item.NVARCHARValue));
                break;
            }
        case 2:
//TextArea
            $("#" + id).html(Encoder.htmlDecode(item.TEXTValue));
            break;
        case 3:
//Date
            $("#" + id).html(formatDate(new Date(item.DATEValue), "yyyy/M/d"));
            break;
        case 4:
//Boolean
            $("#" + id).html(item.BooleanValue);
            break;
        case 5:
//MultipleSelect
            $("#" + id).html(item.OPTIONValues);
            break;
        case 6:
//DropDown
            $("#" + id).html(item.OPTIONValues);
            break;
        case 7:
//Price
            $("#" + id).html(item.DECIMALValue);
            break;
        case 8:
//File    
            var div = $("#" + id);
            var filePath = item.FILEValue;
            var fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
            if (filePath != "") {
                var fileExt = (-1 !== filePath.indexOf('.')) ? filePath.replace( /.*[.]/ , '') : '';
                myregexp = new RegExp("(jpg|jpeg|jpe|gif|bmp|png|ico)", "i");
                if (myregexp.test(fileExt)) {
                    $(div).append('<span class="response"><img src="' + aspxRootPath + filePath + '" class="uploadImage" /></span>');
                } else {

                    $(div).append('<span class="response"><span id="spanFileUpload"  class="cssClassLink"  href="' + 'uploads/' + fileName + '" >' + fileName + '</span></span>');
                }
            }
            break;
        case 9:
//Radio
            $("#" + id).html(item.OPTIONValues);
            break;
        case 10:
//RadioButtonList
            $("#" + id).html(item.OPTIONValues);
            break;
        case 11:
//CheckBox
            $("#" + id).html(item.OPTIONValues);
            break;
        case 12:
//CheckBoxList
            $("#" + id).html(item.OPTIONValues);
            break;
        case 13:
//Password
            $("#" + id).html(item.NVARCHARValue);
            break;
        }
    }

    function GetYouMayAlsoLikeItemsList() {
        RelatedItems = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetYouMayAlsoLikeItemsListByitemSKU",
            data: JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, count: '<%= relatedItemsCount %>' }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindYouMayAlsoLikeItems(index, item);
                    });
                    RelatedItems += "<div class=\"cssClassClear\"></div>";
                } else {
                    RelatedItems += "<span class=\"cssClassNotFound\">No Data found.</span>";
                }
                $("#divYouMayAlsoLike").html(RelatedItems);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            },
            error: function(msg) {
                // csscody.alert('<h2>Information Alert</h2><p>Failed to load you may also like items details!</p>');
            }
        });
    }

    function BindYouMayAlsoLikeItems(index, item) {
        $("#divYouMayAlsoLike").html('');
        if (item.ImagePath == "") {
            item.ImagePath = aspxRootPath + '<%= noItemDetailImagePath %>';
        }
        if (item.AlternateText == "") {
            item.AlternateText = item.Name;
        }
        if ((index + 1) % 4 == 0) {
            RelatedItems += "<div class=\"cssClassYouMayAlsoLikeBox cssClassYouMayAlsoLikeBoxFourth\">";
        } else {
            RelatedItems += "<div class=\"cssClassYouMayAlsoLikeBox\">";
        }
        RelatedItems += '<p class="cssClassProductPicture"><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx"><img  alt="' + item.AlternateText + '" title="' + item.Name + '" src="' + aspxRootPath + item.ImagePath.replace('uploads', 'uploads/Small') + '"></a></p>';
        RelatedItems += '<p class="cssClassProductRealPrice"><span>Price :<span class="cssClassFormatCurrency">' + item.Price + '</span></span></p>';
        if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
            if (item.IsOutOfStock) {
                RelatedItems += "<div class='cssClassButtonWrapper cssClassOutOfStock'><a href='#'><span>Out Of Stock</span></a></div></div>";
            } else {
                RelatedItems += "<div class='cssClassButtonWrapper'><a href='#' onclick='AddToCartToJS(" + item.ItemID + "," + item.Price + "," + JSON2.stringify(item.SKU) + "," + 1 + ");'><span>Add to Cart</span></a></div></div>";

            }
        } else {
            RelatedItems += "<div class='cssClassButtonWrapper'><a href='#' onclick='AddToCartToJS(" + item.ItemID + "," + item.Price + "," + JSON2.stringify(item.SKU) + "," + 1 + ");'><span>Add to Cart</span></a></div></div>";
        }
        // $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
    }

    function AddToCartToJS(itemId, itemPrice, itemSKU, itemQuantity) {
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

    function CheckItemQuantityInCart(itemId) {
        var sessionCode = '<%= sessionCode %>';
        var itemQuantityInCart;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckItemQuantityInCart",
            data: JSON2.stringify({ itemID: itemId, storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                itemQuantityInCart = msg.d;

            }
        });
        return itemQuantityInCart;
    }

    function GetImageLists(itemSKU) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemsImageGalleryInfoBySKU",
            data: JSON2.stringify({ itemSKU: itemSKU, storeID: storeId, portalID: portalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                GetFilePath(msg);
                Gallery();
                ImageZoom();
            }
        //            ,
        //            error: function() {
        //                csscody.alert('<h2>Information Alert</h2><p>Failed to load the item images details!</p>');
        //            }
        });
    }

    function AddStyle() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/ReturnDimension",
            data: JSON2.stringify({ UserModuleID: userModuleID, PortalID: portalId, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            //=====to return from ajax call write this code====
            async: false,
            //=====********====================================
            success: function(msg) {
                SetValueForStyle(msg);
            },
            error: function() {
                //  csscody.alert('<h2>Information Alert</h2><p>Failed to load the item gallery settings!</p>');
            }
        });
    }

    function GetFilePath(msg) {
        var imgList = '';
        if (msg.d.length > 0) {
            $.each(msg.d, function(index, item) {
                imgList += "<li><img id=\"image1\" src=" + aspxRootPath + item.ImagePath.replace('uploads', 'uploads/Large') + " alt=" + item.AlternateText + " title=" + item.AlternateText + " /></li>";
            });
        } else {
            imgList += "<li><img id=\"image1\" src=" + aspxRootPath + '<%= noItemDetailImagePath %>' + " /></li>";
        }
        $("#pikame").html(imgList);
    }

    function ImageZoom() {
        $("#zoom01").gzoom({
            sW: newObject.width,
            sH: newObject.height,
            lW: 1600,
            lH: 1250,
            lightbox: true
        });
    }

    function Gallery() {
        $("#pikame").PikaChoose({ showCaption: false });
        $("#pikame").jcarousel({
            scroll: 3,
            transition: [6],
            initCallback: function(carousel) {
                $(carousel.list).find('img').click(function() {
                    //console.log($(this).parents('.jcarousel-item').attr('jcarouselindex'));
                    carousel.scroll(parseInt($(this).parents('.jcarousel-item').attr('jcarouselindex')));
                });
            }
        });
    }

    function SetValueForStyle(msg) {
        $('div.pika-image').css("width", msg.d[0] + 2);
        $('div.pika-image').css("height", msg.d[1] + 2);
        $('#image1').css('width', msg.d[2]);
        $('#image1').css('height', msg.d[2]);
        newObject = new Variable(msg.d[1], msg.d[0], msg.d[2], msg.d[3]);
    }


    function BindItemsBasicInfo(item) {
        //        if (item.ImagePath == "") {
        //            item.ImagePath = aspxRootPath+ "Modules/ASPXCommerce/ASPXItemsManagement/uploads/noitem.png";
        //        }
        //        if (item.AlternateText == "") {
        //            item.AlternateText = item.Name;
        //        }
        //        $(".cssClassProductBigPicture").html("<img src=" + item.ImagePath + " width=\"323px\" height=\"238px\" alt=" + item.AlternateText + " title=" + item.AlternateText + "/>");
        $("#spanListPrice").html(item.ListPrice);
        $("#spanItemName").html(itemName);
        $("#spanSKU").html(item.SKU);
        $("#spanPrice").html(item.Price);
        $("#hdnPrice").val(item.Price);
        $("#hdnWeight").val(item.Weight);
        //$("#spanWeight").val(item.Weight);
        $("#hdnQuantity").val(item.Quantity);
        if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
            if (item.IsOutOfStock) {
                $("#btnAddToMyCart span span").html('Out Of Stock');
                $("#btnAddToMyCart").attr("disabled", "disabled");
                $("#btnAddToMyCart").addClass('cssClassOutOfStock');
                $("#btnAddToMyCart").show();
            } else {
                $("#btnAddToMyCart span span").html('Add To Cart');
                $("#btnAddToMyCart").removeAttr("disabled");
                $("#btnAddToMyCart").removeClass('cssClassOutOfStock');
                $("#btnAddToMyCart").addClass('cssClassAddToCard');
                $("#btnAddToMyCart").show();
            }
        } else {
            $("#btnAddToMyCart").show();
        }
        $("#txtQty").val('1');
        $("#spanTax").html(item.TaxRateValue);
        if (item.SampleLink != '' || item.SampleFile != '') {
            $("#dwnlDiv").show();
            $("#spanDownloadLink").html(item.SampleLink);
            $("#spanDownloadLink").attr("href", item.SampleFile);


        } else {
            $("#dwnlDiv").hide();
        }

        var savingPercent = ((item.ListPrice - item.Price) / item.ListPrice) * 100;
        savingPercent = savingPercent.toFixed(2);
        $("#spanSaving").html('<b>' + savingPercent + '%</b>');
        if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
            if (item.IsOutOfStock) {
                $("#spanAvailability").html('<b>Out of stock</b>');
            } else {
                $("#spanAvailability").html('<b>In stock</b>');
            }
        } else {
            $("#spanAvailability").html('<b>In stock</b>');
        }

        var shortDesc = '';
        if (item.ShortDescription.length > 870) {
            shortDesc = item.ShortDescription.substring(0, 870)
            shortDesc += " >>>";
        } else {
            shortDesc = item.ShortDescription;
        }
        $("#divItemShortDesc").html(Encoder.htmlDecode(shortDesc));
        $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
        //$("#divItemFullDesc").html(Encoder.htmlDecode(item.Description));
        //$("#divItemFullDesc").hide();
        //$("#divReadLess").hide();
    }

    function AddUpdateRecentlyViewedItem(itemSKU) {
        var userIP = '<%= userIP %>';
        var countryName = '<%= countryName %>';
        var sessionCode = '<%= sessionCode %>';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateRecentlyViewedItems",
            data: JSON2.stringify({ itemSKU: itemSKU, IP: userIP, sessionCode: sessionCode, countryName: countryName, userName: userName, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                //alert("success");
            },
            error: function(msg) {
                //  csscody.alert('<h2>Information Alert</h2><p>Failed to save the recently viewed item!</p>');
            }
        });
    }

    function AddToMyCart() {
        if ($.trim($("#txtQty").val()) == "" || $.trim($("#txtQty").val()) <= 0) {
            alert("Invalid quantity");
            return false;
        }

        var itemQuantityInCart = CheckItemQuantityInCart(itemId);
        if (itemQuantityInCart != 0.1) { //To know whether the item is downloadable (0.1 downloadable)
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if ($("#hdnQuantity").val() <= 0) {
                    csscody.alert("<h2>Information Alert</h2><p>The item is out of stock and out of stock item is not allowed to purchase!</p>");
                    return false;
                } else {

                    if ((eval($.trim($("#txtQty").val())) + eval(itemQuantityInCart)) > eval($("#hdnQuantity").val())) {
                        csscody.alert("<h2>Information Alert</h2><p>You Cann't Add More Than " + $("#hdnQuantity").val() + " Quantity!</p>");
                        return false;
                    }
                }
            }
        }

        var itemPrice = $("#hdnPrice").val();
        var itemQuantity = $.trim($("#txtQty").val());
        var itemCostVariantIDs = "";
        var weightWithVariant = 0;
        var totalWeightVariant;
        var costVariantPrice = 0;
        if ($('#divCostVariant').is(':empty')) {
            itemCostVariantIDs = null;
        } else {
            $("#divCostVariant input[type=radio]:checked").each(function() {
                itemCostVariantIDs += $(this).val() + ",";
                if ($(this).attr('variantvalue') != undefined) {
                    costVariantPrice += $(this).attr('variantvalue');
                }
                if ($(this).attr('variantwtvalue') != undefined) {
                    weightWithVariant += $(this).attr('variantwtvalue');
                }
            });

            $("#divCostVariant input[type=checkbox]:checked").each(function() {
                itemCostVariantIDs += $(this).val() + ",";
                if ($(this).attr('variantvalue') != undefined) {
                    costVariantPrice += $(this).attr('variantvalue');
                }
                if ($(this).attr('variantwtvalue') != undefined) {
                    weightWithVariant += $(this).attr('variantwtvalue');
                }
            });

            $("#divCostVariant select option:selected").each(function() {
                itemCostVariantIDs += $(this).val() + ",";
                if ($(this).attr('variantvalue') != undefined) {
                    costVariantPrice += $(this).attr('variantvalue');
                }
                if ($(this).attr('variantwtvalue') != undefined) {
                    weightWithVariant += $(this).attr('variantwtvalue');
                }
            });
            itemCostVariantIDs = itemCostVariantIDs.substring(0, itemCostVariantIDs.length - 1);
        }
        totalWeightVariant = eval($("#hdnWeight").val()) + eval(weightWithVariant);
        itemPrice = eval(itemPrice) + eval(costVariantPrice);
        var param = { itemID: itemId, itemPrice: itemPrice, weight: totalWeightVariant, itemQuantity: itemQuantity, itemCostVariantIDs: itemCostVariantIDs, storeID: storeId, portalID: portalId, custometID: customerId, sessionCode: sessionCode, userName: userName, cultureName: cultureName };
        var data = JSON2.stringify(param);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddItemstoCartFromDetail",
            data: data,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                csscody.alert('<h2>Information Message</h2><p>Item Successfully Added To your Cart.</p>');
                GetCartItemTotalCount(); //for header cart count from database
                GetCartItemCount(); //for shopping bag counter from database
                GetCartItemListDetails(); //for shopping bag detail
                if ($("#divCartDetails").length > 0) {
                    GetUserCartDetails(); //for binding mycart's tblCartList
                }
                if ($("#dynItemDetailsForm").length > 0) {
                    BindItemBasicByitemSKU(itemSKU);
                }

            },
            error: function() {
                csscody.alert('<h2>Information Alert</h2><p>Failed to Add The Item To your Cart!</p>');
            }
        });
    }

</script>

<div class="cssClassCommonWrapper" id="itemDetails">
    <div class="cssClassProductInformation">
        <div class="cssClassProductImage">
            <div class="cssClassProductBigPicture">
                <div class="pikachoose">
                    <ul id="pikame" class="jcarousel-skin-pika">
                    </ul>
                </div>
            </div>
        </div>
        <div class="cssClassProductPictureDetails">
            <div class="cssClassLeftSide">
                <h2>
                    <asp:Label ID="lblItemTitle" runat="server" Text="Item Name: "></asp:Label>
                    <span id="spanItemName"></span>
                </h2>
                <li class="cssClassItems">
                    <asp:Label ID="lblSKU" runat="server" Text="SKU: "></asp:Label>
                    <span id="spanSKU"></span></li>
                <li><span class="cssClssQTY">
                        <asp:Label ID="lblQty" runat="server" Text="Qty: "></asp:Label>
                        <input type="text" id="txtQty" /><label id='lblNotification' style="color: #FF0000;"></label>
                    </span></li>
                <li id="divQtyDiscount">
                    <p>
                        Our quantity discounts:</p>
                    <div class="cssClassCommonGrid">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassQtyDiscount"
                               id="itemQtyDiscount">
                            <thead>
                                <tr class="cssClassHeadeTitle">
                                    <th>
                                        Quantity (more than)
                                    </th>
                                    <th>
                                        Price
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </li>
                <li>
                    <div class="cssClassDownload cssClassRight" id="dwnlDiv">
                        <asp:Label ID="lblDownloadTitle" runat="server" Text="Sample Item Download: "></asp:Label>
                        <span id="spanDownloadLink" class="cssClassLink"></span>
                    </div>
                </li>
                <li>
                    <div id="divCostVariant">
                    </div>
                </li>
                <div id="divBookMark" class="cssClassLinkShare">
                    <div class="addthis_toolbox addthis_default_style">
                        <a class="addthis_button_facebook_like" fb: like:layout="button_count"></a><a class="addthis_button_tweet">
                                                                                                   </a><a class="addthis_counter addthis_pill_style"></a>
                    </div>

                    <script type="text/javascript"> var addthis_config = { "data_track_clickback": true }; </script>

                    <script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4da3f76e591920f0"> </script>

                </div>
                <div class="cssClassItemRating">
                    <div class="cssClassItemRatingBox cssClassToolTip">
                        <div class="cssClassRatingStar">
                            <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblAverageRating">
                            </table>
                        </div>
                        <span class="cssClassRatingTitle"></span>
                        <%-- For detail star rating info --%>
                        <div class="cssClassToolTipInfo">
                        </div>
                        <div class="cssClassClear">
                        </div>
                    </div>
                    <span class="cssClassTotalReviews"></span><span class="cssClassSeparator">|</span>
                    <%--<a href="#">Popup goes her to show add new review</a>--%>
                    <a href="#" rel="popuprel2" class="popupAddReview" value=""><span class="cssClassAddYourReview">
                                                                                </span></a>
                </div>
                <div class="cssClassButtonWrapper">
                    <div class="cssClassButton">
                        <a href="#" id="lnkContinueShopping"><span>Continue to Shopping</span></a>
                    </div>
                    <div id="divEmailAFriend" class="cssClassButton cssClassDetailPageRightBtn">
                        <a href="#" rel="popuprel" class="popupEmailAFriend" value=""><span>Email a Friend</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="cssClassRightSide">
                <li><span class="cssClassProductOffPrice">
                        <asp:Label ID="lblListPrice" runat="server" Text="List Price: "></asp:Label>
                        <span id="spanListPrice" class="cssClassFormatCurrency"></span></span><span class="cssClassProductRealPrice">
                                                                                                  <asp:Label ID="lblPrice" runat="server" Text="Price: "></asp:Label>
                                                                                                  <span id="spanPrice" class="cssClassFormatCurrency"></span>
                                                                                                  <br />
                                                                                                  <span id="bulkDiscount" class="cssClassBulkDiscount">(Bulk Discount available)</span></span>
                <li class="cssClassYouSave"><span class="cssClassYouSave">
                                                <asp:Label ID="lblSaving" runat="server" Text="You save: "></asp:Label>
                                                <span id="spanSaving"></span></span></li>
                <%--<li class="cssClassRating">
                        <asp:Label ID="lblRating" runat="server" Text="Rating Summary : "></asp:Label>
                        <span id="spanRating"></span></li>--%>
                <li>
                    <div class="cssClassTax">
                        <asp:Label ID="lblTax" runat="server" Text="Tax: "></asp:Label>
                        <span id="spanTax" class="cssClassFormatCurrency"></span>
                    </div>
                </li>
                <li>
                    <div class="cssClassAvailiability">
                        <asp:Label ID="lblAvailability" runat="server" Text="Availability: "></asp:Label>
                        <span id="spanAvailability"></span>
                    </div>
                </li>
                <div class="cssClassButtonWrapper">
                    <button id="addWishListThis" type="button">
                        <span><span><span>+</span>Wishlist</span></span></button>
                    <button id="addCompareListThis" type="button">
                        <span><span><span>+</span>Compare</span></span></button>
                    <button id="btnAddToMyCart" type="button" onclick=" AddToMyCart(); ">
                        <span><span>Add to Cart</span></span></button>
                </div>
            </div>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <div class="cssClassItemQuickOverview">
        <h2>
            <asp:Label ID="lblQuickOverview" Text="Quick Overview :" runat="server" />
        </h2>
        <table width="100%" cellspacing="0" cellpadding="0" border="0" class="tdpadding">
            <tbody>
                <tr class="cssClassItemOverviewContent">
                    <td id="divItemShortDesc">
                    </td>
                </tr>
            </tbody>
        </table>
        <%--  <div class="cssClassReadMore" id="divReadMore">
                    <span>Read More</span></div>
                <div class="cssClassReadMore" id="divReadLess">
                    <span>Read Less</span></div>--%>
    </div>
    <div class="cssClassProductDetailInformation">
        <div id="dynItemDetailsForm" class="cssClassFormWrapper">
        </div>
    </div>
    <div class="cssClassProductDetailInformation cssClassYouMayAlsoLike">
        <h2>
            <asp:Label ID="lblYouMayAlsoLike" Text="You may also like :" runat="server" />
        </h2>
        <div class="cssClassYouMayAlsoLikeWrapper" id="divYouMayAlsoLike">
        </div>
    </div>
    <div id="controlload">
    </div>
    <div class="popupbox" id="popuprel2">
        <div class="cssClassCloseIcon">
            <button type="button" class="cssClassClose">
                <span>Close</span></button>
        </div>
        <h2>
            <asp:Label ID="lblWriteReview" runat="server" Text="Write Your Own Review"></asp:Label>
        </h2>
        <div class="cssClassFormWrapper">
            <%--<div class="cssClassReviewInfos"> Submit a review now and earn 15 reward points once the review is approved. <a href="#"> Learn more...</a></div>
      <div class="cssClassReviewInfos">Applies only to registered customers, may vary when logged in.</div>
      --%>
            <div class="cssClassPopUpHeading">
                <h3>
                    <label id="lblYourReviewing">
                    </label>
                </h3>
            </div>
            <asp:Label ID="lblHowToRate" runat="server" Text="How do you rate this item?"></asp:Label>
            <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblRatingCriteria">
            </table>
            <table border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Nickname:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtUserName" name="name" class="required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Summary Of Your Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtSummaryReview" name="summary" class="required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <textarea id="txtReview" cols="50" rows="10" name="review" class="cssClassTextarea required"
                                  maxlength="300"></textarea>
                    </td>
                </tr>
            </table>
            <div class="cssClassButtonWrapper cssClassWriteaReview">
                <%-- <input  type="submit" value="Submit" id="btnSubmitReview"/>--%>
                <button type="submit" id="btnSubmitReview">
                    <span><span>Submit Review</span></span></button>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hdnPrice" />
<input type="hidden" id="hdnWeight" />
<input type="hidden" id="hdnQuantity" />