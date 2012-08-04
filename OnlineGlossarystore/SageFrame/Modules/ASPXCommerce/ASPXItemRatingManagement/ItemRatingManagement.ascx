<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemRatingManagement.ascx.cs"
            Inherits="Modules_ASPXItemRatingManagement_ItemRatingManagement" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userIP = '<%= userIP %>';
    var countryName = '<%= countryName %>';

    var ratingValues = '';
    var editVal = false;

    $(document).ready(function() {
        LoadItemRatingStaticImage();
        BindAllReviewsAndRatingsGrid(null, null, null);
        ShowGridTable();
        GetStatusList();
        GetAllItemsList();
        BindRatingCriteria();
        BindUserList();
        editVal = false;

        $('#btnDeleteSelected').click(function() {
            var itemReview_ids = '';
            //Get the multiple Ids of the item selected
            $(".itemRatingChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    itemReview_ids += $(this).val() + ',';
                }
            });
            if (itemReview_ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleItemRating(itemReview_ids, e);
                        // alert(itemReview_ids);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        })

        $("#btnReviewBack").click(function() {
            ShowGridTable();
        })

        $("#btnDeleteReview").click(function() {
            var review_id = $(this).attr("name");
            var properties = {
                onComplete: function(e) {
                    if (e) {
                        ConfirmSingleDeleteItemReview(review_id, e);
                    } else {
                        return false;
                    }
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item rating and review?</p>", properties);
        });

        var v = $("#form1").validate({
            rules: {
                name: "required",
                summary: "required",
                review: "required"
            },
            messages: {
                name: "at least 2 chars",
                summary: "at least 2 chars",
                review: "*"
            }
        });
        $("#btnSubmitReview").click(function() {
            if (editVal == false) {
                if ($('#selectItemList option:selected').val() != 0) {
                    if (v.form()) {
                        SaveItemRatings();
                        return false;
                    } else {
                        return false;
                    }
                } else {
                    $('#selectItemList').attr('class', 'cssClassDropDown error');
                    return false;
                }
            } else {
                SaveItemRatings();
            }
        });

        $("#btnReset").click(function() {
            ClearReviewForm();
        });

        $("#btnAddNewReview").click(function() {
            editVal = false;
            BindStarRatingsDetails();
            ClearReviewForm();
            HideAll();
            $("#<%= lblReviewsFromHeading.ClientID %>").html("Add New Rating & Review");
            $("#trUserList").show();
            $("#lnkItemName").hide();
            $("#selectItemList").show();
            $("#trPostedBy").hide();
            $("#trViewedIP").hide();
            $("#trSummaryRating").hide();
            $("#trAddedOn").hide();
            $('#selectStatus').val('2');
            $("#btnDeleteReview").attr("name", 0);
            $("#btnReset").show();
            $("#btnDeleteReview").hide();
            $("#divItemRatingForm").show();
            $("#ddlItemName>option").remove();
            $('#selectItemList').val(1);
        });

        $("#selectItemList").change(function() {
            $("#lnkItemName").attr("name", $(this).val());
            $('#selectItemList').removeClass('error');
        });
    });

    function LoadItemRatingStaticImage() {
        $('#ajaxItemRatingMgmtImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ShowGridTable() {
        HideAll();
        $("#divShowItemRatingDetails").show();
    }

    function BindUserList() {
        var IsAll = true;
        var param = JSON2.stringify({ portalID: portalId });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetUserList",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindUsersList(item);
                });
            }
        });
    }

    function BindUsersList(item) {
        $("#selectUserName").append("<option value=" + item.UserId + ">" + item.UserName + "</option>");
    }

    function BindAllReviewsAndRatingsGrid(searchUserName, status, SearchItemName) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvReviewsNRatings_pagesize").length > 0) ? $("#gdvReviewsNRatings_pagesize :selected").text() : 10;

        $("#gdvReviewsNRatings").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllUserReviewsAndRatings',
            colModel: [
                { display: 'ItemReviewID', name: 'itemreview_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'itemRatingChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Nick Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Total Rating Average', name: 'total_rating_average', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'View From IP', name: 'view_from_IP', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Review Summary', name: 'review_summary', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Review', name: 'review', cssclass: 'cssClassHeadCheckBox', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status ID', name: 'status_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item SKU', name: 'item_SKU', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditUserReviewsAndRatings', arguments: '1,2,3,4,5,6,7,8,9,10,11,12' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteUserReviewsAndRatings', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { userName: searchUserName, statusName: status, itemName: SearchItemName, storeID: storeId, portalID: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 13: { sorter: false } }
        });
    }

    function EditUserReviewsAndRatings(tblID, argus) {
        switch (tblID) {
        case "gdvReviewsNRatings":
            editVal = true;
            ClearReviewForm();
            BindItemReviewDetails(argus);
            BindRatingSummary(argus[0]);
            HideAll();
            $("#divItemRatingForm").show();
            $("#hdnItemReview").val(argus[0]);
            $("#trUserList").hide();
            break;
        default:
            break;
        }
    }

    function BindItemReviewDetails(argus) {
        $("#btnDeleteReview").attr("name", argus[0]);
        $("#<%= lblReviewsFromHeading.ClientID %>").html("Edit this item's Rating & Review");
        $("#lnkItemName").html(argus[10]);
        $("#lnkItemName").attr("href", aspxRedirectPath + "item/" + argus[14] + ".aspx");
        $("#lnkItemName").attr("name", argus[3]);
        $("#lblPostedBy").html(argus[12]);
        $("#lblViewFromIP").html(argus[6]);
        $("#txtNickName").val(argus[4]);
        $("#lblAddedOn").html(argus[11]);
        $("#txtSummaryReview").val(argus[7]);
        $("#txtReview").val(argus[8]);
        $("#selectStatus").val(argus[13]);
        $("#lnkItemName").show();
        $("#selectItemList").hide();
        $("#trPostedBy").show();
        $("#trViewedIP").show();
        $("#trSummaryRating").show();
        $("#trAddedOn").show();
        $("#btnReset").hide();
        $("#btnDeleteReview").show();
    }

    function BindRatingSummary(review_id) {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingByReviewID",
            data: JSON2.stringify({ itemReviewID: review_id, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblRatingCriteria label.error").hide();
                var itemAvgRating = '';
                $.each(msg.d, function(index, item) {
                    if (index == 0) {
                        BindStarRatingsDetails();
                        BindStarRatingAverage(item.RatingAverage);
                        itemRatingAverage = item.RatingAverage;
                    }
                    itemAvgRating = JSON2.stringify(item.RatingValue);
                    $('input.item-rating-crieteria' + item.ItemRatingCriteriaID).rating('select', itemAvgRating);
                });
                $.metadata.setType("class");
                $('input.auto-star-avg').rating();
            },
            error: function() {
                alert("error");
            }
        });
    }

    function BindStarRatingsDetails() {
        $.metadata.setType("attr", "validate");
        $('.auto-submit-star').rating({
            required: true,
            focus: function(value, link) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var tip = $('#hover-test' + ratingCriteria_id);
                tip[0].data = tip[0].data || tip.html();
                tip.html(link.title || 'value: ' + value);
                $("#tblRatingCriteria label.error").hide();
            },
            blur: function(value, link) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var tip = $('#hover-test' + ratingCriteria_id);
                tip.html(tip[0].data || '');
                $("#tblRatingCriteria label.error").hide();
            },

            callback: function(value, event) {
                var ratingCriteria_id = $(this).attr("name").replace( /[^0-9]/gi , '');
                var starRatingValues = $(this).attr("value");
                var len = ratingCriteria_id.length;
                var isAppend = true;
                if (ratingValues != '') {
                    var stringSplit = ratingValues.split('#');
                    $.each(stringSplit, function(index, item) {
                        if (item.substring(0, item.indexOf('-')) == ratingCriteria_id) {
                            var index = ratingValues.indexOf(ratingCriteria_id + "-");
                            var toReplace = ratingValues.substr(index, 2 + len);
                            ratingValues = ratingValues.replace(toReplace, ratingCriteria_id + "-" + value);
                            isAppend = false;
                        }
                    });
                    if (isAppend) {
                        ratingValues += ratingCriteria_id + "-" + starRatingValues + "#" + '';
                    }
                } else {
                    ratingValues += ratingCriteria_id + "-" + starRatingValues + "#" + '';
                }
            }
        });
    }

    function BindStarRatingAverage(itemAvgRating) {
        $("#divAverageRating").html('');
        var ratingStars = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        ratingStars += '<div class="cssClassToolTip">';
        for (i = 0; i < 10; i++) {
            if (itemAvgRating == ratingText[i]) {
                ratingStars += '<input name="avgItemRating" type="radio" class="auto-star-avg {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
                $(".cssClassRatingTitle").html(ratingTitle[i]);
            } else {
                ratingStars += '<input name="avgItemRating" type="radio" class="auto-star-avg {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        ratingStars += '</div>';
        $("#divAverageRating").append(ratingStars);
    }

    function DeleteUserReviewsAndRatings(tblID, argus) {
        switch (tblID) {
        case "gdvReviewsNRatings":
            var properties = {
                onComplete: function(e) {
                    ConfirmSingleDeleteItemReview(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item rating and review?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmSingleDeleteItemReview(itemReviewID, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteSingleItemRating",
                data: JSON2.stringify({ ItemReviewID: itemReviewID, storeID: storeId, portalID: portalId }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindAllReviewsAndRatingsGrid(null, null, null);
                    ShowGridTable();
                },
                error: function() {
                    alert("error");
                }
            });
        }
    }

    function ConfirmDeleteMultipleItemRating(itemReview_ids, event) {
        if (event) {
            DeleteMultipleItemRating(itemReview_ids, storeId, portalId);
        }
    }

    function DeleteMultipleItemRating(_itemReviewIds, _storeId, _portalId) {
        var params = { itemReviewIDs: _itemReviewIds, storeId: _storeId, portalId: _portalId };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleItemRatings",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindAllReviewsAndRatingsGrid(null, null, null);
            }
        });
        return false;
    }

    function HideAll() {
        $("#divShowItemRatingDetails").hide();
        $("#divItemRatingForm").hide();
    }

    function GetStatusList() {
        var param = JSON2.stringify({ cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStatus",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindRatingStatusDropDown(item);
                });
                $('#selectStatus').val('2');
            },
            error: function() {
                alert("error");
            }
        });
    }

    function BindRatingStatusDropDown(item) {
        $("#selectStatus").append("<option value=" + item.StatusID + ">" + item.Status + "</option>");
        $("#ddlStatus").append("<option value=" + item.StatusID + ">" + item.Status + "</option>");
    }

    function BindRatingCriteria() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, isFlag: false });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingCriteria",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#tblRatingCriteria").html('');
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        RatingCriteria(item);
                    });
                } else {
                    alert("No criteria for rating found!");
                }
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function RatingCriteria(item) {
        var ratingCriteria = '';
        ratingCriteria += '<tr><td class="cssClassRatingTitleName"><label class="cssClassLabel">' + item.ItemRatingCriteria + ':<span class="cssClassRequired">*</span></label></td><td>';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="1" title="Worst" validate="required:true" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="2" title="Bad" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="3" title="OK" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="4" title="Good" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="5" title="Best" />';
        ratingCriteria += '<span id="hover-test' + item.ItemRatingCriteriaID + '"></span>';
        ratingCriteria += '<label for="star' + item.ItemRatingCriteriaID + '" class="error">Please rate for ' + item.ItemRatingCriteria + '</label></tr></td>';
        $("#tblRatingCriteria").append(ratingCriteria);
    }

    function SaveItemRatings() {
        var statusId = $("#selectStatus").val();
        var ratingValue = ratingValues;
        var nickName = $("#txtNickName").val();
        var summaryReview = $("#txtSummaryReview").val();
        var review = $("#txtReview").val();
        //var itemId = $("#selectItemList").val();
        var itemId = $("#lnkItemName").attr("name");
        var itemReviewID = $("#btnDeleteReview").attr("name");
        var User = $("#selectUserName option:selected").text();
        var itemReviewId = $("#hdnItemReview").val();
        var param = '';
        if (itemReviewId != 0) {
            param = JSON2.stringify({ ratingCriteriaValue: ratingValue, statusID: statusId, summaryReview: summaryReview, review: review, itemReviewID: itemReviewID, viewFromIP: userIP, viewFromCountry: countryName, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, userName: userName });
        } else {
            param = JSON2.stringify({ ratingCriteriaValue: ratingValue, statusID: statusId, summaryReview: summaryReview, review: review, itemReviewID: itemReviewID, viewFromIP: userIP, viewFromCountry: countryName, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, userName: User });
        }
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateItemRating",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                //alert("This review has been updated sucessfully.");
                csscody.alert('<h2>Information Alert</h2><p>This review has been updated sucessfully.</p>');
                BindAllReviewsAndRatingsGrid(null, null, null);
                ClearReviewForm();
                ShowGridTable();
                BindRatingCriteria();
            },
            error: function() {
                //alert("Error!");
                csscody.error('<h2>Error Message</h2><p>Error! Failed to save.</p>');
            }
        });
    }

    function ClearReviewForm() {
        //Clear all Stars checked      
        $('.auto-submit-star').rating('drain');
        $('.auto-submit-star').removeAttr('checked');
        $('.auto-submit-star').rating('select', -1);
        $("#txtNickName").val('');
        $("#txtSummaryReview").val('');
        $("#txtReview").val('');
        $("label.error").hide();
        $('#selectStatus').val('2');
        $('#txtNickName').removeClass('error');
        $('#txtNickName').parents('td').find('label').remove();
        $('#txtSummaryReview').removeClass('error');
        $('#txtSummaryReview').parents('td').find('label').remove();
        $('#txtReview').removeClass('error');
        $('#txtReview').parents('td').find('label').remove();

        $('#selectItemList').removeClass('error');
        $('#selectItemList').parents('td').find('label').remove();
    }

    function GetAllItemsList() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllItemList",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                // $("#selectItemList>option").remove();
                $.each(msg.d, function(index, item) {
                    BindItemsDropDown(item);
                });
                $("#lnkItemName").attr("name", $("#selectItemList").val());
            },
            error: function() {
                alert("error");
            }
        });
    }

    function BindItemsDropDown(item) {
        $("#selectItemList").append("<option value=" + item.ItemID + ">" + item.ItemName + "</option>");
    }

    function SearchItemRatings() {
        var searchUserName = $.trim($("#txtSearchUserName").val());
        var status = '';
        if (searchUserName.length < 1) {
            searchUserName = null;
        }
        if ($.trim($("#ddlStatus").val()) != 0) {
            status = $("#ddlStatus option:selected").val();
        } else {
            status = null;
        }
        var SearchItemName = $.trim($("#txtSearchItemNme").val());
        if (SearchItemName.length < 1) {
            SearchItemName = null;
        }
        BindAllReviewsAndRatingsGrid(searchUserName, status, SearchItemName);
    }
</script>

<div id="divShowItemRatingDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblReviewsGridHeading" runat="server" Text="All Reviews and Ratings"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" class="" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <p>
                        <button type="button" class="" id="btnAddNewReview">
                            <span><span>Add New Review and Rating </span></span>
                        </button>
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
                                    UserName:</label>
                                <input type="text" id="txtSearchUserName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Status:</label>
                                <select id="ddlStatus" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                </select>
                            </td>
                            <td>
                            <label class="cssClassLabel">
                                Item Name:</label>
                            <input type="text" id="txtSearchItemNme" class="cssClassTextBoxSmall" />
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchItemRatings() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxItemRatingMgmtImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvReviewsNRatings" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divItemRatingForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblReviewsFromHeading" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblEditReviewForm" class="cssClassPadding">
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Item:</label>
                    </td>
                    <td>
                        <a href="#" id="lnkItemName" class="cssClassLabel"></a>
                        <select id="selectItemList" class="cssClassDropDown required">
                            <option value="0">--Select One--</option>
                        </select>
                    </td>
                </tr>
                <tr id="trUserList">
                    <td>
                        <label class="cssClassLabel">
                            User Name:</label>
                    </td>
                    <td>
                        <select id="selectUserName" class="cssClassDropDown">
                        </select>
                    </td>
                </tr>
                <tr id="trPostedBy">
                    <td>
                        <label class="cssClassLabel">
                            Posted By:</label>
                    </td>
                    <td>
                        <label id="lblPostedBy" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr id="trViewedIP">
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            View From IP:</label>
                    </td>
                    <td>
                        <label id="lblViewFromIP" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr id="trSummaryRating">
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Summary Rating:</label>
                    </td>
                    <td>
                        <div id="divAverageRating">
                        </div>
                        <span class="cssClassRatingTitle"></span>
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Detailed Rating:</label>
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblRatingCriteria">
                        </table>
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Nick Name:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtNickName" name="name" class="cssClassNormalTextBox required"
                               minlength="2" />
                    </td>
                </tr>
                <tr id="trAddedOn">
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Added On:</label>
                    </td>
                    <td>
                        <label id="lblAddedOn">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Summary Of Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtSummaryReview" name="summary" class="cssClassNormalTextBox required"
                               minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <textarea id="txtReview" cols="50" rows="10" name="review" class="cssClassTextArea required" maxlength="300"></textarea>
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Status:</label>
                    </td>
                    <td>
                        <select id="selectStatus" class="cssClassDropDown">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnReviewBack">
                    <span><span>Back</span></span></button>
            </p>
            <p>
                <button type="button" id="btnReset">
                    <span><span>Reset</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitReview">
                    <span><span>Submit</span></span></button>
            </p>
            <p>
                <button type="button" id="btnDeleteReview">
                    <span><span>Delete</span></span></button>
            </p>
        </div>
    </div>
</div>

<input type="hidden" id="hdnItemReview" />