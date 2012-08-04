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
using SageFrame.SageMenu;
using System.IO;
using SageFrame.Common.Shared;


public partial class Modules_SageMenu_SageMenu : BaseAdministrationUserControl
{
    public int UserModuleID, PortalID;
    public string ContainerClientID = string.Empty;
    public string UserName = string.Empty, PageName = string.Empty, CultureCode = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            Initialize();
            if (!IsPostBack)
            {
                CreateDynamicNav();
                UserModuleID = int.Parse(SageUserModuleID);
                PortalID = GetPortalID;
                UserName = GetUsername;
                CultureCode = GetCurrentCulture();
                PageName = Path.GetFileNameWithoutExtension(PagePath);
                string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuGlobal", " var Path='" + ResolveUrl(modulePath) + "';", true);
                string pagePath = Request.ApplicationPath != "/" ? Request.ApplicationPath : "";
                pagePath = GetPortalID == 1 ? pagePath : pagePath + "/portal/" + GetPortalSEOName;
                ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuGlobal1", " var PagePath='" + pagePath + "';", true);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    public void CreateDynamicNav()
    {
        ContainerClientID = "divNav_" + SageUserModuleID;
        ltrNav.Text = "<div id='" + ContainerClientID + "'></div>";
    }

    public void Initialize()
    {
        try
        {
            string appPath = Request.ApplicationPath != "/" ? Request.ApplicationPath : "";
            RegisterClientScriptToPage(ScriptMap.SageMenuHoverIntent.Key, ResolveUrl(AppRelativeTemplateSourceDirectory + ScriptMap.SageMenuHoverIntent.Value), false);
            RegisterClientScriptToPage(ScriptMap.SageMenuSuperFish.Key, ResolveUrl(AppRelativeTemplateSourceDirectory + ScriptMap.SageMenuSuperFish.Value), false);
            RegisterClientScriptToPage(ScriptMap.MenuSageMenuScript.Key, ResolveUrl(AppRelativeTemplateSourceDirectory + ScriptMap.MenuSageMenuScript.Value), false);

            IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/superfish.css");
            IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/FooterMenu.css");
            IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/SideMenu.css");
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}
