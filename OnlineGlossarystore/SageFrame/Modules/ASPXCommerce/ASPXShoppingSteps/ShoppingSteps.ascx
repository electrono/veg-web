<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShoppingSteps.ascx.cs"
            Inherits="Modules_ASPXShoppingSteps_ShoppingSteps" %>
<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var customerId = '<%= customerID %>';
    var sessionCode = '<%= sessionCode %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);

    $(document).ready(function() {
        LoadShoppingStepsImage();
        if (userFriendlyURL) {
            $("#lnkStoreLocator").attr("href", '' + aspxRedirectPath + 'Store-Locator-Front.aspx');
        } else {
            $("#lnkStoreLocator").attr("href", '' + aspxRedirectPath + 'Store-Locator-Front');
        }
    });

    function LoadShoppingStepsImage() {
        $('#imgAdvertise').attr('src', '' + aspxTemplateFolderPath + '/images/body-buttom-advertise.jpg');
        $("#imgDelivery").attr('src', '' + aspxTemplateFolderPath + '/images/free-delivery.jpg');
        $("#imgFestiveldeals").attr('src', '' + aspxTemplateFolderPath + '/images/festivedeals.jpg');
        $("#imgStoreLocator").attr('src', '' + aspxTemplateFolderPath + '/images/store-locator.jpg');
    }
</script>

<div class="cssClassBottomContent">
    <div class="cssClassBottomWrapperBox">
        <a href="#">
            <img id="imgAdvertise"  alt="Online Shopping" /></a></div>
    <div class="cssClassBottomWrapperBox">
        <a href="#">
            <img id="imgDelivery" alt="Free Delivery" /></a></div>
    <div class="cssClassBottomWrapperBox">
        <a href="#">
            <img id="imgFestiveldeals" alt="Online Shopping" /></a></div>
    <div class="cssClassBottomWrapperBox cssClassRemoveMargin">
        <a href="#" id="lnkStoreLocator">
            <img id="imgStoreLocator"  alt="Online Shopping" /></a></div>
    <div class="cssClassclear">
    </div>
</div>