﻿/*
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
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;

public partial class Modules_ASPXCommerce_ASPXStoreAccessManagement_StoreAccessControl : BaseAdministrationUserControl
{
    public int portalID, storeID;
    public string lblStoreAccessValueID;
    public string userName;
    public string lblAddEditStoreAccessTitleID;
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();
            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/JQueryUI/jquery.ui.all.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/PopUp/style.css");

            foreach (string css in cssList)
            {
                strTemplatePath = css;
                IncludeCssFile(strTemplatePath);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }


    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = int.Parse(GetStoreID.ToString());
                portalID = int.Parse(GetPortalID.ToString());
                lblStoreAccessValueID = lblStoreAccessValue.ClientID;
                lblAddEditStoreAccessTitleID = lblAddEditStoreAccessTitle.ClientID;
                userName = GetUsername.ToString();
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JSAFormValidate", ResolveUrl("~/js/FormValidation/jquery.validate.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryUI", ResolveUrl("~/js/JQueryUI/jquery-ui-1.8.10.custom.js")); 
        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));       
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
     } 
}
