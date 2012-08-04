/*
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
using SageFrame.Web;
using SageFrame.SageFrameClass;
using SageFrame.FAQs;
using Microsoft.VisualBasic;

namespace SageFrame.Modules.Admin.FAQs
{
    public partial class FAQSettings : BaseAdministrationUserControl
    {
        FAQsDataContext dbFAQs = new FAQsDataContext(SystemSetting.SageFrameConnectionString);
        public static Int32 usermoduleID = 0;
        System.Nullable<Int32> _faqsSettingValueID = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                usermoduleID = Int32.Parse(SageUserModuleID);
                if (!IsPostBack)
                {
                    AddImageUrls();
                    BindDefaultSorting();
                    BindAvailableTokens();
                    BindData();
                    imgAddQuestionToken.Attributes.Add("onclick", string.Format("return InsertText('{0}','{1}')", ddlAvailableQuestionTokens.ClientID, txtQuestionTemplate.ClientID));
                    imgAddAnswerToken.Attributes.Add("onclick", string.Format("return InsertText('{0}','{1}')", ddlAvailableAnswerTokens.ClientID, txtAnswerTemplate.ClientID));
                    imbSave.Attributes.Add("onclick", string.Format("sageHtmlEncoder('{0}')", txtQuestionTemplate.ClientID + "," + txtAnswerTemplate.ClientID));                    
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void AddImageUrls()
        {
            imgAddQuestionToken.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
            imgAddAnswerToken.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
            imbSave.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
        }

        private void BindAvailableTokens()
        {
            try
            {
                ddlAvailableQuestionTokens.DataSource = SageFrameLists.FAQsTokenLists();
                ddlAvailableQuestionTokens.DataTextField = "Value";
                ddlAvailableQuestionTokens.DataValueField = "Key";
                ddlAvailableQuestionTokens.DataBind();
                ListItem question = ddlAvailableQuestionTokens.Items.FindByValue("[ANSWER]");
                ddlAvailableQuestionTokens.Items.Remove(question);
                ddlAvailableAnswerTokens.DataSource = SageFrameLists.FAQsTokenLists();
                ddlAvailableAnswerTokens.DataTextField = "Value";
                ddlAvailableAnswerTokens.DataValueField = "Key";
                ddlAvailableAnswerTokens.DataBind();
                ListItem answer = ddlAvailableAnswerTokens.Items.FindByValue("[QUESTION]");
                ddlAvailableAnswerTokens.Items.Remove(answer);
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void BindDefaultSorting()
        {
            try
            {
                ddlDefaultSorting.DataSource = SageFrameLists.FAQsSorting();
                ddlDefaultSorting.DataTextField = "Value";
                ddlDefaultSorting.DataValueField = "Key";
                ddlDefaultSorting.DataBind();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void BindData()
        {
            try
            {
                var Faqs = dbFAQs.sp_FAQsSettingGetAll(usermoduleID, GetPortalID);
                foreach (sp_FAQsSettingGetAllResult setting in Faqs)
                {
                    switch (setting.SettingKey)
                    {
                        case "FaqQuestionTemplate":
                            txtQuestionTemplate.Text = Server.HtmlDecode(setting.SettingValue.ToString());
                            break;
                        case "FaqAnswerTemplate":
                            txtAnswerTemplate.Text = Server.HtmlDecode(setting.SettingValue.ToString());
                            break;
                        case "FaqEnableAjax":
                            chkUseAjax.Checked = bool.Parse(setting.SettingValue.ToString());
                            break;
                        case "FaqDefaultSorting":
                            ddlDefaultSorting.SelectedIndex = ddlDefaultSorting.Items.IndexOf(ddlDefaultSorting.Items.FindByValue(setting.SettingValue.ToString()));
                            break;
                    }
                }

                //auditBar.Visible = true;
                //lblCreatedBy.Visible = true;
                //lblCreatedBy.Text = GetSageMessage("FAQs", "CreatedBy ") + LINQFAQsSettings.Rows[0]["AddedBy"].ToString() + " " + LINQFAQsSettings.Rows[0]["AddedOn"].ToString();
                //if (LINQFAQsSettings.Rows[0]["UpdatedBy"].ToString() != "" && LINQFAQsSettings.Rows[0]["UpdatedOn"].ToString() != "")
                //{
                //    lblUpdatedBy.Visible = true;
                //    lblUpdatedBy.Text = GetSageMessage("FAQs", "LastUpdatedBy ") + LINQFAQsSettings.Rows[0]["UpdatedBy"].ToString() + " " + LINQFAQsSettings.Rows[0]["UpdatedOn"].ToString();
                //}
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }                    
        }

        protected void imbSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                string Question = txtQuestionTemplate.Text.ToString();
                string Answer = txtAnswerTemplate.Text.ToString();
                SaveSetting("FaqDefaultSorting", ddlDefaultSorting.SelectedValue);
                SaveSetting("FaqEnableAjax", chkUseAjax.Checked.ToString());
                SaveSetting("FaqQuestionTemplate", Question);
                SaveSetting("FaqAnswerTemplate", Answer);

                BindData();
                ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsSettingIsSavedSuccessfully"), "", SageMessageType.Success);
            }
            catch(Exception Ex)
            {
                ProcessException(Ex);
            }  
        }

        private void SaveSetting(string key, string value)
        {
            dbFAQs.sp_FAQsSettingAddUpdate(ref _faqsSettingValueID, usermoduleID, key, value, true, GetPortalID, GetUsername, GetUsername);
        }
    }
}