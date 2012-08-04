<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomerTaxClass.ascx.cs"
            Inherits="Modules_ASPXTaxManagement_CustomerTaxClass" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAll();
        $("#divTaxCustomerClassGrid").show();
        LoadCustomerTaxStaticImage();
        BindCustomerTaxClasses(null);

        $("#btnAddNewTaxCustomerClass").click(function() {
            HideAll();
            $("#<%= lblCustomerTaxClassHeading.ClientID %>").html("New Customer Tax Class");
            $("#divCustomerTaxClass").show();
            $("#txtTaxCustomerClassName").val('');
            $("#hdnTaxCustomerClass").val(0);
        });

        $("#btnSaveTaxCustomerClass").click(function() {
            SaveAndUpdateTaxCustmerClass();
        });

        $("#btnCancel").click(function() {
            HideAll();
            $("#divTaxCustomerClassGrid").show();
        });

        $("#btnDeleteSelected").click(function() {
            var taxCustomerClass_Ids = '';
            $('.TaxCustomerClassChkbox').each(function() {
                if ($(this).attr('checked')) {
                    taxCustomerClass_Ids += $(this).val() + ',';
                }
            });
            if (taxCustomerClass_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteTaxCustomerClass(taxCustomerClass_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });
    });

    function LoadCustomerTaxStaticImage() {
        $('#ajaxCustomerTaxClassImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAll() {
        $("#divTaxCustomerClassGrid").hide();
        $("#divCustomerTaxClass").hide();
    }

    function BindCustomerTaxClasses(classNm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvTaxCustomerClassDetails_pagesize").length > 0) ? $("#gdvTaxCustomerClassDetails_pagesize :selected").text() : 10;

        $("#gdvTaxCustomerClassDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetTaxCustomerClassDetails',
            colModel: [
                { display: 'TaxCostomerClass_ID', name: 'tax_customer_class_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'TaxCustomerClassChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Tax Customer Class Name', name: 'tax_customer_class_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditTaxCustomerClass', arguments: '1,2,3' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteTaxCustomerClass', arguments: '' }
            ],
            txtClass: 'cssClassNormalTextBox',
            rp: perpage,
            nomsg: "No Records Found!",
            param: { className: classNm, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 2: { sorter: false } }
        });
    }

    function EditTaxCustomerClass(tblID, argus) {
        switch (tblID) {
        case "gdvTaxCustomerClassDetails":
            $("#hdnTaxCustomerClass").val(argus[0]);
            $("#txtTaxCustomerClassName").val(argus[3]);
            $("#<%= lblCustomerTaxClassHeading.ClientID %>").html("Edit Customer Tax Class: '" + argus[3] + "'");
            HideAll();
            $("#divCustomerTaxClass").show();
            break;
        default:
            break;
        }
    }

    function DeleteTaxCustomerClass(tblID, argus) {
        switch (tblID) {
        case "gdvTaxCustomerClassDetails":
            var properties = {
                onComplete: function(e) {
                    DeleteTaxCustomerClassByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteTaxCustomerClass(Ids, event) {
        DeleteTaxCustomerClassByID(Ids, event);
    }

    function DeleteTaxCustomerClassByID(_taxCustomerClass_Ids, event) {
        if (event) {
            var params = { taxCustomerClassIDs: _taxCustomerClass_Ids, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteTaxCustomerClass",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindCustomerTaxClasses(null);
                }
            });
        }
        return false;
    }

    function SaveAndUpdateTaxCustmerClass() {
        var taxCustomerClassId = $("#hdnTaxCustomerClass").val();
        var taxCustomerClassName = $("#txtTaxCustomerClassName").val();
        if (taxCustomerClassName != "") {
            var param = JSON2.stringify({ taxCustomerClassID: taxCustomerClassId, taxCustomerClassName: taxCustomerClassName, cultureName: cultureName, storeID: storeId, portalID: portalId, userName: userName });
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateTaxCustmerClass",
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindCustomerTaxClasses(null);
                    HideAll();
                    $("#divTaxCustomerClassGrid").show();
                },
                error: function() {
                    alert("Error!");
                }
            });
        } else {
            csscody.alert("Tax Customer Class can't be Empty!");
            return false;
        }
    }

    function SearchCustomerClassName() {
        var classNm = $.trim($("#txtCustomerClassName").val());
        if (classNm.length < 1) {
            classNm = null;
        }
        BindCustomerTaxClasses(classNm);
    }
</script>

<div id="divTaxCustomerClassGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Customer Tax Classes"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewTaxCustomerClass">
                            <span><span>Add New Customer Tax Class</span> </span>
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
                                    Customer Class Name:</label>
                                <input type="text" id="txtCustomerClassName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCustomerClassName() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxCustomerTaxClassImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvTaxCustomerClassDetails" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div id="divCustomerTaxClass">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCustomerTaxClassHeading" runat="server" Text="Customer Tax Class Information"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblTaxCustomerClassName" runat="server" Text="Tax Customer Class Name:"
                                   CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtTaxCustomerClassName" class="cssClassNormalTextBox" />
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
                <button type="button" id="btnSaveTaxCustomerClass">
                    <span><span>Save Tax Customer Class</span> </span>
                </button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnTaxCustomerClass" />