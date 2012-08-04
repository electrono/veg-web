<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RelatedItemsInCart.ascx.cs"
            Inherits="Modules_ASPXRelatedItemsInCart_RelatedItemsInCart" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var customerId = '<%= customerID %>';
    var sessionCode = '<%= sessionCode %>';
    var cultureName = '<%= cultureName %>';

    var relatedItemCount = '<%= noOfRelatedItemsInCart %>';
    var RelatedUpSellCrossSellItems = '';

    $(document).ready(function() {
        $("#divRelatedItems").hide();
        if ('<%= enableRelatedItemsInCart %>'.toLowerCase() == 'true') {
            GetItemRetatedUpSellAndCrossSellList();
            $("#divRelatedItems").show();
        }
    });

    function GetItemRetatedUpSellAndCrossSellList() {
        RelatedUpSellCrossSellItems = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetRelatedItemsByCartItems",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode, userName: userName, cultureName: cultureName, count: relatedItemCount }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        if (item.ImagePath == "") {
                            item.ImagePath = '<%= noImageRelatedItemsInCartPath %>';
                        }
                        if (item.AlternateText == "") {
                            item.AlternateText = item.Name;
                        }
                        if ((index + 1) % 4 == 0) {
                            RelatedUpSellCrossSellItems += "<div class=\"cssClassYouMayAlsoLikeBox cssClassYouMayAlsoLikeBoxFourth\">";
                        } else {
                            RelatedUpSellCrossSellItems += "<div class=\"cssClassYouMayAlsoLikeBox\">";
                        }
                        RelatedUpSellCrossSellItems += '<p class="cssClassCartPicture"><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx"><img height="92px" width="134px" alt="' + item.AlternateText + '" title="' + item.Name + '" src="' + aspxRootPath + item.ImagePath + '"></a></p>';
                        RelatedUpSellCrossSellItems += '<p class="cssClassProductRealPrice"><span>Price : ' + item.Price + '</span></p>';
                        if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                            if (item.IsOutOfStock) {
                                RelatedUpSellCrossSellItems += "<div class='cssClassButtonWrapper cssClassOutOfStock'><a href='#'><span>Out Of Stock</span></a></div></div>";
                            } else {
                                RelatedUpSellCrossSellItems += "<div class='cssClassButtonWrapper'><a href='#' onclick='AddToCartToJS(" + item.ItemID + "," + item.Price + "," + JSON2.stringify(item.SKU) + "," + 1 + ");'><span>Add to Cart</span></a></div></div>";
                            }
                        } else {

                            RelatedUpSellCrossSellItems += "<div class='cssClassButtonWrapper'><a href='#' onclick='AddToCartToJS(" + item.ItemID + "," + item.Price + "," + JSON2.stringify(item.SKU) + "," + 1 + ");'><span>Add to Cart</span></a></div></div>";
                        }
                    });
                    RelatedUpSellCrossSellItems += "<div class=\"cssClassClear\"></div>";
                    $("#divRelatedItemsInCart").html(RelatedUpSellCrossSellItems);
                } else {
                    $("#divRelatedItemsInCart").html("<span class=\"cssClassNotFound\">No Data found.</span>");
                }
            }
//            ,
//            error: function() {
//                alert("Error!");
//            }
        });
    }

    function AddToCartToJS(itemId, itemPrice, itemSKU, itemQuantity) {
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

</script>


<div id="divRelatedItems" class="cssClassProductDetailInformation cssClassYouMayAlsoLike">
    <h2>
        <asp:Label ID="lblYouMayAlsoLike" Text="You may also like :" runat="server" />
    </h2>
    <div class="cssClassYouMayAlsoLikeWrapper" id="divRelatedItemsInCart">
    </div>
</div>