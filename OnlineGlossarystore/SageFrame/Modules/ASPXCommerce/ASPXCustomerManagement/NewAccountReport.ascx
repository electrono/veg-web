<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NewAccountReport.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXNewAccountReport_NewAccountReport" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadCustomerNewAccountStaticImage();
        BindNewAccountReport(true, false, false);
        $("#ddlNewAccountReport").change(function() {
            ShowReport();
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvNewAccountList').table2CSV();
        });
    });

    function LoadCustomerNewAccountStaticImage() {
        $('#ajaxNewAccountReportImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ShowReport() {
        var selectreport = $("#ddlNewAccountReport").val();
        switch (selectreport) {
        case '1':
            BindNewAccountReport(true, false, false);
            break;
        case '2':
            BindNewAccountReport(false, true, false);
            break;
        case '3':
            BindNewAccountReport(false, false, true);
            break;
        }
    }

    function BindNewAccountReport(monthly, weekly, hourly) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvNewAccountList_pagesize").length > 0) ? $("#gdvNewAccountList_pagesize :selected").text() : 10;

        $("#gdvNewAccountList").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetNewAccounts',
            colModel: [
                { display: 'Period', name: 'period', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of New Accounts', name: 'new_acounts', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center', hide: true }
            ],

            buttons: [
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, cultureName: cultureName, Monthly: monthly, Weekly: weekly, Hourly: hourly },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 13: { sorter: false } }
        });
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvNewAccountList thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvNewAccountList tbody tr");
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

</script>
<div align="right">
    <label><b>Show Reports:</b></label>
    <select id="ddlNewAccountReport">
        <option value="1">Show Current Year Monthly Report</option>
        <option value="2">Show Current Month Weekly Report</option>
        <option value="3">Show Today's Report</option>
    </select></div>
<div id="divNewAccountDetailsByMonthly">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblReviewsGridHeading" runat="server" Text="Customer Accounts"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportToExcel" class="cssClassButtonSubmit" runat="server" OnClick="Button1_Click"
                                    Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
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
                <div class="loading">
                    <img id="ajaxNewAccountReportImageLoad" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvNewAccountList" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />