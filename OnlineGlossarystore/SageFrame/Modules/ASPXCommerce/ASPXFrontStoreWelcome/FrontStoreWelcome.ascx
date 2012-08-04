<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FrontStoreWelcome.ascx.cs"
            Inherits="Modules_ASPXFrontStoreWelcome_FrontStoreWelcome" %>
<script type="text/javascript">
    $(document).ready(function() {
        LoadShoppingStepsImage();
    });

    function LoadShoppingStepsImage() {
        $('#imgMoreImage').attr('src', '' + aspxTemplateFolderPath + '/images/more.png');
    }
</script>
    
<div class="cssClassWelcome">
   
    <div class="cssClassWelcomePicture">
    </div>
    <!--
        <div class="cssClassWelcomeInformation">
            <h2>
                <asp:Label ID="lblDemoHeading" runat="server" CssClass="cssClassWelComeHeading" Text="Welcome to ASPX-Commerce demo store"></asp:Label></h2>
            
            <ul>
            
                <li>DOWNLOAD ASPXCOMMERCE</li>
                <li>UPLOAD & MANAGE PRODUCTS</li>
                <li>MAKE MONEY</li>
            
            </ul>
            <div class="cssClassDownload">
                <a href=""></a></div>
        </div>
            
        <div class="bannerimg">
            
        </div>
            
        <div class="bannerRight">
     
            <p>
                <asp:Label ID="lblDemoText" runat="server" CssClass="cssClassWelComeText" Text="This is a demonstration store powered by ASPX-Commerce shopping cart software. ASPX-Commerce is a full e-commerce solution for small to medium sized businesses."></asp:Label></p>
            <p>
                <asp:Label ID="lblWelcomeInfo" runat="server" CssClass="cssClassWelComeInfo" Text="This is NOT a live store. Please DO NOT enter real credit card details when test
                    ordering from it."></asp:Label>
            </p>
        </div>-->
    
    <div class="cssClassclear">
    </div>
</div>
<%--<div class="cssClassRoundedBox">
    <div class="cssClassLeftTop">
    </div>
    <div class="cssClassRightTop">
    </div>
    <div class="cssClassLeftBtn">
    </div>
    <div class="cssClassRightBtn">
    </div>
    <div class="cssClassRoundedBoxInfo">
        <h1>
            <asp:Label ID="lblDemoHeading" runat="server" CssClass="cssClassWelComeHeading" Text="Welcome to ASPX-Commerce demo store"></asp:Label>
        </h1>
        <div class="cssClassDescription">
            <p>
                <asp:Label ID="lblDemoText" runat="server" CssClass="cssClassWelComeText" Text="This is a demonstration store powered by ASPX-Commerce shopping cart software. ASPX-Commerce is a full e-commerce solution for small to medium sized businesses."></asp:Label></p>
            <p>
                <asp:Label ID="lbl" runat="server" CssClass="cssClassWelComeInfo" Text="This is NOT a live store. Please DO NOT enter real credit card details when test
                    ordering from it."></asp:Label>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>--%>