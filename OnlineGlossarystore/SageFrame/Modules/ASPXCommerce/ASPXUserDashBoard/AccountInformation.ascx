<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AccountInformation.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXUserDashBoard_AccountInformation" %>

<script type="text/javascript">
    $(document).ready(function() {
        // $("#form1").attr("onSubmit", "return false");

        $("#txtFirstName").val(userFirstName);
        $("#txtLastName").val(userLastName);
        $("#txtEmailAddress").val(userEmail);

        var v = $("#form1").validate({
            rules: {
                FirstName: "required",
                LastName: "required",

                Email: {
                    required: true,
                    email: true
                }
            },
            messages: {
                FirstName: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                LastName: {
                    required: '*',
                    minlength: "* (at least 2 chars)"
                },
                Email: {
                    required: '*',
                    email: '*'
                }
            }
        });
        $('#btnSubmitInformation').click(function() {
            if (v.form()) {
                UpdateCustomerInformation();
                return false;
            } else {
                return false;
            }
        });
    });

    function UpdateCustomerInformation() {
        var customerFirstName = $("#txtFirstName").val();
        var customerLastName = $("#txtLastName").val();
        var customerEmail = $("#txtEmailAddress").val();
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, customerID: customerId, userName: userName, firstName: customerFirstName, lastName: customerLastName, email: customerEmail });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateCustomer",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if (data.d == 1) {
                    // alert("Email Address Should Be Unique");
                    csscody.alert("<h2>Information Message</h2><p>Email Address Should Be Unique.</p>");

                } else if (data.d == -1) {
                    //alert("Update Could Not Successed");
                    csscody.error('<h1>Error Message</h1><p>Update Could Not Successed</p>');
                } else {
                    //alert("Customer Information Updated Successfully");
                    csscody.alert("<h2>Information Message</h2><p>Customer Information Updated Successfully.</p>");
                }
            }
//            ,
//            error: function() {
//                alert("Error!");
//            }
        });
        return false;
    }
</script>

<div class="cssClassFormWrapper">
    <div class="cssClassHeading">
        <h1>
            <asp:Label ID="lblAddressTitle" runat="server" Text="Account Information"></asp:Label>
        </h1>
        <div class="cssClassClear">
        </div>
    </div>
    <table id="tblNewAddress" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tbody>
            <tr>
                <td width="20%">
                    <asp:Label ID="lblFirstName" runat="server" Text="FirstName" CssClass="cssClassLabel"></asp:Label>
                    <span class="cssClassRequired">*</span>
                </td>
                <td width="80%">
                    <input type="text" id="txtFirstName" name="FirstName" class="required" minlength="2" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblLastName" runat="server" Text="LastName:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                         class="cssClassRequired">*</span>
                </td>
                <td>
                    <input type="text" id="txtLastName" name="LastName" class="required" minlength="2" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="cssClassLabel"></asp:Label><span
                                                                                                                   class="cssClassRequired">*</span>
                </td>
                <td>
                    <input type="text" id="txtEmailAddress" name="Email" class="required email" minlength="2" />
                </td>
            </tr>
        </tbody>
    </table>
    <div class="cssClassButtonWrapper">
        <button type="submit" name="btnSubmit" id="btnSubmitInformation" class="cssClassButtonSubmit">
            <span><span>Save</span></span></button>
    </div>
</div>