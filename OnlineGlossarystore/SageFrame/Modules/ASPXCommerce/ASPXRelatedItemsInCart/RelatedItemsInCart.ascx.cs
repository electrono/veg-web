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
using ASPXCommerce.Core;

public partial class Modules_ASPXRelatedItemsInCart_RelatedItemsInCart : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID,noOfRelatedItemsInCart;
    public string userName, cultureName;
    public string sessionCode = string.Empty;
    public string noImageRelatedItemsInCartPath, enableRelatedItemsInCart, allowOutStockPurchase;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
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
                noImageRelatedItemsInCartPath = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
                 enableRelatedItemsInCart = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableRelatedCartItems, storeID, portalID, cultureName);
                 noOfRelatedItemsInCart = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.NoOfRelatedCartItems, storeID, portalID, cultureName));
                 allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}
