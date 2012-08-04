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
using System.Text;
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
   public class CategorySqlProvider
    {
        public List<AttributeFormInfo> GetCategoryFormAttributes(Int32 categoryID, Int32 portalID, Int32 storeID, string userName, string culture)
        {
            List<AttributeFormInfo> formAttributeList = new List<AttributeFormInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            formAttributeList = sqlHandler.ExecuteAsList<AttributeFormInfo>("dbo.usp_ASPX_GetCategoryFormAttributes", parameterCollection);
            return formAttributeList;
        }

        public List<CategoryInfo> GetCategoryAll(bool isActive, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            List<CategoryInfo> catList = new List<CategoryInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            catList = sqlHandler.ExecuteAsList<CategoryInfo>("dbo.usp_ASPX_GetCategoryAll", parameterCollection);
            return catList;
        }

        public List<CategoryAttributeInfo> GetCategoryByCategoryID(Int32 categoryID,Int32 storeID, Int32 portalID, string userName, string culture)
        {
            List<CategoryAttributeInfo> catList = new List<CategoryAttributeInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            catList = sqlHandler.ExecuteAsList<CategoryAttributeInfo>("dbo.usp_ASPX_GetCategoryByCategoryID", parameterCollection);
            return catList;
        }

        public bool CheckUniqueName(string catName, int catId, int storeId, int portalId, string cultureName)
        {
            try
            {
                SQLHandler Sq = new SQLHandler();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CategoryName", catName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CategoryID", catId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                return Sq.ExecuteNonQueryAsBool("dbo.usp_ASPX_CategoryNameUniquenessCheck", ParaMeterCollection, "@IsUnique");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public CategoryInfo CategoryAddUpdate(CategoryInfo categoryInfo,string selectedItems, List<CategoryAttributeInfo> listCA, string userName, string culture)
        {
            SQLHandler sqlHandler = new SQLHandler();
            System.Nullable<Int32> categoryID = 0;
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryInfo.CategoryID));
            parameterCollection.Add(new KeyValuePair<string, object>("@SelectedItems", selectedItems));
            parameterCollection.Add(new KeyValuePair<string, object>("@ParentID", categoryInfo.ParentID));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsShowInSearch", categoryInfo.IsShowInSearch));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsShowInCatalog", categoryInfo.IsShowInCatalog));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsShowInMenu", categoryInfo.IsShowInMenu));
            parameterCollection.Add(new KeyValuePair<string, object>("@ActiveFrom", categoryInfo.ActiveFrom));
            parameterCollection.Add(new KeyValuePair<string, object>("@ActiveTo", categoryInfo.ActiveTo));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", categoryInfo.StoreID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", categoryInfo.PortalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", true));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            try
            {
                categoryID = sqlHandler.ExecuteNonQueryAsGivenType<int>("dbo.usp_ASPX_CategoryAddUpdate", parameterCollection, "@NewCategoryID");

                int inputTypeID;
                int validationTypeID;
                string valueType = string.Empty;
                foreach (CategoryAttributeInfo ca in listCA)
                {
                    parameterCollection.Clear();
                    inputTypeID = ca.InputTypeID;
                    validationTypeID = ca.ValidationTypeID;
                    if (inputTypeID == 1)
                    {
                        if (validationTypeID == 3)
                        {
                            parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.DECIMALValue));
                            valueType = "DECIMAL";
                        }
                        else if (validationTypeID == 5)
                        {
                            parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.INTValue));
                            valueType = "INT";
                        }
                        else
                        {
                            parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.NVARCHARValue));
                            valueType = "NVARCHAR";
                        }
                    }
                    else if (inputTypeID == 2)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.TEXTValue));
                        valueType = "TEXT";
                    }
                    else if (inputTypeID == 3)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.DATEValue));
                        valueType = "DATE";
                    }
                    else if (inputTypeID == 4)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.BooleanValue));
                        valueType = "Boolean";
                    }
                    else if (inputTypeID == 5 || inputTypeID == 6 || inputTypeID == 9 || inputTypeID == 10 || inputTypeID == 11 || inputTypeID == 12)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.OPTIONValues));
                        valueType = "OPTIONS";
                    }
                    else if (inputTypeID == 7)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.DECIMALValue));
                        valueType = "DECIMAL";
                    }
                    else if (inputTypeID == 8)
                    {
                        parameterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", ca.FILEValue));
                        valueType = "FILE";
                    }
                    parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
                    parameterCollection.Add(new KeyValuePair<string, object>("@AttributeID", ca.AttributeID));
                    parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", categoryInfo.StoreID));
                    parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", categoryInfo.PortalID));
                    parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
                    parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                    sqlHandler.ExecuteNonQuery("dbo.usp_ASPX_CategoryAttributesValue" + valueType + "AddUpdate", parameterCollection);
                }

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return categoryInfo;
        }

        public void DeleteCategory(Int32 storeID, Int32 portalID, Int32 categoryID, string userName,string culture)
        {
            try
            {
                SQLHandler sqlHandler = new SQLHandler();
                List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
                parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
                parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
                parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                sqlHandler.ExecuteNonQuery("dbo.usp_ASPX_CategoryDelete", parameterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CategoryItemInfo> GetCategoryItems(Int32 offset, Int32 limit, Int32 categoryID, string sku, string name, System.Nullable<decimal> priceFrom, System.Nullable<decimal> priceTo, Int32 storeID, Int32 portalID, string userName, string culture)
        {
            List<CategoryItemInfo> listCategoryItem = new List<CategoryItemInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            parameterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            parameterCollection.Add(new KeyValuePair<string, object>("@SKU", sku));
            parameterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            parameterCollection.Add(new KeyValuePair<string, object>("@PriceFrom", priceFrom));
            parameterCollection.Add(new KeyValuePair<string, object>("@PriceTo", priceTo));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            listCategoryItem = sqlHandler.ExecuteAsList<CategoryItemInfo>("dbo.usp_ASPX_GetItemsByCategoryID", parameterCollection);
            return listCategoryItem;
        }

        public bool SaveChangesCategoryTree(Int32 storeID, Int32 portalID,string categoryIDs,  string userName)
        {
            List<CategoryItemInfo> listCategoryItem = new List<CategoryItemInfo>();
            SQLHandler sqlHandler = new SQLHandler();
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryIDs", categoryIDs));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            sqlHandler.ExecuteNonQuery("dbo.usp_ASPX_CategoryTreeUpdate", parameterCollection);
            return true;
        }
    }
}
