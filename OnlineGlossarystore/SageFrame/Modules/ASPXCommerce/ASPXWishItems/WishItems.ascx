<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WishItems.ascx.cs" Inherits="Modules_ASPXWishItems_WishItems" %>

<script type="text/javascript" language="javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var comment = $("#txtComment").val();
    var ItemIDs = 0;
    var ItemComments = "";
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var wishlistcount = 2;

    $(document).ready(function() {
        if (userFriendlyURL) {
            $("#lnkGoToWishlist").attr("href", '' + aspxRedirectPath + 'My-WishList.aspx');
        } else {
            $("#lnkGoToWishlist").attr("href", '' + aspxRedirectPath + 'My-WishList');
        }
        if ('<%= allowWishItemList %>'.toLowerCase() == 'true') {
            BindMyWishList();
        } else {
            $('#divRecentlyAddedWishList').hide();
        }
    });

    function DeleteWishListItem(itemId) {
        //alert(itemId);
        var properties = {
            onComplete: function(e) {
                ConfirmDeleteWishItem(itemId, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this item from your wish list?</p>", properties);
    }

    function ConfirmDeleteWishItem(id, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteWishItem",
                data: JSON2.stringify({ ID: id, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    GetWishListCount(); // for header wish counter increase for database 
                    BindMyWishList();
                },
                error: function(msg) {
                    alert("error");
                }
            });
        }
    }

    function BindMyWishList() {
        var isShowAll = 0;
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, flagShowAll: isShowAll, count: wishlistcount });

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetWishItemList",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblWishItem>tbody").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindWishItems(item, index);
                    });
                } else {
                    $('#<%= lblLastAdded.ClientID %>').hide();
                    $("#tblWishItem>tbody").html('<span class=\"cssClassNotFound\">Your Wishlist is empty!</span>');
                    $("#tblWishItem>tfoot").html('');
                }
            }
        });
    }

    function BindWishItems(response, index) {
        if (response.ImagePath == "") {
            response.ImagePath = '<%= noImageWishItemPath %>';
        }
        if (response.AlternateText == "") {
            response.AlternateText = response.ItemName;
        }
        if (index % 2 == 0) {
            Items = '<tr class="cssClassAlternativeEven" id="trWishItem_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '"  title="' + response.AlternateText + '"/></div><a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a><span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassDelete"><img id="imgdelete" onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
        } else {
            Items = '<tr class="cssClassAlternativeOdd" id="trWishItem_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '"  title="' + response.AlternateText + '"/></div><a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a><span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassDelete"><img id="imgdelete" onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
        }
        $("#tblWishItem>tbody").append(Items);
        $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
    }
</script>

<div class="cssClassCommonSideBox" id="divRecentlyAddedWishList">
    <h2>
        <asp:Label ID="lblRecentAddedWishItemsTitle" runat="server" Text="Recently Added WishItems"
                   CssClass="cssClassWishItem"></asp:Label></h2>
    <div class="cssClassCommonSideBoxTable">
        <table cellspacing="0" cellpadding="0" border="0" class="cssClassMyWishItemTable" id="tblWishItem"
               width="100%">
            <thead><h3>
                       <asp:Label ID="lblLastAdded" runat="server" Text="Last Added Items"></asp:Label></h3>
            </thead>
            <tbody>
            </tbody>
            <tfoot>
                <tr>
                    <td>
                        <a href="#" id="lnkGoToWishlist">
                            <asp:Label ID="lblGotoWishlist" runat="server" CssClass="gowishlist" Text="Go to Wishlist"></asp:Label></a>
                    </td>
                </tr>
            </tfoot>
        </table>
    </div>
</div>