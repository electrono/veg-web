<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CouponManage.ascx.cs"
            Inherits="Modules_ASPXCouponManagement_CouponManage" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var senderEmail = '<%= userEmail %>';
    var serverLocation = '<%= Request.ServerVariables["SERVER_NAME"] %>';
    var deleteAllSelectedCouponUser = 0;
    var seachByCouponUser = 0;
    $(document).ready(function() {
        LoadCouponAjaxImage();
        $('.cssClassUsesPerCoupon').hide();
        $('.cssClassddlCouponStatus').hide();
        $('.cssClasstxtSearchUserName').hide();
        $('#gdvCouponUser').hide();
        $('#btnBackToCouponTbl').hide();
        $("#divCouponUserForm").hide();
        $("#txtValidFrom").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtValidTo").datepicker({ dateFormat: 'yy/mm/dd' });

        $("#txtSearchValidateFrom").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtSearchValidateTo").datepicker({ dateFormat: 'yy/mm/dd' });

        BindCouponDetails(null, null, null, null);
        GetAllCouponType();
        GetCouponStatus();
        var c = $("#form1").validate({
            rules: {
                newCoupon: "required",
                amount: "required",
                validateFrom: "required",
                userPerCustomer: "required",
                // usesPerCoupon: "required",
                usesPerCustomer: "required"
            },
            messages: {
                newCoupon: "at least 2 chars",
                amount: "*",
                validateFrom: "*",
                validateTo: "*",
                userPerCustomer: "*",
                //    usesPerCoupon: "*",
                usesPerCustomer: "*"
            },
            ignore: ':hidden'
        });
        $("#btnGenerateCode").click(function() {
            $("#spancouponCode").html('');
        });
        $('#btnBackToCouponTbl').click(function() {
            $('#gdvCouponUser').hide();
            $('#btnBackToCouponTbl').hide();
            $('#gdvCoupons').show();
            $('#gdvCoupons_Pagination').show();
            $('#gdvCouponUser_Pagination').hide();

            deleteAllSelectedCouponUser = 0;
            seachByCouponUser = 0;

            $('.cssClassddlCouponStatus').hide();
            $('.cssClasstxtSearchUserName').hide();

            $('.cssClassddlCouponType').show();
            $('.cssClasstxtSearchCouponCode').show();
            $('.cssClasstxtSearchValidateFrom').show();
            $('.cssClasstxtSearchValidateTo').show();
        });

        $("#btnCancelCouponUserUpdate").click(function() {
            $("#divShowCouponDetails").show();
            $("#divCouponUserForm").hide();
            $('#ddlCouponType').val(0);
        });

        $("#btnSubmitCouponUser").click(function() {
            UpdateCouponUser();
        });


        $("#txtValidFrom").bind("change", function() {
            $('#created').html('');
            $('.to').parents('td').find('input').attr("style", '');
            $(this).removeClass('error');
            $('.to').parents('td').find('label').remove();

        });

        $("#txtValidTo").bind("change", function() {
            if ($(this).val() != "") {
                $('#created').html('');
                $('.to').parents('td').find('input').attr("style", '');
                $(this).removeClass('error');
                $('.to').parents('td').find('label').remove();
            }
            $(this).removeClass('error');
            $('.from').parents('td').find('label').remove();

        });

        $("#btnSubmitCoupon").click(function() {
            if (Date.parse($('.from').val()) >= Date.parse($('.to').val())) {
                $('.to').parents('td').find('input').css({ "background-color": "#FCC785" });
                $('#created').html('').html('must be higher date than active from');
                return false;
            } else {
                $('#created').html('');
                $('.to').parents('td').find('input').attr("style", '');
                $(this).removeClass('error');
                $('.to').parents('td').find('label').remove();
            }
            var UsesPerCoupon = 0;
            var settingId = "1,2,3";
            //  var settingValue = $("#txtUsesPerCoupon").val() + "," + $("#txtUsesPerCustomer").val() + "," + $("#ddlIsForFreeShipping").val();
            var settingValue = UsesPerCoupon + "," + $("#txtUsesPerCustomer").val() + "," + $("#ddlIsForFreeShipping").val();

            if ($('#ddlCouponType option:selected').val() != 0) {
                if (c.form()) {
                    if ($("#txtNewCoupon").val() == '') {
                        $("#spancouponCode").html("Coupon Code Is Required").css("color", "red");
                        return false;
                    } else {
                        AddUpdateCoupon(settingId, settingValue);
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                $('#ddlCouponType').attr('class', 'cssClassDropDown error');
                return false;
            }
        });

        $("#btnDeleteSelectedCoupon").click(function() {
            var coupon_Ids = '';
            //Get the multiple Ids of the item selected
            $(".CouponChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    coupon_Ids += $(this).val() + ',';
                }
            });
            if (coupon_Ids == "") {
                csscody.alert('<h2>Information Alert</h2><p>None of the data are selected</p>');
                return false;
            }
            var properties = {
                onComplete: function(e) {
                    if (deleteAllSelectedCouponUser == 1) {
                        DeleteCouponUserByID(coupon_Ids, e);
                    } else {
                        DeleteMultipleCoupons(coupon_Ids, e);
                    }
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
        });

        $("#btnAddNewCoupon").click(function() {
            $("#<%= lblCouponManageTitle.ClientID %>").html("Add new coupon");
            $("#hdnCouponID").val(0);
            $("#txtNewCoupon").attr("disabled", "disabled");
            ClearCouponForm();
            HideAllCouponDivs();
            $("#divCouponForm").show();
            $("#spancouponCode").html('');
        });

        $("#btnCancelCouponUpdate").click(function() {
            HideAllCouponDivs();
            $("#divShowCouponDetails").show();
        });
        $("#txtAmount").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });
        $("#txtUsesPerCoupon").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });
        $("#txtUsesPerCustomer").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                return false;
            }
        });
        HideAllCouponDivs();
        $("#divShowCouponDetails").show();

        $('#ddlIsForFreeShipping').change(function() {
            if ($('#ddlIsForFreeShipping option:selected').val().toLowerCase() == "yes") {
                $("#txtAmount").attr("disabled", "disabled");
                $("#txtAmount").val('');
                $("#txtAmount").parents('tr').hide();
            } else {
                $("#txtAmount").removeAttr("disabled");
                $("#txtAmount").parents('tr').show();
            }
        })
    });

    function LoadCouponAjaxImage() {
        $('#ajaxCouponMgmtImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxCouponImageLoad2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function UpdateCouponUser() {
        var couponID = $("#hdnCouponID").val();
        var couponUserID = $("#hdnCouponUserID").val();
        var couponStatusID = $("#ddlCouponStatusType").val();
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateCouponUser",
            data: JSON2.stringify({ couponUserID: couponUserID, couponStatusID: couponStatusID, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function() {
                BindCouponUsers(couponID, null, null, null);

                $("#divShowCouponDetails").show();
                $("#divCouponUserForm").hide();
            },
            error: function() {
                alert("error");
            }
        });
    }

    function DeleteMultipleCoupons(Ids, event) {
        DeleteCouponByID(Ids, event);
    }

    function ClearCouponForm() {
        document.getElementById('btnGenerateCode').disabled = false;
        $("#ddlCouponType").val(1);
        //  $("#txtUsesPerCoupon").val('');
        $("#txtUsesPerCustomer").val('');
        $("#txtAmount").val('');
        $("#txtNewCoupon").val('');
        $("#txtValidTo").val('');
        $("#txtValidFrom").val('');
        // $("#txtNewCoupon").removeAttr("disabled");
        $("#txtAmount").removeAttr("disabled");
        $("#txtUsesPerCustomer").removeAttr("disabled");
        $("#ddlCouponType").removeAttr("disabled");
        $("#ddlIsForFreeShipping").removeAttr("disabled");
        $("#chkIsActive").attr("checked", true);
        //$("#chkIsActive").removeAttr("checked");
        $("#ddlIsForFreeShipping").val(1);
        BindAllPortalUsersByCouponID(0, null);
        ClearCouponFormError();
    }

    function ClearCouponFormError() {
        // $('#txtUsesPerCoupon').removeClass('error');
        // $('#txtUsesPerCoupon').parents('td').find('label').remove();
        $('#txtUsesPerCustomer').removeClass('error');
        $('#txtUsesPerCustomer').parents('td').find('label').remove();
        $('#txtAmount').removeClass('error');
        $('#txtAmount').parents('td').find('label').remove();
        $('#txtNewCoupon').removeClass('error');
        $('#txtNewCoupon').parents('td').find('label').remove();
        $('#txtValidTo').removeClass('error');
        $('#txtValidTo').parents('td').find('label').remove();
        $('#txtValidFrom').removeClass('error');
        $('#txtValidFrom').parents('td').find('label').remove();
        $('#ddlCouponType').removeClass('error');
        $('#ddlCouponType').parents('td').find('label').remove();
        $('#created').html('');
        $('.to').parents('td').find('input').attr("style", '');
    }

    function GenerateCodeString() {
        var chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz";
        var string_length = 15;
        var codeString = '';
        for (var i = 0; i < string_length; i++) {
            var rnum = Math.floor(Math.random() * chars.length);
            codeString += chars.substring(rnum, rnum + 1);
        }
        $("#txtNewCoupon").val(codeString);
    }

    function AddUpdateCoupon(settingId, settingValue) {
        var portalusers_customername = '';
        var portalusers_emailid = '';
        var portalusers_username = '';

        $("#gdvPortalUser .portalUserChkbox").each(function(i) {
            if ($(this).attr("checked") && $(this).attr('disabled') == false) {
                portalusers_username += $(this).parent('td').next('td').text() + '#';
                portalusers_customername += $(this).parent('td').next('td').next('td').text() + '#';
                portalusers_emailid += $(this).parent('td').next('td').next('td').next('td').text() + '#';
            }
        });

        portalusers_username = portalusers_username.substring(0, portalusers_username.length - 1);
        portalusers_customername = portalusers_customername.substring(0, portalusers_customername.length - 1);
        portalusers_emailid = portalusers_emailid.substring(0, portalusers_emailid.length - 1);

        var couponId = $("#hdnCouponID").val();
        var couponTypeId = $("#ddlCouponType").val();
        var couponCode = $("#txtNewCoupon").val();
        var couponAmount = $("#txtAmount").val() == "" ? null : $("#txtAmount").val();
        var couponLife = $('#txtUsesPerCustomer').val();
        var validFrom = $("#txtValidFrom").val();
        var validTo = $("#txtValidTo").val();
        var isActive = $("#chkIsActive").attr("checked");
        var couponName = $('#ddlCouponType option:selected').text();

        var serverHostLoc = 'http://' + serverLocation;
        var subject = "Congratulation You Got a CouponCode ";

        var fullDate = new Date();
        var twoDigitMonth = ((fullDate.getMonth().length + 1) === 1) ? (fullDate.getMonth() + 1) : (fullDate.getMonth() + 1);
        if (twoDigitMonth.length == 2) {
        } else if (twoDigitMonth.length == 1) {
            twoDigitMonth = '0' + twoDigitMonth;
        }
        var currentDate = fullDate.getDate() + "/" + twoDigitMonth + "/" + fullDate.getFullYear();
        var dateyear = fullDate.getFullYear();

        var emailtemplate = [];
        var unames = [];
        unames = portalusers_customername.split('#');
        var messageBodyHtml = '';
        for (var nn in unames) {
            messageBodyHtml += '<table width="100%" border="0" align="center" cellpadding="0" cellspacing="5" bgcolor="#e0e0e0" style="font:12px Arial, Helvetica, sans-serif;"><tr><td align="center" valign="top"><table style="font:12px Arial, Helvetica, sans-serif;" width="680" border="0" cellspacing="0" cellpadding="0">';
            messageBodyHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr>';
            messageBodyHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr><tr><td><table style="font:12px Arial, Helvetica, sans-serif;" width="680" border="0" cellspacing="0" cellpadding="0"><tr><td width="300">';
            messageBodyHtml += '<a href="' + serverHostLoc + '" target="_blank" style="outline:none; border:none;"><img src="' + serverHostLoc + '/' + aspxTemplateFolderPath + '/images/aspxcommerce.png" width="143" height="62" alt="Aspxcommerce" title="Aspxcommerce"/></a></td>';
            messageBodyHtml += '<td width="191" align="left" valign="middle">&nbsp;</td><td width="189" align="right" valign="middle"><b style="padding:0 20px 0 0; text-shadow:1px 1px 0 #fff;">' + currentDate + '</b></td></tr></table></td></tr>';
            messageBodyHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr>';
            messageBodyHtml += '<tr><td bgcolor="#fff"><div style="border:1px solid #c7c7c7; background:#fff; padding:20px">';
            messageBodyHtml += '<table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr><td><p style="font-family:Arial, Helvetica, sans-serif; font-size:17px; line-height:16px; color:#278ee6; margin:0; padding:0 0 10px 0; font-weight:bold; text-align:left;">Congratulation !! ';
            messageBodyHtml += unames[nn].toUpperCase();
            messageBodyHtml += ' You have got Coupon code for shopping!!</p></td></tr><tr><td><span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;">Enjoy your Shopping !!</span></td></tr></table>';
            //content of coupon
            messageBodyHtml += '<div style="border:1px solid #cfcfcf; background:#f1f1f1; padding:10px"><table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0"><tr><td><table  style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0"><tr>';
            messageBodyHtml += '<td width="120" height="20"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;">Coupon Type: </span></td> <td>' + couponName + '</td>';
            messageBodyHtml += '<td width="150" style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; border-left:1px solid #fff; padding-left:20px;">Valid From: </td><td>' + validFrom + '</td></tr>';
            messageBodyHtml += '<tr><td height="20"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;">Coupon Code: </span></td> <td>' + couponCode + '</td>';
            messageBodyHtml += ' <td  style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; border-left:1px solid #fff; padding-left:20px;">Valid Upto: </td><td>' + validTo + '</td></tr>';
            messageBodyHtml += '<tr><td height="20"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;">Coupon Life: </span></td><td>' + couponLife + '</td>';
            messageBodyHtml += '<td  style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; border-left:1px solid #fff; padding-left:20px;">&nbsp;</td><td>&nbsp;</td></tr>';
            if ($('#ddlIsForFreeShipping option:selected').val() == "YES") {
                messageBodyHtml += '<tr><td height="20"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;">Coupon Amount: </span></td><td>Do not worry!! Its Free Shipping Coupon.</td>';
            } else {
                messageBodyHtml += '<tr><td height="20"><span style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold;">Coupon Amount: </span></td><td>' + couponAmount + '</td>';
            }
            messageBodyHtml += ' <td  style="font-family:Arial, Helvetica, sans-serif; font-size:11px; font-weight:bold; border-left:1px solid #fff; padding-left:20px;">&nbsp;</td><td>&nbsp;</td></tr></table></td></tr></table></div>';
            messageBodyHtml += '<p style="margin:0; padding:10px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;">Thank You,<br /><span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;">AspxCommerce Team </span></p></div></td></tr>';
            messageBodyHtml += '<tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="20" alt=" "/></td></tr>';
            messageBodyHtml += '<tr><td align="center" valign="top"><p style="font-size:11px; color:#4d4d4d"> © ' + dateyear + ' AspxCommerce. All Rights Reserved.</p></td></tr>';
            messageBodyHtml += '    <tr><td align="center" valign="top"><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr></table></td></tr></table>';
            emailtemplate.push(messageBodyHtml);
            messageBodyHtml = '';
        }

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateCouponDetails",
            data: JSON2.stringify({
                couponID: couponId,
                couponTypeID: couponTypeId,
                couponCode: couponCode,
                couponAmount: couponAmount,
                validateFrom: validFrom,
                validateTo: validTo,
                isActive: isActive,
                storeID: storeId,
                portalID: portalId,
                cultureName: cultureName,
                userName: userName,
                settingIDs: settingId,
                settingValues: settingValue,
                PortalUser_CustomerName: portalusers_customername,
                PortalUser_EmailID: portalusers_emailid,
                PortalUser_UserName: portalusers_username,
                SenderEmail: senderEmail,
                Subject: subject,
                MessageBody: emailtemplate
            }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindCouponDetails(null, null, null, null);
                HideAllCouponDivs();
                $("#divShowCouponDetails").show();
                $('#gdvCouponUser').hide();
                if (portalusers_emailid != '') {
                    csscody.alert("<h2>Information Message</h2><p>Email has been send successfully for selected Customer.</p>");
                }
            },
            error: function() {
                csscody.alert("<h2>Information Alert</h2><p>Failure sending mail!</p>");
            }
        });
    }

    function GetAllCouponType() {
        var offset = 0;
        var limit = 0;
        var couponTypeName = null;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCouponTypeDetails",
            data: JSON2.stringify({ offset: offset, limit: limit, couponTypeName: couponTypeName, storeId: storeId, portalId: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, value) {
                    var couponTypeElements = "<option value=" + value.CouponTypeID + ">" + value.CouponType + "</coupon>";
                    $("#ddlCouponType").append(couponTypeElements);
                    $("#ddlSearchCouponType").append(couponTypeElements);
                });
            },
            error: function() {
                alert("error");
            }
        });
    }

    function SearchCouponPortalUsers() {
        var couponId = $("#hdnCouponID").val();
        var searchCustomerName = $('#txtSearchCustomerName').val();
        BindAllPortalUsersByCouponID(couponId, searchCustomerName);
    }

    function BindAllPortalUsersByCouponID(couponId, customerName) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvPortalUser_pagesize").length > 0) ? $("#gdvPortalUser_pagesize :selected").text() : 10;

        $("#gdvPortalUser").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetPortalUsersByCouponID',
            colModel: [
                { display: 'Portal User ID', name: 'portal_user_ID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '4', elemClass: 'portalUserChkbox', elemDefault: false, controlclass: 'userHeaderChkbox' },
                { display: 'User Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Customer Name', name: 'customer_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Email', name: 'email', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'IsAlreadySent', name: 'is_already_sent', cssclass: '', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No', hide: true }
            ],
            rp: perpage,
            nomsg: "No Customers Found!",
            param: { couponID: couponId, storeID: storeId, portalID: portalId, customerName: customerName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 4: { sorter: false } }
        });
    }

    function BindCouponDetails(SearchCouponTypeId, SearchCouponCode, validateFromDate, validateToDate) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCoupons_pagesize").length > 0) ? $("#gdvCoupons_pagesize :selected").text() : 10;

        $("#gdvCoupons").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCouponDetails',
            colModel: [
                { display: 'CouponID', name: 'coupon_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'CouponChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Coupon Type ID', name: 'coupon_type_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Coupon Type', name: 'coupon_type', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Code', name: 'coupon_code', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Uses', name: 'number_of_uses', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Validate From', name: 'validate_from', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Validate To', name: 'validate_to', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Amount', name: 'balance_amount', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'IsFreeShipping', name: 'IsFreeShipping', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'added_on', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Updated On', name: 'updated_on', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Is Active', name: 'is_active', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'View', name: 'view', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewCoupons', arguments: '1' },
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCoupons', arguments: '1,3,5,6,7,8,9,11' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCoupons', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { couponTypeID: SearchCouponTypeId, couponCode: SearchCouponCode, validateFrom: validateFromDate, validateTo: validateToDate, storeId: storeId, portalId: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 12: { sorter: false } }
        });
    }

    Boolean.parse = function(str) {
        // alert(str.toLowerCase());
        switch (str.toLowerCase()) {
        case "yes":
            return true;
        case "no":
            return false;
        default:
            return false;
        }
    };

    function EditCoupons(tblID, argus) {
        switch (tblID) {
        case "gdvCoupons":
                //BInd PortalUserCoupon Grid HERE
            ClearCouponFormError();
            BindAllPortalUsersByCouponID(argus[0], null);
            document.getElementById('btnGenerateCode').disabled = true;
            $("#<%= lblCouponManageTitle.ClientID %>").html("Edit Coupon: '" + argus[4] + "'");
            $("#hdnCouponID").val(argus[0]);
            $("#ddlCouponType").val(argus[3]);
            $("#txtNewCoupon").val(argus[4]);
            $("#txtValidFrom").val(argus[5]);
            $("#txtValidTo").val(argus[6]);
            $("#txtAmount").val(argus[7]);
            $("#chkIsActive").attr('checked', Boolean.parse(argus[10]));
            var couponId = argus[0];
            var userNamesColl = "";
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSettinKeyValueByCouponID",
                data: JSON2.stringify({ couponID: couponId, storeID: storeId, portalID: portalId }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    $.each(msg.d, function(index, value) {

                        if (value.SettingID == 1) {
                            $("#txtUsesPerCoupon").val(value.SettingValue);

                        } else if (value.SettingID == 2) {
                            $("#txtUsesPerCustomer").val(value.SettingValue);
                        } else {
                            $("#ddlIsForFreeShipping").val(value.SettingValue);
                        }
                    });
                },
                error: function(msg) {
                    alert("error");
                }
            });

            $("#txtNewCoupon").attr("disabled", "disabled");
            $("#txtAmount").attr("disabled", "disabled");
            $("#txtUsesPerCustomer").attr("disabled", "disabled");
            $("#ddlCouponType").attr("disabled", "disabled");
            $("#ddlIsForFreeShipping").attr("disabled", "disabled");
            $("#spancouponCode").html('');
            HideAllCouponDivs();
            $("#divCouponForm").show();
            break;
        default:
            break;
        }
    }

    function DeleteCoupons(tblID, argus) {
        switch (tblID) {
        case "gdvCoupons":
            var properties = {
                onComplete: function(e) {
                    DeleteCouponByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteCouponByID(Ids, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCoupons",
                data: JSON2.stringify({ couponIDs: Ids, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindCouponDetails(null, null, null, null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function ViewCoupons(tblID, argus) {
        switch (tblID) {
        case "gdvCoupons":
            deleteAllSelectedCouponUser = 1;
            seachByCouponUser = 1;
            $('#gdvCoupons').hide();
            $('#gdvCoupons_Pagination').hide();
            $('#btnBackToCouponTbl').show();
            $('#gdvCouponUser').show();

            $('.cssClassddlCouponStatus').show();
            $('.cssClasstxtSearchUserName').show();

            $('.cssClassddlCouponType').hide();
            $('.cssClasstxtSearchCouponCode').hide();
            $('.cssClasstxtSearchValidateFrom').hide();
            $('.cssClasstxtSearchValidateTo').hide();
            $("#hdnCouponID").val(argus[0]);
            var couponID = argus[0];
            var couponCode = "";
            BindCouponUsers(couponID, null, null, null);

            break;
        default:
            break;
        }
    }

    function BindCouponUsers(couponID, SearchCouponCode, userName, couponStatusID) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCouponUser_pagesize").length > 0) ? $("#gdvCouponUser_pagesize :selected").text() : 10;

        $("#gdvCouponUser").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCouponUserList',
            colModel: [
                { display: 'CouponUserID', name: 'couponUserID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'CouponChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'CouponID', name: 'coupon_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Coupon Code', name: 'coupon_code', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'User Name', name: 'userName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Amount', name: 'balance_amount', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Status ID', name: 'coupon_status_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Coupon Status', name: 'coupon_status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Life', name: 'couponLife', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Uses', name: 'number_of_uses', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Validate From', name: 'validate_from', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Validate To', name: 'validate_to', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCouponsStatus', arguments: '1,2,3,4,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCouponsUser', arguments: '1,2,3,5' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { CouponID: couponID, CouponCode: SearchCouponCode, UserName: userName, CouponStatusID: couponStatusID, StoreID: storeId, PortalID: portalId, CultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 11: { sorter: false } }
        });

    }

    function DeleteCouponsUser(tblID, argus) {
        switch (tblID) {
        case "gdvCouponUser":
            var couponUserIDs = argus[0];
            if (argus[6] == 3) {
                alert("This coupon has been provided to '" + argus[5] + "'. Deleting prevents '" + argus[5] + "' from using this coupon!");
                return false;
            }
            var properties = {
                onComplete: function(e) {
                    DeleteCouponUserByID(couponUserIDs, e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteCouponUserByID(couponUserIDs, event) {
        if (event) {
            var couponID = $("#hdnCouponID").val();
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCouponUser",
                data: JSON2.stringify({ couponUserID: couponUserIDs, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindCouponUsers(couponID, null, null, null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function EditCouponsStatus(tblID, argus) {
        switch (tblID) {
        case "gdvCouponUser":
            $("#hdnCouponID").val('');
            $("#divShowCouponDetails").hide();
            $("#hdnCouponUserID").val(argus[0]);
            $("#hdnCouponID").val(argus[3]);
            $("#txtCouponCode").text(argus[4]);
            $("#<%= lblCouponUserTitle.ClientID %>").html("Edit Coupon Provided to: " + argus[4] + " ");
            $("#txtUserName").text(argus[5]);
            $("#ddlCouponStatusType ").val(argus[7]);
            $("#divCouponUserForm").show();
            break;
        default:
            break;
        }
    }

    function HideAllCouponDivs() {
        $("#divShowCouponDetails").hide();
        $("#divCouponForm").hide();
    }

    function GetCouponStatus() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCouponStatus",
            data: "{}",
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, value) {

                    var couponStatusElements = "<option value=" + value.CouponStatusID + ">" + value.CouponStatus + "</option>";
                    $("#ddlCouponStatusType").append(couponStatusElements);
                    $("#ddlCouponStatus").append(couponStatusElements);
                });
            },
            error: function() {
                alert("error");
            }
        });
    }

    function SearchCouponDetails() {
        var SearchCouponTypeId = $("#ddlSearchCouponType").val();
        var SearchCouponCode = $.trim($("#txtSearchCouponCode").val());
        var validateFromDate = $.trim($("#txtSearchValidateFrom").val());
        var validateToDate = $.trim($("#txtSearchValidateTo").val());
        if (SearchCouponTypeId != "0") {
            SearchCouponTypeId = $("#ddlSearchCouponType").val();
        } else {
            SearchCouponTypeId = null;
        }
//        if (validateFromDate) {
//            var splitFromDate = String(validateFromDate).split('/');
//            validateFromDate = new Date(Date.UTC(splitFromDate[0], splitFromDate[1] * 1 - 1, splitFromDate[2], 12, 0, 0, 0));
//            validateFromDate = validateFromDate.toMSJSON();
//        }
//        if (validateToDate) {
//            var splitToDate = String(validateToDate).split('/');
//            validateToDate = new Date(Date.UTC(splitToDate[0], splitToDate[1] * 1 - 1, splitToDate[2], 12, 0, 0, 0));
//            validateToDate = validateToDate.toMSJSON();
//        }
        if (validateFromDate.length < 1) {
            validateFromDate = null;
        } else {
            validateFromDate = $.trim($("#txtSearchValidateFrom").val());
        }
        if (validateToDate.length < 1) {
            validateToDate = null;
        } else {
            validateToDate = $.trim($("#txtSearchValidateTo").val());
        }
        if (SearchCouponCode.length < 1) {
            SearchCouponCode = null;
        }

        var searchcouponID = $("#hdnCouponID").val();
        var userName = $.trim($("#txtSearchUserName").val());
        var couponStatusID = $.trim($("#ddlCouponStatus").val());
        if (couponStatusID == "0") {
            couponStatusID = null;
        }
        if (userName.length < 1) {
            userName = null;
        }
        if (seachByCouponUser == 1) {
            BindCouponUsers(searchcouponID, null, userName, couponStatusID);
        } else {
            BindCouponDetails(SearchCouponTypeId, SearchCouponCode, validateFromDate, validateToDate);
        }
    }
</script>

<div id="divShowCouponDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Manage Coupons"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelectedCoupon">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewCoupon">
                            <span><span>Add New Coupon</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnBackToCouponTbl">
                            <span><span>Back</span></span></button>
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
                            <td class="cssClassddlCouponType">
                                <label class="cssClassLabel">
                                    Coupon Type:</label>
                                <select id="ddlSearchCouponType" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td class="cssClassddlCouponStatus">
                                <label class="cssClassLabel">
                                    Coupon Status:</label>
                                <select id="ddlCouponStatus" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td class="cssClasstxtSearchUserName">
                                <label class="cssClassLabel">
                                    UserName:</label>
                                <input type="text" id="txtSearchUserName" class="cssClassTextBoxSmall" />
                            </td>
                            <td class="cssClasstxtSearchCouponCode">
                                <label class="cssClassLabel">
                                    Coupon Code:</label>
                                <input type="text" id="txtSearchCouponCode" class="cssClassTextBoxSmall" />
                            </td>
                            <td class="cssClasstxtSearchValidateFrom">
                                <label class="cssClassLabel">
                                    Validate From:</label>
                                <input type="text" id="txtSearchValidateFrom" class="cssClassTextBoxSmall" />
                            </td>
                            <td class="cssClasstxtSearchValidateTo">
                                <label class="cssClassLabel">
                                    Validate To:</label>
                                <input type="text" id="txtSearchValidateTo" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCouponDetails() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxCouponImageLoad2" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCoupons" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <table id="gdvCouponUser" cellspacing="0" cellpadding="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divCouponForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCouponManageTitle" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblEditCouponForm" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblCouponType" Text="CouponType:" runat="server" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="ddlCouponType" class="cssClassDropDown required">
                            <option value="0">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblIsForFreeShipping" runat="server" Text="Is For Free Shipping:"
                                   CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="ddlIsForFreeShipping" class="cssClassDropDown">
                            <option value="NO">NO</option>
                            <option value="YES">YES</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCoupon" runat="server" Text="CouponCode:" CssClass="cssClassLabel"> </asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtNewCoupon" name="newCoupon" class="cssClassNormalTextBox required"
                               minlength="2" />
                        <button type="button" id="btnGenerateCode" class="cssClassButtonSubmit" onclick=" GenerateCodeString() ">
                            <span><span>Generate Code</span></span></button><span id="spancouponCode"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCouponAmount" Text="Amount:" runat="server" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtAmount" name="amount" class="cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblValidFrom" Text="Valid From:" runat="server" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtValidFrom" name="validateFrom" class="from cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblValidTo" Text="Valid To:" runat="server" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtValidTo" name="validateTo" class="to cssClassNormalTextBox required" />
                        <span id ="created" style="color: #ED1C24;"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblIsActive" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="checkbox" id="chkIsActive" class="cssClassCheckBox" />
                    </td>
                </tr>
                <tr class="cssClassUsesPerCoupon">
                    <td>
                        <asp:Label ID="lblUsesPerCoupon" runat="server" Text="Uses Per Coupon:" CssClass="cssClassLabel"
                                   Visible="false"></asp:Label>
                        <%-- <span class="cssClassRequired">*</span>--%>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtUsesPerCoupon" visible="false" name="usesPerCoupon" class="cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUsesPerCustomer" runat="server" Text="Uses Per Customer:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtUsesPerCustomer" name="userPerCustomer" class="cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPortalUser" runat="server" Text="Select Customers:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <div class="cssClassCommonBox Curve">
                            <div class="cssClassHeader">
                                <h2>
                                    <span id="ctl13_lblTitle">Select whom To send the Coupon Code:</span>
                                </h2>
                            </div>
                            <div class="cssClassGridWrapper">
                                <div class="cssClassGridWrapperContent">
                                    <div class="cssClassSearchPanel cssClassFormWrapper">
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <%--<td class="cssClasstxtRoleName">
                                                    <label class="cssClassLabel">
                                                        Role Name:</label>
                                                    <input type="text" id="txtSearchRoleName" class="cssClassTextBoxSmall" />
                                                </td>
                                                <td class="cssClasstxtSearchUserName">
                                                <label class="cssClassLabel">
                                                    UserName:</label>
                                                <input type="text" id="txtSearchUserName" class="cssClassTextBoxSmall" />
                                                </td>--%>
                                                <td class="cssClasstxtCustomerName">
                                                    <label class="cssClassLabel">
                                                        Customer Name:</label>
                                                    <input type="text" id="txtSearchCustomerName" class="cssClassTextBoxSmall" />
                                                </td>
                                                <td>
                                                    <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                        <p>
                                                            <button type="button" onclick=" SearchCouponPortalUsers() ">
                                                                <span><span>Search</span></span></button>
                                                        </p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="loading">
                                        <img id="ajaxCouponMgmtImageLoad"  />
                                    </div>
                                    <div class="log">
                                    </div>
                                    <table id="gdvPortalUser" cellspacing="0" cellpadding="0" border="0" width="100%">
                                    </table>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancelCouponUpdate">
                    <span><span>Cancel</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitCoupon">
                    <span><span>Save</span></span></button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnCouponID" />
<div id="divCouponUserForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCouponUserTitle" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="Table1" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblCouponCode" Text="CouponCode:" runat="server" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="txtCouponCode" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblUserName" runat="server" Text="UserName:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="txtUserName" cssclass="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCouponStatus" Text="CouponStatus:" runat="server" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="ddlCouponStatusType" class="cssClassDropDown">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancelCouponUserUpdate">
                    <span><span>Cancel</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitCouponUser">
                    <span><span>Save</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<input type="hidden" id="hdnCouponUserID" />
<input type="hidden" id="hdnDeleteAllSelectedCouponUser" />