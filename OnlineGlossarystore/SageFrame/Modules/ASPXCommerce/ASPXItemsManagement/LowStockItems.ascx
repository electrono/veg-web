<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LowStockItems.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXItemsManagement_LowStockItems" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= username %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadLowStockItemStaticImage();
        BindLowStockItemsGrid(null, null, null);
        $("#btnExportToCSV").click(function() {
            $('#gdvLowStockItems').table2CSV();
        });
    });

    function LoadLowStockItemStaticImage() {
        $('#ajaxLowStockItemImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvLowStockItems thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvLowStockItems tbody tr");
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

    function SearchItems() {
        var sku = $.trim($("#txtSearchSKU").val());
        var Nm = $.trim($("#txtSearchName").val());
        if (sku.length < 1) {
            sku = null;
        }
        if (Nm.length < 1) {
            Nm = null;
        }
        var isAct = $.trim($("#ddlIsActive").val()) == "" ? null : ($.trim($("#ddlIsActive").val()) == "True" ? true : false);

        BindLowStockItemsGrid(sku, Nm, isAct);
    }

    function BindLowStockItemsGrid(sku, Nm, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvLowStockItems_pagesize").length > 0) ? $("#gdvLowStockItems_pagesize :selected").text() : 10;

        $("#gdvLowStockItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetLowStockItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHide', coltype: '', align: 'center', controlclass: '', hide: true },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'quantity', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Is Active', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { Sku: sku, name: Nm, isActive: isAct, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false } }
        });
    }
</script>

<div id="gdvLowStockItems_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Low Stock Items"></asp:Label>
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
                                    Name:</label>
                                <input type="text" id="txtSearchName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    SKU:</label>
                                <input type="text" id="txtSearchSKU" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    IsActive:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">True</option>
                                    <option value="False">False</option>
                                </select>
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
                    <img id="ajaxLowStockItemImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvLowStockItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />