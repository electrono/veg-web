<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TopSearchTerms.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_TopSearchTerms" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var topSearchTermcount = 5;
    var latestSearchTermCount = 5;

    $(document).ready(function() {
        SetFirstTabActive();
        GetTopSearchItems();
        GetLatestSearchTerms();
        //GetLatestSearchTerms();
    });

    function SetFirstTabActive() {
        var $tabs = $('#container-8').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function GetTopSearchItems() {
        var commandName = "TOP";
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSearchStatistics",
            data: JSON2.stringify({ count: topSearchTermcount, commandName: commandName, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading" > Top Search Term</td>';
                    headELements += '<td  class="cssClassNormalHeading">No Of Use</td>';
                    headELements += '</tr></tbody></table>';
                    $("#divTopSearchTerms").html(headELements);
                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr><td><label class="cssClassLabel">' + value.SearchTerm + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.Count + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divTopSearchTerms").find('table>tbody').append(bodyElements);

                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divTopSearchTerms").html("<span class=\"cssClassNotFound\">No thing is searched recently!</span>");
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load Top Search Terms.</p>');
            }
        });
    }

    function GetLatestSearchTerms() {
        var commandName = "LATEST";
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSearchStatistics",
            data: JSON2.stringify({ count: latestSearchTermCount, commandName: commandName, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var bodyElements = '';
                    var headELements = '';
                    headELements += '<table class="classTableWrapper"  width="100%" border="0" cellspacing="0" cellpadding="0"><tbody>';
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading">Latest Search Term</td>';
                    headELements += '<td class="cssClassNormalHeading">No Of Use</td>';
                    headELements += '</tr></tbody></table>';

                    $("#divLatestSearchTerms").html(headELements);
                    $.each(msg.d, function(index, value) {
                        bodyElements += '<tr><td><label class="cssClassLabel">' + value.SearchTerm + '</label></td>';
                        bodyElements += '<td><label class="cssClassLabel">' + value.Count + '</label>';
                        bodyElements += '</tr>';
                    });
                    $("#divLatestSearchTerms").find('table>tbody').append(bodyElements);

                    $(".classTableWrapper > tbody tr:even").addClass("cssClassAlternativeEven");
                    $(".classTableWrapper > tbody tr:odd").addClass("cssClassAlternativeOdd");
                } else {
                    $("#divLatestSearchTerms").html("<span class=\"cssClassNotFound\">No thing is searched recently!</span>");
                }
            },
            error: function() {
                alert("error");
            }
        });
    }
</script>



<div class="cssClassTabPanelTable">
    <div id="container-8">
        <ul>
            <li><a href="#fragment-1">
                    <asp:Label ID="lblTabTopSearch" runat="server" Text="Top Search "></asp:Label>
                </a></li>
            <li><a href="#fragment-2">
                    <asp:Label ID="lblTabLatestSearch" runat="server" Text="Latest Search"></asp:Label>
                </a></li>
        </ul>
        <div id="fragment-1">
            <div class="cssClassFormWrapper">
                <div id="divTopSearchTerms">
                </div>
            </div>
        </div>
        <div id="fragment-2">
            <div class="cssClassFormWrapper">
                <div id="divLatestSearchTerms">
                </div>
            </div>
        </div>
    </div>
</div>