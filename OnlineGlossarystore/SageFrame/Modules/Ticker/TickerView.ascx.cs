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
using System.IO;

public partial class Modules_Ticker_TickerView : BaseAdministrationUserControl
{
    public int PortalId,StoreId;
    protected void page_init(object sender, EventArgs e)
    {
        string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalVariables", " var TickerModulePath='" + ResolveUrl(modulePath) + "';", true);
        try
        {
            IncludeCss();
            IncludeJS();
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
                PortalId = GetPortalID;
                StoreId = GetStoreID;

            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void IncludeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQuery_Ticker", ResolveUrl(this.AppRelativeTemplateSourceDirectory + "/Scripts/jquery.liScroll.js"));
    }

    private void IncludeCss()
    {
        //IncludeCssFile("~/Modules/Ticker/Css/jquery.liScroll.css");
        IncludeCssFile("~/Templates/" + TemplateName + "/css/Ticker/jquery.liScroll.css");
    }
}