<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TopCutomersByOrder.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_TopCutomersByOrder" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var TopCustomerOrderCount = 5;

    $(document).ready(function() {
        GetTopCustomerOrdererAdmindash();
    });

    function GetTopCustomerOrdererAdmindash() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetTopCustomerOrderAdmindash",
            data: JSON2.stringify({ count: TopCustomerOrderCount, storeID: storeId, portalID: portalId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading">Customer Name</td>';
                    headELements += '<td class="cssClassNormalHeading">Number of Order</td>';
                    headELements += '<td class="cssClassNormalHeading">Average Order Amount</td>';
                    headELements += '<td class="cssClassNormalHeading">Total Order Amount</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divTopCustomerOrderAdmindash").html(headELements);

                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr><td><label class="cssClassLabel">' + value.CustomerName + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.NumberOfOrder + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.AverageOrderAmount.toFixed(2) + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.TotalOrderAmount.toFixed(2) + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divTopCustomerOrderAdmindash").find('table>tbody').append(bodyElements);

                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divTopCustomerOrderAdmindash").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Top Customers.</p>');
            }
        });
    }
</script>

<div id="divTopCustoerByOrder" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="Top Customer By Order "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divTopCustomerOrderAdmindash">
            </div>
        </div>
    </div>
</div>