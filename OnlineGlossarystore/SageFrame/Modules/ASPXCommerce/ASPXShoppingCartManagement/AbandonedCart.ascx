<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AbandonedCart.ascx.cs"
            Inherits="Modules_ASPXShoppingCartManagement_AbandonedCart" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadAbandonAndLiveStaticImage();
        BindAbandonedCart(null);
        $("#btnAbandonedCartExportToCSV").click(function() {
            $('#gdvAbandonedCart').table2CSV();
        });
    });

    function LoadAbandonAndLiveStaticImage() {
        $('#ajaxAbandonAndliveImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function BindAbandonedCart(CstNm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAbandonedCart_pagesize").length > 0) ? $("#gdvAbandonedCart_pagesize :selected").text() : 10;

        $("#gdvAbandonedCart").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAbandonedCartDetails',
            colModel: [
                { display: 'Customer Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Items', name: 'number_OfItems', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity Of Items', name: 'quantity_OfItems', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SubTotal', name: 'subTotal', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center', hide: true }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, userName: CstNm, cultureName: cultureName, timeToAbandonCart: '<%= timeToAbandonCart %>' },
            current: current_,
            pnew: offset_,
            sortcol: { 4: { sorter: false } }
        });
    }

    function ExportAbandonedCartDataToExcel() {
        var headerArr = $("#gdvAbandonedCart thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvAbandonedCart tbody tr");
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
        $("input[id$='hdnAbandonedCartValue']").val(table);
    }

    function SearchAbandonedShoppingCart() {
        var CstNm = $.trim($("#txtAbdCustomerName").val());
        if (CstNm.length < 1) {
            CstNm = null;
        }
        BindAbandonedCart(CstNm);
    }
</script>

<div class="cssClassBodyContentWrapper" id="divShoppingCartItems">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrGridHeading" runat="server" Text="Abandoned Cart"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <%--     <p>
                        <button type="button" id="btnDeleteShoppingCart">
                            <span><span>Delete All Selected</span></span></button>
                    </p>--%>
                    <p>
                        <asp:Button ID="btnAbandonedCartExportToExcel" runat="server" OnClick="btnAbandonedCartExportToExcel_Click"
                                    Text="Export to Excel" OnClientClick="ExportAbandonedCartDataToExcel()" CssClass="cssClassButtonSubmit" />
                    </p>
                    <p>
                        <button type="button" id="btnAbandonedCartExportToCSV">
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
                                    Customer Name</label>
                                <input type="text" id="txtAbdCustomerName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchAbandonedShoppingCart() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxAbandonAndliveImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvAbandonedCart" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="hdnAbandonedCartValue" runat="server" />