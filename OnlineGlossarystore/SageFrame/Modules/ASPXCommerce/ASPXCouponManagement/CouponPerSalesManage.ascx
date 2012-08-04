<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CouponPerSalesManage.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCouponManagement_CouponItemsManage" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        BindAllCouponPerSalesList(null);
        LoadCouponPerSalesStaticImage();
        $("#btnExportToCSV").click(function() {
            $('#gdvCouponPerSales').table2CSV();
        });
    });

    function LoadCouponPerSalesStaticImage() {
        $('#ajaxCouponPerSalesImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function BindAllCouponPerSalesList(SearchCouponCode) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCouponPerSales_pagesize").length > 0) ? $("#gdvCouponPerSales_pagesize :selected").text() : 10;

        $("#gdvCouponPerSales").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCouponDetailsPerSales',
            colModel: [
                { display: 'Coupon Code', name: 'coupon_code', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Uses', name: 'number_of_uses', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Total Discount Amount Gain by Coupon', name: 'discount_amount', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Total Sales Amount', name: 'sales_amount', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' }
            ],

            rp: perpage,
            nomsg: "No Records Found!",
            param: { couponCode: SearchCouponCode, storeID: storeId, portalID: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 3: { sorter: false } }
        });
    }

    function SearchItems() {
        var coupName = $.trim($("#txtSearchNameCoupon").val());

        if (coupName.length < 1) {
            coupName = null;
        }
        BindAllCouponPerSalesList(coupName);
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvCouponPerSales thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvCouponPerSales tbody tr");
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

<div id="gdvCouponPerSales_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Details of Coupon used"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportDataToExcel" CssClass="cssClassButtonSubmit" runat="server"
                                    OnClick="btnExportDataToExcel_Click" Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
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
        <div class="cssClassClear">
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    CouponCode:</label>
                                <input type="text" id="txtSearchNameCoupon" class="cssClassTextBoxSmall" />
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
                    <img id="ajaxCouponPerSalesImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCouponPerSales" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />