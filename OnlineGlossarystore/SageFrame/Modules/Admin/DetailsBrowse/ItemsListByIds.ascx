<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemsListByIds.ascx.cs"
            Inherits="Modules_Admin_DetailsBrowse_ItemsListByIds" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var customerId = '<%= customerID %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var sessionCode = '<%= sessionCode %>';
    var itemIds = '<%= itemIds %>';

    var arrItemsOption = new Array();
    var arrItemsOptionToBind = new Array();
    $(document).ready(function() {
        ShoppingOptionsHideAll();
        BindItemsOptionViewAsDropDown();
        BindItemsOptionSortByDropDown();

        $("#ddlOptionViewAs").change(function() {
            BindItemOptionsResults();
        });

        $("#ddlOptionSortBy").change(function() {
            // Create OptionPagination element with options
            var items_per_page = $('#ddlOptionPageSize').val();
            $("#OptionPagination").pagination(arrItemsOption.length, {
                callback: pageselectCallback,
                items_per_page: items_per_page,
                //num_display_entries: 10,
                //current_page: 0,
                prev_text: "Prev",
                next_text: "Next",
                prev_show_always: false,
                next_show_always: false
            });
        });

        $("#ddlOptionPageSize").change(function() {
            var items_per_page = $(this).val();
            $("#OptionPagination").pagination(arrItemsOption.length, {
                callback: pageselectCallback,
                items_per_page: items_per_page,
                //num_display_entries: 10,
                //current_page: 0,
                prev_text: "Prev",
                next_text: "Next",
                prev_show_always: false,
                next_show_always: false
            });
        });
    });

    function BindShoppingOptionResultItems() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetShoppingOptionsItemsResult",
            data: JSON2.stringify({ itemIds: itemIds, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#divOptionsSearchResult").html('');
                arrItemsOption.length = 0;
                $("#divOptionsSearchResult").show();
                $("#ddlOptionViewAs").val(1);
                $("#ddlOptionSortBy").val(1);
                if (msg.d.length > 0) {
                    $("#divOptionsSearchResult").html('');
                    $("#divOptionItemViewOptions").show();
                    $("#divOptionPageNumber").show();
                    $("#divOptionViewAs").val(1);
                    $.each(msg.d, function(index, item) {
                        arrItemsOption.push(item);
                    });
                    // Create OptionPagination element with options from form
                    var items_per_page = $('#ddlOptionPageSize').val();
                    $("#OptionPagination").pagination(arrItemsOption.length, {
                        callback: pageselectCallback,
                        items_per_page: items_per_page,
                        //num_display_entries: 10,
                        //current_page: 0,
                        prev_text: "Prev",
                        next_text: "Next",
                        prev_show_always: false,
                        next_show_always: false
                    });
                } else {
                    $("#divOptionItemViewOptions").hide();
                    $("#divOptionPageNumber").hide();
                    $("#divOptionsSearchResult").html("No items found!");
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function ShoppingOptionsHideAll() {
        $("#divOptionItemViewOptions").hide();
        $("#divOptionPageNumber").hide();
        $("#divOptionsSearchResult").hide();
    }

    function BindItemOptionsResults() {
        var viewAsOption = $("#ddlOptionViewAs").val();
        if (arrItemsOptionToBind.length > 0) {
            switch (viewAsOption) {
            case '1':
                ShoppingOptionGridView();
                break;
            case '2':
                ShoppingOptionListView();
                break;
            case '3':
                ShoppingOptionGrid2View();
                break;
            case '4':
                ShoppingOptionGrid3View();
                break;
            case '5':
                ShoppingOptionCompactListView();
                break;
            case '6':
                ShoppingOptionProductGridView();
                break;
            case '7':
                ShoppingOptionListWithoutOptionsView();
                break;
            }
        }
    }

    function BindItemsOptionViewAsDropDown() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindItemsViewAsList",
            data: ({ }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        var displayOptions = "<option value=" + item.DisplayItemID + ">" + item.OptionType + "</option>"
                        $("#ddlOptionViewAs").append(displayOptions);
                    });
                }
                BindShoppingOptionResultItems()
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function BindItemsOptionSortByDropDown() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindItemsSortByList",
            data: ({ }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        var displayOptions = "<option value=" + item.SortOptionTypeID + ">" + item.OptionType + "</option>"
                        $("#ddlOptionSortBy").append(displayOptions);
                    });
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function AddToCartToJSShoppingOption(itemId, itemPrice, itemSKU, itemQuantity) {
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

    function ShoppingOptionGridView() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];
            $("#scriptResultGrid").tmpl(items).appendTo("#divOptionsSearchResult");
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
    }

    function ShoppingOptionListView() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }

            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];
            $("#scriptResultList").tmpl(items).appendTo("#divOptionsSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            if (value.IsFeatured.toLowerCase() == 'no') {
                $(".cssClassFeaturedBg_" + value.ItemID).hide();
            }
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (value.IsOutOfStock) {
                    $(".cssClassAddtoCard_" + value.ItemID + " span").html('Out Of Stock');
                    $(".cssClassAddtoCard_" + value.ItemID).removeClass('cssClassAddtoCard');
                    $(".cssClassAddtoCard_" + value.ItemID).addClass('cssClassOutOfStock');
                    $(".cssClassAddtoCard_" + value.ItemID + " a").removeAttr('onclick');
                }
            }
            if (value.HidePrice == true) {
                $("#divProductListView_" + value.ItemID + " [class=\"cssClassListViewProductPrice\"]").html('');

            }
            if (value.IsFeatured != null) {
                if (value.IsFeatured.toLowerCase() == "no") {
                    $("#divProductListView_" + value.ItemID + " [class=\"cssClassFeaturedBg\"]").hide();
                }
            }
        });
    }

    function ShoppingOptionGrid2View() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];
            $("#scriptResultGrid2").tmpl(items).appendTo("#divOptionsSearchResult");
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
    }

    function ShoppingOptionGrid3View() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];
            $("#scriptResultGrid3").tmpl(items).appendTo("#divOptionsSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
        });
    }

    function ShoppingOptionCompactListView() {
        $("#divOptionsSearchResult").html('');
        var CompactListViewElements = '';
        CompactListViewElements += '<div class="cssClassCompactList">';
        CompactListViewElements += '<table width="100%" cellspacing="0" id="tblCompactList" cellpadding="0" border="0">';
        CompactListViewElements += '<tr class="cssClassHeadeTitle">';
        CompactListViewElements += '<td class="cssClassCLPicture">&nbsp;</td>';
        CompactListViewElements += '<td class="cssClassCLProduct">Item</td>';
        CompactListViewElements += '<td class="cssClassCLProductCode">SKU code</td>';
        CompactListViewElements += '<td class="cssClassCLPrice">Price</td>';
        CompactListViewElements += '<td class="cssClassCLAddtoCart">&nbsp;</td>';
        CompactListViewElements += '</tr>';
        CompactListViewElements += '</table></div>'
        $("#divOptionsSearchResult").html(CompactListViewElements);
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];

            $("#scriptCompactList").tmpl(items).appendTo("#tblCompactList");
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
        $("#tblCompactList tr:even").addClass("cssClassAlternativeEven");
        $("#tblCompactList tr:odd").addClass("cssClassAlternativeOdd");
    }

    function ShoppingOptionProductGridView() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];

            $("#scriptResultProductGrid").tmpl(items).appendTo("#divOptionsSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (value.IsOutOfStock) {
                    $(".cssClassAddtoCard_" + value.ItemID + " span").html('Out Of Stock');
                    $(".cssClassAddtoCard_" + value.ItemID).removeClass('cssClassAddtoCard');
                    $(".cssClassAddtoCard_" + value.ItemID).addClass('cssClassOutOfStock');
                    $(".cssClassAddtoCard_" + value.ItemID + " a").removeAttr('onclick');
                }
            }
            if ('<%= allowWishListItemsById %>'.toLowerCase() != 'true') {
                $('.cssClassWishListButton').hide();
            }
        });
    }

    function ShoppingOptionListWithoutOptionsView() {
        $("#divOptionsSearchResult").html('');
        $.each(arrItemsOptionToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= defaultShoppingOptionImgPath %>';
            } else if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var items = [{
                aspxCommerceRoot: aspxRedirectPath,
                itemID: value.ItemID,
                name: value.Name,
                sku: value.SKU,
                imagePath: aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small'),
                alternateText: value.AlternateText,
                listPrice: (value.ListPrice * rate),
                price: (value.Price * rate),
                shortDescription: Encoder.htmlDecode(value.ShortDescription)
            }];
            $("#scriptResultListWithoutOptions").tmpl(items).appendTo("#divOptionsSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (value.IsOutOfStock) {
                    $(".cssClassInstock_" + value.ItemID).html('Out Of Stock');
                    $(".cssClassAddtoCard_" + value.ItemID + " span").html('Out Of Stock');
                    $(".cssClassAddtoCard_" + value.ItemID).removeClass('cssClassAddtoCard');
                    $(".cssClassAddtoCard_" + value.ItemID).addClass('cssClassOutOfStock');
                    $(".cssClassAddtoCard_" + value.ItemID + " a").removeAttr('onclick');
                }
            }
            if ('<%= allowWishListItemsById %>'.toLowerCase() != 'true') {
                $('.cssClassWishListWithoutOption').hide();
            }
        });
    }

    function pageselectCallback(page_index, jq) {
        // Get number of elements per pagionation page from form
        var items_per_page = $('#ddlOptionPageSize').val();
        var sortByOption = $("#ddlOptionSortBy").val();
        if (arrItemsOption.length > 0) {
            switch (sortByOption) {
            case '1':
//Newest to oldest asc
                arrItemsOption.sort(sort_by('AddedOn', true));
                                                // Sort by start_time
                                                //arrItemsOption.sort(sort_by('_AddedOn', false, function(a){return (new Date(a)).getTime()}));

                break;
            case '2':
//Oldest to newest desc
                arrItemsOption.sort(sort_by('AddedOn', false));
                break;
            case '3':
//Price highest to lowest asc
// Sort by price high to low
                arrItemsOption.sort(sort_by('Price', true, parseFloat));

                                                //arrItemsOption.sort(function(a, b) { return parseFloat(a.price) - parseFloat(b.price) });
                break;
            case '4':
//Price lowest to highest desc
// Sort by price low to high
                arrItemsOption.sort(sort_by('Price', false, parseFloat));
                                                //arrItemsOption.sort(function(a, b) { return parseFloat(b.price) - parseFloat(a.price) });
                break;
            //                                            case '5':         
            //                                                SortArray();         
            //                                                break;        
            }
            //                                        $.each(arrItemsOption, function(index, item) {
            //                                            alert(item.AddedOn);
            //                                        });


            var max_elem = Math.min((page_index + 1) * items_per_page, arrItemsOption.length);
            var newcontent = '';
            arrItemsOptionToBind.length = 0;

            // Iterate through a selection of the content and build an HTML string
            for (var i = page_index * items_per_page; i < max_elem; i++) {
                //newcontent += '<dt>' + arrItemsOption[i]._Name + '</dt>';
                arrItemsOptionToBind.push(arrItemsOption[i]);
            }
            BindItemOptionsResults();
        }

        // Replace old content with new content
        //$('#Searchresult').html(newcontent);

        // Prevent click event propagation
        return false;
    }

    var sort_by = function(field, reverse, primer) {

        reverse = (reverse) ? -1 : 1;

        return function(a, b) {

            a = a[field];
            b = b[field];

            if (typeof(primer) != 'undefined') {
                a = primer(a);
                b = primer(b);
            }

            if (a < b) return reverse * -1;
            if (a > b) return reverse * 1;
            return 0;

        }
    }

                                // The form contains fields for many pagiantion optiosn so you can 
                                // quickly see the resuluts of the different options.
                                // This function creates an option object for the OptionPagination function.
                                // This will be be unnecessary in your application where you just set
                                // the options once.

    function getOptionsFromForm() {
        var opt = { callback: pageselectCallback };
        //parseInt(
        opt.items_per_page = $('#ddlOptionPageSize').val();
        //opt.num_display_entries = 10;
        //opt.current_page = 0;

        opt.prev_text = "Prevs";
        opt.next_text = "Nexts";
        //opt.prev_show_always = false;
        //opt.next_show_always = false;
        return opt;
    }

    function AddUpdateSearchTerm() {
        if (searchText == "") {
            return false;
        }
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateSearchTerm",
            data: JSON2.stringify({ searchTerm: searchText, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function() {
            },
            error: function() {
                alert("search term error");
            }
        });
    }

    function AddToWishList(itemID) {
        if (userName.toLowerCase() != 'anonymoususer') {
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
                        csscody.alert('<h2>Information Alert</h2><p>This item is already in your wish list.</p>');
                    } else {
                        // AddToList(itemID);
                        AddToWishListFromJS(itemID, storeId, portalId, userName, ip, countryName);
                    }
                }
            });
        } else {
            Login();
        }
    }

</script>

<div id="divOptionItemViewOptions" class="viewWrapper">
    <div id="divOptionViewAs" class="view">
        View as:
        <select id="ddlOptionViewAs" class="cssClassDropDown">
        </select>
    </div>
    <div id="divSortBy" class="sort">
        Sort by:
        <select id="ddlOptionSortBy" class="cssClassDropDown">
        </select>
    </div>
</div>
<div id="divOptionsSearchResult" class="cssClassDisplayResult">
</div>
<div class="cssClassClear">
</div>
<!-- TODO:: paging Here -->
<div class="cssClassPageNumber" id="divOptionPageNumber">
    <div class="cssClassPageNumberLeftBg">
        <div class="cssClassPageNumberRightBg">
            <div class="cssClassPageNumberMidBg">
                <div id="OptionPagination">
                </div>
                <div class="cssClassViewPerPage">
                    View Per Page
                    <select id="ddlOptionPageSize" class="cssClassDropDown">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="40">40</option>
                    </select></div>
            </div>
        </div>
    </div>
</div>

<script id="scriptResultGrid" type="text/x-jquery-tmpl">
    <div class="cssClassProductsBox"> 
        <div class="cssClassProductsBoxInfo"> 
            <h2>${name}</h2> 
            <h3>${sku}</h3> 
            <div class="cssClassProductPicture"><img  src='${imagePath}' alt='${alternateText}'  title='${name}'></div> 
            <div class="cssClassProductPriceBox"> 
                <div class="cssClassProductPrice"> 
                    <p class="cssClassProductOffPrice">Regular Price : <span class="cssClassFormatCurrency">${listPrice}</span></p> 
                    <p class="cssClassProductRealPrice">Our Offer : <span class="cssClassFormatCurrency">${price}</span></p> 
                </div>  
            </div>
            <div class="cssClassProductDetail">  
                <p><a href="${aspxCommerceRoot}item/${sku}.aspx">Details</a></p>  
            </div>  
            <div class="cssClassclear"></div>  
        </div>  
        <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
            <div class="cssClassButtonWrapper"> 
                <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
            </div></div>  
    </div>  
</script>

<script id="scriptResultList" type="text/x-jquery-tmpl">
    <div class="cssClassProductListView">
    <div class="cssClassProductListViewLeft">
        <p class="cssClassProductPicture"><img  alt='${alternateText}' src='${imagePath}' title='${name}' /></p>
        <p class="cssClassFeaturedBg cssClassFeaturedBg_${itemID}" ><a href="#">FEATURED</a></p>
    </div>
    <div class="cssClassProductListViewRight">
        <h2>${name}</h2>
        <p>{{html shortDescription}}</p>
        <p class="cssClassListViewProductPrice">Price : <b><span class="cssClassFormatCurrency">${listPrice}</span></b> <span class="cssClassFormatCurrency">${price}</span></p>
        <div class="cssClassViewDetailsAddtoCart"> 
            <div class="cssClassButtonWrapper">
                <a href="${aspxCommerceRoot}item/${sku}.aspx"><span>View Details</span></a>
            </div>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">
                    <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a></div>
            </div>
        </div>
        <div class="cssClassClear"></div>
    </div>
</script>

<script id="scriptResultGrid2" type="text/x-jquery-tmpl">
    <div class="cssClassGrid2Box">
    <div class="cssClassGrid2BoxInfo">
        <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
        <div class="cssClassGrid2Picture"><img  alt='${alternateText}' src='${imagePath}' title='${name}' />
        </div>
        <div class="cssClassGrid2PriceBox">
            <div class="cssClassGrid2Price">
                <p class="cssClassGrid2OffPrice">Price : <span class="cssClassFormatCurrency">${listPrice}</span> <span class="cssClassGrid2RealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
            </div>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">
                    <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
                </div>
            </div>
            <div class="cssClassclear"></div>
        </div>
    </div>
</script>

<script id="scriptResultGrid3" type="text/x-jquery-tmpl">
    <div class="cssClassGrid3Box">
        <div class="cssClassGrid3BoxInfo">
            <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
            <div class="cssClassGrid3Picture"><img  alt='${alternateText}' src='${imagePath}' title='${name}' /></a></div>
            <div class="cssClassGrid3PriceBox">
                <div class="cssClassGrid3Price">
                    <p class="cssClassGrid3OffPrice">Price : <span class="cssClassFormatCurrency">${listPrice}</span> <span class="cssClassGrid3RealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
                </div>
                <div class="cssClassclear"></div>
            </div>
        </div>
    </div>
</script>

<script id="scriptCompactList" type="text/x-jquery-tmpl">
    <tr>
        <td><div class="cssClassProductPicture"><img  src='${imagePath}' alt='${alternateText}' title='${name}' /></div></td>
        <td><p class="cssClassCLProductInfo"><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></p></td>
        <td><p>${sku}</p></td>
        <td><p class="cssClsssCLPrice"><span class="cssClassFormatCurrency">${price}</span></p></td>
        <td>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">
                    <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
                </div>
            </div></td>
    </tr>             
</script>

<script id="scriptResultProductGrid" type="text/x-jquery-tmpl">
    <div class="cssClassProductsGridBox">
        <div class="cssClassProductsGridInfo">
            <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
            <div class="cssClassProductsGridPicture"><img alt='${alternateText}' src='${imagePath}' title='${name}' /></div>
            <div class="cssClassProductsGridPriceBox">
                <div class="cssClassProductsGridPrice">
                    <p class="cssClassProductsGridOffPrice">Price : <span class="cssClassFormatCurrency">${listPrice}</span> <span class="cssClassProductsGridRealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <div class="cssClassWishListButton">
                    <button onclick=" AddToWishList(${itemID}); " id="addWishList" type="button"><span><span>Add to Wishlist</span></span></button>
                </div>
            </div>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper"> 
                    <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a> </div>
            </div>
            <div class="cssClassclear"></div>
        </div>
    </div>
</script>

<script id="scriptResultListWithoutOptions" type="text/x-jquery-tmpl">
    <div class="cssClassListViewWithOutOptions">
        <div class="cssClassListViewWithOutOptionsLeft">
            <p class="cssClassProductPicture"><img  alt='${alternateText}' src='${imagePath}' title='${name}' /></p>
        </div>
        <div class="cssClassListViewWithOutOptionsRight">
            <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
            <p class="cssClassProductCode">${sku}</p> 
            <p>{{html shortDescription}}</p> 
            <p class="cssClassListViewWithOutOptionsPrice">Price : <span class="cssClassFormatCurrency">${price}</span> <span class="cssClassListViewWithOutOptionsOffPrice"> <span class="cssClassFormatCurrency">${listPrice}</span></span> <span class="cssClassInstock_${itemID}">In stock</span></p> 
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">   
                    <a href="#" onclick=" AddToCartToJSShoppingOption(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a> 
                </div> 
            </div>
            <div class="cssClassButtonWrapper cssClassWishListWithoutOption">
                <button type="button" id="addWishList" onclick=" AddToWishList(${itemID}); "><span><span>+ Add to Wishlist</span></span></button> 
            </div> 
        </div> 
        <div class="cssClassClear"></div> 
    </div> 
</script>