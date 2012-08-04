<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemsTags.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXTagsManagement_ASPXItemsTags" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';

    $(document).ready(function() {
        LoadIemsTagsStaticImage();
        BindItemTagsDetails();
        HideDiv();
        $("#divItemTagDetails").show();

        $("#btnExport").click(function() {
            $('#gdvItemTag').table2CSV();
        });

        $("#btnExportToCSV").click(function() {
            $('#gdvShowItemTagsList').table2CSV();
        });

        $("#btnBack").click(function() {
            HideDiv();
            $("#divItemTagDetails").show();
        });
    });

    function LoadIemsTagsStaticImage() {
        $('#ajaxItemTagsImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxItemTagsImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDiv() {
        $("#divItemTagDetails").hide();
        $("#divShowItemsTagsList").hide();
    }

    function BindItemTagsDetails() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvItemTag_pagesize").length > 0) ? $("#gdvItemTag_pagesize :selected").text() : 10;

        $("#gdvItemTag").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetItemTagDetailsList',
            colModel: [
                { display: 'Item ID', name: 'itemId', cssclass: 'cssClassHide', coltype: 'label', align: 'left', hide: true },
                { display: 'Item Name', name: 'item_name', cssclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Unique Tags', name: 'number_of_unique_tags', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Tags', name: 'number_of_tags', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'ShowTags', name: 'shoetags', enable: true, _event: 'click', trigger: '1', callMethod: 'ShowItemTagsList', arguments: '1,2,3' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 4: { sorter: false } }
        });
    }

    function ShowItemTagsList(tblID, argus) {
        switch (tblID) {
        case "gdvItemTag":
            $("#<%= lblShowHeading.ClientID %>").html("Tags Submitted To : '" + argus[3] + "'");
            BindItemsTagsList(argus[0]);
            HideDiv();
            $("#divShowItemsTagsList").show();
            break;
        }
    }

    function BindItemsTagsList(itemId) {
        //var itemId = argus[0];
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShowItemTagsList_pagesize").length > 0) ? $("#gdvShowItemTagsList_pagesize :selected").text() : 10;

        $("#gdvShowItemTagsList").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'ShowItemTagList',
            colModel: [
                { display: 'Tag Name', name: 'tag_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Tag Use', name: 'tag_use', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center', hide: true }
            ],

            buttons: [
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeId: storeId, portalId: portalId, itemID: itemId },
            current: current_,
            pnew: offset_,
            sortcol: { 1: { sorter: false } }
        });
    }

    function ExportDataToExcel() {
        var headerArr = $("#gdvItemTag thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvItemTag tbody tr");
        // var table = $("#Export1_lblTitle").text();
        var table = '<table>';
        table += header;
        $.each(data, function(index, item) {
            var cells = $(this).find("td");
            var td = "";
            $.each(cells, function(i, itm) {
                if ($(this).is(':visible')) {
                    if ($(this).find("div").hasClass("cssClassActionOnClick")) {
                        //do not add
                    } else {
                        td += '<td>' + $(this).text() + '</td>';
                    }
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
        var headerArr = $("#gdvShowItemTagsList thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShowItemTagsList tbody tr");
        // var table = $("#Export1_lblTitle").text();
        var table = '<table>';
        table += header;
        $.each(data, function(index, item) {
            var cells = $(this).find("td");
            var td = "";
            $.each(cells, function(i, itm) {
                if ($(this).is(':visible')) {
                    if ($(this).find("div").hasClass("cssClassActionOnClick")) {
                        //do not add
                    } else {
                        td += '<td>' + $(this).text() + '</td>';
                    }
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

<div id="divItemTagDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTagHeading" runat="server" Text="Items Tags"></asp:Label>
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
                    <img id="ajaxItemTagsImage2"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvItemTag" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divShowItemsTagsList">
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
                    <img id="ajaxItemTagsImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvShowItemTagsList" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<asp:HiddenField ID="HdnGridData" runat="server" />