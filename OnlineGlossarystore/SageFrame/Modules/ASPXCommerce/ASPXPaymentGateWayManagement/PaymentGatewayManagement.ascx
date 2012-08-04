<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaymentGatewayManagement.ascx.cs"
            Inherits="Modules_PaymentGatewayManagement_PaymentGatewayManagement" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var errorcode = '<%= errorCode %>';

    $(document).ready(function() {
        if (errorcode == 1) {
            HideDivsWhenError();
        } else {
            BindPaymentMethodGrid(null, null);
            HideAllDivs();
            $("#divPaymentGateWayManagement").show();
        }
        LoadPaymentGateWayStaticImage();
        GetOrderStatus();
        $("#btnAddNewPayGateWay").click(function() {
            HideAllDivs();
            $("#<%= lblLoadMessage.ClientID %>").html("");
            $("#<%= lblLoadMessage.ClientID %>").hide();
            $("#<%= lblPaymentGateWay.ClientID %>").html("Add New Payment Method");
            $("#divPaymentGateWayForm").show();
        });

        $("#btnDeletePayMethod").click(function() {
            var paymentGateway_Ids = '';
            //Get the multiple Ids of the item selected
            $(".PaymentChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    paymentGateway_Ids += $(this).val() + ',';
                }
            });
            if (paymentGateway_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultiplePayments(paymentGateway_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Payment methods?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        });

        $("#btnCancelPaymentGateway").click(function() {
            HideAllDivs();
            $("#divPaymentGateWayManagement").show();
        });

        $("#btnSubmitPayEdit").click(function() {
            HideAllDivs();
            UpdatePaymentGatewayMethod();
            $("#divPaymentGateWayManagement").show();
        });

        $("#btnCancelPayEdit").click(function() {
            HideAllDivs();
            $("#divPaymentGateWayManagement").show();
        });

        $("#btnBackOrder").click(function() {
            HideAllDivs();
            $("#divPaymentGateWayManagementEdit").show();
        });

        $("#btnBackPaymentEdit").click(function() {
            HideAllDivs();
            $("#divPaymentGateWayManagement").show();
        });

        $("#btnBackFromAddNetPaymentForm").click(function() {
            HideAllDivs();
            BindPaymentMethodGrid(null, null);
            $("#divPaymentGateWayManagement").show();
        });

        $('#btnPrint').click(function() {
            printPage();
        });
    });

    function LoadPaymentGateWayStaticImage() {
        $('#ajaxPayementGatewayImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxPaymentGateWayImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function printPage() {
        // window.print();
        var content = $('#divPrintOrderDetail').html();
        var pwin = window.open('', 'print_content', 'width=100,height=100');
        pwin.document.open();
        pwin.document.write('<html><body onload="window.print()">' + content + '</body></html>');
        pwin.document.close();
        setTimeout(function() { pwin.close(); }, 1000);
    }

    function PrintOrderDetailForm() {
        var divContent = $('#divPrintOrderDetail').html();
        $("input[id$='HdnValue']").val(divContent);
    }

    function BindPaymentMethodGrid(paymentgatewayName, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvPaymentGateway_pagesize").length > 0) ? $("#gdvPaymentGateway_pagesize :selected").text() : 10;
        $("#gdvPaymentGateway").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllPaymentMethod',
            colModel: [
                { display: 'PaymentGatewayId', name: 'paymentgateway_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'PaymentChkbox' },
                { display: 'Payment Gateway Name', name: 'paymentgateway_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'True/False' },
                { display: 'View', name: 'Paymentedit', btntitle: 'View', cssclass: 'cssClassButtonHeader', controlclass: 'cssClassButtonSubmit', coltype: 'button', align: 'left', url: '', queryPairs: '', showpopup: true, popupid: '', poparguments: '7', popupmethod: 'BindOrderList' },
                { display: 'Setting', name: 'setting', btntitle: 'Setting', cssclass: 'cssClassButtonHeader', controlclass: 'cssClassButtonSubmit', coltype: 'button', align: 'left', url: '', queryPairs: '', showpopup: true, popupid: 'popuprel2', poparguments: '6,7', popupmethod: 'LoadControl' },
                { display: 'HdnEdit', name: 'HdnPaymentedit', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'HdnSetting', name: 'Hdnsetting', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'HdnPaymentGatewayID', name: 'HdnPaymentgatewayID', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],
            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditPaymentMethod', arguments: '1,2' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeletePaymentMethod', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, paymentGatewayName: paymentgatewayName, isActive: isAct },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 3: { sorter: false }, 4: { sorter: false }, 5: { sorter: false }, 6: { sorter: false }, 7: { sorter: false }, 8: { sorter: false } }
        });
    }

    function EditPaymentMethod(tblID, argus) {
        switch (tblID) {
        case "gdvPaymentGateway":
            $("#txtPaymentGatewayName").val(argus[3]);
            $("#hdnPaymentGatewayID").val(argus[0]);
            $("#chkIsActive").attr('checked', Boolean.parse(argus[4]));
            $("#<%= lblPaymentGatewayEdit.ClientID %>").html("Editing PaymentGateway method: " + argus[3]);
            HideAllDivs();
            $("#divPaymentGatewayEditForm").show();
            break;
        default:
            break;
        }
    }

    //Convert string to boolean
    Boolean.parse = function(str) {
        switch (str.toLowerCase()) {
        case "true":
            return true;
        case "false":
            return false;
        default:
            return false;
        }
    };

    function HideAllDivs() {
        $("#divPaymentGateWayManagement").hide();
        $("#divPaymentGateWayForm").hide();
        $("#divPaymentGatewayEditForm").hide();
        $("#divPaymentEdit").hide();
        $("#divOrderDetailForm").hide();
        $("#divPaymentGateWayManagementEdit").hide();
    }

    function HideDivsWhenError() {
        HideAllDivs();
        $("#divPaymentGateWayForm").show();
    }

    function LoadControl(argus, PopUpID) {
        var ControlName = argus[0];
        $("#hdnPaymentGatewayID").val(argus[1]);
        if (ControlName != '') {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "LoadControlHandler.aspx/Result",
                data: "{ controlName:'" + aspxRootPath + ControlName + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(response) {
                    $('#' + PopUpID).html(response.d);
                    LoadPaymentGatewaySetting(argus[1], PopUpID);
                },
                error: function() {
                    alert("error");
                }
            });
        } else {
            alert('This Payment Gateway doesn\'t seem to need any Settings!');
        }
    }

    function BindOrderList(argus, billNm, shipNm, orderStatusType) {
        $("#hdnPaymentGatewayIDView").val(argus);
        if (billNm == undefined) {
            billNm = null;
        }
        if (shipNm == undefined) {
            shipNm = null;
        }
        if (orderStatusType == undefined) {
            orderStatusType = null;
        }
        var paymentGatewayId = $("#hdnPaymentGatewayIDView").val();
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvPaymentGatewayEdit_pagesize").length > 0) ? $("#gdvPaymentGatewayEdit_pagesize :selected").text() : 10;
        HideAllDivs();
        $("#divPaymentGateWayManagementEdit").show();
        $("#gdvPaymentGatewayEdit").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetOrderDetailsbyPayID",
            colModel: [
                { display: 'PaymentGatewayID', name: 'paymentgateway_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'PaymentChkbox' },
                { display: 'Order ID', name: 'order_Id', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'link', align: 'left', url: '', queryPairs: '', showpopup: true, popupid: '', poparguments: '1,8', popupmethod: 'LoadOrderDetails' },
                { display: 'Store ID', name: 'store_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AddedOn', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Bill to Name', name: 'bill_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Ship to Name', name: 'ship_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Grand Total', name: 'grand_total', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Status', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'IsMultipleShipping', name: 'IsMultiShipping', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', hide: true, format: 'Yes/No' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { billToName: billNm, ShipToName: shipNm, orderStatusName: orderStatusType, paymentGatewayID: paymentGatewayId, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 8: { sorter: false }, 9: { sorter: false } }
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
                    var StatusElements = "<option value=" + item.OrderStatusID + ">" + item.OrderStatusName + "</option>";
                    $("#ddlOrderStatus").append(StatusElements);
                });
            },
            error: function() {
                alert("error");
            }
        });
    }

    function LoadOrderDetails(argus) {
        var orderID = argus[0];
        var IsMultipleShipping = argus[1];
        var param = JSON2.stringify({ orderId: orderID, storeId: storeId, portalId: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllOrderDetailsByOrderID",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var span = '';
                var span1 = '';
                $.each(msg.d, function(index, item) {
                    if (index == 0) {
                        $("#spanOrderID").html(item.OrderID);
                        $("#spanOrderDate").html(item.OrderDate);
                        $("#spanOrderStatus").html(item.OrderStatusName);
                        $("#spanPaymentMethod").html(item.PaymentMethodName);
                        $("#spanShippingMethod").html('');
                        $("#spanStoreName").html(item.StoreName);
                        $("#spanStoreDescription").html(item.StoreDescription);
                        span = "<b>Billing To:</b>";
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
                            span += ",<br/>" + item.State;

                        if (item.Country != "")
                            span += ",<br/>" + item.Country;

                        if (item.Zip != "")
                            span += ",<br/>" + item.Zip;

                        if (item.Email != "")
                            span += ",<br/>" + item.Email;

                        if (item.Phone != "")
                            span += ",<br/>" + item.Phone;

                        if (item.Mobile != "")
                            span += ",<br/>" + item.Mobile;

                        if (item.Fax != "")
                            span += ",<br/>" + item.Fax;

                        if (item.Website != "")
                            span += ",<br/>" + item.Website;

                        $("#divOrderItemDetails").html('');

                        if (IsMultipleShipping == 'no') {
                            $("#spanShippingMethod").html(item.ShippingMethodName);
                            span1 = "<b>Shipping To:</b>";
                            if (item.ShippingName != "")
                                span1 += "<br/>" + item.ShippingName;

                            if (item.shipAddress1 != "")
                                span1 += ",<br/>" + item.shipAddress1;

                            if (item.shipAddress2 != "")
                                span1 += ",<br/>" + item.shipAddress2;

                            if (item.ShipCompany != "")
                                span1 += ",<br/>" + item.ShipCompany;

                            if (item.shipCity != "")
                                span1 += ",<br/>" + item.shipCity;

                            if (item.shipState != "")
                                span1 += ",<br/>" + item.shipState;

                            if (item.ShipCountry != "")
                                span1 += ",<br/>" + item.ShipCountry;

                            if (item.shipZip != "")
                                span1 += ",<br/>" + item.shipZip;

                            if (item.ShipEmail != "")
                                span1 += ",<br/>" + item.ShipEmail;

                            if (item.shipPhone != "")
                                span1 += ",<br/>" + item.shipPhone;

                            if (item.shipMobile != "")
                                span1 += ",<br/>" + item.shipMobile;

                            if (item.shipFax != "")
                                span1 += ",<br/>" + item.shipFax;

                            if (item.shipWebsite != "")
                                span1 += ",<br/>" + item.shipWebsite;
                            var itemOrderDetails = '<table border="1"><thead><tr><th>Item</th><th>ItemSKU</th><th>Price</th><th>Quantity</th><th>SubTotal</th></td></tr></thead><tbody>';

                            $.each(msg.d, function(index, item) {
                                itemOrderDetails += "<tr><td>" + item.ItemName + "</td>";
                                itemOrderDetails += "<td>" + item.SKU + "</td>";
                                itemOrderDetails += "<td>" + item.Price + "</td>";
                                itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                itemOrderDetails += "<td>" + item.SubTotal + "</td></tr>";

                            });
                            itemOrderDetails += '</tbody></table>';
                        } else {
                            var itemOrderDetails = '<table border="1"><thead><tr><th>Item</th><th>ItemSKU</th><th>Price</th><th>Quantity</th><th>SubTotal</th><th>ShippingMethod</th></td></tr></thead><tbody>';

                            $.each(msg.d, function(index, item) {
                                itemOrderDetails += "<tr><td>" + item.ItemName + "</td>";
                                itemOrderDetails += "<td>" + item.SKU + "</td>";
                                itemOrderDetails += "<td>" + item.Price + "</td>";
                                itemOrderDetails += "<td>" + item.Quantity + "</td>";
                                itemOrderDetails += "<td>" + item.SubTotal + "</td>";
                                itemOrderDetails += "<td>" + item.ShippingMethodName + "</td></tr>";
                            });
                            itemOrderDetails += '</tbody></table>';
                        }

                        $("#divOrderItemDetails").append(itemOrderDetails);
                        $("#spanSubTotalValue").html(item.GrandSubTotal);
                        $("#spanCouponValue").html(item.CouponAmount);
                        $("#spanTaxesValue").html(item.TaxTotal);
                        $("#spanShippingCostValue").html(item.ShippingCost);
                        $("#spanTotalCost").html(item.TotalCost);

                        HideAllDivs();
                        $("#divOrderDetailForm").show();
                    }
                });

                $("#divBillingAddressInfo").html(span);
                $("#divShippingAddressInfo").html(span1);
            },
            error: function() {
                alert("error");
            }
        });
    }

    function UpdatePaymentGatewayMethod() {
        var paymentGatewayID = $("#hdnPaymentGatewayID").val();
        var paymentMethodName = $("#txtPaymentGatewayName").val();
        var isAct = $("#chkIsActive").attr('checked');
        var param = JSON2.stringify({ storeId: storeId, portalId: portalId, paymentGatewayID: paymentGatewayID, paymentGatewayName: paymentMethodName, isActive: isAct, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdatePaymentMethod",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindPaymentMethodGrid(null, null);
            },
            error: function() {
                alert("Error!");
            }
        });
    }


    function DeletePaymentMethod(tblID, argus) {
        switch (tblID) {
        case "gdvPaymentGateway":
            var properties = {
                onComplete: function(e) {
                    DeletePaymentGateMethod(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultiplePayments(Ids, event) {
        if (event) {
            DeletePaymentGateMethod(Ids, event);
        }
    }

    function DeletePaymentGateMethod(_paymentGatewayID, event) {
        var params = { paymentGatewayID: _paymentGatewayID, storeId: storeId, portalId: portalId, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeletePaymentMethod",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindPaymentMethodGrid(null, null);
            }
        });
        return false;
    }

    function SearchPaymentgateway() {
        var paymentgatewayName = $.trim($("#txtSearchPaymentGateWayName").val());
        var isAct = $.trim($("#ddlIsActive").val()) == "" ? null : $.trim($("#ddlIsActive").val()) == 0 ? true : false;
        if (paymentgatewayName.length < 1) {
            paymentgatewayName = null;
        }
        BindPaymentMethodGrid(paymentgatewayName, isAct);
    }

    function SearchOrders() {
        var paymentGatewayID = $("#hdnPaymentGatewayIDView").val();
        var billNm = $.trim($("#txtSearchBillToName").val());
        var shipNm = $.trim($("#txtSearchShipToName").val());
        var orderStatusType = '';
        if (billNm.length < 1) {
            billNm = null;
        }
        if (shipNm.length < 1) {
            shipNm = null;
        }
        if ($("#ddlOrderStatus").val() != "0") {
            orderStatusType = $.trim($("#ddlOrderStatus :selected").text());
        } else {
            orderStatusType = null;
        }
        BindOrderList(paymentGatewayID, billNm, shipNm, orderStatusType);
    }
</script>

<div id="divPaymentGateWayManagement">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="PaymentGatewayManagement" runat="server" Text="Manage Payment Method"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeletePayMethod">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewPayGateWay">
                            <span><span>Add New Payment Method</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Payment Gateway Method Name:</label>
                                <input type="text" id="txtSearchPaymentGateWayName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    IsActive:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="0">Yes</option>
                                    <option value="1">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchPaymentgateway() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxPaymentGateWayImage2"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvPaymentGateway" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divPaymentGateWayForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblPaymentGateWay" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblPaymentGatewayForm" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblLoadMessage" runat="server" CssClass="cssClassRed"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:FileUpload ID="fuPGModule" runat="server" />
                        <asp:Panel ID="pnlRepair" runat="server" Visible="true">
                            <asp:CheckBox ID="chkRepairInstall" runat="server" CssClass="cssClassCheckBox" />
                            <asp:Label ID="lblRepairInstallHelp" runat="server" CssClass="cssClassHelpTitle" />
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input id="btnBackFromAddNetPaymentForm" type="button" value="Back" class="cssClassButtonSubmit" />
                        <asp:Button ID="btnAddNew" runat="server" Text="Save" OnClick="btnAddNew_Click" class="cssClassButtonSubmit" />
                    </td>
                </tr>
            </table>
        </div>
    </div>
</div>

<div id="divPaymentGatewayEditForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblPaymentGatewayEdit" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblPaymentGatewayEdit" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblGatewayName" Text="PaymentGatewayName:" runat="server" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtPaymentGatewayName" class="cssClassNormalTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblIsActive" Text="IsActive:" runat="server" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="checkbox" id="chkIsActive" class="cssClassCheckBox" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancelPayEdit">
                    <span><span>Cancel</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitPayEdit">
                    <span><span>Save</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <input type="hidden" id="hdnPaymentGatewayIDView" />
    <input type="hidden" id="hdnPaymentGatewayID" />
</div>
<div id="popuprel2" class="popupbox adminpopup">
</div>
<div id="divPaymentEdit">
</div>
<div id="divOrderDetailForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderDetailForm" runat="server" Text="Order Details"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnSavePDFForm2" runat="server" Text="Save As Pdf" OnClick="btnSavePDFForm2_Click"
                                    OnClientClick="PrintOrderDetailForm()" CssClass="cssClassButtonSubmit" />
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
        <div id="divPrintOrderDetail" class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td>
                    </td>
                    <td>
                        <span id="spanDate"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <div>
                                <asp:Label ID="lblStoreName" runat="server" Text="Store Name:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                        id="spanStoreName"></span></div>
                            <div>
                                <asp:Label ID="lblStoreDescription" runat="server" Text="Store Description:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                      id="spanStoreDescription"></span></div>
                        </div>
                    </td>
                    <td>
                        <div>
                            <div>
                                <asp:Label ID="lblOrderID" runat="server" Text="OrderID #" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                    id="spanOrderID"></span></div>
                            <div>
                                <asp:Label ID="lblOrderDate" runat="server" Text="ORDER DATE:" CssClass="cssClassLabel"></asp:Label>
                                <span id="spanOrderDate"></span>
                            </div>
                            <div>
                                <asp:Label ID="lblOrderStatus" runat="server" Text="STATUS:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                      id="spanOrderStatus"></span></div>
                            <div>
                                <asp:Label ID="lblPaymentMethod" runat="server" Text="PAYMENT METHOD:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                id="spanPaymentMethod"></span></div>
                            <div>
                                <asp:Label ID="lblShippingMethod" runat="server" Text="SHIPPING METHOD:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                  id="spanShippingMethod"></span></div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div class="cssClassShipping" id="divShippingAddressInfo">
                        </div>
                    </td>
                    <td>
                        <div class="cssClassBilling" id="divBillingAddressInfo">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div id="divOrderItemDetails">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                    <td>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblSubTotal" Text="SubTotal:" runat="server"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;&nbsp; <span id="spanSubTotalValue"></span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCoupon" Text="Coupon:" runat="server"></asp:Label>
                                    <span id="spanCouponValue">&nbsp;&nbsp;&nbsp; </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTaxes" Text="Taxes:" runat="server"></asp:Label>
                                    <span id="spanTaxesValue">&nbsp;&nbsp;&nbsp; </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblShippingCost" Text="ShippingCost:" runat="server"></asp:Label>
                                    <span id="spanShippingCostValue">&nbsp;&nbsp;&nbsp; </span>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblTotalCost" Text="TotalCost:" runat="server"></asp:Label>
                                    <span id="spanTotalCost">&nbsp;&nbsp;&nbsp; </span>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnBackOrder">
                    <span><span>Back</span></span></button>
            </p>
            <p>
                <button type="button" id="btnReset">
                    <span><span>Reset</span></span></button>
            </p>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div id="divPaymentGateWayManagementEdit">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblPaymentGatewayManagement" runat="server" Text="Edit Payment Gateway"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnBackPaymentEdit">
                            <span><span>Back</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="Button1">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Bill To Name:</label>
                                <input type="text" id="txtSearchBillToName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Ship To Name:</label>
                                <input type="text" id="txtSearchShipToName" class="cssClassTextBoxSmall" />
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
                    <img id="ajaxPayementGatewayImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvPaymentGatewayEdit" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>