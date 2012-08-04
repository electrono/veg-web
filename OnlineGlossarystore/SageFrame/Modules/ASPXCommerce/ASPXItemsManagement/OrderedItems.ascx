﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrderedItems.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXItemsManagement_OrderedItems" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= username %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadOrderedItemStaticImage();
        BindOrderedItemsGrid(null);
        $("#btnExportToCSV").click(function() {
            $('#gdvOrderedItems').table2CSV();
        });
    });

    function LoadOrderedItemStaticImage() {
        $('#ajaxOrderedItemImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvOrderedItems thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvOrderedItems tbody tr");
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
        var Nm = $.trim($("#txtSearchName").val());
        if (Nm.length < 1) {
            Nm = null;
        }
        BindOrderedItemsGrid(Nm);
    }

    function BindOrderedItemsGrid(Nm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvOrderedItems_pagesize").length > 0) ? $("#gdvOrderedItems_pagesize :selected").text() : 10;

        $("#gdvOrderedItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetOrderedItemsList',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Quantity Ordered', name: 'quantityordered', cssclass: '', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { name: Nm, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false } }
        });
    }
</script>

<div id="gdvOrderedItems_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Items Ordered"></asp:Label>
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
                    <img id="ajaxOrderedItemImage" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvOrderedItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />