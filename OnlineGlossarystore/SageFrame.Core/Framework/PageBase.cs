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
using System.Web.Security;
using System.Globalization;
using System.Threading;
using System.Data;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using SageFrame.Web.Common.SEO;
using System.Web.UI.WebControls;
using SageFrame.Web.Utilities;
using System.Collections;
using SageFrame.Web;
using SageFrame.Shared;
using SageFrame.ErrorLog;
using System.Text;
using SageFrame.Utilities;

namespace SageFrame.Framework
{
    public enum DivClassType
    {
        HeaderCenter,
        HeaderLeftCenter,
        HeaderCenterRight,
        HeaderLeftCenterRight,
        Center,
        LeftCenter,
        CenterRight,
        LeftCenterRight,
        FooterCenter,
        FooterLeftCenter,
        FooterCenterRight,
        FooterLeftCenterRight
    }
    public class PageBase : System.Web.UI.Page
    {
        #region "Public Properties"

        //string Comment = "";
        string Description = "";
        string KeyWords = "";
        string Copyright = "";
        string Generator = "";
        string Author = "";
        string SageTitle = "";
        string CssPath = "";
        string Refresh = "";
        string Robots = "";
        string ResourceType = "";
        string Distribution = "";
        string RevisitAfter = "";
        string PageEnter = "";
        #endregion
        #region Private Property
		    int PortalID = 1;
            string PortalSEOName = string.Empty;
			int StoreID = 1;
            int CustomerID = 0;
	    #endregion
        public virtual void ShowMessage(string MessageTitle, string Message, string CompleteMessage, bool isSageAsyncPostBack, SageMessageType MessageType)
        {

        }

        public string GetCurrentCultureName
        {
            get
            {                
                return CultureInfo.CurrentCulture.Name; 
            }
        }

        protected override void InitializeCulture()
        {
            //string preferredCulture = null;
            //string preferredUICulture = null;
            //if (preferredUICulture != null && preferredCulture != null)
            //{
            //    SetCulture(preferredUICulture, preferredCulture);
            //}
            //else
            //{
            //    SetCulture("en-US", "en-US");
            //}
            string IsInstalled = Config.GetSetting("IsInstalled").ToString();
            string InstallationDate = Config.GetSetting("InstallationDate").ToString();
            if ((IsInstalled != "" && IsInstalled != "false") && InstallationDate != "")
            {
                SageFrameConfig sfConf = new SageFrameConfig();
                string portalCulture = sfConf.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultLanguage);
                if (Session["SageUICulture"] != null)
                {
                    Thread.CurrentThread.CurrentUICulture = (CultureInfo)Session["SageUICulture"];
                }
                else
                {
                    CultureInfo newUICultureInfo = new CultureInfo(portalCulture);
                    Thread.CurrentThread.CurrentUICulture = newUICultureInfo;
                    Session["SageUICulture"] = newUICultureInfo;
                }
                if (Session["SageCulture"] != null)
                {
                    Thread.CurrentThread.CurrentCulture = (CultureInfo)Session["SageCulture"];
                }
                else
                {
                    CultureInfo newCultureInfo = new CultureInfo(portalCulture);
                    Thread.CurrentThread.CurrentCulture = newCultureInfo;
                    Session["SageCulture"] = newCultureInfo;
                }
            }
            else
            {
                HttpContext.Current.Response.Redirect(ResolveUrl("~/Install/InstallWizard.aspx"));
            }
            

            base.InitializeCulture();
        }

        protected void SetCulture(string name, string locale)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(name);
            Thread.CurrentThread.CurrentCulture = new CultureInfo(locale);
            Session["SageUICulture"] = Thread.CurrentThread.CurrentUICulture;
            Session["SageCulture"] = Thread.CurrentThread.CurrentCulture;
        }

        public static void SetCultureInfo(string name, string locale)
        {
            Thread.CurrentThread.CurrentUICulture = new CultureInfo(name);
            Thread.CurrentThread.CurrentCulture = new CultureInfo(locale);
            HttpContext.Current.Session["SageUICulture"] = Thread.CurrentThread.CurrentUICulture;
            HttpContext.Current.Session["SageCulture"] = Thread.CurrentThread.CurrentCulture;
        }


        protected string GetCurrentUICulture()
        {
            return Thread.CurrentThread.CurrentUICulture.ToString();
        }
        protected string GetCurrentCulture()
        {
            return Thread.CurrentThread.CurrentCulture.ToString();
        }
        public void InitializePage()
        {
            
            #region "Page Meta Section"

            SageFrameConfig sfConfig = new SageFrameConfig();
            SageTitle = sfConfig.GetSettingsByKey(SageFrameSettingKeys.PageTitle);
            Description = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaDescription);
            KeyWords = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaKeywords);
            Refresh = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaRefresh);
            Copyright = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaCopyright);
            Generator = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaGenerator);
            Author = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaAuthor);
            ResourceType = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaRESOURCE_TYPE);
            Distribution = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaDISTRIBUTION);
            Robots = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaRobots);
            PageEnter = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaPAGE_ENTER);
            RevisitAfter = sfConfig.GetSettingsByKey(SageFrameSettingKeys.MetaREVISIT_AFTER);
            
            SEOHelper.RenderTitle(this.Page, SageTitle, false, true, this.GetPortalID);
            SEOHelper.RenderMetaTag(this.Page, "Refresh", Refresh, true);
            SEOHelper.RenderMetaTag(this.Page, "DESCRIPTION", Description, true);
            SEOHelper.RenderMetaTag(this.Page, "KEYWORDS", KeyWords, true);
            SEOHelper.RenderMetaTag(this.Page, "COPYRIGHT", Copyright, true);
            SEOHelper.RenderMetaTag(this.Page, "GENERATOR", Generator, true);
            SEOHelper.RenderMetaTag(this.Page, "AUTHOR", Author, true);
            SEOHelper.RenderMetaTag(this.Page, "RESOURCE-TYPE", ResourceType, false);
            SEOHelper.RenderMetaTag(this.Page, "DISTRIBUTION", Distribution, false);
            SEOHelper.RenderMetaTag(this.Page, "ROBOTS", Robots, true);
            SEOHelper.RenderMetaTag(this.Page, "REVISIT-AFTER", RevisitAfter, false);
            SEOHelper.RenderMetaTag(this.Page, "PAGE-ENTER", PageEnter, false); 

            #endregion

            #region "Set Site Template"

            //Set Site Template
            string TemplateName = sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalCssTemplate);
            string CssTemplatePath = string.Empty;
            string CssLayoutPath = string.Empty;//"~/Templates/" + TemplateName + "/css/layout.css";
            if (HttpContext.Current.Request.RawUrl.Contains("/Admin/") || HttpContext.Current.Request.RawUrl.Contains("/Admin.aspx") || HttpContext.Current.Request.RawUrl.Contains("/Super-User/") || HttpContext.Current.Request.RawUrl.Contains("/Super-User.aspx") || HttpContext.Current.Request.RawUrl.Contains("ManageReturnURL=")) 
            {
                CssTemplatePath = "~/Templates/" + TemplateName + "/css/admintemplate.css";
            }
            else
            {
                CssTemplatePath = "~/Templates/" + TemplateName + "/css/template.css";
                CssLayoutPath = "~/Templates/" + TemplateName + "/css/layout.css";
            }
            CssPath = Page.ResolveUrl(CssPath);
            SEOHelper.RenderCSSPath(this.Page, "SageFrameCSSTemplate", ResolveUrl(CssTemplatePath), true);
            if (!string.IsNullOrEmpty(CssLayoutPath))
            {
                SEOHelper.RenderCSSPath(this.Page, "SageFrameCSSLayout", ResolveUrl(CssLayoutPath), true);
            } 

            #endregion

            #region "Not in use"

            //register SageFrame ClientAPI scripts
            ////Page.ClientScript.RegisterClientScriptInclude("sageframecore", ResolveUrl("~/js/SageFrameCorejs/sageframecore.js"));
            ////Page.ClientScript.RegisterClientScriptInclude("jquery", ResolveUrl("~/js/jquery-1.2.6.min.js"));
            ////Page.ClientScript.RegisterClientScriptInclude("bannerjquery", ResolveUrl("~/js/jquery.cycle.all.js"));
            ////Page.ClientScript.RegisterClientScriptInclude("MessageTemplate", ResolveUrl("~/js/SageFrameCorejs/MessageTemplate.js"));
            //Page.ClientScript.RegisterClientScriptInclude("IE8", ResolveUrl("~/js/SageFrameCorejs/IE8.js"));
            //LitSageScript 

            #endregion

            #region "Script Section"

            Literal LitSageScript = Page.Header.FindControl("LitSageScript") as Literal;
            Literal SageFrameModuleCSSlinks = Page.Header.FindControl("SageFrameModuleCSSlinks") as Literal;
            StringBuilder strbScripts = new StringBuilder();
            if (LitSageScript != null && SageFrameModuleCSSlinks != null)
            {
                strbScripts.Append("<script src=\"" + ResolveUrl("~/js/SageFrameCorejs/sageframecore.js") + "\" type=\"text/javascript\"></script>");
                strbScripts.Append("<script src=\"" + ResolveUrl("~/js/jquery-1.4.4.js") + "\" type=\"text/javascript\"></script>");
                strbScripts.Append("<script src=\"" + ResolveUrl("~/js/json2.js") + "\" type=\"text/javascript\"></script>");
                if (!SageFrameModuleCSSlinks.Text.Contains(strbScripts.ToString()))
                {
                    SageFrameModuleCSSlinks.Text += strbScripts.ToString();
                }
               
            } 

            #endregion

            if (!IsPostBack)
            {
                ProcessHttpRequestValidationException();
            }
        }

        protected override void OnPreRender(EventArgs e)
        {
            if (!(Request.CurrentExecutionFilePath.Contains(".gif") || Request.CurrentExecutionFilePath.Contains(".jpg") || Request.CurrentExecutionFilePath.Contains(".png")))
            {
                base.OnPreRender(e);
                Control ctlphdHeaderLeftContainer = this.FindControl("HeaderLeftPane");
                Control ctlphdHeaderRightContainer = this.FindControl("HeaderRightPane");
                PlaceHolder phdHeaderLeftContainer = (PlaceHolder)ctlphdHeaderLeftContainer;
                PlaceHolder phdHeaderRightContainer = (PlaceHolder)ctlphdHeaderRightContainer;
                Control ctlphdLeftContainer = this.FindControl("LeftPane");
                Control ctlphdRightContainer = this.FindControl("RightPane");
                PlaceHolder phdLeftContainer = (PlaceHolder)ctlphdLeftContainer;
                PlaceHolder phdRightContainer = (PlaceHolder)ctlphdRightContainer;
                Control ctlphdFooterLeftContainer = this.FindControl("FooterLeftPane");
                Control ctlphdFooterRightContainer = this.FindControl("FooterRightPane");
                PlaceHolder phdFooterLeftContainer = (PlaceHolder)ctlphdFooterLeftContainer;
                PlaceHolder phdFooterRightContainer = (PlaceHolder)ctlphdFooterRightContainer;
                #region "Conditions"

                if (phdHeaderLeftContainer != null)
                {
                    if (phdHeaderLeftContainer.HasControls())
                    {
                        if (phdHeaderRightContainer.HasControls())
                        {
                            SetCssClasses("divHeaderContent", DivClassType.HeaderLeftCenterRight);
                        }
                        else
                        {
                            SetCssClasses("divHeaderContent", DivClassType.HeaderLeftCenter);
                        }
                    }
                    else
                    {
                        if (phdHeaderRightContainer.HasControls())
                        {
                            SetCssClasses("divHeaderContent", DivClassType.HeaderCenterRight);
                        }
                        else
                        {
                            SetCssClasses("divHeaderContent", DivClassType.HeaderCenter);
                        }
                    }
                }
                if (phdLeftContainer != null)
                {
                    if (phdLeftContainer.HasControls())
                    {
                        if (phdRightContainer.HasControls())
                        {
                            SetCssClasses("divCenterContent", DivClassType.LeftCenterRight);
                        }
                        else
                        {
                            SetCssClasses("divCenterContent", DivClassType.LeftCenter);
                        }
                    }
                    else
                    {
                        if (phdRightContainer.HasControls())
                        {
                            SetCssClasses("divCenterContent", DivClassType.CenterRight);
                        }
                        else
                        {
                            SetCssClasses("divCenterContent", DivClassType.Center);
                        }
                    }
                }
                if (phdFooterLeftContainer != null)
                {
                    if (phdFooterLeftContainer.HasControls())
                    {
                        if (phdFooterRightContainer.HasControls())
                        {
                            SetCssClasses("divFooterContent", DivClassType.FooterLeftCenterRight);
                        }
                        else
                        {
                            SetCssClasses("divFooterContent", DivClassType.FooterLeftCenter);
                        }
                    }
                    else
                    {
                        if (phdFooterRightContainer.HasControls())
                        {
                            SetCssClasses("divFooterContent", DivClassType.FooterCenterRight);
                        }
                        else
                        {
                            SetCssClasses("divFooterContent", DivClassType.FooterCenter);
                        }
                    }
                } 

                #endregion
                SetGoogleAnalyticsis();
            }
        }

       
        private void SetGoogleAnalyticsis()
        {
            try
            {
                if (!Request.RawUrl.Contains("Admin") || !Request.RawUrl.Contains("Super-User"))
                {

                    Hashtable hst = new Hashtable();
                    if (HttpContext.Current.Cache["SageGoogleAnalytics"] != null)
                    {
                        hst = (Hashtable)HttpContext.Current.Cache["SageGoogleAnalytics"];
                    }
                    else
                    {
                        SettingProvider sp = new SettingProvider();
                        List<GoogleAnalyticsisInfo> objList = sp.GetGoogleAnalyticsActiveOnlyByPortalID(GetPortalID);
                        foreach (GoogleAnalyticsisInfo objl in objList)
                        {
                            hst.Add("SageGoogleAnalytics_" + objl.PortalID, objl.GoogleJSCode);
                        }
                        HttpContext.Current.Cache.Insert("SageGoogleAnalytics", hst);
                    }
                    if (hst != null && hst.Count > 0 && hst.ContainsKey("SageGoogleAnalytics_" + GetPortalID))
                    {
                        Literal LitSageScript = Page.Header.FindControl("LitSageScript") as Literal;
                        if (LitSageScript != null)
                        {
                            string strGoogleJS = hst["SageGoogleAnalytics_" + GetPortalID].ToString();
                            if (!strGoogleJS.Contains("<script type=\"text/javascript\">"))
                            {
                                strGoogleJS = "<script type=\"text/javascript\">" + strGoogleJS + "</script>";
                            }
                            LitSageScript.Text += strGoogleJS;
                        }
                    }
                }
            }
            catch
            {
            }
        }

        public void SetCssClasses(string divID,DivClassType divClassType)
        {
            Control ctl = this.FindControl(divID);
            if (ctl != null)
            {
                HtmlGenericControl div = (HtmlGenericControl)ctl;
                switch (divClassType)
                {
                    case DivClassType.HeaderCenter:
                        div.Attributes.Add("class", "cssClassHeaderWrapperCenter");
                        break;
                    case DivClassType.HeaderLeftCenter:
                        div.Attributes.Add("class", "cssClassHeaderWrapperLeftCenter");
                        break;
                    case DivClassType.HeaderCenterRight:
                        div.Attributes.Add("class", "cssClassHeaderWrapperCenterRight");
                        break;
                    case DivClassType.HeaderLeftCenterRight:
                        div.Attributes.Add("class", "cssClassHeaderWrapperLeftCenterRight");
                        break;
                    case DivClassType.Center:
                        div.Attributes.Add("class", "cssClassMasterWrapperCenter");
                        break;
                    case DivClassType.LeftCenter:
                        div.Attributes.Add("class", "cssClassMasterWrapperLeftCenter");
                        break;
                    case DivClassType.CenterRight:
                        div.Attributes.Add("class", "cssClassMasterWrapperCenterRight");
                        break;
                    case DivClassType.LeftCenterRight:
                        div.Attributes.Add("class", "cssClassMasterWrapperLeftCenterRight");
                        break;
                    case DivClassType.FooterCenter:
                        div.Attributes.Add("class", "cssClassFooterWrapperCenter");
                        break;
                    case DivClassType.FooterLeftCenter:
                        div.Attributes.Add("class", "cssClassFooterWrapperLeftCenter");
                        break;
                    case DivClassType.FooterCenterRight:
                        div.Attributes.Add("class", "cssClassFooterWrapperCenterRight");
                        break;
                    case DivClassType.FooterLeftCenterRight:
                        div.Attributes.Add("class", "cssClassFooterWrapperLeftCenterRight");
                        break;
                }
            }
        }

        public int GetPortalID
        {
            get
            {
                try
                {
                    if (Session["SageFrame.PortalID"] != null && Session["SageFrame.PortalID"].ToString() != "")
                    {
                        return int.Parse(Session["SageFrame.PortalID"].ToString());
                    }
                    else
                    {
                        return 1;
                    }
                }
                catch
                {
                    return 1;
                }
            }
        }

        public void SetPortalID(int portalID)
        {
            PortalID = portalID;
		}

        public int GetStoreID
        {
            get
            {
                try
                {
                    if (Session["SageFrame.StoreID"] != null && Session["SageFrame.StoreID"].ToString() != "")
                    {
                        return int.Parse(Session["SageFrame.StoreID"].ToString());
                    }
                    else
                    {
                        return 1;
                    }
                }
                catch
                {
                    return 1;
                }
            }
        }

        public void SetStoreID(int storeID)
        {
            StoreID = storeID;
        }

        public System.Nullable<Int32> GetCustomerID
        {
            get
            {
                try
                {
                    if (Session["SageFrame.CustomerID"] != null && Session["SageFrame.CustomerID"].ToString() != "")
                    {
                        return int.Parse(Session["SageFrame.CustomerID"].ToString());
                    }
                    else
                    {
                        return 0;
                    }
                }
                catch
                {
                    return 0;
                }
            }
        }

        public void SetCustomerID(int customerID)
        {
            CustomerID = customerID;
        }
        
        public string GetUsername
        {
            get
            {
                try
                {
                    MembershipUser user = Membership.GetUser();
                    if (user != null)
                    {
                        return user.UserName;
                    }
                    else
                    {
                        return "anonymoususer";
                    }
                }
                catch
                {
                    return "anonymoususer";
                }
            }
        }

        public PlaceHolder LoadControl(string UpdatePanelIDPrefix, bool IsPartialRendring, PlaceHolder ContainerControl, string ControlSrc, string PaneName, string strUserModuleID)
        {
            try
            {
                SageUserControl ctl;
                if (ControlSrc.ToLower().EndsWith(".ascx"))
                {
                    if (IsPartialRendring)
                    {
                        UpdatePanel udp = CreateUpdatePanel(UpdatePanelIDPrefix, UpdatePanelUpdateMode.Always, ContainerControl.Controls.Count);
                        ctl = this.Page.LoadControl("~" + ControlSrc) as SageUserControl;
                        ctl.EnableViewState = true;
                        ctl.SageUserModuleID = strUserModuleID;
                        udp.ContentTemplateContainer.Controls.Add(ctl);
                        ContainerControl.Controls.Add(udp);
                    }
                    else
                    {
                        ctl = this.Page.LoadControl("~" + ControlSrc) as SageUserControl;
                        ctl.EnableViewState = true;
                        ctl.SageUserModuleID = strUserModuleID;
                        ContainerControl.Controls.Add(ctl);
                    }
                }
                else
                {
                }
                return ContainerControl;
            }
            catch (Exception ex)
            {
                ProcessException(ex);
                return ContainerControl;
            }
        }

        public UpdatePanel CreateUpdatePanel(string Prefix, UpdatePanelUpdateMode Upm, int PaneUpdatePanelCount)
        {
            UpdatePanel udp = new UpdatePanel();
            udp.UpdateMode = Upm;
            PaneUpdatePanelCount++;
            udp.ID = "_udp_" + "_" + PaneUpdatePanelCount + Prefix;
            //udp.EnableViewState = false;
            return udp;
        }

        public string ConvetVisibility(bool i)
        {
            string Visible = "Same As Page";
            if (i == false)
            {
                Visible = "Page Editor Only";
            }
            return Visible;
        }        

        private string SettingPortal
        {
            get
            {
                string strPortalName = "default";
                try
                {
                    if (HttpContext.Current.Session["SageFrame.PortalSEOName"] != null)
                    {
                        strPortalName = HttpContext.Current.Session["SageFrame.PortalSEOName"].ToString();
                    }
                }
                catch
                {
                    strPortalName = "default";
                }
                return strPortalName;
            }
        }        

        protected void ProcessHttpRequestValidationException()
        {
            if (HttpContext.Current.Request.QueryString["sagealert"] != null && HttpContext.Current.Request.QueryString["sagealert"].ToString() != string.Empty)
            {
                string ShortAlert = "Malicious activity found, your activity is recorded, if you repeat the same action, you may not able to browse this site in future.";
                ShortAlert += " Your IP Address: " + HttpContext.Current.Request.UserHostAddress;
                ShortAlert += " Mechine Name: " + HttpContext.Current.Request.UserHostName;
                string FullAllert = string.Empty;//"A potentially dangerous Request.Form value was detected from the client. Please remove < and > from your entry and re-submit information";
                ShowMessage(SageMessageTitle.Notification.ToString(), ShortAlert, FullAllert, SageMessageType.Alert);
            }
           
        }

        protected void ProcessException(Exception exc)
        {
            ErrorLogDataContext db = new ErrorLogDataContext(SystemSetting.SageFrameConnectionString);
            System.Nullable<int> inID = 0;
            db.sp_LogInsert(ref inID, (int)SageFrame.Web.SageFrameEnums.ErrorType.AdministrationArea, 11, exc.Message, exc.ToString(),
                HttpContext.Current.Request.UserHostAddress, Request.RawUrl, true, GetPortalID, GetUsername);
            ShowMessage(SageMessageTitle.Exception.ToString(), exc.Message, exc.ToString(), SageMessageType.Error);
        }

        protected void ShowMessage(string MessageTitle, string Message, string CompleteMessage, SageMessageType MessageType)
        {
            ScriptManager scp = (ScriptManager)this.Page.FindControl("ScriptManager1");
            if (scp != null)
            {
                bool isSageAsyncPostBack = false;
                if (scp.IsInAsyncPostBack)
                {
                    isSageAsyncPostBack = true;
                }

                if (this.Page == null)
                    return;

                Page SagePage = this.Page;
                if (SagePage == null)
                    return;

                PageBase mSagePage = SagePage as PageBase;
                if (mSagePage != null)
                    mSagePage.ShowMessage(MessageTitle, Message, CompleteMessage, isSageAsyncPostBack, MessageType);
            }
        } 

        public string TemplateName
        {
            get
            {
                SageFrameConfig sfConfig = new SageFrameConfig();
                return sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalCssTemplate);
            }
        }

        public string GetTemplateImageUrl(string imageName, bool isServerControl)
        {
            string path = string.Empty;
            if (isServerControl == true)
            {
                path = "~/Templates/" + TemplateName + "/images/admin/" + imageName;
            }
            else
            {
                path = this.Page.ResolveUrl("~/") + "Templates/" + TemplateName + "/images/admin/" + imageName;
            }
            return path;
        }

        public string GetMessageCsssClass(SageMessageType MessageType)
        {
            string cssClass = string.Empty;
            switch (MessageType)
            {
                case SageMessageType.Alert:
                    cssClass = "cssClassAlert";
                    break;
                case SageMessageType.Error:
                    cssClass = "cssClassError";
                    break;
                case SageMessageType.Success:
                    cssClass = "cssClassSuccess";
                    break;                    
            }
            return cssClass;
        }

        protected string GetPortalSEOName
        {
            get
            {
                if (HttpContext.Current.Session["SageFrame.PortalSEOName"] != null && HttpContext.Current.Session["SageFrame.PortalSEOName"].ToString() != "")
                {
                    PortalSEOName = HttpContext.Current.Session["SageFrame.PortalSEOName"].ToString();
                }
                return PortalSEOName;
            }
        }

        public string GetPageSEOName(string pagePath)
        {
            string SEOName = string.Empty;
            if (string.IsNullOrEmpty(pagePath))
            {
                SageFrameConfig sfConfig = new SageFrameConfig();
                SEOName = sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage);
            }
            else
            {
                string[] pagePaths = pagePath.Split('/');
                SEOName = pagePaths[pagePaths.Length - 1];
                if (string.IsNullOrEmpty(SEOName))
                {
                    SEOName = pagePaths[pagePaths.Length - 2];
                }
                SEOName = SEOName.Replace(".aspx", "");

            }
            return SEOName;
        }        

        public void OverridePageInfo(DataTable dt)
        {
            if (dt != null && dt.Rows != null && dt.Rows.Count > 0)
            {
                string PageTitle = dt.Rows[0]["Title"].ToString();
                string PageRefresh = dt.Rows[0]["RefreshInterval"].ToString();
                string PageDescription = dt.Rows[0]["Description"].ToString();
                string PageKeyWords = dt.Rows[0]["KeyWords"].ToString();

                if (!string.IsNullOrEmpty(PageTitle))
                    SEOHelper.RenderTitle(this.Page, PageTitle, false, true, this.GetPortalID);

                if (!string.IsNullOrEmpty(PageRefresh) && PageRefresh != "0.00")
                    SEOHelper.RenderMetaTag(this.Page, "Refresh", PageRefresh, true);
                else
                {
                    foreach (Control control in this.Page.Header.Controls)
                        if (control is HtmlMeta)
                        {
                            HtmlMeta meta = (HtmlMeta)control;
                            if (meta.Name.ToLower().Equals("Refresh".ToLower()))
                            {
                                meta.Visible = false;
                            }
                        }
                }

                if (!string.IsNullOrEmpty(PageDescription))
                    SEOHelper.RenderMetaTag(this.Page, "DESCRIPTION", PageDescription, true);

                if (!string.IsNullOrEmpty(PageKeyWords))
                    SEOHelper.RenderMetaTag(this.Page, "KEYWORDS", PageKeyWords, true);

            }
            else
            {
                foreach (Control control in this.Page.Header.Controls)
                    if (control is HtmlMeta)
                    {
                        HtmlMeta meta = (HtmlMeta)control;
                        if (meta.Name.ToLower().Equals("Refresh".ToLower()))
                        {
                            meta.Visible = false;
                        }
                    }
            }
            
        }

        public void AddModuleCssToPage(string ControlSrc, bool IsModuleFolerName)
        {
            string ModuleRootLocation = string.Empty;
            if (IsModuleFolerName)
            {
                ModuleRootLocation = "~/Modules/" + ControlSrc + "/module.css";
            }
            else
            {
                ControlSrc = ControlSrc.Replace("/Modules/", "");
                while (ControlSrc.Contains("/"))
                {
                    ControlSrc = ControlSrc.Remove(ControlSrc.LastIndexOf("/"));
                }
            }
            ModuleRootLocation = "~/Modules/" + ControlSrc + "/module.css";
            string FullPath = Server.MapPath(ModuleRootLocation);
            if(System.IO.File.Exists(FullPath))
            {
                Literal SageFrameModuleCSSlinks = this.Page.FindControl("SageFrameModuleCSSlinks") as Literal;
                if (SageFrameModuleCSSlinks != null)
                {
                    string linkText = "<link href=\"" + Page.ResolveUrl(ModuleRootLocation) + "\" rel=\"stylesheet\" type=\"text/css\" />";
                    SageFrameModuleCSSlinks.Text += linkText;
                }
            }
        }

        public void AddModuleCssToPage(string cssFilePath)
        {
            string ModuleRootLocation = string.Empty;
            ModuleRootLocation = cssFilePath;
            string FullPath = Server.MapPath(ModuleRootLocation);
            if (System.IO.File.Exists(FullPath))
            {
                Literal SageFrameModuleCSSlinks = this.Page.FindControl("SageFrameModuleCSSlinks") as Literal;
                if (SageFrameModuleCSSlinks != null)
                {
                    string linkText = "<link href=\"" + Page.ResolveUrl(ModuleRootLocation) + "\" rel=\"stylesheet\" type=\"text/css\" />";
                    SageFrameModuleCSSlinks.Text += linkText;
                }
            }
        }
    }
}
