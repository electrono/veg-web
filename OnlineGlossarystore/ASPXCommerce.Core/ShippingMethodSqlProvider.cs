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
using SageFrame.Web;
using SageFrame.SageFrameClass.MessageManagement;

namespace ASPXCommerce.Core
{
    public class ShippingMethodSqlProvider
    {
        public ShippingMethodSqlProvider()
        {
        }

        public List<ShippingMethodInfo> GetShippingMethods(int offset, int limit,string shippingMethodName,string deliveryTime,System.Nullable<Decimal> weightLimitFrom,System.Nullable<Decimal> weightLimitTo,System.Nullable<bool> isActive, int storeID, int portalID, string cultureName)
        {
            List<ShippingMethodInfo> shipping = new List<ShippingMethodInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            parameterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            parameterCollection.Add(new KeyValuePair<string, object>("@ShippingMethodName", shippingMethodName));
            parameterCollection.Add(new KeyValuePair<string, object>("@DeliveryTime", deliveryTime));
            parameterCollection.Add(new KeyValuePair<string, object>("@WeightLimitFrom", weightLimitFrom));
            parameterCollection.Add(new KeyValuePair<string, object>("@WeightLimitTo", weightLimitTo));
            parameterCollection.Add(new KeyValuePair<string, object>("IsActive", isActive));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            shipping = Sq.ExecuteAsList<ShippingMethodInfo>("usp_ASPX_BindShippingMethodInGrid", parameterCollection);
            return shipping;
        }

        public void DeleteShippings(string shippingMethodIds, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShippingMethodIDs", shippingMethodIds));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("usp_ASPX_DeleteShippingMethods", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void SaveAndUpdateShippings(int shippingMethodID, string shippingMethodName, string imagePath, string alternateText, int displayOrder, string deliveryTime,
            decimal weightLimitFrom, decimal weightLimitTo, int shippingProviderID, int storeID, int portalID, bool isActive, string userName, string cultureName)
        {
            try
            {

                List<KeyValuePair<string, object>> Parameter = new List<KeyValuePair<string, object>>();
                Parameter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodID));
                Parameter.Add(new KeyValuePair<string, object>("@ShippingMethodName", shippingMethodName));
                Parameter.Add(new KeyValuePair<string, object>("@ImagePath", imagePath));
                Parameter.Add(new KeyValuePair<string, object>("@AlternateText", alternateText));
                Parameter.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
                Parameter.Add(new KeyValuePair<string, object>("@DeliveryTime", deliveryTime));
                Parameter.Add(new KeyValuePair<string, object>("@WeightLimitFrom", weightLimitFrom));
                Parameter.Add(new KeyValuePair<string, object>("@WeightLimitTo", weightLimitTo));
                Parameter.Add(new KeyValuePair<string, object>("@ShippingProviderID", shippingProviderID));
                Parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                Parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                Parameter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                Parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
                Parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("usp_ASPX_SaveAndUpdateShippingMethods", Parameter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void AddCostDependencies(int shippingProductCostID, int shippingMethodID, string costDependenciesOptions,  int storeID, int portalID, string userName)
        {
            try
            {

                List<KeyValuePair<string, object>> Parameter = new List<KeyValuePair<string, object>>();
                Parameter.Add(new KeyValuePair<string, object>("@ShippingProductCostID", shippingProductCostID));
                Parameter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodID));
                Parameter.Add(new KeyValuePair<string, object>("@CostDependenciesOptions", costDependenciesOptions));
                Parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                Parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                Parameter.Add(new KeyValuePair<string, object>("@UserName", userName));

                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("usp_ASPX_SaveCostDependencies", Parameter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void AddWeightDependencies(int shippingProductWeightID, int shippingMethodID, string weightDependenciesOptions, int storeID, int portalID, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
                parameter.Add(new KeyValuePair<string, object>("@ShippingProductWeightID", shippingProductWeightID));
                parameter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodID));
                parameter.Add(new KeyValuePair<string, object>("@WeightDependenciesOptions", weightDependenciesOptions));
                parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("usp_ASPX_SaveWeightDependencies", parameter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public void AddItemDependencies(int shippingItemID, int shippingMethodID, string itemDependenciesOptions, int storeID, int portalID, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
                parameter.Add(new KeyValuePair<string, object>("@ShippingItemID", shippingItemID));
                parameter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodID));
                parameter.Add(new KeyValuePair<string, object>("@ItemDependenciesOptions", itemDependenciesOptions));
                parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("usp_ASPX_SaveItemDependencies", parameter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
