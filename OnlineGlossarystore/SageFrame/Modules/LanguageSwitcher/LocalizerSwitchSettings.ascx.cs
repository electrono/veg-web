using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;

public partial class Modules_Language_LocalizerSwitchSettings :BaseAdministrationUserControl
{
    public string ImagePath = "";
    public void Initialize()
    {
        ArrayList jsArrColl = new ArrayList();
       
        //jsArrColl.Add(AppRelativeTemplateSourceDirectory + "js/json2.js");        
        jsArrColl.Add(AppRelativeTemplateSourceDirectory + "js/jquery.dd.js");

        IncludeScriptFile(jsArrColl);
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/carousel.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/module.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/dd.css");


    }
    protected void Page_Load(object sender, EventArgs e)
    {
        Initialize();
        string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "LocalizationLangSwitchGlobalVariable1", " var LanguageSwitchSettingFilepath='" + ResolveUrl(modulePath) + "';", true);
        ImagePath = ResolveUrl(modulePath);
    }
}
