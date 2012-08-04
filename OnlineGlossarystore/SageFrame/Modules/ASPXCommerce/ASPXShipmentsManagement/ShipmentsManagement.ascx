<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShipmentsManagement.ascx.cs"
            Inherits="Modules_ASPXShipmentsManagement_ShipmentsManagement" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideDivs();
        LoadShipmentMgmtStaticImage();
        $("#divShipmentsDetails").show();
        BindShipmentsDetails(null, null, null);
        $("#btnExportToCSV").click(function() {
            $('#gdvShipmentsDetails').table2CSV();
        });
        $("#btnShipmentBack").click(function() {
            HideDivs();
            $("#divShipmentsDetails").show();
        });
    });

    function LoadShipmentMgmtStaticImage() {
        $('#ajaxShipmentsMgmtImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDivs() {
        $("#divShipmentsDetails").hide();
        $("#divShipmentsDetailForm").hide();
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvShipmentsDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShipmentsDetails tbody tr");
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

    function BindShipmentsDetails(shippingMethodNm, orderID, shipNm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShipmentsDetails_pagesize").length > 0) ? $("#gdvShipmentsDetails_pagesize :selected").text() : 10;

        $("#gdvShipmentsDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetShipmentsDetails',
            colModel: [
                { display: 'Shipping Method ID', name: 'shipping_methodId', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Shipping Method Name', name: 'shipping_method_name', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Order ID', name: 'order_id', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'link', align: 'left', url: '', queryPairs: '' },
				//{ display: 'Shipped Date', name: 'shipped_date', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Ship to Name', name: 'ship_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Shipping Rate', name: 'shipping_rate', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'View', name: 'view', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewShipments', arguments: '1,2,3,4,5,6' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { shippimgMethodName: shippingMethodNm, shipToName: shipNm, orderId: orderID, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { o: { sorter: true }, 5: { sorter: false } }
        });
    }

    function ViewShipments(tblID, argus) {
        switch (tblID) {
        case "gdvShipmentsDetails":
            HideDivs();
            $("#<%= lblShipmentForm.ClientID %>").html("Shipping Method ID: #" + argus[0]);
            $("#divShipmentsDetailForm").show();
            BindShippindMethodDetails(argus[4]);
            break;
        }
    }

    function BindShippindMethodDetails(orderId) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindAllShipmentsDetails",
            data: JSON2.stringify({ orderID: orderId, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var tableElements = '';
                var grandTotal = '';
                var dicountAmount = '';
                var couponAmount = '';
                var taxTotal = '';
                var shippingCost = '';
                $.each(msg.d, function(index, value) {
                    var cv = "";
                    if (value.CostVariants != "") {
                        cv = "(" + value.CostVariants + ")";
                    }
                    tableElements += '<tr>';
                    tableElements += '<td>' + value.ItemName + cv + '</td>';
                    $("#shipmentDate").html(value.ShipmentDate);
                    tableElements += '<td>' + value.SKU + '</td>';
                    tableElements += '<td>' + value.ShippingAddress + '</td>';
                    tableElements += '<td>' + value.ShippingMethod + '</td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + value.ShippingRate + '</span></td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + value.Price.toFixed(2) + '</span></td>';
                    tableElements += '<td>' + value.Quantity + '</td>';
                    tableElements += '<td><span class="cssClassFormatCurrency" >' + (value.Price * value.Quantity).toFixed(2) + '</span></td>';
                    tableElements += '</tr>';
                    if (index == 0) {
                        taxTotal = '<tr>';
                        taxTotal += '<td></td><td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Total Tax Amount</td>';
                        taxTotal += '<td><span class="cssClassFormatCurrency" >' + value.TaxTotal.toFixed(2) + '</span></td>';
                        taxTotal += '</tr>';
                        shippingCost = '<tr>';
                        shippingCost += '<td></td><td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Total Shipping Rate</td>';
                        shippingCost += '<td><span class="cssClassFormatCurrency" >' + value.TotalShippingRate.toFixed(2) + '</span></td>';
                        shippingCost += '</tr>';
                        dicountAmount = '<tr>';
                        dicountAmount += '<td></td><td></td><td></td><td></td><td></td><td></td><td  class="cssClassLabel">Total Discount Amount</td>';
                        dicountAmount += '<td><span class="cssClassFormatCurrency" >' + value.DiscountAmount.toFixed(2) + '</span></td>';
                        dicountAmount += '</tr>';
                        couponAmount = '<tr>';
                        couponAmount += '<td></td><td></td><td></td><td></td><td></td><td></td><td  class="cssClassLabel">Total Coupon Amount</td>';
                        couponAmount += '<td><span class="cssClassFormatCurrency" >' + value.TotalCoupon.toFixed(2) + '</span></td>';
                        couponAmount += '</tr>';
                        grandTotal = '<tr>';
                        grandTotal += '<td></td><td></td><td></td><td></td><td></td><td></td><td class="cssClassLabel">Total Amount</td>';
                        grandTotal += '<td><span class="cssClassFormatCurrency" >' + value.GrandTotal.toFixed(2) + '</span></td>';
                        grandTotal += '</tr>';
                    }

                });
                $("#divShipmentsDetailForm").find('table>tbody').html(tableElements);
                $("#divShipmentsDetailForm").find('table>tbody').append(taxTotal);
                $("#divShipmentsDetailForm").find('table>tbody').append(shippingCost);
                $("#divShipmentsDetailForm").find('table>tbody').append(dicountAmount);
                $("#divShipmentsDetailForm").find('table>tbody').append(couponAmount);
                $("#divShipmentsDetailForm").find('table>tbody').append(grandTotal);
                $("#divShipmentsDetailForm").find("table>tbody tr:even").addClass("cssClassAlternativeEven");
                $("#divShipmentsDetailForm").find("table>tbody tr:odd").addClass("cssClassAlternativeOdd");
                HideDivs();
                $("#divShipmentsDetailForm").show();
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + 'en-US' + '' });

            },
            error: function() {
                alert("Order details error");
            }
        });
    }

    function SearchShipments() {
        var shippingMethodNm = $.trim($("#txtShippingMethodName").val());
        var orderID = $.trim($("#txtOrderID").val());
        var shipNm = $.trim($("#txtSearchShipToName").val());
        if (shippingMethodNm.length < 1) {
            shippingMethodNm = null;
        }
        if (orderID.length < 1) {
            orderID = null;
        }
        if (shipNm.length < 1) {
            shipNm = null;
        }
        BindShipmentsDetails(shippingMethodNm, orderID, shipNm);
    }
</script>

<div id="divShipmentsDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderHeading" runat="server" Text="Shipments"></asp:Label>
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
                                    Shipping Method Name:</label>
                                <input type="text" id="txtShippingMethodName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    OrderID:</label>
                                <input type="text" id="txtOrderID" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Ship To Name:</label>
                                <input type="text" id="txtSearchShipToName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchShipments() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxShipmentsMgmtImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvShipmentsDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div class="cssClassFormWrapper Curve" id="divShipmentsDetailForm">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblShipmentForm" runat="server"></asp:Label>
        </h2>
    </div>
    <span class="cssClassLabel">Shipment Date: </span><span id="shipmentDate"></span>
    <br />
    <%--    <span class="cssClassLabel">Shipping Method Name: </span><span id="shippingMethodName">
    </span>--%>
    <br />
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                Shipments Items:</h2>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <table cellspacing="0" cellpadding="0" border="0" width="100%">
                    <thead>
                        <tr class="cssClassHeading">
                            <td>
                                Item Name
                            </td>
                            <td>
                                SKU
                            </td>
                            <td>
                                ShippingAddress
                            </td>
                            <td>Shipping Method Name</td>
                            <td>
                                Shipping Rate
                            </td>
                            <td>
                                Price
                            </td>
                            <td>
                                Quantity
                            </td>
                            <td>
                                Sub Total
                            </td>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>
        <%-- </div>--%></div>
    <div class="cssClassButtonWrapper">
        <p>
            <button type="button" id="btnShipmentBack">
                <span><span>Back</span></span></button>
        </p>
    </div>
</div>