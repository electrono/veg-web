<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TotalStoreRevenue.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_TotalStoreRevenue" %>

<script type="text/javascript">
    var storeId = '<%= StoreID %>';
    var portalId = '<%= PortalID %>';

    $(document).ready(function() {
        GetTotalOrdererRevenueAdmindash();
    });

    function GetTotalOrdererRevenueAdmindash() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetTotalOrderAmountAdmindash",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading">Revenue</td>';
                    headELements += '<td class="cssClassNormalHeading">Tax</td>';
                    headELements += '<td class="cssClassNormalHeading">Shipping Cost</td>';
                    headELements += '<td class="cssClassNormalHeading">Quantity</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divTotalOrderRevenueAdmindash").html(headELements);

                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr><td><label class="cssClassLabel">' + value.Revenue.toFixed(2) + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.TaxTotal.toFixed(2) + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.ShippingCost.toFixed(2) + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.Quantity + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divTotalOrderRevenueAdmindash").find('table>tbody').append(bodyElements);

                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divTotalOrderRevenueAdmindash").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Total Store Revenue.</p>');
            }
        });
    }
</script>

<div id="divTotalRevenue" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="Total Order Revenue "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divTotalOrderRevenueAdmindash">
            </div>
        </div>
    </div>
</div>