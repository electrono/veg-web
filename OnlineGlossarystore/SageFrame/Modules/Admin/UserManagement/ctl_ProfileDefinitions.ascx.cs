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
using SageFrame.Web;
using SageFrame.ProfileManagement;
using SageFrame.Profile;
using System.Collections;
using System.Data;
using System.Text;
using SageFrame.SageFrameClass;


namespace SageFrame.Modules.Admin.UserManagement
{
    public partial class ctl_ProfileDefinitions : BaseAdministrationUserControl
    {
        
        ProfileManagementDataContext db = new ProfileManagementDataContext(SystemSetting.SageFrameConnectionString);

        ProfilePropertyDefinitionCollection _ProfileProperties;// = new ProfilePropertyDefinitionCollection();
        protected override void LoadViewState(object savedState)
        {
            if (!(savedState == null))
            {
                //  Load State from the array of objects that was saved with SaveViewState.
                object[] myState = ((object[])(savedState));
                if (!(myState[0] == null))
                {
                    base.LoadViewState(myState[0]);
                }
                // Load ModuleID
                if (!(myState[1] == null))
                {
                    _ProfileProperties = ((ProfilePropertyDefinitionCollection)(myState[1]));
                }
            }
        }

        protected override object SaveViewState()
        {
            object[] allStates = new object[2];
            //  Save the Base Controls ViewState
            allStates[0] = base.SaveViewState();
            // Save the Profile Properties
            allStates[1] = ProfileProperties;
            return allStates;
        }
                
        public ProfilePropertyDefinitionCollection ProfileProperties
        {
            get
            {
                if (_ProfileProperties == null)
                {
                    _ProfileProperties = new ProfilePropertyDefinitionCollection();
                    try
                    {
                        var LINQ = db.sp_ProfileList(GetPortalID);
                        if (LINQ != null)
                        {
                            foreach (sp_ProfileListResult Profile in LINQ)
                            {
                                _ProfileProperties.Add(Profile);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ProcessException(ex);
                    }
                }
                return _ProfileProperties;
            }
        }

        private void MoveProperty(int index, int destIndex)
        {
            try
            {
                sp_ProfileListResult objProperty = ProfileProperties[index];
                sp_ProfileListResult objNext = ProfileProperties[destIndex];
                int currentOrder = (int)objProperty.DisplayOrder;
                int nextOrder = (int)objNext.DisplayOrder;
                // Swap ViewOrders
                objProperty.DisplayOrder = nextOrder;
                ProfileProperties[index] = objProperty;
                objNext.DisplayOrder = currentOrder;
                ProfileProperties[destIndex] = objNext;
                // 'Refresh Grid
                ProfileProperties.Sort();
                BindGrid();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void MovePropertyDown(int index)
        {
            MoveProperty(index, (index + 1));
        }

        private void MovePropertyUp(int index)
        {
            MoveProperty(index, (index - 1));
        }

        private void BindGrid()
        {                       
            gdvList.DataSource = ProfileProperties;
            gdvList.DataBind();

            if (gdvList.Rows.Count > 0)
            {
                ImageButton imgDown = (ImageButton)gdvList.Rows[gdvList.Rows.Count - 1].FindControl("imgDown");
                imgDown.Visible = false;
            }
        }

        private void RefreshGrid()
        {
            _ProfileProperties = null;
            BindGrid();
        }

        private void AddImageUrls()
        {
            imbSaveChanges.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
            imbRefresh.ImageUrl = GetTemplateImageUrl("imgrefresh.png", true);
            imbAddNew.ImageUrl = GetTemplateImageUrl("imgadd.png", true);
            imbAdd.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
            imbSave.ImageUrl = GetTemplateImageUrl("imgsave.png", true);
            imbCancel.ImageUrl = GetTemplateImageUrl("imgcancel.png", true);
            imbDelete.ImageUrl = GetTemplateImageUrl("imgdelete.png", true);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                AddImageUrls();
                BindGrid();
                BindDdlList();
                BinddlDataType();
                HideAll();
                divGridViewWrapper.Style.Add("display", "block");
            }
        }


        private void BindDdlList()
        {
            try
            {
                var LINQ = db.sp_PropertyTypeList();
                ddlPropertyType.DataSource = LINQ;
                ddlPropertyType.DataTextField = "Name";
                ddlPropertyType.DataValueField = "PropertyTypeID";
                ddlPropertyType.DataBind();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
            //ddlPropertyType
        }

        private void BinddlDataType()
        {
            ddlDataType.DataSource = SageFrameLists.DataTypes();
            ddlDataType.DataValueField = "Key";
            ddlDataType.DataTextField = "Value";
            ddlDataType.DataBind();
        }

        private void CreatePropertyValueDataTable()
        {
            try
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProfileValueID", System.Type.GetType("System.String"));
                dt.Columns.Add("Name", System.Type.GetType("System.String"));
                Session["PropertyValueDataTable"] = null;
                Session["PropertyValueDataTable"] = dt;
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void HideAll()
        {
            try
            {
                divForm.Style.Add("display", "none");
                divGridViewWrapper.Style.Add("display", "none");               
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void ClearForm()
        {
            txtCaption.Text = "";
            ddlPropertyType.SelectedIndex = ddlPropertyType.Items.IndexOf(ddlPropertyType.Items.FindByValue("1"));
            lstvPropertyValue.DataSource = null;
            lstvPropertyValue.DataBind();
            CreatePropertyValueDataTable();
            Session["EditProfileID"] = null;
            HideAll();
            divGridViewWrapper.Style.Add("display", "block");            
        }

        private void AddNew()
        {
            try
            {
                ClearForm();
                HideAll();
                lstvPropertyValue.DataSource = null;
                lstvPropertyValue.DataBind();
                trListPropertyValue.Style.Add("display", "none");
                divForm.Style.Add("display", "");
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void AddPropertyValue()
        {
            try
            {
                AddInDataTable();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void AddInDataTable()
        {
            if (ValidatePropertyValueForm())
            {
                if (Session["PropertyValueDataTable"] != null)
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)Session["PropertyValueDataTable"];

                    DataRow newrow1 = dt.NewRow();
                    dt.Rows.Add(newrow1);
                    dt.Rows[dt.Rows.Count - 1]["ProfileValueID"] = dt.Rows.Count - 1;
                    dt.Rows[dt.Rows.Count - 1]["Name"] = txtPropertyValue.Text.Trim();
                    dt.AcceptChanges();
                    lstvPropertyValue.DataSource = dt;
                    lstvPropertyValue.DataTextField = "Name";
                    lstvPropertyValue.DataValueField = "ProfileValueID";
                    lstvPropertyValue.DataBind();
                    ClearPropertyValueText();
                }
            }
            else
            {
                ShowMessage(SageMessageTitle.Information.ToString(), strMessage.ToString(), "", SageMessageType.Success);
            }
        }

        private void ClearPropertyValueText()
        {
            txtPropertyValue.Text = "";
        }

        StringBuilder strMessage;
        private bool ValidatePropertyValueForm()
        {
            strMessage = new StringBuilder();
            bool IsValid = true;
            //strMessage.AppendLine("Please fill " + Environment.NewLine); 
            strMessage.AppendLine(GetSageMessage("UserManagement", "PleaseFill") + Environment.NewLine);
            if (txtPropertyValue.Text.Trim() == string.Empty)
            {
                IsValid = false;
               // strMessage.AppendLine(" Property Value" + Environment.NewLine);
                strMessage.AppendLine(GetSageMessage("UserManagement", "PropertyValue") + Environment.NewLine);
            }
            return IsValid;
        }

        private void AddPropertyShow()
        {
            ClearPropertyValueText();
            trListPropertyValue.Style.Add("display", "");
        }

        private bool ValidateProfilepropertyForm()
        {
            strMessage = new StringBuilder();
            bool IsValid = true;
            int PropertyTypeID = Int32.Parse(ddlPropertyType.SelectedValue);
            if (PropertyTypeID == 1 || PropertyTypeID == 5 || PropertyTypeID == 6 || PropertyTypeID == 7 || PropertyTypeID == 8)
            {
                //strMessage.AppendLine("Please fill " + Environment.NewLine);
                strMessage.AppendLine(GetSageMessage("UserManagement", "PleaseFil") + Environment.NewLine);
                if (txtCaption.Text.Trim() == string.Empty)
                {
                    IsValid = false;
                   // strMessage.AppendLine(" Caption" + Environment.NewLine);
                    strMessage.AppendLine(GetSageMessage("UserManagement", "Caption") + Environment.NewLine);
                }
            }
            else
            {
               // strMessage.AppendLine("Please fill " + Environment.NewLine);
                strMessage.AppendLine(GetSageMessage("UserManagement", "PleaseFillAgain") + Environment.NewLine);
                if (txtCaption.Text.Trim() == string.Empty)
                {
                    IsValid = false;
                   // strMessage.AppendLine(" Caption" + Environment.NewLine);
                    strMessage.AppendLine(GetSageMessage("UserManagement", "AgainCaption") + Environment.NewLine);
                }
                if (lstvPropertyValue.Items.Count == 0 || lstvPropertyValue.Items.Count < 0)
                {
                    IsValid = false;
                   // strMessage.AppendLine(" Property Value" + Environment.NewLine);
                    strMessage.AppendLine(GetSageMessage("UserManagement", "PropertyValueAgain") + Environment.NewLine);
                }

                if (ddlDataType.SelectedItem.Value != "0")
                {
                    IsValid = false;
                  //  strMessage.AppendLine(" Data type must be string!" + Environment.NewLine);
                    strMessage.AppendLine(GetSageMessage("UserManagement", "DataTypeMustBeString") + Environment.NewLine);
                }
            }

            return IsValid;
        }

        private void ClearProfilepropertyForm()
        {
            try
            {
                txtCaption.Text = "";
                ddlPropertyType.SelectedIndex = ddlPropertyType.Items.IndexOf(ddlPropertyType.Items.FindByValue("1"));
                lstvPropertyValue.DataSource = null;
                lstvPropertyValue.DataBind();
                CreatePropertyValueDataTable();
                Session["EditProfileID"] = null;
                HideAll();
                divForm.Style.Add("display", "none");
                divGridViewWrapper.Style.Add("display", "block");
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void Cancel()
        {
            ClearProfilepropertyForm();
        }

        private void SaveProfileDefination()
        {
            try
            {
                if (ValidateProfilepropertyForm())
                {
                    if (Session["EditProfileID"] != null)
                    {
                        int PropertyTypeID = Int32.Parse(ddlPropertyType.SelectedValue);
                        int ProfileID = Int32.Parse(Session["EditProfileID"].ToString());
                        if (ProfileID != 0)
                        {
                            db.sp_ProfileUpdate(ProfileID, txtCaption.Text.Trim(), PropertyTypeID, ddlDataType.SelectedItem.Value,chkIsRequred.Checked,
                                true, true, DateTime.Now, GetPortalID,GetUsername);
                            if (ProfileID != 0 && PropertyTypeID != 1 && PropertyTypeID != 5 && PropertyTypeID != 6 && PropertyTypeID != 7 && PropertyTypeID != 8 && lstvPropertyValue.Items.Count > 0)
                            {
                                db.sp_ProfileValueDeleteByProfileID(ProfileID, GetPortalID, GetUsername);
                                for (int i = 0; i < lstvPropertyValue.Items.Count; i++)
                                {
                                    System.Nullable<int> ProfileValueID = 0;
                                    db.sp_ProfileValueAdd(ref ProfileValueID, ProfileID, 
                                        lstvPropertyValue.Items[i].Text, true, DateTime.Now, GetPortalID, GetUsername);
                                }
                               
                            }
                          ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("UserManagement", "ProfileUpdatedSuccessfully"), "", SageMessageType.Success);
                            ClearProfilepropertyForm();
                            RefreshGrid();
                        }
                    }
                    else
                    {
                        int PropertyTypeID = Int32.Parse(ddlPropertyType.SelectedValue);
                        System.Nullable<int> ProfileID = 0;
                        db.sp_ProfileAdd(ref ProfileID, txtCaption.Text.Trim(),
                           PropertyTypeID, ddlDataType.SelectedItem.Value, chkIsRequred.Checked, true, DateTime.Now, GetPortalID, GetUsername);
                        if (ProfileID != 0 && ProfileID != null && PropertyTypeID != 1 && PropertyTypeID != 5 && PropertyTypeID != 6 && PropertyTypeID != 7 && PropertyTypeID != 8 && lstvPropertyValue.Items.Count > 0)
                        {
                            for (int i = 0; i < lstvPropertyValue.Items.Count; i++)
                            {
                                System.Nullable<int> ProfileValueID = 0;
                                db.sp_ProfileValueAdd(ref ProfileValueID, ProfileID, lstvPropertyValue.Items[i].Text, true, DateTime.Now, GetPortalID,
                                    GetUsername);
                            }
                           
                        }
                       ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("UserManagement", "ProfileAddedSuccessfully"), "", SageMessageType.Success);
                        ClearProfilepropertyForm();
                        RefreshGrid();
                    }

                }
                else
                {
                    ShowMessage(SageMessageTitle.Information.ToString(), strMessage.ToString(), "", SageMessageType.Success);
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void SaveChanges()
        {
            try
            {
                for (int i = 0; i < gdvList.Rows.Count; i++)
                {
                    ImageButton imbKey = (ImageButton)gdvList.Rows[i].FindControl("imgDelete");
                    int ProfileID = Int32.Parse(imbKey.CommandArgument.ToString());
                    ImageButton imbDisplayOrder = (ImageButton)gdvList.Rows[i].FindControl("imgUp");
                    Int32 DisplayOrder = Int32.Parse(imbDisplayOrder.CommandArgument.ToString());
                    CheckBox chk = (CheckBox)gdvList.Rows[i].FindControl("chkIsActive");
                    bool IsActive = false;
                    if (chk != null && chk.Checked == true)
                    {
                        IsActive = true;
                    }
                    db.sp_ProfileUpdateDisplayOrderAndIsActiveOnly(ProfileID, DisplayOrder, IsActive, DateTime.Now, GetPortalID, GetUsername);
                }
               ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("UserManagement", "ChangesSavedSuccessfully"), "", SageMessageType.Success);
                RefreshGrid();
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void imbAddNew_Click(object sender, ImageClickEventArgs e)
        {
            AddNew();
        }    

        protected void imbAdd_Click(object sender, ImageClickEventArgs e)
        {
            AddPropertyValue();
        }

        protected void imbDelete_Click(object sender, ImageClickEventArgs e)
        {
            DeleteSelectedListItem();
        }

        private void DeleteSelectedListItem()
        {
            try
            {
                if (Session["PropertyValueDataTable"] != null)
                {
                    DataTable dt = new DataTable();
                    dt = (DataTable)Session["PropertyValueDataTable"];
                    if (lstvPropertyValue.Items.Count > 0)
                    {

                        for (int i = 0; i < lstvPropertyValue.Items.Count; i++)
                        {
                            if (lstvPropertyValue.Items[i].Selected == true)
                            {
                                for (int j = 0; j < dt.Rows.Count; j++)
                                {
                                    if (Int32.Parse(dt.Rows[j]["ProfileValueID"].ToString()) == Int32.Parse(lstvPropertyValue.Items[i].Value))
                                    {
                                        dt.Rows.Remove(dt.Rows[j]);
                                        dt.AcceptChanges();
                                    }
                                }
                            }
                        }
                        
                        lstvPropertyValue.DataSource = dt;
                        lstvPropertyValue.DataTextField = "Name";
                        lstvPropertyValue.DataValueField = "ProfileValueID";
                        lstvPropertyValue.DataBind();
                    }
                    
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void ddlPropertyType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int PropertyTypeID = Int32.Parse(ddlPropertyType.SelectedValue);
            if (PropertyTypeID != 1 && PropertyTypeID != 5 && PropertyTypeID != 6 && PropertyTypeID != 7 && PropertyTypeID != 8)
            {
                AddPropertyShow();
            }
            else
            {
                trListPropertyValue.Style.Add("display", "none");
            }
        }             

        protected void imbSave_Click(object sender, ImageClickEventArgs e)
        {
            SaveProfileDefination();
        }

        protected void imbCancel_Click(object sender, ImageClickEventArgs e)
        {
            Cancel();
        }



        protected void gdvList_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

        }

        protected void gdvList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                switch (e.CommandName.ToString())
                {
                    case "Edit":
                        int EditID = Int32.Parse(e.CommandArgument.ToString());
                        Edit(EditID);
                        break;
                    case "Delete":
                        int DeleteID = Int32.Parse(e.CommandArgument.ToString());
                        Delete(DeleteID);
                        break;
                    case "Up":
                        int UpID = Int32.Parse(e.CommandArgument.ToString());
                        UpID = UpID - 1;
                        MovePropertyUp(UpID);
                        break;
                    case "Down":
                        int DownID = Int32.Parse(e.CommandArgument.ToString());
                        DownID = DownID - 1;
                        MovePropertyDown(DownID);
                        break;
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void Edit(int EditID)
        {
            ClearProfilepropertyForm();
            var LINQProfile = db.sp_ProfileGetByProfileID(EditID).SingleOrDefault();
            if (LINQProfile != null)
            {
                txtCaption.Text = LINQProfile.Name;
                ddlPropertyType.SelectedIndex  = ddlPropertyType.Items.IndexOf(ddlPropertyType.Items.FindByValue(LINQProfile.PropertyTypeID.ToString()));
                chkIsRequred.Checked = bool.Parse(LINQProfile.IsRequired.ToString());
                ddlDataType.SelectedIndex = ddlDataType.Items.IndexOf(ddlDataType.Items.FindByValue(LINQProfile.DataType));

                if (LINQProfile.PropertyTypeID != 1 && LINQProfile.PropertyTypeID != 5 && LINQProfile.PropertyTypeID != 6 && LINQProfile.PropertyTypeID != 7 && LINQProfile.PropertyTypeID != 8 && Session["PropertyValueDataTable"] != null)
                {
                    var LINQPropertyValue = db.sp_ProfileValueGetActiveByProfileID(EditID, GetPortalID);
                    CommonFunction LToDCon = new CommonFunction();
                    DataTable dtActual = LToDCon.LINQToDataTable(LINQPropertyValue);
                    if (dtActual != null && dtActual.Rows.Count > 0)
                    {
                        DataTable dt = (DataTable)Session["PropertyValueDataTable"];
                        for (int i = 0; i < dtActual.Rows.Count; i++)
                        {
                            DataRow newrow1 = dt.NewRow();
                            dt.Rows.Add(newrow1);
                            dt.Rows[dt.Rows.Count - 1]["ProfileValueID"] = dtActual.Rows[i]["ProfileValueID"].ToString();
                            dt.Rows[dt.Rows.Count - 1]["Name"] = dtActual.Rows[i]["Name"].ToString();
                            dt.AcceptChanges();

                        }
                        lstvPropertyValue.DataSource = dt;
                        lstvPropertyValue.DataTextField = "Name";
                        lstvPropertyValue.DataValueField = "ProfileValueID";
                        lstvPropertyValue.DataBind();
                        trListPropertyValue.Style.Add("display", "");
                    }

                }
                else
                {
                    lstvPropertyValue.DataSource = null;
                    lstvPropertyValue.DataBind();
                    trListPropertyValue.Style.Add("display", "none");                    
                }
            }
            HideAll();
            divForm.Style.Add("display", "block");
            Session["EditProfileID"] = EditID;

        }

        private void Delete(int DeleteID)
        {
            db.sp_ProfileValueDeleteByProfileID(DeleteID, GetPortalID,GetUsername);
            db.sp_ProfileDeleteByProfileID(DeleteID, GetUsername);
            RefreshGrid();
           ShowMessage(SageMessageTitle.Information.ToString(), GetSageMessage("UserManagement", "ProfileDeletedSuccessfully"), "", SageMessageType.Success);
        }

        protected void gdvList_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                ImageButton btnDelete = (ImageButton)e.Row.FindControl("imgDelete");
                btnDelete.Attributes.Add("onclick", "javascript:return confirm('" + GetSageMessage("UserManagement", "WantToDelete") + "')");
                if (e.Row.RowIndex == 0)
                {
                    ImageButton imgUp = (ImageButton)e.Row.FindControl("imgUp");
                    imgUp.Visible = false;
                }

            }
        }

        protected void gdvList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

        }

        protected void gdvList_RowEditing(object sender, GridViewEditEventArgs e)
        {

        }

        protected void gdvList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {

        }

        protected void imbSaveChanges_Click(object sender, ImageClickEventArgs e)
        {
            SaveChanges();
        }        

        protected void imbRefresh_Click(object sender, ImageClickEventArgs e)
        {
            RefreshGrid();
        }

             

        
    }
}