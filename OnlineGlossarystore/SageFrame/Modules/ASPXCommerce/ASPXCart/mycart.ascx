<%@ Control Language="C#" AutoEventWireup="true" CodeFile="mycart.ascx.cs" Inherits="mycart" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var userName = '<%= userName %>';
    var sessionCode = '<%= sessionCode %>';
    var cultureName = '<%= cultureName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var updateCart = true;
    $(document).ready(function() {
        $('.num-pallets-input').val('');
        if (userFriendlyURL) {
            $("#lnkContinueShopping").attr("href", aspxRedirectPath + "Home.aspx");
        } else {
            $("#lnkContinueShopping").attr("href", aspxRedirectPath + "Home");
        }

        $("#txtCouponCode").val('');
        $("#divCheckOutMultiple").hide();
        if (customerId > 0 && userName.toLowerCase() != 'anonymoususer' && '<%= allowMultipleAddShipping %>'.toLowerCase() == 'true') {
            $("#divCheckOutMultiple").show();
        }

        $("#btnSubmitCouponCode").click(function() {
            VerifyCouponCode();
        });

        $("#btnClear").click(function() {
            var properties = {
                onComplete: function(e) {
                    ClearCartItems(e);
                }
            }
            // Ask user's confirmation before delete records        
            csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete your all cart items?</p>", properties);
        });

        $("#btnUpdateShoppingCart").click(function() {
            var cartItemId = '';
            var quantity = '';
            var cartID = 0;
            var updateCart = true;
            $(".num-pallets-input").each(function() {
                if ($(this).val() == "" || $(this).val() <= 0) {
                    updateCart = false;
                    //alert("Invalid quantity");
                    return false;
                }
                var totQtyInTxtBox = 0;
                var initQtyInCart = 0;
                var itemId = $(this).attr("itemID");
                var itemQuantityInCart = CheckItemQuantityInCart(itemId);
                if ($(this).attr("costVariantID") != '') {
                    $(".num-pallets-input[itemID=" + itemId + "]").each(function() {
                        totQtyInTxtBox = totQtyInTxtBox + eval($(this).val());
                        initQtyInCart = initQtyInCart + eval($(this).attr("quantityInCart"));
                    });
                } else {
                    totQtyInTxtBox = eval($(this).val());
                    initQtyInCart = eval($(this).attr("quantityInCart"));
                }
                if (itemQuantityInCart != 0.1) { //to test if the item is downloadable or simple(-0.1 downloadable)
                    if ((totQtyInTxtBox + itemQuantityInCart - initQtyInCart) > eval($(this).attr("actualQty"))) {
                        // csscody.alert('<h2>Information Message</h2><p>The Quantity Is Greater Than The Available Quantity.</p>');
                        $(this).parents('.cssClassQTYInput').find('.lblNotification:eq(0)').html('The Quantity Is Greater Than The Available Quantity.');
                        updateCart = false;
                        return false;
                    } else {
                        $(this).parents('.cssClassQTYInput').find('.lblNotification').html('');
                        updateCart = true;
                    }
                }
            });
            if (updateCart == true) {
                $(".num-pallets-input").each(function() {
                    cartItemId += parseInt($(this).attr("id").replace( /[^0-9]/gi , '')) + ',';
                    quantity += $(this).val() + ',';
                    cartID = $(this).attr("cartID");
                });
                UpdateCart(cartItemId, cartID, quantity);
            } else {
                csscody.alert("<h2>Information Message</h2><p>Your cart contains Invalid quantity!!</p>");
                //alert("Invalid quantity");
            }
        });

        GetUserCartDetails();

        $('.cssClassCouponHelp').hide();
        $('#txtCouponCode').focus(function() {
            // alert('');
            $('.cssClassCouponHelp').show();

        });
        $('#txtCouponCode').focusout(function() {
            $('.cssClassCouponHelp').hide();

        });


    });

    function UpdateCart(cartItemId, cartID, quantity) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateShoppingCart",
            data: JSON2.stringify({ cartID: cartID, quantitys: quantity, storeID: storeId, portalID: portalId, cartItemIDs: cartItemId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if ($("#lnkMyCart").length > 0) {
                    GetCartItemTotalCount(); //for header cart count from database
                }
                if ($("#lnkShoppingBag").length > 0) {
                    GetCartItemCount();
                    GetCartItemListDetails(); //for details in shopping bag
                }
                if ($("#divRelatedItems").length > 0) {
                    GetItemRetatedUpSellAndCrossSellList();
                }
                GetUserCartDetails();
                // getdiscount();
                csscody.alert("<h2>Information Message</h2><p>Your cart is updated successfully!</p>");
            },
            error: function() {
                alert("error");
            }
        });
    }

    var qtydx = 0;

    function QuantitityDiscountAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, customerID: customerId, sessionCode: sessionCode });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetDiscountQuantityAmount",
            data: param,
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                qtydx = parseFloat(msg.d).toFixed(2);
                // $("#txtDiscountAmount").val(parseFloat(msg.d).toFixed(2));
                //$('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                getdiscount();
            }
        });
    }

    function getdiscount() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSessionVariable",
            data: JSON2.stringify({ key: 'DiscountAmount' }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var dx = 0;
                dx = parseFloat(msg.d).toFixed(2); //12.25  
                var tt = parseFloat($.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , ""));
                var sum = tt - dx - qtydx;
                $("#txtDiscountAmount").val('').val(eval(dx) + eval(qtydx));
                $("#txtTotalCost").val(sum);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            }
        });
    }

    function SetCostVartSession(obj) {
        if ($(obj).attr("costvariants") != null) {
            itemCostVariantData = $(obj).attr("costvariants");
            $.session("ItemCostVariantData", 'empty');
            $.session("ItemCostVariantData", itemCostVariantData);
        }
    }

    function GetUserCartDetails() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartDetails",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName, sessionCode: sessionCode }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                if (msg.d.length > 0) {
                    var cartHeading = '';
                    var cartElements = '';
                    cartHeading += '<table cellspacing="0" cellpadding="0" border="0" width="100%" id="tblCartList">';
                    cartHeading += '<tbody><tr class="cssClassHeadeTitle">';
                    cartHeading += '<td class="cssClassSN">Sn.';
                    if ('<%= showItemImagesOnCart %>'.toLowerCase() == 'true') {
                        cartHeading += '</td><td class="cssClassItemImageWidth">';
                        cartHeading += 'Item Image';
                    }
                    cartHeading += '</td><td>';
                    cartHeading += 'Description';
                    cartHeading += '</td>';
                    cartHeading += '<td>';
                    cartHeading += 'Variants';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassQTY">';
                    cartHeading += 'Qty';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassTimes">';
                    cartHeading += 'X';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassItemPrice">';
                    cartHeading += 'Unit Price';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassEquals">';
                    cartHeading += '=';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassSubTotal">';
                    cartHeading += 'SubTotal';
                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassTaxRate">';
                    cartHeading += 'Unit Tax';
                    cartHeading += '</td>';
                    //                    cartHeading += '<td>';
                    //                    cartHeading += 'Remark';
                    //                    cartHeading += '</td>';
                    cartHeading += '<td class="cssClassAction">';
                    cartHeading += 'Action';
                    cartHeading += '</td>';
                    cartHeading += '</tr>';
                    cartHeading += '</table>';
                    $("#divCartDetails").html(cartHeading);
                    $.each(msg.d, function(index, value) {
                        index = index + 1;
                        if (value.ImagePath == "") {
                            value.ImagePath = '<%= noImageMyCartPath %>';
                        } else if (value.AlternateText == "") {
                            value.AlternateText = value.Name;
                        }
                        cartElements += '<tr >';
                        cartElements += '<td>';
                        cartElements += '<b>' + index + "." + '</b>';
                        cartElements += '</td>';
                        if ('<%= showItemImagesOnCart %>'.toLowerCase() == 'true') {
                            cartElements += '<td>';
                            cartElements += '<p class="cssClassCartPicture">';
                            cartElements += '<img src="' + aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + value.AlternateText + '" title="' + value.AlternateText + '"></p>';
                            cartElements += '</td>';
                        }
                        cartElements += '<td>';
                        cartElements += '<div class="cssClassCartPictureInformation">';
                        cartElements += '<h3>';
                        cartElements += '<a href="item/' + value.SKU + '.aspx"  costvariants="' + value.CostVariants + '" onclick=SetCostVartSession(this);>' + value.ItemName + ' </a></h3>';
                        cartElements += '<p>';
                        cartElements += '' + Encoder.htmlDecode(value.ShortDescription) + '';
                        cartElements += '</p>';
                        cartElements += '</div>';
                        cartElements += '</td>';
                        cartElements += '<td class="row-variants">';
                        cartElements += '' + value.CostVariants + '';
                        cartElements += '</td>';
                        cartElements += '<td class="cssClassQTYInput">';
                        cartElements += '<input class="num-pallets-input" rate="' + value.TaxRateValue.toFixed(2) + '" price="' + (value.Price * rate).toFixed(2) + '" id="txtQuantity_' + value.CartItemID + '" type="text" cartID="' + value.CartID + '" value="' + value.Quantity + '" quantityInCart="' + value.Quantity + '" actualQty="' + value.ItemQuantity + '" costVariantID="' + value.CostVariantsValueIDs + '" itemID="' + value.ItemID + '">';
                        cartElements += '<label class="lblNotification" style="color: #FF0000;"></label></td>';
                        cartElements += '<td class="cssClassTimes">';
                        cartElements += ' X';
                        cartElements += '</td>';
                        cartElements += '<td class="price-per-pallet">';
                        cartElements += '<span class="cssClassFormatCurrency">' + (value.Price * rate).toFixed(2) + '</span>';
                        cartElements += '</td>';
                        cartElements += '<td class="cssClassEquals">';
                        cartElements += '=';
                        cartElements += '</td>';
                        cartElements += '<td class="row-total">';
                        cartElements += '<input class="row-total-input cssClassFormatCurrency" id="txtRowTotal_' + value.CartID + '" value="' + value.TotalItemCost.toFixed(2) + '"  readonly="readonly" type="text" />';
                        cartElements += '</td>';
                        cartElements += '<td class="row-taxRate">';
                        cartElements += '<span class="cssClassFormatCurrency">' + (value.TaxRateValue * rate).toFixed(2) + '</span>';
                        cartElements += '</td>';
                        //                        cartElements += '<td class="rowremark">';
                        //                        cartElements += '' + value.Remarks + '';
                        //                        cartElements += '</td>';
                        cartElements += '<td>';
                        cartElements += ' <img class="ClassDeleteCartItems" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png" alt="Delete" title="Delete" value="' + value.CartItemID + '" cartID="' + value.CartID + '" width="14" height="17"/>';
                        cartElements += '</td>';
                        cartElements += '</tr>';
                    });
                    $("#tblCartList").append(cartElements);

                    $("#tblCartList tr:even ").addClass("cssClassAlternativeEven");
                    $("#tblCartList tr:odd ").addClass("cssClassAlternativeOdd");
                    //QuantitityDiscountAmount();

                } else {
                    $(".cssClassCartInformation").html("<span class=\"cssClassNotFound\">Your shopping cart is empty!</span>");
                }

                $(".ClassDeleteCartItems").bind("click", function() {
                    var cartId = $(this).attr("cartID");
                    var cartItemId = $(this).attr("value");
                    var properties = {
                        onComplete: function(e) {
                            DeleteCartItem(cartId, cartItemId, e);
                        }
                    }
                    // Ask user's confirmation before delete records        
                    csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this item from your Cart?</p>", properties);
                });

                var subTotalAmount = 0.00;
                $(".row-total-input").each(function() {
                    // alert($(this).val());
                    subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val());
                    //  alert(subTotalAmount);                 
                });
                $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                var totalTax = 0.00;
                $(".num-pallets-input").each(function() {
                    totalTax += ($(this).val() * $(this).attr("rate"));
                });
                $(".tax-box").val('').attr("value", totalTax.toFixed(2));

                $("#txtTotalCost").val((parseFloat($(".total-box").val()) + parseFloat($(".tax-box").val())).toFixed(2));
                QuantitityDiscountAmount();


                $(".num-pallets-input").bind('focus', function(e) {
                    $(this).val('');
                    $(this).parents('.cssClassQTYInput').find('.lblNotification').html('');
                    var subTotalAmount = 0.00;
                    var cartId = parseInt($(this).attr("cartID"));
                    $(this).closest('tr').find("#txtRowTotal_" + cartId + "").val($(this).val() * $(this).attr("price"));
                    $(".row-total-input").each(function() {
                        // alert($(this).val());
                        subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val().replace( /[^0-9\.]+/g , ""));

                    });
                    $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                    var totalTax = 0.00;
                    $(".num-pallets-input").each(function() {
                        totalTax += ($(this).val() * $(this).attr("rate"));
                    });

                    $("#txtTotalTax").val('').val(totalTax);

                    $(".tax-box").val('').attr("value", totalTax.toFixed(2));
                    //$("#txtTotalCost").val(parseFloat($(".total-box").val()));


                    $("#txtTotalCost").val((parseFloat($(".total-box").val()) + parseFloat($(".tax-box").val())).toFixed(2));
                    var oldd = parseFloat($.trim($("#txtDiscountAmount").val()).replace( /[^0-9\.]+/g , ""));
                    //  var q = parseFloat($.trim($("#txtDiscountAmount").val()).replace(/[^0-9\.]+/g, ""));
                    var tt = parseFloat($.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , ""));
                    if (tt != 0.00) {
                        var sum = tt - oldd;
                        $("#txtTotalCost").val(sum);
                    }
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                });

                $(".num-pallets-input").bind('select', function(e) {
                    // $(this).val('');
                    $(this).val('');
                    $(this).parents('.cssClassQTYInput').find('.lblNotification').html('');
                    var subTotalAmount = 0.00;
                    var cartId = parseInt($(this).attr("cartID"));
                    $(this).closest('tr').find("#txtRowTotal_" + cartId + "").val($(this).val() * $(this).attr("price"));
                    $(".row-total-input").each(function() {
                        // alert($(this).val());
                        subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val().replace( /[^0-9\.]+/g , ""));

                    });
                    $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                    var totalTax = 0.00;
                    $(".num-pallets-input").each(function() {
                        totalTax += ($(this).val() * $(this).attr("rate"));
                    });

                    $("#txtTotalTax").val('').val(totalTax);

                    $(".tax-box").val('').attr("value", totalTax.toFixed(2));
                    //$("#txtTotalCost").val(parseFloat($(".total-box").val()));
                    $("#txtTotalCost").val((parseFloat($(".total-box").val()) + parseFloat($(".tax-box").val())).toFixed(2));
                    var oldd = parseFloat($.trim($("#txtDiscountAmount").val()).replace( /[^0-9\.]+/g , ""));
                    //  var q = parseFloat($.trim($("#txtDiscountAmount").val()).replace(/[^0-9\.]+/g, ""));
                    var tt = parseFloat($.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , ""));
                    if (tt != 0.00) {
                        var sum = tt - oldd;
                        $("#txtTotalCost").val(sum);
                    }
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });

                });
                $(".num-pallets-input").bind('blur', function(e) {
                    $(this).parents('.cssClassQTYInput').find('.lblNotification').html('');
                });

                $(".num-pallets-input").bind("keypress", function(e) {
                    if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                        if (eval($(this).attr("actualQty")) <= 0) {
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

                                var initQtyTxtBox = 0;
                                var totquantityInCart = 0;
                                var itemId = $(this).attr("itemID");
                                if ($(this).attr("costVariantID") != '') {
                                    $(".num-pallets-input[itemID=" + itemId + "]").each(function() {
                                        if ($(this).val() != '') {
                                            initQtyTxtBox += eval($(this).val());
                                        }

                                        totquantityInCart = totquantityInCart + eval($(this).attr("quantityInCart"));
                                    });
                                } else {
                                    totquantityInCart = eval($(this).attr("quantityInCart"));
                                }

                                //alert(initQty);
                                var itemQuantityInCart = CheckItemQuantityInCart(itemId);
                                if (itemQuantityInCart != 0.1) { //to test if the item is downloadable or simple(0.1 downloadable)
                                    if ((eval(($(this).val() + '' + num)) + itemQuantityInCart + initQtyTxtBox - totquantityInCart) > eval($(this).attr("actualQty"))) {
                                        // csscody.alert('<h2>Information Message</h2><p>The Quantity Is Greater Than The Available Quantity.</p>');
                                        $(this).parents('.cssClassQTYInput').find('.lblNotification:eq(0)').html('The Quantity Is Greater Than The Available Quantity.');
                                        return false;
                                    } else {
                                        $(this).parents('.cssClassQTYInput').find('.lblNotification').html('');
                                    }
                                }
                                //}
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

                $(".num-pallets-input").bind("keyup", function(e) {
                    var subTotalAmount = 0.00;
                    var cartId = parseInt($(this).attr("cartID"));
                    $(this).closest('tr').find("#txtRowTotal_" + cartId + "").val($(this).val() * $(this).attr("price"));
                    $(".row-total-input").each(function() {
                        // alert($(this).val());
                        subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val().replace( /[^0-9\.]+/g , ""));

                    });
                    $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                    //  $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                    var totalTax = 0.00;
                    $(".num-pallets-input").each(function() {
                        totalTax += ($(this).val() * $(this).attr("rate"));
                    });

                    $("#txtTotalTax").val('').val(totalTax);

                    $(".tax-box").val('').attr("value", totalTax.toFixed(2));
                    //$("#txtTotalCost").val(parseFloat($(".total-box").val()));
                    $("#txtTotalCost").val((parseFloat($(".total-box").val().replace( /[^0-9\.]+/g , "")) + parseFloat($(".tax-box").val().replace( /[^0-9\.]+/g , ""))).toFixed(2));
                    var oldd = parseFloat($.trim($("#txtDiscountAmount").val()).replace( /[^0-9\.]+/g , ""));
                    //  var q = parseFloat($.trim($("#txtDiscountAmount").val()).replace(/[^0-9\.]+/g, ""));
                    var tt = parseFloat($.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , ""));
                    if (tt != 0.00) {
                        var sum = tt - oldd;
                        $("#txtTotalCost").val(sum);
                    }
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                });
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });

            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function DeleteCartItem(cartId, cartItemId, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCartItem",
                data: JSON2.stringify({ cartID: cartId, cartItemID: cartItemId, customerID: customerId, sessionCode: sessionCode, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function() {
                    if ($("#lnkMyCart").length > 0) {
                        GetCartItemTotalCount(); //for header cart count from database
                    }
                    if ($("#lnkShoppingBag").length > 0) {
                        GetCartItemCount();
                        GetCartItemListDetails(); //for details in shopping bag
                    }
                    if ($("#divRelatedItems").length > 0) {
                        GetItemRetatedUpSellAndCrossSellList();
                    }
                    GetUserCartDetails();
                    //  getdiscount();
                    csscody.alert("<h2>Information Message</h2><p>Your cart item is deleted successfully!</p>");
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function ClearCartItems(event) {
        if (event) {
            var cartID = $("#tblCartList .ClassDeleteCartItems").attr("cartid");
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/ClearAllCartItems",
                data: JSON2.stringify({ cartID: cartID, customerID: customerId, sessionCode: sessionCode, storeID: storeId, portalID: portalId }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function() {
                    if ($("#lnkMyCart").length > 0) {
                        GetCartItemTotalCount(); //for header cart count from database
                    }
                    if ($("#lnkShoppingBag").length > 0) {
                        GetCartItemCount();
                        GetCartItemListDetails(); //for details in shopping bag
                    }
                    if ($("#divRelatedItems").length > 0) {
                        GetItemRetatedUpSellAndCrossSellList();
                    }
                    GetUserCartDetails();
                    //getdiscount();
                    csscody.alert("<h2>Information Message</h2><p>Your cart items are cleared successfully!<p>");
                },
                error: function() {
                    alert("Error");
                }
            });
        }
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


    function VerifyCouponCode() {
        var couponCode = $.trim($("#txtCouponCode").val());
        var totalCost = $("#txtTotalCost").val().replace( /[^0-9\.]+/g , "");
        if (couponCode == "") {
            csscody.alert("<h2>Information Message</h2><p>Enter Coupon Code!!</p>");
            return false;
        } else {
            var aCount = '';
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSessionVariable",
                data: JSON2.stringify({ key: 'CouponApplied' }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                async: false,
                success: function(msg) {
                    // alert(msg.d);
                    //console.debug(msg.d);
                    var x = parseInt(msg.d);
                    aCount = x;
                },
                error: function() {
                    csscody.alert("error");
                }
            });

            if (aCount != 0) {
                aCount = parseInt(aCount) + 1;
            }
            // alert(aCount);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/VerifyCouponCode",
                data: JSON2.stringify({ totalCost: totalCost, couponCode: couponCode, storeID: storeId, portalID: portalId, userName: userName, appliedCount: aCount }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                async: false,
                success: function(msg) {
                    var item = msg.d;
                    if (item.Verification) {
                        // UpdateCouponUserRecord(item.CouponID);
                        SetSessionValue('CouponCode', couponCode);
                        AddCouponAppliedCount('CouponApplied', 0);

                        if (item.IsForFreeShipping.toLowerCase() == "yes") {
                            $("#txtShippingTotal").val(0.00);
                            SetSessionValue('IsFreeShipping', 'true');
                            $("#txtCouponCode").val('');
                            csscody.alert("<h2>Information Message</h2><p>Congratulation! you need not to worry about shipping cost. It's free!!</p>");

                        } else {
                            //alert(item.CouponAmount);
                            $("#txtDiscountAmount").val(parseFloat($("#txtDiscountAmount").val().replace( /[^0-9\.]+/g , "")) + parseFloat(item.CouponAmount));
                            $("#txtTotalCost").val((parseFloat($("#txtTotalCost").val().replace( /[^0-9\.]+/g , ""))) - parseFloat(item.CouponAmount));
                            $("#txtCouponCode").val('');
                            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                            csscody.alert("<h2>Information Message</h2><p>Congratulaton! you have got " + item.CouponAmount + " discount.</p>");
                            SetSession();
                        }
                    } else {
                        csscody.alert("<h2>Information Message</h2><p>Coupon is either invalid, expired, reached it's usage limit or exceed your cart total purchase amount!</p>");
                        $("#txtCouponCode").val('');
                    }
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function AddCouponAppliedCount(sessionKey, sessionValue) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SetSessionVariableCoupon",
            data: JSON2.stringify({ key: sessionKey, value: sessionValue }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function() {
            },
            error: function() {
                csscody.alert("error");
            }
        });

    }

    function getCouponAppliedCount(Key) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSessionVariable",
            data: JSON2.stringify({ key: Key }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {

                // alert(msg.d);
                //console.debug(msg.d);
                var x = parseInt(msg.d);
                aCount = x;
                // console.debug(x);

            },
            error: function() {
                csscody.alert("error");
            }
        });

    }

    function UpdateCouponUserRecord(id) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateCouponUserRecord",
            data: JSON2.stringify({ couponID: id, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                csscody.alert("success");
            },
            error: function() {
                csscody.alert("error");
            }
        });
    }

    function SetSessionValue(sessionKey, sessionValue) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SetSessionVariable",
            data: JSON2.stringify({ key: sessionKey, value: sessionValue }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function() {
            },
            error: function() {
                csscody.alert("error");
            }
        });
    }

    function SetSession() {
        var totalCost = $.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , "");
        if (eval($.trim($("#txtTotalCost").val()).replace( /[^0-9\.]+/g , "")) < eval('<%= minOrderAmount %>')) {
            csscody.alert('<h2>Information Message</h2><p>You are not eligible to proceed further because Your Order Amount is too low!!!</p>');
            $("a").removeAttr("href");
            return false;
        }
        SetSessionValue("DiscountAmount", parseFloat($.trim($("#txtDiscountAmount").val()).replace( /[^0-9\.]+/g , "")));

    }

</script>

<%--<input type="button" id="btnSubmit" value="Pay through PayPal" />--%>
<div class="cssClassCartInformation cssClassCartTotal">
    <div class="cssClassBlueBtnWrapper">
        <div class="cssClassBlueBtn">
            <a id="lnkProceedToSingleCheckout" href="#" ><span>Proceed to
                                                             Checkout</span></a>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <div class="cssClassCartInformationDetails" id="divCartDetails">
    </div>
   
    <table class="cssClassSubTotalAmount"> <tbody>
            
                                               <tr>
                                                   <td>
                                                       <strong>Grand SUBTOTAL:</strong>
                                                   </td>
                                                   <td>
                                                       <input type="text" class="total-box cssClassFormatCurrency" value="" id="product-subtotal" readonly="readonly" />
                                                   </td>
                                               </tr>
                                               <tr >
                                                   <td>
                                                       <strong>Total Tax:</strong>
                                                   </td>
                                                   <td>
                                                       <input type="text" class="tax-box cssClassFormatCurrency" id="txtTotalTax" readonly="readonly" value="0.00" />
                                                   </td>
                                               </tr>
                                               <tr>
                                                   <td>
                                                       <strong>Discount:</strong>
                                                   </td>
                                                   <td>
                                                       <input type="text" class="cssClassFormatCurrency" id="txtDiscountAmount" readonly="readonly" value="0.00" />
                                                   </td>
                                               </tr>
                                           </tbody>
    </table>
    <div class="cssClassLeftRightBtn">
        <div class="cssClassCartInformation">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="noborder">
                <tbody>
                    <tr class="cssClassHeadeTitle cssClassAlternativeEven">
                        <td class="cssClassSubTotalAmountWidth">
                            <strong>Grand TOTAL:</strong>
                        </td>
                        <td class="cssClassGrandTotalAmountWidth">
                            <input type="text" readonly="readonly" class="cssClassFormatCurrency" id="txtTotalCost" value="0" />
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="cssClassCouponHelp">
        <h3>
            <span class="cssClassRequired">*</span>The coupon amount is applied to your cart, Once you click the apply button and should not have discount value greater than your total purchase!</h3>
    </div>
    <div class="cssClassapplycoupon">
        <h3>
            Enter the CouponCode if you have one:</h3>
        <input type="text" id="txtCouponCode"  />
        <div class="cssClassButtonWrapper">
            <div class="cssClassButton">
                <a href="#"><span id="btnSubmitCouponCode">Apply Coupon</span></a>
            </div>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <div class="cssClassBlueBtnWrapper">
        <div class="cssClassBlueBtn">
            <a id="lnkProceedToSingleChkout" href="#" ><span>Proceed to Checkout</span>
            </a>
        </div>
        <div class="cssClassButtonWrapper">
            <div class="cssClassButton ">
                <a id="lnkContinueShopping" href="#"><span>Continue Shopping</span></a>
            </div>
            
        </div>
        <div class="cssClassButtonWrapper">
            <div class="cssClassButton">
                <a href="#"><span id="btnUpdateShoppingCart">Update Shopping Cart</span></a>
            </div>
        </div>
        <div class="cssClassButtonWrapper">
            <div class="cssClassButton">
                <a href="#"><span id="btnClear">Clear Cart Items</span></a>
            </div>
        </div>
        
        <%--   <div class="cssClassBlueBtn" id="divCheckOutMultiple">
            <a id="lnkProceedToMultiCheckout" href="#" onclick='SetSession();'><span>Checkout With Multiple Address</span>
            </a>
        </div>--%>
        <div class="cssClassClear">
        </div>
    </div>
</div>