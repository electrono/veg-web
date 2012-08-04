<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CustomersManagement.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCustomerManagement_CustomersManagement" %>

<script type="text/javascript">

    var cultureName = '<%= cultureName %>';
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var checkSuccess = '<%= checkIfSucccess %>';
    var refreshValue = '<%= refresh %>';

    $(document).ready(function() {
        if (checkSuccess == 1) {
            BindCustomerDetails();
            HideDiv();
            $("#divCustomerList").show();
        } else {
            HideDiv();
            $("#divAddNewCustomer").show();
            return false;
        }
        LoadCustomerMgmtStaticImage();
        $("#divCustomerList").show();
        $('#btnDeleteSelectedCustomer').click(function() {
            var CustomerIDs = '';
            //Get the multiple Ids of the attribute selected
            $("#gdvCustomerDetails .attrChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    CustomerIDs += $(this).val() + ',';
                }
            });
            if (CustomerIDs != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleCustomer(CustomerIDs, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected attributes?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one attribute before you can do this.<br/> To select one or more attributes, just check the box before each attribute.</p>');
            }
        });
        $("#btnAddNewCustomer").click(function() {
            HideDiv();
            $("#divAddNewCustomer").show();
            ClearForm();
        });
        $("#btnBack").click(function() {
            HideDiv();
            $("#divCustomerList").show();
        });
        if (refreshValue == "True") {
            HideDiv();
            $("#divCustomerList").hide();
            $("#divAddNewCustomer").show();
        }
    });

    function LoadCustomerMgmtStaticImage() {
        $('#ajaxCutomerMgmtImageLoad').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideDiv() {
        $("#divCustomerList").hide();
        $("#divAddNewCustomer").hide();
    }

    function ClearForm() {
        $(".fristName").val('');
        $(".lastName").val('');
        $(".email").val('');
        $(".userName").val('');
        $(".password").val('');
        $(".confirmPassword").val('');
        $(".question").val('');
        $(".answer").val('');
        $(".captchaValue").val('');
        //$(".cssClassCheckBox").removeAttr('checked');        
    }

    function ConfirmDeleteMultipleCustomer(CustomerIDs, event) {
        if (event) {
            DeleteMultipleCustomer(CustomerIDs, storeId, portalId, userName);
        }
    }

    function DeleteMultipleCustomer(_CustomerIDs, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { CustomerIDs: _CustomerIDs, storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteMultipleCustomersByCustomerID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindCustomerDetails();
            }
        });
        return false;
    }

    function DeleteCustomers(tblID, argus) {
        switch (tblID) {
        case "gdvCustomerDetails":
            if (argus[3].toLowerCase() != "yes") {
                DeleteCustomer(argus[0], storeId, portalId, userName);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t delete yourself.</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeleteCustomer(_customerid, _storeId, _portalId, _userName) {
        var properties = {
            onComplete: function(e) {
                ConfirmSingleDelete(_customerid, _storeId, _portalId, _userName, e);
            }
        }
        // Ask user's confirmation before delete records        
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this attribute?</p>", properties);
    }

    function ConfirmSingleDelete(_customerid, _storeId, _portalId, _userName, event) {
        if (event) {
            DeleteSingleCustomer(_customerid, _storeId, _portalId, _userName);
        }
        return false;
    }

    function DeleteSingleCustomer(_customerid, _storeId, _portalId, _userName) {
        //Pass the selected attribute id and other parameters
        var params = { customerId: parseInt(_customerid), storeId: _storeId, portalId: _portalId, userName: _userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCustomerByCustomerID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindCustomerDetails();
                $('#divAttribForm').hide();
                $('#divAttribGrid').show();
            }
        });
    }

    function BindCustomerDetails() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCustomerDetails_pagesize").length > 0) ? $("#gdvCustomerDetails_pagesize :selected").text() : 10;
        $("#gdvCustomerDetails").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCustomerDetails',
            colModel: [
                { display: 'Customer ID', name: 'Customer_ID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '5', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'Customer Name', name: 'Customer_Name', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Culture Name', name: 'Culture_Name', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'AddedOn', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'UpdatedOn', name: 'UpdatedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'is Same User', name: 'is_same_user', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCustomers', arguments: '5' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, CultureName: cultureName, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 6: { sorter: false } }
        });
    }

</script>
<div id="divCustomerList">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrGridHeading" runat="server" Text="Customer Details"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnAddNewCustomer">
                            <span><span>Add New Customer</span></span>
                        </button>
                    </p>
                    <p>
                        <button type="button" id="btnDeleteSelectedCustomer">
                            <span><span>Delete All Selected</span> </span>
                        </button>
                    </p>
                    <div class="cssClassClear">
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="loading">
                    <img id="ajaxCutomerMgmtImageLoad" />
                </div>
                <div class="log">
                </div>
                <table id="gdvCustomerDetails" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div></div>

<div id="divAddNewCustomer">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblCustomerHeading" runat="server" Text="Add New Customer"></asp:Label>
            </h2>
        </div>
        <div class="cssClassUserRegistrationPage">
            <div class="cssClassUserRegistration" >
                <div class="cssClassFormWrapper">
                    <div id="divRegistration" runat="server">
                        <div class="cssClassRegistrationInformation">
                            <%= headerTemplate %>
                        </div>
                        <span class="cssClassRequired">Fields mark with <b>*</b> are compulsory. </span>
                        <div class="cssClassUserRegistrationInfoLeft">
                            <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td colspan="2">
                                        <h3>
                                            User Info</h3>
                                    </td>
                                </tr>
                                <tr>
                                    <td width="270">
                                        <asp:Label ID="FirstNameLabel" runat="server" AssociatedControlID="FirstName" CssClass="cssClassFormLabel">First Name: </asp:Label><span
                                                                                                                                                                               class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="FirstName" runat="server" CssClass="cssClassNormalTextBox fristName"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="FirstName"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                        </p>
                                    </td>
                                    <td>
                                        <asp:Label ID="LastNameLabel" runat="server" AssociatedControlID="LastName" CssClass="cssClassFormLabel">Last Name:</asp:Label><span
                                                                                                                                                                           class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="LastName" runat="server" CssClass="cssClassNormalTextBox lastName"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="LastName"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Label ID="EmailLabel" runat="server" AssociatedControlID="Email" CssClass="cssClassFormLabel">E-mail:</asp:Label>
                                        <span class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBgBig">
                                            <asp:TextBox ID="Email" runat="server" CssClass="cssClassNormalTextBox email"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvEmailRequired" runat="server" ControlToValidate="Email"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="Email"
                                                                            SetFocusOnError="true" ErrorMessage="*" ValidationGroup="CreateUserWizard1" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                            CssClass="cssClasssNormalRed"></asp:RegularExpressionValidator>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <h3>
                                            Create Login</h3>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName" CssClass="cssClassFormLabel">User Name:</asp:Label><span
                                                                                                                                                                           class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="UserName" runat="server" CssClass="cssClassNormalTextBox userName"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvUserNameRequired" runat="server" ControlToValidate="UserName"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                        </p>
                                    </td>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password" CssClass="cssClassFormLabel">Password:</asp:Label><span
                                                                                                                                                                          class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="Password" runat="server" TextMode="Password" CssClass="cssClassNormalTestBox password"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPasswordRequired" runat="server" ControlToValidate="Password"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Password must be atleast of 4 character.."
                                                                            ControlToValidate="Password" ValidationGroup="CreateUserWizard1" ValidationExpression=".{4,}">*</asp:RegularExpressionValidator>
                                        </p>
                                    </td>
                                    <td>
                                        <asp:Label ID="ConfirmPasswordLabel" runat="server" AssociatedControlID="ConfirmPassword"
                                                   CssClass="cssClassFormLabel">Confirm Password:</asp:Label><span class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="ConfirmPassword" runat="server" TextMode="Password" CssClass="cssClassNormalTextBox confirmPassword"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvConfirmPasswordRequired" runat="server" ControlToValidate="ConfirmPassword"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvPasswordCompare" runat="server" ControlToCompare="Password"
                                                                  ControlToValidate="ConfirmPassword" Display="Dynamic" ErrorMessage="*" ValidationGroup="CreateUserWizard1"
                                                                  CssClass="cssClasssNormalRed"></asp:CompareValidator>
                                        </p>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="QuestionLabel" runat="server" AssociatedControlID="Question" CssClass="cssClassFormLabel">Security Question:</asp:Label><span
                                                                                                                                                                                   class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="Question" runat="server" CssClass="cssClassNormalTextBox question"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvQuestionRequired" runat="server" ControlToValidate="Question"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                        </p>
                                    </td>
                                    <td>
                                        <asp:Label ID="AnswerLabel" runat="server" AssociatedControlID="Answer" CssClass="cssClassFormLabel">Security Answer:</asp:Label><span
                                                                                                                                                                             class="cssClassrequired">*</span>
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="Answer" runat="server" CssClass="cssClassNormalTextBox answer"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvAnswerRequired" runat="server" ControlToValidate="Answer"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                        </p>
                                    </td>
                                </tr>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <tr>
                                            <td>
                                                <asp:Label ID="CaptchaLabel" runat="server" Text="Captcha:" AssociatedControlID="CaptchaImage"
                                                           CssClass="cssClassFormLabel"></asp:Label><span id="captchaValidator" runat="server" class="cssClassrequired">*</span>
                                                <p>
                                                    <asp:Image ID="CaptchaImage" runat="server" />
                                                    <asp:ImageButton ID="Refresh" runat="server" OnClick="Refresh_Click" ValidationGroup="Sep" /></p>
                                            </td>
                                            <td>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                        <td>
                                        <asp:Label ID="DataLabel" runat="server" Text="Enter Data Shown Above:" AssociatedControlID="CaptchaValue"
                                                   CssClass="cssClassFormLabel"></asp:Label>
                           
                                        <p class="cssClassRegisterInputBg">
                                            <asp:TextBox ID="CaptchaValue" runat="server" CssClass="cssClassNormalTextBox captchaValue"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCaptchaValueValidator" runat="server" ControlToValidate="CaptchaValue" Display="Dynamic"
                                                                        ErrorMessage="*" ValidationGroup="CreateUserWizard1" CssClass="cssClasssNormalRed"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvCaptchaValue" runat="server" Display="Static" ErrorMessage="*"
                                                                  ValidationGroup="CreateUserWizard1" ControlToValidate="CaptchaValue" ValueToCompare="121"
                                                                  CssClass="cssClasssNormalRed"></asp:CompareValidator></p>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                                <td>
                                    &nbsp;
                                </td>
                            </tr>                 
                            </table>
                        </div>
                        <br />
                        <asp:CheckBox ID="chkIsSubscribeNewsLetter" runat="server" CssClass="cssClassCheckBox" />
                        <asp:Label ID="lblIsSubscribeNewsLetter" runat="server" Text="Subscribe Newsletter:"
                                   AssociatedControlID="CaptchaValue" CssClass="cssClassFormLabel"></asp:Label>
           
                        <br />
                        <div class="cssClassButtonWrapper">
                            <p>
                                <asp:Button ID="FinishButton" runat="server" AlternateText="Finish" 
                                            BorderStyle="None" CausesValidation="True" ValidationGroup="CreateUserWizard1"
                                            CommandName="MoveComplete" CssClass="cssClassButtonSubmit" Text="Register" OnClick="FinishButton_Click" />
                            </p>
                            <p>
                                <button type="button" id="btnBack">
                                    <span><span>Back</span></span>
                                </button>
                            </p>
                        </div>
            
                    </div>
                    <%--<div id="divRegConfirm" class="cssClassRegConfirm" runat="server">
                <h3>
                    Registration Successful</h3>
                <asp:Label ID="lblRegSuccess" runat="server" CssClass="cssClassFormLabel">
                 <asp:Literal ID="USER_RESISTER_SUCESSFUL_INFORMATION" runat="server" meta:resourcekey="USER_RESISTER_SUCESSFUL_INFORMATIONResource1"></asp:Literal>            
                 </asp:Label>
              <div class="cssClassButtonWrapper">                   
                    <span><a href='<%=LoginPath%>'>Go To Login Page</a></span>
                </div>
            </div>--%>
                </div>
            </div>
        </div>
    </div>
</div>