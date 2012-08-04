<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShoppingBagHeader.ascx.cs"
            Inherits="Modules_ASPXShoppingBagHeader_ShoppingBagHeader" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var sessionCode = '<%= sessionCode %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var itemCostVariantData = '';

    $(document).ready(function() {
        // alert(itemCostVariantData);
        LoadAllImages();
        hideShoppingCart();
        $("#divMiniShoppingCart").hide();
        if ('<%= showMiniShopCart %>'.toLowerCase() == 'true') {
            GetCartItemCount();
            $("#divMiniShoppingCart").show();
        }
        //        $("#lnkMyCart").click(function() {
        //            GetCartItemListDetails();
        //        });
        if (userFriendlyURL) {
            $("#lnkViewCart").attr("href", aspxRedirectPath + "My-Cart.aspx");
        } else {
            $("#lnkViewCart").attr("href", aspxRedirectPath + "My-Cart");
        }

        $("#lnkMiniCheckOut").click(function() {

            if (customerId <= 0 && userName.toLowerCase() == 'anonymoususer') {
                if ("<%= allowAnonymousCheckOut %>".toLowerCase() == 'false') {
                    csscody.alert('<h2>Information Alert</h2><p>Checkout is not allowed for Anonymous User!</p>');
                    return false;
                }
            }
            var singleAddressLink = '';
            var multipleAddressLink = '';
            if (userFriendlyURL) {
                singleAddressLink = 'Single-Address-Checkout.aspx';
                multipleAddressLink = 'Multiple-Address-Checkout.aspx';
            } else {
                singleAddressLink = 'Single-Address-Checkout';
                multipleAddressLink = 'Multiple-Address-Checkout';
            }
            var totalCartItemPrice = GetTotalCartItemPrice();
            if (totalCartItemPrice < '<%= minOrderAmount %>') {
                csscody.alert('<h2>Information Alert</h2><p>You are not eligible to proceed further:Your Order Amount is too low!!!</p>');
                return false;
            } else {
                var newMultiShippingDiv = '';
                if (userFriendlyURL) {
                    newMultiShippingDiv = '<a href="' + aspxRedirectPath + singleAddressLink + '" >Checkout With Single Address</a>';
                } else {
                    newMultiShippingDiv = '<a href="' + aspxRedirectPath + singleAddressLink + '">Checkout With Single Address</a>';
                }
                if (customerId > 0 && userName.toLowerCase() != 'anonymoususer') {
                    if (userFriendlyURL) {
                        if ('<%= allowMultipleAddChkOut %>'.toLowerCase() == 'true') {
                            newMultiShippingDiv += '<span class="cssClassOR">OR</span><a href="' + aspxRedirectPath + multipleAddressLink + '">Checkout With Multiple Address</a>';
                        }

                    } else {
                        if ('<%= allowMultipleAddChkOut %>'.toLowerCase() == 'true') {
                            newMultiShippingDiv += '<span class="cssClassOR">OR</span><a href="' + aspxRedirectPath + multipleAddressLink + '">Checkout With Multiple Address</a>';
                        }
                    }
                }
            }
            if ('<%= allowMultipleAddChkOut %>'.toLowerCase() == 'false' && '<%= allowAnonymousCheckOut %>'.toLowerCase() == 'true') {
                window.location = aspxRedirectPath + singleAddressLink;
            } else {
                $("#divMiniCheckoutTypes").html(newMultiShippingDiv);
                ShowPopupControl('popuprel4');
            }

        });
        $(".cssClassClose").click(function() {
            $('#fade, #popuprel4').fadeOut();
        });

        //        $(".cssClassShoppingCart").droppable({
        //            accept: ".cssClassProductsBoxInfo",
        //            activeClass: "drop-active",
        //            hoverClass: "drop-hover",
        //            drop: function(ev, ui) {

        //                var itemId = ui.draggable.attr("itemid");

        //                var itemPrice = ui.draggable.clone().find(".cssClassProductRealPrice span").html();

        //                var itemSKU = ui.draggable.clone().find('h3').html();

        //                //if price is with currency then separate price as ------------itemPrice= parseFloat(itemPrice.split('$')[1])
        //                AddToCartFromJS(itemId, itemPrice, itemSKU, 1, storeId, portalId, customerId, sessionCode, userName, cultureName);
        //            }
        //        });
    });

    function LoadAllImages() {
        $('#fullShoppingBag').attr('src', '' + aspxTemplateFolderPath + '/images/shopping-basket_full.png');
        $("#emptyShoppingBag").attr('src', '' + aspxTemplateFolderPath + '/images/shopping-basket_empty.png');
        $("#imgarrow").attr('src', '' + aspxTemplateFolderPath + '/images/arrow_down.gif');
    }

    function hideShoppingCart() {
        $('#ShoppingCartPopUp').hide();
        $('#imgarrow').attr("src", aspxTemplateFolderPath + "/images/arrow_down.gif");
    }

    function GetCartItemCount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartItemsCount",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d > 0) {
                    $("#imgarrow").show();
                    $("#fullShoppingBag").show();
                    $("#emptyShoppingBag").hide();
                    $("#cartItemCount").html('<a onclick="if(!this.disabled){showShoppingCart();};" href="javascript:void(0);" id="lnkshoppingcart">My Shopping Bag [ ' + msg.d + ' ]</a>');
                } else {
                    $("#imgarrow").hide();
                    $("#fullShoppingBag").hide();
                    $("#emptyShoppingBag").show();
                    $("#cartItemCount").html("[ <b>Your shopping cart is empty!</b> ]");
                }
            }
        });
    }

    function findPos(obj) {
        var curleft = curtop = 0;
        if (obj.offsetParent) {
            curleft = obj.offsetLeft;
            curtop = obj.offsetTop;
            while (obj = obj.offsetParent) {
                curleft += obj.offsetLeft;
                curtop += obj.offsetTop;
            }
        }
        return [curleft, curtop];
    }

    function showShoppingCart() {
        GetCartItemListDetails();
        var obj = $('#lnkshoppingcart');
        var pos = findPos(obj);
        $('#ShoppingCartPopUp').css('left', pos[0] - 180);
        $('#ShoppingCartPopUp').css('top', pos[1] + 20);

        $('#ShoppingCartPopUp').slideToggle("slow");

        if ($('#imgarrow').attr("src").indexOf("arrow_up.gif") > -1) {
            $('#imgarrow').attr("src", aspxTemplateFolderPath + "/images/arrow_down.gif");

        } else {
            $('#imgarrow').attr("src", aspxTemplateFolderPath + "/images/arrow_up.gif");
            //            if (CheckCartToProceed('Header') == false) {
            //                document.getElementById("ctl00_ctl00_ctrlHeader_btnProceed").style.display = "none";
            //            } else {
            //                document.getElementById("ctl00_ctl00_ctrlHeader_btnProceed").style.display = "inline";
            //            }
        }
        return false;

    }

    function GetCartItemListDetails() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName, sessionCode: sessionCode });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartDetails",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblListCartItems").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindCartItemslist(item, index);
                    });
                    $("a").click(function(e) {
                        //   alert($(this).attr("costvariants"));
                        if ($(this).attr("costvariants") != null) {
                            itemCostVariantData = $(this).attr("costvariants");
                            //alert(itemCostVariantData);
                            $.session("ItemCostVariantData", 'empty');
                            $.session("ItemCostVariantData", itemCostVariantData);
                        }
                    });
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });


                    $(".imgCartItemDelete").bind("click", function() {
                        var cartId = parseInt($(this).attr("id").replace( /[^0-9]/gi , ''));
                        var cartItemId = parseInt($(this).attr("name").replace( /[^0-9]/gi , ''));
                        var properties = {
                            onComplete: function(e) {
                                DeleteCartItemByID(cartId, cartItemId, e);
                            }
                        }
                        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item from your cart list?</p>", properties);
                    });
                } else {
                    $("#ShoppingCartPopUp").hide();
                }
            }
        });
    }

//    function StoreInSession(data) {
//    var param={VariantData:data};
//    $.ajax({
//        type: "POST",
//        url: aspxservicePath + "ASPXCommerceWebService.asmx/StoreVariantInSession",
//        data: JSON2.stringigy(param),
//        contentType: "application/json; charset=utf-8",
//        dataType: "json",
//        success: function(msg) {
//            alert("Storing in session success");
//        },
//        Error: function() {
//            alert("storing in session failed");
//        }
//    });
//    }

    function BindCartItemslist(item, index) {
        if (item.CostVariants != '') {
            $('#tblListCartItems').append('<tr><td><a  costvariants="' + item.CostVariants + '" href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + ' (' + item.CostVariants + ')' + '</a></td><td>' + item.Quantity + '&nbsp;&nbsp;*&nbsp;&nbsp;<span class="cssClassFormatCurrency">' + item.Price + '</span>&nbsp;&nbsp;=&nbsp;&nbsp;<span class="cssClassFormatCurrency">' + item.TotalItemCost + '</span></td><td><img class="imgCartItemDelete" name="' + item.CartItemID + '" id="btnDelete_' + item.CartID + '" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>');
        } else {
            $('#tblListCartItems').append('<tr><td><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + '</a></td><td>' + item.Quantity + '&nbsp;&nbsp;*&nbsp;&nbsp;<span class="cssClassFormatCurrency">' + item.Price + '</span>&nbsp;&nbsp;=&nbsp;&nbsp;<span class="cssClassFormatCurrency">' + item.TotalItemCost + '</span></td><td><img class="imgCartItemDelete" name="' + item.CartItemID + '" id="btnDelete_' + item.CartID + '" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>');
        }

    }

    function DeleteCartItemByID(id, cartItemId, event) {
        if (event) {
            var param = JSON2.stringify({ cartID: id, cartItemID: cartItemId, customerID: customerId, sessionCode: sessionCode, storeID: storeId, portalID: portalId, userName: userName });
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCartItem",
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetCartItemCount(); //for bag count
                    GetCartItemListDetails(); //for shopping bag detail
                    //For my Cart Link Header
                    if ($("#lnkMyCart").length > 0) {
                        GetCartItemTotalCount();
                    }
                    if ($('#divCartDetails').length > 0) {
                        GetUserCartDetails(); //for my cart's tblitemList table
                    }
                    if ($("#divLatestItems").length > 0) {
                        BindRecentItems();
                    }
                    if ($("#divShowCategoryItemsList").length > 0) {
                        LoadAllCategoryContents();
                    }
//                    if ($("#divYouMayAlsoLike").length > 0) {
//                        GetYouMayAlsoLikeItemsList();
//                    }
                    if ($("#divShowSimpleSearchResult").length > 0) {
                        BindSimpleSearchResultItems();
                    }
                    if ($("#divOptionsSearchResult").length > 0) {
                        BindShoppingOptionResultItems();
                    }
                    if ($("#divShowTagItemResult").length > 0) {
                        ListTagsItems();
                    }
                    if ($("#divShowAdvanceSearchResult").length > 0) {
                        ShowSearchResult();
                    }
                    if ($("#divWishListContent").length > 0) {
                        GetWishItemList();
                    }
                    if ($("#divRelatedItems").length > 0) {
                        GetItemRetatedUpSellAndCrossSellList();
                    }

                    if ($("#dynItemDetailsForm").length > 0) {
                        BindItemBasicByitemSKU(itemSKU);
                    }
                    csscody.alert('<h2>Information Alert</h2><p>Item has been deleted from your cart!</p>');
                    return false;
                },
                error: function() {
                    csscody.alert('<h2>Information Alert</h2><p>Error!</p>');
                }
            });
        }
        return false;
    }

    function GetTotalCartItemPrice() {
        var totalPrice;
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetTotalCartItemPrice",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                totalPrice = msg.d;
            }
        });
        return totalPrice;
    }

</script>

<div id="divMiniShoppingCart" class="cssClassShoppingCart">
    <p>
        <a onclick=" if (!this.disabled) {showShoppingCart();}; " href="javascript:void(0);"
           id="lnkShoppingBag">
            <img id="fullShoppingBag" width="32" height="32" alt="Shopping Basket" title="Shopping Basket" align="right" /></a>
        <img id="emptyShoppingBag" width="32" height="32" alt="Shopping Basket" title="Shopping Basket" align="right" /></a>
    </p>
    <p>
        <span id="cartItemCount"></span>
        <img id="imgarrow" alt="down" title="down" height="10px" width="10px" onclick=" if (!this.disabled) {showShoppingCart();}; "></p>
</div>
<div id="ShoppingCartPopUp" style="display: none;">
    <h2>
        <asp:Label ID="lblMyCartTitle" runat="server" Text="My Cart Item(s)" CssClass="cssClassShoppingBag"></asp:Label></h2>
    <div class="cssClassCommonSideBoxTable">
        <table id="tblListCartItems" cellspacing="0" cellpadding="0" border="0" width="100%">
        </table>
        <a id="lnkViewCart">View Cart</a> <a id="lnkMiniCheckOut">Checkout</a>
    </div>
</div>
<div id="popuprel4" class="popupbox cssClassCenterPopBox">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblTitleCheckoutOpt" runat="server" Text="Checkout using one of the following options: "></asp:Label>
    </h2>
    <div id="divMiniCheckoutTypes" class="cssClassFormWrapper">
    </div>
</div>
<input type="hidden" id="hdnItemCostVariants" />