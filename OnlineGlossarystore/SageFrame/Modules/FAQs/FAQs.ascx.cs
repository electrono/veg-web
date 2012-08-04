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
using SageFrame.FAQs;
using SageFrame.Web;
using System.Web.UI.HtmlControls;

namespace SageFrame.Modules.Admin.FAQs
{
    public partial class FAQs : BaseAdministrationUserControl
    {
        FAQsDataContext db = new FAQsDataContext(SystemSetting.SageFrameConnectionString);
        public Int32 usermoduleID = 0;

        private bool IsAJAXSettingEnabled()
        {
            bool AJAXEnabled = true;
            var faqsSetting = db.sp_FAQsSettingGetAll(Int32.Parse(SageUserModuleID), GetPortalID);
            foreach (sp_FAQsSettingGetAllResult faqsContent in faqsSetting)
            {
                switch (faqsContent.SettingKey)
                {
                    case "FaqEnableAjax":
                        AJAXEnabled = bool.Parse(faqsContent.SettingValue);
                        break;
                }
            }
            return AJAXEnabled;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    usermoduleID = Int32.Parse(SageUserModuleID);
                    if (usermoduleID != 0)
                    {
                        BindFAQs(usermoduleID);
                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void BindFAQs(Int32 userModuleID)
        {
            try
            {
                dtlFAQs.DataSource = db.sp_GetFAQWithTemplate(userModuleID, true, true, GetPortalID, GetUsername);
                dtlFAQs.DataBind();
                Label lblNoFAQs = dtlFAQs.Controls[0].FindControl("lblNoFAQs") as Label;
                if (dtlFAQs.Items.Count == 0)
                {
                    //dtlFAQs.Visible = false;                    
                    lblNoFAQs.Visible = true;
                }
                else
                {
                    dtlFAQs.Visible = true;
                    lblNoFAQs.Visible = false;
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void dtlFAQs_ItemCommand(object source, DataListCommandEventArgs e)
        {
            try
            {
                int FAQID = Int32.Parse(dtlFAQs.DataKeys[e.Item.ItemIndex].ToString());
                switch (e.CommandName)
                {
                    case "Select":
                        {
                            //Load EditFAQs.ascx
                            //HttpContext.Current.Session["FAQsMessage"] = null;
                            string ControlPath = "/Modules/Admin/FAQs/FAQsEdit.ascx&faqcode=" + FAQID;
                            ProcessSourceControlUrl(Request.RawUrl, ControlPath, "faqsparam");
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void dtlFAQs_ItemDataBound(object sender, DataListItemEventArgs e)
        {
            try
            {
                HiddenField hdnFAQID = (HiddenField)e.Item.FindControl("hdnFAQID");
                Panel pnlFAQuestion = (Panel)e.Item.FindControl("pnlFAQuestion");
                ImageButton imgExpandOrCollapse = (ImageButton)e.Item.FindControl("imgExpandOrCollapse");
                Literal ltrQuestion = (Literal)e.Item.FindControl("ltrQuestion");

                if (e.Item.ItemIndex == 0)
                {
                    imgExpandOrCollapse.ImageUrl = GetTemplateImageUrl("imgCollapse.png", true);
                }
                if (imgExpandOrCollapse != null)
                {
                    imgExpandOrCollapse.Attributes.Add("onclick", string.Format("return flipFlop('{0}','{1}','{2}','{3}','{4}','{5}','{6}');", imgExpandOrCollapse.ClientID, '_' + hdnFAQID.Value, hdnFAQID.Value, TemplateName, ltrQuestion.ClientID, usermoduleID, GetPortalID));
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }
    }
}