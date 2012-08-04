<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LiveCart.ascx.cs" Inherits="Modules_ASPXShoppingCartManagement_LiveCart" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadLiveCartImageStaticImage();
        BindShoppingCartItems(null, null, null);
        $("#btnLiveCartExportToCSV").click(function() {
            $('#gdvShoppingCart').table2CSV();
        });
    });

    function LoadLiveCartImageStaticImage() {
        $('#ajaxLiveCartImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportLiveCartDataToExcel() {
        var headerArr = $("#gdvShoppingCart thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShoppingCart tbody tr");
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
        $("input[id$='hdnLiveCartValue']").val(table);
    }

    function BindShoppingCartItems(itemNm, userNM, qnty) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShoppingCart_pagesize").length > 0) ? $("#gdvShoppingCart_pagesize :selected").text() : 10;

        $("#gdvShoppingCart").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetShoppingCartItemsDetails',
            colModel: [
                { display: 'Cart ID', name: 'cart_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item ID', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Customer Name', name: 'item_Id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item Name', name: 'item_name', cssclass: 'cssClassLinkHeader', controlclass: 'cssClassGridLink', coltype: 'label', align: 'left' },
                { display: 'Quantity', name: 'quantity', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Weight', name: 'weight', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'SKU', name: 'SKU', cssclass: '', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { itemName: itemNm, quantity: qnty, storeID: storeId, portalID: portalId, userName: userNM, cultureName: cultureName, timeToAbandonCart: '<%= timeToAbandonCart %>' },
            current: current_,
            pnew: offset_,
            sortcol: { }
        });
    }

    function SearchLiveShoppingCart() {
        var itemNm = $.trim($("#txtSearchItemName").val());
        var userNM = $.trim($("#txtCustomerName").val());
        var qnty = $.trim($("#txtQuantity").val());
        if (itemNm.length < 1) {
            itemNm = null;
        }
        if (userNM.length < 1) {
            userNM = null;
        }
        if (qnty.length < 1) {
            qnty = null;
        }
        BindShoppingCartItems(itemNm, userNM, qnty);
    }
</script>

<div id="divShoppingCartItems">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCartItemGridHeading" runat="server" Text="Items In Cart"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnLiveCartExportToExcel" class="cssClassButtonSubmit" runat="server"
                                    OnClick="btnLiveCartExportToExcel_Click" Text="Export to Excel" OnClientClick="ExportLiveCartDataToExcel()" />
                    </p>
                    <p>
                        <button type="button" id="btnLiveCartExportToCSV">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <%--                    <p>
                        <button type="button" id="btnDeleteAllSearchTerm">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>--%>
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
                                    ItemName:</label>
                                <input type="text" id="txtSearchItemName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Customer Name</label>
                                <input type="text" id="txtCustomerName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Quantity:</label>
                                <input type="text" id="txtQuantity" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchLiveShoppingCart() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxLiveCartImage" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvShoppingCart" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="hdnLiveCartValue" runat="server" />