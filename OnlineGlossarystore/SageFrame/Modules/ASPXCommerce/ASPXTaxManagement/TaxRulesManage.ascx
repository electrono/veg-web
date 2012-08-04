<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TaxRulesManage.ascx.cs"
            Inherits="Modules_ASPXTaxManagement_TaxRulesManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAll();
        $("#divTaxManageRulesGrid").show();
        LoadTaxRuleMgmtStaticImage();
        BindTaxManageRules(null, null, null, null, null, null);
        BindCustomerTaxClass();
        BindItemTaxClass();
        BindTaxRates();

        $("#btnAddNewTaxRule").click(function() {
            ClearForm();
            HideAll();
            $("#divTaxRuleInformation").show();
            $("#hdnTaxManageRuleID").val(0);
        });

        $("#btnDeleteSelected").click(function() {
            var taxManageRule_Id = '';
            $('.TaxRuleChkbox').each(function() {
                if ($(this).attr('checked')) {
                    taxManageRule_Id += $(this).val() + ',';
                }
            });
            if (taxManageRule_Id != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteTaxRules(taxManageRule_Id, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });

        $("#txtPriority").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgPriority").html("Enter Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtDisplayOrder").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgDisplayOrder").html("Enter Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        var trm = $("#form1").validate({
            ignore: ':hidden',
            rules: {
                ruleName: "required",
                priority: "required",
                displayOrder: "required"
            },
            messages: {
                ruleName: "* (at least 2 chars)",
                priority: "*",
                displayOrder: "*"
            }
        });

        $("#btnSaveTaxRule").click(function() {
            if ($('#ddlCustomerTaxClass option:selected').val() == 0) {
                $('#ddlCustomerTaxClass').attr('class', 'cssClassDropDown error');
                return false;
            } else if ($('#ddlItemTaxClass option:selected').val() == 0) {
                $('#ddlItemTaxClass').attr('class', 'cssClassDropDown error');
                return false;
            } else if ($('#ddlTaxRate option:selected').val() == 0) {
                $('#ddlTaxRate').attr('class', 'cssClassDropDown error');
                return false;
            } else if (trm.form()) {
                SaveAndUpdateTaxRules();
                return false;
            } else {
                return false;
            }
        });

        $("#btnCancel").click(function() {
            HideAll();
            $("#divTaxManageRulesGrid").show();
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvTaxRulesDetails').table2CSV();
        });
    });

    function LoadTaxRuleMgmtStaticImage() {
        $('#ajaxTaxRuleMgmtImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAll() {
        $("#divTaxManageRulesGrid").hide();
        $("#divTaxRuleInformation").hide();
    }

    function ClearForm() {
        $("#<%= lblTaxRuleHeading.ClientID %>").html("New Tax Rule Information");
        $("#txtTaxManageRuleName").val('');
        $("#ddlCustomerTaxClass").val('');
        $("#ddlItemTaxClass").val('');
        $("#ddlTaxRate").val('');
        $("#txtPriority").val('');
        $("#txtDisplayOrder").val('');
        ClearErrorLabel();
    }

    function ClearErrorLabel() {
        $('#txtTaxManageRuleName').removeClass('error');
        $('#txtTaxManageRuleName').parents('td').find('label').remove();
        $('#txtPriority').removeClass('error');
        $('#txtPriority').parents('td').find('label').remove();
        $('#txtDisplayOrder').removeClass('error');
        $('#txtDisplayOrder').parents('td').find('label').remove();

        $('#ddlCustomerTaxClass').removeClass('error');
        $('#ddlItemTaxClass').removeClass('error');
        $('#ddlTaxRate').removeClass('error');
    }

    function BindTaxManageRules(ruleNm, customerClassNm, itemClassNm, taxRateTitle, searchPriority, searchDisplayOrder) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvTaxRulesDetails_pagesize").length > 0) ? $("#gdvTaxRulesDetails_pagesize :selected").text() : 10;

        $("#gdvTaxRulesDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetTaxRules',
            colModel: [
                { display: 'TaxManageRule_ID', name: 'taxManageRule_ID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'TaxRuleChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Tax Manage Rule Name', name: 'taxManageRuleName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tax Customer Class Name', name: 'taxCustomerClassName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tax Item Class Name', name: 'taxItemClassName', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tax Rate', name: 'taxRateTitle', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Priority', name: 'priority', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'DisplayOrder', name: 'displayOrder', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditTaxRule', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteTaxRule', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { ruleName: ruleNm, customerClassName: customerClassNm, itemClassName: itemClassNm, rateTitle: taxRateTitle, priority: searchPriority, displayOrder: searchDisplayOrder, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 7: { sorter: false } }
        });
    }

    function EditTaxRule(tblID, argus) {
        switch (tblID) {
        case "gdvTaxRulesDetails":
            ClearErrorLabel();
            $("#hdnTaxManageRuleID").val(argus[0]);
            $("#txtTaxManageRuleName").val(argus[3]);
            $("#<%= lblTaxRuleHeading.ClientID %>").html("Edit Tax Rule: '" + argus[3] + "'");
            $("#ddlCustomerTaxClass option").each(function() {
                if ($(this).text() == argus[4]) {
                    $(this).attr("selected", "selected");
                }
            });
            $("#ddlItemTaxClass option").each(function() {
                if ($(this).text() == argus[5]) {
                    $(this).attr("selected", "selected");
                }
            });
            $("#ddlTaxRate option").each(function() {
                if ($(this).text() == argus[6]) {
                    $(this).attr("selected", "selected");
                }
            });
            $("#txtPriority").val(argus[7]);
            $("#txtDisplayOrder").val(argus[8]);
            HideAll();
            $("#divTaxRuleInformation").show();
            break;
        default:
            break;
        }
    }

    function DeleteTaxRule(tblID, argus) {
        switch (tblID) {
        case "gdvTaxRulesDetails":
            var properties = {
                onComplete: function(e) {
                    DeleteTaxRuleByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteTaxRules(Ids, event) {
        DeleteTaxRuleByID(Ids, event);
    }

    function DeleteTaxRuleByID(_taxRule_Ids, event) {
        if (event) {
            var params = { taxManageRuleIDs: _taxRule_Ids, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteTaxManageRules",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTaxManageRules(null, null, null, null, null, null);
                }
            });
        }
        return false;
    }

    function BindCustomerTaxClass() {
        var params = { storeID: storeId, portalID: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCustomerTaxClass",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindTaxCustomerClassList(item, index);
                });
            }
        });
    }

    function BindTaxCustomerClassList(item, index) {
        $("#ddlCustomerTaxClass").append("<option value=" + item.TaxCustomerClassID + ">" + item.TaxCustomerClassName + "</option>");
        $("#ddlCustomerClassName").append("<option value=" + item.TaxCustomerClassID + ">" + item.TaxCustomerClassName + "</option>");
    }

    function BindItemTaxClass() {
        var params = { storeID: storeId, portalID: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemTaxClass",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindItemTaxClassList(item, index);
                });
            }
        });
    }

    function BindItemTaxClassList(item, index) {
        $("#ddlItemTaxClass").append("<option value=" + item.TaxItemClassID + ">" + item.TaxItemClassName + "</option>");
        $("#ddlItemClassName").append("<option value=" + item.TaxItemClassID + ">" + item.TaxItemClassName + "</option>");
    }

    function BindTaxRates() {
        var params = { storeID: storeId, portalID: portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetTaxRate",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindTaxRatesList(item, index);
                });
            }
        });
    }

    function BindTaxRatesList(item, index) {
        $("#ddlTaxRate").append("<option value=" + item.TaxRateID + ">" + item.TaxRateTitle + "</option>");
        $("#ddlTaxRateTitle").append("<option value=" + item.TaxRateID + ">" + item.TaxRateTitle + "</option>");
    }

    function SaveAndUpdateTaxRules() {
        var taxManageRuleId = $("#hdnTaxManageRuleID").val();
        var taxManageRuleName = $("#txtTaxManageRuleName").val();
        //if (taxManageRuleName != "") {
        var TaxCustomerClassId = $("#ddlCustomerTaxClass").val();
        var TaxItemClassId = $("#ddlItemTaxClass").val();
        var TaxRateId = $("#ddlTaxRate").val();
        var Priority = $("#txtPriority").val();
        var DispalyOrder = $("#txtDisplayOrder").val();
        var param = JSON2.stringify({ taxManageRuleID: taxManageRuleId, taxManageRuleName: taxManageRuleName, taxCustomerClassID: TaxCustomerClassId, taxItemClassID: TaxItemClassId, taxRateID: TaxRateId, priority: Priority, displayOrder: DispalyOrder, cultureName: cultureName, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateTaxRule",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindTaxManageRules(null, null, null, null, null, null);
                HideAll();
                $("#divTaxManageRulesGrid").show();
            },
            error: function() {
                alert("Error!");
            }
        });
        //      }
//        else {
//            csscody.alert("Tax Rule Name can't be Empty!");
//            return false;
//        }
    }

    function SearchTaxManageRules() {
        var ruleNm = $.trim($("#txtRuleName").val());
        var customerClassNm = '';
        var itemClassNm = '';
        var taxRateTitle = '';
        var searchPriority = $.trim($("#txtSearchPriority").val());
        var searchDisplayOrder = $.trim($("#txtSearchDisplayOrder").val());
        if (ruleNm.length < 1) {
            ruleNm = null;
        }
        if (searchPriority.length < 1) {
            searchPriority = null;
        }

        if (searchDisplayOrder.length < 1) {
            searchDisplayOrder = null;
        }

        if ($("#ddlCustomerClassName").val() != 0) {
            customerClassNm = $.trim($("#ddlCustomerClassName").val());
        } else {
            customerClassNm = null;
        }
        if ($("#ddlItemClassName").val() != 0) {
            itemClassNm = $.trim($("#ddlItemClassName").val());
        } else {
            itemClassNm = null;
        }
        if ($("#ddlTaxRateTitle").val() != 0) {
            taxRateTitle = $.trim($("#ddlTaxRateTitle").val());
        } else {
            taxRateTitle = null;
        }
        BindTaxManageRules(ruleNm, customerClassNm, itemClassNm, taxRateTitle, searchPriority, searchDisplayOrder);
    }
</script>

<div id="divTaxManageRulesGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Manage Tax Rules"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewTaxRule">
                            <span><span>Add New Tax Rule</span> </span>
                        </button>
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
                                    Tax Rule Name:</label>
                                <input type="text" id="txtRuleName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Customer Class Name:</label>
                                <select id="ddlCustomerClassName" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Item Class Name:</label>
                                <select id="ddlItemClassName" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Tax Rate Title:</label>
                                <select id="ddlTaxRateTitle" class="cssClassDropDown">
                                    <option value="0">--All--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Priority:</label>
                                <input type="text" id="txtSearchPriority" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Display Order:</label>
                                <input type="text" id="txtSearchDisplayOrder" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchTaxManageRules() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxTaxRuleMgmtImage" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvTaxRulesDetails" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divTaxRuleInformation">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTaxRuleHeading" runat="server" Text="Tax Rule Information:"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblTaxManageRuleName" runat="server" Text="Tax Manage Rule Name:"
                                   CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtTaxManageRuleName" name="ruleName" class="cssClassNormalTextBox" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCustomerTaxClass" runat="server" Text="Customer Tax Class:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <select id="ddlCustomerTaxClass" class="cssClassDropDown required">
                            <option value="0">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblItemTaxClass" runat="server" Text="Item Tax Class:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <select id="ddlItemTaxClass" class="cssClassDropDown required">
                            <option value="0">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTaxRate" runat="server" Text="Tax Rate:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <select id="ddlTaxRate" class="cssClassDropDown required">
                            <option value="0">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPriority" runat="server" Text="Priority:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtPriority" name="priority" class="cssClassNormalTextBox" />
                        <span id="errmsgPriority"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblDisplayOrder" runat="server" Text="Display Order:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtDisplayOrder" name="displayOrder" class="cssClassNormalTextBox" />
                        <span id="errmsgDisplayOrder"></span>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancel">
                    <span><span>Cancel</span> </span>
                </button>
            </p>
            <p>
                <button type="button" id="btnSaveTaxRule">
                    <span><span>Save Tax Rule</span> </span>
                </button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnTaxManageRuleID" />