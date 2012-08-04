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
using SageFrame.FAQs;

namespace SageFrame.Modules.Admin.FAQs
{
    public partial class FAQsEdit : BaseAdministrationUserControl
    {

        FAQsDataContext db = new FAQsDataContext(SystemSetting.SageFrameConnectionString);

        System.Nullable<Int32> _newFAQID = 0;
        System.Nullable<Int32> _newFAQCategoryID = 0;
        System.Nullable<Int32> _newCategoryCount = 0;
        public Int32 FAQID = 0;

        protected void Page_Init(object sender, EventArgs e)
        {     
            if (Request.QueryString["faqcode"] != null)
            {
                FAQID = Int32.Parse(Request.QueryString["faqcode"].ToString());
                imbDelete.Visible = true;
                lblDelete.Visible = true;
                TabContainerFAQsEdit.Tabs[1].Visible = false;               
            }
            else if (HttpContext.Current.Session["FAQID"] != null && Request.QueryString["faqcode"] == null)
            {
                FAQID = Int32.Parse(HttpContext.Current.Session["FAQID"].ToString());
                TabContainerFAQsEdit.Tabs[1].Visible = true;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    AddImageUrls();
                    BindCategoryDropDown();                    
                    BindFAQsGrid();
                    ClearForm();
                    ClearCategoryForm();
                    BindFAQsCategories();
                    if (Request.QueryString["faqcode"] != null || HttpContext.Current.Session["FAQID"] != null)
                    {
                        PanelVisibility1(true, true, false);
                        BindFAQsDetails(FAQID);
                    }
                    else if(TabContainerFAQsEdit.Tabs[1].Visible == true)
                    {
                        PanelVisibility1(false, false, true);
                        PanelVisibility2(true, false, false);
                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void AddImageUrls()
        {
            imbSave.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
            imbDelete.ImageUrl = GetTemplateImageUrl("imgdelete.png", true);
            imbAddFAQs.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
            imbAddFAQsCategory.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
            imbUpdate.ImageUrl = GetTemplateImageUrl("imgupdate.png", true);
            imbCancel.ImageUrl = GetTemplateImageUrl("imgback.png", true);
            imbReturn.ImageUrl = GetTemplateImageUrl("imgback.png", true);
        }

        private void BindCategoryDropDown()
        {
            try
            {
                ddlCategory.DataSource = db.sp_FAQsCategoryGetByPortal(GetPortalID);
                ddlCategory.DataTextField = "FAQCategoryName";
                ddlCategory.DataValueField = "FAQCategoryID";
                ddlCategory.DataBind();
                ddlCategory.Items.Insert(0, new ListItem("<Select Category>", "-1"));
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void ClearForm()
        {
            ddlCategory.ClearSelection();
            ddlCategory.SelectedIndex = ddlCategory.Items.IndexOf(ddlCategory.Items.FindByValue("-1"));
            FCKeditorQuestionField.Value = "";
            FCKeditorAnswerField.Value = "";
            chkIsActive.Checked = true;
            HttpContext.Current.Session["FAQID"] = null;
        }

        protected void imbSave_Click(object sender, ImageClickEventArgs e)
        {
            if (Page.IsValid)
            {
                if (ddlCategory.SelectedIndex != 0)
                {
                    try
                    {
                        string Error = string.Empty;
                        string QuestionText = System.Text.RegularExpressions.Regex.Replace(FCKeditorQuestionField.Value, "<br/>$", "");
                        QuestionText = System.Text.RegularExpressions.Regex.Replace(FCKeditorQuestionField.Value, "^&nbsp;", "");
                        string AnswerText = System.Text.RegularExpressions.Regex.Replace(FCKeditorAnswerField.Value, "<br/>$", "");
                        AnswerText = System.Text.RegularExpressions.Regex.Replace(FCKeditorAnswerField.Value, "^&nbsp;", "");

                        if (Request.QueryString["faqcode"] != null || HttpContext.Current.Session["FAQID"] != null)
                        {
                            try
                            {
                                db.sp_FAQsUpdate(FAQID, QuestionText, AnswerText,
                                    Int32.Parse(ddlCategory.SelectedValue), chkIsActive.Checked, true, DateTime.Now, GetPortalID, GetUsername);
                                ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsIsUpdatedSuccessfully"), "", SageMessageType.Success);
                                if(!Request.RawUrl.Contains("Sagin"))
                                {
                                HttpContext.Current.Session["FAQsMessage"] = GetSageMessage("FAQs", "FAQsIsUpdatedSuccessfully");
                                }
                            }

                            catch (Exception ex)
                            {
                                Error = ex.Message;
                            }
                        }
                        else
                        {
                            try
                            {
                                db.sp_FAQsAdd(ref _newFAQID, Int32.Parse(SageUserModuleID), QuestionText,
                                    AnswerText, Int32.Parse(ddlCategory.SelectedValue), 0, chkIsActive.Checked,
                                    DateTime.Now, GetPortalID, GetUsername);
                                ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsIsAddedSuccessfully"), "", SageMessageType.Success);
                            }
                            catch (Exception ex)
                            {
                                ProcessException(ex);
                            }
                        }
                        if (Request.QueryString["faqcode"] != null && Error == "")
                        {
                            ClearForm();
                            ProcessCancelRequest(Request.RawUrl);
                        }
                        else
                        {
                            BindFAQsGrid();
                            ClearForm();
                            PanelVisibility1(false, false, true);                            
                        }
                        if (Error != "")
                        {
                            ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("FAQs", "FAQsIsNotUpdated"), "", SageMessageType.Alert);
                        }
                    }
                    catch (Exception ex)
                    {
                        ProcessException(ex);
                    }
                }
                else
                {
                    ShowMessage(SageMessageTitle.Notification.ToString(), GetSageMessage("FAQs", "FAQsCategoryIsNotSelected"), "", SageMessageType.Alert);
                }
            }
        }        

        protected void imbDelete_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                if (Request.QueryString["faqcode"] != null)
                {
                    db.sp_FAQsDelete(FAQID, GetPortalID, GetUsername);
                    ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsIsDeletedSuccessfully"), "", SageMessageType.Success);
                    ClearForm();
                    BindFAQsGrid();
                    ProcessCancelRequest(Request.RawUrl);
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void imbAddFAQs_Click(object sender, ImageClickEventArgs e)
        {
            HttpContext.Current.Session["FAQID"] = null;
            ClearForm();
            PanelVisibility1(true, false, false);
        }

        protected void imbAddFAQsCategory_Click(object sender, ImageClickEventArgs e)
        {
            ClearCategoryForm();
            PanelVisibility2(false, true, false);
        }

        protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
        {
            string error = string.Empty;
            if (Int32.Parse(hdfCategoryID.Value) > 0)
            {
                db.sp_FAQsCheckUniqueFAQsCategoryName(Int32.Parse(hdfCategoryID.Value), txtCategoryName.Text.Trim(), true, ref _newCategoryCount);
                if (_newCategoryCount == 0)
                {
                    try
                    {
                        db.sp_FAQsCategoryUpdate(Int32.Parse(hdfCategoryID.Value), txtCategoryName.Text.Trim(),
                                txtCategoryDescription.Text.Trim(), chkPublish.Checked, true, DateTime.Now, GetPortalID, GetUsername);
                        ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsCategoryISUpdatedSuccessfully"), "", SageMessageType.Success);
                    }
                    catch (Exception ex)
                    {
                        ProcessException(ex);
                        error += ex.Message;
                    }
                }
                else
                {
                    ShowMessage(SageMessageTitle.Notification.ToString(), txtCategoryName.Text.Trim() + " " + GetSageMessage("FAQs", "NameAlreadyExist"), "", SageMessageType.Error);
                    error += "Name already Exist";
                }
            }
            else if (Int32.Parse(hdfCategoryID.Value) == 0)
            {
                db.sp_FAQsCheckUniqueFAQsCategoryName(0, txtCategoryName.Text.Trim(), false, ref _newCategoryCount);

                if (_newCategoryCount == 0)
                {
                    // Add
                    try
                    {
                        db.sp_FAQsCategoryAdd(ref _newFAQCategoryID, Int32.Parse(SageUserModuleID), txtCategoryName.Text.Trim(),
                                txtCategoryDescription.Text.Trim(), chkPublish.Checked, DateTime.Now, GetPortalID, GetUsername);
                        ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsCategoryIsAddedSuccessfully"), "", SageMessageType.Success);
                    }
                    catch (Exception ex)
                    {
                        ProcessException(ex);
                        error += ex.Message;
                    }
                }
                else
                {
                    ShowMessage(SageMessageTitle.Notification.ToString(), txtCategoryName.Text.Trim() + " " + GetSageMessage("FAQs", "NameAlreadyExists"), "", SageMessageType.Error);
                    error += "Name already Exist";
                }
            }
            if (error == string.Empty)
            {
                ClearCategoryForm();
                BindFAQsCategories();
                BindCategoryDropDown();
                PanelVisibility2(true, false, false);
            }
        }

        protected void imbCancel_Click(object sender, ImageClickEventArgs e)
        {
            PanelVisibility2(true, false, false);
        }

        private void PanelVisibility1(bool AddFAQs, bool ShowAuditBar, bool FAQsInGrid)
        {
            pnlAddFAQs.Visible = AddFAQs;
            auditBar.Visible = ShowAuditBar;
            pnlFAQsInGrid.Visible = FAQsInGrid;
        }

        private void PanelVisibility2(bool FAQsCategoryInGrid, bool AddFAQsCategory, bool ShowFAQCategoryID)
        {
            pnlManageFAQsCategory.Visible = FAQsCategoryInGrid;
            pnlAddFAQsCategory.Visible = AddFAQsCategory;
            rowFAQCategoryID.Visible = ShowFAQCategoryID;
        }

        protected void gdvManageFAQs_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gdvManageFAQs_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gdvManageFAQs_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gdvManageFAQs_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gdvManageFAQs_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int FAQID = Int32.Parse(e.CommandArgument.ToString());
                switch (e.CommandName)
                {
                    case "Edit":
                        {
                            HttpContext.Current.Session["FAQID"] = FAQID.ToString();
                            BindFAQsDetails(FAQID);
                            PanelVisibility1(true, true, false);
                            break;
                        }
                    case "Delete":
                        {
                            db.sp_FAQsDelete(FAQID, GetPortalID, GetUsername);
                            ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsIsDeletedSuccessfully"), "", SageMessageType.Success);
                            BindFAQsGrid();
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void BindFAQsDetails(int FAQId)
        {
            try
            {
                var FAQInfo = db.sp_FAQGetByFAQID(FAQId, GetPortalID).SingleOrDefault();
                FCKeditorQuestionField.Value = FAQInfo.Question;
                FCKeditorAnswerField.Value = FAQInfo.Answer;
                ddlCategory.SelectedIndex = ddlCategory.Items.IndexOf(ddlCategory.Items.FindByValue(FAQInfo.FAQCategoryID.ToString()));
                chkIsActive.Checked = bool.Parse(FAQInfo.IsActive.ToString());

                auditBar.Visible = true;
                lblCreatedBy.Visible = true;
                lblCreatedBy.Text = GetSageMessage("FAQs", "CreatedBy ") + FAQInfo.AddedBy.ToString() + " " + FAQInfo.AddedOn.ToString();
                if (FAQInfo.UpdatedBy != null && FAQInfo.UpdatedOn != null)
                {
                    lblUpdatedBy.Visible = true;
                    lblUpdatedBy.Text = GetSageMessage("FAQs", "LastUpdatedBy ") + FAQInfo.UpdatedBy.ToString() + " " + FAQInfo.UpdatedOn.ToString();
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void gdvManageFAQs_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {

        }

        protected void gdvManageFAQs_PageIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gdvManageFAQs_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton btnDelete = (ImageButton)e.Row.FindControl("imbDelete");
                btnDelete.Attributes.Add("onclick", "javascript:return confirm('" + GetSageMessage("FAQs", "AreYouSureToDelete") + "')");
            }
        }

        private void BindFAQsGrid()
        {
            try
            {
                gdvManageFAQs.DataSource = db.sp_GetFAQWithTemplate(Int32.Parse(SageUserModuleID), null, null, GetPortalID, GetUsername);
                gdvManageFAQs.DataBind();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void ClearCategoryForm()
        {
            txtCategoryName.Text = "";
            txtCategoryDescription.Text = "";
            chkPublish.Checked = true;
            hdfCategoryID.Value = "0";
        }

        protected void gdvManageFAQs_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvManageFAQs.PageIndex = e.NewPageIndex;
            BindFAQsGrid();
        }

        protected void imbReturn_Click(object sender, ImageClickEventArgs e)
        {
            if (Request.QueryString["faqcode"] != null)
            {
                ProcessCancelRequest(Request.RawUrl);
            }
            else
            {
                PanelVisibility1(false, false, true);
            }
        }        

        protected void gdvCategory_PageIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gdvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int FAQCategoryID = Int32.Parse(e.CommandArgument.ToString());
                switch (e.CommandName)
                {
                    case "Edit":
                        {
                            PanelVisibility2(false, true, true);
                            var FAQCategoryInfo = db.sp_FAQsCategoryGetByFAQCategoryID(FAQCategoryID, GetPortalID).SingleOrDefault();
                            lblID.Text = FAQCategoryInfo.FAQCategoryID.ToString();
                            hdfCategoryID.Value = lblID.Text;
                            txtCategoryName.Text = FAQCategoryInfo.FAQCategoryName;
                            txtCategoryDescription.Text = FAQCategoryInfo.FAQCategoryDescription;
                            chkPublish.Checked = bool.Parse(FAQCategoryInfo.IsActive.ToString());
                            break;
                        }
                    case "Delete":
                        {
                            db.sp_FAQsCategoryDelete(FAQCategoryID, GetPortalID, GetUsername);
                            ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("FAQs", "FAQsCategoryIsDeletedSuccessfully"), "", SageMessageType.Success);
                            ClearCategoryForm();
                            BindFAQsCategories();
                            break;
                        }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void gdvCategory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gdvCategory_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gdvCategory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void gdvCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gdvCategory_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

        }

        protected void gdvCategory_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton btnDelete = (ImageButton)e.Row.FindControl("imbDeleteCategory");
                btnDelete.Attributes.Add("onclick", "javascript:return confirm('" + GetSageMessage("FAQs", "AreYouSureToDelete") + "')");
            }
        }

        protected void gdvCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvCategory.PageIndex = e.NewPageIndex;
            BindFAQsCategories();
        }

        private void BindFAQsCategories()
        {
            var LINQCat = db.sp_FAQsCategoryGetByPortal(GetPortalID);
            gdvCategory.DataSource = LINQCat;
            gdvCategory.DataBind();
        }

        protected void FCKeditorQuestionField_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if ((FCKeditorQuestionField.Value == "&nbsp;") || (FCKeditorQuestionField.Value == "<br />") || (FCKeditorQuestionField.Value.Length == 0))
            {
                cvQuestion.ErrorMessage = GetSageMessage("FAQs", "FAQsPleaseEnterSomeContent");
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

        protected void FCKeditorAnswerField_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if ((FCKeditorAnswerField.Value == "&nbsp;") || (FCKeditorAnswerField.Value == "<br />") || (FCKeditorAnswerField.Value.Length == 0))
            {
                cvAnswer.ErrorMessage = GetSageMessage("FAQs", "FAQsPleaseEnterSomeContent");
                args.IsValid = false;
            }
            else
            {
                args.IsValid = true;
            }
        }

    }
}