using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;

public partial class Modules_SageFrameCorporateBanner_BannerView : BaseAdministrationUserControl
{
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalVariables", " var bannerModulePath='" + ResolveUrl(modulePath) + "';", true);
            InitializeJS();
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_PreRender(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, this.GetType(), "StartBanner", "GetBannerList();", true);
    }

    private void InitializeJS()
    {
        try
        {
            //Page.ClientScript.RegisterClientScriptInclude("JQuery", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/json2.js"));
            Page.ClientScript.RegisterClientScriptInclude("JQueryEasing", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/jquery.easing.js"));
            Page.ClientScript.RegisterClientScriptInclude("JBannerScript", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/js/script.js"));
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}

