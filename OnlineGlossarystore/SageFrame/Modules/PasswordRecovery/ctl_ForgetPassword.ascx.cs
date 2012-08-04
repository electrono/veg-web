﻿/*
SageFrame® - http://www.sageframe.com
Copyright (c) 2009-2010 by SageFrame
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
using System.Web.Security;
using System.Data;
using SageFrame.Message;
using SageFrame.Web;
using SageFrame.Framework;
using System.Net.Mail;
using SageFrameClass.MessageManagement;
using SageFrame.SageFrameClass.MessageManagement;

namespace SageFrame.Modules.PasswordRecovery
{
    public partial class ctl_ForgetPassword : BaseAdministrationUserControl
    {
        public string helpTemplate = string.Empty;
        SageFrameConfig pb = new SageFrameConfig();
        bool IsUseFriendlyUrls = true;
        MessageTemplateDataContext dbMessageTemplate = new MessageTemplateDataContext(SystemSetting.SageFrameConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            var template = dbMessageTemplate.sp_MessageTemplateByMessageTemplateTypeID(SystemSetting.PASSWORD_FORGET_HELP, GetPortalID).SingleOrDefault();
            if (template != null)
            {

                helpTemplate = "<b>" + template.Body+ "</b>";
            }
            
            IsUseFriendlyUrls = pb.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);
            if (!IsPostBack)
            {
                
                SetValidatorErrorMessage();          
            }
        }

        private void SetValidatorErrorMessage()
        {
            rfvUsername.ErrorMessage = GetSageMessage("PasswordRecovery", "UserNameIsRequired");
            rfvEmail.ErrorMessage = GetSageMessage("PasswordRecovery", "UserEmailAddressIsRequired");
            revEmail.ErrorMessage = GetSageMessage("PasswordRecovery", "UserEmailAddressIsNotValid");
        }        

        protected void wzdForgetPassword_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            try
            {
                GotoLoginPage();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }
        private void GotoLoginPage()
        {
            string strRedURL = string.Empty;
            if (IsUseFriendlyUrls)
            {
                if (GetPortalID > 1)
                {
                    strRedURL = ResolveUrl("~/portal/" + GetPortalSEOName + "/" + pb.GetSettingsByKey(SageFrameSettingKeys.PlortalLoginpage) + ".aspx");                    
                }
                else
                {
                    strRedURL = ResolveUrl("~/" + pb.GetSettingsByKey(SageFrameSettingKeys.PlortalLoginpage) + ".aspx");                   
                }
            }
            else
            {
                strRedURL = ResolveUrl("~/Default.aspx?ptlid=" + GetPortalID + "&ptSEO=" + GetPortalSEOName + "&pgnm=" + pb.GetSettingsByKey(SageFrameSettingKeys.PlortalLoginpage));
            }
            Response.Redirect(strRedURL, false);
        }
        protected void wzdForgetPassword_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            try
            {
                if (txtEmail.Text != "" && txtUsername.Text != "")
                {
                    MembershipUserCollection userCollection = Membership.FindUsersByEmail(txtEmail.Text);
                    if (userCollection.Count > 0)
                    {
                        MembershipUser user = userCollection[txtUsername.Text];
                        if (user != null)
                        {
                            if (user.IsApproved == true)
                            {
                                var template = dbMessageTemplate.sp_MessageTemplateByMessageTemplateTypeID(SystemSetting.PASSWORD_FORGET_USERNAME_PASSWORD_MATCH, GetPortalID).SingleOrDefault();
                                if (template != null)
                                {
                                    ((Literal)WizardStep2.FindControl("litInfoEmailFinish")).Text = template.Body;
                                }
                                var messageTemplates = dbMessageTemplate.sp_MessageTemplateByMessageTemplateTypeID(SystemSetting.PASSWORD_CHANGE_REQUEST_EMAIL, GetPortalID);
                                foreach (var messageTemplate in messageTemplates)
                                {
                                    MessageTokenDataContext messageTokenDB = new MessageTokenDataContext(SystemSetting.SageFrameConnectionString);
                                    var messageTokenValues = messageTokenDB.sp_GetPasswordRecoveryTokenValue(txtUsername.Text, GetPortalID);
                                    CommonFunction comm = new CommonFunction();
                                    DataTable dtTokenValues = comm.LINQToDataTable(messageTokenValues);
                                    string replaceMessageSubject = MessageToken.ReplaceAllMessageToken(messageTemplate.Subject, dtTokenValues);
                                    string replacedMessageTemplate = MessageToken.ReplaceAllMessageToken(messageTemplate.Body, dtTokenValues);
                                    MailHelper.SendMailNoAttachment(messageTemplate.MailFrom, txtEmail.Text, replaceMessageSubject, replacedMessageTemplate, string.Empty, string.Empty);
                                }
                            }
                            else
                            {
                                ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("PasswordRecovery", "UsernameNotActivated"), "", SageMessageType.Alert);
                                e.Cancel = true;
                            }
                        }
                        else
                        {
                            ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("PasswordRecovery", "UsernameOrEmailAddressDoesnotMatched"), "", SageMessageType.Alert);
                            e.Cancel = true;
                        }
                    }
                    else
                    {
                        ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("PasswordRecovery", "UsernameOrEmailAddressDoesnotMatchedAgain"), "", SageMessageType.Alert);
                        e.Cancel = true;
                    }
                }
                else
                {
                    e.Cancel = true;
                    ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("PasswordRecovery", "PleaseEnterAllTheRequiredFields"), "", SageMessageType.Alert);
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            try
            {
                GotoLoginPage();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

    }
}