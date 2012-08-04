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
using SageFrame.Framework;
using SageFrame.SageFrameClass;
using System.IO;
using System.Xml;
using SageFrame.Web.Utils;
using System.Text.RegularExpressions;
using SageFrame.Web;
using System.Data.Common;
using System.Data.SqlClient;
using SageFrame.Utilities;
using System.Text;
using System.Data;
using System.ComponentModel;
using System.Collections;
using System.Security.AccessControl;
using System.Security.Principal;

namespace SageFrame.Install
{
    public partial class InstallWizard : System.Web.UI.Page
    {

        #region "Private Members"

        private static string connectionString = string.Empty;
        private System.Version _DataBaseVersion;
        //private XmlDocument _installTemplate; 

        #endregion


        #region Protected Members
        protected bool PermissionsValid
        {
            get
            {
                bool _Valid = false;
                if ((ViewState["PermissionsValid"] != null))
                {
                    _Valid = Convert.ToBoolean(ViewState["PermissionsValid"]);
                }
                return _Valid;
            }
            set { ViewState["PermissionsValid"] = value; }
        }

        protected string Versions
        {
            get
            {
                string _Versions = string.Empty;
                if ((ViewState["Versions"] != null))
                {
                    _Versions = Convert.ToString(ViewState["Versions"]);
                }
                return _Versions;
            }
            set { ViewState["Versions"] = value; }
        }


        protected System.Version DatabaseVersion
        {
            get
            {
                if (_DataBaseVersion == null)
                {
                    _DataBaseVersion = Config.GetDatabaseVersion();
                }
                return _DataBaseVersion;
            }
        }

        #endregion

        protected void Page_PreRender(object sender, System.EventArgs e)
        {
            //Make sure that the password is not cleared on postback
            //txtPassword.Attributes["value"] = txtPassword.Text;
            if (Session["UserPassword"] != null)
            {
                txtPassword.Attributes.Add("value", Session["UserPassword"].ToString());
            }
            Session["UserPassword"] = null;
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            //LoadControl(phdLogo, "~/Controls/ctl_Logo.ascx");
            //divLogo.Attributes.Add("style", "display:block;");

            //Attach Event(s) to the Buttons
            Button customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
            if ((customButton != null))
            {
                customButton.Click += wizInstallWizard_CustomButtonClick;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblHostWarning.Visible = !Regex.IsMatch(Request.Url.Host, "^([a-zA-Z0-9.-]+)$", RegexOptions.IgnoreCase);

                //HomeURL = Page.ResolveUrl("~/" + CommonHelper.DefaultPage);
                if (!IsPostBack)
                {
                    AddImageUrls();
                    BindWizardControls();
                    //Parse the connection String to the form
                    BindConnectionString();

                    //Database Choices
                    BindDatabases();

                    if (TestDatabaseConnection())
                    {
                        Initialise();
                        rblInstallType.SelectedIndex = 1;
                        lblDataBaseWarning.Visible = false;
                    }
                    else
                    {
                        rblInstallType.SelectedIndex = 0;
                        rblInstallType.Items[1].Enabled = false;
                        lblDataBaseWarning.Visible = true;
                    }

                    BindLabelText();
                    wizInstallWizard.ActiveStepIndex = 0;
                    SetupPage();
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void chkIntegrated_CheckedChanged(object sender, EventArgs e)
        {
            trUser.Visible = !chkIntegrated.Checked;
            trPassword.Visible = !chkIntegrated.Checked;
            //if (chkIntegrated.Checked)
            //{
            //    chkOwner.Checked = true;
            //}
            //chkOwner.Enabled = !chkIntegrated.Checked;
        }

        #region Permission Region

        private void BindPermissions(bool test)
        {
            ///Test Strategy 1
            try
            {
                SageFrame.Application.Application app = new SageFrame.Application.Application();

                PermissionsValid = true;

                lstPermissions.Items.Clear();

                //FolderCreate
                ListItem permissionItem = new ListItem();
                if (test)
                    permissionItem.Selected = VerifyFolderCreate();
                permissionItem.Enabled = false;
                permissionItem.Text = "Create Folder";
                lstPermissions.Items.Add(permissionItem);

                //FileCreate
                permissionItem = new ListItem();
                if (test)
                    permissionItem.Selected = VerifyFileCreate();
                permissionItem.Enabled = false;
                permissionItem.Text = "Create File";
                lstPermissions.Items.Add(permissionItem);

                //FileDelete
                permissionItem = new ListItem();
                if (test)
                    permissionItem.Selected = VerifyFileDelete();
                permissionItem.Enabled = false;
                permissionItem.Text = "Delete File";
                lstPermissions.Items.Add(permissionItem);

                //FolderDelete
                permissionItem = new ListItem();
                if (test)
                    permissionItem.Selected = VerifyFolderDelete();
                permissionItem.Enabled = false;
                permissionItem.Text = "Delete Folder";
                lstPermissions.Items.Add(permissionItem);
            }
            catch (Exception ex)
            {
                throw ex;
            }
           
            if (!test)
            {
               
                string strPermissionsError ="<br> Your site failed the permissions check. Using Windows Explorer, browse to the root folder of the website ( {0} ). Right-click the folder and select Sharing and Security from the popup menu. Select the Security tab. Add the appropriate User Account and set the Permissions.<h3>If using Windows 2000 - IIS5</h3>The {Server}\\ASPNET User Account must have Read, Write, and Change Control of the virtual root of your website.<h3>If using Windows 2003, Windows Vista or Windows Server 2008 and  IIS6 or IIS7</h3>The NT AUTHORITY\\NETWORK SERVICE User Account must have Read, Write, and Change Control of the virtual root of your Website.<h3>If using Windows 7 or Windows Server 2008 R2 and  IIS7.5</h3>The IIS AppPool\\DefaultAppPool User Account must have Read, Write, and Change Control of the virtual root of your Website.";
                lblPermissionsError.Text = strPermissionsError.Replace("{0}", Request.ApplicationPath);
                lblPermissionsError.CssClass = "cssClasssNormalRed";
               
            }
            else
            {
                lblPermissionsError.Text = "Your site passed all the permissions check.";
                lblPermissionsError.CssClass = "cssClasssNormalGreen";
                PermissionsValid = true;
            }
            lblPermissionsError.Visible = true;
        }

        private bool VerifyFolderCreate()
        {
            string verifyPath = Server.MapPath("~/Verify");
            bool verified = true;

            //Attempt to create the Directory
            try
            {
                if (Directory.Exists(verifyPath))
                {
                    Directory.Delete(verifyPath, true);
                }

                Directory.CreateDirectory(verifyPath);
            }
            catch (Exception ex)
            {
                verified = false;
                throw ex;
            }
            if (!verified)
                PermissionsValid = false;

            return verified;
        }

        private bool VerifyFolderDelete()
        {
            string verifyPath = Server.MapPath("~/Verify");
            bool verified = VerifyFolderCreate();

            if (verified)
            {
                //Attempt to delete the Directory
                try
                {
                    Directory.Delete(verifyPath);
                }
                catch (Exception ex)
                {
                    verified = false;
                    throw ex;
                }
            }
            if (!verified)
                PermissionsValid = false;

            return verified;
        }

        private bool VerifyFileCreate()
        {
            string verifyPath = Server.MapPath("~/Verify/Verify.txt");
            bool verified = VerifyFolderCreate();

            if (verified)
            {
                //Attempt to create the File
                try
                {
                    if (File.Exists(verifyPath))
                    {
                        File.Delete(verifyPath);
                    }

                    Stream fileStream = File.Create(verifyPath);
                    fileStream.Close();
                }
                catch (Exception ex)
                {
                    verified = false;
                    throw ex;
                }
            }
            if (!verified)
                PermissionsValid = false;

            return verified;
        }

        private bool VerifyFileDelete()
        {
            string verifyPath = Server.MapPath("~/Verify/Verify.txt");
            bool verified = VerifyFileCreate();

            if (verified)
            {
                //Attempt to delete the File
                try
                {
                    File.Delete(verifyPath);
                }
                catch (Exception ex)
                {
                    verified = false;
                    throw ex;
                }
            }
            if (!verified)
                PermissionsValid = false;

            return verified;
        }

       

        #endregion

        #region Binding Controls
        private void AddImageUrls()
        {
            imgDBProgress.ImageUrl = "~/Install/images/progressbar.gif";
        }

        private void BindLabelText()
        {
            SageFrame.Application.Application app = new SageFrame.Application.Application();
            Label lblTitle = wizInstallWizard.FindControl("HeaderContainer").FindControl("lblTitle") as Label;
            Label lblVersion = wizInstallWizard.FindControl("HeaderContainer").FindControl("lblVersion") as Label;
            if (lblTitle != null)
            {
                lblTitle.Text = "Installation";
            }
            if (lblVersion != null)
            {
                lblVersion.Text = app.Version.ToString();//String.Format(" Version {0}", app.Version);
            }

            lblStepfirstTitle.Text = string.Format("SageFrame Upgrade Wizard - Version {0}", app.FormatVersion(app.Version, true));//app.Version.ToString(3)
            //"<p>SageFrame version {0} is already Installed. Click the Next button to upgrade to the new version.</p>"
            lblStepfirstDetail.Text = "Welcome to the SageFrame Installation Wizard. This wizard will guide you through the installation of your SageFrame Application. You may navigate through the Wizard using the Next and Previous buttons.  On some pages you will see a third button 'Test ...'.  This button will allow you to test the configuration before you continue, to see the effects of changes. The first step is to select the installation method to use, you would like to use for the Installation.";
            lblChooseInstall.Text = "Select Installation Method:";

            lblFilePermissionsTitle.Text = "Checking File Permissions";
            lblFilePermissionsDetail.Text = "SageFrame has extensive file upload capabilities for content, modules, and skins. These features require custom security settings so that the application is able to create and remove files in your website. This page checks the current file permissions to ensure that these features will work correctly. Note: The test checks the root folder of your application.  In most cases this is good enough, as child folders usually inherit their file and folder permissions from their parent.  However, occasionally this test will pass, but there will be a more restrictive permission set on one of the descendant files/folders.";
            lblPermissions.Text = "File Permissions Summary:";
            BindPermissions(false);

            lblConnectionStringTitle.Text = "Configure Database Connection";
            lblConnectionStringDetail.Text = "You can configure the database settings used by SageFrame on this page. If you are installing SageFrame in a 'Hosting Account' your  hosting provider should have provided you with the information. In most situations, you should choose the Database option.";
            lblChooseDatabase.Text = "Select Database:";
            lblServer.Text = "Server:";
            lblServerHelp.Text = "Enter the Name or IP Address of the computer where the Database is located.";
            lblDataBase.Text = "Database:";
            lblDatabaseHelp.Text = "Enter the Database name";
            lblIntegrated.Text = "Integrated Security:";
            lblIntegratedHelp.Text = "Check this if you are using SQL Server's Integrated Security, which means you will be using your Windows account to access SQL Server. If you are using SQL Server Express then you will most likely need to check this option. If you have been given a UserId/Password to access your Database, leave this unchecked, and provide the UserId/Password combination.";
            lblUserID.Text = "User ID:";
            lblUserHelp.Text = "Enter the UserID for the Database";
            lblPassword.Text = "Password:";
            lblPasswordHelp.Text = "Enter the Password for the Database";
            lblOwner.Text = "Run as db Owner:";
            lblOwnerHelp.Text = "Check this if you are running the database as Database Owner - if left unchecked you will be running as the User ID specified";

            lblStepDatabaseTitle.Text = "Run Database Installation Scripts";
            lblStepDatabaseDetail.Text = "The installation of the database scripts should have started when this page loaded.  The Next button will be disabled until the Installation of the Scripts is complete.";

            lblStepDataBaseFeedBackTitle.Text = "Run Database Installation Scripts";
            lblStepDataBaseFeedBackDetail.Text = "The installation of the database scripts should have started when this page loaded.  The Next button will be disabled until the Installation of the Scripts is complete.";

            lblCompleteTitle.Text = "Congratulations";
            lblCompleteDetail.Text = "Congratulations, you have successfully installed SageFrame.";

            lblDataBaseWarning.Text = "The Auto option has been disabled as the SageFrame Application cannot connect to a valid SQL Server database.  You can continue to use either of the other Wizard options 'Custom' and configure the Database settings at the appropriate Wizard step.";
            lblHostWarning.Text = "Your Host Name contains illegal characters (only A-Z, 0-9, - and . are allowed).  You should modify the host name used.";

        }

        private void BindWizardControls()
        {
            BindWizardTitle();

            rblInstallType.Items.Clear();
            rblInstallType.DataSource = SageFrameLists.InstallationType();
            rblInstallType.DataTextField = "Value";
            rblInstallType.DataValueField = "Key";
            rblInstallType.DataBind();

            rblDatabases.Items.Clear();
            rblDatabases.DataSource = SageFrameLists.DatabaseType();
            rblDatabases.DataTextField = "Value";
            rblDatabases.DataValueField = "Key";
            rblDatabases.DataBind();
        }

        private void BindWizardTitle()
        {
            //Main Title
            this.Title = "SageFrame Installation Wizard";

            //Page Titles
            for (int i = 0; i <= wizInstallWizard.WizardSteps.Count - 1; i++)
            {
                switch (i.ToString())
                {
                    case "0":
                        wizInstallWizard.WizardSteps[i].Title = "Welcome";
                        this.Title = "SageFrame Installation Wizard - " + wizInstallWizard.WizardSteps[i].Title;
                        break;
                    case "1":
                        wizInstallWizard.WizardSteps[i].Title = "File Permissions";
                        this.Title = "SageFrame Installation Wizard - " + wizInstallWizard.WizardSteps[i].Title;
                        break;
                    case "2":
                        wizInstallWizard.WizardSteps[i].Title = "Database Configuration";
                        this.Title = "SageFrame Installation Wizard - " + wizInstallWizard.WizardSteps[i].Title;
                        break;
                    case "3":
                        wizInstallWizard.WizardSteps[i].Title = "Database Installation";
                        this.Title = "SageFrame Installation Wizard - " + wizInstallWizard.WizardSteps[i].Title;
                        break;
                    case "4":
                        wizInstallWizard.WizardSteps[i].Title = "Database Installation";
                        this.Title = "SageFrame Installation Wizard - " + wizInstallWizard.WizardSteps[i].Title;
                        break;
                }
            }
        }

        private void BindConnectionString()
        {
            string connection = SystemSetting.SageFrameConnectionString;
            string[] connectionParams = connection.Split(';');
            foreach (string connectionParam in connectionParams)
            {
                int index = connectionParam.IndexOf("=");
                if (index > 0)
                {
                    string key = connectionParam.Substring(0, index);
                    string value = connectionParam.Substring(index + 1);
                    switch (key.ToLower())
                    {
                        case "server":
                        case "data source":
                        case "address":
                        case "addr":
                        case "network address":
                            txtServer.Text = value;
                            break;
                        case "database":
                        case "initial catalog":
                            txtDatabase.Text = value;
                            break;
                        case "uid":
                        case "user id":
                        case "user":
                            txtUserId.Text = value;
                            break;
                        case "pwd":
                        case "password":
                            txtPassword.Text = value;
                            //txtPassword.Attributes.Add("value", value);
                            Session["UserPassword"] = value;
                            break;
                        case "integrated security":
                            chkIntegrated.Checked = (value.ToLower() == "true");
                            break;
                    }
                }
            }

            //if (chkIntegrated.Checked)
            //{
            //    chkOwner.Checked = true;
            //}
            //chkOwner.Enabled = !chkIntegrated.Checked;
        }

        private void BindDatabases()
        {
            rblDatabases.SelectedIndex = 0;
        }

        private bool TestDatabaseConnection()
        {
            bool success = false;

            if (string.IsNullOrEmpty(rblDatabases.SelectedValue))
            {
                connectionString = "ERROR: You must choose a Database Type";
            }
            else
            {
                DbConnectionStringBuilder builder = new DbConnectionStringBuilder();
                if (!string.IsNullOrEmpty(txtServer.Text))
                {
                    builder["Data Source"] = txtServer.Text;
                }
                if (!string.IsNullOrEmpty(txtDatabase.Text))
                {
                    builder["Initial Catalog"] = txtDatabase.Text;
                }
                if (chkIntegrated.Checked)
                {
                    builder["integrated security"] = "true";
                }
                if (!string.IsNullOrEmpty(txtUserId.Text))
                {
                    builder["uid"] = txtUserId.Text;
                }
                if (!string.IsNullOrEmpty(txtPassword.Text))
                {
                    builder["pwd"] = txtPassword.Text;
                    Session["UserPassword"] = builder["pwd"];
                }

                string owner = txtUserId.Text + ".";
                if (chkOwner.Checked)
                {
                    owner = "dbo.";
                }
                connectionString = TestConnection(builder, owner);
                hdnConnectionStringForAll.Value = connectionString;
            }

            if (connectionString.StartsWith("ERROR:"))
            {
                lblDataBaseError.Text = string.Format("Connection Error(s):<br/>{0}", connectionString.Replace("ERROR:", ""));
                lblDataBaseError.CssClass = "cssClasssNormalRed";
            }
            else
            {
                success = true;
                lblDataBaseError.Text = "Connection Success";
                lblDataBaseError.CssClass = "cssClasssNormalGreen";
            }
            return success;
        }

        private string TestConnection(DbConnectionStringBuilder builder, string owner)
        {
            try
            {
                string connStr = builder.ToString();
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    return connStr;
                }
            }
            catch (Exception ex)
            {
                return "ERROR:" + ex.Message;
            }
        }

        private void Initialise()
        {
            if (TestDataBaseInstalled())
            {
                //running current version, so redirect to site home page
                Response.Redirect(Page.ResolveUrl("~/" + CommonHelper.DefaultPage), true);
            }
            //else
            //{
            //    SageFrame.Application.Application app = new SageFrame.Application.Application();

            //    if (DatabaseVersion > new System.Version(0, 0, 0))
            //    {
            //        //Upgrade
            //        lblStepfirstTitle.Text = string.Format("SageFrame Upgrade Wizard - Version {0}", app.FormatVersion(ApplicationVersion, true));
            //        lblStepfirstDetail.Text = string.Format("<p>SageFrame version {0} is already Installed. Click the Next button to upgrade to the new version.</p>", app.FormatVersion(DatabaseVersion, true));
            //    }
            //    else
            //    {
            //        //Install
            //        UpdateMachineKey();
            //    }
            //}

        }

        private void SetupPage()
        {
            Button nextButton = GetWizardButton("StepNavigationTemplateContainerID", "StepNextButton");
            Button prevButton = GetWizardButton("StepNavigationTemplateContainerID", "StepPreviousButton");
            Button customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
            EnableButton(nextButton, true);
            EnableButton(prevButton, true);
            ShowButton(customButton, false);

            switch (wizInstallWizard.ActiveStepIndex)
            {
                case 0:
                    lblPermissionsError.Text = "";
                    break;
                case 1:
                    if (!lblInstallError.Text.Contains("Error"))
                    {
                        lblDataBaseError.EnableViewState = false;
                        ShowButton(nextButton, true);
                        ShowButton(prevButton, true);
                        lblDataBaseError.Visible = true;
                    }
                    else
                    {
                        lblDataBaseError.EnableViewState = true;
                        lblDataBaseError.Text = "";
                        lblDataBaseError.Visible = false;
                    }
                    ShowButton(customButton, true);
                    break;
                case 2:
                    lblPermissionsError.Text = "";
                    SetupDatabasePage(customButton, nextButton, prevButton);
                    break;
                case 3:
                    lblDataBaseError.Text = "";
                    lblInstallErrorOccur.Text = "";
                    lblInstallErrorOccur.Visible = false;
                    EnableButton(nextButton, false);
                    ShowButton(prevButton, false);
                    break;
                case 4:
                    lblInstallError.Visible = true;
                    EnableButton(nextButton, true);
                    ShowButton(prevButton, false);
                    if (lblInstallError.Text.Contains("Error"))
                    {
                        ShowButton(nextButton, false);
                        ShowButton(customButton, true);
                    }
                    break;
            }
        }

        private void SetupDatabasePage(Button customButton, Button nextButton, Button prevButton)
        {
            if (rblDatabases.SelectedIndex == 0)
            {
                bool isSQLDb = (rblDatabases.SelectedValue == "SQLDatabase");
                tblDatabase.Visible = true;
                trDatabase.Visible = isSQLDb;
                trUser.Visible = !chkIntegrated.Checked;
                trPassword.Visible = !chkIntegrated.Checked;

                //chkOwner.Checked = (Config.GetDataBaseOwner() == "dbo.");

                #region Added For Making It dbo.
                chkOwner.Checked = true;
                chkOwner.Enabled = false;
                #endregion

                ShowButton(customButton, true);
                customButton.Visible = true;
                EnableButton(nextButton, true);
                EnableButton(prevButton, true);

                if (!lblInstallError.Text.Contains("Error"))
                {
                    lblDataBaseError.EnableViewState = false;
                    ShowButton(nextButton, true);
                    ShowButton(prevButton, true);
                    lblDataBaseError.Visible = true;
                }
                else
                {
                    lblDataBaseError.EnableViewState = true;
                    lblDataBaseError.Text = "";
                    lblDataBaseError.Visible = false;
                }

            }
            //else
            //{
            //    tblDatabase.Visible = false;
            //    customButton.Visible = false;
            //    EnableButton(nextButton, false);
            //}
        }

        private bool TestDataBaseInstalled()
        {
            bool success = false;
            string IsInstalled = Config.GetSetting("IsInstalled").ToString();
            string InstallationDate = Config.GetSetting("InstallationDate").ToString();
            if ((IsInstalled != "" && IsInstalled != "false") && InstallationDate != "")
            {
                success = true;
            }
            //if (DatabaseVersion == null || DatabaseVersion.Major != ApplicationVersion.Major || DatabaseVersion.Minor != ApplicationVersion.Minor || DatabaseVersion.Build != ApplicationVersion.Build)
            //{
            //    success = false;
            //}
            //if (!success)
            //{
            //    lblInstallError.Text = "There is a problem with the Installation of the Database.";
            //    lblInstallError.Visible = true;
            //}            
            return success;
        }

        private void UpdateMachineKey()
        {
            string installationDate = Config.GetSetting("InstallationDate");

            if (installationDate == null || string.IsNullOrEmpty(installationDate))
            {
                string strError = Config.UpdateMachineKey();

                if (string.IsNullOrEmpty(strError))
                {
                    //Force an App Restart
                    Config.Touch();
                    //running current version, so redirect to site home page
                    System.Web.Security.FormsAuthentication.SignOut();
                    // send a new request to the application to initiate website
                    Response.Redirect(Page.ResolveUrl("~/" + CommonHelper.DefaultPage), true);
                    //Response.Redirect(HttpContext.Current.Request.RawUrl.ToString(), true);
                }
                else
                {
                    //403-3 Error - Redirect to ErrorPage
                    string strURL = "~/ErrorPage.aspx?status=403_3&error=" + strError;
                    HttpContext.Current.Response.Clear();
                    HttpContext.Current.Server.Transfer(strURL);
                }
            }
        }

        #endregion

        #region Wizard Steps

        protected void wizInstallWizard_CancelButtonClick(object sender, EventArgs e)
        {
            wizInstallWizard.ActiveStepIndex = 0;
        }

        protected void wizInstallWizard_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            switch (wizInstallWizard.ActiveStepIndex)
            {
                case 1:
                    wizInstallWizard.ActiveStepIndex = 0;
                    break;
                case 2:
                    wizInstallWizard.ActiveStepIndex = 1;
                    break;
                case 3:
                    wizInstallWizard.ActiveStepIndex = 2;
                    break;
            }
        }

        public static bool IsBusy = false;
        protected void UpdateTimer_Tick(object sender, EventArgs e)
        {
            if (!hdnConnectionStringForAll.Value.Contains("ERROR:"))
            {
                //System.Web.UI.HtmlControls.HtmlGenericControl loadingDiv = (System.Web.UI.HtmlControls.HtmlGenericControl)StepDatabase.FindControl("loadingDiv");
                //if (loadingDiv != null)
                //{
                //    loadingDiv.Visible = false;
                //}
                if (IsBusy == false)
                {
                    if (loadingDiv != null)
                    {
                        loadingDiv.Visible = true;
                    }
                    IsBusy = true;
                    if (Session["_SageScriptFile"] != null)
                    {
                        ArrayList arrColl = (ArrayList)Session["_SageScriptFile"];
                        if (arrColl.Count == 0)
                        {
                            txtFeedback.Text += Environment.NewLine + "Script executed successfully ...";
                            UpdateTimer.Enabled = false;
                            IsBusy = true;
                            lblInstallError.CssClass = "cssClasssNormalGreen";
                            lblInstallErrorOccur.Text = "Script executed successfully ...";
                            wizInstallWizard.ActiveStepIndex = 4;
                        }
                        else
                        {
                            RunSqlScript(hdnConnectionStringForAll.Value, Server.MapPath("~/Install/Providers/DataProviders/SqlDataProvider/"), arrColl.Count);
                            IsBusy = false;
                        }
                    }
                    else
                    {
                        RunSqlScript(hdnConnectionStringForAll.Value, Server.MapPath("~/Install/Providers/DataProviders/SqlDataProvider/"), 0);
                        IsBusy = false;
                    }
                }
            }
            else
            {
                txtFeedback.Text += "There is an error while running the script.";
                UpdateTimer.Enabled = false;
                lblInstallErrorOccur.Text = "Installation Error(s): There was an error while running the script.";
                lblInstallError.CssClass = "cssClasssNormalRed";
                wizInstallWizard.ActiveStepIndex = 4;
            }
        }

        protected void wizInstallWizard_NextButtonClick(object sender, System.Web.UI.WebControls.WizardNavigationEventArgs e)
        {
            try
            {
                switch (e.CurrentStepIndex)
                {
                    case 1:
                        //Step 1 - File Permissions
                        BindPermissions(true);
                        e.Cancel = !PermissionsValid;
                        break;
                    case 2:
                        //Step 2 - Database Connection String
                        bool canConnect = TestDatabaseConnection();
                        if (canConnect)
                        {
                            string dbOwner = string.Empty;
                            if (chkOwner.Checked)
                            {
                                dbOwner = "dbo";
                            }
                            //Config.GetDatabaseVersion();

                            UpdateTimer.Enabled = true;
                        }
                        else
                        {
                            lblDataBaseError.Visible = true;
                            e.Cancel = true;
                        }
                        break;
                    case 3:
                        //Step 3 - Database Feedback1
                        e.Cancel = !TestDataBaseInstalled();
                        break;
                    case 4:
                        //Step 4 - Database Feedback2 
                        e.Cancel = TestDataBaseInstalled();
                        break;
                }
            }
            catch (Exception)
            {
                //throw ex;
            }
        }

        protected void wizInstallWizard_ActiveStepChanged(object sender, EventArgs e)
        {
            BindWizardTitle();
            if (wizInstallWizard.ActiveStepIndex > 0)
            {
                Button nextButton = GetWizardButton("StepNavigationTemplateContainerID", "StepNextButton");
                Button prevButton = GetWizardButton("StepNavigationTemplateContainerID", "StepPreviousButton");
                nextButton.Text = "Next";
                prevButton.Text = "Previous";
            }
            Button customButton = null;
            switch (wizInstallWizard.ActiveStepIndex)
            {
                case 0:
                    //Step 0 - Welcome
                    //HttpContext.Current.Session["ReturnStep"] = null;
                    break;
                case 1:
                    //Step 1 - File Permissions
                    customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
                    customButton.Text = "Test Permissions";
                    if (rblInstallType.SelectedValue == "Auto")
                    {
                        UpdateTimer.Enabled = true;
                        HttpContext.Current.Session["ReturnStep"] = 0;
                        wizInstallWizard.ActiveStepIndex += 2;
                    }
                    break;
                case 2:
                    //Step 2 - Database Connection String
                    customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
                    customButton.Text = "Test Database Connection";
                    //HttpContext.Current.Session["ReturnStep"] = null;
                    break;
                case 3:
                    //Step 3 - Database Feedback1
                    if (rblInstallType.SelectedValue == "Custom")
                    {
                        HttpContext.Current.Session["ReturnStep"] = 2;
                    }
                    break;
                case 4:
                    //Step 4 - Database Feedback2  
                    customButton = GetWizardButton("StepNavigationTemplateContainerID", "CustomButton");
                    customButton.Text = "Return";
                    break;
            }
            SetupPage();
        }

        protected void wizInstallWizard_CustomButtonClick(object sender, System.EventArgs e)
        {
            switch (wizInstallWizard.ActiveStepIndex)
            {
                case 1:
                    //Page 1 - File Permissions
                    BindPermissions(true);
                    break;
                case 2:
                    //Page 2 - Database Connection String
                    TestDatabaseConnection();
                    lblDataBaseError.Visible = true;
                    break;
                case 4:
                    //Step 4 - Database Feedback2  
                    lblInstallError.Text = "";
                    txtFeedback.Text = "";
                    HttpContext.Current.Session["_SageScriptFile"] = null;
                    wizInstallWizard.ActiveStepIndex = Int32.Parse(HttpContext.Current.Session["ReturnStep"].ToString());
                    break;
            }
        }

        protected void wizInstallWizard_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            //To overwrite in web.config file 
            if (rblInstallType.SelectedValue == "Custom")
            {
                Config.UpdateConnectionString(hdnConnectionStringForAll.Value);
            }
            UpdateMachineKey();
        }

        private void EnableButton(Button button, bool enabled)
        {
            if ((button != null))
            {
                button.OnClientClick = "return !checkDisabled(this);";
                if (enabled)
                {
                    button.CssClass = "cssClassWizardButton";
                }
                else
                {
                    button.CssClass = "cssClassWizardButtonDisabled";
                }
            }
        }

        private void ShowButton(Button customButton, bool enabled)
        {
            if ((customButton != null))
            {
                customButton.Visible = enabled;
            }
        }

        private Button GetWizardButton(string containerID, string buttonID)
        {
            Control navContainer = wizInstallWizard.FindControl(containerID);
            Button button = null;
            if ((navContainer != null))
            {
                button = navContainer.FindControl(buttonID) as Button;
            }
            return button;
        }

        protected void StepDataBaseFeedBack_Active(object sender, EventArgs e)
        {
            txtFeedbackDetail.Text = txtFeedback.Text;
            txtFeedback.Text = "";
            lblInstallError.Text = lblInstallErrorOccur.Text;
            lblInstallError.Visible = true;
        }

        #endregion

        #region Script Loader
        StringBuilder feed = new StringBuilder();

        public void RunSqlScript(string connectionString1, string actualpath, int Counter)
        {
            lock (this)
            {
                TextBox txtFeedback = (TextBox)StepDatabase.FindControl("txtFeedback");
                try
                {
                    switch (Counter)
                    {
                        case 0:
                            txtFeedback.Text += "Started running Sql Script...";
                            string[] ScriptFiles = System.IO.Directory.GetFiles(actualpath);
                            ArrayList arrColl = new ArrayList();
                            foreach (string scriptFile in ScriptFiles)
                            {
                                arrColl.Add(scriptFile);
                            }
                            Session["_SageScriptFile"] = arrColl;
                            break;
                        default:
                            ArrayList arrC = (ArrayList)Session["_SageScriptFile"];
                            string strFile = arrC[0].ToString();
                            RunGivenSQLScript(strFile, connectionString1);
                            FileInfo fileName = new FileInfo(strFile);
                            if (fileName != null)
                            {
                                string strFileName = fileName.Name;
                                txtFeedback.Text = txtFeedback.Text + Environment.NewLine + strFileName + " Script run";
                            }
                            if (arrC.Count != 0)
                            {
                                arrC.RemoveAt(0);
                            }
                            Session["_SageScriptFile"] = arrC;
                            break;
                    }

                }
                catch (Exception ex)
                {
                    string sss = ex.Message;
                    txtFeedback.Text += Environment.NewLine + "There was an error while running the script.";
                    UpdateTimer.Enabled = false;
                    lblInstallErrorOccur.Text = "Installation Error(s): There was an error while running the script.";
                    lblInstallError.CssClass = "cssClasssNormalRed";
                    wizInstallWizard.ActiveStepIndex = 4;
                }
            }
        }

        private void RunGivenSQLScript(string scriptFile, string conn)
        {
            SqlConnection sqlcon = new SqlConnection(conn);
            sqlcon.Open();
            SqlCommand sqlcmd = new SqlCommand();
            sqlcmd.Connection = sqlcon;
            sqlcmd.CommandType = CommandType.Text;
            StreamReader reader = null;
            reader = new StreamReader(scriptFile);
            string script = reader.ReadToEnd();
            ExecuteLongSql(sqlcon, script);
            reader.Close();
            sqlcon.Close();
        }

        public void ExecuteLongSql(SqlConnection connection, string Script)
        {
            string sql = "";
            sql = Script;
            Regex regex = new Regex("^GO", RegexOptions.IgnoreCase | RegexOptions.Multiline);
            string[] lines = regex.Split(sql);
            //SqlTransaction transaction = connection.BeginTransaction();
            using (SqlCommand cmd = connection.CreateCommand())
            {
                cmd.Connection = connection;
                //cmd.Transaction = transaction;
                foreach (string line in lines)
                {

                    if (line.Length > 0)
                    {
                        cmd.CommandText = line;
                        cmd.CommandType = CommandType.Text;
                        try
                        {
                            cmd.ExecuteNonQuery();
                        }
                        catch
                        {
                            //transaction.Rollback();
                            throw;
                        }
                    }
                }
            }
            //transaction.Commit();
        }
        #endregion

    }
}
