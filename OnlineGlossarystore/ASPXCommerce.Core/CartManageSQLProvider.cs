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
using System.Text;
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
    public class CartManageSQLProvider
    {

        public bool CheckCart(int itemID, int storeID, int portalID, string userName, string cultureName)
        {

            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsGivenType<bool>("[usp_ASPX_CheckCart]", ParaMeter, "@IsExist");

        }

        public void AddToCart(int itemID, int storeID, int portalID, string userName, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_AddToCart", ParaMeter);
        }

        public List<CartInfo> GetCartDetails(int storeID, int portalID, int customerID, string userName, string cultureName, string sessionCode)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CartInfo>("usp_ASPX_GetCartDetails", ParaMeter);
        }
       
        public List<ShippingMethodInfo> GetShippingMethodByWeight(int storeID, int portalID, int customerID, string userName, string cultureName, string sessionCode)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ShippingMethodInfo>("usp_ASPX_GetShippingMethodByTotalWeight", ParaMeter);
        }

        public decimal GetTotalShippingCost(int shippingMethodID, int storeID, int portalID, string userName, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsScalar<decimal>("usp_ASPX_ShippingCost", ParaMeter);
        }

        public void UpdateShoppingCart(int cartID, string quantitys, int storeID, int portalID, string cartItemIDs,string userName,string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartID", cartID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CartItemIDs", cartItemIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@quantitys", quantitys));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_UpdateShoppingCart", ParaMeter);
        }

        public void DeleteCartItem(int cartID, int cartItemID, int customerID, string sessionCode, int storeID, int portalID, string userName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartID", cartID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CartItemID", cartItemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteCartItem", ParaMeter);
        }

        public void ClearAllCartItems(int cartID, int customerID, string sessionCode, int storeID, int portalID)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CartID", cartID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_ClearCartItems", ParaMeter);
        }

        public void ClearCartAfterPayment(int customerID, string sessionCode, int storeID, int portalID)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_ClearCartAfterPayment", ParaMeter);
        }
    }
}
