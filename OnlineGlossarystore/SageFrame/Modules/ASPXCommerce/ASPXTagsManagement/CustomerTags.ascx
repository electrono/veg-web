<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomerTags.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXTagsManagement_CustomerTags" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';

    $(document).ready(function() {
        LoadCustoerTagsStaticImage();
        BindCustomerTags();
        HideDiv();
        $("#divCustomerTagDetails").show();

        $("#btnExport").click(function() {
            $('#gdvCusomerTag').table2CSV();
        });

        $("#btnExportToCSV").click(function() {
            $('#grdShowTagsList').table2CSV();
        });

        $("#btnBack").click(function() {
            HideDiv();
            $("#divCustomerTagDetails").show();
        });
    });

    function LoadCustoerTagsStaticImage() {
        $('#ajaxCustomerImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxCustomerTagsImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDiv() {
        $("#divCustomerTagDetails").hide();
        $("#divShowCustomerTagList").hide();
    }

    function BindCustomerTags() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCusomerTag_pagesize").length > 0) ? $("#gdvCusomerTag_pagesize :selected").text() : 10;

        $("#gdvCusomerTag").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCustomerTagDetailsList',
            colModel: [
                { display: 'User Name', name: 'user_name', cssclass: '', coltype: 'label', align: 'left' },
                { display: 'Total Tags', name: 'total_tags', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'ShowTags', name: 'shoetags', enable: true, _event: 'click', trigger: '1', callMethod: 'ShowTagsList', arguments: '0' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 2: { sorter: false } }
        });
    }

    function ShowTagsList(tblID, argus) {
        switch (tblID) {
        case "gdvCusomerTag":
            $("#<%= lblShowHeading.ClientID %>").html("Tags Submitted By: '" + argus[3] + "'");
            BindShowCustomerTagList(argus[0]);
            HideDiv();
            $("#divShowCustomerTagList").show();
            break;
        }
    }

    function BindShowCustomerTagList(UserName) {
        //var UserName = argus[0];
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#grdShowTagsList_pagesize").length > 0) ? $("#grdShowTagsList_pagesize :selected").text() : 10;

        $("#grdShowTagsList").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'ShowCustomerTagList',
            colModel: [
                { display: 'ItemID', name: 'itemId', cssclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tag Name', name: 'tag_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'AddedOn', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', format: 'yyyy/MM/dd' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center', hide: true }
            ],

            buttons: [
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, userName: UserName },
            current: current_,
            pnew: offset_,
            sortcol: { 4: { sorter: false } }
        });
    }

    function ExportDataToExcel() {
        var headerArr = $("#gdvCusomerTag thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvCusomerTag tbody tr");
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
        $("input[id$='HdnValue']").val(table);
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#grdShowTagsList thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#grdShowTagsList tbody tr");
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
        $("input[id$='HdnGridData']").val(table);
    }
</script>

<div id="divCustomerTagDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTagHeading" runat="server" Text="Customers Tags"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportDataToExcel" runat="server" OnClick="Button1_Click" Text="Export to Excel"
                                    OnClientClick="ExportDataToExcel()" CssClass="cssClassButtonSubmit" />
                    </p>
                    <p>
                        <button type="button" id="btnExport">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <%--<div class="cssClassSearchPanel cssClassFormWrapper">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td><label class="cssClassLabel"> Cost Variant Name:</label>
                <input type="text" id="txtVariantName" class="cssClassTextBoxSmall" /></td>
              <td><div class="cssClassButtonWrapper cssClassPaddingNone">
                  <p>
                    <button type="button" onclick="SearchCostVariantName()"> <span><span>Search</span></span></button>
                  </p>
                </div></td>
            </tr>
          </table>
        </div>--%>
                <div class="loading">
                    <img id="ajaxCustomerTagsImage2" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCusomerTag" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divShowCustomerTagList">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblShowHeading" runat="server" Text=""></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportToExcel" runat="server" OnClick="Button2_Click" Text="Export to Excel"
                                    OnClientClick="ExportDivDataToExcel()" CssClass="cssClassButtonSubmit" />
                    </p>
                    <p>
                        <button type="button" id="btnExportToCSV">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnBack">
                            <span><span>Back</span></span>
                        </button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="loading">
                    <img id="ajaxCustomerImageLoad"/>
                </div>
                <div class="log">
                </div>
                <table id="grdShowTagsList" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<asp:HiddenField ID="HdnGridData" runat="server" />