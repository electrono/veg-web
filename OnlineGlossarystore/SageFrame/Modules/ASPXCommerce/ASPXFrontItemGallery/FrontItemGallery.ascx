<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FrontItemGallery.ascx.cs"
            Inherits="Modules_ASPXFrontItemGallery_FrontItemGallery" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        BindFeaturedItemsGallery();
    });

    function BindFeaturedItemsGallery() {
        var count = 5;
        var params = { storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName, count: count };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetFeaturedItemsList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var featuredItemGalleryContents = '';
                var itemCaption = '';
                var featuredItemGallery = '';
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        if (item.ImagePath == "") {
                            item.ImagePath = aspxRootPath + '<%= noImageFeaturedItemPath %>';
                        }
                        if (item.AlternateText == "") {
                            item.AlternateText = item.Name;
                        }
                        var medpath = item.ImagePath;
                        medpath = medpath.replace('uploads', 'uploads/Medium');
                        featuredItemGalleryContents += '<a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx"><img alt="' + item.AlternateText + '" src="' + aspxRootPath + medpath + '" class=\"cssClassItemImage\" width=\"240"\ height=\"240"\ title="#Caption-' + item.ItemID + '" /></a>';
                        itemCaption += BindItemCaption(item.ItemID, item.Name, Encoder.htmlDecode(item.ShortDescription), item.Price, item.SKU);
                    });
                    featuredItemGallery += '<div id="slider" class="nivoSlider">' + featuredItemGalleryContents + '</div>' + itemCaption;
                    //_ItemID; _DateFrom; _DateTo; _IsFeatured; _SKU; _Name; _ShortDescription; _Price; _ListPrice; _HidePrice; _HideInRSSFeed; _HideToAnonymous; _AddedOn;
                    $("#slider-wrapper").html(featuredItemGallery);
                    $('#slider').nivoSlider();
                } else {
                    featuredItemGallery += "<div class=\"nivoSlider\"><div class=\"cssClassNotFound\">This store has no featured items found!</div></div>";
                    //_ItemID; _DateFrom; _DateTo; _IsFeatured; _SKU; _Name; _ShortDescription; _Price; _ListPrice; _HidePrice; _HideInRSSFeed; _HideToAnonymous; _AddedOn;
                    $("#slider-wrapper").html(featuredItemGallery);
                }
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            }
//            ,
//            error: function() {
//                csscody.error('<h1>Error Message</h1><p>Failed to load featured items.</p>');
//            }
        });
    }

    function BindItemCaption(itemId, itemName, itemShortDesc, itemPrice, itemSKU) {
        return '<div id="Caption-' + itemId + '" class="nivo-html-caption"><a href="' + aspxRedirectPath + 'item/' + itemSKU + '.aspx">' + itemName + '</a><span >Price : <span class="cssClassFormatCurrency">' + itemPrice + '</span></span></div>';
    }

</script>

<div id="tblFeaturedItems">
</div>
<div id="wrapper">
    <div id="slider-wrapper">
    </div>
</div>