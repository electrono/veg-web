<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemCompareDetails.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXItemsCompare_ItemCompareDetails" %>

<script type="text/javascript" language="javascript">

  //  var storeId = '<%= storeID %>';
  //  var portalId = '<%= portalID %>';
  //  var customerId = '<%= customerID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var sessionCode = '<%= sessionCode %>';
    var IDs = "";
//"1#2#10";

    $(document).ready(function() {
        IDs = $.cookies.get("ItemCompareDetail");
        //alert(IDs);
        GetCompareListImage(IDs);
        GetCompareList(IDs);
        RecentAdd(IDs);
        if ($("#tblRecentlyComparedItemList").length > 0) {
            // var CompareCount = 3;
            // GetRecentlyComparedItemList(storeId, portalId, userName, cultureName, aspxRootPath, CompareCount);          
            RecentlyCompareItemsList();
        }
    });

    function GetCompareList(IDs) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCompareList",
            data: JSON2.stringify({ itemIDs: IDs, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var tableElements = '';
                var myIds = new Array();
                var myAttributes = new Array();
                $("#tblItemCompareList >tbody").html('');
                $("#divItemCompareElements").html("");

                $("#scriptStaticField").tmpl().appendTo("#divItemCompareElements");

                $.each(msg.d, function(index, value) {
                    var cssClass = '';
                    if (value.InputTypeID == 7) {
                        cssClass = 'cssClassFormatCurrency';
                    }
                    if (jQuery.inArray(value.AttributeName, myAttributes) < 0) {
                        $("#tblItemCompareList >tbody").append('<tr id="trCompare_' + index + '"></tr>');
                        $("#tblItemCompareList >tbody> tr:last").append('<td><span class="cssClassLabel">' + value.AttributeName + ': </span></td>');
                        var attributValue = [{ CssClass: cssClass, AttributeValue: Encoder.htmlDecode(value.AttributeValue) }];
                        $("#scriptAttributeValue").tmpl(attributValue).appendTo("#tblItemCompareList tbody>tr:last");
                        myAttributes.push(value.AttributeName);
                    } else {
                        var i = index % (myAttributes.length);
                        attributValue = [{ CssClass: cssClass, AttributeValue: Encoder.htmlDecode(value.AttributeValue) }]; //{{html shortDescription}}
                        $("#scriptAttributeValue").tmpl(attributValue).appendTo("#trCompare_" + i + "");
                    }
                });

                $("#divItemCompareElements").find('table>tbody').html(tableElements);
                $("#tblItemCompareList tr:even").addClass("cssClassAlternativeEven");
                $("#tblItemCompareList tr:odd").addClass("cssClassAlternativeOdd");
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            },
            error: function() {
                alert("Compare List error");
            }
        });
    }

    function RecentAdd(Id) {
        var param = JSON2.stringify({ IDs: Id, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "Post",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddComparedItems",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
            },
            error: function() {
                alert("error");
            }
        });
    }

    function GetCompareListImage(IDs) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCompareListImage",
            data: JSON2.stringify({ itemIDs: IDs, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var tableElements = '';

                var htMl = '';
                $("#divCompareElements").html("");
                //  $("#scriptStaticField").tmpl().appendTo("#divCompareElements");
                $.each(msg.d, function(index, value) {

                    if (value.ImagePath == "") {
                        value.ImagePath = '<%= noImageItemComparePath %>';
                    } else if (value.AlternateText == "") {
                        value.AlternateText = value.Name;
                    }
                    var items = [{
                        aspxCommerceRoot: aspxRootPath,
                        itemID: value.ItemID,
                        name: value.Name,
                        sku: value.SKU,
                        imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                        alternateText: value.AlternateText,
                        listPrice: value.ListPrice,
                        price: value.Price,
                        shortDescription: Encoder.htmlDecode(value.ShortDescription)
                    }];
                    $("#scriptResultProductGrid2").tmpl(items).appendTo("#tblItemCompareList thead > tr");
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                    if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                        if (value.IsOutOfStock) {
                            $(".cssClassAddtoCard_" + value.ItemID + " span").html('Out Of Stock');
                            $(".cssClassAddtoCard_" + value.ItemID).removeClass('cssClassAddtoCard');
                            $(".cssClassAddtoCard_" + value.ItemID).addClass('cssClassOutOfStock');
                            $(".cssClassAddtoCard_" + value.ItemID + " a").removeAttr('onclick');
                        }
                    }

                });
            },
            error: function() {
                alert("Compare List error");
            }
        });
    }

    function CheckWishListUniqueness(itemID) {
        if (customerId > 0 && userName.toLowerCase() != "anonymoususer") {
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
                        // alert("add");
                        //  AddToWishList(itemID);
                        $('#fade, #popuprel6').fadeOut();
                        AddToWishListFromJS(itemID, storeId, portalId, userName, ip, countryName);
                    }
                }
            });
        } else {
            window.location.href = aspxRootPath + 'Login.aspx';
            return false;
        }
    }

    function AddToCartToJSs(itemId, itemPrice, itemSKU, itemQuantity) {
        // alert(itemId +',' + itemPrice +   itemSKU+itemQuantity);            
        $('#fade, #popuprel6').fadeOut();
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

</script>

<div id="divItemCompareElements" class="cssClassFormWrapper">
</div>
<table id="tblItemCompareList" width="100%" border="0" cellspacing="0" cellpadding="0">
    <thead>
        <tr>
            <td>
            </td>
        </tr>
    </thead>
    <tbody>
        <tr>
        </tr>
    </tbody>
</table>

<script id="scriptStaticField" type="text/x-jquery-tmpl">
</script>

<script id="scriptAttributeValue" type="txt/x-jquery-tmpl">
<td class="${CssClass}">{{html AttributeValue}}</td>
</script>

<script id="scriptResultProductGrid2" type="text/x-jquery-tmpl">                        
    <td>
        <div id="comparePride" class="cssClassProductsGridBox">
            <div class="cssClassProductsGridInfo">
                <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
                <div class="cssClassProductsGridPicture"><img src='${imagePath}' alt='${alternateText}' title='${name}' /></div>
                <div class="cssClassProductsGridPriceBox">
                    <div class="cssClassProductsGridPrice">
                        <p class="cssClassProductsGridOffPrice">Price :<del><span class="cssClassFormatCurrency">${listPrice}</span></del> <span class="cssClassProductsGridRealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
                    </div>
                </div>

                <div id="compareAddToWishlist" class="cssClassButtonWrapper">
                    <div class="cssClassWishListButton">
                        <button onclick=" CheckWishListUniqueness(${itemID}); " id="addWishList" type="button"><span>+ Add to Wishlist</span></button>
                    </div>
                </div>
                <div id="compareAddToCart" class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                    <div class="cssClassButtonWrapper"> 
                        <a href="#" onclick=" AddToCartToJSs(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a> </div>
                </div>
                <div class="cssClassclear"></div>
            </div>
        </div>
    </td>
</script>