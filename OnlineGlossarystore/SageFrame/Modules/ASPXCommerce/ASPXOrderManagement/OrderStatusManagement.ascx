<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderStatusManagement.ascx.cs"
            Inherits="Modules__ModulesInstalltions_ASPXOrderStatusManagement_OrderStatusManagement" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var UserName = '<%= userName %>';
    var CultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAlldiv();
        LoadOrderStatusMgmtItemStaticImage();
        $('#divOrderStatusDetail').show();
        BindOrdersStatusInGrid(null, null);

        $("#btnBack").click(function() {
            $("#divOrderStatusDetail").show();
            $("#divEditOrderStatus").hide();
        })

        $('#btnAddNew').click(function() {
            $("#btnReset").show();
            $('#divOrderStatusDetail').hide();
            $('#divEditOrderStatus').show();
            ClearForm();
        })

        $('#btnReset').click(function() {
            Reset();
            ClearForm()
        })

        $('#btnDeleteSelected').click(function() {
            var orderStatus_ids = '';
            $("#tblOrderStatusDetails .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    orderStatus_ids += $(this).val() + ',';
                }
            });
            if (orderStatus_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultiple(orderStatus_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Order Status?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one status before you can do this.<br/> To select one or more order status, just check the box before each order status.</p>');
            }
        })

        $('#btnSaveOrderStatus').click(function() {
            var v = $("#form1").validate({
                messages: {
                    StatusName: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    },
                    ToolTipName: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    }
                }
            });

            if (v.form()) {
                var orderStatus_id = $(this).attr("name");
                if (orderStatus_id != '') {
                    SaveOrderStatus(orderStatus_id, storeId, portalId, UserName, CultureName);
                } else {
                    SaveOrderStatus(0, storeId, portalId, UserName, CultureName);
                }
            }
        })
    });

    function LoadOrderStatusMgmtItemStaticImage() {
        $('#ajaxOrderStatusMgmtImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAlldiv() {
        $('#divOrderStatusDetail').hide();
        $('#divEditOrderStatus').hide();
    }

    function Reset() {
        $('#txtOrderStatusAliasName').val('');
        $('#txtAliasToolTip').val('');
        $('#txtAliasHelp').val('');
        $("#chkIsActiveOrder").removeAttr('checked');
    }

    function ClearForm() {
        $("#btnSaveOrderStatus").removeAttr("name");
        $("#<%= lblHeading.ClientID %>").html("Add New Order Status");

        $('#txtOrderStatusAliasName').val('');
        $('#txtAliasToolTip').val('');
        $('#txtAliasHelp').val('');
        $("#chkIsActiveOrder").removeAttr('checked');
        $("#isActiveTR").show();
        $("#hdnIsSystem").val(false);

        $('#txtOrderStatusAliasName').removeClass('error');
        $('#txtOrderStatusAliasName').parents('td').find('label').remove();
        $('#txtAliasToolTip').removeClass('error');
        $('#txtAliasToolTip').parents('td').find('label').remove();
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

    function BindOrdersStatusInGrid(OrderSatatusName, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#tblOrderStatusDetails_pagesize").length > 0) ? $("#tblOrderStatusDetails_pagesize :selected").text() : 10;

        $("#tblOrderStatusDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllStatusList',
            colModel: [
                { display: 'Order Status ID', name: 'OrderStatusID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '5', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'Order Status Name', name: 'OrderStatusAliasName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Alias Tool Tip', name: 'AliasToolTip', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Alias Help', name: 'AliasHelp', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AddedOn', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd', hide: true },
                { display: 'System', name: 'IsSystemUsed', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'IsActive', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditOrderStatus', arguments: '1,2,3,4,5,6' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteOrderStatus', arguments: '1,5' }
            // { display: 'Active', name: 'active', enable: true, _event: 'click', trigger: '3', callMethod: 'ActiveOrderStatus', arguments: '1,6' },
            // { display: 'Deactive', name: 'deactive', enable: true, _event: 'click', trigger: '4', callMethod: 'DeactiveOrderStatus', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, CultureName: CultureName, UserName: UserName, orderStatusName: OrderSatatusName, IsActive: isAct },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function EditOrderStatus(tblID, argus) {
        switch (tblID) {
        case "tblOrderStatusDetails":
            ClearForm();
            $("#btnReset").hide();
            $('#divOrderStatusDetail').hide();
            $('#divEditOrderStatus').show();

            $("#<%= lblHeading.ClientID %>").html("Edit Order Status: '" + argus[3] + "'");
            $('#txtOrderStatusAliasName').val(argus[3]);
            $('#txtAliasToolTip').val(argus[4]);
            $('#txtAliasHelp').val(argus[5]);
            $("#chkIsActiveOrder").attr('checked', Boolean.parse(argus[8]));
            $("#btnSaveOrderStatus").attr("name", argus[0]);
            if (argus[7].toLowerCase() != "yes") {
                $("#isActiveTR").show();
                $("#hdnIsSystem").val(false);
            } else {
                $("#isActiveTR").hide();
                $("#hdnIsSystem").val(true);
                $('#divOrderStatusDetail').show();
                $('#divEditOrderStatus').hide();
                csscody.alert('<h1>Information Alert</h1><p>You can\'t Edit System Status.</p>');
            }
            break;
        default:
            break;
        }
    }

    function SaveOrderStatus(OrderStatusID, storeId, portalId, UserName, CultureName) {
        var OrderStatusAliasName = $('#txtOrderStatusAliasName').val();
        var AliasToolTip = $('#txtAliasToolTip').val();
        var AliasHelp = $('#txtAliasHelp').val();
        var IsActive = $("#chkIsActiveOrder").attr('checked');
        var IsDeleted = $("#chkIsDeleted").attr('checked');
        var IsSystemUsed = $("#hdnIsSystem").val();

        var functionName = 'AddUpdateOrderStatus';
        var params = {
            StoreID: storeId,
            PortalID: portalId,
            CultureName: CultureName,
            UserName: UserName,
            OrderStatusID: OrderStatusID,
            OrderStatusAliasName: OrderStatusAliasName,
            AliasToolTip: AliasToolTip,
            AliasHelp: AliasHelp,
            IsSystem: IsSystemUsed,
            IsActive: IsActive
        };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindOrdersStatusInGrid(null, null);
                ClearForm();
                $('#divOrderStatusDetail').show();
                $('#divEditOrderStatus').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to edit Order Status</p>');
            }
        });
    }

    function DeleteOrderStatus(tblID, argus) {
        switch (tblID) {
        case "tblOrderStatusDetails":
                //  alert(argus[4]);
            if (argus[4].toLowerCase() != "yes") {
                DeleteAttribute(argus[0], storeId, portalId, CultureName, UserName);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t delete System Status.</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeleteAttribute(_orderStatusId, _storeId, _portalId, _cultureName, _userName) {

        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(_orderStatusId, _storeId, _portalId, _cultureName, _userName, e);

            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this status?</p>", properties);
    }

    function ConfirmSingleDelete(_orderStatusId, _storeId, _portalId, _cultureName, _userName, event) {
        if (event) {
            DeleteSingleAttribute(_orderStatusId, _storeId, _portalId, _cultureName, _userName);
        }
        return false;
    }

    function DeleteSingleAttribute(_orderStatusId, _storeId, _portalId, _cultureName, _userName) {

        var functionName = 'DeleteOrderStatusByID';
        var params = { OrderStatusID: parseInt(_orderStatusId), StoreID: _storeId, PortalID: _portalId, UserName: _userName, CultureName: _cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindOrdersStatusInGrid(null, null);
                ClearForm();
                $('#divOrderStatusDetail').show();
                $('#divEditOrderStatus').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Order Status</p>');
            }
        });
    }

    function ConfirmDeleteMultiple(orderStatus_ids, event) {
        if (event) {
            DeleteMultipleAttribute(orderStatus_ids, storeId, portalId, UserName, CultureName);
        }
    }

    function DeleteMultipleAttribute(orderStatus_ids, storeId, portalId, UserName, CultureName) {

        var functionName = 'DeleteOrderStatusMultipleSelected';
        var params = { OrderStatusIDs: orderStatus_ids, StoreID: storeId, PortalID: portalId, UserName: UserName, CultureName: CultureName };
        var mydata = JSON2.stringify(params);

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindOrdersStatusInGrid(null, null);
                ClearForm();
                $('#divOrderStatusDetail').show();
                $('#divEditOrderStatus').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Order Status</p>');
            }
        });
        return false;
    }

    function SearchOrderStatus() {

        var OrderStatusAliasName = $.trim($("#txtOrderStateName").val());
        if (OrderStatusAliasName.length < 1) {
            OrderStatusAliasName = null;
        }
        var isAct = $.trim($("#ddlVisibitity").val()) == "" ? null : ($.trim($("#ddlVisibitity").val()) == "True" ? true : false);

        BindOrdersStatusInGrid(OrderStatusAliasName, isAct);
    }

</script>

<div id="divOrderStatusDetail">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderStatusHeading" runat="server" Text="Order Status"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNew">
                            <span><span>Add New Order Status</span></span></button>
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
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>
                            <%--<td>
                                <asp:Label ID="lblOrderID" runat="server" CssClass="cssClassLabel" Text="Order ID:"></asp:Label>
                                <input type="text" id="txtOrderID" class="cssClassTextBoxSmall" />
                            </td>--%>
                            <td>
                                <asp:Label ID="lblStatusName" runat="server" CssClass="cssClassLabel" Text="Status Name:"></asp:Label>
                                <input type="text" id="txtOrderStateName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <asp:Label ID="Label1" runat="server" CssClass="cssClassLabel" Text="Is Active:"></asp:Label>
                                <select id="ddlVisibitity" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchOrderStatus() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxOrderStatusMgmtImage" />
                </div>
                <div class="log">
                </div>
                <table id="tblOrderStatusDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="divEditOrderStatus">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblHeading" runat="server" Text="Edit Order Status ID:"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblOrderStatusName" runat="server" Text="Order Status Name:" CssClass="cssClassLabel"></asp:Label><span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtOrderStatusAliasName" name="StatusName" class="cssClassNormalTextBox required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAliasToolTip" runat="server" Text="Alias Tool Tip:" CssClass="cssClassLabel"></asp:Label><span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtAliasToolTip" name="ToolTipName" class="cssClassNormalTextBox required" minlength="2"  />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAliasHelp" runat="server" Text="Alias Help:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtAliasHelp" class="cssClassNormalTextBox" />
                    </td>
                </tr>
                <tr id="isActiveTR">
                    <td>
                        <asp:Label ID="lblOrderStatusIsActive" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <div id="chkIsActiveOrderStatus" class="cssClassCheckBox">
                            <input id="chkIsActiveOrder" type="checkbox" name="chkIsActive" />
                        </div>
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <asp:Label ID="lblOrderStatusIsDeleted" runat="server" Text="Is Deleted:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <div id="Div1" class="cssClassCheckBox">
                            <input id="chkIsDeleted" type="checkbox" name="chkIsDeleted" />
                        </div>
                    </td>
                </tr>--%>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnBack">
                    <span><span>Back</span></span></button>
            </p>
            <p>
                <button type="reset" id="btnReset">
                    <span><span>Reset</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSaveOrderStatus">
                    <span><span>Save Status</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<input id="hdnIsSystem" type="hidden" />