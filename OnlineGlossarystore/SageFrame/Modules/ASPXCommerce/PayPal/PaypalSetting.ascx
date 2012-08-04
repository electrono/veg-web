<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PaypalSetting.ascx.cs"
            Inherits="Modules_PaymentGatewayManagement_PaypalSetting" %>

<script type="text/javascript">
  //  var storeId = '<%= storeID %>';
  // var portalId = '<%= portalID %>';
  //  var userName = '<%= username %>';
   // var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        $("#btnSavePaypalSetting").click(function() {
            SaveUpdatePayPalSetting();
        });
    });

    function LoadPaymentGatewaySetting(id, PopUpID) {
        var paymentGatewayId = id;
        var param = JSON2.stringify({ paymentGatewayID: paymentGatewayId, storeId: storeId, portalId: portalId });
        $.ajax({
            type: "POST",
            url: '<%= aspxPaymentModulePath %>' + "Services/PayPalWebService.asmx/GetAllPayPalSetting",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, item) {
                    $("#txtReturnUrl").val(item.ReturnUrl);
                    $("#txtCancelUrl").val(item.CancelUrl);
                    $("#txtBusinessAccount").val(item.BusinessAccount);
                    $("#txtVerificationUrl").val(item.VerificationUrl);
                    $("#txtAuthenticationToken").val(item.AuthToken);
                    $("#chkIsTest").attr('checked', Boolean.parse(item.IsTestPaypal));
                });
                ShowPopupControl(PopUpID);
                $(".cssClassClose").click(function() {
                    $('#fade, #popuprel2').fadeOut();
                });
            },
            error: function() {
                alert("Error!");
            }
        });
    }

    function SaveUpdatePayPalSetting() {
        var paymentGatewaySettingValueID = 0;
        var paymentGatewayID = $("#hdnPaymentGatewayID").val();

        var settingKey = '';
        settingKey += 'ReturnUrl' + "#" + 'CancelUrl' + "#" + 'BusinessAccount' + "#" + 'VerificationUrl' + "#" + 'AuthToken' + "#" + 'IsTestPaypal';
        var settingValue = '';
        settingValue += $("#txtReturnUrl").val() + '#' + $("#txtCancelUrl").val() + "#" + $("#txtBusinessAccount").val() + "#" + $("#txtVerificationUrl").val() + "#" + $("#txtAuthenticationToken").val() + "#" + $("#chkIsTest").attr('checked');
        var isActive = true;
        var param = JSON2.stringify({ paymentGatewaySettingValueID: paymentGatewaySettingValueID, paymentGatewayID: paymentGatewayID, settingKeys: settingKey, settingValues: settingValue, isActive: isActive, storeId: storeId, portalId: portalId, updatedBy: userName, addedBy: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdatePaymentGateWaySettings",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                alert("Setting Saved Successfully");
                $('#fade, #popuprel2').fadeOut();
            },
            error: function() {
                alert("Error!");
            }
        });
    }
</script>


<div class="cssClassCloseIcon">
    <button type="button" class="cssClassClose">
        <span>Close</span></button>
</div>
<h2>
    <asp:Label ID="lblTitle" runat="server" Text="Paypal Setting Information"></asp:Label>
</h2>
<div class="cssClassFormWrapper">
    <table cellspacing="0" cellpadding="0" border="0" width="100%">
        <tr>
            <td>
                <asp:Label ID="lblReturnUrl" runat="server" Text="Return Url:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="text" id="txtReturnUrl" class="cssClassNormalTextBox">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblCancelUrl" runat="server" Text="Cancel Url:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="text" class="cssClassNormalTextBox" id="txtCancelUrl">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblBusinessAccount" runat="server" Text="Business Account:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="text" class="cssClassNormalTextBox" id="txtBusinessAccount">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblVerificationUrl" runat="server" Text="Verification Url:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="text" class="cssClassNormalTextBox" id="txtVerificationUrl">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblAuthenticationToken" runat="server" Text="Authentication Token:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="text" class="cssClassNormalTextBox" id="txtAuthenticationToken">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblIsTest" runat="server" Text="Is Test:" CssClass="cssClassLabel"></asp:Label>
            </td>
            <td class="cssClassGridRightCol">
                <input type="checkbox" id="chkIsTest" class="cssClassCheckBox" />
            </td>
        </tr>
    </table>
    <div class="cssClassButtonWrapper">
        <p>
            <button id="btnSavePaypalSetting" type="button">
                <span><span>Save</span></span></button>
        </p>
    </div>
</div>