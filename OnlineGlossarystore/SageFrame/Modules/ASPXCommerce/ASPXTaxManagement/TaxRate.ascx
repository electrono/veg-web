<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TaxRate.ascx.cs" Inherits="Modules_ASPXTaxManagement_TaxRate" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        HideAll();
        $("#divTaxRatesGrid").show();
        LoadTaxRateStaticImage();
        BindTaxRates(null, null, null, null);
        GetCountryList();
        GetStateList();

        $("#btnExportToCSV").click(function() {
            $('#gdvTaxRateDetails').table2CSV();
        });

        $("#btnAddNewTaxRate").click(function() {
            $("#ddlState").hide();
            $("#trZipPostCode").show();
            $("#trRangeFrom").hide();
            $("#trRangeTo").hide();
            ClearForm();
            HideAll();
            $("#divTaxRateInformation").show();
            $("#hdnTaxRateID").val(0);
        });

        $("#ddlCountry").change(function() {
            if ($(this).val() == "US") {
                $("#ddlState").show();
                $("#txtState").hide();
            } else {
                $("#ddlState").hide();
                $("#txtState").show();
            }
        });

        $("#chkIsTaxZipRange").click(function() {
            if ($(this).is(':checked')) {
                $("#trZipPostCode").hide();
                $("#trRangeFrom").show();
                $("#trRangeTo").show();
            } else {
                $("#trRangeFrom").hide();
                $("#trRangeTo").hide();
                $("#trZipPostCode").show();
            }
        });

        $("#btnDeleteSelected").click(function() {
            var taxRate_Ids = '';
            $('.TaxRateChkbox').each(function() {
                if ($(this).attr('checked')) {
                    taxRate_Ids += $(this).val() + ',';
                }
            });
            if (taxRate_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteTaxRates(taxRate_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected options?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one option before you can do this.<br/> To select one or more options, just check the box before each options.</p>');
            }

        });

        var tr = $("#form1").validate({
            ignore: ':hidden',
            rules: {
                rateTitle: "required",
                state: "required",
                zipCode: "required",
                rangefrom: "required",
                rangeTo: "required",
                taxRate: {
                    required: true,
                    number: true
                }
            },
            messages: {
                rateTitle: "* (at least 2 chars)",
                state: "* (at least 2 chars)",
                zipCode: "* (at least 5 chars)",
                rangefrom: "* (at least 5 chars)",
                rangeTo: "* (at least 5 chars)",
                taxRate: "*"
            }
        });

        $("#btnSaveTaxRate").click(function() {
            if ($('#ddlCountry option:selected').val() != 0) {
                if (tr.form()) {
                    SaveAndUpdateTaxRate();
                    return false;
                } else {
                    return false;
                }
            } else {
                $('#ddlCountry ').attr('class', 'error');
            }

        });

        //        $("#btnSaveTaxRate").click(function() {
        //            SaveAndUpdateTaxRate();
        //        });

        $("#btnCancel").click(function() {
            HideAll();
            $("#divTaxRatesGrid").show();
        });

        $("#txtZipPostCode").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgZipPostCode").html("Enter Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtRangeFrom").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgRangeFrom").html("Enter Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });

        $("#txtRangeTo").keypress(function(e) {
            if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                $("#errmsgRangeTo").html("Enter Digits Only").css("color", "red").show().fadeOut(1600);
                return false;
            }
        });
        $("#ddlTaxRateType").change(function() {
            if ($.trim($("#ddlTaxRateType").val().toLowerCase()) == "false") {
            } else {
                if ($("#txtTaxRateValue").val() < 100) {
                } else {
                    $("#txtTaxRateValue").val('');
                }
            }

        });
        $("#txtTaxRateValue").keypress(function(e) {
            if ($.trim($("#ddlTaxRateType").val().toLowerCase()) == "false") {
                if (e.which != 8 && e.which != 0 && e.which != 46 && e.which != 31 && (e.which < 48 || e.which > 57)) {
                    $("#errmsgTaxRateValue").html("Enter Digits And Decimal Only").css("color", "red").show().fadeOut(1600);
                    return false;
                }
            } else {
                if (e.which == 8 || e.which == 0 || e.which == 46)
                    return true;
                //if the letter is not digit 
                if (e.which < 48 || e.which > 57)
                    return false;
                // check max range 
                var dest = e.which - 48;
                var result = this.value + dest.toString();
                if (result > 99.99) {
                    return false;
                }
            }
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvTaxRateDetails').table2CSV();
        });
    });

    function LoadTaxRateStaticImage() {
        $('#ajaxTaxRateImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvTaxRateDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvTaxRateDetails tbody tr");
        // var table = $("#Export1_lblTitle").text();
        var table = '<table>';
        table += header;
        $.each(data, function(index, item) {
            var cells = $(this).find("td");
            var td = "";
            $.each(cells, function(i, itm) {

                if ($(this).find("div").hasClass("cssClassActionOnClick")) {
                    //do not add
                } else {
                    td += '<td>' + $(this).text() + '</td>';
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

    function HideAll() {
        $("#divTaxRatesGrid").hide();
        $("#divTaxRateInformation").hide();
    }

    function ClearForm() {
        $("#<%= lblTaxRateHeading.ClientID %>").html("New Tax Rate Information");
        $("#txtTaxRateTitle").val('');
        $("#ddlCountry").val('');
        $("#ddlState").val('');
        $("#txtZipPostCode").val('');
        $("#chkIsTaxZipRange").removeAttr('checked');
        $("#txtRangeFrom").val('');
        $("#txtRangeTo").val('');
        $("#txtTaxRateValue").val('');
        $("#txtState").val('');
        $('#txtTaxRateTitle').removeClass('error');
        $('#txtTaxRateTitle').parents('td').find('label').remove();
        $('#txtZipPostCode').removeClass('error');
        $('#txtZipPostCode').parents('td').find('label').remove();
        $('#txtRangeFrom').removeClass('error');
        $('#txtRangeFrom').parents('td').find('label').remove();
        $('#txtRangeTo').removeClass('error');
        $('#txtRangeTo').parents('td').find('label').remove();
        $('#txtState').removeClass('error');
        $('#txtState').parents('td').find('label').remove();
        $('#txtTaxRateValue').removeClass('error');
        $('#txtTaxRateValue').parents('td').find('label').remove();
    }

    function BindTaxRates(taxName, country, state, zipPostCode) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvTaxRateDetails_pagesize").length > 0) ? $("#gdvTaxRateDetails_pagesize :selected").text() : 10;

        $("#gdvTaxRateDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetTaxRateDetails',
            colModel: [
                { display: 'TaxRate_ID', name: 'taxrate_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'TaxRateChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Tax Rate Title', name: 'tax_rate_title', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Country', name: 'country', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'State/Province', name: 'state_region', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Zip/Post Code', name: 'tax_zip_code', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Zip/Post Is Range', name: 'is_tax_zip_range', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tax Rate Value', name: 'tax_rate_value', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Rate Percentage', name: 'tax_rate_value', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditTaxRate', arguments: '1,2,3,4,5,6,7' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteTaxRate', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { taxName: taxName, searchCountry: country, searchState: state, zip: zipPostCode, storeID: storeId, portalID: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 8: { sorter: false } }
        });
    }

    function EditTaxRate(tblID, argus) {
        switch (tblID) {
        case "gdvTaxRateDetails":
            $("#<%= lblTaxRateHeading.ClientID %>").html("Edit Tax Rate: '" + argus[3] + "'");
            $("#hdnTaxRateID").val(argus[0]);
            $("#txtTaxRateTitle").val(argus[3]);

            $("#ddlCountry option").each(function() {
                if ($(this).text() == argus[4]) {
                    $(this).attr("selected", "selected");
                }
            });

            if ($("#ddlCountry").val() == "US") {
                $("#ddlState").val(argus[5]);
                $("#txtState").hide();
                $("#ddlState").show();
            } else {
                $("#txtState").val(argus[5]);
                $("#ddlState").hide();
                $("#txtState").show();
            }

            $("#txtZipPostCode").val(argus[6]);
            var range = argus[6];
            var subStr = range.split('-');
            $("#txtRangeFrom").val(subStr[0]);
            $("#txtRangeTo").val(subStr[1]);
            $("#txtTaxRateValue").val(argus[8]);
            $("#ddlTaxRateType").val(argus[9]);
            HideAll();
            $("#divTaxRateInformation").show();
            $("#chkIsTaxZipRange").attr('checked', $.parseJSON(argus[7].toLowerCase()));
            if ($("#chkIsTaxZipRange").is(':checked')) {
                $("#trZipPostCode").hide();
                $("#trRangeFrom").show();
                $("#trRangeTo").show();
                $("#txtZipPostCode").val('');
            } else {
                $("#trRangeFrom").hide();
                $("#trRangeTo").hide();
                $("#trZipPostCode").show();
                $("#txtRangeFrom").val('');
                $("#txtRangeTo").val('');
            }
            break;
        default:
            break;
        }
    }

    function DeleteTaxRate(tblID, argus) {
        switch (tblID) {
        case "gdvTaxRateDetails":
            var properties = {
                onComplete: function(e) {
                    DeleteTaxRateByID(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteTaxRates(Ids, event) {
        DeleteTaxRateByID(Ids, event);
    }

    function DeleteTaxRateByID(_taxRate_Ids, event) {
        if (event) {
            var params = { taxRateIDs: _taxRate_Ids, storeID: storeId, portalID: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteTaxRates",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTaxRates(null, null, null, null);
                }
            });
        }
        return false;
    }


    function GetCountryList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCountryList",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindTaxCountryList(item);
                });
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function BindTaxCountryList(item, index) {
        $("#ddlCountry").append("<option value=" + item.Value + ">" + item.Text + "</option>");
        $("#ddlSearchCountry").append("<option value=" + item.Value + ">" + item.Text + "</option>");
    }

    function GetStateList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindStateList",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindTaxStateList(item, index);
                });
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function BindTaxStateList(item, index) {
        $("#ddlState").append("<option value=" + item.Value + ">" + item.Text + "</option>");
        $("#ddlSearchState").append("<option value" + item.Value + ">" + item.Text + "</option>");
    }

    function SaveAndUpdateTaxRate() {
        var TaxRateId = $("#hdnTaxRateID").val();
        var TaxRateTitle = $("#txtTaxRateTitle").val();
        if (TaxRateTitle != "") {
            var TaxCountryCode = '';
            if ($("#ddlCountry option:selected").val() != "0") {
                TaxCountryCode = $("#ddlCountry option:selected").val();
            } else {
                csscody.alert("You Must Select Country!");
                return false;
            }
            var TaxStateCode = '';
            if ($("#ddlCountry").val() == "US") {
                if ($("#ddlState").val() != 0) {
                    TaxStateCode = $("#ddlState option:selected").val();
                } else {
                    csscody.alert("You Must Select State!");
                    return false;
                }
            } else {
                if ($("#txtState").val() != "") {
                    TaxStateCode = $("#txtState").val();
                } else {
                    csscody.alert("State can't be Empty!");
                    return false;
                }
            }
            var IsTaxZipRange = $("#chkIsTaxZipRange").attr('checked');
            var zipPostRange = '';
            if ($("#chkIsTaxZipRange").is(':checked')) {
                zipPostRange = $("#txtRangeFrom").val() + '-' + $("#txtRangeTo").val();
            } else {
                zipPostRange = $("#txtZipPostCode").val();
            }
            var TaxRateValue = $("#txtTaxRateValue").val();
            var RateType = $("#ddlTaxRateType").val();
            var param = JSON2.stringify({ taxRateID: TaxRateId, taxRateTitle: TaxRateTitle, taxCountryCode: TaxCountryCode, taxStateCode: TaxStateCode, taxZipCode: zipPostRange, isTaxZipRange: IsTaxZipRange, taxRateValue: TaxRateValue, rateType: RateType, storeID: storeId, portalID: portalId, userName: userName });
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndUpdateTaxRates",
                data: param,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindTaxRates(null, null, null, null);
                    HideAll();
                    $("#divTaxRatesGrid").show();
                },
                error: function() {
                    alert("Error!");
                }
            });
        } else {
            csscody.alert("Tax Rate Title can't be Empty!");
            return false;
        }
    }

    function SearchTaxRate() {
        var taxName = $.trim($("#txtRateTitle").val());
        var country = '';
        var state = $.trim($("#txtSearchState").val());
        var zipPostCode = $.trim($("#txtSearchZip").val());
        if (taxName.length < 1) {
            taxName = null;
        }
        if ($("#ddlSearchCountry").val() != "0") {
            country = $.trim($("#ddlSearchCountry option:selected").val());
        } else {
            country = null;
        }
        if (state.length < 1) {
            state = null;
        }
        if (zipPostCode.length < 1) {
            zipPostCode = null;
        }
        BindTaxRates(taxName, country, state, zipPostCode);
    }
</script>

<div id="divTaxRatesGrid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Tax Rates"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnAddNewTaxRate">
                            <span><span>Add New Tax Rate</span> </span>
                        </button>
                    </p>
                    <p>
                        <asp:Button ID="btnExportToExcel" CssClass="cssClassButtonSubmit" runat="server"
                                    OnClick="Button1_Click" Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
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
                                    Tax Rate Title:</label>
                                <input type="text" id="txtRateTitle" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Country:</label>
                                <select id="ddlSearchCountry" class="cssClassDropDown">
                                    <option value="0">--Select Country--</option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    State/Region:</label>
                                <input type="text" id="txtSearchState" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Zip Post Code:</label>
                                <input type="text" id="txtSearchZip" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchTaxRate() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxTaxRateImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvTaxRateDetails" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div id="divTaxRateInformation">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTaxRateHeading" runat="server" Text="Tax Rate Information"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblTaxRateTitle" runat="server" Text="Tax Rate Title:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtTaxRateTitle" name="rateTitle" minlength="2" class="cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCountry" runat="server" Text="Country:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <select id="ddlCountry" class="cssClassDropDown required">
                            <option value="0">--Select Country--</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblState" runat="server" Text="State/Province:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <select id="ddlState" class="cssClassDropDown">
                            <option value="0">--Select State--</option>
                        </select>
                        <input type="text" id="txtState" name="state" minlength="2" class="cssClassNormalTextBox required" />
                    </td>
                </tr>
                <tr id="trZipPostCode">
                    <td>
                        <asp:Label ID="lblZipPostCode" runat="server" Text="Zip/Post Code:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtZipPostCode" name="zipCode" minlength="5" class="cssClassNormalTextBox required" />
                        <span id="errmsgZipPostCode"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblIsZipPostRange" runat="server" Text="Is Zip/Post Range:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <input type="checkbox" id="chkIsTaxZipRange" class="cssClassCheckBox" />
                    </td>
                </tr>
                <tr id="trRangeFrom">
                    <td>
                        <asp:Label ID="lblRangeFrom" runat="server" Text="Range From:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtRangeFrom" name="rangefrom" minlength="5" class="cssClassNormalTextBox required" />
                        <span id="errmsgRangeFrom"></span>
                    </td>
                </tr>
                <tr id="trRangeTo">
                    <td>
                        <asp:Label ID="lblRangeTo" runat="server" Text="Range To:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtRangeTo" name="rangeTo" minlength="5" class="cssClassNormalTextBox required" />
                        <span id="errmsgRangeTo"></span>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblRateType" runat="server" Text="Rate Type:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td>
                        <select id="ddlTaxRateType" class="cssClassDropDownCostDependencies">
                            <option value="False">Absolute ($)</option>
                            <option value="True">Percent (%)</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblTaxRateValue" runat="server" Text="Tax Rate:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td>
                        <input type="text" id="txtTaxRateValue" name="taxRate" class="cssClassNormalTextBox required" />
                        <span id="errmsgTaxRateValue"></span>
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
                <button type="button" id="btnSaveTaxRate">
                    <span><span>Save Tax Rate</span> </span>
                </button>
            </p>
        </div>
    </div>
</div>
<input type="hidden" id="hdnTaxRateID" />