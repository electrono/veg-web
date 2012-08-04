<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AllCoupons.ascx.cs" Inherits="Modules_Admin_DetailsBrowse_AllCoupons" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var customerId = '<%= customerID %>';
    var couponShowCount = 0;
    var couponList = new Array();

    function pageselectCallback(page_index, jq) {
        // Get number of elements per pagionation page from form
        var items_per_page = $('#ddlPageSize').val();
        var max_elem = Math.min((page_index + 1) * items_per_page, couponList.length);
        $("#divCouponList").html('');
        coupon = '';
        for (var i = page_index * items_per_page; i < max_elem; i++) {
            BindCouponListForDisplay(couponList[i]);
            coupon += couponList[i].CouponID;
        }
        return false;
    }

    $(document).ready(function() {
        BindAllCouponList();
        $("#ddlPageSize").change(function() {
            var optInit = getOptionsFromForm();
            $("#Pagination").pagination(couponList.length, optInit);
        });

    });

    function BindAllCouponList() {
        var coupon = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCouponDetailListFront",
            data: JSON2.stringify({ Count: couponShowCount, StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: cultureName, CustomerID: customerId }),
            contentType: "application/json;charset=utf-8",
            dataType: "json",
            success: function(msg) {
                couponList = [];
                if (msg.d.length > 0) {
                    $.each(msg.d, function(index, item) {
                        BindCouponList(item, index);
                    });
                    var optInit = getOptionsFromForm();
                    $("#Pagination").pagination(couponList.length, optInit);
                    $("#divSearchPageNumber").show();
                } else {
                    $("#divSearchPageNumber").hide();
                    $("#divCouponList").html("<span class=\"cssClassNotFound\">No Data Found!!</span>");
                }
            }
//            ,
//            error: function() {
//                alert("error");
//            }
        });
    }

    function BindCouponList(item, index) {
        if (coupon.indexOf(item.CouponID) == -1) {
            coupon += item.CouponID;
        }
        couponList.push(item);
    }

    function BindCouponListForDisplay(item) {

        var htmlListt = "";
        htmlListt += '<ul class="couponList"><li><span> Coupon Type: <span>' + item.CouponType + '</li>';
        htmlListt += '<li><span> Coupon Code: <span>' + item.CouponCode + '</li>';
        htmlListt += '<li><span> Amount: <span class="cssClassFormatCurrency">' + (item.CouponAmount * rate) + '</li>';
        htmlListt += '<li><span> Valid Till: <span>' + item.ValidateTo + '</li>';
        htmlListt += '</ul><br />';
        $("#divCouponList").append(htmlListt);
        $('.cssClassFormatCurrency').formatCurrency({ colorize: true, region: '' + region + '' });
    }

    function getOptionsFromForm() {
        var opt = { callback: pageselectCallback };
        opt["items_per_page"] = $('#ddlPageSize').val();
        opt["prev_text"] = "Prev";
        opt["next_text"] = "Next";
        opt["prev_show_always"] = false;
        opt["next_show_always"] = false;
        return opt;
    }

</script>

<div id="divCouponDetailFront">
    <div class="cssClassFormWrapper">
        <div class="couponlistheader">
            <h2>
                <asp:Label ID="lblWishHeading" runat="server" Text="Available Coupon List"></asp:Label></h2>
            <%-- <a class="btnPrevious" href="#">
                    <img alt="" src="<%=ResolveUrl("~/")%>Templates/ASPXCommerce/images/admin/btnback.png" /></a>
                <a class="btnNext" href="#">
                    <img alt="" src="<%=ResolveUrl("~/")%>Templates/ASPXCommerce/images/admin/imgforward.png" /></a>--%>
        </div>
        <div id="divCouponList">
        </div>
        <%-- <div>
            <p>
                <a href="#" class"btnSeeAllCoupon" onclick="SeeAllCoupon(0)">See all Coupons >></a>
                <a href="#" class"btnColapseAllCoupon" onclick="SeeAllCoupon(1)"> << </a>              
            </p>
        </div>--%>
    </div>
    <div class="cssClassPageNumber" id="divSearchPageNumber">
        <div class="cssClassPageNumberLeftBg">
            <div class="cssClassPageNumberRightBg">
                <div class="cssClassPageNumberMidBg">
                    <div id="Pagination">
                    </div>
                    <div class="cssClassViewPerPage">
                        View Per Page<select id="ddlPageSize" class="cssClassDropDown">
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
</div>