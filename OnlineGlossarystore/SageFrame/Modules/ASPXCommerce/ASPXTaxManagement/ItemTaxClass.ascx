<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemTaxClass.ascx.cs"
            Inherits="Modules_ASPXTaxManagement_ItemTaxClass" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAll();
        $("#divTaxItemClassGrid").show();
        LoadItemTaxClassStaticImage();
        BindTaxItemClasses(null);

        $("#btnAddNewTaxItemClass").click(function() {
            HideAll();
            $("#<%= lblItemTaxClassHeading.ClientID %>").html("New Item Tax Class");
            $("#divProductTaxClass").show();
            $("#txtTaxItemClassName").val('');
            $("#hdnTaxItemClassID").val(0);
        });

        $("#btnSaveTaxItemClass").click(function() {
            SaveAndUpdateTaxItemClass();
        });

        $("#btnCancel").click(function() {
            HideAll();
            $("#divTaxItemClassGrid").show();
        });

        $('#btnDeleteSelected').click(function() {
            var TaxItemClass_Ids = '';
            $(".TaxItemClassChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    TaxItemClass_Ids += $(this).val() + ',';
                }
            });
            if (TaxItemClass_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteTaxItemClass(TaxItemClass_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }
        });
    });

    function LoadItemTaxClassStaticImage() {
        $('#ajaxItemTaxClassImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAll() {
        $("#divTaxItemClassGrid").hide();
        $("#divProductTaxClass").hide();
    }

    function BindTaxItemClasses(itemClassNm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvTaxItemClassDetails_pagesize").length > 0) ? $("#gdvTaxItemClassDetails_pagesize :selected").text() : 10;

        $("#gdvTaxItemClassDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetTaxItemClassDetails',
            colModel: [
                { display: 'TaxItemClass_ID', name: 'tax_item_class_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'TaxItemClassChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Tax Item Class Name', name: 'tax_item_class_name', cssclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditTaxItemClass', arguments: '1,2,3' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteTaxItemClass', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { itemClassName: itemClassNm, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 2: { sorter: false } }
        });
    }

    function EditTaxItemClass(tblID, argus) {
        switch (tblID) {
        case "gdvTaxItemClassDetails":
            $("#<%= lblItemTaxClassHeading.ClientID %>").html("Edit Item Tax Class: '" + argus[3] + "'");
            $("#hdnTaxItemClassID").val(argus[0]);
            $("#txtTaxItemClassName").val(argus[3]);
            HideAll();
            $("#divProductTaxClass").show();
            break;
        default:
            break;
        }
    }

    function DeleteTaxItemClass(tblID, argus) {
        switch (tblID) {
        case "gdvTaxItemClassDetails":
            var properties = {
                onComplete: function(e) {
                    DeleteTaxItemClassByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteTaxItemClass(Ids, event) {
        DeleteTaxItemClassByID(Ids, event);
    }

    function DeleteTaxItemClassByID(taxItemClass_Ids, event) {
        if (event) {
            var params = { taxItemClassIDs: taxItemClass_Ids, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteTaxItemClass",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTaxItemClasses(null);
                }
            });
        }
        return false;
    }

    function SaveAndUpdateTaxItemClass() {
        var taxItemClassId = $("#hdnTaxItemClassID").val();
        var taxItemClassName = $("#txtTaxItemClassName").val();
        if (taxItemClassName != "") {
            var param = JSON2.stringify({ taxItemClassID: taxItemClassId, taxItemClassName: taxItemClassName, cultureName: cultureName, storeID: storeId, portalID: portalId, userName: userName });
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateTaxItemClass",
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindTaxItemClasses(null);
                    HideAll();
                    $("#divTaxItemClassGrid").show();
                },
                error: function() {
                    alert("Error!");
                }
            });
        } else {
            csscody.alert("Tax Item Class can't be Empty!");
            return false;
        }
    }

    function SearchItemClassName() {
        var itemClassNm = $.trim($("#txtItemClassName").val());
        if (itemClassNm.length < 1) {
            itemClassNm = null;
        }
        BindTaxItemClasses(itemClassNm);
    }
</script>

<div id="divTaxItemClassGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Item Tax Classes"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewTaxItemClass">
                            <span><span>Add New Item Tax Class</span> </span>
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
                                    Item Class Name:</label>
                                <input type="text" id="txtItemClassName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchItemClassName() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxItemTaxClassImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvTaxItemClassDetails" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divProductTaxClass">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblItemTaxClassHeading" runat="server" Text="Item Tax Class Information"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblTaxItemClassName" runat="server" Text="Tax Item Class Name:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtTaxItemClassName" class="cssClassNormalTextBox" />
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
                <button type="button" id="btnSaveTaxItemClass">
                    <span><span>Save Tax Item Class</span> </span>
                </button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnTaxItemClassID" />