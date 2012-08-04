<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BestSellers.ascx.cs" Inherits="Modules_ASPXBestSellers_BestSellers" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var countSeller = '<%= countBestSeller %>';


    $(document).ready(function() {
        $("#divBestSellers").hide();
        if ('<%= enableBestSellerItems %>'.toLowerCase() == 'true') {
            GetBestSoldItems();
            $("#divBestSellers").show();
        }
    });

    function GetBestSoldItems() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetBestSoldItems",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, count: countSeller }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        //_ImagePath":"Modules\/ASPXItemsManagement\/uploads\/item_1_213388.bmp","_ItemName":"item 1","_Sku":"skuitem1","_SoldItem":29,"_itemid":1}
                        //  $(".cssClassBestSellerBoxInfo ul").append('');
                        $(".cssClassBestSellerBoxInfo ul").append('<li><a href="' + aspxRedirectPath + 'item/' + item.Sku + '.aspx" ><img src="' + aspxRootPath + item.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + item.ItemName + '" /></a><a href="' + aspxRedirectPath + 'item/' + item.Sku + '.aspx" >' + item.ItemName + '</a></li>');
                    });
                } else {
                    $(".cssClassBestSellerBox").html("<span class=\"cssClassNotFound\">No item is sold in this store Yet!</span>");
                    $(".cssClassBestSellerBox").removeClass("cssClassBestSellerBox");
                }
            } //,
        //            error: function() {
        //                alert("error");
        //            }
        });
    }
</script>

<div id="divBestSellers" class="cssClassBestSeller cssClassBestSellerMargin">
    <h2>
        Best Sellers</h2>
    <div class="cssClassBestSellerBox">
        <div class="cssClassBestSellerBoxInfo">
            <h3>
                BestSeller Items</h3>
            <ul>
            </ul>
        </div>
        <div class="cssClassclear">
        </div>
    </div>
</div>