<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShoppingOptions.ascx.cs"
            Inherits="Modules_ASPXShoppingOptions_ShoppingOptions" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var upperLimit = '<%= shoppingOptionRange %>';

    $(document).ready(function() {
        GetShoppingOptionsByPrice();
    });

    function GetShoppingOptionsByPrice() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName, upperLimit: upperLimit });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/ShoppingOptionsByPrice",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $("#tblShoppingOptionsByPrice>tbody").html('');
                    $("#<%= lblPriceTitle.ClientID %>").show();
                    $.each(msg.d, function(index, item) {
                        BindShoppingOptionsByPrice(item, index);
                    });
                } else {
                    $("#<%= lblPriceTitle.ClientID %>").hide();
                    $("#tblShoppingOptionsByPrice>tbody").html("<span class=\"cssClassNotFound\">No Data Found.</span>");
                }
            }
//            ,
//            error: function() {
//                alert("Error!");
//            }
        });
    }

    function BindShoppingOptionsByPrice(response, index) {
        // alert(response.ItemIDs);
        var PriceOptions = '';
        if (index % 2 == 0) {
            PriceOptions = '<tr class="cssClassAlternativeEven"><td><a href="' + aspxRedirectPath + 'option/results.aspx?id=' + response.ItemIDs + '" >' + response.Option + ' (' + response.Count + ')</a></td></tr>';
        } else {
            PriceOptions = '<tr class="cssClassAlternativeOdd"><td><a href="' + aspxRedirectPath + 'option/results.aspx?id=' + response.ItemIDs + '" >' + response.Option + ' (' + response.Count + ')</a></td></tr>';
        }
        $("#tblShoppingOptionsByPrice>tbody").append(PriceOptions);
    }
</script>

<div class="cssClassCommonSideBox">
    <h2>
        <asp:Label ID="lblShoppingTitle" runat="server" Text="Shopping Options" CssClass="cssClassShoppingOptions"></asp:Label></h2>
    <h3>
        <asp:Label ID="lblPriceTitle" runat="server" Text="By Price" CssClass="cssClassShoppingOptionByPrice"></asp:Label></h3>
    <div class="cssClassCommonSideBoxTable">
        <table id="tblShoppingOptionsByPrice" width="100%" border="0" cellspacing="0" cellpadding="0">
            <tbody>
            </tbody>
        </table>
    </div>
</div>