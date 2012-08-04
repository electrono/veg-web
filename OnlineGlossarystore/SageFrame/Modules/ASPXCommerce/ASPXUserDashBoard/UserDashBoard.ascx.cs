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
using SageFrame.Security;
using SageFrame.Security.Entities;
using ASPXCommerce.Core;
using SageFrame.Framework;

public partial class Modules_ASPXUserDashBoard_UserDashBoard : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID;
   
    public string sessionCode = string.Empty;

    public string cultureName, userName, userEmail, userFirstName, userLastName;

    public string allowMultipleAddress, allowWishListMyAccount;

    public string userIP;
    public string countryName = string.Empty;
   
    public string aspxfilePath;
    public bool IsUseFriendlyUrls = true;

    MembershipController m = new MembershipController();
    protected void page_init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();
            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/StarRating/jquery.rating.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/PopUp/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/JQueryUIFront/jquery.ui.all.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/PasswordValidation/jquery.validate.password.css");
            
            foreach (string css in cssList)
            {
                strTemplatePath = css;
                IncludeCssFile(strTemplatePath);
            }

            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            aspxfilePath = ResolveUrl(modulePath).Replace("ASPXUserDashBoard", "ASPXItemsManagement");//This is for Download file Path
    
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

                UserInfo sageUser = m.GetUserDetails(GetPortalID, GetUsername);
                userEmail = sageUser.Email;
                userFirstName = sageUser.FirstName;
                userLastName = sageUser.LastName;

                if (HttpContext.Current.Session.SessionID != null)
                {
                    sessionCode = HttpContext.Current.Session.SessionID.ToString();
                }
                allowMultipleAddress = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowUsersToCreateMultipleAddress, storeID, portalID, cultureName);
                allowWishListMyAccount = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList, storeID, portalID, cultureName);
                userIP = HttpContext.Current.Request.UserHostAddress;
                IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
                ipToCountry.GetCountry(userIP, out countryName);


            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {

        

        Page.ClientScript.RegisterClientScriptInclude("JQueryUI", ResolveUrl("~/js/JQueryUI/jquery-ui-1.8.10.custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JDownload", ResolveUrl("~/js/jDownload/jquery.jdownload.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));

        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

        Page.ClientScript.RegisterClientScriptInclude("metadata", ResolveUrl("~/js/StarRating/jquery.MetaData.js"));
        Page.ClientScript.RegisterClientScriptInclude("FormValidate", ResolveUrl("~/js/FormValidation/jquery.validate.js"));
        Page.ClientScript.RegisterClientScriptInclude("PasswordValidate", ResolveUrl("~/js/PasswordValidation/jquery.validate.password.js"));

        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));

        Page.ClientScript.RegisterClientScriptInclude("rating", ResolveUrl("~/js/StarRating/jquery.rating.js"));
        Page.ClientScript.RegisterClientScriptInclude("pack", ResolveUrl("~/js/StarRating/jquery.rating.pack.js"));

        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
    }  
}
