<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LatestFiveOrderItems.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_LatestFiveOrderItems" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var latestOrderItemCount = 5;

    $(document).ready(function() {
        GetLatestOrderItems();
    });

    function GetLatestOrderItems() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetLatestOrderItems",
            data: JSON2.stringify({ count: latestOrderItemCount, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {

                if (msg.d.length > 0) {

                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading">'; //<td class="cssClassNormalHeading">OrderID</td>';
                    headELements += '<td class="cssClassNormalHeading">Customer Name</td>';
                    headELements += '<td class="cssClassNormalHeading">Ordered Date</td>';
                    headELements += '<td class="cssClassNormalHeading">Grand Total</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divLatestOrderStatics").html(headELements);

                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr>'; //<td><label class="cssClassLabel">' + value.OrderID + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.FirstName + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.AddedOn + '</label>';
                        bodyElements += '<td><label class="cssClassLabel">' + (value.GrandTotal).toFixed(2) + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divLatestOrderStatics").find('table>tbody').append(bodyElements);

                    $(" .classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divLatestOrderStatics").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Latest Ordered Items.</p>');
            }
        });
    }
</script>

<div id="divLatestOrderStaticsByCustomer" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="List of Latest Orders"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divLatestOrderStatics">
            </div>
        </div>
    </div>
</div>