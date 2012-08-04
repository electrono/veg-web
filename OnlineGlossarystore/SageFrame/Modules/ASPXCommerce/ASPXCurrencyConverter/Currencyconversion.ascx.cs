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
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ASPXCommerce.Core;
using SageFrame.Web;
using System.Collections;


public partial class Modules_ASPXCommerce_ASPXCurrencyConverter_Currencyconversion : BaseAdministrationUserControl
{
    public string MainCurrency="";
    public int storeID, portalID;
    public string  cultureName;

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {

            InitializeJS();
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
                storeID = GetStoreID;
                portalID = GetPortalID;               
                cultureName = GetCurrentCultureName;
                MainCurrency = StoreSetting.GetStoreSettingValueByKey(StoreSetting.MainCurrency, storeID, portalID, cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }       
    }
    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQuerySession", ResolveUrl("~/js/Session.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryCurrencyFormat", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency-1.4.0.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryRegionAll", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency.all.js"));
        Page.ClientScript.RegisterClientScriptInclude("FancyDropDown", ResolveUrl("~/js/FancyDropDown/fancyDropDown.js")); 
    }
}
