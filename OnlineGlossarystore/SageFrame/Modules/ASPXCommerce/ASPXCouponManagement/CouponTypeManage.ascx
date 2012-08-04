<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CouponTypeManage.ascx.cs"
            Inherits="Modules_ASPXCouponManagement_CouponTypeManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadCouponTypeStaticImage();
        BindCouponTypeDetails(null);
        HideAllCouponTypeDivs();
        $("#divShowCouponTypeDetails").show();
        $("#btnAddNewCouponType").click(function() {
            $("#<%= lblCouponTypeFormTitle.ClientID %>").html("Add New Coupon Type");
            $("#hdnCouponTypeID").val(0);
            HideAllCouponTypeDivs();
            $("#divCouponTypeProviderForm").show();
            $("#txtNewCouponType").val('');
            $("#chkIsActive").attr("checked", true);

        });
        $("#btnSubmitCouponType").click(function() {

            var v = $("#form1").validate({
                messages: {
                    CouponTypeName: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    }
                }
            });
            if (v.form()) {
                AddUpdateCouponType();
            } else {
                return false;
            }
        });
        $("#btnCancelCouponTypeUpdate").click(function() {
            HideAllCouponTypeDivs();
            $("#divShowCouponTypeDetails").show();

            $('#txtNewCouponType').removeClass('error');
            $('#txtNewCouponType').parents('td').find('label').remove();
        });

        $("#btnDeleteSelectedCouponType").click(function() {
            var coupontype_ids = '';
            //Get the multiple Ids of the item selected
            $(".CouponTypeChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    coupontype_ids += $(this).val() + ',';
                }
            });
            if (coupontype_ids == "") {
                csscody.alert('<h2>Information Alert</h2><p>None of the data are selected</p>');
                return false;
            }
            var properties = {
                onComplete: function(e) {
                    DeleteMultipleCouponTypes(coupontype_ids, e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
        });
    });

    function LoadCouponTypeStaticImage() {
        $('#ajaxCouponTypeImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function DeleteMultipleCouponTypes(ids, event) {
        DeleteCouponTypeByID(ids, event);
    }

    function BindCouponTypeDetails(searchCouponType) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCouponType_pagesize").length > 0) ? $("#gdvCouponType_pagesize :selected").text() : 10;

        $("#gdvCouponType").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCouponTypeDetails',
            colModel: [
                { display: 'Coupon Type ID', name: 'coupon_type_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'CouponTypeChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Coupon Type', name: 'setting_key', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'added_on', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Is Active', name: 'is_active', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditCouponType', arguments: '1,3' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCouponType', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { couponTypeName: searchCouponType, storeId: storeId, portalId: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 4: { sorter: false } }
        });
    }

    function HideAllCouponTypeDivs() {
        $("#divShowCouponTypeDetails").hide();
        $("#divCouponTypeProviderForm").hide();
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

    function EditCouponType(tblID, argus) {
        switch (tblID) {
        case "gdvCouponType":
            $("#<%= lblCouponTypeFormTitle.ClientID %>").html("Edit Coupon Type: '" + argus[3] + "'");
            $("#hdnCouponTypeID").val(argus[0]);
            $("#txtNewCouponType").val(argus[3]);
            $("#chkIsActive").attr("checked", Boolean.parse(argus[4]));
            HideAllCouponTypeDivs();
            $("#divCouponTypeProviderForm").show();
            break;
        default:
            break;
        }
    }

    function DeleteCouponType(tblID, argus) {
        switch (tblID) {
        case "gdvCouponType":
            var properties = {
                onComplete: function(e) {
                    DeleteCouponTypeByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteCouponTypeByID(ids, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCouponType",
                data: JSON2.stringify({ IDs: ids, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindCouponTypeDetails(null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function AddUpdateCouponType() {
        var couponType_id = $("#hdnCouponTypeID").val();
        var isActive = $("#chkIsActive").attr("checked");
        var couponType = $("#txtNewCouponType").val();
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateCouponType",
            data: JSON2.stringify({ couponTypeID: couponType_id, couponType: couponType, isActive: isActive, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindCouponTypeDetails(null);
                HideAllCouponTypeDivs();
                $("#divShowCouponTypeDetails").show();
            },
            error: function(msg) {
                alert('Error!');
            }
        });
    }

    function SearchCouponType() {
        var searchCouponType = $.trim($("#txtSearchCouponType").val());
        //var isAct = $("#ddlIsActive").val() == "" ? null : $("#ddlIsActive").val() == "True" ? true : false;
        if (searchCouponType.length < 1) {
            searchCouponType = null;
        }
        BindCouponTypeDetails(searchCouponType);
    }
</script>

<div id="divShowCouponTypeDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCouponTypeGridTitle" runat="server" Text="Manage Coupon Types"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelectedCouponType">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewCouponType">
                            <span><span>Add New Coupon Type</span></span></button>
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
                                    Coupon Type:</label>
                                <input type="text" id="txtSearchCouponType" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCouponType() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxCouponTypeImageLoad" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCouponType" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divCouponTypeProviderForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCouponTypeFormTitle" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblEditCouponForm" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblCouponType" Text="CouponType:" runat="server" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtNewCouponType" name="CouponTypeName" class="cssClassNormalTextBox required" minlength="2" />
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
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancelCouponTypeUpdate">
                    <span><span>Cancel</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitCouponType">
                    <span><span>Save</span></span></button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnCouponTypeID" />