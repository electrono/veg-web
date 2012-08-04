<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LatestItems.ascx.cs" Inherits="Modules_ASPXLatestItems_LatestItems" %>
 
<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var customerId = '<%= customerID %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var sessionCode = '<%= sessionCode %>';
    var defaultImagePath = '<%= defaultImagePath %>';
    var noOfLatestItems = '<%= noOfLatestItems %>';
    $(document).ready(function() {

        $("#divLatestItems").hide();
        if ('<%= enableLatestItems %>'.toLowerCase() == 'true') {
            BindRecentItems();
            $("#divLatestItems").show();
        }
    });

    function fixedEncodeURIComponent(str) {
        return encodeURIComponent(str).replace( /!/g , '%21').replace( /'/g , '%27').replace( /\(/g , '%28').
            replace( /\)/g , '%29').replace( /\*/g , '%2A');
    }

    function AddItemsToCompare(itemId) {
        var countCompareItems = GetCompareItemsCount();
        if (countCompareItems >= '<%= maxCompareItemCount %>') {
            csscody.alert('<h2>Information Alert</h2><p>You cannot add more than <%= maxCompareItemCount %> items to compare list!!</p>');
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
                    csscody.alert('<h2>Information Alert</h2><p>The selected item is already in the compare list.</p>');
                } else {
                    AddToMyCompare(itemId);
                }
            }
        });
    }

    function AddToMyCompare(itemId) {
        var addparam = { ID: itemId, storeID: storeId, portalID: portalId, userName: userName, IP: ip, countryName: countryName, sessionCode: sessionCode };
        var adddata = JSON2.stringify(addparam);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveCompareItems",
            data: adddata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                csscody.alert('<h2>Information Message</h2><p>Item Successfully Added To your compare list.</p>');
                if ($("#h2compareitems").length > 0) {
                    GetCompareItemList(); //for MyCompareItem 
                }
            },
            error: function(msg) {
                alert("error");
            }
        });
    }

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
            }
//            ,
//            error: function(msg) {
//                alert("error");
//            }
        });
        return countCompareItems;
    }


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
                    AddToWishListFromJS(itemID, storeId, portalId, userName, ip, countryName); // AddToList ==> AddToWishList
                }
            }
        });
    }

    function IncreaseWishListCount() {
        var wishListCount = $('#lnkMyWishlist span ').html().replace( /[^0-9]/gi , '');
        wishListCount = parseInt(wishListCount) + 1;
        $('.cssClassLoginStatusInfo ul li a#lnkMyWishlist span ').html("[" + wishListCount + "]");
    }

    function AddToCartToJS(itemId, itemPrice, itemSKU, itemQuantity) {
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

    function IncreaseShoppingBagCount() {
        var myShoppingBagCount = $('#lnkshoppingcart').html().replace( /[^0-9]/gi , '');
        myShoppingBagCount = parseInt(myShoppingBagCount) + 1;
        $('#lnkshoppingcart').html(" My Shopping Bag [" + myShoppingBagCount + "]");
    }

    function BindRecentItems() {
        var count = noOfLatestItems;
        //alert(defaultImagePath);
        var params = { storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName, count: count };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetLatestItemsList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var RecentItemContents = '';
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        //if (!item.HideToAnonymous) {
                        if (item.ImagePath == "") {
                            item.ImagePath = defaultImagePath;
                        }
                        if (item.AlternateText == "") {
                            item.AlternateText = item.Name;
                        }
                        if ((index + 1) % eval('<%= noOfLatestItemsInARow %>') == 0) {
                            RecentItemContents += "<div class=\"cssClassProductsBox cssClassProductsBoxNoMargin\">";
                        } else {
                            RecentItemContents += "<div class=\"cssClassProductsBox\">";
                        }
                        var hrefItem = aspxRedirectPath + "item/" + fixedEncodeURIComponent(item.SKU) + ".aspx";
                        RecentItemContents += '<div class="cssClassProductsBoxInfo" itemid="' + item.ItemID + '"><h2>' + item.Name + '</h2><h3>' + item.SKU + '</h3><div class="cssClassProductPicture"><a href="' + hrefItem + '"><img  alt="' + item.AlternateText + '"  title="' + item.AlternateText + '" src="' + aspxRootPath + item.ImagePath.replace('uploads', 'uploads/Small') + '"></a></div>';

                        if (!item.HidePrice) {
                            RecentItemContents += "<div class=\"cssClassProductPriceBox\"><div class=\"cssClassProductPrice\"><p class=\"cssClassProductOffPrice\">Regular Price : <span class=\"cssClassFormatCurrency\" value=" + (item.ListPrice).toFixed(2) + ">" + (item.ListPrice * rate).toFixed(2) + "</span></p><p class=\"cssClassProductRealPrice \" >Our Offer : <span class=\"cssClassFormatCurrency\" value=" + (item.Price).toFixed(2) + ">" + (item.Price * rate).toFixed(2) + "</span></p></div></div>";
                        } else {
                            RecentItemContents += "<div class=\"cssClassProductPriceBox\"></div>";
                        }
                        RecentItemContents += '<div class="cssClassProductDetail"><p><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">Details</a></p></div>';

                        RecentItemContents += "<div class=\"cssClassButtonWrapper\">";
                        if ('<%= allowWishListLatestItem %>'.toLowerCase() == 'true') {
                            if (customerId > 0 && userName.toLowerCase() != "anonymoususer") {
                                RecentItemContents += "<div class=\"cssClassWishListButton\"><button type=\"button\" id=\"addWishList\" onclick='CheckWishListUniqueness(" + item.ItemID + ");'><span><span><span>+</span>Wishlist</span></span></button></div>";
                            } else {
                                RecentItemContents += "<div class=\"cssClassWishListButton\"><button type=\"button\" id=\"addWishList\" onclick='Login();'><span><span><span>+</span>Wishlist</span></span></button></div>";
                            }
                        }
                        //RecentItemContents+="<input type=\"button\" id=\"addWishList\" value=\"Add To Wishlist\" onclick='AddToWishList(" + item.ItemID + ");'/>";
                        //RecentItemContents += "<div class=\"cssClassWishListDetail\"><p><a href='addtowishlist.aspx?itemId="+ item.ItemID + "'>Add to Wishlist</a></p>";
                        if ('<%= allowAddToCompareLatest %>'.toLowerCase() == 'true') {
                            RecentItemContents += "<div class=\"cssClassCompareButton\"><button type=\"button\" id=\"btnAddCompare\" onclick='AddItemsToCompare(" + item.ItemID + ");'><span><span><span>+</span>Compare</span></span></button></div>";
                        }
                        RecentItemContents += "</div>";
                        RecentItemContents += "<div class=\"cssClassclear\"></div>";
                        var itemSKU = JSON2.stringify(item.SKU);
                        var itemName = JSON2.stringify(item.Name);
                        if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                            if (item.IsOutOfStock) {
                                RecentItemContents += "</div><div class=\"cssClassAddtoCard\"><div class=\"cssClassButtonWrapper cssClassOutOfStock\"><a href=\"#\"><span>Out Of Stock</span></a></div></div>";

                            } else {
                                RecentItemContents += "</div><div class=\"cssClassAddtoCard\"><div class=\"cssClassButtonWrapper\"><a href=\"#\" title=" + itemName + "  onclick='AddToCartToJS(" + item.ItemID + "," + item.Price.toFixed(2) + "," + itemSKU + "," + 1 + ");'><span>Add to cart</span></a></div></div>";

                            }
                        } else {
                            RecentItemContents += "</div><div class=\"cssClassAddtoCard\"><div class=\"cssClassButtonWrapper\"><a href=\"#\" title=" + itemName + "  onclick='AddToCartToJS(" + item.ItemID + "," + item.Price.toFixed(2) + "," + itemSKU + "," + 1 + ");'><span>Add to cart</span></a></div></div>";

                        }
                        RecentItemContents += "</div>";


                        // }
                    });
                } else {
                    RecentItemContents += "<span class=\"cssClassNotFound\">This store has no items listed yet!</span>";
                }
                //_ItemID; _DateFrom; _DateTo; _IsFeatured; _SKU; _Name; _Price; _ListPrice; _HidePrice; _HideInRSSFeed; _HideToAnonymous; _AddedOn; _ImagePath; _AlternateText
                $("#tblRecentItems").html(RecentItemContents);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                //$('.cssClassProductRealPrice span').formatCurrency({ colorize: true, region: '' + region + '' });
                //$(".cssClassProductsBoxInfo").draggable({ helper: 'clone', opacity: 0.5, cursor: 'crosshair', revert: true });
            }
        //            ,
        //            error: function() {
        //                csscody.error('<h1>Error Message</h1><p>Failed to load recent items.</p>');
        //            }
        });
    }

</script>

<div id="divLatestItems" class="cssClassProducts">
    <%--<h1>
        <asp:Label ID="lblRecentItemsHeading" runat="server" Text="Recently Added Items"
            CssClass="cssClassLabel"></asp:Label></h1>--%>
    <div id="tblRecentItems">
    
    </div>
    <div class="cssClassclear">
    </div>
</div>