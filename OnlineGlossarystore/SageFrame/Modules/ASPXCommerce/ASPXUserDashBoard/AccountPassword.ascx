<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AccountPassword.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXUserDashBoard_AccountPassword" %>

<script type="text/javascript">
    $(document).ready(function() {
        $('#txtConfirmPassword').change(function() {
            if ($("#txtNewPassword").val() != $("#txtConfirmPassword").val()) {
                $('#lblnotification').html('Password does not matched.');

            } else {
                $('#lblnotification').html('');
            }
        });

        $('#btnSubmitPassword').click(function() {
            var d = $("#form1").validate({
                rules: {
                    Password: { required: true },
                    ConfirmPassword: { required: true }
                }
            });
            if (d.form()) {
                if ($("#txtNewPassword").val() == $("#txtConfirmPassword").val()) {
                    UpdateUserPassword();
                    return false;
                }
            }

        });
    });

    function UpdateUserPassword() {
        var newPassword = $("#txtNewPassword").val();
        var retypePassword = $("#txtConfirmPassword").val();
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, newPassword: newPassword, retypePassword: retypePassword });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/ChangePassword",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {

                if (data.d) {
                    $("#txtNewPassword").val('');
                    $("#txtConfirmPassword").val('');
                    //$('#lblnotification').html('<br/> Password changed successfully.');
                    csscody.alert("<h2>Information Message</h2><p>Password changed successfully.</p>");
                } else {
                    //alert("Error While Changing Password");
                    csscody.error('<h1>Error Message</h1><p>Error While Changing Password</p>');
                }
            },
            error: function() {
                //alert("Error!");
                csscody.error('<h1>Error Message</h1><p>Error Occured!!</p>');
            }
        });
        return false;
    }
</script>

<div class="cssClassFormWrapper">
    <div class="cssClassHeading">
        <h1>
            <asp:Label ID="lblAccountTitle" runat="server" Text="Change Password"></asp:Label>
        </h1>
        <div class="cssClassClear">
        </div>
    </div>
    <table id="tblAccountPassword" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
                <td width="20%">
                    <asp:Label ID="lblPassword" runat="server" Text="New Password" CssClass="cssClassLabel"></asp:Label>
                    <span class="cssClassRequired">*</span>
                </td>
                <td width="80%">
                    <input type="password" id="txtNewPassword" name="Password" class="required" minlength="4"  />
                </td>
                <%--   <td>
                    <div class="password-meter">
                        <div class="password-meter-message">
                        </div>
                        <div class="password-meter-bg">
                            <div class="password-meter-bar">
                            </div>
                        </div>
                    </div>
                </td>--%>
                
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lbRetypePassword" runat="server" Text="Confirm Password:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                                      class="cssClassRequired">*</span>
                </td>
                <td>
                    <input type="password" id="txtConfirmPassword" name="ConfirmPassword" class="required" /><label id='lblnotification' style ="color: #FF0000;"></label>
                </td>
            </tr>
           
        </tbody>
    </table>
    <div class="cssClassButtonWrapper">
        <button type="button" name="btnSubmitPassword" id="btnSubmitPassword" class="cssClassButtonSubmit">
            <span><span>Save Password</span></span></button>
    </div>
</div>