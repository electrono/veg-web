<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserRecentHistory.ascx.cs"
            Inherits="Modules_ASPXUserDashBoard_UserRecentHistory" %>

<script type="text/javascript">
    $(document).ready(function() {
        LoadUserDashRecentHistoryStaticImage();
        GetUserRecentlyViewedItems();
        GetUserRecentlyComparedItems();
        $("#btnDeleteMyViewed").click(function() {
            var viewedItemsIds = '';
            $('.recentlyViewedItemsChkbox').each(function() {
                if ($(this).attr("checked")) {
                    viewedItemsIds += $(this).val() + ',';
                }
            });
            if (viewedItemsIds != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleViewedItems(viewedItemsIds, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        });
        $("#btnDeleteMyCompared").click(function() {
            var compareItemIds = '';
            $('.recentlyComparedItemsChkbox').each(function() {
                if ($(this).attr("checked")) {
                    compareItemIds += $(this).val() + ',';
                }
            });
            if (compareItemIds != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleCompareItems(compareItemIds, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        });
    });

    function LoadUserDashRecentHistoryStaticImage() {
        $('#ajaxUserRecentHistoryImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function GetUserRecentlyViewedItems() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvRecentlyViewedItems_pagesize").length > 0) ? $("#gdvRecentlyViewedItems_pagesize :selected").text() : 5;
        var defaultImage = "Modules/ASPXCommerce/ASPXItemsManagement/uploads/noitem.png";

        $("#gdvRecentlyViewedItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetUserRecentlyViewedItems',
            colModel: [
                { display: 'ItemID', name: 'items_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'recentlyViewedItemsChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Image', name: 'image', coltype: 'image', cssclass: 'cssClassImageHeader', controlclass: 'cssClassGridImage', alttext: '3', align: 'left' },
                { display: 'AlternateText', name: 'alternate_text', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'ItemName', name: 'item_name', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'link', align: 'left', url: 'item', queryPairs: '5' },
                { display: 'Viewed On', name: 'viewed_on', coltype: 'label', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'SKU', name: 'SKU', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center', hide: true }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', arguments: '2,3,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', arguments: '3,5' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 6: { sorter: false } },
            defaultImage: defaultImage
        });

    }

    function ConfirmDeleteMultipleViewedItems(ids, event) {
        DeleteMultipleViewedItems(ids, event);
    }

    function DeleteMultipleViewedItems(viewedItem_Ids, event) {
        if (event) {
            var params = { viewedItems: viewedItem_Ids, storeID: storeId, portalID: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteViewedItems",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetUserRecentlyViewedItems();
                }
            });
        }
        return false;
    }

    function GetUserRecentlyComparedItems() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvRecentlyComparedItems_pagesize").length > 0) ? $("#gdvRecentlyComparedItems_pagesize :selected").text() : 5;
        var defaultImage = aspxRootPath + "Modules/ASPXCommerce/ASPXItemsManagement/uploads/noitem.png";

        $("#gdvRecentlyComparedItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetUserRecentlyComparedItems',
            colModel: [
                { display: 'ItemID', name: 'items_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'recentlyComparedItemsChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Image', name: 'image', cssclass: 'cssClassImageHeader', controlclass: 'cssClassGridImage', coltype: 'image', alttext: '3', align: 'left' },
                { display: 'AlternateText', name: 'alternate_text', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'ItemName', name: 'item_name', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'link', align: 'left', url: 'item', queryPairs: '5' },
                { display: 'Compared On', name: 'compared_on', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'SKU', name: 'SKU', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center', hide: true }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', arguments: '2,3,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', arguments: '3,5' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 6: { sorter: false } },
            defaultImage: defaultImage
        });
    }

    function ConfirmDeleteMultipleCompareItems(ids, event) {
        DeleteMultipleCompareItems(ids, event);
    }

    function DeleteMultipleCompareItems(compareItem_Ids, event) {
        if (event) {
            var params = { compareItems: compareItem_Ids, storeID: storeId, portalID: portalId };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteComparedItems",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetUserRecentlyComparedItems();
                }
            });
        }
        return false;
    }

</script>

<div id="divUserRecentlyViewedItems">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblViewedTitle" runat="server" Text=" Viewed Items"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteMyViewed">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <%--<p>
                        <button type="button" id="btnAddViewedItemToWishList"><span><span>Add to WishList</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddViewedItemsToCart"><span><span>Add to Cart</span></span></button>
                    </p>--%>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="loading">
                    <img src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvRecentlyViewedItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divUserRecentlyComparedItems">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblComparedTitle" runat="server" Text=" Compared Items"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteMyCompared">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <%--<p>
                        <button type="button" id="btnAddComparedItemstToWishList"><span><span>Add to WishList</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddComparedItemsToCart"><span><span>Add to Cart</span></span></button>
                    </p>--%>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="loading">
                    <img id="ajaxUserRecentHistoryImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvRecentlyComparedItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>