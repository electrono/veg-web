<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyTags.ascx.cs" Inherits="Modules_ASPXMyTags_MyTags" %>

<script type="text/javascript">

    $(document).ready(function() {
        GetMyTags();
    });

    function GetMyTags() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetTagsByUserName",
            data: JSON2.stringify({ userName: userName, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var MyTags = '';
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, value) {
                        MyTags += '<li class="tag_content"><a href="' + aspxRedirectPath + 'tagsitems/tags.aspx?tagsId=' + value.ItemTagIDs + '"><label>' + value.Tag + '</label></a>';
                        MyTags += "<button type=\"button\" class=\"cssClassCross\" value=" + value.ItemTagIDs + " onclick ='DeleteMyTag(this)'><span>x</span></button></li>";
                    });
                } else {
                    MyTags = "<span class=\"cssClassNotFound\">Your tag list is empty!</span>";
                }
                $("#divMyTags >ul").html(MyTags);

            }
//            ,
//            error: function() {
//            csscody.error('<h2>Error Message</h2><p>Error! Failed to load tags.</p>');
//            }
        });
    }

    function DeleteMyTag(obj) {
        var itemTagId = $(obj).attr("value");
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteUserOwnTag",
            data: JSON2.stringify({ itemTagID: itemTagId, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                // alert("Your Tag is successfully deleted!");
                csscody.alert('<h2>Information Alert</h2><p>Your Tag is successfully deleted!.</p>');
                GetMyTags();
            },
            error: function() {
                alert("error");
            }
        });
    }
</script>

<div class="cssClassFormWrapper">
    <div class="cssClassCommonCenterBox">
        <h2>
            <asp:Label ID="lblMyTagsTitle" runat="server" Text="My Tags Content" CssClass="cssClassTags"></asp:Label></h2>
        <div class="cssClassCommonCenterBoxTable">
            <div id="divMyTags">
                <ul>
                </ul>
            </div>
        </div>
    </div>
</div>