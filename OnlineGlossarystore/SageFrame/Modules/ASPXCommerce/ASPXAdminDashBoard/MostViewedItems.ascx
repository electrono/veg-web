<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MostViewedItems.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_MostViewedItems" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var MostViewedItemCount = 5;

    $(document).ready(function() {
        GetMostViewedItemAdmindash();
    });

    function GetMostViewedItemAdmindash() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetMostViwedItemAdmindash",
            data: JSON2.stringify({ count: MostViewedItemCount, storeID: storeId, portalID: portalId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading">Item Name</td>';
                    headELements += '<td class="cssClassNormalHeading">Price</td>';
                    headELements += '<td class="cssClassNormalHeading">Number of View</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divMostViewedItemAdmindash").html(headELements);

                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr><td><label class="cssClassLabel">' + value.ItemTypeName + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.Price.toFixed(2) + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.ViewCount + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divMostViewedItemAdmindash").find('table>tbody').append(bodyElements);

                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divMostViewedItemAdmindash").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Most Viewed Items.</p>');
            }
        });
    }
</script>

<div id="divMostViewedItem" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="Most Viewed Item "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divMostViewedItemAdmindash">
            </div>
        </div>
    </div>
</div>