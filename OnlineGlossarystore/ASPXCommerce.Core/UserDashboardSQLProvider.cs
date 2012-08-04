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
   public class UserDashboardSQLProvider
    {
       public void AddUpdateUserAddress(int addressID, int customerID, string firstName, string lastName, string email, string company,
        string address1, string address2, string city, string state, string zip, string phone, string mobile,
   string fax,string webSite,string countryName, bool isDefaultShipping, bool isDefaultBilling, int storeID, int portalID, string userName, string cultureName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@AddressID", addressID));
           ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
           ParaMeter.Add(new KeyValuePair<string, object>("@FirstName", firstName));
           ParaMeter.Add(new KeyValuePair<string, object>("@LastName", lastName));
           ParaMeter.Add(new KeyValuePair<string, object>("@Email", email));
           ParaMeter.Add(new KeyValuePair<string, object>("@Company", company));
           ParaMeter.Add(new KeyValuePair<string, object>("@Address1", address1));
           ParaMeter.Add(new KeyValuePair<string,object>("@Address2",address2));
           ParaMeter.Add(new KeyValuePair<string, object>("@City", city));
           ParaMeter.Add(new KeyValuePair<string, object>("@State", state));
           ParaMeter.Add(new KeyValuePair<string, object>("@Zip", zip));
           ParaMeter.Add(new KeyValuePair<string, object>("@Phone", phone));
           ParaMeter.Add(new KeyValuePair<string, object>("@Mobile", mobile));
           ParaMeter.Add(new KeyValuePair<string, object>("@Fax", fax));
           ParaMeter.Add(new KeyValuePair<string, object>("@WebSite", webSite));
           ParaMeter.Add(new KeyValuePair<string, object>("@Country", countryName));
           ParaMeter.Add(new KeyValuePair<string, object>("@IsDefaultShipping", isDefaultShipping));
           ParaMeter.Add(new KeyValuePair<string, object>("@IsDefaultBilling", isDefaultBilling));
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
           SQLHandler sqlH = new SQLHandler();
           sqlH.ExecuteNonQuery("usp_ASPX_AddUpdateUserAddress", ParaMeter);
       }
       public List<AddressInfo> GetUserAddressDetails(int storeID, int portalID, int customerID, string userName, string cultureName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
           SQLHandler sqlh = new SQLHandler();
           return sqlh.ExecuteAsList<AddressInfo>("usp_ASPX_GetUserAddressBookDetails", ParaMeter);
       }
       public void DeleteAddressBookDetails(int addressID, int storeID, int portalID, string userName, string cultureName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@AddressID", addressID));
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
           SQLHandler sqLH = new SQLHandler();
           sqLH.ExecuteNonQuery("usp_ASPX_DeleteAddressBook", ParaMeter);
       }
       public List<UserProductReviewInfo> GetUserProductReviews(int storeID, int portalID, string userName, string cultureName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
           SQLHandler sqLH = new SQLHandler();
          return  sqLH.ExecuteAsList<UserProductReviewInfo>("usp_ASPX_GetUserProductReviews", ParaMeter);
       }
       public void UpdateUserProductReview(int itemID, int itemReviewID, string ratingIDs, string ratingValues, string reviewSummary, string review, int storeID, int portalID, string userName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
           ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
           ParaMeter.Add(new KeyValuePair<string, object>("@RatingIDs", ratingIDs));
           ParaMeter.Add(new KeyValuePair<string, object>("@RatingValues", ratingValues));
           ParaMeter.Add(new KeyValuePair<string, object>("@ReviewSummary", reviewSummary));
           ParaMeter.Add(new KeyValuePair<string, object>("@Review", review));
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           SQLHandler sqLH = new SQLHandler();
           sqLH.ExecuteNonQuery("usp_ASPX_GetUserProductReviewUpdate", ParaMeter);
           
       }
       public void DeleteUserProductReview(int itemID, int itemReviewID, int storeID, int portalID, string userName)
       {
           List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
           ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
           ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
           ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
           ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
           ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
           SQLHandler sqLH = new SQLHandler();
           sqLH.ExecuteNonQuery("usp_ASPX_DeleteUserProductReview", ParaMeter);
       }
    }
}
