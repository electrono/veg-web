<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SearchTermManage.ascx.cs"
            Inherits="Modules_ASPXSearchTerm_SearchTermManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadSearchTermStaticImage();
        GetSearchTermDetails(null);
        $("#btnDeleteAllSearchTerm").click(function() {
            var searchTermIds = '';
            $(".searchTermCheckbox").each(function() {
                if ($(this).attr("checked")) {
                    searchTermIds += $(this).val() + ',';
                }
            });
            if (searchTermIds == "") {
                csscody.alert('<h2>Information Alert</h2><p>None of the data are selected</p>');
                return false;
            }
            var properties = {
                onComplete: function(e) {
                    DeleteSearchTerm(searchTermIds, e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);

        });
        $("#btnExportToCSV").click(function() {
            $('#gdvSearchTerm').table2CSV();
        });
    });

    function LoadSearchTermStaticImage() {
        $('#ajaxSearchTermImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvSearchTerm thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvSearchTerm tbody tr");
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

    function GetSearchTermDetails(searchTerm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvSearchTerm_pagesize").length > 0) ? $("#gdvSearchTerm_pagesize :selected").text() : 10;

        $("#gdvSearchTerm").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'ManageSearchTerms',
            colModel: [
                { display: 'SearchTermID', name: 'search_term_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'searchTermCheckbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Search Term', name: 'search_term', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'No Of Use', name: 'no_of_use', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
            // { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditSearchTerms',arguments: '2,3,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteSearchTerms', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, cultureName: cultureName, searchTerm: searchTerm },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 3: { sorter: false } }
        });
    }

    function DeleteSearchTerms(tblID, argus) {
        switch (tblID) {
        case "gdvSearchTerm":
            var properties = {
                onComplete: function(e) {
                    DeleteSearchTerm(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteSearchTerm(Ids, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteSearchTerm",
                data: JSON2.stringify({ searchTermID: Ids, storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function() {
                    GetSearchTermDetails(null);
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to Delete!!</p>');
                }
            });
        }
        return false;
    }

    function SearchTerm() {
        var search = $.trim($("#txtSearchTerm").val());
        if (search.length < 1) {
            search = null;
        }
        GetSearchTermDetails(search);
    }
</script>

<div id="divShowSearchTermDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Search Term Manage"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteAllSearchTerm">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <asp:Button ID="btnExportToExcel" class="cssClassButtonSubmit" runat="server" OnClick="Button1_Click"
                                    Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
                    </p>
                    <p>
                        <button type="button" id="btnExportToCSV">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Search Term:</label>
                                <input type="text" id="txtSearchTerm" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchTerm() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxSearchTermImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvSearchTerm" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />