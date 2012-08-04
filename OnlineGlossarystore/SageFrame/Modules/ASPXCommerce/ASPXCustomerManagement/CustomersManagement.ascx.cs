﻿/*
AspxCommerce® - http://www.aspxcommerce.com
Copyright (c) 20011-2012 by AspxCommerce
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using SageFrame.Security;
using SageFrame.Message;
using SageFrame.Security.Entities;
using System.Web.Security;
using SageFrame.Security.Helpers;
using SageFrame.Security.Providers;
using SageFrame.NewLetterSubscriber;
using System.Data;
using SageFrameClass.MessageManagement;
using SageFrame.SageFrameClass.MessageManagement;
using System.Drawing.Imaging;

public partial class Modules_ASPXCommerce_ASPXCustomerManagement_CustomersManagement : BaseAdministrationUserControl
{
    public int storeID, portalID;
    public string userName, cultureName;
    public string headerTemplate = string.Empty;
    private Random random = new Random();
    MessageTokenDataContext messageTokenDB = new MessageTokenDataContext(SystemSetting.SageFrameConnectionString);
    SageFrameConfig pagebase = new SageFrameConfig();
    MembershipController _member = new MembershipController();
    public int checkIfSucccess = 1;
    public bool refresh = false;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            storeID = GetStoreID;
            portalID = GetPortalID;
            userName = GetUsername;
            cultureName = GetCurrentCultureName;
            if (!IsPostBack)
            {
                MessageTemplateDataContext dbMessageTemplate = new MessageTemplateDataContext(SystemSetting.SageFrameConnectionString);
                var template = dbMessageTemplate.sp_MessageTemplateByMessageTemplateTypeID(SystemSetting.USER_REGISTRATION_HELP, GetPortalID).SingleOrDefault();
                if (template != null)
                {
                    headerTemplate = "<div>" + template.Body + "</div>";
                }

                if (_member.EnableCaptcha)
                {
                    InitializeCaptcha();
                }
                else { HideCaptcha(); }
                SetValidatorErrorMessage();
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalTemplateFolderPath", " var aspxTemplateFolderPath='" + ResolveUrl("~/") + "Templates/" + TemplateName + "';", true);
        try
        {
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalServicePath", " var aspxservicePath='" + ResolveUrl("~/") + "Modules/ASPXCommerce/ASPXCommerceServices/" + "';", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalTemplateFolderPath", " var aspxTemplateFolderPath='" + ResolveUrl("~/") + "Templates/" + TemplateName + "';", true);
            InitializeJS();
            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
            foreach (string css in cssList)
            {
                strTemplatePath = css;
                IncludeCssFile(strTemplatePath);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
    }
	
    private void InitializeCaptcha()
    {
        CaptchaValue.Text = "";
        this.Session["CaptchaImageText"] = GenerateRandomCode();
        cvCaptchaValue.ValueToCompare = this.Session["CaptchaImageText"].ToString();
        CaptchaImage.ImageUrl = "~/CaptchaImageHandler.aspx";
        Refresh.ImageUrl = GetTemplateImageUrl("imgrefresh.png", true);
        CaptchaImage.Visible = true;
        CaptchaLabel.Visible = true;
        CaptchaValue.Visible = true;
        captchaValidator.Visible = false;
        Refresh.Visible = true;
        DataLabel.Visible = true;
        rfvCaptchaValueValidator.Enabled = true;
    }
	
    private void HideCaptcha()
    {
        CaptchaImage.Visible = false;
        CaptchaLabel.Visible = false;
        CaptchaValue.Visible = false;
        Refresh.Visible = false;
        DataLabel.Visible = false;
        rfvCaptchaValueValidator.Enabled = false;
        captchaValidator.Visible = false;
    }

    private void SetValidatorErrorMessage()
    {
        rfvUserNameRequired.Text = "*";
        rfvPasswordRequired.Text = "*";
        rfvConfirmPasswordRequired.Text = "*";
        rfvFirstName.Text = "*";
        rfvLastName.Text = "*";
        rfvEmailRequired.Text = "*";
        rfvQuestionRequired.Text = "*";
        rfvAnswerRequired.Text = "*";
        rfvCaptchaValueValidator.Text = "*";
        cvPasswordCompare.Text = "*";
        cvCaptchaValue.Text = GetSageMessage("UserRegistration", "EnterTheCorrectCapchaCode");
        revEmail.Text = "*";
        rfvUserNameRequired.ErrorMessage = GetSageMessage("UserRegistration", "UserNameIsRequired");
        rfvPasswordRequired.ErrorMessage = GetSageMessage("UserRegistration", "PasswordIsRequired");
        rfvConfirmPasswordRequired.ErrorMessage = GetSageMessage("UserRegistration", "PasswordConfirmIsRequired");
        rfvFirstName.ErrorMessage = GetSageMessage("UserRegistration", "FirstNameIsRequired");
        rfvLastName.ErrorMessage = GetSageMessage("UserRegistration", "LastNameIsRequired");
        rfvEmailRequired.ErrorMessage = GetSageMessage("UserRegistration", "EmailAddressIsRequired");
        rfvQuestionRequired.ErrorMessage = GetSageMessage("UserRegistration", "SecurityQuestionIsRequired");
        rfvAnswerRequired.ErrorMessage = GetSageMessage("UserRegistration", "SecurityAnswerIsRequired");
        rfvCaptchaValueValidator.ErrorMessage = GetSageMessage("UserRegistration", "EnterTheCorrectCapchaCode");
        cvPasswordCompare.ErrorMessage = GetSageMessage("UserRegistration", "PasswordRetypeMatch");
        cvCaptchaValue.ErrorMessage = GetSageMessage("UserRegistration", "EnterTheCorrectCapchaCode");
        revEmail.ErrorMessage = GetSageMessage("UserRegistration", "EmailAddressIsNotValid");
    }

    protected void Refresh_Click(object sender, EventArgs e)
    {
        refresh = true;
        GenerateCaptchaImage();                 
        //try
        //{
        //    this.Session["CaptchaImageText"] = GenerateRandomCode();
        //    cvCaptchaValue.ValueToCompare = this.Session["CaptchaImageText"].ToString();
        //    CaptchaImage.ImageUrl = "../../../CaptchaImageHandler.aspx?=dummy" + DateTime.Now.ToLongTimeString();
        //    CaptchaValue.Text = "";
        //}
        //catch (Exception ex)
        //{
        //    ProcessException(ex);
        //}
    }

    private void GenerateCaptchaImage()
    {
        try
        {
            this.Session["CaptchaImageText"] = GenerateRandomCode();
            cvCaptchaValue.ValueToCompare = this.Session["CaptchaImageText"].ToString();
            CaptchaImage.ImageUrl = ResolveUrl("~") +"CaptchaImageHandler.aspx?=dummy" + DateTime.Now.ToLongTimeString();
            CaptchaValue.Text = "";
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private string GenerateRandomCode()
    {
        string s = "";
        string[] CapchaValue = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9" };
        for (int i = 0; i < 6; i++)
            s = String.Concat(s, CapchaValue[this.random.Next(36)]);
        return s;
    }


    protected void FinishButton_Click(object sender, EventArgs e)
    {
        this.Session["CaptchaImageText"] = null;
        if (_member.EnableCaptcha)
        {
            if (ValidateCaptcha())
            {
                RegisterUser();
            }
        }
        else
        {
            RegisterUser();
        }
        GenerateCaptchaImage();
    }

    private bool ValidateCaptcha()
    {
        if (!(cvCaptchaValue.ValueToCompare == CaptchaValue.Text))
        {
            ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("UserRegistration", "EnterTheCorrectCapchaCode"), "", SageMessageType.Error);
            return false;
        }

        return true;
    }

    private void RegisterUser()
    {
        try
        {
            MessageTemplateDataContext dbMessageTemplate = new MessageTemplateDataContext(SystemSetting.SageFrameConnectionString);

            if (string.IsNullOrEmpty(UserName.Text) || string.IsNullOrEmpty(FirstName.Text) || string.IsNullOrEmpty(LastName.Text) || string.IsNullOrEmpty(Email.Text))
            {
                ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("UserRegistration", "PleaseEnterAllRequiredFields"), "", SageMessageType.Alert);
                checkIfSucccess = 0;
            }
            else
            {
                int UserRegistrationType = pagebase.GetSettingIntByKey(SageFrameSettingKeys.PortalUserRegistration);

                bool isUserActive = UserRegistrationType == 2 ? true : false;

                UserInfo objUser = new UserInfo();
                objUser.ApplicationName = Membership.ApplicationName;
                objUser.FirstName = FirstName.Text;
                objUser.UserName = UserName.Text;
                objUser.LastName = LastName.Text;
                string Pwd, PasswordSalt;
                PasswordHelper.EnforcePasswordSecurity(_member.PasswordFormat, Password.Text, out Pwd, out PasswordSalt);
                objUser.Password = Pwd;
                objUser.PasswordSalt = PasswordSalt;
                objUser.Email = Email.Text;
                objUser.SecurityQuestion = Question.Text;
                objUser.SecurityAnswer = Answer.Text;
                objUser.IsApproved = true;
                objUser.CurrentTimeUtc = DateTime.Now;
                objUser.CreatedDate = DateTime.Now;
                objUser.UniqueEmail = 0;
                objUser.PasswordFormat = _member.PasswordFormat;
                objUser.PortalID = GetPortalID;
                objUser.AddedOn = DateTime.Now;
                objUser.AddedBy = GetUsername;
                objUser.UserID = Guid.NewGuid();
                objUser.RoleNames = SystemSetting.REGISTER_USER_ROLENAME;
                objUser.StoreID = GetStoreID;
                objUser.CustomerID = 0;

                UserCreationStatus status = new UserCreationStatus();
                CheckRegistrationType(UserRegistrationType, ref objUser);

                MembershipDataProvider.CreatePortalUser(objUser, out status, UserCreationMode.REGISTER);
                if (status == UserCreationStatus.DUPLICATE_USER)
                {
                    ShowMessage(SageMessageTitle.Notification.ToString(), UserName.Text.Trim() + " " + GetSageMessage("UserManagement", "NameAlreadyExists"), "", SageMessageType.Alert);
                    checkIfSucccess = 0;

                }
                else if (status == UserCreationStatus.DUPLICATE_EMAIL)
                {
                    ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("UserManagement", "EmailAddressAlreadyIsInUse"), "", SageMessageType.Alert);
                    checkIfSucccess = 0;

                }
                else if (status == UserCreationStatus.SUCCESS)
                {
                    MembershipUser userInfo = Membership.GetUser(UserName.Text);
                    if (chkIsSubscribeNewsLetter.Checked)
                    {
                        int? newID = 0;
                        ManageNewsLetterSubscription(Email.Text, ref newID);
                    }
                    ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("UserManagement", "UserCreatedSuccessfully"), "", SageMessageType.Success);
                    checkIfSucccess = 1;
                    //HandlePostRegistration(UserRegistrationType, dbMessageTemplate);
                }
            }
        }

        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void ManageNewsLetterSubscription(string email, ref int? newID)
    {
        NewLetterSubscriberDataContext dbNewLetterSubscribe = new NewLetterSubscriberDataContext(SystemSetting.SageFrameConnectionString);
        string clientIP = Request.UserHostAddress.ToString();
        dbNewLetterSubscribe.sp_NewLetterSubscribersAdd(ref newID, email, clientIP, true, GetUsername, DateTime.Now, GetPortalID);
    }

    private void CheckRegistrationType(int UserRegistrationType, ref UserInfo user)
    {
        switch (UserRegistrationType)
        {
            case 0:
                break;
            case 1:
                user.IsApproved = false;
                break;
            case 2:
                user.IsApproved = true;
                break;
            case 3:
                user.IsApproved = false;
                break;
        }
    }

    private void LogInPublicModeRegistration()
    {
        string strRoles = string.Empty;
        MembershipController member = new MembershipController();
        RoleController role = new RoleController();
        UserInfo user = member.GetUserDetails(GetPortalID, UserName.Text);

        if (!(string.IsNullOrEmpty(UserName.Text) && string.IsNullOrEmpty(Password.Text)))
        {
            if (PasswordHelper.ValidateUser(user.PasswordFormat, Password.Text, user.Password, user.PasswordSalt))
            {
                string userRoles = role.GetRoleNames(user.UserName, GetPortalID);
                strRoles += userRoles;
                if (strRoles.Length > 0)
                {
                    SetUserRoles(strRoles);
                    SessionTracker sessionTracker = (SessionTracker)Session["Tracker"];
                    sessionTracker.PortalID = GetPortalID.ToString();
                    sessionTracker.Username = UserName.Text;
                    Session["Tracker"] = sessionTracker;
                    SageFrame.Web.SessionLog SLog = new SageFrame.Web.SessionLog();
                    SLog.SessionTrackerUpdateUsername(sessionTracker, sessionTracker.Username, GetPortalID.ToString());
                    {
                        FormsAuthentication.SetAuthCookie(UserName.Text, true);
                        bool IsUseFriendlyUrls = pagebase.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);
                        if (IsUseFriendlyUrls)
                        {
                            if (GetPortalID > 1)
                            {
                                Response.Redirect(ResolveUrl("~/portal/" + GetPortalSEOName + "/" + pagebase.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage) + ".aspx"), false);
                            }
                            else
                            {
                                Response.Redirect(ResolveUrl("~/" + pagebase.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage) + ".aspx"), false);
                            }
                        }
                        else
                        {
                            Response.Redirect(ResolveUrl("~/Default.aspx?ptlid=" + GetPortalID + "&ptSEO=" + GetPortalSEOName + "&pgnm=" + pagebase.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage)), false);
                        }

                    }
                }

            }

        }
    }

    public void SetUserRoles(string strRoles)
    {
        Session["SageUserRoles"] = strRoles;
        HttpCookie cookie = HttpContext.Current.Request.Cookies["SageUserRolesCookie"];
        if (cookie == null)
        {
            cookie = new HttpCookie("SageUserRolesCookie");
        }
        cookie["SageUserRolesProtected"] = strRoles;
        HttpContext.Current.Response.Cookies.Add(cookie);
    }
   
}
