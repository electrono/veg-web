<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreTaxes.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXTaxManagement_StoreTaxes" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= username %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadStoreTaxImageStaticImage();
        BindStoreTaxesGrid(null, true, false, false);
        $("#ddlTaxReport").change(function() {
            ShowReport();
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvStoreTaxes').table2CSV();
        });
    });

    function LoadStoreTaxImageStaticImage() {
        $('#ajaxStoreTaxImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ShowReport() {
        var selectreport = $("#ddlTaxReport").val();
        switch (selectreport) {
        case '1':
            BindStoreTaxesGrid(null, true, false, false);
            break;
        case '2':
            BindStoreTaxesGrid(null, false, true, false);
            break;
        case '3':
            BindStoreTaxesGrid(null, false, false, true)
            break;
        }
    }

    function BindStoreTaxesGrid(Nm, monthly, weekly, hourly) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvStoreTaxes_pagesize").length > 0) ? $("#gdvStoreTaxes_pagesize :selected").text() : 10;
        $("#gdvStoreTaxes").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetStoreSalesTaxes',
            colModel: [
                { display: 'TaxName', name: 'tax_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Rate', name: 'rate', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'quantity', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Percent', name: 'is_percent', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'No Of Orders', name: 'noOfOrders', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'TaxAmount', name: 'taxamount', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Period', name: 'period', cssclass: '', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { taxRuleName: Nm, storeID: storeId, portalID: portalId, Monthly: monthly, Weekly: weekly, Hourly: hourly },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false } }
        });
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvStoreTaxes thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvStoreTaxes tbody tr");
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

    function SearchItems() {

        var Nm = $.trim($("#txtSearchName").val());

        if (Nm.length < 1) {
            Nm = null;
        }
        var selectreport = $("#ddlTaxReport").val();
        switch (selectreport) {
        case '1':
            BindStoreTaxesGrid(Nm, true, false, false);
            break;
        case '2':
            BindStoreTaxesGrid(Nm, false, true, false);
            break;
        case '3':
            BindStoreTaxesGrid(Nm, false, false, true)
            break;
        }
    }

</script>
<div align="right">
    <label><b>Show Tax Reports:</b></label>
    <select id="ddlTaxReport">
        <option value="1">Show Year Report</option>
        <option value="2">Show Current Month Report</option>
        <option value="3">Show Today's Report</option>
    </select></div>
<div id="gdvStoreTax_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Store Taxes"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
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
                                    TaxName:</label>
                                <input type="text" id="txtSearchName" class="cssClassTextBoxSmall" />
                            </td>
                            
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchItems() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxStoreTaxImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvStoreTaxes" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />