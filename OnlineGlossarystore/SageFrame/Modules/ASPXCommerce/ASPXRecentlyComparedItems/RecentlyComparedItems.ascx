<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecentlyComparedItems.ascx.cs"
            Inherits="Modules_ASPXRecentlyComparedItems_RecentlyComparedItems" %>

<script type="text/javascript" language="javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        // $("#divRecentComparedItems").hide();
        if ('<%= enableRecentlyCompared %>'.toLowerCase() != 'true' || '<%= enableCompareItemsRecently %>'.toLowerCase() != 'true') {
            $("#divRecentComparedItems").hide();
            // var CompareCount = '<%= countCompare %>';
            //GetRecentlyComparedItemList(storeId, portalId, userName, cultureName, aspxRootPath, CompareCount);            
        } else {
            RecentlyCompareItemsList();
            // $("#divRecentComparedItems").show();
        }
    });

    function RecentlyCompareItemsList() {
        var recentlyCompareCount = '<%= countCompare %>';
        var params = { count: recentlyCompareCount, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetRecentlyComparedItemList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblRecentlyComparedItemList>tbody").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindRecentlyCompareItems(item, index);
                    });
                } else {
                    $("#tblRecentlyComparedItemList>tbody").html("<span class=\"cssClassNotFound\">You have not viewed any items yet!</span>");
                }
            }
//            ,
//            error: function() {
//                csscody.error('<h1>Error Message</h1><p>Failed to load recently viewed items.</p>');
//            }
        });
    }

    function BindRecentlyCompareItems(item, index) {
        var RecentlyCompareItems = '';
        if (index % 2 == 0) {
            RecentlyCompareItems = '<tr class="cssClassAlternativeEven"><td><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + '</a></td></tr>';
        } else {
            RecentlyCompareItems = '<tr class="cssClassAlternativeOdd"><td><a href="' + aspxRedirectPath + 'item/' + item.SKU + '.aspx">' + item.ItemName + '</a></td></tr>';
        }
        $("#tblRecentlyComparedItemList>tbody").append(RecentlyCompareItems);
    }
</script>

<div id="divRecentComparedItems" class="cssClassCommonSideBox">
    <h2>
        <asp:Label ID="lblRecebtlyComparedTitle" runat="server" Text="Recently Compared Items"
                   CssClass="cssClassRecentlyComparedItems"></asp:Label></h2>
    <div class="cssClassCommonSideBoxTable">
        <table id="tblRecentlyComparedItemList" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            </tbody>
        </table>
    </div>
</div>