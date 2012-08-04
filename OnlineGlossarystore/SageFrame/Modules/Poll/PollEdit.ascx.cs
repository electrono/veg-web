using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Poll;
using SageFrame.Web;
using System.Data;
using SageFrame.Web.Utilities;
using System.Web.UI.HtmlControls;
using System.Text;
using SageFrame.SageFrameClass;

public partial class Modules_Poll_PollEdit : BaseAdministrationUserControl
{
    //declaration for poll editing
    System.Nullable<Int32> _pollQuestionID = 0;
    public Int32 usermoduleIDControl = 0;
    PollDataContext dbPollEdit = new PollDataContext(SystemSetting.SageFrameConnectionString);
    DataSet dsDummy = null; 
    DataTable tbDummy = null;
    DataTable tempRemoveAns = null;
    DataSet dsDummy1 = null;
    DataTable tbDummy1 = null;


    protected void Page_Load(object sender, EventArgs e)
    {
        dsDummy = new DataSet();
        tbDummy = new DataTable();
        if (!Page.IsPostBack)
        {
            AddColumns();
            //Add dummy row to table
            tbDummy.Rows.Add(1, "", "Remove Answer Field","0");
            tbDummy.Rows.Add(2, "", "Remove Answer Field","0");
            tbDummy.Rows.Add(3, "", "Add Answer Field", "0");
            BindWithRepeater();
            AddImageUrls();
            BindPollGrid();
            imbUpdate.Visible = false;
            lblUpdate.Visible = false;
        }

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        usermoduleIDControl = Int32.Parse(SageUserModuleID);
    }

    private void AddImageUrls()
    {
      //  imbPollActiveFromCalender.ImageUrl = GetTemplateImageUrl("imgcalendar.png", true);
      //  imbPollActiveToCalender.ImageUrl = GetTemplateImageUrl("imgcalendar.png", true);
    }

    private void BindPollGrid()
    {
        try
        {
            var linq = dbPollEdit.sp_PollQuestionGetAll(GetPortalID, usermoduleIDControl);
            gdvPollEdit.DataSource = linq;
            gdvPollEdit.DataBind();
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }

    }
    

    protected void gdvPollEdit_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                HiddenField hdnPollQuestionID = e.Row.FindControl("hdnPollQuestionID") as HiddenField;
                Label lblOptions = e.Row.FindControl("lblOptions") as Label;
                StringBuilder strContent = new StringBuilder();
                var LinqPollList = dbPollEdit.sp_PollView(Int32.Parse(hdnPollQuestionID.Value));
                CommonFunction comm = new CommonFunction();
                DataTable dt = comm.LINQToDataTable(LinqPollList);

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    strContent.Append("<div class=\"cssClassPollAnswer\">" + dt.Rows[i]["Answer"].ToString());
                    strContent.Append("</div>");
                }
                strContent.Append("<div class=\"cssClassPollDate\">" + "Poll Active From:" + "<span>" + dt.Rows[0]["PollActiveFrom"].ToString());
                strContent.Append("</div>");
                strContent.Append("<div class=\"cssClassPollDate\">" + "Poll Active To:" + "<span>" + dt.Rows[0]["PollActiveTo"].ToString());
                strContent.Append("</div>");
                lblOptions.Text = strContent.ToString();
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void EditPollbyPollID(int ID)
    {
        try
        {
            ViewState["QuestionID"] = ID;
           
            var linqQuestion = dbPollEdit.sp_PollQuestionGetPollQuestionID(ID);
            CommonFunction commques = new CommonFunction();
            DataTable dtques = commques.LINQToDataTable(linqQuestion);
            for (int i = 0; i < dtques.Rows.Count; i++)
            {
                txtPollQues.Text = dtques.Rows[i]["Question"].ToString();
            }

            foreach (GridViewRow row in gdvPollEdit.Rows)
            {
                HiddenField hdnPollQuestionID = (HiddenField)row.FindControl("hdnPollQuestionID");
                var linqanswer = dbPollEdit.sp_PollView(Int32.Parse(hdnPollQuestionID.Value));
                CommonFunction comm = new CommonFunction();
                DataTable dt = comm.LINQToDataTable(linqanswer);
                txtPollActiveFrom.Text = DateTime.Parse(dt.Rows[0]["PollActiveFrom"].ToString()).ToShortDateString();
                txtPollActiveTo.Text = DateTime.Parse(dt.Rows[0]["PollActiveTo"].ToString()).ToShortDateString(); 
            }
            // HiddenField hdnPollQuestionID = ((HiddenField)item.FindControl("hdnPollQuestionID"));
            //foreach (RepeaterItem item in RepeaterAnswers.Items)
            //{
                dsDummy1= new DataSet();
                tbDummy1= new DataTable();
                
                //TextBox txtAnswer = ((TextBox)item.FindControl("txtAnswer"));
                var linqans = dbPollEdit.sp_PollView(ID);
                CommonFunction comms = new CommonFunction();
                DataTable dtAns = comms.LINQToDataTable(linqans);
            
                tbDummy1.Columns.Add("ID");
                tbDummy1.Columns.Add("Answer");
                tbDummy1.Columns.Add("Button");
                tbDummy1.Columns.Add("PollOptionID");
                for (int i = 0; i < dtAns.Rows.Count; i++)
                {
                    tbDummy1.Rows.Add(i + 1, dtAns.Rows[i]["Answer"], "Remove Answer Field", dtAns.Rows[i]["PollOptionID"]);
                   
                }
                tbDummy1.Rows.Add(dtAns.Rows.Count+1, "", "Add Answer Field", 0);
                dsDummy1.Tables.Add(tbDummy1);                
                RepeaterAnswers.DataSource = dsDummy1;
                RepeaterAnswers.DataBind();

                foreach (RepeaterItem item in RepeaterAnswers.Items)
                {
                    ImageButton btnDel = ((ImageButton)item.FindControl("btnAddAnother"));
                    btnDel.ImageUrl = GetPollImageUrl("btndelete.png", true);
                }
                ImageButton btnAdd = ((ImageButton)RepeaterAnswers.Items[RepeaterAnswers.Items.Count - 1].FindControl("btnAddAnother"));
                btnAdd.ImageUrl = GetPollImageUrl("btnadd.png", true);
                
                //string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                //txtAnswer.Text = title;
                //foreach (GridViewRow rowItem in gdvPollEdit.Rows)
                //{
                //    HiddenField hdnPollOptionID = (HiddenField)(rowItem.Cells[i].FindControl("hdnPollOptionID"));
                //    dbPollEdit.sp_PollOptionDeletebyPollOptionD(int.Parse(hdnPollOptionID.Value), GetPortalID);
                //}
           // }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    protected void gdvPollEdit_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int Id = int.Parse(e.CommandArgument.ToString());
        switch (e.CommandName)
        {
            case "Edit":
                EditPollbyPollID(Id);
              //  HideAll();
                imbUpdate.Visible = true;
                lblUpdate.Visible = true;
                imbSave.Visible = false;
                lblSave.Visible = false;
              //  pnlPollQuesSetting.Visible = true;
                break;
            case "Delete":
                try
                {
                    dbPollEdit.sp_PollDeletebyPollQuestionID(Id, GetPortalID);
                    ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PollDeletedSuccessfully"), "", SageMessageType.Success);
                    BindPollGrid();
                }

                catch (Exception ex)
                {
                    ProcessException(ex);
                }

                break;
        }
    }
    private void HideAll()
    {
      //  pnlPollQuesSetting.Visible = false;
    }
    protected void gdvPollEdit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gdvPollEdit.PageIndex = e.NewPageIndex;
    }

    protected void imbSave_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            int count = 0;
          //  var LINQPollAnswerCount = dbPollEdit.sp_PollSettingByValueSettingList();
           var LINQPollAnswerCount = dbPollEdit.sp_PollSettingGetAll(usermoduleIDControl, GetPortalID);
            string PollAnswerCount = string.Empty;
            foreach (sp_PollSettingGetAllResult Pollanswer in LINQPollAnswerCount)
            {
                switch (Pollanswer.SettingKey)
                {
                    case "AnswerCount":
                        PollAnswerCount = Pollanswer.SettingValue.ToString();
                        break;
                }
            }

            for (int i = 1; i <= RepeaterAnswers.Items.Count; i++)
            {
                count ++;
            }
            

                if (txtPollActiveFrom.Text != "" && txtPollActiveTo.Text != "" && count==int.Parse(PollAnswerCount))
                {
                    dbPollEdit.sp_PollQuestionAdd(txtPollQues.Text.Trim(), true, GetPortalID, DateTime.Now,
                        GetUsername, DateTime.Parse(txtPollActiveFrom.Text.Trim()), DateTime.Parse(txtPollActiveTo.Text.Trim()), usermoduleIDControl,
                        GetCurrentCultureName, ref _pollQuestionID);


                    foreach (RepeaterItem item in RepeaterAnswers.Items)
                    {
                        
                        string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                        dbPollEdit.sp_PollOptionAdd(_pollQuestionID, title, true, GetPortalID, DateTime.Now,
                         GetUsername, usermoduleIDControl, GetCurrentCultureName);
                    }

                    ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PollQuestionAndAnswerSavedSuccessfully"), "", SageMessageType.Success);
                    Response.Redirect(Request.Url.ToString());
                }
                else
                {
                    ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "EnterTheNumberOfAnswerAsSetInSettingPage"), "", SageMessageType.Success);
                }
            }
       
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void AddColumns()
    {
        try
        {
            tbDummy.Columns.Add("ID");
            tbDummy.Columns.Add("Answer");
            tbDummy.Columns.Add("Button");
            tbDummy.Columns.Add("PollOptionID");
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    public string GetPollImageUrl(string imageName, bool isServerControl)
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
    private void BindWithRepeater()
    {
        try
        {
            //add this table to dataset
            dsDummy.Tables.Add(tbDummy);

            //bind this dataset to repeater
            RepeaterAnswers.DataSource = dsDummy;
            RepeaterAnswers.DataBind();

            foreach (RepeaterItem item in RepeaterAnswers.Items)
            {
                string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                ImageButton btnDel = ((ImageButton)item.FindControl("btnAddAnother"));
                btnDel.ImageUrl = GetPollImageUrl("btndelete.png", true);
            }
            ImageButton btnAdd = ((ImageButton)RepeaterAnswers.Items[RepeaterAnswers.Items.Count - 1].FindControl("btnAddAnother"));
            btnAdd.ImageUrl = GetPollImageUrl("btnadd.png", true);
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    protected void RepeaterAnswers_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        try
        {
            int Total = RepeaterAnswers.Items.Count;

            if (e.CommandName == "Add Answer Field")
            {
                Total = Total + 1;
                AddColumns();
                int ID = 1;
                foreach (RepeaterItem item in RepeaterAnswers.Items)
                {
                    HiddenField hdnPollOptionID = (HiddenField)item.FindControl("hdnPollOptionID");
                    string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                    ImageButton btnAdd = ((ImageButton)item.FindControl("btnAddAnother"));
                    tbDummy.Rows.Add(ID++, title, "Remove Answer Field", hdnPollOptionID.Value);
                }
                tbDummy.Rows.Add(ID++, "", "Add Answer Field", "0");

                BindWithRepeater();
            }

            else if (e.CommandName == "Remove Answer Field")
            {
                Total = Total - 1;

                tbDummy.Columns.Add("ID");
                tbDummy.Columns.Add("Answer");
                tbDummy.Columns.Add("Button");
                tbDummy.Columns.Add("PollOptionID");
                int ID = 1;
                foreach (RepeaterItem item in RepeaterAnswers.Items)
                {
                    // Button btnAdd = ((Button)item.FindControl("btnAddAnother"));
                    ImageButton btnAdd = ((ImageButton)item.FindControl("btnAddAnother"));
                    HiddenField hdnPollOptionID = (HiddenField)item.FindControl("hdnPollOptionID");
                    // btnAdd.ImageUrl = GetPollImageUrl("btndelete.png", true);
                    string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                    if (btnAdd != e.CommandSource)
                    {
                        if (btnAdd.ToolTip == "Remove Answer Field")
                        {
                            tbDummy.Rows.Add(ID++, title, "Remove Answer Field", hdnPollOptionID.Value);
                        }
                        else
                        {
                            tbDummy.Rows.Add(ID++, title, "Add Answer Field", hdnPollOptionID.Value);
                        }
                    }
                    else
                    {
                        if (ViewState["TableRemoveAns"] == null)
                        {
                            tempRemoveAns = new DataTable();
                            tempRemoveAns.Columns.Add("ID");
                            tempRemoveAns.Columns.Add("Answer");
                            tempRemoveAns.Columns.Add("Button");
                            tempRemoveAns.Columns.Add("PollOptionID");
                        }
                        else
                        {
                            tempRemoveAns = (DataTable)ViewState["TableRemoveAns"];
                        }
                        tempRemoveAns.Rows.Add(ID++, title, "Remove Answer Field", hdnPollOptionID.Value);
                        ViewState["TableRemoveAns"] = tempRemoveAns;
                    }
                }
                BindWithRepeater();
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
    protected void gdvPollEdit_RowEditing(object sender, GridViewEditEventArgs e)
    {

    }
    protected void gdvPollEdit_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gdvPollEdit_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }

    protected void imbUpdate_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (txtPollActiveFrom.Text != "" && txtPollActiveTo.Text != "")
            {
                if (ViewState["QuestionID"] != null)
                {
                    dbPollEdit.sp_PollQuestionAddUpdateByID(txtPollQues.Text.Trim(), true, GetPortalID,
                        DateTime.Now, GetUsername, DateTime.Parse(txtPollActiveFrom.Text.Trim()), DateTime.Parse(txtPollActiveTo.Text.Trim()),
                        usermoduleIDControl, GetCurrentCultureName, Int32.Parse(ViewState["QuestionID"].ToString()), ref _pollQuestionID);
                }
                foreach (RepeaterItem item in RepeaterAnswers.Items)
                {
                    HiddenField hdnPollOptionID = ((HiddenField)item.FindControl("hdnPollOptionID"));

                    string title = ((TextBox)item.FindControl("txtAnswer")).Text;
                    if (title.Trim() != "")
                    {
                        dbPollEdit.sp_PollOptionAddUpdateByID(Int32.Parse(ViewState["QuestionID"].ToString()), int.Parse(hdnPollOptionID.Value), title,
                            true, GetPortalID, DateTime.Now, GetUsername, usermoduleIDControl, GetCurrentCultureName);
                    }                   

                }
                if (ViewState["TableRemoveAns"] != null)
                {
                    tempRemoveAns = (DataTable)ViewState["TableRemoveAns"];
                    foreach (DataRow dr in tempRemoveAns.Rows)
                    {
                        dbPollEdit.sp_PollOptionDeletebyPollOptionD(int.Parse(dr["PollOptionID"].ToString()), GetPortalID, usermoduleIDControl);
                    }
                }
               // pnlPollQuesSetting.Visible = true;
                ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PollQuestionAndAnswerSavedSuccessfully"), "", SageMessageType.Success);
                Response.Redirect(Request.Url.ToString());
            }
            else
            {
                ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "PleaseEnterThePollDate"), "", SageMessageType.Success);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
        BindPollGrid();

    }

}

