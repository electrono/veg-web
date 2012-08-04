<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomersReviews.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXItemRatingManagement_CustomersReviews" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userIP = '<%= userIP %>';
    var countryName = '<%= countryName %>';
    var ratingValues = '';

    $(document).ready(function() {
        LoadCustomerItemReviewStaticImage();
        BindCustomerReviews();
        GetStatusList();
        $('#btnDeleteReview').hide();
        HideDiv();
        $("#divCustomerReviews").show();

        $("#btnExportToCSV").click(function() {
            $('#gdvCustomerReviews').table2CSV();
        });
        $("#btnBackCustomerReviews").click(function() {
            HideDiv();
            $("#divCustomerReviews").show();
        });
        $("#btnExportReviews").click(function() {
            $('#gdvShowCustomerReviewList').table2CSV();
        });
        $("#btnReviewBack").click(function() {
            HideDiv();
            $("#divShowCustomerReviewList").show();
        });
    });

    function LoadCustomerItemReviewStaticImage() {
        $('#ajaxCustomerItemReviewImage1').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxCustomerItemReviewImage2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDiv() {
        $("#divCustomerReviews").hide();
        $("#divShowCustomerReviewList").hide();
        $("#divCustomerItemRatingForm").hide();
    }

    function BindCustomerReviews() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCustomerReviews_pagesize").length > 0) ? $("#gdvCustomerReviews_pagesize :selected").text() : 10;

        $("#gdvCustomerReviews").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCustomerReviews',
            colModel: [
                { display: 'Customer Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Number Of Reviews', name: 'number_of_reviews', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Show', name: 'showReviews', enable: true, _event: 'click', trigger: '1', callMethod: 'ShowCustomerReviewsList', arguments: '1,' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId },
            current: current_,
            pnew: offset_,
            sortcol: { 2: { sorter: false } }
        });
    }

    function ExportDivDataToExcel() {
        var headerArr = $("#gdvCustomerReviews thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvCustomerReviews tbody tr");
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

    function ShowCustomerReviewsList(tblID, argus) {
        switch (tblID) {
        case "gdvCustomerReviews":
            $("#<%= lblCRHeading.ClientID %>").html("All Reviews Of Customer: '" + argus[0] + "'");
            BindShowCustomerReviewsList(argus[0], null, null, null);
            HideDiv();
            $("#divShowCustomerReviewList").show();
            break;
        }
    }

    function BindShowCustomerReviewsList(UserName, searchUserName, status, SearchItemName) {
        $("#hdnUser").val(UserName);
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShowCustomerReviewList_pagesize").length > 0) ? $("#gdvShowCustomerReviewList_pagesize :selected").text() : 10;

        $("#gdvShowCustomerReviewList").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllCustomerReviewsList',
            colModel: [
                { display: 'ItemReviewID', name: 'itemreview_id', cssclass: 'cssClassHide', align: 'center', elemClass: 'customerReviewChkbox', hide: true },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'User Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Total Rating Average', name: 'total_rating_average', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'View From IP', name: 'view_from_IP', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Review Summary', name: 'review_summary', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Review', name: 'review', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Added By', name: 'AddedBy', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Status ID', name: 'status_id', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item SKU', name: 'item_SKU', cssclass: 'cssClassHide', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'View', name: 'view', enable: true, _event: 'click', trigger: '1', callMethod: 'EditUserReviewsAndRatings', arguments: '1,2,3,4,5,6,7,8,9,10,11,12' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { user: searchUserName, statusName: status, itemName: SearchItemName, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: UserName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 13: { sorter: false } }
        });
    }

    function EditUserReviewsAndRatings(tblID, argus) {
        switch (tblID) {
        case "gdvShowCustomerReviewList":
            BindItemReviewDetails(argus);
            BindRatingCriteria(argus[0]);
            BindRatingSummary(argus[0]);
            HideDiv();
            $("#divCustomerItemRatingForm").show();
            $("#hdnItemReviewID").val(argus[0]);
            break;
        default:
            break;
        }
    }

    function BindRatingCriteria(reviewID) {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName, itemReviewID: reviewID, isFlag: false });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetItemRatingCriteriaByReviewID",
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
        ratingCriteria += '<tr><td class="cssClassRatingTitleName"><label class="cssClassLabel">' + item.ItemRatingCriteria + ':</label></td><td>';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="1" title="Worst" validate="required:true" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="2" title="Bad" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="3" title="OK" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="4" title="Good" />';
        ratingCriteria += '<input name="star' + item.ItemRatingCriteriaID + '" type="radio" class="auto-submit-star item-rating-crieteria' + item.ItemRatingCriteriaID + '" value="5" title="Best" />';
        ratingCriteria += '<span id="hover-test' + item.ItemRatingCriteriaID + '"></span>';
        ratingCriteria += '<label for="star' + item.ItemRatingCriteriaID + '" class="error">Please rate for ' + item.ItemRatingCriteria + '</label></tr></td>';
        $("#tblRatingCriteria").append(ratingCriteria);
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

    function BindItemReviewDetails(argus) {
        $("#<%= lblReviewsFromHeading.ClientID %>").html("Review: '" + argus[7] + "'");
        $("#lnkItemNames").html(argus[10]);
        $("#lnkItemNames").attr("name", argus[3]);
        $("#lblPostedBy").html(argus[12]);
        $("#lblViewFromIP").html(argus[6]);
        $("#txtNickName").val(argus[4]);
        $("#lblAddedOn").html(argus[11]);
        $("#txtSummaryReview").val(argus[7]);
        $("#txtReview").val(argus[8]);
        $("#selectStatus").val(argus[13]);

        $("#txtNickName").attr('disabled', 'disabled');
        $("#txtSummaryReview").attr('disabled', 'disabled');
        $("#txtReview").attr('disabled', 'disabled');
        $("#selectStatus").attr('disabled', 'disabled');
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
                    $('input.item-rating-crieteria' + item.ItemRatingCriteriaID).rating('disable');
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

    function ExportDataToExcel() {
        var headerArr = $("#gdvShowCustomerReviewList thead tr th");
        var header = "<tr>";
        $.each(headerArr, function() {
            if (!$(this).hasClass("cssClassAction") && !$(this).hasClass("cssClassHide")) {
                header += '<th>' + $(this).text() + '</th>';
            }
        });
        header += '</tr>'
        var data = $("#gdvShowCustomerReviewList tbody tr");
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
        $("input[id$='HdnReviews']").val(table);
    }

    function SearchItemRatings() {
        var user = $("#hdnUser").val();
        var searchUserName = $.trim($("#txtSearchUserName").val());
        var status = '';
        if (searchUserName.length < 1) {
            searchUserName = null;
        }
        if ($.trim($("#ddlStatus").val()) != 0) {
            status = $("#ddlStatus option:selected").text();
        } else {
            status = null;
        }
        var SearchItemName = $.trim($("#txtsearchItemNm").val());
        if (SearchItemName.length < 1) {
            SearchItemName = null;
        }
        BindShowCustomerReviewsList(user, searchUserName, status, SearchItemName);
    }
</script>

<div id="divCustomerReviews">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblReviewHeading" runat="server" Text="Customer Reviews"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <asp:Button ID="btnExportToExcel" CssClass="cssClassButtonSubmit" runat="server"
                                    OnClick="Button1_Click" Text="Export to Excel" OnClientClick="ExportDivDataToExcel()" />
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
                <div class="loading">
                    <img id="ajaxCustomerItemReviewImage2" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCustomerReviews" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnValue" runat="server" />
<div id="divShowCustomerReviewList">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCRHeading" runat="server" Text=""></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">                    
                    <p>
                        <asp:Button ID="btnExportReviewsToExcel" CssClass="cssClassButtonSubmit" runat="server"
                                    OnClick="Button2_Click" Text="Export to Excel" OnClientClick="ExportDataToExcel()" />
                    </p>
                    <p>
                        <button type="button" id="btnExportReviews">
                            <span><span>Export to CSV</span></span></button>
                    </p>
                    <p>
                        <button type="button" id="btnBackCustomerReviews">
                            <span><span>Back</span></span></button>
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
                                    ItemName:</label>
                                <input type="text" id="txtsearchItemNm" class="cssClassTextBoxSmall" />
                            </td>
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
                    <img id="ajaxCustomerItemReviewImage1" />
                </div>
                <div class="log">
                </div>
                <table id="gdvShowCustomerReviewList" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<asp:HiddenField ID="HdnReviews" runat="server" />
<div id="divCustomerItemRatingForm">
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
                        <label id="lnkItemNames" class="cssClassLabel"></label>
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
                            Nick Name:</label>
                    </td>
                    <td>
                        <input type="text" id="txtNickName" class="cssClassNormalTextBox "/>
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
                            Summary Of Review:</label>
                    </td>
                    <td>
                        <input type="text" id="txtSummaryReview" name="summary" class="cssClassNormalTextBox "/>
                    </td>
                </tr>
                <tr>
                    <td class="cssClassTableLeftCol">
                        <label class="cssClassLabel">
                            Review:</label>
                    </td>
                    <td>
                        <textarea id="txtReview" cols="50" rows="10" class="cssClassTextArea"></textarea>
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
        </div>
    </div>
</div>
<input type="hidden" id="hdnUser" />
<input type="hidden" id="hdnItemReviewID" />