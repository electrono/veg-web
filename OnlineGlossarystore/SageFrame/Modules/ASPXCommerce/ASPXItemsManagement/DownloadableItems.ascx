<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DownloadableItems.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXItemsManagement_DownloadableItems" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadDownloadableItemStaticImage();
        BindDownLoadableItemsGrid(null, null);
        $("#btnExportToCSV").click(function() {
            $('#gdvDownLoadableItems').table2CSV();
        });

        $('.cssClassDownload').jDownload({
            root: '<%= aspxfilePath %>',
            dialogTitle: 'ASPXCommerce Download Sample Item:'
        });
    });

    function LoadDownloadableItemStaticImage() {
        $('#ajaxDownloadableItemImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvDownLoadableItems thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvDownLoadableItems tbody tr");
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

        BindDownLoadableItemsGrid(sku, Nm);
    }

    function BindDownLoadableItemsGrid(sku, Nm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvDownLoadableItems_pagesize").length > 0) ? $("#gdvDownLoadableItems_pagesize :selected").text() : 10;

        $("#gdvDownLoadableItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetDownLoadableItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'itemsChkbox', elemDefault: false, controlclass: 'classClassCheckBox', hide: true },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Sample Link', name: 'sample_link', cssclass: '', controlclass: 'cssClassDownload', coltype: 'linklabel', align: 'left', value: '5', downloadarguments: '', downloadmethod: '' },
                { display: 'Actual Link', name: 'actual_link', cssclass: '', controlclass: 'cssClassDownload', coltype: 'linklabel', align: 'left', value: '6', downloadarguments: '', downloadmethod: '' },
                { display: 'Sample File', name: 'sample_file', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actual File', name: 'actual_file', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Purchases', name: 'purchase', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Downloads', name: 'download', cssclass: '', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { Sku: sku, name: Nm, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName, CheckUser: false },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false } }
        });
    }
</script>

<div id="gdvDownLoadableItems_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="DownLoadable Items"></asp:Label>
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
                    <img id="ajaxDownloadableItemImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvDownLoadableItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />