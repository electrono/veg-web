<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LatestSearchTerms.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXAdminDashBoard_LatestSearchTerms" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var latestSearchTermCount = 5;

    $(document).ready(function() {
        // GetTopSearchItems();
        GetLatestSearchTerms();
    });

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
                    headELements += '<tr class="cssClassHeading"><td class="cssClassNormalHeading">SearchTerm</td>';
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

<div id="divLatestSearch" class="cssClssRoundedBoxTable">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblInventoryDetail" CssClass="cssClassLabel" runat="server" Text="Latest Search "></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div id="divLatestSearchTerms">
            </div>
        </div>
    </div>
</div>