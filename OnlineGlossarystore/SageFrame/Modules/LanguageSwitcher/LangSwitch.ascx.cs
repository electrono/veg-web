using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using System.Text;

public partial class Modules_Language_LangSwitch : BaseAdministrationUserControl
{
    public string ContainerClientID = string.Empty;
    public int LangUserModuleID = 0,PortalID=0,UserModuleID=0;
    protected void Page_Init(object sender, EventArgs e)
    {
        Initialize();
    }
    public void Initialize()
    {
        ArrayList jsArrColl = new ArrayList();
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/carousel.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/module.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/dd.css");       
        jsArrColl.Add(AppRelativeTemplateSourceDirectory + "js/jquery.dd.js");
        jsArrColl.Add(AppRelativeTemplateSourceDirectory + "js/jquery.tools.min.js");     
        IncludeScriptFile(jsArrColl);
        IncludeScriptFileInHeadSection(AppRelativeTemplateSourceDirectory + "js/LangSwitch.min.js");


    }
    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            CreateDynamicNav();
            PortalID = GetPortalID;
            UserModuleID = int.Parse(SageUserModuleID);
            LangUserModuleID = int.Parse(SageUserModuleID);
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "LanguageSwitchGlobalVariable1", " var LanguageSwitchFilePath='" + ResolveUrl(modulePath) + "';", true);
            string flagPath = ResolveUrl(Request.ApplicationPath);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "LanguageSwitchGlobalVariable2", " var LanguageSwitchFlagPath='" + ResolveUrl(flagPath) + "';", true);
        }
    }
   
    public void CreateDynamicNav()
    {
        ContainerClientID = "divNav_" + SageUserModuleID;
        StringBuilder sb = new StringBuilder();
        sb.Append("<div id='" + ContainerClientID + "'>");
        sb.Append("<div id='divFlagButton_"+SageUserModuleID+"' class='FlagButtonWrapper'> </div>");
        sb.Append("<div id='divFlagDDL_"+SageUserModuleID+"'> </div>");
        sb.Append("<div id='divPlainDDL_"+SageUserModuleID+"'> </div>");
        sb.Append("<div id='carousel_container_"+SageUserModuleID+"' class='CssClassLanguageWrapper'>");
        sb.Append("<div class='CssClassLanguageWrapperInside' id='divLangWrap_"+SageUserModuleID+"'>");
        sb.Append("<div id='left_scroll_"+SageUserModuleID+"' class='cssClassLeftScroll'><img class='imgLeftScroll' /></div>");
        sb.Append("<div id='carousel_inner_"+SageUserModuleID+"' class='cssClassCarousel'>");
        sb.Append("<ul id='carousel_ul_"+SageUserModuleID+"'></ul></div>");
        sb.Append("<div id='right_scroll_"+SageUserModuleID+"' class='cssClassRightScroll'><img class='imgRightScroll'/></div></div></div>");
        sb.Append("</div>");
        ltrNav.Text = sb.ToString();
    }
}



