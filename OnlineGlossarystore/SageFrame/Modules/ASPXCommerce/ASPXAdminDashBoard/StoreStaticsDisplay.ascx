<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StoreStaticsDisplay.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_StoreStaticsDisplay" %>

<script type="text/javascript">
    var storeId = '<%= StoreID %>';
    var portalId = '<%= PortalID %>';

    $(document).ready(function() {
        HideDiv();
        $("#ddlChartType").show();
        $("#lbla").show();
        BindChartByLastWeekAmount();
        BindChartByCurrentMonthAmount();
        BindChartByOneYearAmount();
        BindChartBy24hoursAmount();
        $(window).load(function() {
            ShowCharts();
        });
        $("#ddlChartType").change(function() {
            ShowCharts();
        });

        $("#ddlChartTypeLW").change(function() {
            ShowChartLW();
        });

        $("#ddlChartTypeCM").change(function() {
            ShowChartCM();
        });

        $("#ddlChartTypeYear").change(function() {
            ShowChartYear();
        });

        $("#ddlRange").change(function() {
            ShowChartRange();
        });
    });

    function HideDiv() {
        $("#divLW").hide();
        $("#div24hours").hide();
        $("#divCM").hide();
        $("#divYear").hide();
        $("#ddlChartType").hide();
        $("#lbla").hide();
        $("#ddlChartTypeLW").hide();
        $("#lblb").hide();
        $("#ddlChartTypeCM").hide();
        $("#lblc").hide();
        $("#ddlChartTypeYear").hide();
        $("#lbld").hide();
    }

    function RemoveCharts() {
        $('.visualize-bar').remove();
        $('.visualize-pie').remove();
        $('.visualize-line').remove();
    }

    function ShowCharts() {
        var optionChart = $("#ddlChartType").val();
        switch (optionChart) {
        case '1':
            RemoveCharts();
            $("#div24hours").visualize();
            break;
        case '2':
            RemoveCharts();
            $("#div24hours").visualize({ type: 'pie' });
            break;
        case '3':
            RemoveCharts();
            $("#div24hours").visualize({ type: 'line' });
            break;
        }
    }

    function ShowChartLW() {
        var optionChart = $("#ddlChartTypeLW").val();
        switch (optionChart) {
        case '1':
            RemoveCharts();
            $("#divLW").visualize();
            break;
        case '2':
            RemoveCharts();
            $("#divLW").visualize({ type: 'pie' });
            break;
        case '3':
            RemoveCharts();
            $("#divLW").visualize({ type: 'line' });
            break;
        }
    }

    function ShowChartCM() {
        var optionChart = $("#ddlChartTypeCM").val();
        switch (optionChart) {
        case '1':
            RemoveCharts();
            $("#divCM").visualize();
            break;
        case '2':
            RemoveCharts();
            $("#divCM").visualize({ type: 'pie' });
            break;
        case '3':
            RemoveCharts();
            $("#divCM").visualize({ type: 'line' });
            break;
        }
    }

    function ShowChartYear() {
        var optionChart = $("#ddlChartTypeYear").val();
        switch (optionChart) {
        case '1':
            RemoveCharts();
            $("#divYear").visualize();
            break;
        case '2':
            RemoveCharts();
            $("#divYear").visualize({ type: 'pie' });
            break;
        case '3':
            RemoveCharts();
            $("#divYear").visualize({ type: 'line' });
            break;
        }
    }

    function ShowChartRange() {
        var optionRange = $("#ddlRange").val();
        switch (optionRange) {
        case '24h':
            RemoveCharts();
            $('#a').show();
            $("#div24hours").visualize().hide();
            $("#b,#c,#d").hide();
            HideDiv();
            $("#ddlChartType").show();
            $("#lbla").show();
            break;
        case '7d':
            RemoveCharts();
            $('#b').show();
            $("#divLW").visualize().hide();
            $("#a,#c,#d").hide();
            HideDiv();
            $("#ddlChartTypeLW").show();
            $("#lblb").show();
            break;
        case '1m':
            RemoveCharts();
            $('#c').show();
            $("#divCM").visualize().hide();
            $("#a,#b,#d").hide();
            HideDiv();
            $("#ddlChartTypeCM").show();
            $("#lblc").show();
            break;
        case '1y':
            RemoveCharts();
            $('#d').show();
            $("#divYear").visualize().hide();
            $("#b,#c,#a").hide();
            HideDiv();
            $("#ddlChartTypeYear").show();
            $("#lbld").show();
            break;
        }
    }

    function BindChartByLastWeekAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetOrderChartDetailsByLastWeek",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var orderChart = '<table><thead><tr><td></td>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<th>" + item.Date + "</th></td>";
                    });
//                        orderChart += '</tr></thead><tbody><tr><th scope="row">Amount(A)</th>';
//                        $.each(msg.d, function(index, item) {
//                        orderChart += "<td>" + item.GrandTotal + "</td>";
//                        });
                    orderChart += '</tr><tr><th scope="row">Registered Customers(C)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.CustomerVisit + "</td>";
                    });
                    orderChart += '</tr><tr><th scope="row">Orders(O)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.Orders + "</td>";
                    });
                    orderChart += '</tr></tbody></table>';
                    $("#divLW").append(orderChart);
                }

            },
            error: function() {
                // alert("Error!");
                csscody.error('<h1>Error Message</h1><p>Failed to load Charts By Week.</p>');
            }
        });
    }

    function BindChartByCurrentMonthAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetOrderChartDetailsBycurentMonth",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var orderChart = '<table><thead><tr><td></td>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<th>" + item.Date + "Week</th></td>";
                    });
//                        orderChart += '</tr></thead><tbody><tr><th scope="row">Amount(A)</th>';
//                        $.each(msg.d, function(index, item) {
//                        orderChart += "<td>" + item.GrandTotal + "</td>";
//                        });
                    orderChart += '</tr><tr><th scope="row">Registered Customers(C)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.CustomerVisit + "</td>";
                    });
                    orderChart += '</tr><tr><th scope="row">Orders(O)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.Orders + "</td>";
                    });
                    orderChart += '</tr></tbody></table>';
                    $("#divCM").append(orderChart);
                }
            },
            error: function() {
                // alert("Error!");
                csscody.error('<h1>Error Message</h1><p>Failed to load Charts By Month.</p>');
            }
        });
    }

    function BindChartByOneYearAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetOrderChartDetailsByOneYear",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var orderChart = '<table><thead><tr><td></td>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<th>" + item.Date + "</th></td>";
                    });
//                        orderChart += '</tr></thead><tbody><tr><th scope="row">Amount(A)</th>';
//                        $.each(msg.d, function(index, item) {
//                        orderChart += "<td>" + item.GrandTotal.toFixed(2) + "</td>";
//                        });
                    orderChart += '</tr><tr><th scope="row">Registered Customers(C)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.CustomerVisit + "</td>";
                    });
                    orderChart += '</tr><tr><th scope="row">Orders(O)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.Orders + "</td>";
                    });
                    orderChart += '</tr></tbody></table>';
                    $("#divYear").append(orderChart);
                }
            },
            error: function() {
                //alert("Error!");
                csscody.error('<h1>Error Message</h1><p>Failed to load Charts By Year.</p>');
            }
        });
    }

    function BindChartBy24hoursAmount() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetOrderChartDetailsBy24hours",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var orderChart = '<table><thead><tr><td></td>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<th>" + item.Date + ":00</th></td>";
                    });
//                        orderChart += '</tr></thead><tbody><tr><th scope="row">Amount(A)</th>';
//                        $.each(msg.d, function(index, item) {
//                        orderChart += "<td>" + item.GrandTotal + "</td>";
//                        });
                    orderChart += '</tr><tr><th scope="row">Registered Customers(C)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.CustomerVisit + "</td>";
                    });
                    orderChart += '</tr><tr><th scope="row">Orders(O)</th>';
                    $.each(msg.d, function(index, item) {
                        orderChart += "<td>" + item.Orders + "</td>";
                    });
                    orderChart += '</tr></tbody></table>';
                    $("#div24hours").append(orderChart);
                }
            },
            error: function() {
                //alert("Error!");
                csscody.error('<h1>Error Message</h1><p>Failed to load Charts By Day.</p>');
            }
        });
    }
</script>

<div>
    <label>
        <b>Select Range:</b></label>
    <select id="ddlRange" class="cssClassDropDown">        
        <option value="24h" >Show Today's Report</option>
        <option value="7d">Last Week</option>
        <option value="1m">Current Month</option>
        <option value="1y">Year To Date</option>
    </select><br />
    <br />
</div>
<div id="a">
    <label id="lbla">
        <b>Select Chart Type:</b></label>
    <select id="ddlChartType" class="cssClassDropDown">        
        <option value="1" >Bar</option>
        <option value="2">Pie</option>
        <option value="3">Line</option>
    </select></div>
<div id="div24hours">
</div>
<div id="b">
    <label id="lblb">
        <b>Select Chart Type:</b></label>
    <select id="ddlChartTypeLW" class="cssClassDropDown">
        <option value="0">--Select Chart Type--</option>
        <option value="1">Bar</option>
        <option value="2">Pie</option>
        <option value="3">Line</option>
    </select>
    <div id="divLW">
    </div>
</div>
<div id="c">
    <label id="lblc">
        <b>Select Chart Type:</b></label>
    <select id="ddlChartTypeCM" class="cssClassDropDown">
        <option value="0">--Select Chart Type--</option>
        <option value="1">Bar</option>
        <option value="2">Pie</option>
        <option value="3">Line</option>
    </select>
    <div id="divCM">
    </div>
</div>
<div id="d">
    <label id="lbld">
        <b>Select Chart Type:</b></label>
    <select id="ddlChartTypeYear" class="cssClassDropDown">
        <option value="0">--Select Chart Type--</option>
        <option value="1">Bar</option>
        <option value="2">Pie</option>
        <option value="3">Line</option>
    </select>
    <div id="divYear">
    </div>
</div>