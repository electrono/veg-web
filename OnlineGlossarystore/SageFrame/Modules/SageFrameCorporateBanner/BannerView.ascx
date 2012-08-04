<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BannerView.ascx.cs" Inherits="Modules_SageFrameCorporateBanner_BannerView" %>

<script type="text/javascript">
    //var bannerModulePath = "Modules/SageFrameCorporateBanner/";
    var userModuleId = '<%= SageUserModuleID %>';
    var portalId = '<%= GetPortalID %>';
    var cultureName = '<%= GetCurrentCultureName %>';
    var bannerMainText = '';
    var bannerNavText = '';

//    $(document).ready(function() {
//        GetBannerList();
//    });

    function GetBannerList() {
        bannerMainText = '';
        bannerNavText = '';
        $.ajax({
            type: "POST",
            url: bannerModulePath + "Services/BannerWCFService.svc/GetBannersInfo",
            data: JSON2.stringify({ userModuleID: userModuleId, portalID: portalId, showInActive: false }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                //alert(msg.d.length);
                if (msg.d.length > 0) {
                    BindBannerDetails(msg);
                    AddBannerSlider();
                } else {
                    $("#sageCorpBanner").html("<span class=\"cssclassNoBanner\"> No Banner Images Uploaded Yet! </span>");
                }
            },
            error: function() {
                alert('Failed');
            }
        });
    }

    function BindBannerDetails(response) {
        $.each(response.d, function(index, item) {
            //alert(bannerModulePath + "uploads/" + item.BannerImage);
            BindBannerMain(item);
            BindBannerNav(item);
        });
    }

    function BindBannerMain(item) {
        bannerMainText += "<li><img src=" + bannerModulePath + "uploads/Banners/" + item.BannerImage + " title=" + item.ImageToolTip + " /><div class=\"lof-main-item-desc\"><h3>" + item.Title + " </h3><p>" + item.Description + "</p><div class=\"cssClassReadMore\"><a href=" + item.ReadMorePage + ".aspx" + "><span>" + item.ReadButtonText + "</span></a></div></div></li>";
        $("#bannerMain").html(bannerMainText);
    }

    function BindBannerNav(item) {
        bannerNavText += "<li><h3>" + item.NavigationTitle + "</h3><div><img src=" + bannerModulePath + "uploads/NavigationImages/Large/" + item.NavigationImage + " height=\"280\" width=\"241\"></div></li>";
        $("#bannerNav").html(bannerNavText);
    }

    function AddBannerSlider() {
        $('#sageCorpBanner').lofJSidernews({
            interval: 3000,
            easing: 'easeInOutQuad',
            duration: 1200,
            auto: true
        });
    }

</script>

<div class="container">
    <div id="sageCorpBanner" class="lof-slidecontent">
        <div class="preload">
            <div></div>
        </div>
        <!-- MAIN CONTENT -->
        <div class="lof-main-outer">
            <ul class="lof-main-wapper" id="bannerMain">
              
            </ul>
        </div>
        <!-- END MAIN CONTENT -->
        <!-- NAVIGATOR -->
        <div class="lof-navigator-outer">
            <ul class="lof-navigator" id="bannerNav">
        
            </ul>
        </div>
    </div>
</div>