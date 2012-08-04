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
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using SageFrame.Security;
using System.Collections.Generic;
using SageFrame.Security.Entities;
using SageFrame.Common.Shared;

namespace SageFrame.Controls
{
    public partial class ctl_AdminMenuOnly : BaseUserControl
    {
        public int UserModuleID, PortalID;
        public int Mode = 0;
        public string CultureCode = string.Empty,UserName=string.Empty,PortalName=string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            Initialize();           
            IsSuperUser();
            PortalID = GetPortalID;
            UserName=GetUsername;
            CultureCode = GetCurrentCulture();
            PortalName = GetPortalSEOName;
                
            
        }
        public void Initialize()
        {
            string appPath = Request.ApplicationPath != "/" ? Request.ApplicationPath : "";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuAdminGlobal1", " var SageMenuWCFPath='" + appPath + "';", true);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SageMenuAdminMenu", " var pagePathAdminMenu='" + appPath + "';", true);          
            RegisterClientScriptToPage(ScriptMap.MenuJQueryHoverIntent.Key, ResolveUrl(appPath + ScriptMap.MenuJQueryHoverIntent.Value),true);
            RegisterClientScriptToPage(ScriptMap.MenuJQuerySuperFish.Key, ResolveUrl(appPath + ScriptMap.MenuJQuerySuperFish.Value),true);
            RegisterClientScriptToPage(ScriptMap.MenuSageAdminMenuScript.Key, ResolveUrl(appPath + ScriptMap.MenuSageAdminMenuScript.Value),true);

            IncludeCssFile(ResolveUrl(appPath+"/Modules/SageMenu/css/superfish.css"));
            IncludeCssFile(ResolveUrl(appPath + "/Modules/SageMenu/css/FooterMenu.css"));
            IncludeCssFile(ResolveUrl(appPath + "/Modules/SageMenu/css/SideMenu.css"));
        }

        protected void IsSuperUser()
        {
            RoleController _role = new RoleController();
            string[] roles = _role.GetRoleNames(GetUsername, GetPortalID).ToLower().Split(',');
            if(roles.Contains(SystemSetting.SUPER_ROLE[0]))
            {
                Mode=1;
            }            
            
        }


    }
}