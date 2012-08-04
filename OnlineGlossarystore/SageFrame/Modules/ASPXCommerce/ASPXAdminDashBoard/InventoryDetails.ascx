<%@ Control Language="C#" AutoEventWireup="true" CodeFile="InventoryDetails.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_InventoryDetails" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var lowStock = '<%= lowStockQuantity %>';

    $(document).ready(function() {
        GetInventoryDetails();
    })

    function GetInventoryDetails() {
        functionName = 'GetInventoryDetails';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: JSON2.stringify({ count: lowStock, storeID: storeId, portalID: portalId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        $('#lblItemtotal').html(item.TotalItem);
                        $('#lblAvtive').html(item.Active);
                        $('#lblHidden').html(item.Hidden);
                        $('#lblDownloadable').html(item.DItemscountNo);
                        $('#lblSpecial').html(item.SItemsCountNo);
                        $('#lblLowstock').html(item.LowStockItemCount);
                    });
                } else {
                    $('#lblItemtotal').html('0');
                    $('#lblAvtive').html('0');
                    $('#lblHidden').html('0');
                    $('#lblDownloadable').html('0');
                    $('#lblSpecial').html('0');
                    $('#lblLowstock').html('0');
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Inventory Deatils.</p>');
            }
        });
    }
</script>

<div id="divInventoryDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" runat="server" Text="Inventory "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div class="classTableWrapper">
                <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblInventoryDetail">
                    <tr>
                        <td class="cssClassTableLeftCol">
                            <asp:Label ID="lblTotalItem" runat="server" CssClass="cssClassLabel" Text="Total Items: "></asp:Label><label
                                                                                                                                      id="lblItemtotal"></label>
                        </td>
                        <td>
                            <asp:Label ID="lblActiveItem" runat="server" CssClass="cssClassLabel" Text="Active Items: "></asp:Label><label
                                                                                                                                        id="lblAvtive"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="cssClassTableLeftCol">
                            <asp:Label ID="lblHiddenItem" runat="server" CssClass="cssClassLabel" Text="Hidden Items: "></asp:Label><label
                                                                                                                                        id="lblHidden"></label>
                        </td>
                        <td>
                        </td>
                    </tr>
                    <tr>
                        <td class="cssClassTableLeftCol">
                            <asp:Label ID="lblDownloadableItems" runat="server" CssClass="cssClassLabel" Text="Downloadable Items: "></asp:Label><label
                                                                                                                                                     id="lblDownloadable"></label>
                        </td>
                        <td>
                            <asp:Label ID="lblSpecialItems" runat="server" CssClass="cssClassLabel" Text="Special Items: "></asp:Label><label
                                                                                                                                           id="lblSpecial"></label>
                        </td>
                    </tr>
                    <tr>
                        <td class="cssClassTableLeftCol">
                            <asp:Label ID="lblLowStockItem" runat="server" CssClass="cssClassLabel" Text="LowStock Items: "></asp:Label><label
                                                                                                                                            id="lblLowstock"></label>
                        </td>
                        <td>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>