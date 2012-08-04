<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WishItemList.ascx.cs"
            Inherits="WishItemList" %>

<script type="text/javascript" language="javascript">
    $(document).ready(function() {
        GetWishItemList();
    });

    function GetWishItemList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetWishItemList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, flagShowAll: isAll, count: count }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblWishItemList>tbody").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindWishListItems(item, index);
                    });
                    $(".comment").each(function() {
                        if ($(this).val() == "") {
                            $(this).addClass("lightText").val("enter a comment..");
                        }
                    });

                    $(".comment").bind("focus", function() {
                        if ($(this).val() == "enter a comment..") {
                            $(this).removeClass("lightText").val("");
                        }
                        // focus lost action
                    });
                    $(".comment").bind("blur", function() {
                        if ($(this).val() == "") {
                            $(this).val("enter a comment..").addClass("lightText");
                        }
                    });
                } else {
                    $("#tblWishItemList>thead").hide();
                    $("#wishitemBottom").hide();
                    $("#tblWishItemList").html("<p>Your Wishlist is empty!</p>");
                }
            },
            error: function(msg) {
                alert(msg.d);
            }
        });
    }

    function BindWishListItems(response, index) {
        if (response.ImagePath == "") {
            response.ImagePath = aspxRootPath + "Modules/ASPXCommerce/ASPXItemsManagement/uploads/noitem.png";
        } else if (response.AlternateText == "") {
            response.AlternateText = response.ItemName;
        }
        ItemIDs = response.ItemID + "#";
        ItemComments = $("#comment" + response.ItemID + "").innerText;

        var WishDate = DateDeserialize(response.WishDate, "yyyy/M/d");
        if (index % 2 == 0) {
            Items = '<tr class="cssClassAlternativeEven" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '"  title="' + response.AlternateText + '"/><a href="' + aspxRootPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a><span class="cssClassPrice">' + response.Price + '</span></td><td class="cssClassWishComment"><textarea id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart"> <div class="cssClassButtonWrapper"><a href="' + aspxRootPath + 'item/' + response.SKU + '.aspx"><span>Add To Cart</span></a></div></td><td class="cssClassDelete"><img id="imgdelete" onclick="DeleteWishItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
        } else {
            Items = '<tr class="cssClassAlternativeOdd" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '"  title="' + response.AlternateText + '"/><a href="' + aspxRootPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a><span class="cssClassPrice">' + response.Price + '</span></td><td class="cssClassWishComment"><textarea id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart"> <div class="cssClassButtonWrapper"><a href="' + aspxRootPath + 'item/' + response.SKU + '.aspx"><span>Add To Cart</span></a></div></td><td class="cssClassDelete"><img id="imgdelete" onclick="DeleteWishItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
        }
        $("#tblWishItemList>tbody").append(Items);
    }

    function DeleteWishItem(itemId) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(itemId, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this item from your wish list?</p>", properties);
    }

    function ConfirmSingleDelete(id, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteWishItem",
                data: JSON2.stringify({ ID: id, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    if ($(".cssClassWishListCount").html() != null) {
                        $.UpdateHeaderWishlistCount();
                    }
                    GetWishItemList();
                    alert('Success');
                },
                error: function(msg) {
                    alert("error");
                }
            });
        }
    }

    $.extend({
        UpdateHeaderWishlistCount: function() {
            var wishListCount = $(".cssClassWishListCount").html().replace( /[^0-9]/gi , '');
            wishListCount = parseInt(wishListCount) - 1;
            $(".cssClassWishListCount").html("[" + wishListCount + "]");
        }
    });

    function UpdateWishList() {
        var comment = '';
        var itemId = '';
        $(".comment").each(function() {
            comment += $(this).val() + ',';
            itemId += parseInt($(this).attr("id").replace( /[^0-9]/gi , '')) + ',';
            //UpdateList(itemId, comment);
        });
        comment = comment.substring(0, comment.length - 1);
        itemId = itemId.substring(0, itemId.length - 1);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateWishList",
            data: JSON2.stringify({ ID: itemId, comment: comment, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                alert("success");
            },
            error: function(msg) {
                alert("error");
            }
        });
    }

    function ClearWishList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/ClearWishList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                alert("Successfully cleared your wishlist!");
            },
            error: function(msg) {
                alert("error");
            }
        });
    }

    function DateDeserialize(content, format) {
        content = eval('new ' + content.replace( /[/]/gi , ''));
        return formatDate(content, format);
    }
</script>

<div class="cssClassFormWrapper">
    <div class="cssClassCommonCenterBox">
        <h2>
            <asp:Label ID="lblMyWishListTitle" runat="server" Text="My WishList Content" CssClass="cssClassWishItem"></asp:Label></h2>
        <div class="cssClassCommonCenterBoxTable">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblWishItemList"
                   class="cssClassMyWishItemTable">
                <thead>
                    <tr class="cssClassCommonCenterBoxTableHeading">
                        <td class="cssClassWishItemDetails">
                            <asp:Label ID="lblItem" runat="server" Text="Item"></asp:Label>
                        </td>
                        <td class="cssClassWishListComment">
                            <asp:Label ID="lblComment" runat="server" Text="Comment"></asp:Label>
                        </td>
                        <td class="cssClassAddedOn">
                            <asp:Label ID="lblAddedOn" runat="server" Text="Added On"></asp:Label>
                        </td>
                        <td class="cssClassAddToCart">
                            <asp:Label ID="lblAddToCart" runat="server" Text="Add To Cart"></asp:Label>
                        </td>
                        <td class="cssClassDelete">
                        </td>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
            <div class="cssClassButtonWrapper" id="wishitemBottom">
                <%--<button type="button">
                    <span><span>Share Wishlist</span></span></button>
                <button type="button">
                    <span><span>Add All to Cart</span></span></button>--%>
                <button type="button" id="updateWishList" onclick=" UpdateWishList(); ">
                    <span><span>Update WishList</span></span></button>
                <button type="button" id="clearWishList" onclick=" ClearWishList(); ">
                    <span><span>Clear WishList</span></span></button>
                <%--<button type="button">
                    <span><span>Continue shopping</span></span></button>--%>
            </div>
        </div>
    </div>
</div>