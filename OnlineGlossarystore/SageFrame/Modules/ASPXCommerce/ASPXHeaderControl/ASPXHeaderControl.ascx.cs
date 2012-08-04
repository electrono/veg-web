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

public partial class Modules_ASPXHeaderControl_ASPXHeaderControl : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID;
    public string userName, cultureName;
    public string sessionCode = string.Empty;
	public string myAccountURL, shoppingCartURL, wishListURL,allowAnonymousCheckOut,allowMultipleShipping,minOrderAmount,allowWishList;
    public bool IsUseFriendlyUrls = true;

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {            
            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
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
            SageFrameConfig pagebase = new SageFrameConfig();
            IsUseFriendlyUrls = pagebase.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);
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
                myAccountURL = StoreSetting.GetStoreSettingValueByKey(StoreSetting.MyAccountURL, storeID, portalID, cultureName);
                shoppingCartURL = StoreSetting.GetStoreSettingValueByKey(StoreSetting.ShoppingCartURL, storeID, portalID, cultureName);
                wishListURL = StoreSetting.GetStoreSettingValueByKey(StoreSetting.WishListURL, storeID, portalID, cultureName);
                allowAnonymousCheckOut = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowAnonymousCheckOut, storeID, portalID, cultureName);
                allowMultipleShipping = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowMultipleShippingAddress, storeID, portalID, cultureName);
                minOrderAmount = StoreSetting.GetStoreSettingValueByKey(StoreSetting.MinimumOrderAmount, storeID, portalID, cultureName);
                allowWishList = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList,storeID,portalID,cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

    }
}
