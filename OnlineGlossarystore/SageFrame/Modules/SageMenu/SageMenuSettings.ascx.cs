using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using SageFrame.Web;

public partial class Modules_SageMenu_SageMenuSettings :BaseAdministrationUserControl
{
    public string UserName;
    public int UserModuleID, PortalID;
    protected void Page_Load(object sender, EventArgs e)
    {
        Initialize();
        if (!IsPostBack)
        {
            UserModuleID = int.Parse(SageUserModuleID);
            PortalID = GetPortalID;
            UserName = GetUsername;
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuSettingsGlobal", " var SageMenuSettingPath='" + ResolveUrl(modulePath) + "';", true);
            string pagePath = ResolveUrl(Request.ApplicationPath);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuSettingsGlobal1", " var SageMenuSettingPagePath='" + ResolveUrl(pagePath) + "';", true);
        }
    }
    public void Initialize()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQueryFileTree", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "js/hoverIntent.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQuerymenujs", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "js/superfish.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryJSON", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "js/json2.js"));
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/superfish.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/module.css");



    }
}
