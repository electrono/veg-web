<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WishItemList.ascx.cs"
            Inherits="WishItemList" %>

<script type="text/javascript" language="javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var customerId = '<%= customerID %>';
    var sessionCode = '<%= sessionCode %>';
    var userEmail = '<%= userEmail %>';
    var serverLocation = '<%= Request.ServerVariables["SERVER_NAME"] %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);

    $(document).ready(function() {
//        if (customerId == 0 && userName.toLowerCase() == 'anonymoususer') {
//            Login();
//            return false;
//        }
        $("#divWishListContent").hide();
        if ('<%= enableWishList %>'.toLowerCase() == 'true') {
            GetWishItemList();
            $("#divWishListContent").show();
            $('.errorMessage').hide();
            $('#divShareWishList').hide();
            if (userFriendlyURL) {
                $("#lnkContinueShopping").attr("href", '' + aspxRedirectPath + 'Home.aspx');
            } else {
                $("#lnkContinueShopping").attr("href", '' + aspxRedirectPath + 'Home');
            }
            $("#continueInStore").click(function() {
                if (userFriendlyURL) {
                    window.location.href = aspxRedirectPath + 'Home.aspx';
                } else {
                    window.location.href = aspxRedirectPath + 'Home';
                }
                return false;
            });

            //		$('#btnShareWishBack').click(function() {
            //            $('#divWishListContent').show();
            //            $('#divShareWishList').hide();
            //        });

            $('#shareWishList').click(function() {
                //  $('#divWishListContent').hide();
                $('#divShareWishList').show();
                HideMessage();
                ShowPopupControl('popuprel5');
            });

            $(".cssClassClose").click(function() {
                $('#fade, #popuprel5').fadeOut();
            });

            $('#btnShareWishItem').click(function() {
                var emailIDsColln = $('#txtEmailID').val();
                if (validateMultipleEmailsCommaSeparated(emailIDsColln)) {
                    SendShareItemEmail();
                } else {
                    // alert('Eener Valid email with comma separated');
                    $('.errorMessage').show();
                }
            });
        } else {
            csscody.alert('<h2>Information Alert</h2><p>WishList is not enabled.</p>');
        }

    });

    function trim(str, chars) {
        return ltrim(rtrim(str, chars), chars);
    }

    function ltrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
    }

    function rtrim(str, chars) {
        chars = chars || "\\s";
        return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
    }

    function validateMultipleEmailsCommaSeparated(value) {
        var result = value.split(",");
        for (var i = 0; i < result.length; i++)
            if (!validateEmail(result[i]))
                return false;
        return true;
    }

    function validateEmail(field) {
        var regex = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/ ;
        return (regex.test(trim(field))) ? true : false;
    }

    function ClearShareWishItemForm() {
        $('#txtEmailID').val('');
        $('#txtEmailMessage').val('');
        $('.cssClassWishComment textarea').val('');
        $(".comment").each(function() {
            if ($(this).val() == "") {
                $(this).addClass("lightText").val("enter a comment..");
            }
        });
    }

    function DeleteWishListItem(itemId) {
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
                    GetWishItemList(); // for rebinding the wishlist item 
                    csscody.alert("<h2>Information Message</h2><p>WishList Item Deleted Successfully.</p>");
                },
                error: function(msg) {
                    alert("error");
                }
            });
        }
    }

    function GetWishItemList() {
        var count = 10;
        var isAll = 1;
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
                    $("#tblWishItemList").html("<span class=\"cssClassNotFound\">Your Wishlist is empty!</span>");
                }
            }
//            ,
//            error: function(msg) {
//                alert("Error!");
//            }
        });
    }

    function BindWishListItems(response, index) {
        if (response.ImagePath == "") {
            response.ImagePath = '<%= noImageWishList %>';
        } else if (response.AlternateText == "") {
            response.AlternateText = response.ItemName;
        }
        ItemIDs = response.ItemID + "#";
        ItemComments = $("#comment" + response.ItemID + "").innerText;

        var WishDate = DateDeserialize(response.WishDate, "yyyy/M/d");

        var itemSKU = JSON2.stringify(response.SKU);
        if (index % 2 == 0) {

            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (response.IsOutOfStock) {
                    //  Items = "<tr class='cssClassAlternativeEven' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt=' "+ response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2) + "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper cssClassOutOfStock'><a href='#'><span>Out Of Stock</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                    Items = '<tr class="cssClassAlternativeEven" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                    Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                    Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                    Items += "<div class='cssClassButtonWrapper cssClassOutOfStock'><a href=\"#\"><span>Out Of Stock</span></a></div></td>";
                    Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + ' /images/admin/btndelete.png"/></td></tr>';

                } else {
                    //  Items = "<tr class='cssClassAlternativeEven' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt='" + response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2) + "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper '><a href='#' onclick='AddToCartToJS(" + response.ItemID + "," + response.Price  + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                    Items = '<tr class="cssClassAlternativeEven" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                    Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                    Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                    Items += "<div class='cssClassButtonWrapper'><a href=\"#\" onclick='AddToCartToJS(" + response.ItemID + "," + response.Price + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td>";
                    Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
                }
            } else {
                //  Items = "<tr class='cssClassAlternativeEven' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt='" + response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2)+ "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper '><a href='#' onclick='AddToCartToJS(" + response.ItemID + "," + response.Price  + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                Items = '<tr class="cssClassAlternativeEven" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                Items += "<div class='cssClassButtonWrapper'><a href=\"#\" onclick='AddToCartToJS(" + response.ItemID + "," + response.Price + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td>";
                Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';

            }
        } else {
            if ('<%= allowOutStockPurchase %>'.toLowerCase() == 'false') {
                if (response.IsOutOfStock) {
                    // Items = "<tr class='cssClassAlternativeOdd' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt='" + response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2) + "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper cssClassOutOfStock'><a href='#'><span>Out Of Stock</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                    Items = '<tr class="cssClassAlternativeOdd" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                    Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                    Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                    Items += "<div class='cssClassButtonWrapper cssClassOutOfStock'><a href=\"#\"><span>Out Of Stock</span></a></div></td>";
                    Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + ' /images/admin/btndelete.png"/></td></tr>';

                } else {
                    //  Items = "<tr class='cssClassAlternativeOdd' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt='" + response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2)+ "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper '><a href='#' onclick='AddToCartToJS(" + response.ItemID + "," + response.Price + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                    Items = '<tr class="cssClassAlternativeOdd" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                    Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                    Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                    Items += "<div class='cssClassButtonWrapper'><a href=\"#\" onclick='AddToCartToJS(" + response.ItemID + "," + response.Price + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td>";
                    Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';
                }
            } else {
                //   Items = "<tr class='cssClassAlternativeOdd' id='tr_" + response.ItemID + "'><td class='cssClassWishItemDetails'><div class='cssClassImage'><img src='" + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + "' alt='" + response.AlternateText + "' title='" + response.AlternateText + "'/></div><a href='" + aspxRedirectPath + "item/" + response.SKU + ".aspx'>" + response.ItemName + "</a><span class='cssClassPrice cssClassFormatCurrency'>" + (response.Price * rate).toFixed(2)+ "</span></td><td class='cssClassWishComment'><textarea maxlength='300' onkeyup="+ismaxlength(this)+" id='comment_" + response.ItemID + "' class='comment'>" + response.Comment + "</textarea></td><td class='cssClassWishDate'>" + WishDate + "</td><td class='cssClassWishToCart'><div class='cssClassButtonWrapper '><a href='#' onclick='AddToCartToJS(" + response.ItemID + "," + response.Price  + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td><td class='cssClassDelete'><img onclick='DeleteWishListItem(" + response.ItemID + ")' src='" + aspxTemplateFolderPath + "/images/admin/btndelete.png'/></td></tr>";
                Items = '<tr class="cssClassAlternativeOdd" id="tr_' + response.ItemID + '"><td class="cssClassWishItemDetails"><div class="cssClassImage"><img src="' + aspxRootPath + response.ImagePath.replace('uploads', 'uploads/Small') + '" alt="' + response.AlternateText + '" title="' + response.AlternateText + '"/></div>';
                Items += '<a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a>';
                Items += '<span class="cssClassPrice cssClassFormatCurrency">' + (response.Price * rate).toFixed(2) + '</span></td><td class="cssClassWishComment"><textarea maxlength="300" onkeyup="' + ismaxlength(this) + '" id="comment_' + response.ItemID + '" class="comment">' + response.Comment + '</textarea></td><td class="cssClassWishDate">' + WishDate + '</td><td class="cssClassWishToCart">';
                Items += "<div class='cssClassButtonWrapper'><a href=\"#\" onclick='AddToCartToJS(" + response.ItemID + "," + response.Price + "," + itemSKU + "," + 1 + ");'><span>Add To Cart</span></a></div></td>";
                Items += '<td class="cssClassDelete"><img onclick="DeleteWishListItem(' + response.ItemID + ')" src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png"/></td></tr>';

            }
        }

        $("#tblWishItemList>tbody").append(Items);
        $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
        if ('<%= showImageInWishlist %>'.toLowerCase() == 'false') {
            $('.cssClassWishItemDetails>img').hide();
        }
        $(".comment").keypress(function(e) {
            if (e.which == 35) {
                return false;
            }
        });
    }

    function ismaxlength(obj) {
        var mlength = obj.getAttribute ? parseInt(obj.getAttribute("maxlength")) : ""
        if (obj.getAttribute && obj.value.length > mlength)
            obj.value = obj.value.substring(0, mlength)
    }

    function AddToCartToJS(itemId, itemPrice, itemSKU, itemQuantity) {
        AddToCartFromJS(itemId, itemPrice, itemSKU, itemQuantity, storeId, portalId, customerId, sessionCode, userName, cultureName);
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
                    GetWishListCount(); // for header wish counter increase for database
                    GetWishItemList(); // for rebinding the wishlist item    
                    //alert('Success');
                    csscody.alert("<h2>Information Message</h2><p>WishList Item Deleted Successfully.</p>");
                },
                error: function(msg) {
                    alert("error");
                }
            });
        }
    }

    function UpdateWishList() {
        var comment = '';
        var itemId = '';
        $(".comment").each(function() {
            comment += $(this).val() + '#';
            itemId += parseInt($(this).attr("id").replace( /[^0-9]/gi , '')) + '#';
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
                //alert("success Update WIshlist");
                csscody.alert("<h2>Information Message</h2><p>WishList Updated Successfully.</p>");
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
                GetWishListCount(); // for header wish counter increase for database
                GetWishItemList(); // for rebinding the wishlist item    
                //alert("Successfully cleared your wishlist!");
                csscody.alert("<h2>Information Message</h2><p>Successfully cleared your wishlist!</p>");
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

    function SendShareItemEmail() {
        var emailID = '';
        var message = '';
        var itemId = '';

        var arr = new Array;
        var elems = '';
        $(".comment").each(function() {
            itemId += parseInt($(this).attr("id").replace( /[^0-9]/gi , '')) + ',';
        });
        itemId = itemId.substring(0, itemId.length - 1);

        emailID = $('#txtEmailID').val();
        message = $('#txtEmailMessage').val();

        var senderName = userName;
        var senderEmail = userEmail;
        var receiverEmailID = emailID;
        var subject = "Take A Look At " + senderName + "'s " + " WishList";
        var msgbodyhtml = '';
        var msgCommenthtml = '';
//        $('#tblWishItemList tbody .cssClassWishItemDetails img').each(function() {
//            $(this).attr({ Width: "123px", Height: "81px" });
//        });

        var serverHostLoc = 'http://' + serverLocation;
        var fullDate = new Date();
        var twoDigitMonth = ((fullDate.getMonth().length + 1) === 1) ? (fullDate.getMonth() + 1) : (fullDate.getMonth() + 1);
        if (twoDigitMonth.length == 2) {
        } else if (twoDigitMonth.length == 1) {
            twoDigitMonth = '0' + twoDigitMonth;
        }
        var currentDate = fullDate.getDate() + "/" + twoDigitMonth + "/" + fullDate.getFullYear();
        var dateyear = fullDate.getFullYear();

        var trLength = $('#tblWishItemList tbody tr').lenght;
        var tdContent = '';
        var tdContentArray = [];
        var shareWishMailHtml = '';
        shareWishMailHtml += '<table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" align="center" cellpadding="0" cellspacing="5" bgcolor="#e0e0e0"><tr><td align="center" valign="top"><table width="680" border="0" cellspacing="0" cellpadding="0"><tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr><tr><td>';
        shareWishMailHtml += '<table width="680" border="0" cellspacing="0" cellpadding="0"><tr>';
        shareWishMailHtml += ' <td width="300"><a href="' + serverHostLoc + '" target="_blank" style="outline:none; border:none;"><img src="' + serverHostLoc + aspxTemplateFolderPath + '/images/aspxcommerce.png' + '" width="143" height="62" alt="Aspxcommerce" title="Aspxcommerce"/></a></td>';
        shareWishMailHtml += '<td width="191" align="left" valign="middle">&nbsp;</td><td width="189" align="right" valign="middle"><b style="padding:0 20px 0 0; text-shadow:1px 1px 0 #fff;"> ' + currentDate + '</b></td></tr></table></td></tr>';
        shareWishMailHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr><tr><td bgcolor="#fff"><div style="border:1px solid #c7c7c7; background:#fff; padding:20px">';
        shareWishMailHtml += '<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr>';
        shareWishMailHtml += ' <td><p style="font-family:Arial, Helvetica, sans-serif; font-size:17px; line-height:16px; color:#278ee6; margin:0; padding:0 0 10px 0; font-weight:bold; text-align:left;">';
        shareWishMailHtml += 'Your Friend <strong>' + userName + '</strong> Wants to Share these Wished Item with You !!</p>';
        shareWishMailHtml += '<p style="margin:0; padding:10px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;"> Friend Email ID: ' + senderEmail + ' </p></td></tr>';
        shareWishMailHtml += '<tr><td><p style="margin:0; padding:10px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;"> ' + message + '</p></td></tr></table>';
        shareWishMailHtml += '<table width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td>';
        shareWishMailHtml += '  <table width="100%" border="0" cellspacing="0" cellpadding="0"><tr>';
        // loop function here
        $('#tblWishItemList tbody tr').each(function() {
            var src = $(this).find('td div.cssClassImage img').attr('src');
            var alt = $(this).find('td div.cssClassImage img').attr('alt');
            var title = $(this).find('td div.cssClassImage img').attr('title');
            var price = $(this).find('td.cssClassWishItemDetails span').html();
            var href = $(this).find('td.cssClassWishItemDetails a').attr('href');
            var hrefHtml = $(this).find('td.cssClassWishItemDetails a').html();
            var htmlComment = $(this).find('td.cssClassWishComment textarea').val();
            tdContent += '<td width="33%"><div style="border:1px solid #cfcfcf; background:#f1f1f1; padding:10px; text-align:center;"> <img src=' + serverHostLoc + src + ' alt="' + alt + '" width="80" />';
            tdContent += ' <p style="margin:0; padding:5px 0 0 0; font-family:Arial, Helvetica, sans-serif; font-size:12px; font-weight:normal; line-height:18px;">';
            tdContent += '<span style="font-weight:bold; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;">' + title + '</span><br />'; //item name
            tdContent += '<span style="font-weight:bold; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;"> <a href="' + serverHostLoc + href + '">' + hrefHtml + '</a></span><br />'; //item name
            tdContent += '<span style="font-weight:bold; font-size:11px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;">Price:</span> ' + price + '<br />'; //price
            tdContent += '<span style="font-weight:bold; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;">Comments:</span> ' + htmlComment + '</p></div></td>'; //comment
            tdContentArray.push(tdContent);
            tdContent = '';
        }); //loop finishes
        for (var i in tdContentArray) {
            if (i % 3 == 0) {
                shareWishMailHtml += '</tr><tr>' + tdContentArray[i];
            } else {
                shareWishMailHtml += tdContentArray[i];
            }
        }
        shareWishMailHtml += '</tr></table></td></tr></table><p style="margin:0; padding:10px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;"> Thank You,<br />';
        shareWishMailHtml += '<span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;">AspxCommerce Team </span></p></div></td></tr>';
        shareWishMailHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="20" alt=" "/></td></tr><tr>';
        shareWishMailHtml += ' <td align="center" valign="top"><p style="font-size:11px; color:#4d4d4d"> © ' + dateyear + ' AspxCommerce. All Rights Reserved.</p></td>';
        shareWishMailHtml += '</tr><tr><td align="center" valign="top"><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr></table></td></tr></table>';

        var functionName = "ShareWishListEmailSend";
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: JSON2.stringify({ StoreID: storeId, PortalID: portalId, ItemID: itemId, SenderName: senderName, SenderEmail: userEmail, ReceiverEmailID: receiverEmailID, Subject: subject, Message: message, Link: shareWishMailHtml, CultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                csscody.alert("<h2>Information Message</h2><p>Email has been send successfully.</p>");
                ClearShareWishItemForm();
                $('#divWishListContent').show();
                $('#divShareWishList').hide();
                $('#fade, #popuprel5, .cssClassClose').fadeOut();
            },
            error: function() {
                ClearShareWishItemForm();
                $('#fade, #popuprel5, .cssClassClose').fadeOut();
                csscody.alert("<h2>Information Alert</h2><p>Failure sending mail!</p>");
            }
        });
    }

    function HideMessage() {
        $('.errorMessage').hide();
    }
</script>

<div id="divWishListContent" class="cssClassFormWrapper">
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
                <button type="button" id="shareWishList" rel="popuprel5">
                    <span><span>Share Wishlist</span></span></button>
                <%--<button type="button">
                    <span><span>Add All to Cart</span></span></button>--%>
                <button type="button" id="updateWishList" onclick=" UpdateWishList(); ">
                    <span><span>Update WishList</span></span></button>
                <button type="button" id="clearWishList" onclick=" ClearWishList(); ">
                    <span><span>Clear WishList</span></span></button>
                <button type="button" id="continueInStore">
                    <span><span>Continue to Shopping</span></span></button>
            </div>
        </div>
    </div>
</div>
<div class="popupbox" id="popuprel5">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblWishHeading" runat="server" Text="Share Your WishList" CssClass="cssClassWishItem"></asp:Label>
    </h2>
           
    <div id="divShareWishList" class="cssClassFormWrapper">
        <div class="cssClassCommonCenterBox">
            <div class="cssClassPopUpHeading">
                <h3>
                    <asp:Label ID="lblShareHeading" runat="server" Text="Sharing Information" CssClass="cssClassLabel"></asp:Label>
                </h3>
            </div>
            <div class="cssClassCommonCenterBoxTable">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblShareWishList"
                       class="cssClassMyWishItemTable">
                    <tbody>
                        <tr>
                            <td>
                                <li>
                                    <asp:Label ID="lblEmailHeading" runat="server" Text="Email addresses, separated by commas"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                    <br />
                                    <textarea id="txtEmailID" name="receiveremailIDs" class="required email" rows="5"
                                              cols="60" name="emailIDs" onclick=" HideMessage(); "></textarea>
                                    <br />
                                    <p class="errorMessage">
                                        <span class="cssClassRequired">Enter Valid EmailID with comma separated</span></p>
                                </li>
                                <li>
                                    <asp:Label ID="lblEmailMessage" runat="server" Text="Message"></asp:Label><br />
                                    <textarea id="txtEmailMessage" class="emailMessage" rows="5" cols="60" name="emailMessage"
                                              minlength="5"></textarea>
                                </li>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="cssClassButtonWrapper">
                    <%--<button type="button" id="btnShareWishBack" >
                    <span><span>Back</span></span></button>--%>
                    <button type="button" id="btnShareWishItem">
                        <span><span>Share WishList</span></span></button>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hdnWishItem" />