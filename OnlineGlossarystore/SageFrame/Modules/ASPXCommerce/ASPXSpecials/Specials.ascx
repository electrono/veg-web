<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Specials.ascx.cs" Inherits="Modules_ASPXSpecials_Specials" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var countSpecials = '<%= noOfSpecialItems %>';

    $(document).ready(function() {
        $("#divSpecialItems").hide();
        if ('<%= enableSpecialItems %>'.toLowerCase() == 'true') {
            GetSpecialItems();
            $("#divSpecialItems").show();
        }

    });

    function GetSpecialItems() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSpecialItems",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, count: countSpecials }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        $(".cssClassSpecialBoxInfo ul").append('<li><a href="' + aspxRedirectPath + 'item/' + item.ItemSku + '.aspx" ><img src="' + aspxRootPath + item.imagepath.replace('uploads', 'uploads/Small') + '"  alt="' + item.ItemName + '" /></a><a href="' + aspxRedirectPath + 'item/' + item.ItemSku + '.aspx" >' + item.ItemName + '</a></li>');
                    });
                } else {
                    $(".cssClassSpecialBox").html("<span class=\"cssClassNotFound\">No special item found in this store!</span>");
                    $(".cssClassSpecialBox").removeClass("cssClassSpecialBox");
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }
</script>

<div id="divSpecialItems" class="cssClassSpecial">
    <h2>
        Specials</h2>
    <div class="cssClassSpecialBox">
        <div class="cssClassSpecialBoxInfo">
            <h3>
                Special Items</h3>
            <ul>
            </ul>
        </div>
        <div class="cssClassclear">
        </div>
    </div>
</div>