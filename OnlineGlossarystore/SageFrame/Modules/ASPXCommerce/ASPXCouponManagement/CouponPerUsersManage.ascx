<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CouponPerUsersManage.ascx.cs"
            Inherits="Modules_ASPXCouponManagement_CouponUserManageMent" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        $("#txtValidFrom").datepicker({ dateFormat: 'yy/mm/dd' });
        $("#txtValidTo").datepicker({ dateFormat: 'yy/mm/dd' });
        LoadCouponPerUserStaticImage();
        BindCouponUserDetails(null, null, null, null, null);
        GetCouponStatus();
        HideAll();
        $("#divShowCouponTypeDetails").show();
        $("#btnDeleteAllNonPendingCoupon").click(function() {

            var properties = {
                onComplete: function(e) {
                    DeleteCouponUserByID(0, e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all non pending coupon User(s)?</p>", properties);
        });

        $("#btnCancelCouponUserUpdate").click(function() {
            HideAll();
            $("#divShowCouponTypeDetails").show();
        });

        $("#btnSubmitCouponUser").click(function() {
            UpdateCouponUser();
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvCouponUser').table2CSV();
        });
    });

    function LoadCouponPerUserStaticImage() {
        $('#ajaxCouponPerUserImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function UpdateCouponUser() {
        var couponUserID = $("#hdnCouponUserID").val();
        var couponStatusID = $("#ddlCouponStatusType").val();
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateCouponUser",
            data: JSON2.stringify({ couponUserID: couponUserID, couponStatusID: couponStatusID, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function() {
                BindCouponUserDetails(null, null, null, null, null);
                HideAll();
                $("#divShowCouponTypeDetails").show();
            },
            error: function() {
                alert("error");
            }
        });
    }

    function HideAll() {
        $("#divShowCouponTypeDetails").hide();
        $("#divCouponUserForm").hide();
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

    function BindCouponUserDetails(searchCouponCode, userName, couponStatusID, validateFrom, validateTo) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCouponUser_pagesize").length > 0) ? $("#gdvCouponUser_pagesize :selected").text() : 10;

        $("#gdvCouponUser").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCouponUserDetails',
            colModel: [
                { display: 'Coupon User ID', name: 'coupon_type_id', cssclass: 'cssClassHide', coltype: 'checkbox', align: 'center', elemClass: 'CouponUserChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox', hide: true },
                { display: 'Coupon ID', name: 'coupon_id', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Coupon Code', name: 'coupon_code', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'User Name', name: 'user', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Life', name: 'couponLife', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'No Of Uses', name: 'no_of_use', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Coupon Status ID', name: 'coupon_status_id', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Coupon Status', name: 'coupon_status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Valid From', name: 'valid_from', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Valid To', name: 'valid_to', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { couponCode: searchCouponCode, userName: userName, couponStatusId: couponStatusID, validFrom: validateFrom, validTo: validateTo, storeId: storeId, portalId: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 2: { sorter: false }, 10: { sorter: false } }
        });
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvCouponUser thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvCouponUser tbody tr");
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

    function DeleteCouponUser(tblID, argus) {
        switch (tblID) {
        case "gdvCouponUser":
            if (argus[4] == 3) {
                alert("This coupon has been provided to '" + argus[3] + "'. Deleting prevents '" + argus[3] + "'  from using this coupon.So,first change the status for this coupon and then delete it.");
                return false;
            }
            var properties = {
                onComplete: function(e) {
                    DeleteCouponUserByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteCouponUserByID(ids, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCouponUser",
                data: JSON2.stringify({ couponUserID: ids, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindCouponUserDetails(null, null, null, null, null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function SearchCouponCode() {
        var searchCouponCode = $.trim($("#txtSearchCouponCode").val());
        var userName = $.trim($("#txtSearchUserName").val());
        var couponStatusID = $.trim($("#ddlCouponStatus").val());
        var validateFrom = $.trim($("#txtValidFrom").val());
        var validateTo = $.trim($("#txtValidTo").val());
        if (couponStatusID == "0") {
            couponStatusID = null;
        }
        if (searchCouponCode.length < 1) {
            searchCouponCode = null;
        }
        if (userName.length < 1) {
            userName = null;
        }
        if (validateFrom.length < 1) {
            validateFrom = null;
        } else {
            var splitFromDate = String(validateFrom).split('/');
            validateFrom = new Date(Date.UTC(splitFromDate[0], splitFromDate[1] * 1 - 1, splitFromDate[2], 12, 0, 0, 0));
            validateFrom = validateFrom.toMSJSON();
        }
        if (validateTo.length < 1) {
            validateTo = null;
        } else {
            var splitToDate = String(validateTo).split('/');
            validateTo = new Date(Date.UTC(splitToDate[0], splitToDate[1] * 1 - 1, splitToDate[2], 12, 0, 0, 0));
            validateTo = validateTo.toMSJSON();
        }
        BindCouponUserDetails(searchCouponCode, userName, couponStatusID, validateFrom, validateTo);
    }
</script>

<div id="divShowCouponTypeDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Coupon User Manage"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteAllNonPendingCoupon">
                            <span><span>Delete All Non Pending Coupon User(s)</span></span></button>
                    </p>
                    <p>
                        <asp:Button ID="btnExportDataToExcel" CssClass="cssClassButtonSubmit" runat="server"
                                    OnClick="btnExportDataToExcel_Click" Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
                    </p>
                    <p>
                        <button type="button" id="btnExportToCSV">
                            <span><span>Export to CSV</span></span></button>
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
                                    Coupon Code:</label>
                                <input type="text" id="txtSearchCouponCode" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    UserName:</label>
                                <input type="text" id="txtSearchUserName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Coupon Status:</label>
                                <select id="ddlCouponStatus" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Valid From:</label>
                                <input type="text" id="txtValidFrom" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Valid To:</label>
                                <input type="text" id="txtValidTo" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCouponCode() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxCouponPerUserImageLoad" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCouponUser" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="hdnCouponUserID" />
<asp:HiddenField ID="HdnValue" runat="server" />