<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ASPXHeaderControl.ascx.cs"
            Inherits="Modules_ASPXHeaderControl_ASPXHeaderControl" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var sessionCode = '<%= sessionCode %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var myAccountURL = '<%= myAccountURL %>';
    var shoppingCartURL = '<%= shoppingCartURL %>';
    var wishListURL = '<%= wishListURL %>';

    $(document).ready(function() {
        GetCartItemTotalCount();
        if ('<%= allowWishList %>'.toLowerCase() == 'true') {
            GetWishListCount();
        } else {
            $('.cssClassWishList').hide();
        }
        if (customerId > 0 && userName.toLowerCase() != 'anonymoususer') {
            if (userFriendlyURL) {
                $("#lnkMyAccount").attr("href", '' + aspxRedirectPath + myAccountURL + '.aspx');
            } else {
                $("#lnkMyAccount").attr("href", '' + aspxRedirectPath + myAccountURL);
            }
        } else {
            if (userFriendlyURL) {
                $("#lnkMyAccount").attr("href", '' + aspxRedirectPath + 'Login.aspx');
            } else {
                $("#lnkMyAccount").attr("href", '' + aspxRedirectPath + 'Login');
            }
        }
        $("#lnkCheckOut , .cssClassBlueBtn ").click(function() {

            if ($(".cssClassBlueBtn ").length > 0) {
                if ($("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "") < 0) {
                    csscody.alert("<h2>Information Alert</h2><p>You can't proceed to checkout your amount is not applicable!</p>");
                    return false;
                }
            }


            var totalCartItemPrice = GetTotalCartItemPrice();
            //alert(totalCartItemPrice);
            if (totalCartItemPrice == 0) {
                csscody.alert('<h2>Information Alert</h2><p>You have not added any items in cart yet!</p>');
                return false;
            }
            if (totalCartItemPrice < '<%= minOrderAmount %>') {
                csscody.alert('<h2>Information Alert</h2><p>You are not eligible to proceed further:Your order amount is too low!</p>');
            } else {

                var singleAddressLink = '';
                var multipleAddressLink = '';
                if (userFriendlyURL) {
                    singleAddressLink = 'Single-Address-Checkout.aspx';
                    multipleAddressLink = 'Multiple-Address-Checkout.aspx';
                } else {
                    singleAddressLink = 'Single-Address-Checkout';
                    multipleAddressLink = 'Multiple-Address-Checkout';
                }

                var newMultiShippingDiv = '';
                newMultiShippingDiv = '<a href="' + aspxRedirectPath + singleAddressLink + '">Checkout With Single Address</a>';
                if (customerId > 0 && userName.toLowerCase() != 'anonymoususer') {
                    if ('<%= allowMultipleShipping %>'.toLowerCase() == 'true') {
                        newMultiShippingDiv += '<span class="cssClassOR">OR</span><a href="' + aspxRedirectPath + multipleAddressLink + '">Checkout With Multiple Addresses</a>';
                    }
                } else {
                    if ('<%= allowAnonymousCheckOut %>'.toLowerCase() == 'true') {
                        newMultiShippingDiv = '<a href="' + aspxRedirectPath + singleAddressLink + '">Checkout With Single Address</a>';
                    } else {
                        csscody.alert('<h2>Information Alert</h2><p>Checkout is not allowed for anonymous user!</p>');
                        return false;
                    }
                }
                if ('<%= allowMultipleShipping %>'.toLowerCase() == 'false' && '<%= allowAnonymousCheckOut %>'.toLowerCase() == 'true') {
                    window.location = aspxRedirectPath + singleAddressLink;
                } else {

                    if (customerId == 0) {
                        window.location = aspxRedirectPath + singleAddressLink;
                    } else {
                        $("#divCheckoutTypes").html(newMultiShippingDiv);
                        ShowPopupControl('popuprel3');
                    }
                }

            }

        });
        $(".cssClassClose").click(function() {
            $('#fade, #popuprel3').fadeOut();
        });
    });

    function GetWishListCount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, sessionCode: sessionCode, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CountWishItems",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#lnkMyWishlist").html("My Wishlist <span class=\"cssClassTotalCount\">[" + msg.d + "]</span>");
                var myWishlistLink = '';
                var loginLink = '';
                if (userFriendlyURL) {
                    myWishlistLink = 'My-Wishlist.aspx';
                    loginLink = 'Login.aspx';
                } else {
                    myWishlistLink = 'My-Wishlist';
                    loginLink = 'Login';
                }
                if (customerId > 0 && userName.toLowerCase() != 'anonymoususer') {
                    $("#lnkMyWishlist").attr("href", '' + aspxRedirectPath + myWishlistLink + '');
                } else {
                    $("#lnkMyWishlist").attr("href", '' + aspxRedirectPath + loginLink + '');
                }
            }
        });
    }

    function GetCartItemTotalCount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartItemsCount",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#lnkMyCart").html("My Cart <span class=\"cssClassTotalCount\">[" + msg.d + "]</span>");
                var myCartLink = '';
                if (userFriendlyURL) {
                    myCartLink = shoppingCartURL + '.aspx';
                } else {
                    myCartLink = shoppingCartURL;
                }
                $("#lnkMyCart").attr("href", '' + aspxRedirectPath + myCartLink + '');
            }
        });
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

<div class="cssClassLoginStatusWrapper">
    <div class="cssClassLoginStatusInfo">
        <ul>
            <li class="cssClassAccount"><a id="lnkMyAccount">My Account</a></li>
            <li class="cssClassWishList"><a id="lnkMyWishlist"></a></li>
            <li class="cssClassCart"><a id="lnkMyCart"></a></li>
            <li class="cssClassCheckOut"><a id="lnkCheckOut" rel="popuprel3" href="#">Checkout</a></li>
        </ul>
        <div class="cssClassclear">
        </div>
    </div>
</div>
<div id="popuprel3" class="popupbox cssClassCenterPopBox">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblCheckoutOptions" runat="server" Text="Checkout using one of the following options: "></asp:Label>
    </h2>
    <div id="divCheckoutTypes" class="cssClassFormWrapper">
    </div>
</div>