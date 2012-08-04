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
using System.Collections;
using System.Data.SqlClient;
using System.Data;

namespace ASPXCommerce.Core
{
    public class ItemAttributesManagementSqlProvider
    {
        public ItemAttributesManagementSqlProvider()
        {

        }
        /// <summary>
        /// To Bind grid
        /// </summary>
        /// <returns></returns>
        public List<AttributesBasicInfo> GetItemAttributes(int offset, int limit, string attributeName, System.Nullable<bool> isRequired, System.Nullable<bool> comparable, System.Nullable<bool> IsSystem, int storeId, int portalId, string cultureName, string userName)
        //(int portalID, int userModuleID, string cultureName)
        {
            List<AttributesBasicInfo> ml = new List<AttributesBasicInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeName", attributeName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsRequired", isRequired));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Comparable", comparable));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsSystem", IsSystem));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));  
            //ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));            
            ml = Sq.ExecuteAsList<AttributesBasicInfo>("dbo.usp_ASPX_AttributesGetAll", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To Bind Attribute Type dropdown
        /// </summary>
        /// <returns></returns>
        public List<AttributesInputTypeInfo> GetAttributesInputType()
        {
            List<AttributesInputTypeInfo> ml = new List<AttributesInputTypeInfo>();
            SQLHandler Sq = new SQLHandler();
            ml = Sq.ExecuteAsList<AttributesInputTypeInfo>("dbo.usp_ASPX_AttributesInputTypeGetAll");
            return ml;
        }

        /// <summary>
        /// To Bind Attribute Item Type dropdown
        /// </summary>
        /// <returns></returns>
        public List<AttributesItemTypeInfo> GetAttributesItemType(int storeId, int portalId)
        {
            List<AttributesItemTypeInfo> ml = new List<AttributesItemTypeInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ml = Sq.ExecuteAsList<AttributesItemTypeInfo>("dbo.usp_ASPX_AttributesItemTypeGetAll", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To Bind Attribute validation Type dropdown
        /// </summary>
        /// <returns></returns>
        public List<AttributesValidationTypeInfo> GetAttributesValidationType()
        {
            List<AttributesValidationTypeInfo> ml = new List<AttributesValidationTypeInfo>();
            SQLHandler Sq = new SQLHandler();
            ml = Sq.ExecuteAsList<AttributesValidationTypeInfo>("dbo.usp_ASPX_AttributesValidationTypeGetAll");
            return ml;
        }

        /// <summary>
        /// To Bind for Attribute ID
        /// </summary>
        /// <returns></returns>
        public List<AttributesGetByAttributeIDInfo> GetAttributesInfoByAttributeID(int attributeId, int storeId, int portalId, string userName)
        {
            List<AttributesGetByAttributeIDInfo> ml = new List<AttributesGetByAttributeIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", attributeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ml = Sq.ExecuteAsList<AttributesGetByAttributeIDInfo>("dbo.usp_ASPX_AttributesGetByAttributeID", ParaMeterCollection);
            return ml;
        }
        /// <summary>
        /// To Delete Multiple Attribute IDs
        /// </summary>
        /// <returns></returns>
        public void DeleteMultipleAttributes(string attributeIds, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeIDs", attributeIds));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_AttributesDeleteMultipleSelected", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Delete by Attribute ID
        /// </summary>
        /// <returns></returns>
        public void DeleteAttribute(int attributeId, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", attributeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteAttributeByAttributeID", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Activate/ Deactivate Attribute 
        /// </summary>
        /// <returns></returns>
        public void UpdateAttributeIsActive(int attributeId, int storeId, int portalId, string userName, bool isActive)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", attributeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_UpdateAttributeIsActiveByAttributeID", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Save Attribute 
        /// </summary>
        /// <returns></returns>
        public void SaveAttribute(AttributesGetByAttributeIDInfo attributeToInsert)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", attributeToInsert.AttributeID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeName", attributeToInsert.AttributeName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@InputTypeID", attributeToInsert.InputTypeID));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DefaultValue", attributeToInsert.DefaultValue));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Length", attributeToInsert.Length));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AliasName", attributeToInsert.AliasName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AliasToolTip", attributeToInsert.AliasToolTip));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AliasHelp", attributeToInsert.AliasHelp));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DisplayOrder", attributeToInsert.DisplayOrder));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsUnique", attributeToInsert.IsUnique));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsRequired", attributeToInsert.IsRequired));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInAdvanceSearch", attributeToInsert.ShowInAdvanceSearch));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInComparison", attributeToInsert.ShowInComparison));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPriceRule", attributeToInsert.IsIncludeInPriceRule));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPromotions", attributeToInsert.IsIncludeInPromotions));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsEnableEditor", attributeToInsert.IsEnableEditor));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInSearch", attributeToInsert.ShowInSearch));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInGrid", attributeToInsert.ShowInGrid));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsEnableSorting", attributeToInsert.IsEnableSorting));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsUseInFilter", attributeToInsert.IsUseInFilter));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsShownInRating", attributeToInsert.IsShownInRating));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", attributeToInsert.IsActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", attributeToInsert.IsModified));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ValidationTypeID", attributeToInsert.ValidationTypeID));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", attributeToInsert.StoreID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", attributeToInsert.PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", attributeToInsert.AddedBy));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", attributeToInsert.CultureName));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemTypes", attributeToInsert.ItemTypes));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpdateFlag", attributeToInsert.Flag));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsUsedInConfigItem", attributeToInsert.IsUsedInConfigItem));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SaveOptions", attributeToInsert.SaveOptions));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_AttributeAddUpdate", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Bind Attribute Set Base On dropdown
        /// </summary>
        /// <returns></returns>
        public List<AttributeSetInfo> GetAttributeSet(int storeId, int portalId)
        {
            List<AttributeSetInfo> ml = new List<AttributeSetInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ml = Sq.ExecuteAsList<AttributeSetInfo>("dbo.usp_ASPX_AttributeSetGetAll", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To Save Attribute Set
        /// </summary>
        /// <returns></returns>
        public int SaveUpdateAttributeSet(AttributeSetInfo attributeSetInfoToInsert)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetInfoToInsert.AttributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetBaseID", attributeSetInfoToInsert.AttributeSetBaseID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetName", attributeSetInfoToInsert.AttributeSetName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", attributeSetInfoToInsert.IsActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", attributeSetInfoToInsert.IsModified));

                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", attributeSetInfoToInsert.StoreID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", attributeSetInfoToInsert.PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", attributeSetInfoToInsert.AddedBy));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpdateFlag", attributeSetInfoToInsert.Flag));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SaveString", attributeSetInfoToInsert.SaveString));
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteNonQuery("dbo.usp_ASPX_AttributeSetAddUpdate", ParaMeterCollection, "@AttributeSetIDOut");

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// Check unique Attribute set name
        /// </summary>
        /// <returns></returns>
        public int CheckAttributeSetUniqueName(int AttributeSetID, string AttributeSetName, int StoreID, int PortalID, bool UpdateFlag)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", AttributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetName", AttributeSetName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsEdit", UpdateFlag));
                SQLHandler Sq = new SQLHandler();
                return Sq.ExecuteNonQuery("dbo.usp_ASPX_AttributeSetUniquenessCheck", ParaMeterCollection, "@AttributeSetCount");
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To Bind Attribute set grid
        /// </summary>
        /// <returns></returns>
        public List<AttributeSetBaseInfo> GetAttributeSetGrid(int offset, int limit, string attributeSetName, System.Nullable<bool> isActive, System.Nullable<bool> usedInSystem, int storeId, int portalId, string cultureName, string userName)
        {
            List<AttributeSetBaseInfo> ml = new List<AttributeSetBaseInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetName", attributeSetName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UsedInSystem", usedInSystem));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            //ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));            
            ml = Sq.ExecuteAsList<AttributeSetBaseInfo>("dbo.usp_ASPX_AttributeSetGridGetAll", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To Bind Attribute set from fill using Attribute set ID
        /// </summary>
        /// <returns></returns>
        public List<AttributeSetGetByAttributeSetIDInfo> GetAttributeSetInfoByAttributeSetID(int attributeSetId, int storeId, int portalId, string userName, string cultureName)
        {
            List<AttributeSetGetByAttributeSetIDInfo> ml = new List<AttributeSetGetByAttributeSetIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ml = Sq.ExecuteAsList<AttributeSetGetByAttributeSetIDInfo>("dbo.usp_ASPX_AttributeSetGetByAttributeSetID", ParaMeterCollection);
            return ml;
        }

        /// <summary>
        /// To update, delete  Attribute Set only if it is NOT SystemUsed Type
        /// </summary>
        /// <returns></returns>
        public void DeleteAttributeSet(int attributeSetId, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteAttributeSetByAttributeSetID", ParaMeterCollection);

            }
            catch (Exception e)
            {
                throw e;
            }
        }


        /// <summary>
        /// To update, delete  Attribute Set only if it is NOT SystemUsed Type
        /// </summary>
        /// <returns></returns>
        public void UpdateAttributeSetIsActive(int attributeSetId, int storeId, int portalId, string userName, bool isActive)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_UpdateAttributeSetIsActiveByAttributeSetID", ParaMeterCollection);

            }
            catch (Exception e)
            {
                throw e;
            }
        }

        /// <summary>
        /// To update, add  Attribute Group
        /// </summary>
        /// <returns></returns>
        public void UpdateAttributeGroup(int attributeSetId, string groupName, int GroupID, string CultureName, string Aliasname, int storeId, int portalId, string userName, bool isActive, bool isModified, bool flag)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@GroupName", groupName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", isModified));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@GroupID", GroupID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AliasName", Aliasname));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UpdateFlag", flag));

                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_AttributeGroupAddUpdate", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void DeleteAttributeSetGroup(int attributeSetId, int groupId, int storeId, int portalId, string userName, string cultureName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@GroupID", groupId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));

                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteAttributeSetGroupByAttributeSetID", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public List<AttributeSetGroupAliasInfo> RenameAttributeSetGroupAlias(AttributeSetGroupAliasInfo attributeSetInfoToUpdate)
        {
            try
            {
                List<AttributeSetGroupAliasInfo> ml = new List<AttributeSetGroupAliasInfo>();
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@GroupID", attributeSetInfoToUpdate.GroupID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", attributeSetInfoToUpdate.CultureName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AliasName", attributeSetInfoToUpdate.AliasName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetInfoToUpdate.AttributeSetID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", attributeSetInfoToUpdate.StoreID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", attributeSetInfoToUpdate.PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", attributeSetInfoToUpdate.IsActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", attributeSetInfoToUpdate.IsModified));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", attributeSetInfoToUpdate.UpdatedBy));
                SQLHandler Sq = new SQLHandler();
                ml = Sq.ExecuteAsList<AttributeSetGroupAliasInfo>("dbo.usp_ASPX_AttributeGroupAliasRename", ParaMeterCollection);
                return ml;
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void DeleteAttribute(int attributeSetId, int groupId, int attributeId, int storeId, int portalId, string userName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeSetID", attributeSetId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@GroupID", groupId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AttributeID", attributeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));

                SQLHandler Sq = new SQLHandler();
                Sq.ExecuteNonQuery("dbo.usp_ASPX_DeleteAttributeByAttributeSetID", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        ///// <summary>
        ///// To Bind Items grid
        ///// </summary>
        ///// <returns></returns>
        //public void List<ItemsInfo> GetItems(int offset, int limit, int storeId, int portalId, string userName, string cultureName)
        //{
        //    List<ItemsInfo> ml = new List<ItemsInfo>();
        //    SQLHandler Sq = new SQLHandler();
        //    List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName)); 
        //    ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));           
        //    ml = Sq.ExecuteAsList<ItemsInfo>("dbo.usp_ASPX_ItemsGetAll", ParaMeterCollection);
        //    return ml;
        //}       
    }   
}
