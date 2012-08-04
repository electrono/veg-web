<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvanceSearch.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXGeneralSearch_AdvanceSearch" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var customerId = '<%= customerID %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var sessionCode = '<%= sessionCode %>';
    var arrItemListType = new Array();
    var arrResultToBind = new Array();

    $(document).ready(function() {
        $(document).ajaxStart(function() {
            $('#divAjaxLoader').show();
        });

        $(document).ajaxStop(function() {
            $('#divAjaxLoader').hide();
        });

        $("#txtPriceFrom").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgPriceFrom").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtPriceTo").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                $("#errmsgPriceTo").html("Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        LoadAdvanceSearchStaticImage();
        LoadAllCategoryForSearch();
        BindItemsViewAsDropDown();
        AdvanceSearchHideAll();
        BindAttributes();
        $("#ddlViewAs").val(1);
        BindItemsSortByDropDown();
        $("#ddlSortBy").val(1);
        $("#ddlViewAs").change(function() {
            BindResults();
        });
        $("#ddlSortBy").change(function() {
            // Create pagination element with options
            var items_per_page = $('#ddlPageSize').val();
            $("#Pagination").pagination(arrItemListType.length, {
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

        $("#ddlPageSize").change(function() {
            var items_per_page = $(this).val();
            $("#Pagination").pagination(arrItemListType.length, {
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

        $("#btnAdvanceSearch").click(function() {
            ShowSearchResult();
            AddUpdateAdvanceSearchTerm();
        });

        function LoadAdvanceSearchStaticImage() {
            $('#ajaxAdvanceSearchImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        }

        function AddUpdateAdvanceSearchTerm() {
            var searchTerm = $.trim($("#txtSearchFor").val());
            if (searchTerm == "") {
                return false;
            }
            if (searchTerm == "Search items here...") {
                searchTerm = "";
                return false;
            }

            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateSearchTerm",
                data: JSON2.stringify({ searchTerm: searchTerm, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function() {
                }
            //                ,
            //                error: function() {
            //                    alert("search term error");
            //                }
            });
        }

        $('#txtSearchFor').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSearchedTermList",
                    data: JSON2.stringify({ search: $('#txtSearchFor').val(), storeID: storeId, portalID: portalId }),
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataFilter: function(data) { return data; },
                    success: function(data) {
                        response($.map(data.d, function(item) {
                            return {
                                value: item.SearchTerm
                            }
                        }))
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus);
                    }
                });
            },
            minLength: 2
        });


        $(".searchForTextBox").each(function() {
            if ($(this).val() == "") {
                $(this).addClass("lightText").val("Search items here...");
            }
        });

        $(".searchForTextBox").bind("focus", function() {
            if ($(this).val() == "Search items here...") {
                $(this).removeClass("lightText").val("");
            }
            // focus lost action
        });

        $(".searchForTextBox").bind("blur", function() {
            if ($(this).val() == "") {
                $(this).val("Search items here...").addClass("lightText");
            }
        });

        $("#txtSearchFor").keyup(function(event) {
            if (event.keyCode == 13) {
                $("#btnAdvanceSearch").click();
            }
        });
        if ($('#divCheckBox ul li input[id=8]').length > 0) {
            $('.pricebox input,.pricebox span').show();
            $("#txtPriceFrom").val('');
            $("#txtPriceTo").val('');
        } else {
            $('.pricebox input,.pricebox span').hide();
            $("#txtPriceFrom").val('');
            $("#txtPriceTo").val('');
        }
    });

    function BindAttributes() {
        var params = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributes",
            data: params,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    var check = "<li><input type='checkbox' id=" + item.AttributeID + " value=" + item.InputTypeID + " name=" + item.ValidationTypeID + "><label> " + item.AttributeName + "</label></li>";
                    $("#divCheckBox ul").append(check);
                });
                if ($('#divCheckBox ul li input[id=8]').length > 0) {

                    $('#divCheckBox ul li input[id=8]').bind("click", function() {

                        if ($(this).attr('checked') == true) {
                            $("#txtPriceFrom").val('');
                            $("#txtPriceTo").val('');
                            $('.pricebox input,.pricebox span').show();
                        } else {
                            $("#txtPriceFrom").val('');
                            $("#txtPriceTo").val('');
                            $('.pricebox input,.pricebox span').hide();
                        }


                    });

                } else {

                }
            }
        //            ,
        //            error: function() {
        //                alert("error");
        //            }
        });
    }

    function AdvanceSearchHideAll() {
        $("#divItemViewOptions").hide();
        $("#divSearchPageNumber").hide();
        $("#divShowAdvanceSearchResult").hide();
    }

    function BindItemsViewAsDropDown() {
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
                        $("#ddlViewAs").append(displayOptions);
                    });
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function BindItemsSortByDropDown() {
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
                        $("#ddlSortBy").append(displayOptions);
                    });
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
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
                        csscody.alert('<h2>Information Alert</h2><p>The selected item is already in your wish list.</p>');
                    } else {
                        //  AddToList(itemID);
                        AddToWishListFromJS(itemID, storeId, portalId, userName, ip, countryName);
                    }
                }
            });
        } else {
            Login();
        }
    }

    function LoadAllCategoryForSearch() {
        var isActive = true;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllCategoryForSearch",
            data: JSON2.stringify({ prefix: '---', isActive: isActive, culture: cultureName, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var Elements = '';
                Elements += '<option value="0">--All Category--</option>';
                $.each(msg.d, function(index, item) {
                    Elements += "<option value=" + item.CategoryID + ">" + item.LevelCategoryName + "</option>";
                });
                $("#ddlCategory").html(Elements);
            }
        });
    }

    function ShowSearchResult() {
        var categoryId = $("#ddlCategory").val();
        var chkIDs = '';
        var priceFrom = $.trim($("#txtPriceFrom").val());
        var priceTo = $.trim($("#txtPriceTo").val());
        var searchText = $.trim($("#txtSearchFor").val());
        if (searchText == "Search items here...") {
            //  searchText = "";          
        }
        var attributeIds = '';

        if (categoryId == "0") {
            categoryId = null;
        }
        if (searchText == "") {
            alert("Enter Search Text");
            return false;
        }
        if (searchText == "Search items here...") {
            searchText = "";
        }

        //        if (isNaN(priceFrom) && isNaN(priceTo)) {
        //            csscody.alert('<h1>Alert Message</h1><p>Invalid price! Price should be number..</p>');
        //            return false;
        //        }
        if (priceFrom == "" || priceTo == "") {
            priceFrom = null;
            priceTo = null;
        } else if (eval(priceTo) < eval(priceFrom)) {
            alert("To Price must be greater than From Price");
            return false;
        }
        $("#divCheckBox ul").each(function() {
            var check = $(this).find("input[type='checkbox']");
            $.each(check, function() {
                if ($(this).attr("checked")) {
                    attributeIds += $(this).attr('id') + ',';
                    chkIDs += $(this).attr('value');
                    chkIDs += ',';
                    chkIDs += $(this).attr('name');
                    chkIDs += '#';
                }
            });
            attributeIds = attributeIds.substr(0, attributeIds.length - 1);

        });
        var params = {
            storeID: storeId,
            portalID: portalId,
            categoryID: categoryId,
            SearchText: searchText,
            checkValue: chkIDs,
            PriceFrom: priceFrom,
            PriceTo: priceTo,
            userName: userName,
            cultureName: cultureName,
            attributeIDS: attributeIds
        };

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemsByDyanamicAdvanceSearch",
            data: JSON2.stringify(params),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#divShowAdvanceSearchResult").html('');
                arrItemListType.length = 0;
                $("#divShowAdvanceSearchResult").show();
                if (msg.d.length > 0) {
                    $("#divShowAdvanceSearchResult").html('');
                    $("#divItemViewOptions").show();
                    $("#divSearchPageNumber").show();
                    $.each(msg.d, function(index, item) {
                        arrItemListType.push(item);
                    });
                    // Create pagination element with options from form
                    var items_per_page = $('#ddlPageSize').val();
                    $("#Pagination").pagination(arrItemListType.length, {
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
                    $("#divItemViewOptions").hide();
                    $("#divSearchPageNumber").hide();
                    $("#divShowAdvanceSearchResult").html("No items found!");
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function BindResults() {
        var viewAsOption = $("#ddlViewAs").val();
        if (arrResultToBind.length > 0) {
            switch (viewAsOption) {
            case '1':
                GridView();
                break;
            case '2':
                ListView();
                break;
            case '3':
                Grid2View();
                break;
            case '4':
                Grid3View();
                break;
            case '5':
                CompactListView();
                break;
            case '6':
                ProductGridView();
                break;
            case '7':
                ListWithoutOptionsView();
                break;
            }
        }
    }

    function AddToCartToJSAdvanceSearch(itemId, itemPrice, itemSKU, itemQuantity) {

        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
    }

    function GridView() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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

            $("#scriptResultGrid").tmpl(items).appendTo("#divShowAdvanceSearchResult");
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

    function ListView() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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
            $("#scriptResultList").tmpl(items).appendTo("#divShowAdvanceSearchResult");
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

    function Grid2View() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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
            $("#scriptResultGrid2").tmpl(items).appendTo("#divShowAdvanceSearchResult");
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

    function Grid3View() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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
            $("#scriptResultGrid3").tmpl(items).appendTo("#divShowAdvanceSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
        });
    }

    function CompactListView() {
        $("#divShowAdvanceSearchResult").html('');
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
        $("#divShowAdvanceSearchResult").html(CompactListViewElements);
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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

    function ProductGridView() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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

            $("#scriptResultProductGrid").tmpl(items).appendTo("#divShowAdvanceSearchResult");
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (value.IsOutOfStock) {
                    $(".cssClassAddtoCard_" + value.ItemID + " span").html('Out Of Stock');
                    $(".cssClassAddtoCard_" + value.ItemID).removeClass('cssClassAddtoCard');
                    $(".cssClassAddtoCard_" + value.ItemID).addClass('cssClassOutOfStock');
                    $(".cssClassAddtoCard_" + value.ItemID + " a").removeAttr('onclick');
                }
            }
            if ('<%= allowWishListAdvSearch %>'.toLowerCase() != 'true') {
                $('.cssClassWishListButton').hide();
            }
        });
    }

    function ListWithoutOptionsView() {
        $("#divShowAdvanceSearchResult").html('');
        $.each(arrResultToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImageAdSearchPath %>';
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

            $("#scriptResultListWithoutOptions").tmpl(items).appendTo("#divShowAdvanceSearchResult");
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
            if ('<%= allowWishListAdvSearch %>'.toLowerCase() != 'true') {
                $('.cssClassWishListWithoutOption').hide();
            }
        });
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
        var sortByOption = $("#ddlSortBy").val();
        if (arrItemListType.length > 0) {
            switch (sortByOption) {
            case '1':
//Newest to oldest asc
                arrItemListType.sort(sort_by('AddedOn', true));
                                                // Sort by start_time
                                                //arrItemListType.sort(sort_by('_AddedOn', false, function(a){return (new Date(a)).getTime()}));

                break;
            case '2':
//Oldest to newest desc
                arrItemListType.sort(sort_by('AddedOn', false));
                break;
            case '3':
//Price highest to lowest asc
// Sort by price high to low
                arrItemListType.sort(sort_by('Price', true, parseFloat));

                                                //arrItemListType.sort(function(a, b) { return parseFloat(a.price) - parseFloat(b.price) });
                break;
            case '4':
//Price lowest to highest desc
// Sort by price low to high
                arrItemListType.sort(sort_by('Price', false, parseFloat));
                                                //arrItemListType.sort(function(a, b) { return parseFloat(b.price) - parseFloat(a.price) });
                break;
                break;
            }

            var max_elem = Math.min((page_index + 1) * items_per_page, arrItemListType.length);
            var newcontent = '';
            arrResultToBind.length = 0;

            // Iterate through a selection of the content and build an HTML string
            for (var i = page_index * items_per_page; i < max_elem; i++) {
                //newcontent += '<dt>' + arrItemListType[i]._Name + '</dt>';
                arrResultToBind.push(arrItemListType[i]);
            }
            BindResults();
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
                                // This function creates an option object for the pagination function.
                                // This will be be unnecessary in your application where you just set
                                // the options once.

    function getOptionsFromForm() {
        var opt = { callback: pageselectCallback };
        //parseInt(
        opt.items_per_page = $('#ddlPageSize').val();
        //opt.num_display_entries = 10;
        //opt.current_page = 0;

        opt.prev_text = "Prevs";
        opt.next_text = "Nexts";
        //opt.prev_show_always = false;
        //opt.next_show_always = false;
        return opt;
    }

</script>

<div class="cssClassAdvenceSearch">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblTitle" runat="server" Text="Advance Search:"></asp:Label>
        </h2>
    </div>
    <div class="cssClassFormWrapper">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="tdpadding">
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblSearchFor" runat="server" Text="Search For:" CssClass="cssClassLabel cssClasssearchFor"></asp:Label>
                    <input type="text" id="txtSearchFor" class="cssClassNormalTextBox searchForTextBox" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblSearchIn" runat="server" Text="Search In:" CssClass="cssClassLabel"></asp:Label>
                    <div id="divCheckBox">
                        <ul>
                        </ul>
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCategory" runat="server" Text="Category:" CssClass="cssClassLabel"></asp:Label>
                    <select id="ddlCategory" class="cssClassDropDown">
                    </select>                    
                </td>
                <td>
                    <span class="pricebox">
                        <asp:Label ID="lblPriceIn" runat="server" Text="Price:" CssClass="cssClassLabel"></asp:Label>&nbsp;&nbsp;&nbsp;
                        <span> From:</span><input class="cssClassNormalTextBox" id="txtPriceFrom" type="text" /><span id="errmsgPriceFrom"></span>
                        <span> To:</span><input class="cssClassNormalTextBox" id="txtPriceTo" type="text" /><span id="errmsgPriceTo"></span>
                    </span>
                </td>
            </tr>
        </table>
    </div>
    <div class="cssClassButtonWrapper cssClassPaddingNone">
        <p>
            <button type="button" id="btnAdvanceSearch">
                <span><span>Search</span></span></button>
        </p>
    </div>
</div>
<div id="divAjaxLoader">
    <img id="ajaxAdvanceSearchImage" alt="loading...." />
</div>
<div id="divItemViewOptions" class="viewWrapper">
    <div id="divViewAs" class="view">
        View as:
        <select id="ddlViewAs" class="cssClassDropDown">
        </select>
    </div>
    <div id="divSortBy" class="sort">
        Sort by:
        <select id="ddlSortBy" class="cssClassDropDown">
        </select>
    </div>
</div>
<div id="divShowAdvanceSearchResult" class="cssClassDisplayResult">
</div>
<div class="cssClassClear">
</div>
<!-- TODO:: paging Here -->
<div class="cssClassPageNumber" id="divSearchPageNumber">
    <div class="cssClassPageNumberLeftBg">
        <div class="cssClassPageNumberRightBg">
            <div class="cssClassPageNumberMidBg">
                <div id="Pagination">
                </div>
                <div class="cssClassViewPerPage">
                    View Per Page
                    <select id="ddlPageSize" class="cssClassDropDown">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="40">40</option>
                    </select></div>
                <%--<table width="84%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td width="40">
                            <a href="#">Prev</a>
                        </td>
                        <td>
                            <span>1</span> <a href="#">2</a> <a href="#">3</a> <a href="#">4</a> <a href="#">5</a>
                            <a href="#">6</a> <a href="#">7</a> <a href="#">8</a> <a href="#">9</a> <a href="#">
                                10</a> <a href="#">11</a> <a href="#">12</a> <a href="#">13</a> <a href="#">14</a>
                            <a href="#">15</a> <a href="#">16</a> <a href="#">17</a> <a href="#">18</a> <a href="#">
                                19</a> <a href="#">20</a>
                        </td>
                        <td width="40">
                            <a href="#">Next</a>
                        </td>
                    </tr>
                </table>--%>
            </div>
        </div>
    </div>
</div>

<script id="scriptResultGrid" type="text/x-jquery-tmpl">
    <div class="cssClassProductsBox"> 
        <div class="cssClassProductsBoxInfo"> 
            <h2>${name}</h2> 
            <h3>${sku}</h3> 
            <div class="cssClassProductPicture"><img src=${imagePath} alt='${alternateText}'  title='${name}'></div> 
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
                <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
            </div></div>  
    </div>   
</script>

<script id="scriptResultList" type="text/x-jquery-tmpl">
    <div id="divProductListView_${itemID}" class="cssClassProductListView">
    <div class="cssClassProductListViewLeft">
        <p class="cssClassProductPicture"><img  src=${imagePath} alt='${alternateText}' title='${name}' /></p>
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
                    <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a></div>
            </div>
        </div>
        <div class="cssClassClear"></div>
    </div>
</script>

<script id="scriptResultGrid2" type="text/x-jquery-tmpl">
    <div class="cssClassGrid2Box">
    <div class="cssClassGrid2BoxInfo">
        <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
        <div class="cssClassGrid2Picture"><img src=${imagePath}  alt='${alternateText}' title='${name}' />
        </div>
        <div class="cssClassGrid2PriceBox">
            <div class="cssClassGrid2Price">
                <p class="cssClassGrid2OffPrice">Price : <span class="cssClassFormatCurrency">${listPrice}</span> <span class="cssClassGrid2RealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
            </div>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper"> 
                    <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
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
            <div class="cssClassGrid3Picture"><img  src=${imagePath} alt='${alternateText}' title='${name}' /></a></div>
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
        <td><div class="cssClassProductPicture"><img src=${imagePath}  alt='${alternateText}' title='${name}' /></div></td>
        <td><p class="cssClassCLProductInfo"><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></p></td>
        <td><p>${sku}</p></td>
        <td><p class="cssClsssCLPrice"><span class="cssClassFormatCurrency">${price}</span></p></td>
        <td>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">                      
                    <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span> Add to Cart </span></a>
                </div>
            </div></td>
    </tr>             
</script>

<script id="scriptResultProductGrid" type="text/x-jquery-tmpl">
    <div class="cssClassProductsGridBox">
        <div class="cssClassProductsGridInfo">
            <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
            <div class="cssClassProductsGridPicture"><img src=${imagePath}  alt='${alternateText}' title='${name}' /></div>
            <div class="cssClassProductsGridPriceBox">
                <div class="cssClassProductsGridPrice">
                    <p class="cssClassProductsGridOffPrice">Price : <span class="cssClassFormatCurrency">${listPrice}</span> <span class="cssClassProductsGridRealPrice"> <span class="cssClassFormatCurrency">${price}</span></span> </p>
                </div>
            </div>
            <div class="cssClassButtonWrapper">
                <div class="cssClassWishListButton">
                    <button onclick=" AddToWishList(${itemID}); " id="addWishList" type="button"><span>+ Add to Wishlist</span></button>
                </div>
            </div>
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper"> 
                    <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a> </div>
            </div>
            <div class="cssClassclear"></div>
        </div>
    </div>
</script>

<script id="scriptResultListWithoutOptions" type="text/x-jquery-tmpl">
    <div class="cssClassListViewWithOutOptions">
        <div class="cssClassListViewWithOutOptionsLeft">
            <p class="cssClassProductPicture"><img src=${imagePath} alt='${alternateText}' title='${name}' /></p>
        </div>
        <div class="cssClassListViewWithOutOptionsRight">
            <h2><a href="${aspxCommerceRoot}item/${sku}.aspx">${name}</a></h2>
            <p class="cssClassProductCode">${sku}</p> 
            <p>{{html shortDescription}}</p> 
            <p class="cssClassListViewWithOutOptionsPrice">Price : <span class="cssClassFormatCurrency">${price}</span> <span class="cssClassListViewWithOutOptionsOffPrice"> <span class="cssClassFormatCurrency">${listPrice}</span></span> <span class="cssClassInstock_${itemID}">In stock</span></p> 
            <div class="cssClassAddtoCard_${itemID} cssClassAddtoCard">
                <div class="cssClassButtonWrapper">   
                    <a href="#" onclick=" AddToCartToJSAdvanceSearch(${itemID},${price},${JSON2.stringify(sku)},${1}); "><span>Add to Cart</span></a>
                </div> 
            </div> 
            <div class="cssClassButtonWrapper cssClassWishListWithoutOption">
                <button type="button" id="addWishList" onclick=" AddToWishList(${itemID}); "><span><span>+ Add to Wishlist</span></span></button> 
            </div>
        </div> 
        <div class="cssClassClear"></div> 
    </div> 
</script>