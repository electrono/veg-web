<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InvoiceManagement.ascx.cs"
            Inherits="Modules_ASPXInvoiceManagement_InvoiceManagement" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var customerEmail = '';

    $(document).ready(function() {
        LoadInvoiceAjaxStaticImage();
        BindInvoiceInformation(null, null, null);
        GetInvoiceStatus();
        HideAll();
        $("#btnExportToCSV").click(function() {
            $('#gdvInvoiceDetails').table2CSV();
        });
        $('#divOrderDetails').show();

        $("#btnBack").click(function() {
            HideAll();
            $('#divOrderDetails').show();
            ClearInvoiceForm();
        });
        $('#btnPrint').click(function() {
            printPage();
        });
    });

    function LoadInvoiceAjaxStaticImage() {
        $('#ajaxInvoiceMgmtImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAll() {
        $('#divOrderDetails').hide();
        $('#divInvoiceForm').hide();
    }

    function ClearInvoiceForm() {
        $('#spanInvoiceNo').html('');
        $('#spanInvoiceDate').html('');
        $("#spanCustomerName").html('');
        $("#spanCustomerEmail").html('');
        $("#spanOrderID").html('');
        $("#spanOrderDate").html('');
        $("#spanOrderStatus").html('');
        $("#spanPaymentMethod").html('');
        $("#spanShippingMethod").html('');
        $("#divBillingAddressInfo").html('');
        $("#divShippingAddressInfo").html('');
        $('#divOrderItemDetails>table').empty();
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvInvoiceDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvInvoiceDetails tbody tr");
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

    function BindInvoiceInformation(invoiceNum, billToNm, statusType) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvInvoiceDetails_pagesize").length > 0) ? $("#gdvInvoiceDetails_pagesize :selected").text() : 10;

        $("#gdvInvoiceDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetInvoiceDetailsList',
            colModel: [
                { display: 'Invoice No.', name: 'invoice_number', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', url: '', queryPairs: '' },
                { display: 'Invoice Date', name: 'invoice_date', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Order ID', name: 'order_id', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'link', align: 'left', url: '', queryPairs: '' },
                { display: 'CustomeName', name: 'CustomerName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Order Date', name: 'order_date', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Bill to Name', name: 'bill_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Ship to Name', name: 'ship_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Status', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Amount', name: 'amount', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'CustomeEmail', name: 'CustomerEmail', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
            //{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditAttributes', arguments: '1,5' },
            //{display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteAttributes', arguments: '' },
                { display: 'View', name: 'view Invoice', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewAttributes', arguments: '1,2,3,4,5,6,7,8,9' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { invoiceNumber: invoiceNum, billToNama: billToNm, status: statusType, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 10: { sorter: false } }
        });
    }

    function ViewAttributes(tblID, argus) {
        switch (tblID) {
        case "gdvInvoiceDetails":
                //  alert(argus);
            customerEmail = argus[11];
            $("#<%= lblInvoiceForm.ClientID %>").html("Invoice Number: #" + argus[0]);
            $('#divOrderDetails').hide();
            $('#divInvoiceForm').show();
            $('#spanInvoiceNo').html(argus[0]);
            $('#spanInvoiceDate').html(argus[3]);
            $("#spanCustomerName").html(argus[5]);
            $("#spanCustomerEmail").html(argus[11]);
            getItemInvoiceDetail(argus[4]);

            break;
        default:
            break;
        }
    }

    function getItemInvoiceDetail(orderId) {
        var param = JSON2.stringify({ orderID: orderId, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetInvoiceDetailsByOrderID",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var span = '';
                var span1 = '';
                var orderID = 0;
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        if (index == 0) {
                            $("#spanOrderID").html(item.OrderID);
                            $("#spanOrderDate").html(item.OrderDate);
                            $("#spanOrderStatus").html(item.OrderStatusName);
                            $("#spanPaymentMethod").html(item.PaymentMethodName);

                            if (item.IsMultipleShipping != true) {
                                if (item.ShippingMethodName != '') {
                                    $("#spanShippingMethod").html(item.ShippingMethodName);
                                } else {
                                    $("#spanShippingMethod").html("Downloadable Items don't need Shipping Method");
                                }
                            } else {
                                $('#spanShippingMethod').html('Multiple Shipping Exist');
                            }

                            $("#spanStoreName").html(item.StoreName);
                            $("#spanStoreDescription").html(item.StoreDescription);

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
                                if (item.ShippingName != '') {
                                    span1 = "<br/> <b>Shipping To: </b>";
                                } else {
                                    span1 = "<br/><b>Shipping Address do not needed for Downloadable Items</b>";
                                }
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

                                var itemOrderDetails = '<br/><table width="100%" border="0" cellspacing="0" cellpadding="0" class="OrderDetailsTable"><thead><tr align="left" class="cssClassLabel"><th><b>Item Name</b></th><th><b>Price</b></th><th><b>Quantity</b></th><th><b>SubTotal</b></th></td></tr></thead><tbody>';
                                $.each(msg.d, function(index, item) {
                                    if (item.CostVariants == "") {
                                        itemOrderDetails += "<tr><td>" + item.ItemName + "</td>";
                                        itemOrderDetails += "<td><span class='cssClassFormatCurrency' >" + item.Price.toFixed(2) + "</span></td>";
                                        itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                        itemOrderDetails += "<td><span class='cssClassFormatCurrency' >" + item.SubTotal.toFixed(2) + "</span></td></tr>";
                                    } else {
                                        itemOrderDetails += "<tr><td>" + item.ItemName + " (" + item.CostVariants + ")" + "</td>";
                                        itemOrderDetails += "<td><span class='cssClassFormatCurrency' >" + item.Price.toFixed(2) + "</td>";
                                        itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                        itemOrderDetails += "<td><span class='cssClassFormatCurrency' >" + item.SubTotal.toFixed(2) + "</span></td></tr>";
                                    }
                                });
                                if (index == 0) {
                                    itemOrderDetails += "<br/><tr><td></td><td></td><td class='cssClassLabel'>SubTotal</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.GrandSubTotal.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td class='cssClassLabel'>Taxes </td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.TaxTotal.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td class='cssClassLabel'>Shipping Cost </td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.ShippingCost.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td class='cssClassLabel'>Discount Amount</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.DiscountAmount.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td class='cssClassLabel'>Coupon Amount </td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.CouponAmount.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td class='cssClassLabel'>Total Cost </td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.GrandTotal.toFixed(2) + "</span></td></tr>";
                                }
                                itemOrderDetails += '</tbody></table>';
                            } else {
                                var itemOrderDetails = '<table class="classTableWrapper" width="100%" border="0" cellspacing="0" cellpadding="0"><thead><tr align="left" class="cssClassLabel"><th><b>ItemName</b></th><th><b>Price</b></th><th><b>Quantity</b></th><th><b>Shipping Method</b></th><th><b>Shipping To</b></th><th><b>SubTotal</b></th></td></tr></thead><tbody>';
                                $.each(msg.d, function(index, item) {

                                    if (item.CostVariants == "") {
                                        itemOrderDetails += "<tr><td>" + item.ItemName + "</td>";
                                        itemOrderDetails += "<td>" + item.Price.toFixed(2) + "</td>";
                                        itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                        itemOrderDetails += "<td>" + item.ShippingMethodName + "</td>";
                                    } else {

                                        itemOrderDetails += "<tr><td>" + item.ItemName + " (" + item.CostVariants + ")" + "</td>";
                                        itemOrderDetails += "<td>" + item.Price.toFixed(2) + "</td>";
                                        itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                        itemOrderDetails += "<td>" + item.ShippingMethodName + "</td>";
                                    }


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
                                    itemOrderDetails += "<td><span class='cssClassFormatCurrency' >" + item.SubTotal.toFixed(2) + "</span></td></tr>";
                                });

                                if (index == 0) {
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>SubTotal</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.GrandSubTotal.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>Taxes</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.TaxTotal.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>Shipping Cost</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.ShippingCost.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>Discount</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.DiscountAmount.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>Coupon</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.CouponAmount.toFixed(2) + "</span></td></tr>";
                                    itemOrderDetails += "<tr><td></td><td></td><td></td><td></td><td class='cssClassLabel'>Total Cost</td>";
                                    itemOrderDetails += " <td><span class='cssClassFormatCurrency' >" + item.GrandTotal.toFixed(2) + "</span></td></tr>";
                                }
                                itemOrderDetails += '</tbody></table>';
                            }
                            $("#divOrderItemDetails").html(itemOrderDetails);
                            $(".OrderDetailsTable>tbody tr:even").addClass("cssClassAlternativeEven");
                            $(".OrderDetailsTable>tbody tr:odd").addClass("cssClassAlternativeOdd");
                        }

                        $("#divOrderDetailForm").show();
                    });
                    $("#divBillingAddressInfo").html(span);
                    $("#divShippingAddressInfo").html(span1);
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + 'en-US' + '' });

                } else {
                    csscody.alert("<h1>Information</h1><p>No Invoice is Available for this Order</p>");
                    $('#divOrderDetails').show();
                    $('#divInvoiceForm').hide();
                }
            },
            error: function() {
                alert("error");
            }
        });
    }

    function GetInvoiceStatus() {

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStatusList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    var couponStatusElements = "<option value=" + item.OrderStatusID + ">" + item.OrderStatusName + "</option>";
                    $("#ddlStatus").append(couponStatusElements);
                });
            },
            error: function() {
                alert("error");
            }
        });
    }

    function SearchInvoices() {
        var invoiceNum = $.trim($("#txtInvoiceNumber").val());
        //var orderID = trim($("#txtOrderID").val());
        var billToNm = $.trim($("#txtbillToName").val());
        var statusType = '';
        if (invoiceNum.length < 1) {
            invoiceNum = null;
        }
        if ($("#ddlStatus").val() != "0") {
            statusType = $.trim($("#ddlStatus").val());
        } else {
            statusType = null;
        }
        if (billToNm.length < 1) {
            billToNm = null;
        }
        BindInvoiceInformation(invoiceNum, billToNm, statusType);
    }

    function PrintInvoiceForm() {
        var divContent = $('#divPrintInvoiceForm').html();
        $("input[id$='HdnValue']").val(divContent);
    }

    function printPage() {
        window.print();
//        var content = $('#divPrintInvoiceForm').html();
//        var pwin = window.open('', 'print_content', 'width=100,height=100');
//        pwin.document.open();
//        pwin.document.write('<html><head><title></title></head><body onload="window.print()">' + content + '</body></html>');      
//        pwin.document.close();
//        setTimeout(function() { pwin.close(); }, 1000);
    }
</script>

<div id="divOrderDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderHeading" runat="server" Text="Invoices"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <%--<p>                        
                        <asp:Button ID="btnSavePdf" class="cssClassButtonSubmit" runat="server" Text="Save As Pdf" OnClick="btnSavePdf_Click"
                            OnClientClick="ExportDivDataToExcel()" />
                    </p>--%>
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
                                    Invoice Number: </label>
                                <input type="text" id="txtInvoiceNumber" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Bill To Name: </label>
                                <input type="text" id="txtbillToName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Status: </label>
                                <select id="ddlStatus" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchInvoices() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxInvoiceMgmtImageLoad" />
                </div>
                <div class="log">
                </div>
                <table id="gdvInvoiceDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<%--Invoice Form --%>
<div id="divInvoiceForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInvoiceForm" runat="server"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnSavePDFForm2" runat="server" Text="Save As Pdf" OnClick="btnSavePDFForm2_Click"
                                    OnClientClick="PrintInvoiceForm()" CssClass="cssClassButtonSubmit" />
                    </p>
                    <p>
                        <button type="button" id="btnPrint">
                            <span><span>Print</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div id="divPrintInvoiceForm" class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td>
                        <div>
                            <div>
                                <asp:Label ID="lblInvoiceDate" runat="server" Text="Invoice Date: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                             id="spanInvoiceDate"></span></div>
                            <div>
                                <asp:Label ID="lblInvoiceNo" runat="server" Text="Invoice No: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                         id="spanInvoiceNo"></span>
                            </div>
                        </div>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <div>
                                <asp:Label ID="lblStoreName" runat="server" Text="Store Name: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                         id="spanStoreName"></span></div>
                            <div>
                                <asp:Label ID="lblStoreDescription" runat="server" Text="Store Description: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                       id="spanStoreDescription"></span></div>
                            <div>
                                <asp:Label ID="lblCustomerName" runat="server" Text="Customer Name: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                               id="spanCustomerName"></span></div>
                            <div>
                                <asp:Label ID="lblCustomeEmail" runat="server" Text="Customer Email: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                id="spanCustomerEmail"></span></div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <div>
                                <asp:Label ID="lblOrderID" runat="server" Text="Order ID: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                     id="spanOrderID"></span>
                            </div>
                            <div>
                                <asp:Label ID="lblOrderDate" runat="server" Text="ORDER DATE: " CssClass="cssClassLabel"></asp:Label>
                                <span id="spanOrderDate"></span>
                            </div>
                            <div>
                                <asp:Label ID="lblOrderStatus" runat="server" Text="STATUS: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                       id="spanOrderStatus"></span>
                            </div>
                            <div>
                                <asp:Label ID="lblPaymentMethod" runat="server" Text="PAYMENT METHOD: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                 id="spanPaymentMethod"></span>
                            </div>
                            <div>
                                <asp:Label ID="lblShippingMethod" runat="server" Text="SHIPPING METHOD: " CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                   id="spanShippingMethod"></span>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="cssClassShipping" id="divShippingAddressInfo">
                        </div>
                    </td>
                    <td class="cssClassTableLeftCol">
                        <div class="cssClassBilling" id="divBillingAddressInfo">
                        </div>
                    </td>
                </tr>
            </table>
         
            <div id="divOrderItemDetails" class="cssClassGridWrapper">
            </div>                                 
            
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnBack">
                    <span><span>Back</span></span></button>
            </p>
        </div>
    </div>
</div>