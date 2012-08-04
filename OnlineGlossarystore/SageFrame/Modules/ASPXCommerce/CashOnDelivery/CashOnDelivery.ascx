<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CashOnDelivery.ascx.cs" Inherits="Modules_ASPXCommerce_PaymentGateways_CashOnDelivery_CashOnDelivery" %>
<script type="text/javascript">

    $(document).ready(function() {
        $('#btnTestOrder').click(function() {
            if (customerId != 0 && userName != 'anonymoususer') {
                var checkIfCartExist = CheckCustomerCartExist();
                if (!checkIfCartExist) {
                    alert("Your cart has been emptyed already!!");
                    return false;
                }
            }
            //  $.cookie('GrandTotal', $("#txtTotalCost").val());
            TotalDiscount = eval(parseFloat(TotalDiscount) + parseFloat(CartDiscount));
            if ($('#SingleCheckOut').length > 0) {

                AddOrderDetailsTest();
            } else {
                SendDataForPaymentTestMulti();
            }
        });
    });

    function CheckCustomerCartExist() {
        var checkCartExist;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckCustomerCartExist",
            data: JSON2.stringify({ customerID: customerId, storeID: storeId, portalID: portalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                checkCartExist = msg.d;

            }
        });
        return checkCartExist;
    }

    function getSession(Key) {
        var value = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSessionVariableCart",
            data: JSON2.stringify({ key: Key }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                value = parseFloat(msg.d);
            },
            error: function() {

            }
        });
        return value;

    }

    function SendDataForPaymentTestMulti() {
        //credit card info
        var creditCardTransactionType = $('#ddlTransactionType option:selected').text();
        var cardNo = $('#txtCardNo').val();
        var cardCode = $('#txtCardCode').val();
        var CardType = $('#cardType option:selected').text();
        var expireDate;
        expireDate = $('#lstMonth option:selected').text();
        expireDate += $('#lstYear option:selected').text();

        //Cheque Number
        var accountNumber = $('#txtAccountNumber').val();
        var routingNumber = $('#txtRoutingNumber').val();
        var accountType = $('#ddlAccountType option:selected').text();
        var bankName = $('#txtBankName').val();
        var accountHoldername = $('#txtAccountHolderName').val();
        var checkType = $('#ddlChequeType option:selected').text();
        var checkNumber = $('#txtChequeNumber').val();
        var recurringBillingStatus = false;

        if ($('#chkRecurringBillingStatus').is(':checked'))
            recurringBillingStatus = true;
        else
            recurringBillingStatus = false;

        var paymentMethodName = "Cash On Delivery";
        var paymentMethodCode = "Cash On Delivery";
        var isBillingAsShipping = false;


        if ($('#chkBillingAsShipping').attr('checked'))
            isBillingAsShipping = true;
        else
            isBillingAsShipping = false;

        var orderRemarks = "Order Remarks";
        var currencyCode = "USD";
        var isTestRequest = "TRUE";
        var isEmailCustomer = "TRUE";
        var discountAmount = "";
        var taxTotal = getSession("TaxAll"); //'<%= Session["TaxAll"] %>'; // $.cookies.get('Tax');
        var paymentGatewayID = getSession("Gateway"); // '<%= Session["Gateway"] %>'; //$.cookies.get('Gateway');
        var paymentGatewaySubTypeID = 1;
        amount = getSession("GrandTotalAll"); //'<%= Session["GrandTotalAll"] %>';
        var OrderDetails = {
            BillingAddressInfo: {
                FirstName: firstName,
                LastName: lastName,
                CompanyName: company,
                EmailAddress: customerEmail,
                Address: address,
                City: city,
                State: state,
                Zip: zip,
                Country: country,
                Phone: phone,
                Fax: fax,
                IsDefaultBilling: false,
                IsDefaultShipping: false,
                IsBillingAsShipping: isBillingAsShipping
            },
            PaymentInfo: {
                PaymentMethodName: paymentMethodName,
                PaymentMethodCode: paymentMethodCode,
                CardNumber: "",
                TransactionType: creditCardTransactionType,
                CardType: CardType,
                CardCode: "",
                ExpireDate: "",
                AccountNumber: accountNumber,
                RoutingNumber: routingNumber,
                AccountType: accountType,
                BankName: bankName,
                AccountHolderName: accountHoldername,
                ChequeType: checkType,
                ChequeNumber: checkNumber,
                RecurringBillingStatus: recurringBillingStatus
            },
            OrderDetailsInfo: {
                SessionCode: '',
                IsGuestUser: false,
                InvoiceNumber: "",
                TransactionID: 0,
                GrandTotal: amount,
                DiscountAmount: TotalDiscount,
                CouponCode: couponCode,
                PurchaseOrderNumber: 0,
                PaymentGatewayTypeID: paymentGatewayID,
                PaymentGateSubTypeID: paymentGatewaySubTypeID,
                ClientIPAddress: clientIPAddress,
                UserBillingAddressID: $('.cssClassBillingAddressInfo span').attr('id'),
                ShippingMethodID: spMethodID,
                PaymentMethodID: 0,
                TaxTotal: taxTotal,
                CurrencyCode: currencyCode,
                CustomerID: customerId,
                ResponseCode: 0,
                ResponseReasonCode: 0,
                ResponseReasonText: "",
                Remarks: orderRemarks,
                IsMultipleCheckOut: true,
                IsTest: isTestRequest,
                IsEmailCustomer: isEmailCustomer,
                IsDownloadable: IsDownloadItemInCart
            },
            CommonInfo: {
                PortalID: portalId,
                StoreID: storeId,
                CultureName: cultureName,
                AddedBy: userName,
                IsActive: isActive
            }
        };

        var paramData = {
            OrderDetailsCollection: {
                objOrderDetails: OrderDetails.OrderDetailsInfo,
                lstOrderItemsInfo: lstItems,
                objPaymentInfo: OrderDetails.PaymentInfo,
                objBillingAddressInfo: OrderDetails.BillingAddressInfo,
                objCommonInfo: OrderDetails.CommonInfo
            }
        };
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveOrderDetails",
            data: JSON2.stringify({ "OrderDetail": paramData.OrderDetailsCollection }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                document.location = aspxRedirectPath + "CashOnDeliverySuccess.aspx";
            },
            error: function(errorMsg) {
                alert("Place Order Error");
                return false;
            }
        });
    }

    function AddOrderDetailsTest() {

        if ($('#txtFirstName').val() == '') {
            var billingAddress = $('#dvBillingSelect option:selected').text();
            var addr = billingAddress.split(',');
            var Name = addr[0].split(' ');
            Array.prototype.clean = function(deleteValue) {
                for (var i = 0; i < this.length; i++) {
                    if (this[i] == deleteValue) {
                        this.splice(i, 1);
                        i--;
                    }
                }
                return this;
            };
            Name.clean("");

            if ($('#dvBillingSelect option:selected').val() > 0)
                addressID = $('#dvBillingSelect option:selected').val();
            firstName = Name[0];
            lastName = Name[1];
            company = addr[8];
            customerEmail = addr[6];
            address1 = addr[1];
            address2 = addr[11];
            city = addr[2];
            state = addr[3];
            zip = addr[5];
            country = addr[4];
            phone = addr[7];
            mobile = addr[8];
            fax = addr[9];
            website = addr[10];
        } else {
            firstName = $('#txtFirstName').val();
            lastName = $('#txtLastName').val();
            company = $('#txtCompanyName').val();
            customerEmail = $('#txtEmailAddress').val();
            address1 = $('#txtAddress1').val();
            address2 = $('#txtAddress2').val();
            city = $('#txtCity').val();
            country = $('#ddlBLCountry option:selected').text();
            if (country == 'United States')
                state = $('#ddlBLState option:selected').text();
            else
                state = $('#txtState').val();
            zip = $('#txtZip').val();
            phone = $('#txtPhone').val();
            mobile = $('#txtMobile').val();
            fax = $('#txtFax').val();
            website = $('#txtWebsite').val();
            isDefaultBilling = false;

        }

        if ($('#txtSPFirstName').val() == '') {
            var address = $('#dvShippingSelect option:selected').text();
            //" test test, Imadol, asdfasf, HH, Andorra, 235234, budiestpunk@gmail.com, 123434343434"
            var addr = address.split(',');
            var Name = addr[0].split(' ');
            var address = $('#dvShippingSelect option:selected').text();
            var addr = address.split(',');
            var Name = addr[0].split(' ');
            Array.prototype.clean = function(deleteValue) {
                for (var i = 0; i < this.length; i++) {
                    if (this[i] == deleteValue) {
                        this.splice(i, 1);
                        i--;
                    }
                }
                return this;
            };
            Name.clean("");
            spFirstName = Name[0];
            spLastName = Name[1];
            spCompany = addr[12];
            spEmail = addr[6];
            spAddress1 = addr[1];
            spAddress2 = addr[11];
            spCity = addr[2];
            spState = addr[3];
            spZip = addr[5];
            spCountry = addr[4];
            spPhone = addr[7];
            spMobile = addr[8];
            spFax = addr[9];
            spWebsite = addr[10];
        } else {
            spFirstName = $('#txtSPFirstName').val();
            spLastName = $('#txtSPLastName').val();
            spCompany = $('#txtSPCompany').val();
            spAddress1 = $('#txtSPAddress').val();
            spAddress2 = $('#txtSPAddress2').val();
            spCity = $('#txtSPCity').val();
            spZip = $('#txtSPZip').val();
            spCountry = $('#ddlSPCountry option:selected').text();
            if ($.trim(spCountry) == 'United States') {
                spState = $('#ddlSPState').val();
            } else {
                spState = $('#txtSPState').val();
            }
            spPhone = $('#txtSPPhone').val();
            spMobile = $('#txtSPMobile').val();
            spFax = '';
            spEmail = $('#txtSPEmailAddress').val();
            spWebsite = '';
            isDefaultShipping = false;
        }

        //credit card info
        var creditCardTransactionType = $('#ddlTransactionType option:selected').text();
        var cardNo = $('#txtCardNo').val();
        var cardCode = $('#txtCardCode').val();
        var CardType = $('#cardType option:selected').text();

        var expireDate;
        expireDate = $('#lstMonth option:selected').text();
        expireDate += $('#lstYear option:selected').text();

        //Cheque Number
        var accountNumber = $('#txtAccountNumber').val();
        var routingNumber = $('#txtRoutingNumber').val();
        var accountType = $('#ddlAccountType option:selected').text();
        var bankName = $('#txtBankName').val();
        var accountHoldername = $('#txtAccountHolderName').val();
        var checkType = $('#ddlChequeType option:selected').text();
        var checkNumber = $('#txtChequeNumber').val();
        var recurringBillingStatus = false;

        if ($('#chkRecurringBillingStatus').is(':checked'))
            recurringBillingStatus = true;
        else
            recurringBillingStatus = false;

        if ($('#chkBillingAsShipping').attr('checked'))
            isBillingAsShipping = true;
        else
            isBillingAsShipping = false;


        var orderRemarks = "Order Remarks";
        var orderItemRemarks = "Order Item Remarks";
        var currencyCode = "USD";
        var isTestRequest = "TRUE";
        var isEmailCustomer = "TRUE";
        var taxTotal = getSession("TaxAll");
        var paymentGatewayID = getSession("Gateway");
        var paymentGatewaySubTypeID = 1;
        var shippingMethodID = spMethodID;
        var paymentMethodCode = "Cash On Delivery";
        var paymentMethodName = "Cash On Delivery";

        shippingRate = getSession("ShippingCostAll");
        amount = getSession("GrandTotalAll");
        var OrderDetails = {
            BillingAddressInfo: {
                AddressID: addressID,
                FirstName: firstName,
                LastName: lastName,
                CompanyName: company,
                EmailAddress: customerEmail,
                Address: address1,
                Address2: address2,
                City: city,
                State: state,
                Zip: zip,
                Country: country,
                Phone: phone,
                Mobile: mobile,
                Fax: fax,
                WebSite: website,
                IsDefaultBilling: isDefaultBilling,
                IsBillingAsShipping: isBillingAsShipping
            },
            objSPAddressInfo: {
                AddressID: spAddressID,
                FirstName: spFirstName,
                LastName: spLastName,
                CompanyName: spCompany,
                EmailAddress: spEmail,
                Address: spAddress1,
                Address2: spAddress2,
                City: spCity,
                State: spState,
                Zip: spZip,
                Country: spCountry,
                Phone: spPhone,
                Mobile: spMobile,
                Fax: spFax,
                WebSite: spWebsite,
                IsDefaultShipping: isDefaultShipping
            },
            PaymentInfo: {
                PaymentMethodName: paymentMethodName,
                PaymentMethodCode: paymentMethodCode,
                CardNumber: "",
                TransactionType:
                    creditCardTransactionType,
                CardType: "",
                CardCode: "",
                ExpireDate: "",
                AccountNumber: accountNumber,
                RoutingNumber: routingNumber,
                AccountType: accountType,
                BankName: bankName,
                AccountHolderName: accountHoldername,
                ChequeType: checkType,
                ChequeNumber: checkNumber,
                RecurringBillingStatus: recurringBillingStatus
            },
            OrderDetailsInfo: {
                SessionCode: sessionCode,
                InvoiceNumber: "",
                TransactionID: 0,
                GrandTotal: amount,
                DiscountAmount: TotalDiscount,
                CouponCode: couponCode,
                PurchaseOrderNumber: 0,
                PaymentGatewayTypeID: paymentGatewayID,
                PaymentGateSubTypeID: paymentGatewaySubTypeID,
                ClientIPAddress: clientIPAddress,
                UserBillingAddressID: addressID,
                ShippingMethodID: shippingMethodID,
                IsGuestUser: isUserGuest,
                PaymentMethodID: 0,
                TaxTotal: taxTotal,
                CurrencyCode: currencyCode,
                CustomerID: customerId,
                ResponseCode: 0,
                ResponseReasonCode: 0,
                ResponseReasonText: "",
                Remarks: orderRemarks,
                IsMultipleCheckOut: false,
                IsTest: isTestRequest,
                IsEmailCustomer: isEmailCustomer,
                IsDownloadable: IsDownloadItemInCart
            },
            CommonInfo: {
                PortalID: portalId,
                StoreID: storeId,
                CultureName: cultureName,
                AddedBy: userName,
                IsActive: isActive
            }
        };

        var paramData = {
            OrderDetailsCollection: {
                objOrderDetails: OrderDetails.OrderDetailsInfo,
                lstOrderItemsInfo: lstItems,
                objPaymentInfo: OrderDetails.PaymentInfo,
                objBillingAddressInfo: OrderDetails.BillingAddressInfo,
                objShippingAddressInfo: OrderDetails.objSPAddressInfo,
                objCommonInfo: OrderDetails.CommonInfo
            }
        };

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveOrderDetails",
            data: JSON2.stringify({ "OrderDetail": paramData.OrderDetailsCollection }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {

                document.location = aspxRedirectPath + "CashOnDeliverySuccess.aspx";
            },
            error: function(errorMsg) {
                alert("Place Order Error");
                return false;
            }
        });
    }

    function retrive() {
        $.cookies.get('Discount', $('#txtDiscountAmount').val().replace( /[^0-9\.]+/g , ""));
        $.cookies.get('ShippingCost', $('#txtShippingTotal').val().replace( /[^0-9\.]+/g , ""));
        var gt = $("#txtTotalCost").val().replace( /[^0-9\.]+/g , "");
        if (gt == 'NaN')
            gt = 0;
        $.cookies.get('GrandTotal', gt);
    }
</script>

<input id="btnTestOrder" type="button" value="PlaceOrder (Cash On Delivery)" />