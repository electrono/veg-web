<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderOverViews.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_OrderOverViews" %>

<script type="text/javascript">
    var storeId = '<%= StoreID %>';
    var portalId = '<%= PortalID %>';
    var StaticOrderStatusCount = 10;

    $(document).ready(function() {
        GetStaticOrderStatusAdminDash();
    });

    function GetStaticOrderStatusAdminDash() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStaticOrderStatusAdminDash",
            data: JSON2.stringify({ count: StaticOrderStatusCount, storeID: storeId, portalID: portalId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper" width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '';
                    headELements += '<tr class="cssClassHeading"><td >Status Name</td>';
                    headELements += '<td >This Day</td>';
                    headELements += '<td >This Week</td>';
                    headELements += '<td >This Month</td>';
                    headELements += '<td >This Year</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divStaticOrderStatusAdmindash").html(headELements);

                    $.each(msg.d, function(index, value) {

                        var last = msg.d.length;
                        if (index != last - 1) {
                            bodyElements += '<tr ><td><label class="cssClassLabel">' + value.StatusName + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisDay + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisWeek + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisMonth + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisYear + '</label>';
                            bodyElements += '</tr>';
                        } else {
                            bodyElements += '<tr ><td><label class="cssClassLabel">' + value.StatusName + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisDay.toFixed(2) + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisWeek.toFixed(2) + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisMonth.toFixed(2) + '</label></td>';
                            bodyElements += '<td><label class="cssClassLabel">' + value.ThisYear.toFixed(2) + '</label>';
                            bodyElements += '</tr>';
                        }
                    });

                    $("#divStaticOrderStatusAdmindash").find('table>tbody').append(bodyElements);
                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divStaticOrderStatusAdmindash").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Order Overview.</p>');
            }
        });
    }
</script>

<div id="divOrderStatus" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="Order Status OverView "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divStaticOrderStatusAdmindash">
            </div>
        </div>
    </div>
</div>