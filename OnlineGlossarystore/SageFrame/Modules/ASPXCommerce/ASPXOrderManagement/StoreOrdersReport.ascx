<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreOrdersReport.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXOrderManagement_StoreOrdersReport" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var senderEmail = '<%= senderEmail %>';
    var msgbody = '';

    $(document).ready(function() {
        HideAll();
        LoadStoreReportStaticImage();
        $("#divOrderDetails").show();
        BindOrderDetails(null, null);
        GetOrderStatus();
        $("#btnExportToCSV").click(function() {
            $('#gdvOrderDetails').table2CSV();
        });
        $("#btnBack").click(function() {
            HideAll();
            $("#divOrderDetails").show();
        });
        $("#btnSPBack").click(function() {
            HideAll();
            $("#divOrderDetails").show();
        });
    });

    function LoadStoreReportStaticImage() {
        $('#ajaxStoreOrderReportImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAll() {
        $("#divOrderDetails").hide();
        $("#divOrderDetailForm").hide();
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvOrderDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvOrderDetails tbody tr");
        // var table = $("#Export1_lblTitle").text();
        var table = '<table>';
        table += header;
        $.each(data, function(index, item) {
            var cells = $(this).find("td");
            var td = "";
            $.each(cells, function(i, itm) {
                if ($(this).is(':visible')) {
                    if ($(this).find("div").hasClass("cssClassActionOnClick")) {
                        //do not add
                    } else {
                        td += '<td>' + $(this).text() + '</td>';
                    }
                }
            });
            table += '<tr>' + td + '</tr>';
        });

        table += '</tr></table>';
        table = $.trim(table);
        table = table.replace( />/g , '&gt;');
        table = table.replace( /</g , '&lt;');
        $("input[id$='HdnValue']").val(table);
    }

    function BindOrderDetails(customerNm, orderStatusType) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvOrderDetails_pagesize").length > 0) ? $("#gdvOrderDetails_pagesize :selected").text() : 10;

        $("#gdvOrderDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetOrderDetails',
            colModel: [
                { display: 'OrderID', name: 'order_id', cssclass: 'cssClassHeadNumber', coltype: 'label', align: 'left' },
                { display: 'Invoice Number', name: 'invoice_number', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'CustomerID', name: 'customerID', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Customer Name', name: 'customer_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Email', name: 'email', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Order Status', name: 'order_status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Grand Total', name: 'grand_total', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Payment Gateway Type Name', name: 'payment_gateway_typename', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Payment Method Name', name: 'payment_method_name', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Ordered Date', name: 'ordered_date', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'View', name: 'view', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewOrders' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, cultureName: cultureName, orderStatusName: orderStatusType, userName: customerNm },
            current: current_,
            pnew: offset_,
            sortcol: { 10: { sorter: false } }
        });
    }

    function ViewOrders(tblID, argus) {
        switch (tblID) {
        case "gdvOrderDetails":
            HideAll();
            $("#<%= lblOrderForm.ClientID %>").html("Order ID: #" + argus[0]);
            $("#divOrderDetailForm").show();
            BindAllOrderDetailsForm(argus[0]);
            break;
        default:
            break;
        }
    }

    function getItemInvoiceDetail(orderId) {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, orderID: orderId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetInvoiceDetailsByOrderID",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, orderID: orderId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var span = '';
                var span1 = '';
                var orderID = 0;
                if (msg.d.length > 0) {

                    $.each(msg.d, function(index, item) {
                        if (index == 0) {
                            var greet = '<tr style="background-color:#f4f6f8 ;text-align:left;"><td>Dear ';
                            greet += '  ' + $('#customerNameEdit').html() + '<br />';
                            greet += 'This is to inform you that your order  has been ' + item.OrderStatusName + '. </td></tr>';

                            msgbody = '<table width="100%" cellspacing="0" cellpadding="0" border="0" style="min-height:100%;background-color:#f4f6f8;font:12px Arial, Helvetica, sans-serif;"><tbody><tr>';
                            msgbody += '<td align="center" style="width:100%;min-height:100%"><table cellspacing="0" cellpadding="0" border="0" style="width:700px;table-layout:fixed;margin:24px 0 24px 0">';
                            msgbody += '<tbody sytle="border:1px solid #e6e6e6;">' + greet + '<tr><td style="background-color:#ffffff;margin:0px auto 0px auto;padding:0px 44px 0px 46px;text-align:left">';
                            msgbody += '<table width="100%" cellspacing="0" cellpadding="0" border="0" style="padding:27px 0px 0px 0px;border-bottom:1px solid #868686;margin-bottom:8px">';
                            msgbody += '<tbody><tr><td valign="middle" align="left" style="padding-bottom:3px"><img src="http://www.aspxcommerce.com/Templates/ASPXCommerce/images/aspxcommerce.png" width="143" height="62"  alt="ASPxCommerce"></td>';
                            msgbody += '<td width="100%" valign="bottom" style="text-align:right;font:bold 26px Arial;text-transform:uppercase;margin:0px">Invoice: ';
                            msgbody += ' </td></tr></tbody></table><table width="100%" cellspacing="0" cellpadding="0" border="0"  ><tbody><tr valign="top"><td style="width:50%;padding:35px 0px 0px 2px;font-size:12px;font-family:Arial">';
                            msgbody += '<table cellspacing="0" cellpadding="0" border="0"><tbody><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Store Name:</td><td width="100%" style="font-size:12px;font-family:Arial;">';
                            msgbody += '' + item.StoreName + '';
                            msgbody += '</td></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Store Description:</td><td width="100%" style="font-size:12px;font-family:Arial;"> ';
                            msgbody += ' ' + item.StoreDescription + ' ';
                            msgbody += '</td></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Customer Name:</td><td width="100%" style="font-size:12px;font-family:Arial">';
                            msgbody += ' ' + $('#customerNameEdit').html() + '';
                            msgbody += '</td></tr></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;"></td><td width="100%" style="font-size:12px;font-family:Arial"> ';
                            // msgbody += 'info@sageframe.com';
                            msgbody += '</td></tr></tbody></table></td><td style="width:50%;padding:14px 0px 0px 2px;font-size:12px;font-family:Arial"><h2 style="font:bold 17px Tahoma;margin:0px">';
                            msgbody += 'Order#' + item.OrderID + '';
                            msgbody += '</h2><table cellspacing="0" cellpadding="0" border="0"><tbody><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Status:</td><td width="100%" style="font-size:12px;font-family:Arial;font-weight:bold;">';
                            msgbody += '' + item.OrderStatusName + '';
                            msgbody += '</td></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Date:</td><td style="font-size:12px;font-family:Arial">';
                            msgbody += '10/21/2011, 09:03';
                            msgbody += '</td></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Payment method:</td><td style="font-size:12px;font-family:Arial">';
                            msgbody += '' + item.PaymentMethodName + '';
                            msgbody += '</td></tr><tr valign="top"><td style="font-size:12px;font-family:verdana, helvetica, arial, sans-serif;text-transform:uppercase;color:#000000;padding-right:10px;white-space:nowrap;font-weight:bold;">Shipping method:</td><td style="font-size:12px;font-family:Arial">';

                            if (item.IsMultipleShipping != true) {
                                msgbody += item.ShippingMethodName;
                            } else {
                                msgbody += 'Multiple Shipping Exist';
                            }

                            msgbody += '</tr></tbody></table></td></tr></tbody></table></td></tr><tr><td style="background-color:#ffffff;margin:0px auto 0px auto ;" ><table style="padding-left:50px;" width="100% cellspacing="0" cellpadding="0" border="0" >';


                            span = "<br/> <b>Billing To: </b>";
                            if (item.BillingName != "")
                                span += "<br/>" + item.BillingName;

                            if (item.Address1 != "")
                                span += ",<br/>" + item.Address1;

                            if (item.Address2 != "")
                                span += ",<br/>" + item.Address2;

                            if (item.Company != "")
                                span += ",<br/>" + item.Company;

                            if (item.City != "")
                                span += ",<br/>" + item.City;

                            if (item.State != "")
                                span += ", " + item.State;

                            if (item.Zip != "")
                                span += ",<br/>" + item.Zip;

                            if (item.Country != "")
                                span += ",<br/>" + item.Country;

                            if (item.Email != "")
                                span += ",<br/>" + item.Email;

                            if (item.Phone != "")
                                span += ",<br/>" + item.Phone;

                            if (item.Mobile != "")
                                span += ", " + item.Mobile;

                            if (item.Fax != "")
                                span += ",<br/>" + item.Fax;

                            if (item.Website != "")
                                span += ",<br/>" + item.Website;

                            if (item.IsMultipleShipping != true) {
                                span1 = "<br/> <b>Shipping To: </b>";
                                if (item.ShippingName != "")
                                    span1 += "<br/>" + item.ShippingName;

                                if (item.shipAddress1 != "")
                                    span1 += ",<br/>" + item.shipAddress1;

                                if (item.shipAddress2 != "")
                                    span1 += ", <br/>" + item.shipAddress2;

                                if (item.ShipCompany != "")
                                    span1 += ",<br/>" + item.ShipCompany;

                                if (item.shipCity != "")
                                    span1 += ",<br/>" + item.shipCity;

                                if (item.shipState != "")
                                    span1 += "," + item.shipState;

                                if (item.shipZip != "")
                                    span1 += ",<br/>" + item.shipZip;

                                if (item.ShipCountry != "")
                                    span1 += ",<br/>" + item.ShipCountry;

                                if (item.ShipEmail != "")
                                    span1 += ",<br/>" + item.ShipEmail;

                                if (item.shipPhone != "")
                                    span1 += ",<br/>" + item.shipPhone;

                                if (item.shipMobile != "")
                                    span1 += ", " + item.shipMobile;

                                if (item.shipFax != "")
                                    span1 += ",<br/>" + item.shipFax;

                                if (item.shipWebsite != "")
                                    span1 += ",<br/>" + item.shipWebsite;

                                var itemOrderDetails = '<table style="border:1px solid #e6e6e6;" width="80%" border="0" cellspacing="1" cellpadding="0" ><thead><tr ><th width="55%" style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>Item Name</b></th><th width="15%" style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>Price</b></th><th width="15%" style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial"  ><b>Quantity</b></th><th width="15%" style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>SubTotal</b></th></td></tr></thead><tbody>';

                                $.each(msg.d, function(index, item) {
                                    itemOrderDetails += "<tr><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.ItemName + " (" + item.CostVariants + ")" + "</td>";
                                    itemOrderDetails += "<td  style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>" + item.Price.toFixed(2) + "</td>";
                                    itemOrderDetails += "<td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.Quantity + "</td>";
                                    itemOrderDetails += "<td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.SubTotal.toFixed(2) + "</td></tr>";
                                });
                                if (index == 0) {
                                    itemOrderDetails += "<br/><tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>SubTotal</td>";
                                    itemOrderDetails += " <td>" + item.GrandSubTotal.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Taxes </td>";
                                    itemOrderDetails += " <td>" + item.TaxTotal.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Shipping Cost </td>";
                                    itemOrderDetails += " <td>" + item.ShippingCost.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Discount</td>";
                                    itemOrderDetails += " <td>" + item.DiscountAmount.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Coupon </td>";
                                    itemOrderDetails += " <td>" + item.CouponAmount.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Total Cost </td>";
                                    itemOrderDetails += " <td>" + item.GrandTotal.toFixed(2) + "</td></tr>";
                                }
                                itemOrderDetails += '</tbody></table>';
                            } else {
                                var itemOrderDetails = '<table style="border:1px solid #e6e6e6;" width="80%" border="0" cellspacing="1" cellpadding="0"><thead><tr  width="70%" style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><th><b>ItemName</b></th><th style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>Price</b></th><th style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial"  ><b>Quantity</b></th><th style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>Shipping Method</b></th><th style="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>Shipping To</b></th><thstyle="background-color:#eeeeee;padding:6px 10px;white-space:nowrap;font-size:12px;font-family:Arial" ><b>SubTotal</b></th></td></tr></thead><tbody>';

                                $.each(msg.d, function(index, item) {
                                    itemOrderDetails += "<tr><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.ItemName + "</td>";
                                    itemOrderDetails += "<td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.Price.toFixed(2) + "</td>";
                                    itemOrderDetails += "<td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>" + item.Quantity + "</td>";
                                    itemOrderDetails += "<td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.ShippingMethodName + "</td>";
                                    var shippingDetails = "";
                                    if (item.ShippingName != "")
                                        shippingDetails += "<br/>" + item.ShippingName;

                                    if (item.shipAddress1 != "")
                                        shippingDetails += ",<br/>" + item.shipAddress1;

                                    if (item.shipAddress2 != "")
                                        shippingDetails += "," + item.shipAddress2;

                                    if (item.ShipCompany != "")
                                        shippingDetails += ",<br/>" + item.ShipCompany;

                                    if (item.shipCity != "")
                                        shippingDetails += ",<br/>" + item.shipCity;

                                    if (item.shipState != "")
                                        shippingDetails += "," + item.shipState;

                                    if (item.shipZip != "")
                                        shippingDetails += ",<br/>" + item.shipZip;

                                    if (item.ShipCountry != "")
                                        shippingDetails += ",<br/>" + item.ShipCountry;

                                    if (item.ShipEmail != "")
                                        shippingDetails += ",<br/>" + item.ShipEmail;

                                    if (item.shipPhone != "")
                                        shippingDetails += ",<br/>" + item.shipPhone;

                                    if (item.shipMobile != "")
                                        shippingDetails += ", " + item.shipMobile;

                                    if (item.shipFax != "")
                                        shippingDetails += ",<br/>" + item.shipFax;

                                    if (item.shipWebsite != "")
                                        shippingDetails += ",<br/>" + item.shipWebsite;

                                    itemOrderDetails += "<td>" + shippingDetails + "</td>";
                                    itemOrderDetails += "<td>" + item.SubTotal.toFixed(2) + "</td></tr>";
                                });

                                if (index == 0) {
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>SubTotal</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.GrandSubTotal.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Taxes</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.TaxTotal.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Shipping Cost</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.ShippingCost.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Discount</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.DiscountAmount.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Coupon</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;' >" + item.CouponAmount.toFixed(2) + "</td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: left; padding: 5px 10px; font-size: 12px;'>Total Cost</td>";
                                    itemOrderDetails += " <td style='background-color: rgb(255, 255, 255); font-family: Arial; text-align: right; padding: 5px 10px; font-size: 12px;'>" + item.GrandTotal.toFixed(2) + "</td></tr>";
                                }
                                itemOrderDetails += '</tbody></table>';
                            }
                            msgbody += '<tr><td>' + span + '</td><td>' + span1 + '</td></tr>';
                            msgbody += '<tr><td colspan="2" >' + itemOrderDetails + '<br/>';
                            msgbody += '  <p style="font-family:Arial, Helvetica, sans-serif; font-size:12px; font-weight:normal; color:#000;">if you having Issues with your order or any further inquiry then you can mail<a style="color:#278ee6;" href="mailto:info@aspxcommerce.com">info@aspxcommerce.com</a></p>';
                            msgbody += '<p style="margin:0; padding:5px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;">Please do not reply to this email. This mail is automatic generated email.<br><br>Thank You,<br><span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;">AXPXCommerce Team </span></p><br/><br/><br/></td></tr></table></td></tr> </tbody></table></td></tr></tbody></table>';
                        }
                    });
                }
            },
            error: function() {
                alert("error");
                return false;
            }
        });
    }

    function BindAllOrderDetailsForm(argus) {
        var orderId = argus;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllOrderDetailsForView",
            data: JSON2.stringify({ orderId: orderId, storeId: storeId, portalId: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
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
                        billAdd += '<li><b><u>Billing Address:</u></b></li>';
                        billAdd += '<li>' + arrBill[0] + ' ' + arrBill[1] + '</li>';
                        billAdd += '<li>' + arrBill[2] + '</li><li>' + arrBill[3] + '</li><li>' + arrBill[4] + '</li><li>' + arrBill[5] + '</li>';
                        billAdd += '<li>' + arrBill[6] + '</li><li>' + arrBill[7] + '</li>' + arrBill[8] + '<li>' + arrBill[9] + '</li><li>' + arrBill[10] + '</li><li>' + arrBill[11] + '</li><li>' + arrBill[12] + '</li>';
                        billAdd += '<li>' + arrBill[13] + '</li>';
                        $("#divOrderDetailForm").find('ul').html(billAdd);
                        $("#OrderDate").html(value.OrderedDate);
                        $("#PaymentGatewayType").html(value.PaymentGatewayTypeName);
                        $("#PaymentMethod").html(value.PaymentMethodName);
                    }
                    tableElements += '<tr>';
                    tableElements += '<td>' + value.ItemName + '<br/>' + value.CostVariants + '</td>';
                    tableElements += '<td>' + value.SKU + '</td>';
                    tableElements += '<td>' + value.ShippingAddress + '</td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + value.ShippingRate.toFixed(2) + '</span></td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + value.Price.toFixed(2) + '</span></td>';
                    tableElements += '<td>' + value.Quantity + '</td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + (value.Price * value.Quantity).toFixed(2) + '</span></td>';
                    tableElements += '</tr>';
                    if (index == 0) {
                        taxTotal = '<tr>';
                        taxTotal += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Tax Total</td>';
                        taxTotal += '<td><span class="cssClassFormatCurrency" >' + value.TaxTotal.toFixed(2) + '</span></td>';
                        taxTotal += '</tr>';
                        shippingCost = '<tr>';
                        shippingCost += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Shipping Cost</td>';
                        shippingCost += '<td><span class="cssClassFormatCurrency" >' + value.ShippingCost.toFixed(2) + '</span></td>';
                        shippingCost += '</tr>';
                        discountAmount = '<tr>';
                        discountAmount += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Discount Amount</td>';
                        discountAmount += '<td><span class="cssClassFormatCurrency" >' + value.DiscountAmount.toFixed(2) + '</span></td>';
                        discountAmount += '</tr>';
                        couponAmount = '<tr>';
                        couponAmount += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Coupon Amount</td>';
                        couponAmount += '<td><span class="cssClassFormatCurrency" >' + value.CouponAmount.toFixed(2) + '</span></td>';
                        couponAmount += '</tr>';
                        grandTotal = '<tr>';
                        grandTotal += '<td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Grand Total</td>';
                        grandTotal += '<td><span class="cssClassFormatCurrency" >' + value.GrandTotal.toFixed(2) + '</span></td>';
                        grandTotal += '</tr>';
                    }
                });
                $("#divOrderDetailForm").find('table>tbody').html(tableElements);
                $("#divOrderDetailForm").find('table>tbody').append(taxTotal);
                $("#divOrderDetailForm").find('table>tbody').append(shippingCost);
                $("#divOrderDetailForm").find('table>tbody').append(discountAmount);
                $("#divOrderDetailForm").find('table>tbody').append(couponAmount);
                $("#divOrderDetailForm").find('table>tbody').append(grandTotal);
                $("#divOrderDetailForm").find("table>tbody tr:even").addClass("cssClassAlternativeEven");
                $("#divOrderDetailForm").find("table>tbody tr:odd").addClass("cssClassAlternativeOdd");
                HideAll();
                $("#divOrderDetailForm").show();
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + 'en-US' + '' });
            },
            error: function() {
                alert("Order details error");
            }
        });
    }

    function GetOrderStatus() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStatusList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    var couponStatusElements = "<option value=" + item.OrderStatusID + ">" + item.OrderStatusName + "</option>";
                    $("#ddlOrderStatus").append(couponStatusElements);
                    $("#selectStatus").append(couponStatusElements);
                });
            },
            error: function() {
                alert("error");
            }
        });
    }

    function SearchOrders() {
        var customerNm = $.trim($("#txtCustomerName").val());
        var orderStatusType = '';
        if (customerNm.length < 1) {
            customerNm = null;
        }
        if ($("#ddlOrderStatus").val() == "0") {
            orderStatusType = null;
        } else {
            orderStatusType = $("#ddlOrderStatus option:selected").text();
        }
        BindOrderDetails(customerNm, orderStatusType);
    }
</script>

<div id="divOrderDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderHeading" runat="server" Text="Orders"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportToExcel" class="cssClassButtonSubmit" runat="server" OnClick="Button1_Click"
                                    Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
                    </p>
                    <p>
                        <button type="button" id="btnExportToCSV">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Customer Name:</label>
                                <input type="text" id="txtCustomerName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Order Status:</label>
                                <select id="ddlOrderStatus" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchOrders() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxStoreOrderReportImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvOrderDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div class="cssClassFormWrapper Curve" id="divOrderDetailForm">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblOrderForm" runat="server"></asp:Label>
        </h2>
    </div>
    <span class="cssClassLabel">Ordered Date: </span><span id="OrderDate"></span>
    <ul>
    </ul>
    <span class="cssClassLabel">Payment Gateway Type: </span><span id="PaymentGatewayType">
                                                             </span>
    <br />
    <span class="cssClassLabel">Payment Method: </span><span id="PaymentMethod"></span>
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
                            <td >
                                Item Name
                            </td>
                            <td >
                                SKU
                            </td>
                            <td >
                                Shipping Address
                            </td>
                            <td >
                                Shipping Rate
                            </td>
                            <td >
                                Price
                            </td>
                            <td >
                                Quantity
                            </td>
                            <td >
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
    <div class="cssClassButtonWrapper">
        <p>
            <button type="button" id="btnBack">
                <span><span>Back</span></span></button>
        </p>
    </div>
</div>