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

public partial class Modules_ASPXCommerce_ASPXNewAccountReport_NewAccountReport : BaseAdministrationUserControl
{
    public int storeID, portalID;
    public string userName, cultureName;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                userName = GetUsername;
                cultureName = GetCurrentCultureName;
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
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

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JSPGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPFormValidate", ResolveUrl("~/js/FormValidation/jquery.validate.js"));
        Page.ClientScript.RegisterClientScriptInclude("csv", ResolveUrl("~/js/ExportToCSV/table2CSV.js"));
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        try
        {
            string table = HdnValue.Value;
            ExportToExcel(ref table, "MyReport_NewAccount");;
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    public void ExportToExcel(ref string table, string fileName)
    {
        table = table.Replace("&gt;", ">");
        table = table.Replace("&lt;", "<");
        HttpContext.Current.Response.ClearContent();
        HttpContext.Current.Response.AddHeader("content-disposition", "attachment;filename=" + fileName + "_" + DateTime.Now.ToString("M_dd_yyyy_H_M_s") + ".xls");
        HttpContext.Current.Response.ContentType = "application/xls";
        HttpContext.Current.Response.Write(table);
        HttpContext.Current.Response.End();
    }
}
