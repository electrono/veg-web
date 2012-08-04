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
using System.Data.SqlClient;
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
    public class ItemsManagementSqlProvider
    {
        public ItemsManagementSqlProvider()
        {
        }

        /// <summary>
        /// To Bind grid with all Items
        /// </summary>
        /// <param name="offset"></param>
        /// <param name="limit"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <returns></returns>

        public List<ItemsInfo> GetAllItems(int offset, int limit, string Sku, string name, string itemType, string attributesetName, string visibility, System.Nullable<bool> isActive, int storeId, int portalId, string userName, string cultureName)
        {
            List<ItemsInfo> ml = new List<ItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", Sku));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemType", itemType));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetName", attributesetName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Visibility", visibility));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ml = Sq.ExecuteAsList<ItemsInfo>("dbo.usp_ASPX_ItemsGetAll", ParaMeterCollection);
            return ml;
        }
        /// <summary>
        /// To Bind grid with all Related Items
        /// </summary>
        /// <param name="offset"></param>
        /// <param name="limit"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="selfItemId"></param>
        /// <returns></returns>
        public List<ItemsInfo> GetRelatedItemsByItemID(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
        {
            List<ItemsInfo> ml = new List<ItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SelfItemID", selfItemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            ml = Sq.ExecuteAsList<ItemsInfo>("dbo.usp_ASPX_GetRelatedItemsByItemID", ParaMeterCollection);
            return ml;
        }
        /// <summary>
        /// To Bind grid with all UP Sell Items
        /// </summary>
        /// <param name="offset"></param>
        /// <param name="limit"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="selfItemId"></param>
        /// <returns></returns>
        public List<ItemsInfo> GetUpSellItemsByItemID(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
        {
            List<ItemsInfo> ml = new List<ItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SelfItemID", selfItemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            ml = Sq.ExecuteAsList<ItemsInfo>("dbo.usp_ASPX_GetUpSellItemsByItemID", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To Bind grid with all Cross Sell Items
        /// </summary>
        /// <param name="offset"></param>
        /// <param name="limit"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="selfItemId"></param>
        /// <returns></returns>
        public List<ItemsInfo> GetCrossSellItemsByItemID(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
        {
            List<ItemsInfo> ml = new List<ItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SelfItemID", selfItemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            ml = Sq.ExecuteAsList<ItemsInfo>("dbo.usp_ASPX_GetCrossSellItemsByItemID", ParaMeterCollection);
            return ml;
        }
       
        /// <summary>
        /// To Delete Multiple Item IDs
        /// </summary>
        /// <param name="itemIds"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="userName"></param>
        public void DeleteMultipleItems(string itemIds, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemIDs", itemIds));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_ItemsDeleteMultipleSelected", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Delete Single Item ID
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="userName"></param>
        public void DeleteSingleItem(string itemId, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteItemByItemID", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<AttributeFormInfo> GetItemFormAttributes(int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
        {
            List<AttributeFormInfo> formAttributeList = new List<AttributeFormInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemTypeID", itemTypeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));            
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            formAttributeList = Sq.ExecuteAsList<AttributeFormInfo>("dbo.usp_ASPX_GetItemFormAttributes", ParaMeterCollection);
            return formAttributeList;
        }

        public List<AttributeFormInfo> GetItemFormAttributesByItemSKUOnly(string itemSKU, int storeID, int portalID, string userName, string culture)
        {
            List<AttributeFormInfo> formAttributeList = new List<AttributeFormInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            formAttributeList = Sq.ExecuteAsList<AttributeFormInfo>("dbo.usp_ASPX_GetItemFormAttributesByItemSKU", ParaMeterCollection);
            return formAttributeList;
        }

        public List<TaxRulesInfo> GetAllTaxRules(int storeID, int portalID, bool isActive)
        {
            List<TaxRulesInfo> lstTaxManageRule = new List<TaxRulesInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));

            lstTaxManageRule = Sq.ExecuteAsList<TaxRulesInfo>("dbo.usp_ASPX_TaxRuleGetAll", ParaMeterCollection);
            return lstTaxManageRule;
        }

        public int AddItem(int itemID, int itemTypeID, int attributeSetID, int taxRuleID, int storeID, int portalID, string userName, string culture, bool isActive, bool isModified,
			string sku, string activeFrom, string activeTo, string hidePrice, string isHideInRSS, string isHideToAnonymous,
            string categoriesIDs, string relatedItemsIDs, string upSellItemsIDs, string crossSellItemsIDs, string downloadItemsValue, bool updateFlag)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemTypeID", itemTypeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", sku));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@TaxRuleID", taxRuleID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ActiveFrom", activeFrom));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ActiveTo", activeTo));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@HidePrice", hidePrice));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@HideInRSSFeed", isHideInRSS));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@HideToAnonymous", isHideToAnonymous));
                //For Static tabs
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CategoriesIDs", categoriesIDs));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@RelatedItemsIDs", relatedItemsIDs));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpSellItemsIDs", upSellItemsIDs));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CrossSellItemsIDs", crossSellItemsIDs));                

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", isModified));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DownloadInfos", downloadItemsValue));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpdateFlag", updateFlag)); 
                
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteNonQueryAsGivenType<int>("dbo.usp_ASPX_ItemAddUpdate", ParaMeterCollection, "@NewItemID");

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void SaveUpdateItemAttributes(int itemID, int attributeSetID, int storeID, int portalID, string userName, string culture, bool isActive, bool isModified, string attribValue, int _attributeID, int _inputTypeID, int _ValidationTypeID, int _attributeSetGroupID, bool _isIncludeInPriceRule, bool _isIncludeInPromotions, int _displayOrder)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", isModified));
                //ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpdateFlag", updateFlag));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeValue", attribValue));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", _attributeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@InputTypeID", _inputTypeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ValidationTypeID", _ValidationTypeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetGroupID", _attributeSetGroupID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPriceRule", _isIncludeInPriceRule));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPromotions", _isIncludeInPromotions));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DisplayOrder", _displayOrder));
                SQLHandler Sq = new SQLHandler();
                //_inputTypeID //_ValidationTypeID
                string valueType = string.Empty;
                if (_inputTypeID == 1)
                {
                    if (_ValidationTypeID == 3)
                    {
                        valueType = "DECIMAL";
                    }
                    else if (_ValidationTypeID == 5)
                    {
                        valueType = "INT";
                    }
                    else
                    {
                        valueType = "NVARCHAR";
                    }
                }
                else if (_inputTypeID == 2)
                {
                    valueType = "TEXT";
                }
                else if (_inputTypeID == 3)
                {
                    valueType = "DATE";
                }
                else if (_inputTypeID == 4)
                {
                    valueType = "Boolean";
                }
                else if (_inputTypeID == 5 || _inputTypeID == 6 || _inputTypeID == 9 || _inputTypeID == 10 ||
                         _inputTypeID == 11 || _inputTypeID == 12)
                {
                    valueType = "OPTIONS";
                }
                else if (_inputTypeID == 7)
                {
                    valueType = "DECIMAL";
                }
                else if (_inputTypeID == 8)
                {
                    valueType = "FILE";
                }
                Sq.ExecuteNonQuery("dbo.usp_ASPX_ItemAttributesValue" + valueType + "AddUpdate", ParaMeterCollection);

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// make the Item active deactive
        /// </summary>
        /// <param name="itemId"></param>
        /// <param name="storeId"></param>
        /// <param name="portalId"></param>
        /// <param name="userName"></param>
        /// <param name="isActive"></param>
        public void UpdateItemIsActive(int itemId, int storeId, int portalId, string userName, bool isActive)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_UpdateItemIsActiveByItemID", ParaMeterCollection);

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<AttributeFormInfo> GetItemAttributesValuesByItemID(int itemID, int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
        {
            try
            {
                List<AttributeFormInfo> itemAttributes = new List<AttributeFormInfo>();
                SQLHandler Sq = new SQLHandler();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemTypeID", itemTypeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                itemAttributes = Sq.ExecuteAsList<AttributeFormInfo>("dbo.usp_ASPX_GetItemFormAttributesValuesByItemID", ParaMeterCollection);
                return itemAttributes;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CategoryInfo> GetCategoryList(string prefix, bool isActive, string cultureName, Int32 storeID, Int32 portalID, string userName, int itemId)
        {
            List<CategoryInfo> catList = new List<CategoryInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Prefix", prefix));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            catList = Sq.ExecuteAsList<CategoryInfo>("dbo.usp_ASPX_GetCategoryListForCatalog", ParaMeterCollection);
            return catList;
        }

        public bool CheckUniqueSKUCode(string SKU, int itemId, int storeId, int portalId, string cultureName)
        {
            try
            {
                SQLHandler Sq = new SQLHandler();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", SKU));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                return Sq.ExecuteNonQueryAsBool("dbo.usp_ASPX_ItemSKUCodeUniquenessCheck", ParaMeterCollection, "@IsUnique");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void DeleteItemImageByItemID(int itemId)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteItemImageByItemID", ParaMeterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<FeaturedItemsInfo> GetFeaturedItemsByCount(int storeId, int portalId, string userName, string cultureName, int count)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Count", count));
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteAsList<FeaturedItemsInfo>("dbo.usp_ASPX_FeaturedItemsGetByCount", ParaMeterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<LatestItemsInfo> GetLatestItemsByCount(int storeId, int portalId, string userName, string cultureName, int count)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));                
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Count", count));
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteAsList<LatestItemsInfo>("dbo.usp_ASPX_LatestItemsGetByCount", ParaMeterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<AttributeFormInfo> GetItemDetailsInfoByItemSKU(string itemSKU, int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
        {
            try
            {
                List<AttributeFormInfo> itemAttributes = new List<AttributeFormInfo>();
                SQLHandler Sq = new SQLHandler();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemTypeID", itemTypeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                itemAttributes = Sq.ExecuteAsList<AttributeFormInfo>("dbo.usp_ASPX_GetItemDetailsByItemSKU", ParaMeterCollection);
                return itemAttributes;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public ItemBasicDetailsInfo GetItemBasicInfo(string itemSKU, int storeID, int portalID, string userName, string culture)
        {
            try
            {
                ItemBasicDetailsInfo itemBasicDetails = new ItemBasicDetailsInfo();
                SQLHandler Sq = new SQLHandler();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
                itemBasicDetails = Sq.ExecuteAsObject<ItemBasicDetailsInfo>("dbo.usp_ASPX_ItemsGetBasicInfos", ParaMeterCollection);
                return itemBasicDetails;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<CostVariantInfo> GetAllCostVariantOptions(int itemId, int storeId, int portalId, string cultureName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteAsList<CostVariantInfo>("dbo.usp_ASPX_BindCostVariantsInDropdownList", ParaMeterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
		}

        //--------------------------GetMostViewedItems---------------------------
        public List<MostViewedItemsInfo> GetAllMostViewedItems(int offset, int limit, string name, int storeId, int portalId, string userName, string cultureName)
        {
            List<MostViewedItemsInfo> ml = new List<MostViewedItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ml = Sq.ExecuteAsList<MostViewedItemsInfo>("usp_ASPX_GetMostViewedItems", ParaMeterCollection);
            return ml;
        }
        //----------------------------------------------------------------------------------------------
        //-----------------------------------Get Low Stock Items----------------------------------------
        public List<LowStockItemsInfo> GetAllLowStockItems(int offset, int limit, string Sku, string name, System.Nullable<bool> isActive, int storeId, int portalId, string userName, string cultureName)
        {
            List<LowStockItemsInfo> ml = new List<LowStockItemsInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", Sku));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ml = Sq.ExecuteAsList<LowStockItemsInfo>("dbo.usp_ASPX_GetLowStockItems", ParaMeterCollection);
            return ml;
        }
        //-------------------------------------------------------------------------------------------------
        //--------------------------Get Ordered Items List------------------------------------------------
        public List<OrderItemsGroupByItemIDInfo> GetOrderedItemsList(int offset, int limit, string name, int storeId, int portalId, string userName, string cultureName)
        {
            List<OrderItemsGroupByItemIDInfo> ml = new List<OrderItemsGroupByItemIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ml = Sq.ExecuteAsList<OrderItemsGroupByItemIDInfo>("dbo.usp_ASPX_GetItemsOrdered", ParaMeterCollection);
            return ml;
        }
        //----------------------------------------------------------------------------------------------
        //-----------------------------------Get DownLoadable Items----------------------------------------
        public List<DownLoadableItemGetInfo> GetDownLoadableItemsList(int offset, int limit, string Sku, string name, int storeId, int portalId, string userName, string cultureName, System.Nullable<bool> CheckUser)
        {
            List<DownLoadableItemGetInfo> ml = new List<DownLoadableItemGetInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", Sku));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CheckUser", CheckUser));

            ml = Sq.ExecuteAsList<DownLoadableItemGetInfo>("dbo.usp_ASPX_GetDownloadableItemsForReport", ParaMeterCollection);
            return ml;
        }
    }
}
