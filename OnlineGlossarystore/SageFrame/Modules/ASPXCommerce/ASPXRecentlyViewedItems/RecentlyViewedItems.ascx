<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecentlyViewedItems.ascx.cs"
            Inherits="Modules_ASPXRecentlyViewedItems_RecentlyViewedItems" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        $("#divRecentViewedItems").hide();
        if ('<%= enableRecentlyViewed %>'.toLowerCase() == 'true') {
            RecentlyViewedItemsList();
            $("#divRecentViewedItems").show();
        }

    });

    function RecentlyViewedItemsList() {
        var recentlyViewedCount = '<%= countViewedItems %>';
        var params = { count: recentlyViewedCount, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetRecentlyViewedItems",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblRecentlyViewedItems>tbody").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindRecentlyViewedItems(item, index);
                    });
                } else {
                    $("#tblRecentlyViewedItems>tbody").html("<span class=\"cssClassNotFound\">You have not viewed any items yet!</span>");
                }
            }
//            ,
//            error: function() {
//                csscody.error('<h1>Error Message</h1><p>Failed to load recently viewed items.</p>');
//            }
        });
    }

    function BindRecentlyViewedItems(item, index) {
        var RecentlyViewedItems = '';
        if (index % 2 == 0) {
            RecentlyViewedItems = '<tr class="cssClassAlternativeEven"><td><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + '</a></td></tr>';
        } else {
            RecentlyViewedItems = '<tr class="cssClassAlternativeOdd"><td><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + '</a></td></tr>';
        }
        $("#tblRecentlyViewedItems>tbody").append(RecentlyViewedItems);
    }

</script>

<div id="divRecentViewedItems" class="cssClassCommonSideBox">
    <h2>
        <asp:Label ID="lblYouMayAlsoLike" Text="Recently Viewed Items" runat="server" CssClass="cssClassRecentlyViewedItems" /></h2>
    <div class="cssClassCommonSideBoxTable">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tblRecentlyViewedItems">
            <tbody>
            </tbody>
        </table>
    </div>
</div>