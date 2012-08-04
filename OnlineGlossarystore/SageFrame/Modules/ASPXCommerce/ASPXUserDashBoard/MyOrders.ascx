<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MyOrders.ascx.cs" Inherits="Modules_ASPXUserDashBoard_MyOrders" %>

<script type="text/javascript">

    $(function() {
        LoadUserMyOrderStaticImage();
        GetMyOrders();
        OrderHideAll();
        $("#divTrackMyOrder").show();
        $("#divMyOrders").show();
        $("#lnkBack").bind("click", function() {
            OrderHideAll();
            $("#divTrackMyOrder").show();
            $("#divMyOrders").show();
        });

        $("#txtOrderID").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgOrderID").html("Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#btnGetOrderDetails").click(function() {
            var orderID = $.trim($("#txtOrderID").val());
            if (orderID == "") {
                alert("Please, Enter Your Order ID!");
            } else {

                GetAllOrderDetails(orderID);
            }
        });
    });

    function LoadUserMyOrderStaticImage() {
        $('#ajaxUserDashMyOrder').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function OrderHideAll() {
        $("#divMyOrders").hide();
        $("#divOrderDetails").hide();
        $("#divTrackMyOrder").hide();
    }

    function GetMyOrders() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvMyOrder_pagesize").length > 0) ? $("#gdvMyOrder_pagesize :selected").text() : 10;

        $("#gdvMyOrder").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetMyOrderList',
            colModel: [
                { display: 'OrderID', name: 'order_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Invoice Number', name: 'invoice_number', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'CustomerID', name: 'customerID', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Customer Name', name: 'customer_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Email', name: 'email', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Order Status', name: 'order_status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Grand Total', name: 'grand_total', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Payment Gateway Type Name', name: 'payment_gateway_typename', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Payment Method Name', name: 'payment_method_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Ordered Date', name: 'ordered_date', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'View', enable: true, _event: 'click', trigger: '1', callMethod: 'GetOrderDetails', arguments: '' }
            //{display: 'Re-Order', name: 'reOrder', enable: true, _event: 'click', trigger: '2', callMethod: 'GetCheckOutPage', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, CustomerID: customerId, CultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 10: { sorter: false } }
        });
    }

    function GetOrderDetails(tblID, argus) {
        switch (tblID) {
        case "gdvMyOrder":
            GetAllOrderDetails(argus[0]);
            break;
        }
    }

    function GetAllOrderDetails(argus) {
        var orderId = argus;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetMyOrders",
            data: JSON2.stringify({ orderID: orderId, storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var elements = '';
                    var tableElements = '';
                    var grandTotal = '';
                    var couponAmount = '';
                    var taxTotal = '';
                    var shippingCost = '';
                    var discountAmount = '';
                    $.each(msg.d, function(index, value) {
                        if (index < 1) {
                            var billAdd = '';
                            var arrBill;
                            arrBill = value.BillingAddress.split(',');
                            billAdd += '<li>' + arrBill[0] + ' ' + arrBill[1] + '</li>';
                            billAdd += '<li>' + arrBill[2] + '</li><li>' + arrBill[3] + '</li><li>' + arrBill[4] + '</li><li>' + arrBill[5] + '</li>';
                            billAdd += '<li>' + arrBill[6] + '</li><li>' + arrBill[7] + '</li>' + arrBill[8] + '<li>' + arrBill[9] + '</li><li>' + arrBill[10] + '</li><li>' + arrBill[11] + '</li><li>' + arrBill[12] + '</li>';
                            billAdd += '<li>' + arrBill[13] + '</li>';
                            $("#divOrderDetails").find('ul').html(billAdd);
                            $("#orderedDate").html(value.OrderedDate);
                            $("#paymentGatewayType").html(value.PaymentGatewayTypeName);
                            $("#paymentMethod").html(value.PaymentMethodName);
                        }
                        tableElements += '<tr>';
                        tableElements += '<td>' + value.ItemName + '<br/>' + value.CostVariants + '</td>';
                        tableElements += '<td>' + value.SKU + '</td>';
                        tableElements += '<td>' + value.ShippingAddress + '</td>';
                        tableElements += '<td><span class="cssClassFormatCurrency">' + value.ShippingRate.toFixed(2) + '</span></td>';
                        tableElements += '<td><span class="cssClassFormatCurrency">' + value.Price.toFixed(2) + '</span></td>';
                        tableElements += '<td>' + value.Quantity + '</td>';
                        tableElements += '<td><span class="cssClassFormatCurrency">' + (value.Price * value.Quantity).toFixed(2) + '</span></td>';
                        tableElements += '</tr>';
                        if (index == 0) {
                            taxTotal = '<tr>';
                            taxTotal += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Tax Total</td>';
                            taxTotal += '<td><span class="cssClassFormatCurrency">' + value.TaxTotal.toFixed(2) + '</span></td>';
                            taxTotal += '</tr>';
                            shippingCost = '<tr>';
                            shippingCost += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Shipping Cost</td>';
                            shippingCost += '<td><span class="cssClassFormatCurrency">' + value.ShippingRate.toFixed(2) + '</span></td>';
                            shippingCost += '</tr>';
                            discountAmount = '<tr>';
                            discountAmount += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Discount Amount</td>';
                            discountAmount += '<td><span class="cssClassFormatCurrency">' + value.DiscountAmount.toFixed(2) + '</span></td>';
                            discountAmount += '</tr>';
                            couponAmount = '<tr>';
                            couponAmount += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Coupon Amount</td>';
                            couponAmount += '<td><span class="cssClassFormatCurrency">' + value.CouponAmount.toFixed(2) + '</span></td>';
                            couponAmount += '</tr>';
                            grandTotal = '<tr>';
                            grandTotal += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Grand Total</td>';
                            grandTotal += '<td><span class="cssClassFormatCurrency">' + value.GrandTotal.toFixed(2) + '</span></td>';
                            grandTotal += '</tr>';
                        }

                    });

                    $("#divOrderDetails").find('table>tbody').html(tableElements);
                    $("#divOrderDetails").find('table>tbody').append(taxTotal);
                    $("#divOrderDetails").find('table>tbody').append(shippingCost);
                    $("#divOrderDetails").find('table>tbody').append(discountAmount);
                    $("#divOrderDetails").find('table>tbody').append(couponAmount);
                    $("#divOrderDetails").find('table>tbody').append(grandTotal);
                    OrderHideAll();
                    $("#divOrderDetails").show();
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                } else {
                    alert("Invalid OrderID!!!!");
                    $("#txtOrderID").val('');
                    return false;
                }
            },
            error: function() {
                alert("Order details error");
            }
        });
    }

    function GetCheckOutPage(tdlID, argus) {
        switch (tdlID) {
        case "gdvMyOrder":
                //TODO:: Reorder SP [dbo].[usp_ASPX_GetReOrderItems] call and redirect too checkoutpage.aspx;
            break;
        }
    }
</script>

<div id="divTrackMyOrder" class="cssClassSearchPanel cssClassFormWrapper">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td class="style2">
                <label class="cssClassLabel">
                    Order ID #:
                </label>
                <input type="text" id="txtOrderID" class="cssClassTextBoxSmall" /><span id="errmsgOrderID"></span>
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnGetOrderDetails">
                            <span><span>GO</span></span></button>
                    </p>
                </div>
            </td>
        </tr>
    </table>
</div>
<div id="divMyOrders">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="My Orders"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
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
                    <img id="ajaxUserDashMyOrder" />
                </div>
                <div class="log">
                </div>
                <table id="gdvMyOrder" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divOrderDetails" class="cssClassFormWrapper">
    <span class="cssClassLabel">Ordered Date: </span><span id="orderedDate"></span>
    <ul>
    </ul>
    <span class="cssClassLabel">PaymentGateway Type: </span><span id="paymentGatewayType"></span>
    <br />
    <span class="cssClassLabel">Payment Method: </span><span id="paymentMethod"></span>
    <br />
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                Ordered Items:</h2>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <thead>
                        <tr class="cssClassHeading">
                            <td class="header">
                                Item Name
                            </td>
                            <td class="header">
                                SKU
                            </td>
                            <td class="header">
                                Shipping Address
                            </td>
                            <td class="header">
                                Shipping Rate
                            </td>
                            <td class="header">
                                Price
                            </td>
                            <td class="header">
                                Quantity
                            </td>
                            <td class="header">
                                SubTotal
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <a href="#" id="lnkBack" class="cssClassBack">Go back</a>
</div>