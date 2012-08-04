<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RecentReviewsAndRatings.ascx.cs"
            Inherits="Modules_ASPXItemRatingManagement_RecentReviewsAndRatings" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userIP = '<%= userIP %>';
    var countryName = '<%= countryName %>';

    var ratingValues = '';
    var ItemsReview = '';

    var arrItemDetailsReviewList = new Array();
    var arrItemReviewList = new Array();

    /**
    * Callback function that displays the content.
    *
    * Gets called every time the user clicks on a pagination link.
    *
    * @param {int}page_index New Page index
    * @param {jQuery} jq the container with the pagination links as a jQuery object
    */

    function pageselectCallback(page_index, jq) {
        // Get number of elements per pagionation page from form
        //alert(page_index);
        // alert(jq);
        $("#tblRatingPerUser").html('');

        var items_per_page = $("#ddlPageSize").val();
        var max_elem = Math.min((page_index + 1) * items_per_page, arrItemReviewList.length);

        //alert(arrItemDetailsReviewList.length + '::' + arrItemReviewList.length);
        // Iterate through a selection of the content and build an HTML string
        ItemsReview = '';

        for (var i = page_index * items_per_page; i < max_elem; i++) {
            BindAverageUserRating(arrItemReviewList[i]);
            //alert(arrItemReviewList[i].ItemReviewID);
            ItemsReview += arrItemReviewList[i].ItemReviewID;

        }
        $.each(arrItemDetailsReviewList, function(index, item) {
            if (ItemsReview.indexOf(item.ItemReviewID) != -1) {
                BindPerUserIndividualRatings(item.ItemReviewID, item.ItemRatingCriteria, item.RatingValue);
            }
        });
        //
        $("input.star-rate").rating();
        $("#tblRatingPerUser tr:even").addClass("cssClassAlternativeOdd");
        $("#tblRatingPerUser tr:odd").addClass("cssClassAlternativeEven");
        //GetItemRatingPerUser();
        // Prevent click event propagation
        return false;
    }

    // The form contains fields for many pagiantion optiosn so you can 
    // quickly see the resuluts of the different options.
    // This function creates an option object for the pagination function.
    // This will be be unnecessary in your application where you just set
    // the options once.

    function getOptionsFromForm() {
        var opt = { callback: pageselectCallback };
        //parseInt(
        opt.items_per_page = $('#ddlPageSize').val();
        //opt.num_display_entries = 10;
        //opt.current_page = 0;

        opt.prev_text = "Prev";
        opt.next_text = "Next";
        opt.prev_show_always = false;
        opt.next_show_always = false;
        return opt;
    }

    $(document).ready(function() {

        BindRatingCriteria();
        GetStatusOfRatingReview();
        GetItemRatingPerUser();
        $("#ddlPageSize").change(function() {
            // Create pagination element with options from form
            var optInit = getOptionsFromForm();
            $("#Pagination").pagination(arrItemReviewList.length, optInit);
        });

        $(".cssClassClose").click(function() {
            $('#fade, #popuprel5').fadeOut();
        });

        $("#btnReviewBack").click(function() {
            //HideAll();
            //$("#tblLatestReviews").show();
            $('#fade, #popuprel5').fadeOut();
        });

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
            ignore: ':hidden',
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
            if (v.form()) {
                SaveItemRatings();
                return false;
            } else {
                return false;
            }
        });
        // 
    });

    function SaveItemRatings() {
        var statusId = $("#selectStatus").val();
        var ratingValue = ratingValues;
        var nickName = $("#txtNickName").val();
        var summaryReview = $("#txtSummaryReview").val();
        var review = $("#txtReview").val();
        var itemId = $("#lnkItemName").attr("name");
        var itemReviewID = $("#btnDeleteReview").attr("name");
        var param = JSON2.stringify({ ratingCriteriaValue: ratingValue, statusID: statusId, summaryReview: summaryReview, review: review, itemReviewID: itemReviewID, viewFromIP: userIP, viewFromCountry: countryName, itemID: itemId, storeID: storeId, portalID: portalId, nickName: nickName, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateItemRating",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                GetItemRatingPerUser();
                HideAll();
                //$("#tblLatestReviews").show();
                // alert("This review has been updated sucessfully.");
                csscody.alert('<h2>Information Alert</h2><p>This review has been updated sucessfully.</p>');
                ClearReviewForm();
            },
            error: function() {
                csscody.error('<h2>Error Message</h2><p>Error! Failed to save Rating</p>');
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

    function BindRatingCriteria() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, isFlag: false });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingCriteria",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        RatingCriteria(item);
                    });

                } else {
                    //alert("No criteria for rating found!");
                    csscody.alert('<h2>Information Alert</h2><p> No criteria for rating found!</p>');
                }
            },
            error: function() {
                //alert("Error!");
                csscody.error('<h2>Error Message</h2><p> Error! Failed to bind Rating Criteria</p>');
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

    function GetStatusOfRatingReview() {
        var param = JSON2.stringify({ cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetStatus",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    BindRatingReviewStatusDropDown(item);
                });
            },
            error: function() {
                // alert("error");
                csscody.error('<h2>Error Message</h2><p> Error! Failed to bind Status Of Rating</p>');
            }
        });
    }

    function BindRatingReviewStatusDropDown(item) {
        $("#selectStatus").append("<option value=" + item.StatusID + ">" + item.Status + "</option>");
    }

    function EditReview(reviewID) {
        BindReviewPopUp(reviewID);
        ShowPopupControl("popuprel5");
    }

    function BindReviewPopUp(reviewID) {
        review_id = reviewID;
        $("#btnDeleteReview").attr("name", review_id);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingByReviewID",
            data: JSON2.stringify({ itemReviewID: review_id, storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                //HideAll();
                //$("#tblEditReviews").show();
                $("#tblRatingCriteria label.error").hide();
                var itemAvgRating = '';
                $.each(msg.d, function(index, item) {
                    if (index == 0) {
                        BindStarRatingsDetails();
                        BindItemReviewDetails(item);
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
                csscody.error('<h2>Error Message</h2><p> Error! Failed to bind Review PopUp.</p>');
            }
        });
    }

    function BindItemReviewDetails(item) {
        $("#lnkItemName").html(item.ItemName);
        $("#lnkItemName").attr("href", aspxRedirectPath + 'item/' + item.ItemSKU + '.aspx');
        $("#lnkItemName").attr("target", "_blank");
        $("#lnkItemName").attr("name", item.ItemID);
        $("#lblPostedBy").html(item.AddedBy);
        $("#lblViewFromIP").html(item.ViewFromIP);
        $("#txtNickName").val(item.Username);
        $("#lblAddedOn").html(item.AddedOn);

        $("#txtSummaryReview").val(item.ReviewSummary);
        $("#txtReview").val(item.Review);

        $("#lblViewFromIP").html(item.ViewFromIP);

        $("#selectStatus").val(item.StatusID);
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

    function DeleteReview(obj) {
        var review_id = $(obj).val();
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDeleteItemReview(review_id, e);
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this item rating and review?</p>", properties);
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
                    GetItemRatingPerUser();
                    HideAll();
                    //$("#tblLatestReviews").show();
                    return false;
                },
                error: function() {
                    //  alert("error");
                    csscody.error('<h2>Error Message</h2><p>Error! Unable to delete.</p>');
                }
            });
        } else {
            return false;
        }
    }

    function HideAll() {
        $('#fade, #popuprel5').fadeOut();
    }

    function GetItemRatingPerUser() {
        ItemsReview = '';
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetRecentItemReviewsAndRatings",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                arrItemDetailsReviewList.length = 0;
                arrItemReviewList.length = 0;
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindItemsRatingByUser(item, index);
                    });
                    // Create pagination element with options from form
                    var optInit = getOptionsFromForm();
                    $("#Pagination").pagination(arrItemReviewList.length, optInit);
                    //alert(arrItemReviewList.length);

                } else {
                    $("#divSearchPageNumber").hide();
                    //alert("No user rating is found!");
                    var avgRating = "<tr><td class=\"cssClassNotFound\">Currently there are no reviews</td></tr>";
                    $("#tblRatingPerUser").append(avgRating);
                }

            },
            error: function() {
                //alert("Error!");
                csscody.error('<h2>Error Message</h2><p>Error! Failed to bind User Rating.</p>');
            }
        });


    }

    function BindItemsRatingByUser(item, index) {
        // alert(ItemsReview.indexOf(item.ItemReviewID));
        arrItemDetailsReviewList.push(item);
        if (ItemsReview.indexOf(item.ItemReviewID) == -1) {
            ItemsReview += item.ItemReviewID;
            arrItemReviewList.push(item);

        }
    }

    function BindAverageUserRating(item) {
        var userRatings = '';
        userRatings += '<tr><td><div class="cssClassRateReviewWrapper"><div class="cssClassItemRating">';
        userRatings += '<div class="cssClassItemRatingBox">' + BindStarRatingAveragePerUser(item.ItemReviewID, item.RatingAverage) + '</div>';
        userRatings += '<div class="cssClassRatingInfo"><p>' + Encoder.htmlDecode(item.ReviewSummary) + '<span> Review by <strong>' + item.Username + '</strong></span></p></div></div>';
        userRatings += '<div class="cssClassRatingReviewDesc"><p>' + Encoder.htmlDecode(item.Review) + '</p></div>';
        userRatings += '<div class="cssClassRatingReviewDate"><p> (Posted on <strong>' + formatDate(new Date(item.AddedOn), "yyyy/M/d hh:mm:ssa") + '</strong>)</p></div>';
        userRatings += '</div><div class="cssClassButtonWrapper"><p><button type="button" id="btnEditReview" onclick="EditReview(' + item.ItemReviewID + ' )"><span><span>Edit</span></span></button></p></div></td></tr>';
        $("#tblRatingPerUser").append(userRatings);
        var ratingToolTip = $("#hdnRatingTitle" + item.ItemReviewID + "").val();
        $(".cssClassUserRatingTitle_" + item.ItemReviewID + "").html(ratingToolTip);
    }

    function BindStarRatingAveragePerUser(itemReviewID, itemAvgRating) {
        var ratingStars = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        var ratingTitleText = '';
        ratingStars += '<div class="cssClassRatingStar"><div class="cssClassToolTip">';
        ratingStars += '<span class="cssClassRatingTitle cssClassUserRatingTitle_' + itemReviewID + '"></span>';
        for (i = 0; i < 10; i++) {
            if (itemAvgRating == ratingText[i]) {
                ratingStars += '<input name="avgRatePerUser' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
                ratingTitleText = ratingTitle[i];
            } else {
                ratingStars += '<input name="avgRatePerUser' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        ratingStars += '<input type="hidden" value="' + ratingTitleText + '" id="hdnRatingTitle' + itemReviewID + '"></input><span class="cssClassToolTipInfo cssClassReviewId_' + itemReviewID + '"></span></div></div><div class="cssClassClear"></div>';
        return ratingStars;
    }

    function BindPerUserIndividualRatings(itemReviewID, itemRatingCriteria, ratingValue) {
        var userRatingStarsDetailsInfo = '';
        var ratingTitle = ["Worst", "Ugly", "Bad", "Not Bad", "Average", "OK", "Nice", "Good", "Best", "Excellent"]; //To do here tooltip for each half star
        var ratingText = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
        var i = 0;
        userRatingStarsDetailsInfo += '<div class="cssClassToolTipDetailInfo">';
        userRatingStarsDetailsInfo += '<span class="cssClassCriteriaTitle">' + itemRatingCriteria + ': </span>';
        for (i = 0; i < 10; i++) {
            if (ratingValue == ratingText[i]) {
                userRatingStarsDetailsInfo += '<input name="avgUserDetailRate' + itemRatingCriteria + '_' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" checked="checked" value="' + ratingTitle[i] + '" />';
            } else {
                userRatingStarsDetailsInfo += '<input name="avgUserDetailRate' + itemRatingCriteria + '_' + itemReviewID + '" type="radio" class="star-rate {split:2}" disabled="disabled" value="' + ratingTitle[i] + '" />';
            }
        }
        userRatingStarsDetailsInfo += '</div>';
        $('#tblRatingPerUser span.cssClassReviewId_' + itemReviewID + '').append(userRatingStarsDetailsInfo);
    }
</script>

<div id="tblLatestReviews">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblFrontReviewsHeading" runat="server" Text="Latest comments & reviews"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <div class="cssClassRateReview">
                <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblRatingPerUser">
                </table>
            </div>
            <div class="cssClassPagination" id="divSearchPageNumber">
                <div class="cssClassPageNumber">
                    <div id="Pagination">
                    </div>
                </div>
                <div class="cssClassViewPerPage">
                    View Per Page
                    <select id="ddlPageSize">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="25">25</option>
                        <option value="40">40</option>
                    </select>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="popupbox" id="popuprel5">
    <div class="cssClassCloseIcon">
        <button type="button" class="cssClassClose">
            <span>Close</span></button>
    </div>
    <h2>
        <asp:Label ID="Label1" runat="server" Text="Edit this item Rating & Review"></asp:Label>
    </h2>
    <%--<div id="tblEditReviews">
  <div class="cssClassCommonBox Curve">
    <div class="cssClassHeader">
      <h2>
        <asp:Label ID="lblReviewFromHeading" runat="server" Text="Edit this item Rating & Review"></asp:Label>
      </h2>
    </div>--%>
    <div class="cssClassFormWrapper">
        <table cellspacing="0" cellpadding="0" border="0" width="100%" id="tblEditReviewForm"
               class="cssClassPadding">
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Item:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <a href="#" id="lnkItemName"></a>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Posted By:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <label id="lblPostedBy" class="cssClassLabel">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        View From IP:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <label id="lblViewFromIP" class="cssClassLabel">
                    </label>
                    <%--<input type="text" id="txtViewFromIP" />--%>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Summary Rating:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <div id="divAverageRating">
                    </div>
                    <span class="cssClassRatingTitle" class="cssClassLabel"></span>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Detailed Rating:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <table cellspacing="0" cellpadding="0" width="100%" border="0" id="tblRatingCriteria">
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Nick Name:<span class="cssClassRequired">*</span></label>
                </td>
                <td class="cssClassTableRightCol">
                    <input type="text" id="txtNickName" name="name" class="cssClassNormalTextBox required"
                           minlength="2" />
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Added On:</label>
                </td>
                <td class="cssClassTableRightCol">
                    <label id="lblAddedOn">
                    </label>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Summary Of Review:<span class="cssClassRequired">*</span></label>
                </td>
                <td class="cssClassTableRightCol">
                    <input type="text" id="txtSummaryReview" name="summary" class="cssClassNormalTextBox required"
                           minlength="2" />
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Review:<span class="cssClassRequired">*</span></label>
                </td>
                <td class="cssClassTableRightCol">
                    <textarea id="txtReview" cols="50" rows="10" name="review" class="cssClassTextarea required" maxlength="300"></textarea>
                </td>
            </tr>
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Status:</label>
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
            <button type="button" id="btnReviewBack">
                <span><span>Back</span></span></button>
        </p>
        <p>
            <input type="submit" value="Submit" id="btnSubmitReview" class="cssClassButtonSubmit">
            <%--<button type="submit" id="" ><span><span>Save</span></span></button>--%>
            <%-- <input  type="submit" value="Submit" id="btnSubmitReview"/>--%>
        </p>
        <p>
            <button type="button" id="btnDeleteReview">
                <span><span>Delete</span></span></button>
        </p>
    </div>
    <div class="cssClassClear">
    </div>
</div>