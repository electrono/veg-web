<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CheckoutInformationContent.ascx.cs"
            Inherits="Modules_ASPXCheckoutInformationContent_CheckoutInformationContent" %>

<script type="text/javascript" language="javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var sessionCode = '<%= sessionCode %>';
    var couponCode = '<%= CouponCode %>';
    var isActive = true;
    var IsFShipping = '<%= IsFShipping %>';

    var discountShopping = '<%= Discount %>';
    var clientIPAddress = '<%= userIP %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var myAccountURL = '<%= myAccountURL %>';
    var CartDiscount = 0;
    var TotalDiscount = discountShopping;
    var IsDownloadItemInCart = false;
    var IsDownloadItemInCartFull = false;
    var CountDownloadableItem = 0;
    var CountAllItem = 0;


    var paymentMethodName = "";
    var paymentMethodCode = "";
    var isBillingAsShipping = 0;
    var shippingRate = 0;
    var amount = 0;
    var lstItems = [];
    var spMethodID = 0;
    var spCost = 0;
    var ID = 0;
    var qty = 0;
    var Tax = 0;
    var price = 0;
    var weight = 0;
    var CartID = 0;
    var ItemType = '';

    //billing adrress
    var addressID = 0;
    var firstName = "";
    var lastName = "";
    var company = "";
    var customerEmail = "";
    var address1 = "";
    var address2 = "";
    var city = "";
    var state = "";
    var zip = "";
    var country = "";
    var phone = "";
    var mobile = "";
    var fax = "";
    var website = "";
    var isDefaultBilling = false;

    //shipping address
    var spAddressID = 0;
    var spFirstName = "";
    var spLastName = "";
    var spCompany = "";
    var spAddress1 = "";
    var spAddress2 = "";
    var spCity = "";
    var spState = "";
    var spZip = "";
    var spCountry = "";
    var spPhone = "";
    var spMobile = "";
    var spFax = "";
    var spEmail = "";
    var spWebsite = "";
    var isDefaultShipping = false;
    var isUserGuest = true;
    var $accor = '';
    $(document).ready(function() {


        //TO Check if only Downloadable Items in cart

        $accor = $("#accordion").accordion({ autoHeight: false, event: false });
        var $billingSelect = $('#dvBillingSelect');
        var $billingInfo = $('#dvBillingInfo');
        var $shippingSelect = $('#dvShippingSelect');
        var $shippingInfo = $('#dvShippingInfo');

        GetCountry();
        $('#ddlBLState').hide();
        $('#ddlSPState').hide();
        GetState();
        GetUserCartDetails();
        GetShippinMethodsFromWeight();
        LoadPGatewayList();
        $('#dvLogin').hide();
        $('#lblAuthCode').hide();
        $('#txtAuthCode').hide();
        $billingSelect.hide();
        $shippingSelect.hide();
        //$('#txtPhone').mask("99-99999999");       

        if (userName != 'anonymoususer') {
            BindUserAddress();
            $billingInfo.hide();
            $billingSelect.show();
            isUserGuest = false;
            $accor.accordion("activate", 1);
            $('#btnBillingBack').hide();
            if (IsDownloadItemInCartFull) {
                $('#dvBilling .cssClassCheckBox').hide();
            } else {
                $('#dvBilling .cssClassCheckBox').show();
            }

        } else {
            $('#btnBillingBack').show();

        }


        if (TotalDiscount == 0) {
            QuantitityDiscountAmount();
        }

        $('#rdbRegister').click(function() {
            $('#btnCheckOutMethodContinue').hide();
            $('#dvLogin').show();
            isUserGuest = false;
        });
        $('#rdbGuest').click(function() {
            $('#btnCheckOutMethodContinue').show();
            $('#dvLogin').hide();
            $('#txtLoginEmail').val('');
            $('#loginPassword').val('');
            isUserGuest = true;
        });


        var v = $("#form1").validate({
            messages: {
                FirstName: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                LastName: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                Email: {
                    required: '*',
                    email: '*'
                },
                Address1: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                Address2: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                Phone: {
                    required: '*',
                    maxlength: "*"
                //number: true
                },
                Company: {
                    maxlength: "*"
                },
                mobile: {
                    maxlength: "*"
                //number: true
                },
                Fax: {
                    
                //number: true
                },
                City: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                stateprovince: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                biZip: {
                    required: '*',
                    minlength: "* (at least 5 chars)",
                    maxlength: "*" //number: true
                },
                spFName: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                spLName: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                spAddress1: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                spAddress2: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                spCountry: {
                    required: '*',
                    minlength: "* (at least 4 chars)"
                },
                spCity: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                SPCompany: {
                    maxlength: "*"
                },
                spZip: {
                    required: '*',
                    minlength: "* (at least 5 chars)",
                    maxlength: "*"
                },
                spstateprovince: {
                    required: '*',
                    minlength: "* (at least 2 chars)",
                    maxlength: "*"
                },
                spPhone: {
                    required: '*',
                    minlength: "* (at least 7 chars)"
                },
                spmobile: {
                    maxlength: "*"
                },
                cardCode: {
                    required: '*',
                    minlength: "* (at least 3 chars)"
                }
            },
            rules:
                {
                    creditCard: {
                        required: true,
                        creditcard: true
                    }
                },
            ignore: ":hidden"
        });

        $('#ddlTransactionType').change(function() {
            if ($('#ddlTransactionType option:selected').text() == " CAPTURE_ONLY") {
                $('#lblAuthCode').show();
                $('#txtAuthCode').show();
            } else {
                $('#lblAuthCode').hide();
                $('#txtAuthCode').hide();
            }
        });

        $('#btnCheckOutMethodContinue').click(function() {
            if (v.form()) {
                if ($('#rdbGuest').attr('checked') == true) {
                    $accor.accordion("activate", 1);
                    $billingInfo.show();
                    $billingSelect.hide();
                    if ($('#rdbGuest').is(':checked')) {
                        $('#password').hide();
                        $('#confirmpassword').hide();
                    } else {
                        $('#password').show();
                        $('#confirmpassword').show();
                    }
                }
            } else {
                alert('Please fill the form correctly');
            }
        });


        $('#btnBillingContinue').click(function() {

            if (CountAllItem == CountDownloadableItem) {
                IsDownloadItemInCartFull = true;
            } else {
                IsDownloadItemInCartFull = false;
            }
            if (v.form()) {
                // alert('');                                    
                AssignItemsDetails();
                if (isUserGuest == false) {
                    if ($.trim($('#ddlBilling').text()) == '' || $.trim($('#ddlBilling').text()) == null) {
                        $('#addBillingAddress').show();
                        return false;
                    } else {
                        BindBillingData();
                        if ($('#txtFirstName').val() == '') {
                            $shippingInfo.hide();
                            $shippingSelect.show();
                        } else {
                            $shippingInfo.show();
                            $shippingSelect.hide();
                        }
                        if (IsDownloadItemInCartFull) {
                            AssignItemsDetails();
                            $accor.accordion("activate", 4);
                            $("#txtShippingTotal").val(0);
                            SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                        }
                        if ($('#chkBillingAsShipping').is(':checked')) {
                            BindShippingData();
                            if (IsDownloadItemInCartFull) {
                                $accor.accordion("activate", 4);
                                $("#txtShippingTotal").val(0);
                                SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                            } else {
                                $accor.accordion("activate", 3);
                            }
                        } else {
                            $accor.accordion("activate", 2);
                        }
                        // return false;
                    }
                } else {
                    BindBillingData();
                    if ($('#txtFirstName').val() == '') {
                        $shippingInfo.hide();
                        $shippingSelect.show();
                    } else {
                        $shippingInfo.show();
                        $shippingSelect.hide();
                    }
                    if (IsDownloadItemInCartFull) {
                        $accor.accordion("activate", 4);
                        $("#txtShippingTotal").val(0);
                        SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                    }
                    if ($('#chkBillingAsShipping').is(':checked')) {
                        BindShippingData();
                        if (IsDownloadItemInCartFull) {
                            AssignItemsDetails();
                            $accor.accordion("activate", 4);
                            $("#txtShippingTotal").val(0);
                            SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                        } else {
                            $accor.accordion("activate", 3);
                        }
                    } else {
                        $accor.accordion("activate", 2);
                    }
                    // return false;
                }
            } else {
                //  alert('Please fill the form correctly');
            }

        });

        $('#btnBillingBack').click(function() {
            if (userName != 'anonymoususer') {
                $accor.accordion("activate", 1);
            } else {

                $('#dvCPBilling').html('');
                $accor.accordion("activate", 0);
            }
        });

        $('#btnShippingContinue').click(function() {
            if (CountAllItem == CountDownloadableItem) {
                IsDownloadItemInCartFull = true;
            } else {
                IsDownloadItemInCartFull = false;
            }
            if (v.form()) {
                if (isUserGuest == false) {
                    if ($.trim($('#ddlShipping').text()) == '' || $.trim($('#ddlShipping').text()) == null) {
                        // alert("Please visit your Dashboard to add Shipping Address!!!");
                        $('#addShippingAddress').show();
                        return false;
                    } else {
                        $.cookies.set('ShippingDetails', $('#ddlShipping option').html());
                        BindShippingData();
                        if (IsDownloadItemInCartFull) {
                            $accor.accordion("activate", 4);
                            $("#txtShippingTotal").val(0);
                        } else {
                            $accor.accordion("activate", 3);
                        }
                    }
                } else {
                    $.cookies.set('ShippingDetails', $('#ddlShipping option').html());
                    BindShippingData();
                    if (IsDownloadItemInCartFull) {
                        $accor.accordion("activate", 4);
                        $("#txtShippingTotal").val(0);
                        SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                    } else {
                        $accor.accordion("activate", 3);
                    }
                }
            } else {
                //  alert('Please fill the form correctly');
            }
        });

        $('#btnShippingBack').click(function() {
            $('#dvCPShipping').html('');
            $accor.accordion("activate", 1);
            if ($('#chkBillingAsShipping').attr('checked') == 'true' || $('#chkBillingAsShipping').attr('checked') == true) {
                $('#chkBillingAsShipping').attr('checked', false);
            }
        });

        $('#btnShippingMethodBack').click(function() {
            if ($('#chkBillingAsShipping').is(':checked')) {
                $accor.accordion("activate", 1);
            } else {
                $accor.accordion("activate", 2);
            }
        });
        $('#btnShippingMethodContinue').click(function() {
            $('#btnShippingMethodContinue').show();
            var count = 0;
            AssignItemsDetails();

            $("input[type='radio'][name='shippingRadio']").each(function() {
                if ($(this).is(':checked') == true)
                    count = 1;
            });
            if (count == 1) {
                AssignItemsDetails();
                var discountTotal = eval(TotalDiscount) + eval(CartDiscount);
                SetSessionValue("DiscountAll", discountTotal);
                //   $.cookie('Discount', eval(TotalDiscount) + eval(CartDiscount));
                SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
                var gt = $("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "");
                if (gt == 'NaN')
                    gt = 0;
                SetSessionValue("GrandTotalAll", parseFloat(gt));
                BindShippingMethodData();
                $accor.accordion("activate", 4);

            } else {
                csscody.alert("<h2>Information Message</h2><p>Please Check at least One Shipping Method.</p>");
                // $('#divShippingMethod table tr td').html('').html("  Either Items weight in your cart doesn't meet the shipping provider weight criteria or No shipping Method is set in this store!!");
                // $('#btnShippingMethodContinue').hide();
            }
            var gt1 = $("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "");
            if (gt1 == 'NaN')
                gt1 = 0;
            SetSessionValue("GrandTotalAll", parseFloat(gt1));
        });


        $('#btnPaymentInfoContinue').click(function() {
            var Total = 0;
            if (v.form()) {
                if ($.trim(country) == "United States") {
                    state = $('#ddlBLState :selected').text();
                }
                if ($.trim(spCountry) == "United States") {
                    spState = $('#ddlSPState :selected').text();
                }
                if ($('#dvPGList input:radio:checked').attr('checked') == 'checked' || $('#dvPGList input:radio:checked').attr('checked') == true) {
                    if ($.trim($('#dvPGList input:radio:checked').attr('id')) == 'rdbAIM Authorize.NET') {
                        if ($('#AIMChild').length > 0) {
                            BindPaymentData();
                            $('#txtDiscountAmount').val(parseFloat(eval(TotalDiscount) + eval(CartDiscount)).toFixed(2));
                            Total = parseFloat(eval($("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""))) + Tax + parseFloat(eval($(".total-box").val().replace( /[^-0-9\.]+/g , ""))) - eval(TotalDiscount) - eval(CartDiscount);
                            $("#txtTotalCost").val(Total.toFixed(2));
                            // $("#txtTotalCost").val(parseFloat($("#txtShippingTotal").val()) + Tax + parseFloat($(".total-box").val()) - eval(TotalDiscount) - eval(CartDiscount));
                            $('#txtTax').val(Tax.toFixed(2));
                            SetSessionValue("TaxAll", Tax);
                            var gt = $("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "");
                            if (gt == 'NaN')
                                gt = 0;
                            SetSessionValue("GrandTotalAll", parseFloat(gt));
                            $accor.accordion("activate", 5);

                            if ($("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "") < 0) {
                                csscody.alert("<h2>Information Alert</h2><p>Your cart is not eligible to checkout due to a negatve total amount!</p>");
                                $('#dvPlaceOrder .cssClassButtonWrapper ').find('input').not("#btnPlaceBack").remove();
                                $("#dvPGList input:radio").attr("disabled", "disabled");
                            } else {
                                $("#dvPGList input:radio").attr("disabled", false);
                            }

                        } else {
                        }

                    } else {
                        BindPaymentData();
                        $('#txtDiscountAmount').val(parseFloat(eval(TotalDiscount) + eval(CartDiscount)).toFixed(2));
                        Total = parseFloat($("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , "")) + Tax + parseFloat($(".total-box").val().replace( /[^-0-9\.]+/g , "")) - eval(TotalDiscount) - eval(CartDiscount);
                        $("#txtTotalCost").val(Total.toFixed(2));
                        //$("#txtTotalCost").val(parseFloat($("#txtShippingTotal").val()) + Tax + parseFloat($(".total-box").val()) - eval(TotalDiscount) - eval(CartDiscount));
                        $('#txtTax').val(Tax.toFixed(2).replace( /[^-0-9\.]+/g , ""));
                        SetSessionValue("TaxAll", Tax);
                        var gt = $("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "");
                        if (gt == 'NaN')
                            gt = 0;
                        SetSessionValue("GrandTotalAll", parseFloat(gt));
                        $accor.accordion("activate", 5);
                        if ($("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "") < 0) {
                            csscody.alert("<h2>Information Alert</h2><p>Your cart is not eligible to checkout due to a negatve total amount!</p>");
                            $('#dvPlaceOrder .cssClassButtonWrapper ').find('input').not("#btnPlaceBack").remove();
                            $("#dvPGList input:radio").attr("disabled", "disabled");
                        } else {
                            $("#dvPGList input:radio").attr("disabled", false);
                        }

                    }
                } else {
                    csscody.alert("<h2>Information Message</h2><p>Please Select your payment system.</p>");
                }
            } else {
                alert('Please fill the form correctly');
            }
            $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
        });

        $('#btnPaymentInfoBack').click(function() {
            $('#dvCPPaymentMethod').html('');
            if (IsDownloadItemInCartFull) {
                $accor.accordion("activate", 1);
                $("#txtShippingTotal").val(0);
                SetSessionValue("ShippingCostAll", $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , ""));
            } else {
                $accor.accordion("activate", 3);
            }
        });

        $('#btnPlaceBack').click(function() {
            $accor.accordion("activate", 4);
        });

        $('#chkBillingAsShipping').click(function() {
            AddBillingAsShipping();
        });

        $("#ddlSPCountry ,#ddlBLCountry ").change(function() {
            if ($.trim($("#ddlSPCountry :selected").text()) == 'United States') {
                $('#ddlSPState').show();
                $('#txtSPState').hide();
            } else {
                $('#ddlSPState').hide();
                $('#txtSPState').show();
            }

            if ($.trim($("#ddlBLCountry :selected").text()) == 'United States') {
                $('#ddlBLState').show();
                $('#txtState').hide();
            } else {
                $('#ddlBLState').hide();
                $('#txtState').show();
            }
        });
        $(".cssClassClose").click(function() {
            $('#fade, #popuprel').fadeOut();
            $('#popuprel .cssClassFormWrapper table').empty();
        });
        $('#addBillingAddress ,#addShippingAddress').click(function() {
            $('#popuprel .cssClassFormWrapper table').empty();
            $('<table  width="100%" border="0" cellpadding="0" cellspacing="0">' + $('#dvBillingInfo table').html() + '</table>').insertBefore('#popuprel .cssClassFormWrapper .cssClassButtonWrapper');
            ClearAll();
            switch ($(this).attr('id')) {
            case "addBillingAddress":
                ShowPopupControl("popuprel");
                $('#trBillingAddress ,#trShippingAddress').show();
                $("#popuprel .cssClassFormWrapper table #chkShippingAddress").attr("checked", "checked");
                $("#popuprel .cssClassFormWrapper table #chkShippingAddress").attr("disabled", "disabled");
                $("#popuprel .cssClassFormWrapper table #chkBillingAddress").attr("checked", "checked");
                $("#popuprel .cssClassFormWrapper table #chkBillingAddress").attr("disabled", "disabled");
                break;
            case "addShippingAddress":
                $('#popuprel .cssClassFormWrapper table tr:nth-child(7)').remove();
                ShowPopupControl("popuprel");
                break;
            }
            // ShowPopupControl("popuprel");
            $("#popuprel .cssClassFormWrapper table #ddlSPCountry ,#popuprel .cssClassFormWrapper table #ddlBLCountry").bind("change", function() {

                if ($.trim($("#popuprel .cssClassFormWrapper table #ddlSPCountry :selected").text()) == 'United States') {
                    $('#popuprel .cssClassFormWrapper table #ddlSPState').show();
                    $('#popuprel .cssClassFormWrapper table #txtSPState').hide();
                } else {
                    $('#popuprel .cssClassFormWrapper table #ddlSPState').hide();
                    $('#popuprel .cssClassFormWrapper table #txtSPState').show();
                }

                if ($.trim($("#popuprel .cssClassFormWrapper table #ddlBLCountry :selected").text()) == 'United States') {
                    $('#popuprel .cssClassFormWrapper table #ddlBLState').show();
                    $('#popuprel .cssClassFormWrapper table #txtState').hide();
                } else {
                    $('#popuprel .cssClassFormWrapper table #ddlBLState').hide();
                    $('#popuprel .cssClassFormWrapper table #txtState').show();
                }
            });

        });
        $('#btnSubmitAddress').click(function() {
            if (v.form()) {
                AddUpdateUserAddress();
            }
        });
        $('#trBillingAddress , #trShippingAddress').hide();
        $('#addBillingAddress , #addShippingAddress').hide();
        if ($.trim($('#ddlBilling').text()) == "" || $.trim($('#ddlBilling').text()) == null) {

            $('#addBillingAddress').show();
        } else {
            $('#addBillingAddress').hide();
        }
        if ($.trim($('#ddlShipping').text()) == "" || $.trim($('#ddlShipping').text()) == null) {
            // alert("Please visit your Dashboard to add Shipping Address!!!");
            $('#addShippingAddress').show();
        } else {
            $('#addShippingAddress').hide();
        }

        CheckDownloadableOnlyInCart();

        var register = "";
        var checkouturl = "";
        if (userFriendlyURL) {
            register = 'User-Registration.aspx';
            checkouturl = "Single-Address-Checkout.aspx";
        } else {
            register = 'User-Registration';
            checkouturl = "Single-Address-Checkout";
        }
        $('.cssClassRegisterlnk').html('<a href ="' + aspxRedirectPath + register + '?ReturnUrl=' + aspxRedirectPath + checkouturl + '"><span class="cssClassRegisterLink">Register</span></a>');

        if (IsDownloadItemInCartFull) {
            $('#dvBilling .cssClassCheckBox').hide();
        } else {
            $('#dvBilling .cssClassCheckBox').show();
        }


    });

    function CheckDownloadableOnlyInCart() {
        //        $.ajax({
        //            type: "POST",
        //            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckDownloadableItemOnly",
        //            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, sessionCode: sessionCode }),
        //            contentType: "application/json;charset=utf-8",
        //            dataType: "json",
        //            success: function(msg) {
        //                IsDownloadItemInCart = msg.d;
        if (IsDownloadItemInCart) {
            if (userName == 'anonymoususer') {
                $('.cssClassCheckOutMethodLeft p:first').html('').html('Your cart contains Digital item(s)!<br/> Checkout as <b>Existing User</b> OR <b><span class="cssClassRegisterlnk">Register</span></b> with us for future convenience:');
                $('.cssClassCheckOutMethodLeft .cssClassPadding #rdbGuest ,.cssClassCheckOutMethodLeft .cssClassPadding  #lblguest').remove();
                $('#btnCheckOutMethodContinue').hide();
                $('#rdbRegister').attr('checked', true);
                $('#dvLogin').show();
                //  $('.cssClassCheckOutMethod').html('').html('Please Register <a href ="' + aspxRedirectPath + register + '">here</a> to continue your download..');

            }
        } else {
            $('#rdbGuest').attr('checked', true);
        }
        if (CountAllItem == CountDownloadableItem) {
            IsDownloadItemInCartFull = true;
        } else {
            IsDownloadItemInCartFull = false;
        }
        if (IsDownloadItemInCartFull) {
            $('#dvBilling .cssClassCheckBox').hide();
        } else {
            $('#dvBilling .cssClassCheckBox').show();
        }
        //            },
        //            error: function() {
        //                alert("error in database connection!");
        //            }
        //        });
    }

    function AddUpdateUserAddress() {
        var addressIdX = $("#hdnAddressID").val();
        var firstNameX = $("#popuprel .cssClassFormWrapper table #txtFirstName").val();
        var lastNameX = $("#popuprel .cssClassFormWrapper table #txtLastName").val();
        var emailX = $("#popuprel .cssClassFormWrapper table #txtEmailAddress").val();
        var companyX = $("#popuprel .cssClassFormWrapper table #txtCompanyName").val();
        var address1X = $("#popuprel .cssClassFormWrapper table #txtAddress1").val();
        var address2X = $("#popuprel .cssClassFormWrapper table #txtAddress2").val();
        var cityX = $("#popuprel .cssClassFormWrapper table #txtCity").val();
        var stateX = '';
        if ($("#popuprel .cssClassFormWrapper table #ddlBLCountry :selected").text() == 'United States') {
            stateX = $("#popuprel .cssClassFormWrapper table #ddlBLState :selected").text();
        } else {
            stateX = $("#popuprel .cssClassFormWrapper table #txtState").val();
        }
        var zipX = $("#popuprel .cssClassFormWrapper table #txtZip").val();
        var phoneX = $("#popuprel .cssClassFormWrapper table #txtPhone").val();
        var mobileX = $("#popuprel .cssClassFormWrapper table #txtMobile").val();
        var faxX = '';
        if ($("#popuprel .cssClassFormWrapper table #txtFax").length > 0)
            faxX = $("#popuprel .cssClassFormWrapper table #txtFax").val();
        var webSiteX = '';
        if ($("#popuprel .cssClassFormWrapper table #txtFax").length > 0)
            webSiteX = $("#popuprel .cssClassFormWrapper table #txtWebsite").val();

        var countryNameX = $("#popuprel .cssClassFormWrapper table #ddlBLCountry :selected").text();
        var isDefaultShippingX = $("#popuprel .cssClassFormWrapper table #chkShippingAddress").attr("checked");
        var isDefaultBillingX = $("#popuprel .cssClassFormWrapper table #chkBillingAddress").attr("checked");
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateUserAddress",
            data: JSON2.stringify({
                addressID: addressIdX,
                customerID: customerId,
                firstName: firstNameX,
                lastName: lastNameX,
                email: emailX,
                company: companyX,
                address1: address1X,
                address2: address2X,
                city: cityX,
                state: stateX,
                zip: zipX,
                phone: phoneX,
                mobile: mobileX,
                fax: faxX,
                webSite: webSiteX,
                countryName: countryNameX,
                isDefaultShipping: isDefaultShippingX,
                isDefaultBilling: isDefaultBillingX,
                storeID: storeId,
                portalID: portalId,
                userName: userName,
                cultureName: cultureName
            }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function() {
                BindUserAddress();
                $('#addBillingAddress ,#addShippingAddress').hide();
                $('#fade, #popuprel').fadeOut();
            },
            error: function() {
                alert("updateerror");
            }
        });
    }

    function ClearAll() {
        $("#hdnAddressID").val(0);
        $("#txtFirstName").val('');
        $("#txtLastName").val('');
        $("#txtEmailAddress").val('');
        $("#txtCompanyName").val('');
        $("#txtAddress1").val('');
        $("#txtAddress2").val('');
        $("#txtCity").val('');
        $("#txtState").val('');
        $('#ddlBLState').val(1);
        $("#ddlBLCountry").val(1);
        $("#txtZip").val('');
        $("#txtPhone").val('');
        $("#txtMobile").val('');
        $("#txtFax").val('');
        $("#txtWebsite").val('');
        //$(".error").hide();
    }

    function ConfirmADDNewAddress(event) {
        if (event) {
            var route = '';
            if (userFriendlyURL) {
                route = aspxRedirectPath + myAccountURL + '.aspx';
            } else {
                route = aspxRedirectPath + myAccountURL;
            }
            window.location.href = route;
            return false;
        } else {
            return false;
        }
    }

    function BindBillingData() {
        $('#dvCPBilling').html('');
        var itemsarray = [];
        $('#dvBilling input:text,#dvBillingSelect option:selected').each(function() {
            var items = '';
            if ($(this).attr('class') == 'cssBillingShipping')
                items = $(this).text();
            else
                items = $(this).val();
            if (items != '') {
                itemsarray.push(items);
            }
        });

        var html = '<ul>';
        $.each(itemsarray, function(index, item) {
            if (item != '') {
                html += '<li>' + item + '</li>';
            }
        });

        html += '</ul>';
        html += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnBillingChange"><span><span>Change</span></span></button></p><div class="cssClassClear"></div></div>';
        $('#dvCPBilling').html('').append(html);
        itemsarray = [];
        $('#btnBillingChange').bind("click", function() {
            $('#dvCPBilling').html('');
            itemsarray = [];
            $accor.accordion("activate", 1);
        });
    }

    function QuantitityDiscountAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, customerID: customerId, sessionCode: sessionCode });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetDiscountQuantityAmount",
            data: param,
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                TotalDiscount = parseFloat(msg.d).toFixed(2);
            }
        });
    }

    function BindShippingData() {
        $('#dvCPShipping').html('');
        var itemsarray = [];
        $('#dvShipping input:text, #dvShippingSelect option:selected').each(function() {
            var items = '';
            if ($(this).attr('class') == 'cssBillingShipping')
                items = $(this).text();
            else
                items = $(this).val();
            itemsarray.push(items);
        });

        var html = '<ul>';
        $.each(itemsarray, function(index, item) {
            if (item != '') {
                html += '<li>' + item + '</li>';
            }
        });
        html += '</ul>';
        html += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnShippingChange"><span><span>Change</span></span></button></p><div class="cssClassClear"></div></div>';
        $('#dvCPShipping').html('').append(html);
        itemsarray = [];
        $('#btnShippingChange').bind("click", function() {
            $('#dvCPShipping').html('');
            $accor.accordion("activate", 2);
        });
    }

    function BindShippingMethodData() {
        $('#dvCPShippingMethod').html('');
        var itemsarray = [];
        var items = $('#divShippingMethod input:radio:checked').parents('tr').find('td div.cssClassCartPictureInformation h3').html();
        itemsarray.push(items);
        var html = '<ul>';
        $.each(itemsarray, function(index, item) {
            if (item != '') {
                html += '<li>' + item + '</li>';
            }
        });
        html += '</ul>';
        html += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnShippingMethodChange"><span><span>Change</span></span></button></p><div class="cssClassClear"></div></div>';
        $('#dvCPShippingMethod').html('').append(html);
        itemsarray = [];
        $('#btnShippingMethodChange').bind("click", function() {
            $('#dvCPShippingMethod').html('');
            itemsarray = [];
            $accor.accordion("activate", 3);
        });
    }

    function BindPaymentData() {
        var itemsarray = [];
        var items = '';
        items = $('#dvPGList input[type=radio]:checked').attr('realname');
        itemsarray.push(items);
        if ($('#cardType').length > 0) {
            items = $.trim($('#AIMChild input:radio:checked').nextAll().find('label').html());
            itemsarray.push(items);
        }
        //alert(itemsarray);       

        var html = '<ul>';
        $('#dvCPPaymentMethod').html('');
        $.each(itemsarray, function(index, item) {
            if (item != '') {
                html += '<li>' + item + '</li>';
            }
        });
        html += '</ul>';
        html += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnPaymentChange"><span><span>Change</span></span></button></p><div class="cssClassClear"></div></div>';
        $('#dvCPPaymentMethod').html('').append(html);
        itemsarray = [];
        $('#btnPaymentChange').bind("click", function() {
            $('#dvCPPaymentMethod').html('');
            itemsarray = [];
            if ($('#cardType').length > 0) {
                $('#cardType').remove();
            }
            $accor.accordion("activate", 4);
        });

    }

    function AddBillingAsShipping() {

        if ($('#chkBillingAsShipping').attr('checked')) {
            if ($('#dvBillingInfo').is(':hidden')) {
                $("#ddlShipping").val($("#ddlBilling").val());
                $.cookies.set('ShippingDetails', $('#ddlShipping option').html());
            } else {
                $('#txtSPFirstName').val($('#txtFirstName').val());
                $('#txtSPLastName').val($('#txtLastName').val());
                $('#txtSPEmailAddress').val($('#txtEmailAddress').val());

                $('#txtSPCompany').val($('#txtCompanyName').val());
                $('#txtSPAddress').val($('#txtAddress1').val());
                $('#txtSPAddress2').val($('#txtAddress2').val());
                $('#txtSPCity').val($('#txtCity').val());

                if ($.trim($("#ddlBLCountry :selected").text()) == 'United States') {
                    $('#ddlSPState').show();
                    $('#txtSPState').hide();
                    $('#ddlSPState').val($('#ddlBLState').val());
                } else {
                    $('#ddlSPState').hide();
                    $('#txtSPState').show();
                    $('#txtSPState').val($('#txtState').val());

                }
                $('#txtSPZip').val($('#txtZip').val());
                $('#ddlSPCountry').val($('#ddlBLCountry').val());
                $('#txtSPPhone').val($('#txtPhone').val());
                $('#txtSPMobile').val($('#txtMobile').val());
                $.cookies.set('ShippingDetails', $('#txtSPFirstName').val() + ',' + $('#txtSPLastName').val() + ',' + $('#txtSPCompany').val() + ',' + $('#txtSPAddress').val() + ',' + $('#txtSPCity').val() + ',' + $('#ddlSPState').val() + ',' + $('#txtSPZip').val() + ',' + $('#ddlSPCountry').val() + ',' + $('#txtSPPhone').val() + ',' + $('#txtSPFax').val());
            }
        } else {
            $.cookies.set('ShippingDetails', '');
            $('#txtSPFirstName').val("");
            $('#txtSPLastName').val("");
            $('#txtSPCompany').val("");
            $('#txtSPAddress').val("");
            $('#txtSPAddress2').val("");
            $('#txtSPEmailAddress').val("");
            $('#txtSPMobile').val("");
            $('#txtSPCity').val("");
            $('#ddlSPState').val(1);
            $('#txtSPState').val("");
            $('#txtSPZip').val("");
            $('#ddlSPCountry').val(1);
            $('#txtSPPhone').val("");
            $('#txtSPFax').val("");
            $('#ddlSPState').hide();
            $('#txtSPState').show();
        }
    }

    function GetCountry() {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCountryList",
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        var option = '';
                        option += "<option class='cssBillingShipping'> " + item.Text + "</option>";
                        $('#ddlBLCountry').append(option);
                        $('#ddlSPCountry').append(option);
                    });
                }
            },
            error: function(errorMessage) {
                alert('Country Error');
            }
        });
    }

    function GetState() {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindStateList",
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        var option = '';
                        option += "<option class='cssBillingShipping'> " + item.Text + "</option>";
                        $('#ddlBLState').append(option);
                        $('#ddlSPState').append(option);
                    });
                }
            },
            error: function(errorMessage) {
                alert('Country Error');
            }
        });
    }

    function GetShippinMethodsFromWeight() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetShippingMethodByWeight",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName, sessionCode: sessionCode }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {

                var shippingmethodId = 0;
                var shippingHeading = '';
                var shippingMethodElements = '';
                shippingHeading += '<table width="100%" cellspacing="0" cellpadding="0" border="0">';
                shippingHeading += '<tbody><tr class="cssClassHeadeTitle">';
                shippingHeading += '<td colspan="4">Shipping Method(s)</td>';
                shippingHeading += '</tr></tbody></table>';
                $("#divShippingMethod").html(shippingHeading);

                if (msg.d.length == 0) {
                    $('#divShippingMethod table>tbody').append("<tr><td>Items' weight in your cart doesn't meet the shipping provider weight criteria Or<br /> Shipping providers are unable to ship items!</td></tr>");
                    $('#btnShippingMethodContinue').hide();
                }

                $.each(msg.d, function(index, value) {
                    shippingMethodElements += '<tr ><td class=""><b><input name="shippingRadio" type="radio" value="' + value.ShippingMethodID + '" shippingCost=" ' + value.ShippingCost + '"/></b></td>';
                    shippingMethodElements += '<td class="">';
                    if (value.ImagePath != "") {
                        shippingMethodElements += '<p class="cssClassCartPicture"><img  alt="' + value.AlternateText + '" src="' + aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small') + '" height="83px" width="124px" /></p>';
                    }
                    shippingMethodElements += '</td>';
                    shippingMethodElements += '<td>';
                    shippingMethodElements += '<div class="cssClassCartPictureInformation">';
                    shippingMethodElements += '<h3>' + value.ShippingMethodName + '</h3>';
                    shippingMethodElements += '<p><b>Delivery Time: ' + value.DeliveryTime + '</b></p>';
                    shippingMethodElements += '</div></td>';
                    shippingMethodElements += '<td id="Fshipping"><p><b>Shipping Cost: <span class="cssClassFormatCurrency">' + value.ShippingCost + '</span></b></p></td>'
                    shippingMethodElements += '</tr>';
                    if (index == 0) {
                        shippingmethodId = value.ShippingMethodID
                    }
                });

                $("#divShippingMethod").find("table>tbody").append(shippingMethodElements);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                $("#divShippingMethod").find("table>tbody tr:even").addClass("cssClassAlternativeEven");
                $("#divShippingMethod").find("table>tbody tr:odd").addClass("cssClassAlternativeOdd");
                if (IsFShipping.toLowerCase() == 'true') {
                    $('#Fshipping p b').html('');
                    $('#Fshipping p b').html('Shipping Cost: 0.00 (free shipping)');
                    $('#txtShippingTotal').val('0.00');
                }
                //$("input[type='radio'][name='shippingRadio'][value=" + shippingmethodId + "]").attr("checked", "checked");
                // $("#txtShippingTotal").val('').val($("input[type='radio'][name='shippingRadio'][value=" + shippingmethodId + "]").attr("shippingCost"));
                spMethodID = shippingmethodId;

                $("input[type='radio'][name='shippingRadio']").bind("change", function() {
                    $(this).attr("checked", "checked");
                    spMethodID = $(this).attr("value");
                    spCost = $(this).attr("shippingCost");
                    GetDiscountCartPriceRule(CartID, spCost);
                    $("#txtShippingTotal").val('').val($(this).attr("shippingCost"));
                    if (IsFShipping.toLowerCase() == 'true') {
                        $('#Fshipping p b').html('');
                        $('#Fshipping p b').html('Shipping Cost: 0.00 (free shipping)');
                        $('#txtShippingTotal').val('0.00');
                    }
                    $("#txtTotalCost").val(parseFloat($("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , "")) + Tax + parseFloat($(".total-box").val().replace( /[^-0-9\.]+/g , "")) - eval(TotalDiscount) - eval(CartDiscount));
                    spCost = $("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , "");
                });
                $('#txtDiscountAmount').val(parseFloat(TotalDiscount + CartDiscount).toFixed(2));
                $("#txtTotalCost").val(parseFloat($("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , "")) + Tax + parseFloat($(".total-box").val().replace( /[^-0-9\.]+/g , "")) - eval(TotalDiscount) - eval(CartDiscount));
            },
            error: function() {
                alert("Shipping Method Error");
            }
        });
    }

    function GetDiscountCartPriceRule(CartID, SpCost) {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetDiscountPriceRule",
            data: JSON2.stringify({ cartID: CartID, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, shippingCost: SpCost }),

            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d.length > 0) {
                    //alert(msg.d);
                    CartDiscount = parseFloat(msg.d).toFixed(2);

                }
            },
            error: function(errorMessage) {
                alert('Cart Price Error');
            }
        });
    }

    function GetUserCartDetails() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCartDetails",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName, sessionCode: sessionCode }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var cartHeading = '';
                var cartElements = '';

                cartHeading += '<table width="100%" border="0" cellpadding="0" cellspacing="0" id="tblCartList">';
                cartHeading += '<tbody><tr class="cssClassHeadeTitle">';
                cartHeading += '<td class="cssClassSN"> Sn.';
                cartHeading += ' </td><td class="cssClassProductImageWidth">';
                cartHeading += 'Item Image';
                cartHeading += '</td><td>';
                cartHeading += 'Description';
                cartHeading += '</td>';
                cartHeading += '<td>';
                cartHeading += 'Variants';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassQTY">';
                cartHeading += ' Qty';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassTimes">';
                cartHeading += 'X';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassProductPrice">';
                cartHeading += 'Unit Price';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassEquals">';
                cartHeading += '=';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassSubTotal">';
                cartHeading += 'SubTotal';
                cartHeading += '</td>';
                cartHeading += '<td class="cssClassTaxRate">';
                cartHeading += 'Unit Tax';
                cartHeading += '</td>';
                cartHeading += '</tr>';
                cartHeading += '</table>';
                $("#divCartDetails").html(cartHeading);
                $.each(msg.d, function(index, value) {
                    index = index + 1;
                    if (value.ImagePath == "") {
                        value.ImagePath = '<%= noImageCheckOutInfoPath %>';
                    } else if (value.AlternateText == "") {
                        value.AlternateText = value.Name;
                    }
                    if (parseInt(value.ItemTypeID) == 2) {
                        IsDownloadItemInCart = true;
                        CountDownloadableItem++;
                    }
                    CountAllItem++;
                    cartElements += '<tr >';
                    cartElements += '<td>';
                    cartElements += '<b>' + index + "." + '</b>';
                    cartElements += '</td>';
                    cartElements += '<td>';
                    cartElements += '<p class="cssClassCartPicture">';
                    cartElements += '<img src="' + aspxRootPath + value.ImagePath.replace('uploads', 'uploads/Small') + '" ></p>';
                    cartElements += '</td>';
                    cartElements += '<td>';
                    cartElements += '<div class="cssClassCartPictureInformation">';
                    cartElements += '<h3>';
                    cartElements += '<a class="cssClassLink" id="item_' + value.ItemID + '" itemType="' + value.ItemTypeID + '"  href="' + aspxRedirectPath + 'item/' + value.SKU + '.aspx">' + value.ItemName + ' </a></h3>';
                    cartElements += '<p>';
                    cartElements += '' + Encoder.htmlDecode(value.ShortDescription) + '';
                    cartElements += '</p>';
                    cartElements += '</div>';
                    cartElements += '</td>';
                    cartElements += '<td class="row-variants" varIDs="' + value.CostVariantsValueIDs + '">';
                    cartElements += '' + value.CostVariants + '';
                    cartElements += '</td>';
                    cartElements += '<td class="cssClassPreviewQTY">';
                    cartElements += '<input class="num-pallets-input" taxrate="' + (value.TaxRateValue * rate).toFixed(2) + '" price="' + value.Price + '" id="txtQuantity_' + value.CartID + '" type="text" readonly="readonly" value="' + value.Quantity + '">';
                    cartElements += '</td>';
                    cartElements += '<td class="cssClassTimes">';
                    cartElements += ' X';
                    cartElements += '</td>';
                    cartElements += '<td class="price-per-pallet">';
                    cartElements += '<span id="' + value.Weight + '" class="cssClassFormatCurrency">' + (value.Price * rate).toFixed(2) + '</span>';
                    cartElements += '</td>';
                    cartElements += '<td class="cssClassEquals">';
                    cartElements += '=';
                    cartElements += '</td>';
                    cartElements += '<td class="row-total">';
                    cartElements += '<input class="row-total-input cssClassFormatCurrency" id="txtRowTotal_' + value.CartID + '"  value="' + (value.TotalItemCost * rate).toFixed(2) + '"  readonly="readonly" type="text" />';
                    cartElements += '</td>';
                    cartElements += '<td class="row-taxRate">';
                    cartElements += '<span class="cssClassFormatCurrency">' + (value.TaxRateValue * rate).toFixed(2) + '</span>';
                    cartElements += '</td>';
                    cartElements += '</tr>';
                    CartID = value.CartID;
                });
                $("#tblCartList").append(cartElements);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                $("#tblCartList tr:even ").addClass("cssClassAlternativeEven");
                $("#tblCartList tr:odd ").addClass("cssClassAlternativeOdd");

                var subTotalAmount = 0.00;
                $(".row-total-input").each(function() {
                    subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val().replace( /[^-0-9\.]+/g , ""));
                    $.cookies.set('Total', subTotalAmount.toFixed(2).replace( /[^-0-9\.]+/g , ""));
                });

                Tax = 0.00;
                $(" .cssClassPreviewQTY .num-pallets-input").each(function() {
                    Tax += $(this).val() * $(this).attr("taxrate");
                });
                SetSessionValue("TaxAll", Tax);
                $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                //  alert(subTotalAmount.toFixed(2));
                $(".num-pallets-input").bind("keypress", function(e) {
                    if ($(this).val() == "") {
                        if (e.which != 8 && e.which != 0 && (e.which < 49 || e.which > 57)) {
                            return false;
                        }
                    } else {
                        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                            return false;
                        }
                    }
                });
                $(".num-pallets-input").bind("keyup", function(e) {
                    var subTotalAmount = 0;
                    var cartId = parseInt($(this).attr("id").replace( /[^0-9]/gi , ''));
                    $(this).closest('tr').find("#txtRowTotal_" + cartId + "").val($(this).val() * $(this).attr("price"));
                    $(".row-total-input").each(function() {
                        subTotalAmount = parseFloat(subTotalAmount) + parseFloat($(this).val().replace( /[^0-9]/gi , ''));
                    });
                    $(".total-box").val('').attr("value", subTotalAmount.toFixed(2));
                    if (IsFShipping.toLowerCase() == 'true') {
                        $('#Fshipping p b').html('');
                        $('#Fshipping p b').html('ShippingCost: 0.00 (free shipping)');
                        $('#txtShippingTotal').val('0.00');
                    }
                    $('#txtTax').val(Tax.toFixed(2));
                    $('#txtDiscountAmount').val(parseFloat(TotalDiscount).toFixed(2) + parseFloat(CartDiscount).toFixed(2));
                    $("#txtTotalCost").val(parseFloat($("#txtShippingTotal").val().replace( /[^-0-9\.]+/g , "")) + parseFloat(Tax) + parseFloat($(".total-box").val().replace( /[^-0-9\.]+/g , "")) - parseFloat(TotalDiscount) - parseFloat(CartDiscount));
                    var gt = $("#txtTotalCost").val().replace( /[^-0-9\.]+/g , "");
                    if (gt == 'NaN')
                        gt = 0;
                    SetSessionValue("GrandTotalAll", parseFloat(gt));
                    $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
                });
                if ($('#lnkMyCart').find('.cssClassTotalCount').text().replace('[', '').replace(']', '') == '0') {
                    $('.cssClassAccordionWrapper').hide();
                    $('.cssClassRightAccordainTab').hide();
                    $('.cssClassBodyContentWrapper').append("<div id ='msgnoitem' class='cssClassCommonBox Curve'><div class='cssClassHeader'><h2> <span id='spnheader'>Message </span></h2> <div class='cssClassClear'> </div></div><div class='cssClassGridWrapper'><div class='cssClassGridWrapperContent'><h3> No Items found in your Cart</h3><div class='cssClassButtonWrapper'><button type='button' id='btnContinueInStore'><span><span>Continue to Shopping</span></span></button></div><div class='cssClassClear'></div></div></div></div>");

                    $("#btnContinueInStore").click(function() {
                        if (userFriendlyURL) {
                            window.location.href = aspxRedirectPath + 'Home.aspx';
                        } else {
                            window.location.href = aspxRedirectPath + 'Home';
                        }
                        return false;
                    });
                }
                AssignItemsDetails();
                CheckDownloadableOnlyInCart();

            },
            error: function() {
                alert("Items Detail Error");
            }
        });

    }

    function AssignItemsDetails() {
        $('#tblCartList tr').not('.cssClassHeadeTitle').each(function(i, v) {
            ID = $(this).find('a').attr("id").replace( /[^0-9]/gi , '');
            ItemType = parseInt($(this).find('a').attr("itemType"));
            if ($(this).find("input[class='num-pallets-input']").val() != "null")
                qty = $(this).find("input[class='num-pallets-input']").val();
            else {
                qty = 0;
            }
            if ($(this).find("input[class='num-pallets-input']").attr('price') != "null") {
                price = $(this).find("input[class='num-pallets-input']").attr('price');

            } else {
                price = 0.00;
            }
            if ($(this).find("td.price-per-pallet").find('span').attr('id') != "null")
                weight = $(this).find("td.price-per-pallet").find('span').attr('id');
            else {
                weight = 0;
            }

            if ($('#dvShippingSelect option:selected').val() > 0)
                spAddressID = $('#dvShippingSelect option:selected').val();


            var costvariants = '';
            if ($.trim($(this).find(".row-variants").html()) != '') {
                costvariants = $.trim($(this).find(".row-variants").attr('varIDs'));
            } else {
                costvariants = 0;
            }


            if (parseInt(ItemType) == 2) {
                lstItems[i] = { "OrderID": 0, "ShippingAddressID": 0, "ShippingMethodID": 0, "ItemID": ID, "Variants": costvariants, "Quantity": qty, "Price": parseFloat(price), "Weight": 0, "Remarks": '', "orderItemRemarks": '', "ShippingRate": 0, 'IsDownloadable': true };

            } else {
                lstItems[i] = { "OrderID": 0, "ShippingAddressID": spAddressID, "ShippingMethodID": spMethodID, "ItemID": ID, "Variants": costvariants, "Quantity": qty, "Price": parseFloat(price), "Weight": parseFloat(weight), "Remarks": '', "orderItemRemarks": '', "ShippingRate": spCost, 'IsDownloadable': false };

            }


        });
    }

    function BindUserAddress() {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAddressBookDetails",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                var option = '';
                var optionBilling = '';
                var pattern = ",", re = new RegExp(pattern, "g");

                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        if (item.DefaultShipping == 1) {
                            option += "<option value=" + item.AddressID + " selected='selected' class='cssBillingShipping'> ";
                            option += item.FirstName.replace(re, "-") + " " + item.LastName.replace(re, "-");
                            if (item.Address1 != "")
                                option += ", " + item.Address1.replace(re, "-");

                            if (item.City != "")
                                option += ", " + item.City.replace(re, "-");

                            if (item.State != "")
                                option += ", " + item.State.replace(re, "-");

                            if (item.Country != "")
                                option += ", " + item.Country.replace(re, "-");

                            if (item.Zip != "")
                                option += ", " + item.Zip.replace(re, "-");

                            if (item.Email != "")
                                option += ", " + item.Email.replace(re, "-");

                            if (item.Phone != "")
                                option += ", " + item.Phone.replace(re, "-");

                            if (item.Mobile != "")
                                option += ", " + item.Mobile.replace(re, "-");

                            if (item.Fax != "")
                                option += ", " + item.Fax.replace(re, "-");

                            if (item.Website != "")
                                option += ", " + item.Website.replace(re, "-");

                            if (item.Address2 != "")
                                option += ", " + item.Address2.replace(re, "-");

                            if (item.Company != "")
                                option += ", " + item.Company.replace(re, "-");
                        } else {
                            option += "<option value=" + item.AddressID + " class='cssBillingShipping'> ";
                            option += item.FirstName.replace(re, "-") + " " + item.LastName.replace(re, "-");
                            if (item.Address1 != "")
                                option += ", " + item.Address1.replace(re, "-");

                            if (item.City != "")
                                option += ", " + item.City.replace(re, "-");

                            if (item.State != "")
                                option += ", " + item.State.replace(re, "-");

                            if (item.Country != "")
                                option += ", " + item.Country.replace(re, "-");

                            if (item.Zip != "")
                                option += ", " + item.Zip.replace(re, "-");

                            if (item.Email != "")
                                option += ", " + item.Email.replace(re, "-");

                            if (item.Phone != "")
                                option += ", " + item.Phone.replace(re, "-");

                            if (item.Mobile != "")
                                option += ", " + item.Mobile.replace(re, "-");

                            if (item.Fax != "")
                                option += ", " + item.Fax.replace(re, "-");

                            if (item.Website != "")
                                option += ", " + item.Website.replace(re, "-");

                            if (item.Address2 != "")
                                option += ", " + item.Address2.replace(re, "-");

                            if (item.Company != "")
                                option += ", " + item.Company.replace(re, "-");

                        }

                        if (item.DefaultBilling == 1) {
                            optionBilling += "<option value=" + item.AddressID + " selected='selected' class='cssBillingShipping'> ";
                            optionBilling += item.FirstName.replace(re, "-") + " " + item.LastName.replace(re, "-");
                            if (item.Address1 != "")
                                optionBilling += ", " + item.Address1.replace(re, "-");

                            if (item.City != "")
                                optionBilling += ", " + item.City.replace(re, "-");

                            if (item.State != "")
                                optionBilling += ", " + item.State.replace(re, "-");

                            if (item.Country != "")
                                optionBilling += ", " + item.Country.replace(re, "-");

                            if (item.Zip != "")
                                optionBilling += ", " + item.Zip.replace(re, "-");

                            if (item.Email != "")
                                optionBilling += ", " + item.Email.replace(re, "-");

                            if (item.Phone != "")
                                optionBilling += ", " + item.Phone.replace(re, "-");

                            if (item.Mobile != "")
                                optionBilling += ", " + item.Mobile.replace(re, "-");

                            if (item.Fax != "")
                                optionBilling += ", " + item.Fax.replace(re, "-");

                            if (item.Website != "")
                                optionBilling += ", " + item.Website.replace(re, "-");

                            if (item.Address2 != "")
                                optionBilling += ", " + item.Address2.replace(re, "-");

                            if (item.Company != "")
                                optionBilling += ", " + item.Company.replace(re, "-");
                        } else {
                            optionBilling += "<option value=" + item.AddressID + " class='cssBillingShipping'> ";
                            optionBilling += item.FirstName.replace(re, "-") + " " + item.LastName.replace(re, "-");
                            if (item.Address1 != "")
                                optionBilling += ", " + item.Address1.replace(re, "-");

                            if (item.City != "")
                                optionBilling += ", " + item.City.replace(re, "-");

                            if (item.State != "")
                                optionBilling += ", " + item.State.replace(re, "-");

                            if (item.Country != "")
                                optionBilling += ", " + item.Country.replace(re, "-");

                            if (item.Zip != "")
                                optionBilling += ", " + item.Zip.replace(re, "-");

                            if (item.Email != "")
                                optionBilling += ", " + item.Email.replace(re, "-");

                            if (item.Phone != "")
                                optionBilling += ", " + item.Phone.replace(re, "-");

                            if (item.Mobile != "")
                                optionBilling += ", " + item.Mobile.replace(re, "-");

                            if (item.Fax != "")
                                optionBilling += ", " + item.Fax.replace(re, "-");

                            if (item.Website != "")
                                optionBilling += ", " + item.Website.replace(re, "-");

                            if (item.Address2 != "")
                                optionBilling += ", " + item.Address2.replace(re, "-");

                            if (item.Company != "")
                                optionBilling += ", " + item.Company.replace(re, "-");
                        }
                    });
                    $("#ddlShipping").html(option);
                    $("#ddlBilling").html(optionBilling);
                    if ($.trim($('#ddlBilling').text()) == "" || $.trim($('#ddlBilling').text()) == null) {

                        $('#addBillingAddress').show();
                    } else {
                        $('#addBillingAddress').hide();
                    }
                    if ($.trim($('#ddlShipping').text()) == "" || $.trim($('#ddlShipping').text()) == null) {
                        // alert("Please visit your Dashboard to add Shipping Address!!!");
                        $('#addShippingAddress').show();
                    } else {
                        $('#addShippingAddress').hide();
                    }
                }
            },
            error: function(errorMessage) {
                alert('Address Error');
            }
        });
    }

    function SetSessionValue(sessionKey, sessionValue) {
        //  SetSessionValue("DiscountAll")
        //  SetSessionValue("TaxAll")
        //  SetSessionValue("ShippingCostAll")
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SetSessionVariable",
            data: JSON2.stringify({ key: sessionKey, value: sessionValue }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            async: false,
            success: function() {
            },
            error: function() {
                //csscody.alert("error");
            }
        });
    }

    function LoadPGatewayList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetPGList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        //<input id="rdbCheck" type="radio" name="paymentType" class="cssClassRadioBtn" /><b><label> Check/MoneyOrder</label></b><br />
                        //_type":"PaymentGatewayListInfo:#ASPXCommerce.Core","ControlSource":"Modules\/ASPXCommerce\/PayPal\/paypal.ascx","PaymentGatewayTypeID":2,"PaymentGatewayTypeName":"PayPal"}]}

                        $('#dvPGList').append('<input id="rdb' + item.PaymentGatewayTypeName + '" name="PGLIST" type="radio" realname="' + item.PaymentGatewayTypeName + '" friendlyname="' + item.FriendlyName + '"  source="' + item.ControlSource + '" value="' + item.PaymentGatewayTypeID + '" class="cssClassRadioBtn" /><b><label> ' + item.PaymentGatewayTypeName + '</label></b><br />');

                    });
                    $('#dvPGList input[name="PGLIST"]').bind("click", function() {
                        SetSessionValue("Gateway", $(this).attr('value'));
                        if ('paypal' == $(this).attr('friendlyname').toLowerCase()) {
                            paymentMethodCode = "Paypal";
                            paymentMethodName = "Paypal";
                        } else {
                        }

                        if ('aimauthorize' == $.trim($(this).attr('friendlyname').toLowerCase())) {

                            LoadControl($(this).attr('source'), $.trim($(this).attr('friendlyname')));
                        } else {
                            LoadControl($(this).attr('source'), $(this).attr('friendlyname'));
                            $('#dvCheque').hide();
                            $('#creditCard').hide();
                            $('#AIMChild').hide();
                            $('#dvPaymentInfo input[type="button"]').remove();
                        }
                    });
                }
            },
            error: function(errorMsg) {
            }
        });
    }

    function LoadControl(ControlName, Name) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "LoadControlHandler.aspx/Result",
            data: "{ controlName:'" + aspxRootPath + ControlName + "'}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(response) {
                if (Name.toLowerCase() == 'aimauthorize') {
                    $('#dvCheque').remove();
                    $('#creditCard').remove();
                    $('#AIMChild').remove();
                    $('#dvPaymentInfo input[type="button"]').remove();
                    $('#dvPaymentInfo .cssClassButtonWrapper').before(response.d);
                    $('#dvPaymentInfo input[type="button"]').remove();
                    $('#dvPlaceOrder .cssClassButtonWrapper ').find('input').not("#btnPlaceBack").remove();
                    $('#dvPlaceOrder .cssClassButtonWrapper ').append(response.d);
                    $('#dvPlaceOrder .cssClassButtonWrapper div ').remove();
                } else {
                    $('#dvPlaceOrder .cssClassButtonWrapper ').find('input').not("#btnPlaceBack").remove();
                    $('#dvPlaceOrder .cssClassButtonWrapper ').append(response.d);
                }

            },
            error: function() {
                alert("error");
            }
        });
    }

</script>

<div id="SingleCheckOut">
</div>
<div class="cssClassCheckout">
    <div class="cssClassAccordionWrapper">
        <div id="accordion" class="accordion">
            <div class="accordionHeading">
                <h2>
                    <span>1</span><b>Checkout Method</b></h2>
            </div>
            <div class="cssClassFormWrapper">
                <div class="cssClassCheckOutMethod">
                    <div class="cssClassCheckOutMethodLeft">
                        <p>
                            Checkout as a <b>Guest</b> or <b>Register</b> with us for future convenience:</p>
                        <p class="cssClassPadding">
                            <input id="rdbGuest" type="radio" class="cssClassRadioBtn" name="guestOrRegister" />
                            <label id="lblguest">
                                <b>Checkout as Guest</b></label>
                            <br />
                            <input id="rdbRegister" type="radio" class="cssClassRadioBtn" name="guestOrRegister" />
                            <label>
                                <b>Registered User</b></label>
                        </p>
                        <br />
                        <p>
                            <span class="cssClassRegisterlnk">Register</span> and save time!<br />
                            <span class="cssClassRegisterlnk">Register</span> with us for future convenience:<br /><br />
                        </p>
                        <p class="cssClassSmallFont">
                            - Fast and easy check out<br />
                            - Easy access to your order history and status<br />
                            - To Track your Digital Purchase
                        </p>
                        <div class="cssClassButtonWrapper ">
                            <button id="btnCheckOutMethodContinue" type="button">
                                <span><span>Continue</span></span></button>
                        </div>
                    </div>
                    <asp:UpdatePanel ID="udpLogin" runat="server">
                        <ContentTemplate>
                            <div id="dvLogin" class="cssClassCheckOutMethodRight">
                                <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="View1" runat="server">
                                        <div class="cssClassloginbox">
                                            <div class="cssClassloginboxInside">
                                                <div class="cssClassloginboxInsideDetails">
                                                    <div class="cssClassLoginLeftBox">
                                                        <div class="cssClassadminloginHeading">
                                                            <h1>
                                                                <asp:Label ID="lblAdminLogin" runat="server" Text="Login" meta:resourcekey="lblAdminLoginResource1"></asp:Label>
                                                            </h1>
                                                        </div>
                                                        <div class="cssClassadminloginInfo">
                                                            <table border="0" cellpadding="0" width="100%" class="cssClassnormalborder">
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="cssClassNormalText"
                                                                                   meta:resourcekey="UserNameLabelResource1">User Name:</asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <p class="cssClassTextBox">
                                                                            <asp:TextBox ID="UserName" runat="server" meta:resourcekey="UserNameResource1"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                                                                                        ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login1"
                                                                                                        CssClass="cssClassusernotfound" meta:resourcekey="UserNameRequiredResource1">*</asp:RequiredFieldValidator>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="PasswordASPX" CssClass="cssClassNormalText"
                                                                                   meta:resourcekey="PasswordLabelResource1">Password:</asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <p class="cssClassTextBox">
                                                                            <asp:TextBox ID="PasswordASPX" runat="server" TextMode="Password" meta:resourcekey="PasswordResource1"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="PasswordASPX"
                                                                                                        ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login1"
                                                                                                        CssClass="cssClassusernotfound" meta:resourcekey="PasswordRequiredResource1">*</asp:RequiredFieldValidator>
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td width="118">
                                                                        <table width="118" border="0" cellspacing="0" cellpadding="0">
                                                                            <tr>
                                                                                <td width="18">
                                                                                    <asp:CheckBox ID="RememberMe" runat="server" CssClass="cssClassCheckBox" meta:resourcekey="RememberMeResource1" />
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="lblrmnt" runat="server" Text="Remember me." CssClass="cssClassRemember"
                                                                                               meta:resourcekey="lblrmntResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td colspan="2">
                                                                                    <span class="cssClassForgetPass">
                                                                                        <asp:HyperLink ID="hypForgetPassword" runat="server" Text="Foget Password?" meta:resourcekey="hypForgetPasswordResource1"></asp:HyperLink>
                                                                                    </span>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td width="120">
                                                                                    <div class="cssClassButtonWrapper">
                                                                                        <span><span>
                                                                                                  <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Sign In" ValidationGroup="Login1"
                                                                                                              OnClick="LoginButton_Click" meta:resourcekey="LoginButtonResource1" />
                                                                                              </span></span>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" class="cssClassusernotfound">
                                                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False" meta:resourcekey="FailureTextResource1"></asp:Literal>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </div>
                                                    <div class="cssClassLoginRighttBox" runat="server" id="divSignUp">
                                                        <h2>
                                                            <span>New here?</span>
                                                        </h2>
                                                        <p>
                                                            <a href="/User-Registration.aspx" runat="server" id="signup">Sign up</a> for a new
                                                            account</p>
                                                        <div class="cssClassNewSIgnUp">
                                                            <span>»</span><a href="/User-Registration.aspx" runat="server" id="signup1">Sign up</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </asp:View>
                                    <asp:View ID="View2" runat="server">
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                            <div class="cssClassclear">
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="accordionHeading">
                <h2>
                    <span>2</span><b>Billing Information</b></h2>
            </div>
            <div id="dvBilling" class="cssClassCheckoutInformationContent">
                <div id="dvBillingInfo" class="cssClassCheckoutLeftBox">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:Label ID="lblFirstName" runat="server" Text="FirstName" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td >
                                    <input type="text" id="txtFirstName" name="FirstName" class="required" minlength="2" maxlength="40"/>
                                </td>
                                <td>
                                    <asp:Label ID="lblLastName" runat="server" Text="LastName:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                         class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtLastName" name="LastName" class="required" minlength="2" maxlength="40" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                   class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtEmailAddress" name="Email" class="required email" minlength="2" />
                                </td>
                                <td>
                                    <asp:Label ID="lblCompany" Text="Company:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtCompanyName" maxlength="40" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblAddress1" Text="Address1:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                         class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtAddress1" name="Address1" class="required" minlength="2" maxlength="250" />
                                </td>
                                <td>
                                    <asp:Label ID="lblAddress2" Text="Address2:" runat="server" CssClass="cssClassLabel" ></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtAddress2" maxlength="250" name="Address2"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCountry" Text="Country:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                       class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <select id="ddlBLCountry" class="cssClassDropDown">
                                    </select>
                                </td>
                   
                                <td>
                                    <asp:Label ID="lblState" Text="State/Province:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                            class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtState" name="stateprovince" class="required" minlength="2" maxlength="250" /> <select id="ddlBLState" class="cssClassDropDown">
                                                                                                                                            </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblZip" Text="Zip/Postal Code:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                           class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtZip" name="biZip" class="required number" minlength="5" maxlength="10"/>
                                </td>
                                <td>
                                    <asp:Label ID="lblCity" Text="City:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                 class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtCity" name="City" class="required" minlength="2" maxlength="250"  />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblPhone" Text="Phone:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                   class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtPhone" name="Phone" class="required number" minlength="7" maxlength="20" />
                                </td>
                                <td>
                                    <asp:Label ID="lblMobile" Text="Mobile:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtMobile"  class="number" name="mobile" maxlength="20" />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblFax" Text="Fax:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtFax" name="Fax" class="number" maxlength="20" />
                                </td>
                                <td>
                                    <asp:Label ID="lblWebsite" Text="Website:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtWebsite" class="url" maxlength="30"  />
                                </td>
                            </tr>
                            <tr id="trShippingAddress">
                                <td>
                                    <input type="checkbox" id="chkShippingAddress" />
                                </td>
                                <td>
                                    <asp:Label ID="lblDefaultShipping" Text=" Use as Default Shipping Address" runat="server"
                                               CssClass="cssClassLabel"></asp:Label>
                                </td>
                            </tr>
                            <tr id="trBillingAddress">
                                <td>
                                    <input type="checkbox" id="chkBillingAddress" />
                                </td>
                                <td>
                                    <asp:Label ID="lblDefaultBilling" Text="Use as Default Billing Address" runat="server"
                                               CssClass="cssClassLabel"></asp:Label>
                                </td>
                            </tr>
               
                        </tbody>
                    </table>
                    <input type="hidden" id="hdnAddressID" />
                    <p class="cssClassRequired">
                        * required</p>
                </div>
                <div id="dvBillingSelect">
                    <label>
                        Billing Address : <span class="cssClassRequired">*</span></label>
                    <select id="ddlBilling">
                    </select>
                    <div class="cssClassButtonWrapper cssClassRightBtn">
                        <button id="addBillingAddress" type="button" value="Add Billing Address">
                            <span><span>Add Billing Address</span></span></button>
                    </div>
                </div>
                <p class="cssClassCheckBox">
                    <input id="chkBillingAsShipping" type="checkbox" /><span> Use Billing Address As Shipping
                                                                           Address</span>
                </p>
                <div class="cssClassButtonWrapper cssClassRightBtn">
                    <button id="btnBillingBack" type="button" value="back" class="back">
                        <span><span>Back</span></span></button>
                    <button id="btnBillingContinue" type="button" value="next" class="next">
                        <span><span>Continue</span></span></button>
                </div>
                <div class="cssClassClear">
                </div>
            </div>
            <div class="accordionHeading">
                <h2>
                    <span>3</span><b>Shipping Information</b></h2>
            </div>
            <div id="dvShipping" class="cssClassCheckoutInformationContent">
                <div id="dvShippingInfo" class="cssClassCheckoutLeftBox">
                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tbody>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSPFirstName" runat="server" Text="FirstName" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td >
                                    <input id="txtSPFirstName" name="spFName" type="text" class="required" minlength="2" maxlength="40" />
                                </td>
                                <td>
                                    <asp:Label ID="lblSPLastName" runat="server" Text="LastName:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                           class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input id="txtSPLastName" name="spLName" type="text" class="required" minlength="2" maxlength="40" />
                                </td>
                            </tr>
                            <tr>  
                                <td>
                                    <asp:Label ID="lblSPEmail" runat="server" Text="Email:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                     class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtSPEmailAddress" name="Email" class="required email" minlength="2" />
                                </td>                
                                <td>
                                    <asp:Label ID="lblSPCompany" Text="Company:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input id="txtSPCompany" type="text" maxlength="50" name="SPCompany" />
                                </td>
                   
                            </tr>
                            <tr> 
                                <td>
                                    <asp:Label ID="lblSPAddress1" Text="Address1:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                           class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input id="txtSPAddress" name="spAddress1" type="text" class="required" minlength="2" maxlength="250" />
                                </td>                   
                                <td>
                                    <asp:Label ID="lblSPAddress2" Text="Address2:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtSPAddress2" maxlength="250" name="SPAddress2" />
                                </td>
                    
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSPCountry" Text="Country:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                         class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <select id="ddlSPCountry">                           
                                    </select>
                                </td>                 
                                <td>
                                    <asp:Label ID="lblSPState" Text="State/Province:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                              class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtSPState" name="spstateprovince" class="required" minlength="2" maxlength="250"  />  <select id="ddlSPState" class="cssClassDropDown">
                                                                                                                                                  </select>
                                </td>
                   
                            </tr>
                            <tr>
                  
                                <td>
                                    <asp:Label ID="lblSPCity" Text="City:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                   class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input type="text" id="txtSPCity" name="City" class="required" minlength="2" maxlength="250" />
                                </td>  <td>
                                           <asp:Label ID="lblSPZip" Text="Zip/Postal Code:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                                    class="cssClassRequired">*</span>
                                       </td>
                                <td>
                                    <input id="txtSPZip" name="spZip" type="text" class="required number" minlength="5" maxlength="10" />
                                </td> 
                                      
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblSPPhone" Text="Phone:" runat="server" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                     class="cssClassRequired">*</span>
                                </td>
                                <td>
                                    <input id="txtSPPhone" name="spPhone" type="text" class="required number" minlength="7" maxlength="20" />
                                </td>  
                                <td>
                                    <asp:Label ID="lblSPMobile" Text="Mobile:" runat="server" CssClass="cssClassLabel"></asp:Label>
                                </td>
                                <td>
                                    <input type="text" id="txtSPMobile" name="spmobile"   class="number"  minlength="10" maxlength="20" />
                                </td>                       
                            </tr>                  
          
                        </tbody>
                    </table>
                    <p class="cssClassRequired">
                        * required</p>
                </div>
                <div id="dvShippingSelect">
                    <label>
                        Shipping Address : <span class="cssClassRequired">*</span></label>
                    <select id="ddlShipping">
                    </select>
                    <div class="cssClassButtonWrapper cssClassRightBtn">
                        <button id="addShippingAddress" type="button" value="Add Shipping Address">
                            <span><span>Add Shipping Address</span></span></button>
                    </div>
                </div>
                <div class="cssClassClear">
                </div>
                <div class="cssClassButtonWrapper">
                    <div class="cssClassButtonWrapper cssClassRightBtn">
                        <button id="btnShippingBack" type="button" value="back" class="back">
                            <span><span>Back</span></span></button>
                        <button id="btnShippingContinue" type="button" value="continue" class="continue">
                            <span><span>Continue</span></span></button>
                    </div>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="accordionHeading">
                <h2>
                    <span>4</span><b>Shipping Method </b>
                </h2>
            </div>
            <div id="dvPaymentsMethod" class="cssClassButtonWrapper">
                <div id="divShippingMethod" class="cssClassShippingMethodInfo cssClassCartInformation">
                </div>
                <div class="cssClassButtonWrapper cssClassRightBtn">
                    <button id="btnShippingMethodBack" type="button" value="back" class="back">
                        <span><span>Back</span></span></button>
                    <button id="btnShippingMethodContinue" type="button" value="continue" class="continue">
                        <span><span>Continue</span></span></button>
                </div>
                <div class="cssClassClear">
                </div>
            </div>
            <%--      <div class="accordionHeading">
                <h2>
                    <span>4</span><b>Shipping Method </b></h2>
            </div>
            <div id="dvPaymentsMethod" class="cssClassButtonWrapper">
            <div id="divPaymentMethods">
                            
                        
                </div>
				<div id="divPaymentSubTypes" class="cssClassButtonWrapper"></div>
				 <div class="cssClassButtonWrapper cssClassRightBtn">
                
                 <button id="btnPaymentGatewayTypeBack"  type="button" value="back" class="back" ><span><span>Back</span></span></button>
                        <button id="btnPaymentGatewayTypeContinue"  type="button" value="continue" class="continue" ><span><span>Continue</span></span></button>
                    
                        </div>
				
                <div class="cssClassClear">
                </div>
            </div>--%>
            <div class="accordionHeading">
                <h2>
                    <span>5</span><b>Payment Information</b></h2>
            </div>
            <div id="dvPaymentInfo" class="cssClassPaymentMethods">
                <div id="dvPGList">
                </div>
                <%--    <div id="AIMChild">
                       <input id="rdbCheck" type="radio" name="paymentType" class="cssClassRadioBtn" />
                   <b> <label>
                        Check/MoneyOrder</label></b><br />
                        <input id="rdbCreditCard" type="radio" name="paymentType" class="cssClassRadioBtn"  />
                    <b><label>
                        Credit Card</label></b>
                        </div>
                        <div id="dvCheque" class="cssClassCheckoutInformationContent">
                        <b> <label >
                                Account Number  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtAccountNumber" type="text"  name="accountNumber" class=" required" minlength="5"/><br />
                             <b> <label >
                                Routing Number  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtRoutingNumber" type="text"   name="routingNumber" class=" required" minlength="9"/><br />
                            <b><label>
                                Account Type    : <span class="cssClassRequired">*</span></label></b><br />
                             <select id="ddlAccountType">
                              <option >CHECKING</option>
                              <option >BUSINESSCHECKING</option>
                              <option >SAVINGS</option>
                            </select>
                             <br />
                             <b> <label >
                                Bank Name  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtBankName" type="text"   name="bankName" class=" required" minlength="2"/><br />
                                <b> <label >
                                Account Holder  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtAccountHolderName" type="text"  name="accountHolderName" class=" required" minlength="2"/><br />
                            
                            <b><label>
                                Cheque Type    : <span class="cssClassRequired">*</span></label></b><br />
                             <select id="ddlChequeType">                              
                              <option >ARC</option>
                              <option >BOC</option>
                              <option >CCD</option>
                              <option >PPD</option>
                              <option >TEL</option>
                              <option >WEB</option>
                            </select>
                             <br />
                             
                              <b> <label >
                                Cheque Number  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtChequeNumber" type="text"  name="chequeNumber" class=" required" minlength="4"/><br />
                            <p class="cssClassCheckBox">
                <input id="chkRecurringBillingStatus" type="checkbox" /><span> Recurring Billing Status</span>
               </p>
                        </div>
                        
                <div id="creditCard" class="cssClassCheckoutInformationContent">
               
                            <b><label>
                                Transaction Type : <span class="cssClassRequired">*</span></label></b><br />
                        <select id="ddlTransactionType"></select>
                        <b><label id ="lblAuthCode">
                        AuthorizeCode:<span class="cssClassRequired">*</span> </label></b>
                       <input type ="text" id ="txtAuthCode" class="required" minlength="5"/>
                        
                            <br />
                            <b><label>
                                Card Type    : <span class="cssClassRequired">*</span></label></b><br />
                             <select id="cardType">
                              <option selected="selected">--Select one--</option>
                            </select>
                             <br />
                            <b><label>
                                Card No    : <span class="cssClassRequired">*</span></label></b><br />
                        <input id ="txtCardNo" type="text" maxlength ="16" size ="22" class="creditcard  required" name="creditCard" /><br />
                       
                       
                        
                           <b> <label >
                                Card Code  : <span class="cssClassRequired" >*</span></label></b><br />
                            <input id ="txtCardCode" type="text" size ="10" maxlength="4"  name="cardCode" class=" required" minlength="4"/>
                           <a class="screenshot" rel="App_Images/HTMLEditor.icons/cvv.gif" href="#">What is this?</a>
                           <br/>
                  
                            <b><label>
                            
                                Expire Date : <span class="cssClassRequired">*</span></label></b><br />
                      
                             <select id="lstMonth" class="required">
                              <option value="Month" selected="selected">--Month--</option>
                              <option value ="01">01</option>
                              <option value ="02">02</option>
                              <option value ="03">03</option>
                              <option value ="04">04</option>
                              <option value="05">05</option>
                              <option value="06">06</option>
                              <option value="07">07</option>
                              <option value="08">08</option>
                              <option value="09">09</option>
                              <option value="10">10</option>
                              <option value="11">11</option>
                              <option value="12">12</option>
                            </select>
                              <select id="lstYear">
                              <option value="Year" selected="selected">--Year--</option>
                              <option value="2011">2011</option>
                              <option value="2012">2012</option>
                              <option value="2013">2013</option>
                              <option value="2014">2014</option>
                              <option value="2015">2015</option>
                              <option value="2016">2016</option>
                              <option value="2017">2017</option>
                              <option value="2018">2018</option>
                              <option value="2019">2019</option>
                              <option value="2020">2020</option>
                              <option value="2021">2021</option>
                              <option value="2022">2022</option>
                            </select>
                             
                 
                
                </div>--%>
                <div class="cssClassButtonWrapper cssClassRightBtn">
                    <button id="btnPaymentInfoBack" type="button" value="back" class="back">
                        <span><span>Back</span></span></button>
                    <button id="btnPaymentInfoContinue" type="button" value="continue" class="continue">
                        <span><span>Continue</span></span></button>
                </div>
                <div class="cssClassClear">
                </div>
            </div>
            <div class="accordionHeading">
                <h2>
                    <span>6</span><b>Order Review </b>
                </h2>
            </div>
            <div id="dvPlaceOrder" class="cssClassOrderReview">
                <div class="cssClassCartInformationDetails" id="divCartDetails">
                </div>
                <table width="100%" class="noborder">
                    <tbody>
                        <tr class="cssClassSubTotalAmount">
                            <td>
                                <strong>Grand SUBTOTAL:</strong>
                            </td>
                            <td>
                                <input type="text" class="total-box cssClassFormatCurrency" value="$0" id="product-subtotal" readonly="readonly" />
                            </td>
                        </tr>
                        <tr class="cssClassSubTotalAmount">
                            <td>
                                <strong>Shipping Cost:</strong>
                            </td>
                            <td>
                                <input type="text" class="cssClassFormatCurrency" id="txtShippingTotal" readonly="readonly" value="0.00" />
                            </td>
                        </tr>
                        <tr class="cssClassSubTotalAmount">
                            <td>
                                <strong>Total Tax:</strong>
                            </td>
                            <td>
                                <input type="text" class="tax-box cssClassFormatCurrency" id="txtTax" readonly="readonly" value="0.00" />
                            </td>
                        </tr>
                        <tr class="cssClassSubTotalAmount">
                            <td>
                                <strong>Total Discount:</strong>
                            </td>
                            <td>
                                <input type="text" id="txtDiscountAmount" class="cssClassFormatCurrency" readonly="readonly" value="0.00" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="cssClassLeftRightBtn">
                    <div class="cssClassCartInformation">
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="noborder">
                            <tbody>
                                <tr class="cssClassHeadeTitle cssClassAlternativeEven">
                                    <td class="cssClassSubTotalAmountWidth">
                                        <strong>Grand TOTAL:</strong>
                                    </td>
                                    <td class="cssClassGrandTotalAmountWidth">
                                        <input type="text" readonly="readonly" id="txtTotalCost" class="cssClassFormatCurrency" value="0" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="cssClassButtonWrapper ">
                        <button id="btnPlaceBack" type="button" value="back" class="back">
                            <span><span>Back</span></span></button>
                        <%--<button id="btnPlaceOrder" type="submit" class ="submit" ><span><span>Place Order</span></span></button>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="cssClassRightAccordainMenu">
    <div class="cssClassRightAccordainTab">
        <h1>
            Checkout progress</h1>
        <div class="cssClassRightAccordainMenuInfo">
            <h2>
                Billing Address</h2>
        </div>
        <div id="dvCPBilling">
        </div>
        <div class="cssClassRightAccordainMenuInfo">
            <h2>
                Shipping Address</h2>
        </div>
        <div id="dvCPShipping">
        </div>
        <div class="cssClassRightAccordainMenuInfo">
            <h2>
                Shipping Method</h2>
        </div>
        <div id="dvCPShippingMethod">
        </div>
        <div class="cssClassRightAccordainMenuInfoSelected">
            <h2>
                Payment Method</h2>
        </div>
        <div id="dvCPPaymentMethod">
        </div>
        <%--<div class="cssClassRightAccordainMenuInfoSelected">
            <h2>
                Payment Gateway Type</h2>
        </div>
        <div id="dvPaymentGatewayTypeMethod">
        </div>--%>
    </div>
</div>
<div class="popupbox" id="popuprel">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="lblAddressTitle" runat="server" Text="Address Details"></asp:Label>
    </h2>
    <div class="cssClassFormWrapper">
        <div class="cssClassButtonWrapper">
            <button type="button" id="btnSubmitAddress" class="cssClassButtonSubmit">
                <span><span>Save</span></span></button>
        </div>
    </div>
</div>