<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TickerView.ascx.cs" Inherits="Modules_Ticker_TickerView" %>

<script type="text/javascript">
    //<![CDATA[
    var PortalId = '<%= PortalId %>';
    var StoreId = '<%= StoreId %>';
    $(document).ready(function() {
        $.ajax({
            type: "POST",
            url: TickerModulePath + "Services/TickerWebService.asmx/GetAllTickerItem",
            data: JSON2.stringify({ StoreID: StoreId, PortalID: PortalId }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                var TickerItem = "";
                $.each(msg.d, function(index, Data) {
                    TickerItem += '<li>' + Data.TickerNews + '</li>';

                });
                $('#js-news').html(TickerItem);

                //$().ready(function() {
                $(".liScrollExample").liScroll({
                    showControls: true,
                    travelocity: 0.03
                // });
                });
            }
        });
    });
//]]>
</script>

<div class="liScrollExample" id="ticker-wrapper">
    <ul id="js-news">
    </ul>
</div>