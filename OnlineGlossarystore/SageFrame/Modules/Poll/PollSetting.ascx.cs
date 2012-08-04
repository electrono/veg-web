using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using SageFrame.Poll;
using System.Text;
using System.Data;
using System.Collections;
using SageFrame.SageFrameClass;
using System.Web.UI.HtmlControls;
using System.Collections.Specialized;
namespace SageFrame.Modules.Poll
{
    public partial class PollSetting : BaseAdministrationUserControl
    {

        public Int32 usermoduleIDControl = 0;
        // public Int32 usermoduleIDControl = 0;
        System.Nullable<Int32> _pollSettingValueID = 0;
        //System.Nullable<Int32> _pollQuestionID = 0;
        string SettingKey = string.Empty;

        PollDataContext dbpoll = new PollDataContext(SystemSetting.SageFrameConnectionString);


        protected void Page_Init(object sender, EventArgs e)
        {
            usermoduleIDControl = Int32.Parse(SageUserModuleID);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                gdvColorSetting.DataSource = CreateDataTable();
                gdvColorSetting.DataBind();
                gridlastrowcount();
                LoadPollSettingtoControl();
                LoadPollVoteControlSettingtoControl();
            }

        }

        //datatable for colorsetting
        private DataTable CreateDataTable()
        {
            DataTable dtColors = new DataTable();
            dtColors.Columns.Add("SN");
            dtColors.Columns.Add("OrderNumber");
            dtColors.Columns.Add("ColorName");
            dtColors.Columns.Add("ColorLocalName");
            dtColors.Columns.Add("ColorIsActive");
            dtColors.AcceptChanges();
            List<SageFrameStringKeyValue> poolColorsColl = GetColors();
            for (int i = 0; i < poolColorsColl.Count; i++)
            {
                DataRow dr = dtColors.NewRow();
                dr["SN"] = i.ToString();
                dr["OrderNumber"] = i.ToString();
                dr["ColorName"] = poolColorsColl[i].Value.ToString();
                dr["ColorLocalName"] = poolColorsColl[i].Value.ToString();
                dr["ColorIsActive"] = true;
                dtColors.Rows.Add(dr);
            }
            ViewState["dtColors"] = dtColors;
            return dtColors;
        }

        private List<SageFrameStringKeyValue> GetColors()
        {
            List<SageFrameStringKeyValue> colorsColl = new List<SageFrameStringKeyValue>();
            colorsColl.Add(new SageFrameStringKeyValue("Red", "Red"));
            colorsColl.Add(new SageFrameStringKeyValue("Black", "Black"));
            colorsColl.Add(new SageFrameStringKeyValue("Green", "Green"));
            colorsColl.Add(new SageFrameStringKeyValue("Blue", "Blue"));
            colorsColl.Add(new SageFrameStringKeyValue("White", "White"));
            colorsColl.Add(new SageFrameStringKeyValue("Purple", "Purple"));
            colorsColl.Add(new SageFrameStringKeyValue("Gray", "Gray"));
            colorsColl.Add(new SageFrameStringKeyValue("Orange", "Orange"));
            colorsColl.Add(new SageFrameStringKeyValue("Yellow", "Yellow"));
            return colorsColl;
        }

       
        //for poll Setting
        private void SaveSetting(string key, string value)
        {
            dbpoll.sp_PollSettingUpdate(ref _pollSettingValueID, usermoduleIDControl, key, value, true, GetPortalID,
                GetUsername, GetUsername);
        }
        private void LoadPollSettingtoControl()
        {
            try
            {
                SettingKey = "ColorOrder";
                var Poll = dbpoll.sp_PollSettingGetAll(usermoduleIDControl, GetPortalID);
                foreach (sp_PollSettingGetAllResult setting in Poll)
                {
                    switch (setting.SettingKey)
                    {
                        case "AnswerCount":
                            txtNumberOfAnswer.Text = setting.SettingValue.ToString();
                            break;
                        case "ColorOrder":
                            for (int i = 0; i < gdvColorSetting.Rows.Count; i++)
                            {
                                HiddenField hdnColorLocalName = (HiddenField)gdvColorSetting.Rows[i].FindControl("hdnColorLocalName");
                                CheckBox chkColorIsActive = (CheckBox)gdvColorSetting.Rows[i].FindControl("chkColorIsActive");
                                char[] split = new char[] { ',' };
                                string[] colorCollection = setting.SettingValue.Split(split);

                                foreach (string color in colorCollection)
                                {
                                    if (color == hdnColorLocalName.Value)
                                    {
                                        chkColorIsActive.Checked = true;
                                    }
                                }
                            }
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }
        private void gridlastrowcount()
        {
            if (gdvColorSetting.Rows.Count > 0)
            {
                int lastRow = gdvColorSetting.Rows.Count - 1;
                gdvColorSetting.Rows[lastRow].FindControl("imbMoveDown").Visible = false;
            }
        }



        protected void imbPollSetting_Click(object sender, ImageClickEventArgs e)
        {
            // HideAll();
            LoadPollSettingtoControl();

        }

        protected void imbPollQuesSetting_Click(object sender, ImageClickEventArgs e)
        {

            LoadPollSettingtoControl();

        }

        //protected void imbPollAnsSetting_Click(object sender, ImageClickEventArgs e)
        //{
        //    HideAll();
        //    pnlPollQuesSetting.Visible = false;
        //    pnlPollSetting.Visible = false;
        //}
        protected void gdvColorSetting_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "Up")
                {
                    OrderRow(e.CommandArgument.ToString(), true);
                }

                if (e.CommandName == "Down")
                {
                    OrderRow(e.CommandArgument.ToString(), false);
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }

        }

        private void OrderRow(string OrderNumber, bool isUp)
        {
            try
            {
                if (ViewState["dtColors"] != null)
                {
                    DataTable dt = (DataTable)ViewState["dtColors"];
                    int rowIndex = 0;
                    #region "CurrentIndex Section"
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (Int32.Parse(dt.Rows[i]["SN"].ToString()) == Int32.Parse(OrderNumber))
                        {
                            rowIndex = i;
                            break;
                        }
                    }
                    #endregion
                    DataRow dtrNew = dt.NewRow();
                    DataRow drC = dt.Rows[rowIndex];
                    if (isUp)
                    {
                        #region "Up"
                        DataRow drU = dt.Rows[rowIndex - 1];
                        string SN = drC["SN"].ToString();
                        string mOrderNumber = drC["OrderNumber"].ToString();
                        string ColorName = drC["ColorName"].ToString();
                        string ColorLocalName = drC["ColorLocalName"].ToString();
                        string ColorIsActive = drC["ColorIsActive"].ToString();
                        dt.Rows[rowIndex]["SN"] = drU["SN"].ToString();
                        dt.Rows[rowIndex]["OrderNumber"] = drU["OrderNumber"].ToString();
                        dt.Rows[rowIndex]["ColorName"] = drU["ColorName"].ToString();
                        dt.Rows[rowIndex]["ColorLocalName"] = drU["ColorLocalName"].ToString();
                        dt.Rows[rowIndex]["ColorIsActive"] = drU["ColorIsActive"].ToString();
                        dt.AcceptChanges();
                        DataRow dtrNewUP = dt.NewRow();
                        dt.Rows[rowIndex - 1]["SN"] = SN;
                        dt.Rows[rowIndex - 1]["OrderNumber"] = mOrderNumber;
                        dt.Rows[rowIndex - 1]["ColorName"] = ColorName;
                        dt.Rows[rowIndex - 1]["ColorLocalName"] = ColorLocalName;
                        dt.Rows[rowIndex - 1]["ColorIsActive"] = ColorIsActive;
                        dt.AcceptChanges();
                        #endregion
                    }
                    else
                    {
                        #region "Down"
                        DataRow drDown = dt.Rows[rowIndex + 1];
                        string SN = drC["SN"].ToString();
                        string mOrderNumber = drC["OrderNumber"].ToString();
                        string ColorName = drC["ColorName"].ToString();
                        string ColorLocalName = drC["ColorLocalName"].ToString();
                        string ColorIsActive = drC["ColorIsActive"].ToString();
                        dt.Rows[rowIndex]["SN"] = drDown["SN"].ToString();
                        dt.Rows[rowIndex]["OrderNumber"] = drDown["OrderNumber"].ToString();
                        dt.Rows[rowIndex]["ColorName"] = drDown["ColorName"].ToString();
                        dt.Rows[rowIndex]["ColorLocalName"] = drDown["ColorLocalName"].ToString();
                        dt.Rows[rowIndex]["ColorIsActive"] = drDown["ColorIsActive"].ToString();
                        dt.AcceptChanges();
                        DataRow dtrNewDown = dt.NewRow();
                        dt.Rows[rowIndex + 1]["SN"] = SN;
                        dt.Rows[rowIndex + 1]["OrderNumber"] = mOrderNumber;
                        dt.Rows[rowIndex + 1]["ColorName"] = ColorName;
                        dt.Rows[rowIndex + 1]["ColorLocalName"] = ColorLocalName;
                        dt.Rows[rowIndex + 1]["ColorIsActive"] = ColorIsActive;
                        dt.AcceptChanges();
                        #endregion
                    }

                    ViewState["dtColors"] = dt;
                    gdvColorSetting.DataSource = dt;
                    gdvColorSetting.DataBind();

                    gridlastrowcount();
                    SettingKey = "ColorOrder";
                    var Poll = dbpoll.sp_PollSettingGetAll(usermoduleIDControl, GetPortalID);
                    foreach (sp_PollSettingGetAllResult setting in Poll)
                    {
                        switch (setting.SettingKey)
                        {
                            case "AnswerCount":
                                txtNumberOfAnswer.Text = setting.SettingValue.ToString();
                                break;

                            case "ColorOrder":
                                for (int i = 0; i < gdvColorSetting.Rows.Count; i++)
                                {
                                    HiddenField hdnColorLocalName = (HiddenField)gdvColorSetting.Rows[i].FindControl("hdnColorLocalName");
                                    CheckBox chkColorIsActive = (CheckBox)gdvColorSetting.Rows[i].FindControl("chkColorIsActive");
                                    char[] split = new char[] { ',' };
                                    string[] colorCollection = setting.SettingValue.Split(split);

                                    foreach (string color in colorCollection)
                                    {
                                        if (color == hdnColorLocalName.Value)
                                        {
                                            chkColorIsActive.Checked = true;
                                        }
                                    }
                                }
                                break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        protected void gdvColorSetting_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    if (e.Row.RowIndex == 0)
                    {
                        e.Row.FindControl("imbMoveUp").Visible = false;
                    }
                    //else if (e.Row.RowIndex == 8)
                    //{
                    //    e.Row.FindControl("imbMoveDown").Visible = false;
                    //}
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);

            }
        }
        private string GetPollImageUrl(string imageName, bool isServerControl)
        {
            string path = string.Empty;
            if (isServerControl == true)
            {
                path = "~/Modules/Poll/Image/" + imageName;
            }
            else
            {
                path = this.Page.ResolveUrl("~/Modules/Poll/Image/" + imageName);
            }
            return path;
        }

        protected void imbPollVoteControl_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SaveSetting("VotingControl", rblPollVoteControl.SelectedValue);
               // SaveSetting("VotingTime", txtVotingTime.Text);
                ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PollSettingSavedSuccessfully"), "", SageMessageType.Success);
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void LoadPollVoteControlSettingtoControl()
        {
            try
            {
                var LinqPollVoteControl = dbpoll.sp_PollSettingGetAll(usermoduleIDControl, GetPortalID);
                foreach (sp_PollSettingGetAllResult setting in LinqPollVoteControl)
                {
                    switch (setting.SettingKey)
                    {
                        case "VotingControl":
                            rblPollVoteControl.SelectedValue = setting.SettingValue.ToString();
                            break;
                        //case "VotingTime":
                        //    txtVotingTime.Text = setting.SettingValue.ToString();
                        //    break;

                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }
       
        protected void imbSavePollSettingSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SaveSetting("AnswerCount", txtNumberOfAnswer.Text);
                SettingKey = "ColorOrder";
                string seletedColorNames = string.Empty;
                //dbpoll.sp_PollSettingUpdate(ref _pollSettingValueID, usermoduleIDControl, SettingKey, txtNumberOfAnswer.Text.Trim(),
                //    true, GetPortalID, GetUsername, GetUsername);
                int count = 0;

                for (int i = 0; i < gdvColorSetting.Rows.Count; i++)
                {
                    CheckBox chkColorIsActive = (CheckBox)gdvColorSetting.Rows[i].FindControl("chkColorIsActive");
                    if (chkColorIsActive.Checked == true)
                    {
                        count += 1;
                        HiddenField hdnColorLocalName = (HiddenField)gdvColorSetting.Rows[i].FindControl("hdnColorLocalName");
                        seletedColorNames = seletedColorNames + hdnColorLocalName.Value.Trim() + ",";
                    }
                }
                if (seletedColorNames.Length > 1 && count == Convert.ToInt32(txtNumberOfAnswer.Text))
                {
                    seletedColorNames = seletedColorNames.Substring(0, seletedColorNames.Length - 1);
                    dbpoll.sp_PollSettingUpdate(ref _pollSettingValueID, usermoduleIDControl, SettingKey, seletedColorNames, true, GetPortalID,
                        GetUsername, GetUsername);


                    ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PollSettingSavedSuccessfully"), "", SageMessageType.Success);
                }
                else
                {
                    ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "EnterNumberOfColorAsNumberOfAnswerRequired"), "", SageMessageType.Alert);
                }

            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }
       
       

    }
}






        



   