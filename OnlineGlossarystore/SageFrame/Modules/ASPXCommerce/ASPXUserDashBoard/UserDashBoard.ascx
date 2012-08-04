<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserDashBoard.ascx.cs"
            Inherits="Modules_ASPXUserDashBoard_UserDashBoard" %>
    
<script type="text/javascript" language="javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    //AccountDashboard     
    var userEmail = '<%= userEmail %>';
    var sessionCode = '<%= sessionCode %>';
    var customerId = '<%= customerID %>';
    //AccountInformation    
    var userFirstName = '<%= userFirstName %>';
    var userLastName = '<%= userLastName %>';
    //AccountPassword
    //all are common
    //AddressBook
    var allowMultipleAddress = '<%= allowMultipleAddress %>'
    //MyOrder all common
    //My Tags all common
    //Referred friend all common
    //shareWish list all common
    //user Download
    var downloadIP = '<%= userIP %>';
    var aspxfilePath = '<%= aspxfilePath %>';
    //user item review
    var userIP = '<%= userIP %>';
    var ReviewID = '';
    var status = '';
    var ratingValues = '';
    var countryName = '<%= countryName %>';
    //user product review all common
    // user recent history all common
    // wishItem list 
    var count = 1;
    var isAll = 1;
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var allowWishListMyAccount = '<%= allowWishListMyAccount %>';

    $(document).ready(function() {
        if (allowWishListMyAccount.toLowerCase() != 'true') {
            $('.cssClassMyDashBoard li').each(function(index) {
                if ($(this).find('a').attr('name') == 'MyWishList') {
                    $(this).hide();
                }
                if ($(this).find('a').attr('name') == 'SharedWishList') {
                    $(this).hide();
                }
            });
        }
        if (customerId > 0 && userName.toLowerCase() != 'anonymoususer') {
            $(document).ajaxStart(function() {
                $('#divAjaxLoader').show();
            });

            $(document).ajaxStop(function() {
                $('#divAjaxLoader').hide();
            });
            //        if (customerId == 0 && userName.toLowerCase() == 'anonymoususer') {
            //            Login();
            //            return false;
            //        }
            LoadAjaxUserDashBoardStaticImage();
            LoadControl("Modules/ASPXCommerce/ASPXUserDashBoard/AccountDashboard.ascx");
            $("#spanName").html(' (' + userName + ')');
            $("ul.cssClassMyDashBoard li a").bind("click", function() {
                $("ul.cssClassMyDashBoard li a").removeClass("cssClassmyAccountActive");
                $(this).addClass("cssClassmyAccountActive");

                var linkId = $(this).attr("name");
                var ControlName = '';
                switch (linkId) {
                case 'AccountDashBoard':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/AccountDashboard.ascx";
                    break;
                case 'AccountInformation':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/AccountInformation.ascx";
                    break;
                case 'AccountPassword':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/AccountPassword.ascx";
                    break;
                case 'AddressBook':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/AddressBook.ascx";
                    break;
                case 'MyOrders':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/MyOrders.ascx";
                    break;
                //                case 'BillingAgreements':               
                //                    break;               
                //                case 'RecurringProfiles':               
                //                    break;               
                case 'MyItemReviews':
                        //ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/UserProductReviews.ascx";
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/UserItemReviews.ascx";
                    break;
                case 'MyTags':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/MyTags.ascx";
                    break;
                case 'MyWishList':
                    ControlName = "Modules/ASPXCommerce/ASPXWishList/WishItemList.ascx";
                    break;
                case 'SharedWishList':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashboard/ShareWishListItems.ascx";
                    break;
                case 'MyDownloadableItems':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/UserDownloadableProducts.ascx";
                    break;
                //                case 'NewsLetterSubscriptions':               
                //                    break;               
                case 'ReferredFriends':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashBoard/ReferredFriends.ascx";
                    break;
                //                case 'StoreCredit':               
                //                    break;               
                //                case 'GiftCard':               
                //                    break;               
                //                case 'RewardPoints':               
                //                    break;               
                case 'RecentHistory':
                    ControlName = "Modules/ASPXCommerce/ASPXUserDashboard/UserRecentHistory.ascx";
                    break;
                }
                LoadControl(ControlName);
            });
        } else {
            var loginPage = '';
            if (userFriendlyURL) {
                loginPage = 'Login.aspx';
            } else {
                loginPage = 'Login';
            }
            window.location = aspxRedirectPath + loginPage;
        }
    });

    function LoadAjaxUserDashBoardStaticImage() {
        $('#ajaxUserDashbaoardImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function LoadControl(controlName) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "LoadControlHandler.aspx/Result",
            data: "{ controlName:'" + aspxRootPath + controlName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                $('#divLoadUserControl').html(response.d);
            },
            error: function() {
                alert("Error!");
            }
        });
    }

</script>

<div class="cssClassMyDashBoard">
    <div class="cssClassCommonSideBox">
        <h2>
            <span>My Account</span>
        </h2>
        <div class="cssClasMyAccount">
            <ul class="cssClassMyDashBoard">
                <li><a href="#" name="AccountDashBoard" class="cssClassmyAccountActive">Account Dashboard</a></li>
                <li><a href="#" name="AccountInformation">Account Information</a></li>
                <li><a href="#" name="AccountPassword">Change Password</a></li>
                <li><a href="#" name="AddressBook">Address Book</a></li>
                <li><a href="#" name="MyOrders">My Orders</a></li>
                <%--<li><a href="#" name="BillingAgreements">Billing Agreements</a></li>
                <li><a href="#" name="RecurringProfiles">Recurring Profiles</a></li>--%>
                <li><a href="#" name="MyItemReviews">My Item Reviews</a></li>
                <li><a href="#" name="MyTags">My Tags</a></li>
                <li><a href="#" name="MyWishList">My Wishlist</a></li>
                <li><a href="#" name="SharedWishList">Shared Wishlist</a></li>
                <li><a href="#" name="MyDownloadableItems">My Digital Items</a></li>
                <%--<li><a href="#" name="NewsLetterSubscriptions">Newsletter Subscriptions</a></li>--%>
                <li><a href="#" name="ReferredFriends">Referred Friends</a></li>
                <%--<li><a href="#" name="StoreCredit">Store Credit</a></li>
                <li><a href="#" name="GiftCard">Gift Card</a></li>
                <li><a href="#" name="RewardPoints">Reward Points</a></li>--%>
                <li><a href="#" name="RecentHistory">Recent History</a></li>
            </ul>
        </div>
    </div>
    <div id="divAjaxLoader">
        <img id="ajaxUserDashbaoardImage"  alt="loading...." />
    </div>  
    <div id="divLoadUserControl" class="cssClasMyAccountInformation">
   
        <div class="cssClassMyDashBoardInformation">
            <p>
                Hello,<span id="spanName"></span> From your My Account Dashboard you
                have the ability to view a snapshot of your recent account activity and update your
                account information. Select a link below to view or edit information.
            </p>
        </div>
    </div>
    <div class="cssClassclear">
    </div>
    
</div>