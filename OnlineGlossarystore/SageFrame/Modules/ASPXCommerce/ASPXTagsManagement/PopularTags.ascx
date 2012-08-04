<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopularTags.ascx.cs" Inherits="Modules_ASPXTagsManage_TagsManage" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';

    $(document).ready(function() {
        LoadPopularTagsStaticImage();
        BindPopulatTags();
        HideDiv();
        $("#divPopularTagDetails").show();

        $("#btnBack").click(function() {
            HideDiv();
            $("#divPopularTagDetails").show();
        });

        $("#btnExport").click(function() {
            $('#gdvPopularTag').table2CSV();
        });

        $("#btnExportToCSV").click(function() {
            $('#gdvShowPopulatTagsDetails').table2CSV();
        });
    });

    function LoadPopularTagsStaticImage() {
        $('#ajaxPopulartagsImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxPopularTagsImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDiv() {
        $("#divPopularTagDetails").hide();
        $("#divShowPopulartagsDetails").hide();
    }

    function BindPopulatTags() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvPopularTag_pagesize").length > 0) ? $("#gdvPopularTag_pagesize :selected").text() : 10;

        $("#gdvPopularTag").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetPopularTagDetailsList',
            colModel: [
                { display: 'Tag Name', name: 'tag_name', cssclass: '', coltype: 'label', align: 'left' },
                { display: 'Popularity', name: 'popularity', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'ShowDetails', name: 'showtags', enable: true, _event: 'click', trigger: '1', callMethod: 'ShowTagsDetails', arguments: '0' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 2: { sorter: false } }
        });
    }

    function ShowTagsDetails(tblID, argus) {
        switch (tblID) {
        case "gdvPopularTag":
            $("#<%= lblShowHeading.ClientID %>").html("Tag '" + argus[0] + "' Details");
            ShowPopularTagsList(argus[0]);
            HideDiv();
            $("#divShowPopulartagsDetails").show();
            break;
        }
    }

    function ShowPopularTagsList(tagName) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShowPopulatTagsDetails_pagesize").length > 0) ? $("#gdvShowPopulatTagsDetails_pagesize :selected").text() : 10;

        $("#gdvShowPopulatTagsDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'ShowPopularTagList',
            colModel: [
                { display: 'User Name', name: 'user_name', cssclass: '', coltype: 'label', align: 'left' },
                { display: 'Item ID', name: 'itemId', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center', hide: true }
            ],

            buttons: [
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, tagName: tagName },
            current: current_,
            pnew: offset_,
            sortcol: { 3: { sorter: false } }
        });
    }

    function ExportDataToExcel() {
        var headerArr = $("#gdvPopularTag thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvPopularTag tbody tr");
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
        var headerArr = $("#gdvShowPopulatTagsDetails thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShowPopulatTagsDetails tbody tr");
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

<div id="divPopularTagDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTagHeading" runat="server" Text="Popular Tags"></asp:Label>
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
                <div class="loading">
                    <img id="ajaxPopularTagsImage2" />
                </div>
                <div class="log">
                </div>
                <table id="gdvPopularTag" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divShowPopulartagsDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblShowHeading" runat="server" Text=""></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportToExcel" runat="server" OnClick="Button2_Click" Text="Export to Excel"
                                    OnClientClick="ExportDivDataToExcel()" CssClass=" cssClassButtonSubmit" />
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
                    <img id="ajaxPopulartagsImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvShowPopulatTagsDetails" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<asp:HiddenField ID="HdnGridData" runat="server" />