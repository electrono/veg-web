<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShippingReport.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXShippingReport_ShippingReport" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadShippingReportStaticImage();
        ShippedReportDetails(null, true, false, false);
        $("#ddlShippingReport").change(function() {
            ShowReport();
        });
        $("#btnExportToCSV").click(function() {
            $('#gdvShippedReportDetails').table2CSV();
        });

    });

    function LoadShippingReportStaticImage() {
        $('#ajaxShippingReportImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ShowReport() {
        var selectreport = $("#ddlShippingReport").val();
        switch (selectreport) {
        case '1':
            ShippedReportDetails(null, true, false, false);
            break;
        case '2':
            ShippedReportDetails(null, false, true, false);
            break;
        case '3':
            ShippedReportDetails(null, false, false, true)
            break;
        }
    }

    function ShippedReportDetails(shippingName, monthly, weekly, hourly) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShippedReportDetails_pagesize").length > 0) ? $("#gdvShippedReportDetails_pagesize :selected").text() : 10;

        $("#gdvShippedReportDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetShippedDetails',
            colModel: [
                { display: 'Shipping Method ID', name: 'shipping_methodId', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Shipping Method Name', name: 'shipping_method_name', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Orders', name: 'num_of_orders', cssclass: 'cssClassLinkHeader', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Total Shipping', name: 'ship_to_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Period', name: 'period', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center', hide: true }
            ],
            buttons: [
                //{ display: 'View', name: 'view', enable: true, _event: 'click', trigger: '3', callMethod: 'ViewShipments', arguments: '1,2,3,4,5,6' },
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, cultureName: cultureName, shippingMethodName: shippingName, Monthly: monthly, Weekly: weekly, Hourly: hourly },
            current: current_,
            pnew: offset_,
            sortcol: { o: { sorter: true }, 4: { sorter: false } }
        });
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvShippedReportDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShippedReportDetails tbody tr");
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

    function SearchShippingReport() {

        var Nm = $.trim($("#txtShippingMethodNm").val());

        if (Nm.length < 1) {
            Nm = null;
        }
        var selectreport = $("#ddlShippingReport").val();
        switch (selectreport) {
        case '1':
            ShippedReportDetails(Nm, true, false, false);
            break;
        case '2':
            ShippedReportDetails(Nm, false, true, false);
            break;
        case '3':
            ShippedReportDetails(Nm, false, false, true)
            break;
        }
    }
</script>
<div align="right">
    <label><b>Show Shiping Reports:</b></label>
    <select id="ddlShippingReport">
        <option value="1">Show Year Report</option>
        <option value="2">Show Current Month Report</option>
        <option value="3">Show Today's Report</option>
    </select></div>
<div id="divShippiedReport">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblOrderHeading" runat="server" Text=" Shipped Reports"></asp:Label>
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
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Shipping Method Name:</label>
                                <input type="text" id="txtShippingMethodNm" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchShippingReport() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxShippingReportImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvShippedReportDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />