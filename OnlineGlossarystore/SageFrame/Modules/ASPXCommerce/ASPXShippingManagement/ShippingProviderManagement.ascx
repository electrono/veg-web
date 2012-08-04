<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShippingProviderManagement.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXShippingManagement_ShippingProviderManagement" %>
<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var UserName = '<%= userName %>';
    var CultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAllDiv();
        LoadSippingProviderStaticImage();
        $('#divShippingProviderDetails').show();
        BindShippingProviderNameInGrid(null, null);

        $("#btnSPBack").click(function() {
            $("#divShippingProviderDetails").show();
            $("#divEditShippingProvider").hide();
            // $('#txtSPName').removeClass('error');           
        });

        //        $("#btnSPReset").click(function() {           
        //            ClearForm();
        //        });

        $('#btnSPAddNew').click(function() {
            $("#btnSPReset").show();
            $('#divShippingProviderDetails').hide();
            $('#divEditShippingProvider').show();
            ClearForm();
        });

        $('#btnSaveShippingProvider').click(function() {
            var v = $("#form1").validate({
                messages: {
                    name: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    },
                    name2: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    }
                }
            });

            if (v.form()) {
                var shippingProvider_id = $(this).attr("name");
                if (shippingProvider_id != '') {
                    SaveShippingProvider(shippingProvider_id);
                } else {
                    SaveShippingProvider(0);
                }
            }
        });

        $('#btnSPDeleteSelected').click(function() {
            var shippingProvider_ids = '';
            $("#tblShippingProviderList .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shippingProvider_ids += $(this).val() + ',';
                }
            });
            if (shippingProvider_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleSP(shippingProvider_ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected ShippingProviders?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one Shipping Providers before you can do this.<br/> To select one or more Shipping Providers, just check the box before each Shipping Providers Name.</p>');
            }
        });
    });

    function LoadSippingProviderStaticImage() {
        $('#ajaxShippingProviderImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAllDiv() {
        $('#divShippingProviderDetails').hide();
        $('#divEditShippingProvider').hide();
    }

    function ClearForm() {
        $("#btnSaveShippingProvider").removeAttr("name");
        $("#<%= lblSPHeading.ClientID %>").html("Add New Shipping Provider");

        $('#txtSPServiceCode').val('');
        $('#txtSPName').val('');
        $('#txtSPAliasHelp').val('');
        $("#chkIsActiveSP").removeAttr('checked');
        $("#isActiveSp").show();

        $('#txtSPServiceCode').removeClass('error');
        $('#txtSPServiceCode').parents('td').find('label').remove();
        $('#txtSPName').removeClass('error');
        $('#txtSPName').parents('td').find('label').remove();
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

    function BindShippingProviderNameInGrid(shippingProviderName, isAct) {
        //        $('#txtSearchShippingProviderName').val('');
        //        $("#ddlSPVisibitity").val(0);
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#tblShippingProviderList_pagesize").length > 0) ? $("#tblShippingProviderList_pagesize :selected").text() : 10;

        $("#tblShippingProviderList").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetShippingProviderNameList',
            colModel: [
                { display: 'ShippingProvider ID', name: 'ShippingProvderID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'Shipping Provider Service Code', name: 'ShippingProviderServiceCode', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Shippinng Provider Name', name: 'ShippingProviderName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Shippping Provicer Alias Help', name: 'ShippingProviderAliasHelp', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'IsActive', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditShippingProvider', arguments: '1,2,3,4,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteShippingProvider', arguments: '1' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, CultureName: CultureName, UserName: UserName, ShippingProviderName: shippingProviderName, IsActive: isAct },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 5: { sorter: false } }
        });
    }

    function EditShippingProvider(tblID, argus) {
        switch (tblID) {
        case 'tblShippingProviderList':
            ClearForm();
            $('#divShippingProviderDetails').hide();
            $('#divEditShippingProvider').show();
            $('#btnSPReset').hide();
            $("#<%= lblSPHeading.ClientID %>").html("Edit Shipping Provider ID: '" + argus[0] + "'");
            $('#txtSPServiceCode').val(argus[3]);
            $('#txtSPName').val(argus[4]);
            $('#txtSPAliasHelp').val(argus[5]);
            $("#chkIsActiveSP").attr('checked', Boolean.parse(argus[6]));
            $("#btnSaveShippingProvider").attr("name", argus[0]);
            break;
        default:
            break;
        }
    }

    function SaveShippingProvider(shippingProviderID) {
        var spServiceCode = $('#txtSPServiceCode').val();
        var spName = $('#txtSPName').val();
        var spAliasName = $('#txtSPAliasHelp').val();
        var IsActive = $("#chkIsActiveSP").attr('checked');

        functionName = "ShippingProviderAddUpdate";
        var params = {
            ShippingProviderID: shippingProviderID,
            StoreID: storeId,
            PortalID: portalId,
            UserName: UserName,
            CultureName: CultureName,
            ShippingProviderServiceCode: spServiceCode,
            ShippingProviderName: spName,
            ShippingProviderAliasHelp: spAliasName,
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
                ClearForm();
                BindShippingProviderNameInGrid(null, null);
                $('#divShippingProviderDetails').show();
                $('#divEditShippingProvider').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to edit Shipping Provider</p>');
            }
        });
    }

    function DeleteShippingProvider(tblID, argus) {
        switch (tblID) {
        case 'tblShippingProviderList':
            DeleteSingleSP(argus[0]);
            break;
        default:
            break;
        }
    }

    function DeleteSingleSP(_shippingProviderID) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleSPDelete(_shippingProviderID, e);
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this Shipping Provider?</p>", properties);
    }

    function ConfirmSingleSPDelete(_shippingProviderID, event) {
        if (event) {
            DeleteSingleShippingProvider(_shippingProviderID);
        }
        return false;
    }

    function DeleteSingleShippingProvider(_shippingProviderID) {
        var functionName = 'DeleteShippingProviderByID';
        var params = { ShippingProviderID: parseInt(_shippingProviderID), StoreID: storeId, PortalID: portalId, UserName: UserName, CultureName: CultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                ClearForm();
                BindShippingProviderNameInGrid(null, null);
                $('#divShippingProviderDetails').show();
                $('#divEditShippingProvider').hide();
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Shipping Provider</p>');
            }
        });
    }

    function ConfirmDeleteMultipleSP(shippingProvider_ids, event) {

        if (event) {
            DeleteMultipleShippingProviders(shippingProvider_ids);
        }
    }

    function DeleteMultipleShippingProviders(shippingProvider_ids) {
        var functionName = 'DeleteShippingProviderMultipleSelected';
        var params = { ShippingProviderIDs: shippingProvider_ids, StoreID: storeId, PortalID: portalId, UserName: UserName, CultureName: CultureName };
        var mydata = JSON2.stringify(params);

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                ClearForm();
                BindShippingProviderNameInGrid(null, null);
                $('#divShippingProviderDetails').show();
                $('#divEditShippingProvider').hide();

            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to Delete Shipping Providers</p>');
            }
        });
        return false;
    }

    function SearchShippingProvider() {
        var shippingProviderName = $.trim($('#txtSearchShippingProviderName').val());
        if (shippingProviderName.length < 1) {
            shippingProviderName = null;
        }
        var isAct = $.trim($("#ddlSPVisibitity").val()) == "" ? null : ($.trim($("#ddlSPVisibitity").val()) == "True" ? true : false);

        BindShippingProviderNameInGrid(shippingProviderName, isAct);
    }
</script>

<div id="divShippingProviderDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblShippingProvider" runat="server" Text="Shipping Providers"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnSPDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnSPAddNew">
                            <span><span>Add New Shipping Provider</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table cellspacing="0" cellpadding="0" border="0" width="100%">
                        <tr>                            
                            <td>
                                <asp:Label ID="lblShippingProviderName" runat="server" CssClass="cssClassLabel" Text="Shipping Providers Name:"></asp:Label>
                                <input type="text" id="txtSearchShippingProviderName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <asp:Label ID="lblShippingProviderIsActive" runat="server" CssClass="cssClassLabel" Text="Is Active:"></asp:Label>
                                <select id="ddlSPVisibitity" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchShippingProvider() " >
                                            <span><span>Search</span></span></button> <!--onclick="SearchOrderStatus()"-->
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxShippingProviderImage" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="tblShippingProviderList" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
        
    </div>
</div>

<div id="divEditShippingProvider">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblSPHeading" runat="server" Text="Edit Shipping Provider ID:"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblSPServiceCode" runat="server" Text="Shipping Provider Service Code:" CssClass="cssClassLabel"></asp:Label><span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtSPServiceCode" name="name" class="cssClassNormalTextBox required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSPName" runat="server" Text="Shipping Provider Name:" CssClass="cssClassLabel"></asp:Label><span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtSPName" name="name2" class="cssClassNormalTextBox required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSPAliasHelp" runat="server" Text="Shipping Provider Alias Help:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtSPAliasHelp" class="cssClassNormalTextBox" />
                    </td>
                </tr>
                <tr id="isActiveSp">
                    <td>
                        <asp:Label ID="lblSPIsActive" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <div id="chkIsActiveShippingProvider" class="cssClassCheckBox">
                            <input id="chkIsActiveSP" type="checkbox" name="chkIsActive" />
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
                <button type="button" id="btnSPBack">
                    <span><span>Back</span></span></button>
            </p>
            <p>
                <button type="reset" id="btnSPReset">
                    <span><span>Reset</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSaveShippingProvider"  class="cssClassButtonSubmit" type="submit" value="Save">
                    <span><span>Save</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>