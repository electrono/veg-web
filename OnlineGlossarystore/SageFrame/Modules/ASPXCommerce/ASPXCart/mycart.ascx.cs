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
using ASPXCommerce.Core;

public partial class mycart : BaseAdministrationUserControl
{

    public int storeID, portalID,customerID,minimumItemQuantity,maximumItemQuantity;
    public string userName, cultureName;
    public string sessionCode = string.Empty;
    public string noImageMyCartPath, allowMultipleAddShipping, showItemImagesOnCart, minOrderAmount, allowOutStockPurchase;
    public bool IsUseFriendlyUrls = true;
    protected void page_init(object sender, EventArgs e)
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

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SageFrameConfig pagebase = new SageFrameConfig();
            IsUseFriendlyUrls = pagebase.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                userName = GetUsername;
                customerID = GetCustomerID;
                cultureName = GetCurrentCultureName;
                if (HttpContext.Current.Session.SessionID != null)
                {
                    sessionCode = HttpContext.Current.Session.SessionID.ToString();
                }
                noImageMyCartPath = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
                allowMultipleAddShipping = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowMultipleShippingAddress, storeID, portalID, cultureName);
                showItemImagesOnCart = StoreSetting.GetStoreSettingValueByKey(StoreSetting.ShowItemImagesInCart, storeID, portalID, cultureName);
                minOrderAmount = StoreSetting.GetStoreSettingValueByKey(StoreSetting.MinimumOrderAmount, storeID, portalID, cultureName);
                minimumItemQuantity = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MinimumItemQuantity, storeID, portalID, cultureName));
                maximumItemQuantity = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MaximumItemQuantity, storeID, portalID, cultureName));
                allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        //Page.ClientScript.RegisterClientScriptInclude("OrderForm", ResolveUrl("~/js/OrderForm/order.js"));
        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQuerySession", ResolveUrl("~/js/Session.js"));
    }
}
