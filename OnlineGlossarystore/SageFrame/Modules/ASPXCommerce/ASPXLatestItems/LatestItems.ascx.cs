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
using SageFrame.Web;
using System.Collections;
using SageFrame.Framework;
using SageFrame.Web.Utilities;
using ASPXCommerce.Core;

public partial class Modules_ASPXLatestItems_LatestItems : BaseAdministrationUserControl
{
    public string userIP;
    public string countryName = string.Empty;
    public string sessionCode = string.Empty;
    public int storeID, portalID, customerID;
    public string userName, cultureName;
    public string defaultImagePath, enableLatestItems, allowOutStockPurchase, allowWishListLatestItem, allowAddToCompareLatest;
    public int noOfLatestItems,noOfLatestItemsInARow ,maxCompareItemCount;
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
          //cssList.Add("~/Templates/" + TemplateName + "/css/PopUp/style.css");
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
        //if (!Page.ClientScript.IsClientScriptIncludeRegistered("JQueryHoverIntent"))
        //{
        //    Page.ClientScript.RegisterClientScriptInclude("JQueryHoverIntent", ResolveUrl(Request.ApplicationPath + "/Modules/SageMenu/js/hoverIntent.js"));

        //}
        Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryCurrencyFormat", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency-1.4.0.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryRegionAll", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency.all.js"));
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                customerID = GetCustomerID;
                userName = GetUsername;
                cultureName = GetCurrentCultureName;
                if (HttpContext.Current.Session.SessionID != null)
                {
                    sessionCode = HttpContext.Current.Session.SessionID.ToString();
                }

                //StoreSettingInfo DefaultStoreSettings = (StoreSettingInfo)Session["DefaultStoreSettings"];
                //DefaultStoreSettings.AllowAnonymousCheckOut
                userIP = HttpContext.Current.Request.UserHostAddress;
                IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
                ipToCountry.GetCountry(userIP, out countryName);
	            defaultImagePath=StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
	            noOfLatestItems =Convert.ToInt32( StoreSetting.GetStoreSettingValueByKey(StoreSetting.NoOfLatestItemsDisplay, storeID, portalID, cultureName));
	            enableLatestItems = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableLatestItems, storeID, portalID, cultureName);
                allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
                maxCompareItemCount = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MaxNoOfItemsToCompare, storeID, portalID, cultureName));
                noOfLatestItemsInARow = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.NoOfLatestItemsInARow, storeID, portalID, cultureName));
                allowWishListLatestItem = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList,storeID,portalID,cultureName);
                allowAddToCompareLatest = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableCompareItems, storeID, portalID, cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}
