<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DiscountBar.ascx.cs" Inherits="Modules_ASPXDiscountBanner_DiscountBar" %>
<script type="text/javascript">
    $(document).ready(function() {
        LoadDiscountBarImage();
    });
//    $(window).load(function() {
//        LoadDiscountBarImage();
//    });

    function LoadDiscountBarImage() {
        $('#imgDiscountImage1').attr('src', '' + aspxTemplateFolderPath + '/images/discount.png');
    }
</script>

<div class="cssClassDiscount">
    <div class="cssClassDiscountBox">
        <a href="#">
            <img id="imgDiscountImage1" alt="Discount" /></a></div>
    <div class="cssClassclear">
    </div>
</div>