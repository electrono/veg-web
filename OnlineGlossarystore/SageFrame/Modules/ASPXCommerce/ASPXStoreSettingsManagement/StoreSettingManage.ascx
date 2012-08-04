<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreSettingManage.ascx.cs"
            Inherits="Modules_ASPXStoreSettings_StoreSettingManage" %>
<script type="text/javascript" >
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideForLaterUseDivs();
        InitializeTabs();
        GetAllCountry();
        GetAllCurrency();
        GetAllStoreSettings();
        $("input[DataType='Integer']").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });
        $("#ddlCurrency").attr("disabled", "disabled");
        $("#txtWeightUnit").attr("disabled", "disabled");
        $("#form1").validate({
            messages: {
                DefaultImageProductURL: {
                    required: '*'
                },
                MyAccountURL: {
                    required: '*'
                },
                ShoppingCartURL: {
                    required: '*'
                },
                WishListURL: {
                    required: '*'
                },
                MainCurrency: {
                    required: '*'
                },
                Weight: {
                    required: '*'
                },
                StoreName: {
                    required: '*'
                },
                StoreCloseInformation: {
                    required: '*'
                },
                StoreNotAccessedInfo: {
                    required: '*'
                },
                TimeTodeleteAbandCart: {
                    required: '*',
                    number: true
                },
                CartAbandonTime: {
                    required: '*',
                    number: true
                },
                LowStockQuantity: {
                    required: '*'
                },
                ShoppingOptionRange: {
                    required: '*'
                },
                EmailFrom: {
                    required: '*'
                },
                EmailTo: {
                    required: '*'
                },
                DefaultTitle: {
                    required: '*'
                },
                DefaultMetaDescription: {
                    required: '*'
                },
                DefaultMetaKeyWords: {
                    required: '*'
                },
                MaximumImageSize: {
                    required: '*'
                },
                ItemLargeThumbnailImage: {
                    required: '*'
                },
                ItemMediumThumbnailImage: {
                    required: '*'
                },
                ItemSmallThumbnailImageSize: {
                    required: '*'
                },
                CategoryLargeThumbnailImageSize: {
                    required: '*'
                },
                CategoryMediumThumbnailImageSize: {
                    required: '*'
                },
                CategorySmallThumbnailImageSize: {
                    required: '*'
                },
                DefaultTimeZone: {
                    required: '*'
                },
                MinimumOrderAmount: {
                    required: '*'
                },
                RecentlyViewedCount: {
                    required: '*'
                },
                LatestItemsCount: {
                    required: '*'
                },
                LatestItemsInARow: {
                    required: '*'
                },
                BestSellersCount: {
                    required: '*'
                },
                ItemSpecialCount: {
                    required: '*'
                },
                RecentlyComparedCount: {
                    required: '*'
                },
                RelatedItemsInCartCount: {
                    required: '*'
                },
                NumberOfItemsToCompare: {
                    required: '*'
                },
                NoOfPopTags: {
                    required: '*'
                }
            },
            //success: "valid",
            submitHandler: function() { UpdateStoreSettings(); }
        });
        ImageUploader();

    });

    function HideForLaterUseDivs() {
        $("#storefragment-4").hide();
        $("#divForLaterUseEmail").hide();
        $("#divForLaterUseGS").hide();
        $("#divForLaterUseCPS").hide();
        $("#divForLaterUseOS").hide();
    }

    function InitializeTabs() {
        var $tabs = $('#container-7').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function GetAllStoreSettings() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllStoreSettings",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var value = msg.d;
                if (value != null) {
                    BindAllValue(value);
                }
            },
            error: function() {
                alert("Getting Store Settings Error");
            }
        });
    }

    function GetAllCountry() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCountryList",
            data: "{}",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var countryElements = '';
                $.each(msg.d, function(index, value) {
                    countryElements += '<option value=' + value.Value + '>' + value.Text + '</option>';
                });
                $("#ddlCountry").html(countryElements);
            },
            error: function() {
                alert("country error");
            }
        });
    }

    function GetAllCurrency() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCurrencyList",
            data: JSON2.stringify({ StoreID: storeId, PortalID: portalId, CultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var currencyElements = '';
                $.each(msg.d, function(index, value) {
                    currencyElements += '<option value=' + value.CurrencyCode + '>' + value.CurrencyName + '</option>';
                });
                $("#ddlCurrency").html(currencyElements);
            },
            error: function() {
                alert("currency error");
            }
        });
    }

    function BindAllValue(obj) {
        //Standard Settings
        $("#hdnPrevFilePath").val(obj.DefaultProductImageURL);
        $("#defaultProductImage").html('<img src="' + aspxRootPath + obj.DefaultProductImageURL + '" class="uploadImage" height="90px" width="100px"/>');
        $("#<%= ddlMyAccountURL.ClientID %>").val(obj.MyAccountURL);
        $("#<%= ddlShoppingCartURL.ClientID %>").val(obj.ShoppingCartURL);
        $("#<%= ddlWishListURL.ClientID %>").val(obj.WishListURL);

        //General Settings
        if (obj.SSLSecurePages != null) {
            var sslSecurePages = (obj.SSLSecurePages).split(',');
            for (var i in sslSecurePages)
                $("#<%= lstSSLSecurePages.ClientID %> [value=" + $.trim(sslSecurePages[i]) + "]").attr('selected', "selected");
        }
        $("#ddlCurrency").val(obj.MainCurrency);
        $("#ddlCountry").val(obj.DefaultCountry);
        $("#txtWeightUnit").val(obj.WeightUnit);
        $("#txtStoreName").val(obj.StoreName);
        $("#chkStoreClosed").attr("checked", $.parseJSON(obj.StoreClosed.toLowerCase()));
        $("#txtStoreCloseInformation").val(obj.StoreClosePageContent);
        $("#txtStoreNotAccessedInfo").val(obj.StoreNOTAccessPageContent);
        $("#txtCartAbandonTime").val(obj.CartAbandonedTime);
        $("#txtTimeToDeleteAbandCart").val(obj.TimeToDeleteAbandonedCart);
        $("#txtGoogleMapAPIKey").val(obj.GoogleMapAPIKey);
        $("#txtLowStockQuantity").val(obj.LowStockQuantity);
        $("#txtShoppingOptionRange").val(obj.ShoppingOptionRange);
        $("#chkAllowAnonymousCheckout").attr("checked", $.parseJSON(obj.AllowAnonymousCheckOut.toLowerCase()));
        $("#chkAllowMultipleShippingAddress").attr("checked", $.parseJSON(obj.AllowMultipleShippingAddress.toLowerCase()));
        $("#chkAllowOutStockPurchase").attr("checked", $.parseJSON(obj.AllowOutStockPurchase.toLowerCase()));

        //Email Settings
        $("#txtSendEmailsFrom").val(obj.SendEcommerceEmailsFrom);
        $("#txtSendEmailsTo").val(obj.SendEcommerceEmailTo);
        $("#chkSendOrderNotification").attr("checked", $.parseJSON(obj.SendOrderNotification.toLowerCase()));
        $("#chkSendPaymentNotification").attr("checked", $.parseJSON(obj.SendPaymentNotification.toLowerCase()));
        $("#chkStoreAdminEmail").attr("checked", $.parseJSON(obj.StoreAdminEmail.toLowerCase()));

        //SEO/Display Settings
        $("#chkEnableStoreNamePrefix").attr("checked", $.parseJSON(obj.EnableStoreNamePrefix.toLowerCase()));
        $("#txtDefaultTitle").val(obj.DefaultTitle);
        $("#txtDefaultMetaDescription").val(obj.DefaultMetaDescription);
        $("#txtDefaultMetaKeywords").val(obj.DefaultMetaKeyWords);
        $("#chkWelcomeMsg").attr("checked", $.parseJSON(obj.ShowWelcomeMessageOnHomePage.toLowerCase()));
        $("#chkNewsRssFeed").attr("checked", $.parseJSON(obj.DisplayNewsRSSFeedLinkInBrowserAddressBar.toLowerCase()));
        $("#chkBlogRssFeed").attr("checked", $.parseJSON(obj.DisplayBlogRSSFeedLinkInBrowserAddressBar.toLowerCase()));

        //Media Settings
        $("#txtMaximumImageSize").val(obj.MaximumImageSize);
        $("#txtItemLargeThumbnailImageSize").val(obj.ItemLargeThumbnailImageSize);
        $("#txtItemMediumThumbnailImageSize").val(obj.ItemMediumThumbnailImageSize);
        $("#txtItemSmallThumbnailImageSize").val(obj.ItemSmallThumbnailImageSize);
        $("#txtCategoryLargeThumbnailImageSize").val(obj.CategoryLargeThumbnailImageSize);
        $("#txtCategoryMediumThumbnailImageSize").val(obj.CategoryMediumThumbnailImageSize);
        $("#txtCategorySmallThumbnailImageSize").val(obj.CategorySmallThumbnailImageSize);
        $("#chkShowItemImagesInCart").attr("checked", $.parseJSON(obj.ShowItemImagesInCart.toLowerCase()));
        $("#chkShowItemImagesInWishList").attr("checked", $.parseJSON(obj.ShowItemImagesInWishList.toLowerCase()));

        //Customer Profiles Settings
        $("#chkAllowMultipleAddress").attr("checked", $.parseJSON(obj.AllowUsersToCreateMultipleAddress.toLowerCase()));
        $("#chkAllowCreditCardData").attr("checked", $.parseJSON(obj.AllowUsersToStoreCreditCardDataInProfile.toLowerCase()));
        $("#txtMinimumOrderAmount").val(obj.MinimumOrderAmount);
        $("#txtMinimumQuantity").val(obj.MinimumItemQuantity);
        $("#txtMaximumItemQuantity").val(obj.MaximumItemQuantity);
        $("#chkAllowForUserGroup").attr("checked", $.parseJSON(obj.AllowCustomerToSignUpForUserGroup.toLowerCase()));
        $("#chkAllowRePayOrder").attr("checked", $.parseJSON(obj.AllowCustomersToPayOrderAgainIfTransactionWasDeclined.toLowerCase()));
        $("#chkAllowPrivateMsg").attr("checked", $.parseJSON(obj.AllowPrivateMessages.toLowerCase()));
        $("#<%= ddlDftStoreTimeZone.ClientID %>").val(obj.DefaultStoreTimeZone);

        //Other Settings
        $("#chkEnableCompareItems").attr("checked", $.parseJSON(obj.EnableCompareItems.toLowerCase()));
        $("#txtNoOfItemsToCompare").val(obj.MaxNoOfItemsToCompare);
        $("#chkEnableWishList").attr("checked", $.parseJSON(obj.EnableWishList.toLowerCase()));
        $("#chkEmailAFriend").attr("checked", $.parseJSON(obj.EnableEmailAFriend.toLowerCase()));
        $("#chkShowMiniShoppingCart").attr("checked", $.parseJSON(obj.ShowMiniShoppingCart.toLowerCase()));
        $("#chkNotifyAboutItemReviews").attr("checked", $.parseJSON(obj.NotifyAboutNewItemReviews.toLowerCase()));
        $("#chkItemReviewsApproved").attr("checked", $.parseJSON(obj.ItemReviewMustBeApproved.toLowerCase()));
        $("#chkAllowAnonymousUserToWriteReviews").attr("checked", $.parseJSON(obj.AllowAnonymousUserToWriteItemRatingAndReviews.toLowerCase()));
        $("#chkEnableRecentlyViewedItems").attr("checked", $.parseJSON(obj.EnableRecentlyViewedItems.toLowerCase()));
        $("#txtNoOfRecentlyViewedItems").val(obj.NoOfRecentlyViewedItemsDispay);
        $("#chkEnableLatestItems").attr("checked", $.parseJSON(obj.EnableLatestItems.toLowerCase()));
        $("#txtNoOfLatestItems").val(obj.NoOfLatestItemsDisplay);
        $("#txtNoOfLatestItemsInARow").val(obj.NoOfLatestItemsInARow);
        $("#chkShowBestSellers").attr("checked", $.parseJSON(obj.EnableBestSellerItems.toLowerCase()));
        $("#txtNoOfBestSellers").val(obj.NoOfBestSellersItemDisplay);
        $("#chkEnableSpecialItems").attr("checked", $.parseJSON(obj.EnableSpecialItems.toLowerCase()));
        $("#txtNoOfSpecialItems").val(obj.NoOfSpecialItemDisplay);
        $("#chkEnableRecentlyComparedItems").attr("checked", $.parseJSON(obj.EnableRecentlyComparedItems.toLowerCase()));
        $("#txtNoOfRecentlyComparedItems").val(obj.NoOfRecentlyComparedItems);
        $("#chkRelatedItemsInCart").attr("checked", $.parseJSON(obj.EnableRelatedCartItems.toLowerCase()));
        $("#txtNoOfRelatedItemsInCart").val(obj.NoOfRelatedCartItems);
        $("#txtNoOfPopTags").val(obj.NoOfPopularTags);

    }

    function UpdateStoreSettings() {
        //Standard Settings
        var defaultImageProductURL = $("#defaultProductImage>img").attr("src").replace(aspxRootPath, "");
        var prevFilePath = $("#hdnPrevFilePath").val();
        var myAccountURL = $("#<%= ddlMyAccountURL.ClientID %>").val();
        var shoppingCartURL = $("#<%= ddlShoppingCartURL.ClientID %>").val();
        var myWishListURL = $("#<%= ddlWishListURL.ClientID %>").val();

        //General Settings
        var sslSecurePages = "";
        $("#<%= lstSSLSecurePages.ClientID %> option:selected").each(function() {
            sslSecurePages += $(this).val() + ",";
        });
        var currency = $("#ddlCurrency option:selected").val();
        var country = $("#ddlCountry option:selected").val();
        var weightUnit = $("#txtWeightUnit").val();
        var storeName = $("#txtStoreName").val();
        var storeClosePageContent = $("#txtStoreCloseInformation").val();
        var storeClosed = $("#chkStoreClosed").attr("checked");
        var storeNOTAccessPageContent = $("#txtStoreNotAccessedInfo").val();
        var cartAbandonedTime = $("#txtCartAbandonTime").val();
        var timeToDeleteAbandonedCart = $("#txtTimeToDeleteAbandCart").val();
        var googleMapAPI = $("#txtGoogleMapAPIKey").val();
        var lowStockQuantity = $("#txtLowStockQuantity").val();
        var shoppingOptionRange = $("#txtShoppingOptionRange").val();
        var allowAnonymousCheckout = $("#chkAllowAnonymousCheckout").attr("checked");
        var allowMultipleShippingAddress = $("#chkAllowMultipleShippingAddress").attr("checked");
        var allowOutStockPurchase = $("#chkAllowOutStockPurchase").attr("checked");

        //Email Settings
        var emailFrom = $("#txtSendEmailsFrom").val();
        var emailTo = $("#txtSendEmailsTo").val();
        var SendOrderNotification = $("#chkSendOrderNotification").attr("checked");
        var sendPaymentNotification = $("#chkSendPaymentNotification").attr("checked");
        var storeAdminEmail = $("#chkStoreAdminEmail").attr("checked");

        //SEO/Display Settings
        var enableStoreNamePrefix = $("#chkEnableStoreNamePrefix").attr("checked");
        var defaultTitle = $("#txtDefaultTitle").val();
        var defaultMetaDescription = $("#txtDefaultMetaDescription").val();
        var defaultMetaKeywords = $("#txtDefaultMetaKeywords").val();
        var showWelcomeMsg = $("#chkWelcomeMsg").attr("checked");
        var showNewsRssFeed = $("#chkNewsRssFeed").attr("checked");
        var showBlogRssFeed = $("#chkBlogRssFeed").attr("checked");

        //Media Settings
        var maximumImageSize = $("#txtMaximumImageSize").val();
        var ItemLargeThumbnailImageSize = $("#txtItemLargeThumbnailImageSize").val();
        var ItemMediumThumbnailImageSize = $("#txtItemMediumThumbnailImageSize").val();
        var ItemSmallThumbnailImageSize = $("#txtItemSmallThumbnailImageSize").val();
        var CategoryLargeThumbnailImageSize = $("#txtCategoryLargeThumbnailImageSize").val();
        var CategoryMediumThumbnailImageSize = $("#txtCategoryMediumThumbnailImageSize").val();
        var CategorySmallThumbnailImageSize = $("#txtCategorySmallThumbnailImageSize").val();
        var showItemImagesInCart = $("#chkShowItemImagesInCart").attr("checked");
        var showItemImagesInWishList = $("#chkShowItemImagesInWishList").attr("checked");

        //Customer Profiles Settings
        var allowMultipleAddress = $("#chkAllowMultipleAddress").attr("checked");
        var allowSavingCreditCartData = $("#chkAllowCreditCardData").attr("checked");
        var minimumOrderAmount = $("#txtMinimumOrderAmount").val();
        var minimumItemQuantity = $("#txtMinimumQuantity").val();
        var maximumItemQuantity = $("#txtMaximumItemQuantity").val();
        var AllowForUserGroup = $("#chkAllowForUserGroup").attr("checked");
        var AllowRePayOrder = $("#chkAllowRePayOrder").attr("checked");
        var allowPrivateMessages = $("#chkAllowPrivateMsg").attr("checked");
        var defaultStoreTimeZone = $("#<%= ddlDftStoreTimeZone.ClientID %>").val();


        //Other Settings
        var enableCompareItems = $("#chkEnableCompareItems").attr("checked");
        var maxNoOfItemsToCompare = $("#txtNoOfItemsToCompare").val();
        var enableWishList = $("#chkEnableWishList").attr("checked");
        var enableEmailAFriend = $("#chkEmailAFriend").attr("checked");
        var showMiniShoppingCart = $("#chkShowMiniShoppingCart").attr("checked");
        var notifyItemReviews = $("#chkNotifyAboutItemReviews").attr("checked");
        var itemReviewsApproved = $("#chkItemReviewsApproved").attr("checked");
        var allowAnonymousUserToWriteReviews = $("#chkAllowAnonymousUserToWriteReviews").attr("checked");
        var enableRecentlyViewedItems = $("#chkEnableRecentlyViewedItems").attr("checked");
        var noOfRecentlyViewedItems = $("#txtNoOfRecentlyViewedItems").val();
        var enableLatestItems = $("#chkEnableLatestItems").attr("checked");
        var noOfLatestItems = $("#txtNoOfLatestItems").val();
        var noOfLatestItemsInARow = $("#txtNoOfLatestItemsInARow").val();
        var showBestSellers = $("#chkShowBestSellers").attr("checked");
        var noOfBestSellers = $("#txtNoOfBestSellers").val();
        var enableSpecial = $("#chkEnableSpecialItems").attr("checked");
        var noOfSpecialItems = $("#txtNoOfSpecialItems").val();
        var enableRecentlyComparedItems = $("#chkEnableRecentlyComparedItems").attr("checked");
        var noOfRecentlyComparedItems = $("#txtNoOfRecentlyComparedItems").val();
        var enableRelatedCartItems = $("#chkRelatedItemsInCart").attr("checked");
        var noOfRelatedCartItems = $("#txtNoOfRelatedItemsInCart").val();
        var noOfPopTags = $("#txtNoOfPopTags").val();


        var settingValues = '';
        settingValues += myAccountURL + '*' + shoppingCartURL + '*' + myWishListURL + '*';
        settingValues += currency + '*' + country + '*' + weightUnit + '*' + storeName + '*' + storeClosePageContent + '*' + storeClosed + '*' + storeNOTAccessPageContent + '*' + cartAbandonedTime + '*' + timeToDeleteAbandonedCart + '*' + googleMapAPI + '*' + lowStockQuantity + '*' + shoppingOptionRange + '*' + allowAnonymousCheckout + '*' + allowMultipleShippingAddress + '*' + sslSecurePages + '*';
        settingValues += emailFrom + '*' + emailTo + '*' + SendOrderNotification + '*' + sendPaymentNotification + '*' + storeAdminEmail + '*';
        settingValues += enableStoreNamePrefix + '*' + defaultTitle + '*' + defaultMetaDescription + '*' + defaultMetaKeywords + '*' + showWelcomeMsg + '*' + showNewsRssFeed + '*' + showBlogRssFeed + '*';
        settingValues += maximumImageSize + '*' + ItemLargeThumbnailImageSize + '*' + ItemMediumThumbnailImageSize + '*' + ItemSmallThumbnailImageSize + '*' + CategoryLargeThumbnailImageSize + '*' + CategoryMediumThumbnailImageSize + '*' + CategorySmallThumbnailImageSize + '*' + showItemImagesInCart + '*' + showItemImagesInWishList + '*';
        settingValues += allowMultipleAddress + '*' + allowSavingCreditCartData + '*' + minimumOrderAmount + '*' + minimumItemQuantity + '*' + maximumItemQuantity + '*' + AllowForUserGroup + '*' + AllowRePayOrder + '*' + allowPrivateMessages + '*' + defaultStoreTimeZone + '*' + allowOutStockPurchase + '*';
        settingValues += enableCompareItems + '*' + maxNoOfItemsToCompare + '*' + enableWishList + '*' + enableEmailAFriend + '*' + showMiniShoppingCart + '*' + notifyItemReviews + '*' + itemReviewsApproved
            + '*' + allowAnonymousUserToWriteReviews + '*' + enableRecentlyViewedItems + '*' + noOfRecentlyViewedItems + '*' + enableLatestItems + '*' + noOfLatestItems + '*' + noOfLatestItemsInARow + '*' + showBestSellers
                + '*' + noOfBestSellers + '*' + enableSpecial + '*' + noOfSpecialItems + '*' + enableRecentlyComparedItems + '*' + noOfRecentlyComparedItems + '*' + enableRelatedCartItems + '*' + noOfRelatedCartItems + '*' + noOfPopTags;


        var settingKeys = '';
        settingKeys += 'MyAccountURL' + '*' + 'ShoppingCartURL' + '*' + 'WishListURL' + '*';
        settingKeys += 'MainCurrency' + '*' + 'DefaultCountry' + '*' + 'WeightUnit' + '*' + 'StoreName' + '*' + 'StoreClosePageContent' + '*' + 'StoreClosed' + '*' + 'StoreNOTAccessPageContent' + '*' + 'CartAbandonedTime' + '*' + 'TimeToDeleteAbandonedCart' + '*' + 'GoogleMapAPIKey' + '*' + 'LowStockQuantity' + '*' + 'ShoppingOptionRange' + '*' + 'AllowAnonymousCheckOut' + '*' + 'AllowMultipleShippingAddress' + '*' + 'SSLSecurePages' + '*';
        settingKeys += 'SendEcommerceEmailsFrom' + '*' + 'SendEcommerceEmailTo' + '*' + 'SendOrderNotification' + '*' + 'SendPaymentNotification' + '*' + 'StoreAdminEmail' + '*';
        settingKeys += 'EnableStoreNamePrefix' + '*' + 'DefaultTitle' + '*' + 'DefaultMetaDescription' + '*' + 'DefaultMetaKeyWords' + '*' + 'ShowWelcomeMessageOnHomePage' + '*' + 'DisplayNewsRSSFeedLinkInBrowserAddressBar' + '*' + 'DisplayBlogRSSFeedLinkInBrowserAddressBar' + '*';
        settingKeys += 'MaximumImageSize' + '*' + 'ItemLargeThumbnailImageSize' + '*' + 'ItemMediumThumbnailImageSize' + '*' + 'ItemSmallThumbnailImageSize' + '*' + 'CategoryLargeThumbnailImageSize' + '*' + 'CategoryMediumThumbnailImageSize' + '*' + 'CategorySmallThumbnailImageSize' + '*' + 'ShowItemImagesInCart' + '*' + 'ShowItemImagesInWishList' + '*';
        settingKeys += 'AllowUsersToCreateMultipleAddress' + '*' + 'AllowUsersToStoreCreditCardDataInProfile' + '*' + 'MinimumOrderAmount' + '*' + 'MinimumItemQuantity' + '*' + 'MaximumItemQuantity' + '*' + 'AllowCustomerToSignUpForUserGroup' + '*' + 'AllowCustomersToPayOrderAgainIfTransactionWasDeclined' + '*' + 'AllowPrivateMessages' + '*' + 'DefaultStoreTimeZone' + '*' + 'AllowOutStockPurchase' + '*';
        settingKeys += 'Enable.CompareItems' + '*' + 'MaxNoOfItemsToCompare' + '*' + 'Enable.WishList' + '*' + 'Enable.EmailAFriend' + '*' + 'Show.MiniShoppingCart' + '*' + 'NotifyAboutNewItemReviews' + '*' + 'ItemReviewMustBeApproved'
            + '*' + 'AllowAnonymousUserToWriteItemRatingAndReviews' + '*' + 'Enable.RecentlyViewedItems' + '*' + 'NoOfRecentlyViewedItemsDispay' + '*' + 'Enable.LatestItems' + '*' + 'NoOfLatestItemsDisplay' + '*' + 'NoOfLatestItemsInARow' + '*' + 'Enable.BestSellerItems'
                + '*' + 'NoOfBestSellersItemDisplay' + '*' + 'Enable.SpecialItems' + '*' + 'NoOfSpecialItemDisplay' + '*' + 'Enable.RecentlyComparedItems' + '*' + 'NoOfRecentlyComparedItems' + '*' + 'Enable.RelatedCartItems' + '*' + 'NoOfRelatedCartItems' + '*' + 'NoOfPopularTags';


        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateStoreSettings",
            data: JSON2.stringify({ settingKeys: settingKeys, settingValues: settingValues, prevFilePath: prevFilePath, newFilePath: defaultImageProductURL, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function() {
                GetAllStoreSettings();
                alert("success");
            },
            error: function() {
                alert("Setting Update error");
            }
        });
    }

    function ImageUploader() {
        maxFileSize = '<%= maxFileSize %>';
        var upload = new AjaxUpload($('#fupDefaultImageURL'), {
            action: aspxStoreSetModulePath + "MultipleFileUploadHandler.aspx",
            name: 'myfile[]',
            multiple: false,
            data: { },
            autoSubmit: true,
            responseType: 'json',
            onChange: function(file, ext) {
                //alert('changed');
            },
            onSubmit: function(file, ext) {
                if (ext != "exe") {
                    if (ext && /^(jpg|jpeg|jpe|gif|bmp|png|ico)$/i .test(ext)) {
                        this.setData({
                            'MaxFileSize': maxFileSize
                        });
                    } else {
                        csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
                        return false;
                    }
                } else {
                    csscody.alert('<h1>Alert Message</h1><p>Not a valid image!</p>');
                    return false;
                }
            },
            onComplete: function(file, response) {
                var res = eval(response);
                if (res.Message != null && res.Status > 0) {
                    //alert(res.Message);
                    AddNewImages(res);
                    return false;
                } else {
                    csscody.error('<h1>Error Message</h1><p>Can\'t upload the image!</p>');
                    return false;
                }
            }
        });
    }

    function AddNewImages(response) {
        $("#defaultProductImage").html('<img src="' + aspxRootPath + response.Message + '" class="uploadImage" height="90px" width="100px"/>');
    }

</script>

<div id="divStoreSettings">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblHeading" runat="server" Text="Store Settings"></asp:Label>
            </h2>
        </div>
        <div class="cssClassTabPanelTable">
            <div id="container-7">
                <ul>
                    <li><a href="#storefragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="Standard"></asp:Label>
                        </a></li>
                    <li><a href="#storefragment-2">
                            <asp:Label ID="lblTabTitle2" runat="server" Text="General"></asp:Label>
                        </a></li>
                    <li><a href="#storefragment-3">
                            <asp:Label ID="lbTabTitle3" runat="server" Text="Email"></asp:Label>
                        </a></li>
                    <%-- <li><a href="#storefragment-4">
                        <asp:Label ID="lbTabTitle4" runat="server" Text="SEO/Display"></asp:Label>
                    </a></li>--%>
                    <li><a href="#storefragment-5">
                            <asp:Label ID="lbTabTitle5" runat="server" Text="Media"></asp:Label>
                        </a></li>
                    <%-- <li><a href="#storefragment-8">
                        <asp:Label ID="lblTabTitle6" runat="server" Text="Security"></asp:Label>
                    </a></li>--%>
                    <li><a href="#storefragment-6">
                            <asp:Label ID="lbTabTitle7" runat="server" Text="Customer Profiles"></asp:Label>
                        </a></li>
                    <li><a href="#storefragment-7">
                            <asp:Label ID="lbTabTitle8" runat="server" Text="Other"></asp:Label>
                        </a></li>
                </ul>
                <div id="storefragment-1">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab1Info" runat="server" Text="Standard Settings"></asp:Label>
                        </h3>
                        <table border="0" width="100%" id="tblStandardSettingsForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblDefaultImageProductURL" Text="Default Image Product URL:" runat="server"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input id="fupDefaultImageURL" type="file" class="cssClassBrowse" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <div id="defaultProductImage">
                                    </div>
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:Label ID="lblMyAccountURL" runat="server" Text="My Account URL:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlMyAccountURL" runat="server" class="cssClassDropDown" >
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShoppingCartURL" runat="server" Text="Shopping Cart URL:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlShoppingCartURL" class="cssClassDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblWishListURL" runat="server" Text="WishList URL:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlWishListURL" class="cssClassDropDown" runat="server">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="storefragment-2">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTab2Info" runat="server" Text="General Settings"></asp:Label>
                        </h3>
                        <div id="divForLaterUseGS">
                            <table id="tblForLaterUSe">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDefaultCountry" runat="server" Text="Default Country:" CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <select id="ddlCountry" class="cssClassDropDown">
                                        </select>
                                    </td>
                                </tr>
                            
                                <tr>
                                    <td>
                                        <asp:Label ID="lblStoreName" runat="server" Text="Store Name: " CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="text" id="txtStoreName" name="StoreName" class="cssClassNormalTextBox required" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSSLSecurePages" runat="server" Text="SSL Secure Pages:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <asp:ListBox ID="lstSSLSecurePages" runat="server" SelectionMode="Multiple" AutoPostBack="false"></asp:ListBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblGoogleMapAPIKey" runat="server" Text="Google Map API Key For Store Locator:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="text" id="txtGoogleMapAPIKey" name="GoogleMapAPIKey" class="cssClassNormalTextBox required" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table id="tblGeneralSettingForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMainCurrency" runat="server" Text="Main Currency:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <select id="ddlCurrency" class="cssClassDropDown">
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblWeightUnit" runat="server" Text="Weight Unit:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtWeightUnit" name="Weight" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblLowStockQuantity" runat="server" Text="Low Stock Quantity:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtLowStockQuantity" name="LowStockQuantity" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShoppingOptionRange" runat="server" Text="Shopping Option Range:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtShoppingOptionRange" name="ShoppingOptionRange" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStorURL" runat="server" Text="Store Close Information:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <%-- <td>
                                    <textarea id="txtStoreCloseInformation" name="StoreCloseInformation" cols="20" rows="5"></textarea>
                                </td>--%>
                                <%-- <td>
                                    <asp:DropDownList ID="ddlStoreCloseUrl" runat="server" class="cssClassDropDown">
                                    </asp:DropDownList>
                                </td>--%>
                                <td>
                                    <textarea id="txtStoreCloseInformation" name="StoreCloseInformation" cols="20" rows="5" class="cssClassTextArea"></textarea>
                                </td>
                               
                            </tr>  
                            <tr>
                                <td>
                                    <asp:Label ID="lblStoreClosed" runat="server" Text="Store Closed:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkStoreClosed" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblStoreNotAccessed" runat="server" Text="Store Not Accessed Information:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td>
                                    <textarea id="txtStoreNotAccessedInfo" name="StoreNotAccessedInfo" cols="20" rows="5" class="cssClassTextArea"></textarea>
                                </td>                                                         
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCartAbandonTime" Text="Cart Abandon Time(In Hours):" runat="server" CssClass="cssClassFormLabel"></asp:Label>                               
                                </td>
                                <td>
                                    <input type="text" id="txtCartAbandonTime" name="CartAbandonTime"  datatype="Integer" class="cssClassNormalTextBox required number"  >
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTimeToDeleteAbandCart" Text="Abandoned Carts Deletion Time(In Hours):" runat="server" CssClass="cssClassFormLabel"></asp:Label>                               
                                </td>
                                <td>
                                    <input type="text" id="txtTimeToDeleteAbandCart" name="TimeTodeleteAbandCart"  datatype="Integer" class="cssClassNormalTextBox required number">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllowAnonymousCheckOut" Text="Allow Anonymous Checkout:" runat="server"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkAllowAnonymousCheckout" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllowMultipleShippingAddress" runat="server" Text="Allow Multiple Shipping Address:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkAllowMultipleShippingAddress" readonly="readonly" disabled="disabled"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllowOutStockPurchase" runat="server" Text="Allow purchases when out of stock:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkAllowOutStockPurchase" readonly="readonly" disabled="disabled" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
               
                <div id="storefragment-3">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblEmailSettingForm" runat="server" Text="Email Settings"></asp:Label>
                        </h3>
                        <div id="divForLaterUseEmail">
                            <table id="tblForLaterUseEmail">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSendEmailsTo" runat="server" Text="Send E-Commerce Emails To:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="text" id="txtSendEmailsTo" name="EmailTo" class="cssClassNormalTextBox required" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblSendPaymentNotification" runat="server" Text="Send Payment Notification:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkSendPaymentNotification" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblStoreAdminEmail" runat="server" Text="Store Admin Email:" CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkStoreAdminEmail" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table id="tblEmailSettingForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSendEmailsFrom" runat="server" Text="Send E-Commerce Emails From:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtSendEmailsFrom" name="EmailFrom" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                           
                            <tr>
                                <td>
                                    <asp:Label ID="lblSendOrderNotification" runat="server" Text="Send Order Notification:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkSendOrderNotification" />
                                </td>
                            </tr>
                           
                        </table>
                    </div>
                </div>
                <div id="storefragment-4" >
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblSEODisplay" runat="server" Text="SEO/Display Settings"></asp:Label>
                        </h3>
                        <table id="tblSEODisplayForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableStoreNamePrefix" runat="server" Text="Enable Store Name Prefix:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableStoreNamePrefix" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDefaultTitle" runat="server" Text="Default Title:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtDefaultTitle" name="DefaultTitle" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDefaultMetaDescription" runat="server" Text="Default Meta Description:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtDefaultMetaDescription" name="DefaultMetaDescription" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblDefaultMetaKeywords" runat="server" Text="Default Meta KeyWords:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtDefaultMetaKeywords" name="DefaultMetaKeyWords" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblWelcomMsg" runat="server" Text="Show Welcome Message On Home Page"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkWelcomeMsg" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNewsRssFeed" runat="server" Text="Show News RSS Feed Link in Browser AddressBar:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkNewsRssFeed" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblBlogsRssFeed" runat="server" Text="Show Blog RSS Feed Link in Browser AddressBar:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkBlogRssFeed" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div id="storefragment-5">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblMediaSetting" runat="server" Text="Media Settings"></asp:Label>
                        </h3>
                        <table id="tblMediaSettingForm">
                            <tr>
                                <td>
                                    <asp:Label ID="lblMaximumImageSize" Text="Maximum Image Size:" runat="server" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtMaximumImageSize" datatype="Integer" name="MaximumImageSize"
                                           class="cssClassNormalTextBox required" /> <b>KB</b>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblItemLargeThumbImageSize" Text="Item Large Thumbnail Image Size:" runat="server"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtItemLargeThumbnailImageSize" name="ItemLargeThumbnailImage" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblItemMediumThumbnailImageSize" Text="Item Medium Thumbnail Image Size:" runat="server"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtItemMediumThumbnailImageSize" name="ItemMediumThumbnailImage" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblItemSmallThumbnailImageSize" runat="server" Text="Item Small Thumbnail Image Size:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtItemSmallThumbnailImageSize" name="ItemSmallThumbnailImageSize"
                                           datatype="Integer" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCategoryLargeThumbnailImageSize" runat="server" Text="Category Large Thumbnail Image Size:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtCategoryLargeThumbnailImageSize" name="CategoryLargeThumbnailImageSize"
                                           datatype="Integer" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCategoryMediumThumbnailImageSize" runat="server" Text="Category Medium Thumbnail Image Size:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtCategoryMediumThumbnailImageSize" name="CategoryMediumThumbnailImageSize"
                                           datatype="Integer" class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCategorySmallThumbnailImageSize" runat="server" Text="Category Small Thumbnail Image Size:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtCategorySmallThumbnailImageSize" name="CategorySmallThumbnailImageSize" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShowItemImagesInCart" runat="server" Text="Show Item Images in Cart:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkShowItemImagesInCart" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShowItemImagesInWishList" runat="server" Text="Show Item Images in WishList:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkShowItemImagesInWishList" />
                                </td>
                            </tr>
                        </table>
                    </div> 
                </div>
                <div id="storefragment-6">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblTitleCustomerProfiles" runat="server" Text="Customer Profiles Settings"></asp:Label>
                        </h3>
                        <div id="divForLaterUseCPS">
                            <table id="tblForLaterUseCPS">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAllowCreditCardData" runat="server" Text="Allow Users to store CreditCard Data in Profile:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkAllowCreditCardData" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAllowUserGroup" runat="server" Text="Allow Customers to Sign User groups:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkAllowForUserGroup" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAllowRePayOrder" runat="server" Text="Allow Customers to pay order again if the transaction was declined:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkAllowRePayOrder" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblAllowPrivateMessages" runat="server" Text="Allow Private Messages:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkAllowPrivateMsg" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblDefaultStoreTimeZone" runat="server" Text="Default Store Time Zone:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlDftStoreTimeZone" class="cssClassDropDown" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMinimumItemQuantity" runat="server" Text="Minimum Quantity To Be Purchased:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="text" id="txtMinimumQuantity" name="MinimumItemQuantity" datatype="Integer"
                                               class="cssClassNormalTextBox required" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMaximumItemQuantity" runat="server" Text="Maximum Purchased Quantity:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="text" id="txtMaximumItemQuantity" name="MaximumItemQuantity" datatype="Integer"
                                               class="cssClassNormalTextBox required" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table id="tblCustomerProfilesSettings">
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllowMultipleAddress" runat="server" Text="Allow Users To Create Multiple Address:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkAllowMultipleAddress" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:Label ID="lblMinimumOrder" runat="server" Text="Minimum Order Amount:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtMinimumOrderAmount" name="MinimumOrderAmount" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>                            
                        </table>
                    </div>
                </div>
                <div id="storefragment-7">
                    <div class="cssClassFormWrapper">
                        <h3>
                            <asp:Label ID="lblOtherSettings" runat="server" Text="Other Settings"></asp:Label>
                        </h3>
                        <div id="divForLaterUseOS">
                            <table id="tblForLaterUseOS">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblNotifyAboutItemReviews" runat="server" Text="Notify About Item Reviews:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkNotifyAboutItemReviews" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblItemReviewsApproved" runat="server" Text="Item Review Must be Approved:"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                                    </td>
                                    <td class="cssClassGridRightCol">
                                        <input type="checkbox" id="chkItemReviewsApproved" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <table id="tblOtherSettings">
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableCompareItems" runat="server" Text="Enable 'Compare Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableCompareItems" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfItemsCompare" runat="server" Text="Maximum Number Of Items Allowed To Compare:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfItemsToCompare" name="NumberOfItemsToCompare"
                                           datatype="Integer" class="cssClassNormalTextBox required" readonly="readonly" disabled="disabled"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableWishList" runat="server" Text="Enable 'WishList':" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableWishList" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableEmailAFriend" runat="server" Text="Enable 'Refer-A-Friend':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEmailAFriend" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShowMiniShoppingCart" runat="server" Text="Show 'Mini Shopping Cart':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkShowMiniShoppingCart" />
                                </td>
                            </tr>
                            
                            <tr>
                                <td>
                                    <asp:Label ID="lblAllowAnonymousUserToWriteReviews" runat="server" CssClass="cssClassFormLabel"
                                               Text="Allow AnonymousUser to Write Reviews and Ratings:"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkAllowAnonymousUserToWriteReviews" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableRecentlyViewedItems" runat="server" Text="Enable 'Recently Viewed Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableRecentlyViewedItems" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfRecentlyViewedItems" runat="server" Text="No Of Recently Viewed Items:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfRecentlyViewedItems" name="RecentlyViewedCount" datatype="Integer"
                                           class="cssClassNormalTextBox required" readonly="readonly" disabled="disabled" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableLatestItems" runat="server" Text="Enable 'Latest Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableLatestItems" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfLatestItems" runat="server" Text="No Of Latest Items:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfLatestItems" name="LatestItemsCount" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfLatestItemsInARow" runat="server" Text="No Of Latest Items In A Row:" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfLatestItemsInARow" name="LatestItemsInARow" datatype="Integer"
                                           class="cssClassNormalTextBox required" readonly="readonly" disabled="disabled"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShowBestSellers" runat="server" Text="Enable 'BestSeller Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkShowBestSellers" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfBestSellers" runat="server" Text="No Of BestSeller Items:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfBestSellers" name="BestSellersCount" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableSpecialItems" runat="server" Text="Enable 'Special Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableSpecialItems" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfSpecialItems" runat="server" Text="No Of Special Items:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfSpecialItems" name="ItemSpecialCount" datatype="Integer"
                                           class="cssClassNormalTextBox required" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEnableRecentlyComparedItems" runat="server" Text="Enable 'Recently Compared Items':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkEnableRecentlyComparedItems" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfRecentlyComparedItems" runat="server" Text="No Of Recently Compared Items:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfRecentlyComparedItems" name="RecentlyComparedCount"
                                           datatype="Integer" class="cssClassNormalTextBox required" readonly="readonly" disabled="disabled" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblRelatedItemsInCart" runat="server" Text="Enable 'Related Items In Cart':"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="checkbox" id="chkRelatedItemsInCart" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfRelatedItemsInCart" runat="server" Text="No Of Related Items In Cart:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfRelatedItemsInCart" name="RelatedItemsInCartCount"
                                           datatype="Integer" class="cssClassNormalTextBox required" readonly="readonly" disabled="disabled"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblNoOfPopTags" runat="server" Text="No Of Popular Tags:"
                                               CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td class="cssClassGridRightCol">
                                    <input type="text" id="txtNoOfPopTags" name="NoOfPopTags"
                                           datatype="Integer" class="cssClassNormalTextBox required"  readonly="readonly" disabled="disabled"/>
                                </td>
                            </tr>
                             
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="submit" id="btnSaveStoreSettings" class="cssClassButtonSubmit">
                    <span><span>Save Settings</span></span></button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnPrevFilePath" />