<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemsCompare.ascx.cs"
            Inherits="Modules_ASPXCompareItems_ItemsCompare" %>

<script type="text/javascript" language="javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var ip = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var sessionCode = '<%= sessionCode %>';
    var IDs = "";

    $(document).ready(function() {
        $("#divCompareItems").hide();
        if ('<%= enableCompareItems %>'.toLowerCase() == 'true') {
            GetCompareItemList();
            $("#divCompareItems").show();
            $("#btncompare").click(function() {
                $.cookies.set("ItemCompareDetail", IDs);
                LoadControl("Modules/ASPXCommerce/ASPXItemsCompare/ItemCompareDetails.ascx");
            });

            $(".cssClassClose").click(function() {
                $('#fade, #popuprel6').fadeOut();
            });

            $('#btnPrintItemCompare').click(function() {
                printPage();
            });
        }
    });

    function printPage() {
        var content = $('#divCompareElementsPopUP').html();
        var pwin = window.open('', 'print_content', 'width=100,height=100');
        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">' + content + '</body></html>');
        pwin.document.close();
        setTimeout(function() { pwin.close(); }, 5000);
    }

    function RecentAdd(Id) {
        var param = JSON2.stringify({ IDs: Id, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "Post",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddComparedItems",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                alert("success");
            },
            error: function() {
                alert("error");
            }
        });
    }

    function GetCompareItemList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemCompareList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, sessionCode: sessionCode }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                IDs = '';
                $("#tblCompareItemList>tbody").html('');
                $("#h2compareitems").html("<span class='cssClassCompareItem'>My Compare Items [" + msg.d.length + "]</span>");
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindItems(item, index);
                    });
                    IDs = IDs.substring(0, IDs.length - 1);
                    $("#compareItemBottons").show();
                } else {
                    $("#compareItemBottons").hide();
                    $("#tblCompareItemList>tbody").html("<span class=\"cssClassNotFound\">No items has been compared yet!</span>");
                }
            }
        });
    }

    function BindItems(response, index) {
        var ItemID = response.ItemID;
        IDs += ItemID + "#";
        if (index % 2 == 0) {
            Items = '<tr class="cssClassAlternativeEven"><td class="cssClassCompareItemInfo"><a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a></td><td class="cssClassDelete"><img src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png" onclick="DeleteCompareItem(' + ItemID + ');"/></td></tr>';
        } else {
            Items = '<tr class="cssClassAlternativeOdd"><td class="cssClassCompareItemInfo"><a href="' + aspxRedirectPath + 'item/' + response.SKU + '.aspx">' + response.ItemName + '</a></td><td class="cssClassDelete"><img src="' + aspxTemplateFolderPath + '/images/admin/btndelete.png" onclick="DeleteCompareItem(' + ItemID + ');"/></td></tr>';
        }
        $("#tblCompareItemList>tbody").append(Items);
    }

    function DeleteCompareItem(itemId) {
        // alert(itemId);
        var properties = {
            onComplete: function(e) {
                ConfirmDelete(itemId, e);
                //alert(itemId);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to delete this item?</p>", properties);
    }

    function ConfirmDelete(id, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCompareItem",
                data: JSON2.stringify({ ID: id, storeID: storeId, portalID: portalId, userName: userName, sessionCode: sessionCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    // alert("success");
                    GetCompareItemList();
                }
            });
        }
    }

    function ClearAll() {
        var properties = {
            onComplete: function(e) {
                ConfirmClear(e);
            }
        }
        // Ask user's confirmation before delete records
        csscody.confirm("<h2>Delete Confirmation</h2><p>Do you want to clear all the item?</p>", properties);
    }

    function ConfirmClear(event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/ClearAll",
                data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, sessionCode: sessionCode }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    GetCompareItemList();
                }
            });
        }
    }

    function LoadControl(ControlName) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "LoadControlHandler.aspx/Result",
            data: "{ controlName:'" + aspxRootPath + ControlName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                $('#divCompareElementsPopUP').html(response.d);
                ShowPopupControl("popuprel6");
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }
</script>

<div id="divCompareItems" class="cssClassCommonSideBox">
    <h2 id="h2compareitems">
    </h2>
    <div class="cssClassCommonSideBoxTable">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" id="tblCompareItemList">
            <tbody>
            </tbody>
        </table>
        <div class="cssClassButtonWrapper" id="compareItemBottons">
            <button type="button" onclick=" ClearAll(); ">
                <span><span>Clear All</span></span></button>
            <button type="button" id="btncompare">
                <span><span>Compare</span></span></button>
        </div>
    </div>
</div>
<div class="popupbox cssClassCompareBox" id="popuprel6">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblCompareTitle" runat="server" Text="Compare following Items"></asp:Label>
    </h2>
    <div class="cssClassButtonWrapper cssClassTopPrint">
        <p>
            <button type="button" id="btnPrintItemCompare">
                <span><span>Print</span></span></button>
        </p>
        <div class="cssClassClear">
        </div>
    </div>
    <div id="divCompareElementsPopUP" class="cssClassFormWrapper">
    </div>
</div>