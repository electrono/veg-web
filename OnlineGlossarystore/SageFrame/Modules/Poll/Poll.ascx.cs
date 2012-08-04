using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using SageFrame.Web;
using SageFrame.Poll;
using System.Text;
using System.Data;
using SageFrame.Web.Utilities;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
namespace SageFrame.Modules.Poll
{
    public partial class Poll : BaseAdministrationUserControl
    {
        PollDataContext dbpoll = new PollDataContext(SystemSetting.SageFrameConnectionString);
        public Int32 usermoduleID = 0;
        string SettingKey = string.Empty;
        CommonFunction CF = new CommonFunction();
        // System.Nullable<Int32> _PollQuestionID = 0;
        // System.Nullable<Int32> _PollOptionID = 0;

        protected void Page_Init(object sender, EventArgs e)
        {
            usermoduleID = Int32.Parse(SageUserModuleID);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCSS();
                getpollquestion();
                pnlViewResult.Visible = false;                
                imbGoBack.Visible = false;
                lblGoBack.Visible = false;
            }
        }

        private void LoadCSS()
        {
            IncludeCssFile("~/Modules/Poll/css/module.css");
        }

        public DataSet GetSettingsByPortalAndSettingType(string usermoduleID, string QuestionID, string PortalID, string Username)
        {
            try
            {
                List<KeyValuePair<string, string>> ParaMeterCollection = new List<KeyValuePair<string, string>>();
                ParaMeterCollection.Add(new KeyValuePair<string, string>("@usermoduleID", usermoduleID));
                ParaMeterCollection.Add(new KeyValuePair<string, string>("@QuestionID", QuestionID));
                ParaMeterCollection.Add(new KeyValuePair<string, string>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, string>("@Username", Username));
                DataSet ds = new DataSet();
                SQLHandler sagesql = new SQLHandler();
                ds = sagesql.ExecuteAsDataSet("dbo.sp_PollAnswerList", ParaMeterCollection);
                return ds;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public DataTable GetSettingsByPortal(string usermoduleID, string QuestionID, string PortalID, string Username)
        {
            try
            {
                DataTable dt = new DataTable();
                DataSet ds = GetSettingsByPortalAndSettingType(usermoduleID, QuestionID, PortalID, Username);
                if (ds != null && ds.Tables != null && ds.Tables[0] != null)
                {
                    dt = ds.Tables[0];
                }
                return dt;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        //fxn for pollresultview

        private void getresult()
        {
            try
            {
                var linqtotalvotecount = dbpoll.sp_PollTotalCount(int.Parse(hdnQuestionID.Value)).SingleOrDefault();
                lblPollTotalVoteCount.Text = "Total Vote Count:" + linqtotalvotecount.TotalVotes;
                lblPollTotalVoteCount.Font.Bold = true;
                pnlOption.Visible = false;
                pnlViewResult.Visible = true;
                //imbvote.Visible = false;
                btnvote.Visible = false;
              //  imbviewresult.Visible = false;
                btnviewresult.Visible = false;
                SettingKey = "ColorOrder";
                var linqcolorarray = dbpoll.sp_PollSettingGetAllColor(usermoduleID, GetPortalID, SettingKey).SingleOrDefault();
                string[] arrColor = linqcolorarray.SettingValue.Split(",".ToCharArray());
                var linqviewresult = dbpoll.sp_PollReportByPollQuestionID(int.Parse(hdnQuestionID.Value), GetPortalID, GetUsername);
                CommonFunction CF = new CommonFunction();
                DataTable dt = CF.LINQToDataTable(linqviewresult);
                Table tblPoll = new Table();
                tblPoll.ID = "tblPoll";
                tblPoll.Width = Unit.Parse("243");
                tblPoll.CellPadding = 0;
                tblPoll.CellSpacing = 0;
                tblPoll.BorderWidth = 0;
                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TableRow tblpolltr = new TableRow();
                        TableCell tblpollltd = new TableCell();
                        tblpollltd.Width = Unit.Parse("150");
                        HtmlGenericControl divViewResult = new HtmlGenericControl("div");
                        if (i < arrColor.Length)
                        {
                            string CurrentColor = arrColor[i].ToString();
                            string divClassName = "cssClassColorScheme_" + CurrentColor;
                            divViewResult.Attributes.Add("class", divClassName);
                        }
                        else
                        {
                            string divClassName = "cssClassColorScheme_Yellow";
                            divViewResult.Attributes.Add("class", divClassName);
                        }
                        string divstyleWidth = "width:" + dt.Rows[i]["VotePercentage"].ToString() + "%";
                        divViewResult.Attributes.Add("style", divstyleWidth);
                        tblpollltd.Controls.Add(divViewResult);
                        tblpolltr.Controls.Add(tblpollltd);
                        TableCell tblpollrtd = new TableCell();
                        tblpollrtd.Width = Unit.Parse("139");
                        string PoolResultText = dt.Rows[i]["VotePercentage"].ToString() + "%" + " " + dt.Rows[i]["Answer"].ToString();
                        tblpollrtd.Text = PoolResultText;
                        tblpollrtd.CssClass = "cssClassNoBorder";
                        tblpolltr.Controls.Add(tblpollrtd);
                        tblPoll.Controls.Add(tblpolltr);
                    }
                    divResult.Controls.Add(tblPoll);
                }

                //imbGoBack.Visible = true;
                //lblGoBack.Visible = true;
                //lblvote.Visible = false;
                //lblviewresult.Visible = false;
                //pnlOption.Visible = true;
            }

            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void getpollquestion()
        {
            try
            {
                var LINQCheckQues = dbpoll.sp_PollCheckQuestionList(usermoduleID);
                if (LINQCheckQues != null)
                {                    
                    foreach (sp_PollCheckQuestionListResult Ques in LINQCheckQues)
                    {
                        if (Ques.QuestionCount >= 1)
                        {
                            int questionID = 0;
                            var LINQQues = dbpoll.sp_PollQuestionGet(GetPortalID, usermoduleID);
                            foreach (sp_PollQuestionGetResult ques in LINQQues)
                            {
                                lblQuestion.Text = ques.Question;
                                hdnQuestionID.Value = ques.PollQuestionID.ToString();
                                questionID = ques.PollQuestionID;
                            }
                            var LINQAns = dbpoll.sp_PollAnswerList(usermoduleID, questionID, GetPortalID, GetUsername);
                            rdopollanswerlist.DataSource = LINQAns;
                            rdopollanswerlist.DataValueField = "PollOptionID";
                            rdopollanswerlist.DataTextField = "Answer";
                            rdopollanswerlist.DataBind();
                            pnlOption.Visible = true;
                        }
                        else
                        {
                            pnlOption.Visible = false;
                            //imbvote.Visible = false;
                            btnvote.Visible = false;
                            //  imbviewresult.Visible = false;
                            btnviewresult.Visible = false;
                            ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "NoPollQuestion"), "", SageMessageType.Alert);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }



        protected void imbGoBack_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                pnlOption.Visible = true;
                lblPollTotalVoteCount.Visible = false;
               // imbvote.Visible = true;
                btnvote.Visible = true;
                //imbviewresult.Visible = true;
                btnviewresult.Visible = true;
                imbGoBack.Visible = false;
                lblGoBack.Visible = false;
                ClearForm();
                Response.Redirect(Request.Url.ToString());
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }
        }

        private void ClearForm()
        {
            rdopollanswerlist.SelectedIndex = -1;
        }
        
       
        protected void btnvote_Click(object sender, EventArgs e)
        {
            try
            {
                if (rdopollanswerlist.SelectedItem != null)
                {
                    var LINQPollVoteControl = dbpoll.sp_PollSettingByValueSettingList();

                    //var LINQPollVoteControl = dbpoll.sp_PollSettingGetAll(usermoduleID, GetPortalID);
                    string votecontrol = string.Empty;
                    foreach (sp_PollSettingByValueSettingListResult vote in LINQPollVoteControl)
                    {
                        switch (vote.SettingKey)
                        {
                            case "VotingControl":
                                votecontrol = vote.SettingValue.ToString();
                                break;
                        }
                    }

                    if (votecontrol == "2" || votecontrol == "4")
                    {
                        int counter = 0;
                        var checkusername = dbpoll.sp_PollCheckUsername(GetUsername, GetPortalID, this.Context.Request.UserHostAddress,
                            int.Parse(hdnQuestionID.Value));
                        foreach (sp_PollCheckUsernameResult checkuser in checkusername)
                        {
                            counter = int.Parse(checkuser.CountUser.ToString());
                        }
                        if (counter == 0 || GetUsername == SystemSetting.SYSTEM_USER_NOTALLOW_HTMLCOMMENT[0])
                        {
                            if (Session["anonymoususer"] == null)
                            {
                                dbpoll.sp_PollAddandUpdate(int.Parse(hdnQuestionID.Value), int.Parse(rdopollanswerlist.SelectedItem.Value),
                                    this.Context.Request.UserHostAddress, GetUsername, true, GetPortalID, GetUsername);
                                Session["anonymoususer"] = GetUsername;
                                ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "ThankyouForYourVote"), "", SageMessageType.Success);
                            }
                            else
                            {
                                ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "YouHadAlreadyVotedThisPoll"), "", SageMessageType.Alert);

                            }
                        }
                        else
                        {
                            ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "YouHadAlreadyVotedThisPoll"), "", SageMessageType.Alert);
                        }
                    }

                 else if (votecontrol == "1")
                    {
                        if (Session["ClientIP"] == null)
                        {
                            Session["ClientIP"] = this.Context.Request.UserHostAddress;
                            dbpoll.sp_PollAddandUpdate(int.Parse(hdnQuestionID.Value), int.Parse(rdopollanswerlist.SelectedItem.Value), this.Context.Request.UserHostAddress,
                               GetUsername, true, GetPortalID, GetUsername);
                            ShowMessage(SageMessageTitle.Information.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "ThankyouForYourVote"), "", SageMessageType.Success);
                        }
                        else
                        {
                            ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "YouHadAlreadyVotedThisPoll"), "", SageMessageType.Alert);
                        }
                    }

                  else if (votecontrol == "3")
                    {
                        dbpoll.sp_PollAddandUpdate(int.Parse(hdnQuestionID.Value), int.Parse(rdopollanswerlist.SelectedItem.Value), this.Context.Request.UserHostAddress,
                              GetUsername, true, GetPortalID, GetUsername);
                        ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "ThankyouForYourVote"), "", SageMessageType.Success);
                    }

                    else
                    {
                        ShowMessage(SageMessageTitle.Notification.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "YouHadAlreadyVotedThisPoll"), "", SageMessageType.Alert);
                    }
                    getresult();
                    imbGoBack.Visible = true;
                    lblGoBack.Visible = true;
                }

                else
                {
                    ShowMessage(SageMessageTitle.Exception.ToString(), SageMessage.GetSageModuleLocalMessageByVertualPath("Modules/Poll/ModuleLocalText", "ChooseYourAnswerAndThenVote"), "", SageMessageType.Alert);
                }
            }
            catch (Exception ex)
            {
                ProcessException(ex);
            }

        }
        protected void btnviewresult_Click(object sender, EventArgs e)
        {
            try
            {
                var linqtotalvotecount = dbpoll.sp_PollTotalCount(int.Parse(hdnQuestionID.Value)).SingleOrDefault();
                lblPollTotalVoteCount.Text = "Total Vote Count:" + linqtotalvotecount.TotalVotes;
                lblPollTotalVoteCount.Font.Bold = true;
                pnlOption.Visible = false;
                pnlViewResult.Visible = true;
                btnvote.Visible = false;
                btnviewresult.Visible = false;
                SettingKey = "ColorOrder";
                var linqcolorarray = dbpoll.sp_PollSettingGetAllColor(usermoduleID, GetPortalID, SettingKey).SingleOrDefault();
                string[] arrColor = linqcolorarray.SettingValue.Split(",".ToCharArray());
                var linqviewresult = dbpoll.sp_PollReportByPollQuestionID(int.Parse(hdnQuestionID.Value), GetPortalID, GetUsername);
                CommonFunction CF = new CommonFunction();
                DataTable dt = CF.LINQToDataTable(linqviewresult);
                Table tblPoll = new Table();
                tblPoll.ID = "tblPoll";
                tblPoll.Width = Unit.Parse("243");
                tblPoll.CellPadding = 0;
                tblPoll.CellSpacing = 0;
                tblPoll.BorderWidth = 0;
                if (dt != null && dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        TableRow tblpolltr = new TableRow();
                        TableCell tblpollltd = new TableCell();
                        tblpollltd.Width = Unit.Parse("150");
                        HtmlGenericControl divViewResult = new HtmlGenericControl("div");
                        if (i < arrColor.Length)
                        {
                            string CurrentColor = arrColor[i].ToString();
                            string divClassName = "cssClassColorScheme_" + CurrentColor;
                            divViewResult.Attributes.Add("class", divClassName);
                        }
                        else
                        {
                            string divClassName = "cssClassColorScheme_Yellow";
                            divViewResult.Attributes.Add("class", divClassName);
                        }                        
                        string divstyleWidth = "width:" + dt.Rows[i]["VotePercentage"].ToString() + "%";
                        divViewResult.Attributes.Add("style", divstyleWidth);
                        tblpollltd.Controls.Add(divViewResult);
                        tblpolltr.Controls.Add(tblpollltd);
                        TableCell tblpollrtd = new TableCell();
                        tblpollrtd.Width = Unit.Parse("139");
                        string PoolResultText = dt.Rows[i]["VotePercentage"].ToString() + "%" + " " + dt.Rows[i]["Answer"].ToString();
                        tblpollrtd.Text = PoolResultText;
                        tblpollrtd.CssClass = "cssClassNoBorder";
                        tblpolltr.Controls.Add(tblpollrtd);
                        tblPoll.Controls.Add(tblpolltr);
                    }
                    divResult.Controls.Add(tblPoll);
                }
                imbGoBack.Visible = true;
                lblGoBack.Visible = true;
                pnlViewResult.Visible = true;
            }

            catch (Exception ex)
            {
                ProcessException(ex);
            }

        }
    }
}












