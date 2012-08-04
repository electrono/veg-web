<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Currencyconversion.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCurrencyConverter_Currencyconversion" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var cultureName = '<%= cultureName %>';
    var BaseCurrency = '<%= MainCurrency %>';
    var SelectedCurrency = '<%= MainCurrency %>';
    var region = cultureName;

    var rate = 1;

    $(document).ready(function() {
        if ($.session("Rate")) {
            rate = $.session("Rate");
            region = $.session("Region"); //$('select.makeMeFancy').find(":selected").text()
            SelectedCurrency = $.session("SelectedCurrency");
        }
        bindCurrencyList();
        $('#ddlCurrency').change(function() {
            if ($("#ddlCurrency").val() == BaseCurrency) {
                rate = 1;
                region = $("#ddlCurrency option:selected").attr("region");
                SelectedCurrency = $("#ddlCurrency option:selected").val();
            } else {
                GetRate();
                region = $("#ddlCurrency option:selected").attr("region");
                SelectedCurrency = $("#ddlCurrency option:selected").val();
            }
            $.session("Region", region);
            $.session("Rate", rate);
            $.session("SelectedCurrency", SelectedCurrency);
            if ($("#divLatestItems").length) {
                BindRecentItems();
            }
//            if ($("#divItemDetails").length) {
//                BindItemBasicByitemSKU(itemSKU);
//                //BindItemQuantityDiscountByUserName(itemSKU);
//            }
        });
    });

    function GetRate() {
        var checkparam = { from: BaseCurrency, to: $("#ddlCurrency").val() };
        var checkdata = JSON2.stringify(checkparam);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCurrencyRate",
            data: checkdata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                if (msg.d) {
                    rate = msg.d;
                }
            }
        });
    }

    function bindCurrencyList() {
        var param = { StoreID: storeId, PortalID: portalId, CultureName: cultureName };
        var checkdata = JSON2.stringify(param);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCurrencyList",
            data: checkdata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var options = "";
                    $.each(msg.d, function(index, item) {
                        if (item.CurrencyCode == SelectedCurrency) {
                            options += '<option selected="selected" data-icon="' + aspxRootPath + 'images/flags/' + item.BaseImage + '"  data-html-text="' + item.CurrencyName + '-' + item.CurrencyCode + '" region="' + item.Region + '"  value="' + item.CurrencyCode + '" >' + item.CurrencyName + '-' + item.CurrencyCode + '</option>';
                        } else {
                            options += '<option data-icon="' + aspxRootPath + 'images/flags/' + item.BaseImage + '"  data-html-text="' + item.CurrencyName + '-' + item.CurrencyCode + '" region="' + item.Region + '"  value="' + item.CurrencyCode + '" >' + item.CurrencyName + '-' + item.CurrencyCode + '</option>';
                        }
                    });
                    $("#ddlCurrency").html(options);
                    MakeFancyDropDown();
                }
            }
        });
    }

</script>

<div class="cssClassCurrencySelect">
    Select Currency:<select id="ddlCurrency" class="makeMeFancy">
                    </select>
</div>