<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PendingTags.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXTagsManagement_PendingTags" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var arrTagItems = new Array();
    var arrTagItemsToBind = new Array();

    $(document).ready(function() {
        HideAll();
        LoadPendingTagsStaticImage();
        $("#divShowTagDetails").show();
        BindTagDetails(null);
        GetStatusOfTag();
        $("#btnSaveTag").click(function() {
            var validTag = $("#form1").validate({
                messages: {
                    Tag: {
                        required: '*',
                        maxlength: "*"
                    }
                }
            });
            if (validTag.form()) {
                UpdateTags();
            } else return false;
        });

        $(".cssClassClose").click(function() {
            $('#fade, #popuprel2').fadeOut();
        });
        $("#btnCancel").click(function() {
            HideAll();
            $("#divShowTagDetails").show();
        });
        $('#btnApproveAllSelected').click(function() {
            var tags_ids = '';
            $("#gdvTags .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    tags_ids += $(this).val() + ',';
                }
            });
            if (tags_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ApproveAllSelectedTags(tags_ids, e);
                    }
                }
                csscody.confirm("<h1>Approve Confirmation</h1><p>Do you want to Approve Selected Tags?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one status before you can do this.<br/> To select one or more tags, just check the box before each Tags.</p>');
            }
        });
        $("#ddlTagItemDisplay").change(function() {
            var items_per_page = $(this).val();
            $("#Pagination").pagination(arrTagItems.length, {
                callback: pageselectCallback,
                items_per_page: items_per_page,
                //num_display_entries: 10,
                //current_page: 0,
                prev_text: "Prev",
                next_text: "Next",
                prev_show_always: false,
                next_show_always: false
            });
        });
    });

    function LoadPendingTagsStaticImage() {
        $('#ajaxPendingTagsImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ApproveAllSelectedTags(tagsIDs, event) {
        if (event) {
            var newTags = "";
            var newTagStatus = 3;
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateTag",
                data: JSON2.stringify({ ItemTagIDs: tagsIDs, newTag: newTags, StatusID: newTagStatus, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTagDetails(null);
                    HideAll();
                    $("#divShowTagDetails").show();
                }
            });
        }
        return false;
    }

    function UpdateTags(itemTagIDs) {
        var itemTagIDs = $("#hdnItemTagID").val();
        var hdnStatusID = $("#hdnStatusID").val();
        var hdnTag = $("#hdnTag").val();
        var newTag = $("#txtTag").val();
        var newStatusID = $("#selectStatus").val();
//        if (newTag == '') {
//            alert("Enter Tag Title");
//            return false;
//        }
        if (hdnStatusID != newStatusID || hdnTag != newTag) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateTag",
                data: JSON2.stringify({ ItemTagIDs: itemTagIDs, newTag: newTag, StatusID: newStatusID, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTagDetails(null);
                    HideAll();
                    $("#divShowTagDetails").show();
                }
            });
        } else {
            HideAll();
            $("#divShowTagDetails").show();
        }
    }

    function HideAll() {
        $("#divEditTag").hide();
        $("#divShowTagDetails").hide();
    }

    function clearTagForm() {

        $('#txtTag').removeClass('error');
        $('#txtTag').parents('td').find('label').remove();
    }

    function GetStatusOfTag() {
        var param = JSON2.stringify({ cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStatus",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindTagStatusDropDown(item);
                });
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function BindTagStatusDropDown(item) {
        $("#selectStatus").append("<option value=" + item.StatusID + ">" + item.Status + "</option>");
        $("#ddlStatus").append("<option value=" + item.StatusID + ">" + item.Status + "</option>");
    }

    function BindTagDetails(tags) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvTags_pagesize").length > 0) ? $("#gdvTags_pagesize :selected").text() : 10;

        $("#gdvTags").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetTagDetailsListPending',
            colModel: [
                { display: 'ItemTagIDs', name: 'itemtag_ids', cssclass: 'cssClassHeadCheckBox', controlclass: 'attribHeaderChkbox', coltype: 'checkbox', align: 'center', elemClass: 'attrChkbox', elemDefault: false },
                { display: 'Tag', name: 'tag', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'User Counts', name: 'user_count', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', showpopup: false },
                { display: 'Item Counts', name: 'item_count', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', showpopup: false },
                { display: 'Status', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'StatusID', name: 'status_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'UserIDs', name: 'user_ids', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'ItemIDs', name: 'item_ids', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Tag Count', name: 'tag_count', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                    //{ display: 'View', name: 'view_items', enable: true, _event: 'click', trigger: '3', callMethod: 'ShowTaggedItems', arguments: '7' },
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditTags', arguments: '0,1,5' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteTags', arguments: '0' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { tag: tags, storeId: storeId, portalId: portalId, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 9: { sorter: false } }
        });
    }

    function EditTags(tblID, argus) {
        switch (tblID) {
        case "gdvTags":
            $("#<%= lblEditTagDetails.ClientID %>").html("Edit Tag: '" + argus[4] + "'");
            HideAll();
            clearTagForm();
            $("#divEditTag").show();
            $("#hdnItemTagID").val(argus[3]);
            $("#hdnTag").val(argus[4]);
            $("#hdnStatusID").val(argus[5]);
            $("#txtTag").val(argus[4]);
            $("#selectStatus").val(argus[5]);
            break;
        default:
            break;
        }
    }

    function DeleteTags(tblID, argus) {
        switch (tblID) {
        case "gdvTags":
            var properties = {
                onComplete: function(e) {
                    ConfirmDeleteTag(argus[3], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this Tag?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteTag(itemTagIDs, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteTag",
                data: JSON2.stringify({ ItemTagIDs: itemTagIDs, storeID: storeId, portalID: portalId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindTagDetails(null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }

    function ShowTaggedItems(tblID, argus) {
        switch (tblID) {
        case "gdvTags":
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemsByMultipleItemID",
                data: JSON2.stringify({ ItemIDs: argus[3], storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    arrTagItems.length = 0;
                    var tagItems = '';
                    $.each(msg.d, function(index, value) {
                        arrTagItems.push(value);
                    });
                    var items_per_page = $('#ddlTagItemDisplay').val();
                    $("#Pagination").pagination(arrTagItems.length, {
                        callback: pageselectCallback,
                        items_per_page: items_per_page,
                        //num_display_entries: 10,
                        //current_page: 0,
                        prev_text: "Prev",
                        next_text: "Next",
                        prev_show_always: false,
                        next_show_always: false
                    });
                    ShowPopupControl('popuprel2');
                },
                error: function(msg) {
                    alert("error callin");
                }
            });
            break;
        }

    }

    function pageselectCallback(page_index, jq) {
        // Get number of elements per pagionation page from form
        var items_per_page = $('#ddlTagItemDisplay').val();


        var max_elem = Math.min((page_index + 1) * items_per_page, arrTagItems.length);
        var newcontent = '';
        arrTagItemsToBind.length = 0;

        // Iterate through a selection of the content and build an HTML string
        for (var i = page_index * items_per_page; i < max_elem; i++) {
            //newcontent += '<dt>' + arrItemListType[i]._Name + '</dt>';
            arrTagItemsToBind.push(arrTagItems[i]);
        }
        BindResults();


        // Replace old content with new content
        //$('#Searchresult').html(newcontent);

        // Prevent click event propagation
        return false;
    }

    function BindResults() {

        $("#divShowTagItemsResult").html('');
        $("#divShowTagItemsResult").html('<table><tbody><tr></tr></tbody></table>');
        $.each(arrTagItemsToBind, function(index, value) {
            if (value.ImagePath == "") {
                value.ImagePath = '<%= noImagePendingTagsPath %>';
            }
            if (value.AlternateText == "") {
                value.AlternateText = value.Name;
            }
            var tagItems = '';
            var isAppend = false;
            var isNewRow = false;
            var istrue = (index + 1) % 6;
            if (istrue != 0) {
                isAppend = true;
                tagItems += '<td>';
                tagItems += ' <div class="cssClassGrid3Box">';
                tagItems += '<div class="cssClassGrid3BoxInfo">';
                tagItems += '<h2><a href="' + aspxRedirectPath + 'item/' + value.SKU + '.aspx" target="blank">' + value.Name + '</a></h2>';
                tagItems += '<div class="cssClassGrid3Picture"><img height="81" width="123" src="' + aspxRootPath + value.ImagePath + '" alt="' + value.AlternateText + '" title="' + value.Name + '" /></div>';
                tagItems += '<div class="cssClassGrid3PriceBox">';
                tagItems += '<div class="cssClassGrid3PriceBox"><div class="cssClassGrid3Price">';
                tagItems += ' <p class="cssClassGrid3OffPrice">Price :<span class="cssClassGrid3RealPrice"> <span>' + value.Price + '</span></span> </p>';
                tagItems += '<div class="cssClassclear"></div></div></div></div>';
                tagItems += '</td>';
            } else {
                isNewRow = true;
                tagItems += '<tr>';
                tagItems += '<td>';
                tagItems += ' <div class="cssClassGrid3Box">';
                tagItems += '<div class="cssClassGrid3BoxInfo">';
                tagItems += '<h2><a href="' + aspxRedirectPath + 'item/' + value.SKU + '.aspx">' + value.Name + '</a></h2>';
                tagItems += '<div class="cssClassGrid3Picture"><img height="81" width="123" src="' + aspxRootPath + value.ImagePath + '" alt="' + value.AlternateText + '" title="' + value.Name + '" /></div>';
                tagItems += '<div class="cssClassGrid3PriceBox">';
                tagItems += '<div class="cssClassGrid3PriceBox"><div class="cssClassGrid3Price">';
                tagItems += ' <p class="cssClassGrid3OffPrice">Price :<span class="cssClassGrid3RealPrice"> <span>' + value.Price + '</span></span> </p>';
                tagItems += '<div class="cssClassclear"></div></div></div></div>';
                tagItems += '</td>';
                tagItems += '</tr>';
            }
            if (isAppend) {
                $("#divShowTagItemsResult").find('table>tbody tr:last').append(tagItems);
            }
            if (isNewRow) {
                $("#divShowTagItemsResult").find('table>tbody').append(tagItems);
            }
        });
    }

    function SearchTags() {
        var tags = $.trim($("#txtSearchTag").val());
        if (tags.length < 1) {
            tags = null;
        }
        BindTagDetails(tags);
    }
</script>

<div class="cssClassBodyContentWrapper" id="divShowTagDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Manage Pending Tags"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnApproveAllSelected">
                            <span><span>Approve All Selected</span></span></button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Tag:</label>
                                <input type="text" id="txtSearchTag" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchTags() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxPendingTagsImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvTags" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div class="cssClassBodyContentWrapper" id="divEditTag">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblEditTagDetails" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblTagTitle" runat="server" Text="Tag:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                        class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtTag" name="Tag" class="cssClassNormalTextBox required" maxlength="20" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblStatus" runat="server" Text="Status:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select id="selectStatus" class="cssClassDropDown">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button id="btnSaveTag" type="button">
                    <span><span>Save</span></span></button>
            </p>
            <p>
                <button id="btnCancel" type="button">
                    <span><span>Cancel</span></span></button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <input type="hidden" id="hdnItemTagID" />
    <input type="hidden" id="hdnTag" />
    <input type="hidden" id="hdnStatusID" />
</div>
<div id="popuprel2" class="popupbox">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <div id="divShowTagItemsResult">
    </div>
    <div class="cssClassClear">
    </div>
    <div class="cssClassPageNumber" id="divSearchPageNumber">
        <div class="cssClassPageNumberLeftBg">
            <div class="cssClassPageNumberRightBg">
                <div class="cssClassPageNumberMidBg">
                    <div id="Pagination">
                    </div>
                    <div class="cssClassViewPerPage">
                        View Per Page
                        <select id="ddlTagItemDisplay" class="cssClassDropDown">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="15">15</option>
                            <option value="20">20</option>
                            <option value="25">25</option>
                            <option value="40">40</option>
                        </select></div>
                </div>
            </div>
        </div>
    </div>
</div>