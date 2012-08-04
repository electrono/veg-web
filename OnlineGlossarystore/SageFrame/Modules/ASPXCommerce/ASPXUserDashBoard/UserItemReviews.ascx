﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserItemReviews.ascx.cs"
            Inherits="Modules_ASPXUserDashBoard_UserProductReviews" %>

<script type="text/javascript">

    $(document).ready(function() {
        LoadUserDashItemReviewStaticImage();
        BindReviewsAndRatingsGridByUser();
        ShowGridTable();
        var v = $("#form1").validate({
            messages: {
                name: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                summary: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                review: {
                    required: '*',
                    minlength: "*"
                }
            }
        });

        $('#btnUpdateReview').click(function() {
            if (v.form()) {
                UpdateItemRatingsByUser();
                BindRatingCriteria();
                ShowGridTable();
                return false;
            } else {
                return false;
            }
        });

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
    });

    function LoadUserDashItemReviewStaticImage() {
        $('#ajaxUserItemReviewImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function ShowGridTable() {
        HideAll();
        $("#divShowItemRatingDetails").show();
    }

    function BindReviewsAndRatingsGridByUser() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvReviewsNRatings_pagesize").length > 0) ? $("#gdvReviewsNRatings_pagesize :selected").text() : 10;

        $("#gdvReviewsNRatings").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetUserReviewsAndRatings',
            colModel: [
                { display: 'ItemReviewID', name: 'itemreview_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'itemRatingChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Nick Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Total Rating Average', name: 'total_rating_average', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'View From IP', name: 'view_from_IP', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Review Summary', name: 'review_summary', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Review', name: 'review', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status', name: 'status', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'link', align: 'left', url: 'item', queryPairs: 'itemSKU:11', showpopup: false, popupid: '', poparguments: '', popupmethod: '' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status ID', name: 'status_id', cssclass: '', controlclass: 'cssClassHeadNumber', coltype: 'label', align: 'left', hide: true },
                { display: 'Item SKU', name: 'item_SKU', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditReviewsNRatings', arguments: '1,2,3,4,5,6,7,8,9,11,12' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteReviewsNRatings', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, userName: userName, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 13: { sorter: false } }
        });
    }

    function EditReviewsNRatings(tblID, argus) {
        switch (tblID) {
        case "gdvReviewsNRatings":
            ReviewID = argus[0];
            status = argus[9];
            ClearReviewForm();
            BindItemReviewDetails(argus);
            BindRatingSummary(argus[0]);
                //BindRatingCriteria();
            HideAll();
            $("#divItemRatingForm").show();
            break;
        default:
            break;
        }
    }

    function BindItemReviewDetails(argus) {
        BindRatingCriteria();
        $("#btnDeleteReview").attr("name", argus[0]);
        $("#lnkItemName").html(argus[10]);
        $("#lnkItemName").attr("href", aspxRedirectPath + "item/" + argus[13] + ".aspx");
        $("#lnkItemName").attr("name", argus[3]);
        $("#lblViewFromIP").html(argus[6]);
        $("#txtNickName").val(argus[4]);
        $("#lblAddedOn").html(argus[11]);
        $("#txtSummaryReview").val(argus[7]);
        $("#txtReview").val(argus[8]);
        $("#lblStatus").html(argus[9]);
        if (argus[9].toLowerCase() != "pending") {
            $("#txtSummaryReview").attr('disabled', 'disabled');
            $("#txtReview").attr('disabled', 'disabled');
            // $('#btnDeleteReview').hide();
            $('#btnUpdateReview').hide();
        } else {
            $("#txtSummaryReview").removeAttr('disabled');
            $("#txtReview").removeAttr('disabled');
            $("#txtNickName").removeAttr('disabled');
            //$('#btnDeleteReview').hide();
            $('#btnUpdateReview').show();
        }
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
                    if (status.toLowerCase() == "approved") {
                        $('input.item-rating-crieteria' + item.ItemRatingCriteriaID).rating('disable');
                        $("#txtNickName").attr('disabled', 'disabled');
                    }
                });
                //$.metadata.setType("class");
                $('input.auto-star-avg').rating();
            }
        //            ,
        //            error: function() {
        //                alert("error");
        //            }
        });
    }

    function BindStarRatingsDetails() {
        //$.metadata.setType("attr", "validate");
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

    function DeleteReviewsNRatings(tblID, argus) {
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
                    BindReviewsAndRatingsGridByUser();
                    ShowGridTable();
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
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
                BindReviewsAndRatingsGridByUser();
            }
        });
        return false;
    }

    function HideAll() {
        $("#divShowItemRatingDetails").hide();
        $("#divItemRatingForm").hide();
    }

    function BindRatingCriteria() {
        var functionName = '';
        var param = '';
        if (status.toLowerCase() == 'pending') {
            functionName = "GetItemRatingCriteria";
            param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, isFlag: false });
        } else {
            functionName = "GetItemRatingCriteriaByReviewID";
            param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, itemReviewID: ReviewID, isFlag: false });
        }

        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
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
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="1" title="Worst"/>';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="2" title="Bad" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="3" title="OK" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="4" title="Good" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="5" title="Best" disabled="disabled"/>';
        ratingCriteria += '<span id="hover-test' + item.ItemRatingCriteriaID + '" class="cssClassHoverText"></span>';
        ratingCriteria += '<label for="star' + item.ItemRatingCriteriaID + '" class="error">Please rate for ' + item.ItemRatingCriteria + '</label></tr></td>';
        $("#tblRatingCriteria").append(ratingCriteria);
    }

    function UpdateItemRatingsByUser() {
        // alert('update');    
        var functionName = '';
        var param = '';
        var nickName = '';
        var summaryReview = '';
        var review = '';
        var itemId = '';
        var itemReviewID = '';
        var statusIs = '';
        if (status.toLocaleLowerCase() == "approved") {
            functionName = "UpdateItemRatingByUser";
            nickName = $("#txtNickName").val();
            summaryReview = $("#txtSummaryReview").val();
            review = $("#txtReview").val();
            itemId = $("#lnkItemName").attr("name");
            itemReviewID = $("#btnDeleteReview").attr("name");
            param = JSON2.stringify({ summaryReview: summaryReview, review: review, itemReviewID: itemReviewID, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, userName: userName });
        } else {
            functionName = "UpdateItemRating";
            statusId = '2';
            ratingValue = ratingValues;
            nickName = $("#txtNickName").val();
            summaryReview = $("#txtSummaryReview").val();
            review = $("#txtReview").val();
            itemId = $("#lnkItemName").attr("name");
            itemReviewID = $("#btnDeleteReview").attr("name");
            param = JSON2.stringify({ ratingCriteriaValue: ratingValue, statusID: statusId, summaryReview: summaryReview, review: review, itemReviewID: itemReviewID, viewFromIP: userIP, viewFromCountry: countryName, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, userName: userName });
        }
        debugger
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                alert("This review has been updated sucessfully.");
                BindReviewsAndRatingsGridByUser();
                ClearReviewForm();
            },
            error: function() {
                alert("Failed to update!");
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
    }
</script>

<div id="divShowItemRatingDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblReviewNRatingGridHeading" runat="server" Text="All Reviews and Ratings"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected">
                            <span><span>Delete All Selected</span></span></button>
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
                <div class="loading">
                    <img id="ajaxUserItemReviewImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvReviewsNRatings" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>
<div class="cssClassBodyContentWrapper" id="divItemRatingForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <label id="lblFormTitle">
                    Edit this item's Rating & Review</label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tblEditReviewForm"
                   class="cssClassPadding">
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Item:</label>
                    </td>
                    <td>
                        <a href="#" id="lnkItemName" class="cssClassLabel"></a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            View From IP:</label>
                    </td>
                    <td>
                        <label id="lblViewFromIP" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
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
                    <td>
                        <label class="cssClassLabel">
                            Detailed Rating:</label>
                    </td>
                    <td>
                        <table cellspacing="0" cellpadding="0" border="0" id="tblRatingCriteria">
                        </table>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Nick Name:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtNickName" name="name" class="cssClassNormalTextBox required"
                               minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Added On:</label>
                    </td>
                    <td>
                        <label id="lblAddedOn" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Summary Of Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtSummaryReview" name="summary" class="cssClassNormalTextBox required"
                               minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Review:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <textarea id="txtReview" cols="50" rows="10" name="review" class="cssClassTextArea required"></textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <label class="cssClassLabel">
                            Status:</label>
                    </td>
                    <td>
                        <label id="lblStatus" class="cssClassLabel">
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <button type="button" id="btnReviewBack">
                <span><span>Back</span></span></button>
            <button type="submit" id="btnUpdateReview">
                <span><span>Submit</span></span></button>
            <button type="button" id="btnDeleteReview">
                <span><span>Delete</span></span></button>
        </div>
    </div>
</div>