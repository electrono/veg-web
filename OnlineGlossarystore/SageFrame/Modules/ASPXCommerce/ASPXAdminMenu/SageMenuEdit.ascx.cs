/*
AspxCommerce® - http://www.aspxcommerce.com
Copyright (c) 20011-2012 by AspxCommerce
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

public partial class Modules_SageMenu_SageMenuEdit : BaseAdministrationUserControl
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
        Page.ClientScript.RegisterClientScriptInclude("JQueryPaginate", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "js/jquery.pajinate.js"));
      
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/SideMenu.css");
        IncludeCssFile(AppRelativeTemplateSourceDirectory + "css/styles.css");
    }
}
