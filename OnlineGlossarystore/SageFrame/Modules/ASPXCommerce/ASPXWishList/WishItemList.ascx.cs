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
using System.Collections;
using SageFrame.Web;
using System.Web.Security;
using SageFrame.Framework;
using ASPXCommerce.Core;

public partial class WishItemList : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID;
    public string userName, cultureName;
    public string countryName = string.Empty;
    public string sessionCode = string.Empty;
    public string userEmail = string.Empty;
    public string userIP, noImageWishList, enableWishList, showImageInWishlist, allowOutStockPurchase;
    public bool IsUseFriendlyUrls = true;
    protected void page_init(object sender, EventArgs e)
    {

        string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalVariables", " var aspxservicePath='" + ResolveUrl(modulePath) + "';", true);

        MembershipUser userDetail = Membership.GetUser(GetUsername);
        userEmail = userDetail.Email;

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
            storeID = GetStoreID;
            portalID = GetPortalID;
            userName = GetUsername;
            customerID = GetCustomerID;
            cultureName = GetCurrentCultureName;
            if (HttpContext.Current.Session.SessionID != null)
            {
                sessionCode = HttpContext.Current.Session.SessionID.ToString();
            }

            userIP = HttpContext.Current.Request.UserHostAddress;
            IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
            ipToCountry.GetCountry(userIP, out countryName);
            noImageWishList = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
            enableWishList = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList, storeID, portalID, cultureName);
            showImageInWishlist = StoreSetting.GetStoreSettingValueByKey(StoreSetting.ShowItemImagesInWishList, storeID, portalID, cultureName);
            allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSPFormValidate", ResolveUrl("~/js/FormValidation/jquery.validate.js"));
    }
}
