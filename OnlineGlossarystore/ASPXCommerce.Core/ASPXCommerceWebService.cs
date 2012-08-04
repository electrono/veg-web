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
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using SageFrame.Web.Utilities;
using ASPXCommerce.Core;
using SageFrame.Web;
using System.Data.SqlClient;
using System.Text;
using System.IO;
using System.Data;
using System.Runtime.Serialization;
using SageFrame.SageFrameClass.MessageManagement;
using SageFrame.Security;
using SageFrame.Security.Entities;
using System.Web.Security;
using SageFrame.Security.Helpers;
using CurrencyConverter;
using SageFrame.RolesManagement;

/// <summary>
/// Summary description for ASPXCommerceWebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class ASPXCommerceWebService : System.Web.Services.WebService
{

    public ASPXCommerceWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    #region Testing Method
    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }
    #endregion

    #region Header Menu category Lister
    [WebMethod]
    public List<CategoryInfo> GetCategoryMenuList(int storeID, int portalID, string cultureName)
    {
        List<CategoryInfo> catInfo = new List<CategoryInfo>();

        List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
        paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        paramCol.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sageSQL = new SQLHandler();
        catInfo = sageSQL.ExecuteAsList<CategoryInfo>("[dbo].[usp_aspx_GetCategoryMenuAttributes]", paramCol);

        return catInfo;
    }
    #endregion

    #region ASPX BreadCrumb
    [WebMethod]
    public string GetCategoryForItem(int storeID, int portalID, string itemSku)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemSku", itemSku));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsScalar<string>("usp_ASPX_GetCategoryforItems", ParaMeter);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    #endregion

    #region General Functions
    //--------------------Roles Lists------------------------    
    [WebMethod]
    public List<PortalRole> GetAllRoles(Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            List<PortalRole> portalRoleCollection = new List<PortalRole>();
            PriceRuleController priceRuleController = new PriceRuleController();
            portalRoleCollection = priceRuleController.GetPortalRoles(portalID, true, userName);
            return portalRoleCollection;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------Store Lists------------------------    
    [WebMethod]
    public List<StoreInfo> GetAllStores(int portalID, string userName, string culture)
    {
        StoreSqlProvider storeSqlProvider = new StoreSqlProvider();
        return storeSqlProvider.GetAllStores(portalID, userName, culture);
    }

    //----------------country list------------------------------    
    [WebMethod]
    public List<CountryInfo> BindCountryList()
    {
        try
        {
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CountryInfo>("usp_ASPX_BindTaxCountryList");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //----------------state list--------------------------    
    [WebMethod]
    public List<StateInfo> BindStateList()
    {
        try
        {
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<StateInfo>("usp_ASPX_BindStateList");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //----------------Currency List----------------------
    //[WebMethod]
    //public List<CurrencyInfo> BindCurrencyList()
    //{
    //    try
    //    {
    //        SQLHandler sqlH = new SQLHandler();
    //        return sqlH.ExecuteAsList<CurrencyInfo>("usp_ASPX_BindCurrencyList");
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}
    #endregion

    #region Status Management
    //------------------Status DropDown-------------------    
    [WebMethod]
    public List<StatusInfo> GetStatus(string cultureName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return sqLH.ExecuteAsList<StatusInfo>("usp_ASPX_GetStatusList", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Bind Users DropDown
    [WebMethod]
    public List<UserInRoleInfo> BindRoles(int portalID, bool isAll, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@IsAll", isAll));
            parameter.Add(new KeyValuePair<string, object>("@Username", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<UserInRoleInfo>("sp_PortalRoleList", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Attributes Management
    [WebMethod]
    public List<AttributesInputTypeInfo> GetAttributesInputTypeList()
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributesInputType();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributesItemTypeInfo> GetAttributesItemTypeList(int storeId, int portalId)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributesItemType(storeId, portalId);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributesValidationTypeInfo> GetAttributesValidationTypeList()
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributesValidationType();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributesBasicInfo> GetAttributesList(int offset, int limit, string attributeName, System.Nullable<bool> isRequired, System.Nullable<bool> comparable, System.Nullable<bool> IsSystem, int storeId, int portalId, string cultureName, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetItemAttributes(offset, limit, attributeName, isRequired, comparable, IsSystem, storeId, portalId, cultureName, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributesGetByAttributeIDInfo> GetAttributeDetailsByAttributeID(int attributeId, int storeId, int portalId, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributesInfoByAttributeID(attributeId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteMultipleAttributesByAttributeID(string attributeIds, int storeId, int portalId, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.DeleteMultipleAttributes(attributeIds, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteAttributeByAttributeID(int attributeId, int storeId, int portalId, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.DeleteAttribute(attributeId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateAttributeIsActiveByAttributeID(int attributeId, int storeId, int portalId, string userName, bool isActive)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.UpdateAttributeIsActive(attributeId, storeId, portalId, userName, isActive);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveUpdateAttributeInfo(int attributeId, string attributeName, int inputTypeID, string defaultValue, int validationTypeID,
        System.Nullable<int> length, string aliasName, string aliasToolTip, string aliasHelp, int displayOrder, bool isUnique, bool isRequired, bool isEnableEditor,
        bool showInGrid, bool showInSearch, bool showInAdvanceSearch, bool showInComparison, bool isIncludeInPriceRule,
        bool isIncludeInPromotions, bool isEnableSorting, bool isUseInFilter, bool isShownInRating, int storeId, int portalId,
        bool isActive, bool isModified, string userName, string cultureName, string itemTypes, bool flag, bool isUsedInConfigItem, string saveOptions)
    {
        try
        {
            AttributesGetByAttributeIDInfo attributeInfoToInsert = new AttributesGetByAttributeIDInfo
            {
                AttributeID = attributeId,
                AttributeName = attributeName,
                InputTypeID = inputTypeID,
                DefaultValue = defaultValue,
                ValidationTypeID = validationTypeID,
                Length = length > 0 ? length : null,
                AliasName = aliasName,
                AliasToolTip = aliasToolTip,
                AliasHelp = aliasHelp,
                DisplayOrder = displayOrder,
                IsUnique = isUnique,
                IsRequired = isRequired,
                IsEnableEditor = isEnableEditor,
                ShowInGrid = showInGrid,
                ShowInSearch = showInSearch,
                ShowInAdvanceSearch = showInAdvanceSearch,
                ShowInComparison = showInComparison,
                IsIncludeInPriceRule = isIncludeInPriceRule,
                IsIncludeInPromotions = isIncludeInPromotions,
                IsEnableSorting = isEnableSorting,
                IsUseInFilter = isUseInFilter,
                IsShownInRating = isShownInRating,
                StoreID = storeId,
                PortalID = portalId,
                IsActive = isActive,
                IsModified = isModified,
                UpdatedBy = userName,
                AddedBy = userName,
                CultureName = cultureName,
                ItemTypes = itemTypes,
                Flag = flag,
                IsUsedInConfigItem = isUsedInConfigItem,
                SaveOptions = saveOptions
            };
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.SaveAttribute(attributeInfoToInsert);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region AttributeSet Management
    [WebMethod]
    public List<AttributeSetBaseInfo> GetAttributeSetGrid(int offset, int limit, string attributeSetName, System.Nullable<bool> isActive, System.Nullable<bool> usedInSystem, int storeId, int portalId, string cultureName, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributeSetGrid(offset, limit, attributeSetName, isActive, usedInSystem, storeId, portalId, cultureName, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    [WebMethod]
    public List<AttributeSetInfo> GetAttributeSetList(int storeId, int portalId)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributeSet(storeId, portalId);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    [WebMethod]
    public int SaveUpdateAttributeSetInfo(int attributeSetId, int attributeSetBaseId, string attributeSetName, int storeId, int portalId,
        bool isActive, bool isModified, string userName, bool flag, string saveString)
    {
        try
        {
            AttributeSetInfo attributeSetInfoToInsert = new AttributeSetInfo
            {
                AttributeSetID = attributeSetId,
                AttributeSetBaseID = attributeSetBaseId,
                AttributeSetName = attributeSetName,
                StoreID = storeId,
                PortalID = portalId,
                IsActive = isActive,
                IsModified = isModified,
                UpdatedBy = userName,
                AddedBy = userName,
                Flag = flag,
                SaveString = saveString
            };
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.SaveUpdateAttributeSet(attributeSetInfoToInsert);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public int CheckAttributeSetUniqueness(int attributeSetId, string attributeSetName, int storeId, int portalId, bool updateFlag)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.CheckAttributeSetUniqueName(attributeSetId, attributeSetName, storeId, portalId, updateFlag);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributeSetGetByAttributeSetIDInfo> GetAttributeSetDetailsByAttributeSetID(int attributeSetId, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.GetAttributeSetInfoByAttributeSetID(attributeSetId, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteAttributeSetByAttributeSetID(int attributeSetId, int storeId, int portalId, string userName)
    {
        try
        {
            //AttributeSetInfo attributeSetInfoToInsert = new AttributeSetInfo
            //{
            //    AttributeSetID = attributeSetId,
            //    StoreID = storeId,
            //    PortalID = portalId,
            //    DeletedBy = userName
            //};
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.DeleteAttributeSet(attributeSetId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateAttributeSetIsActiveByAttributeSetID(int attributeSetId, int storeId, int portalId, string userName, bool isActive)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.UpdateAttributeSetIsActive(attributeSetId, storeId, portalId, userName, isActive);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveUpdateAttributeGroupInfo(int attributeSetId, string groupName, int GroupID, string CultureName, string Aliasname, int StoreId, int PortalId, string UserName, bool isActive, bool isModified, bool flag)
    {
        //attributeSetId: 1, groupName: node, GroupID: _groupId, CultureName: cultureName, AliasName: node, storeId: _storeId, portalId: _portalId, userName: _userName, isActive: _isActive, isModified: _isModified, flag: _updateFlag
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.UpdateAttributeGroup(attributeSetId, groupName, GroupID, CultureName, Aliasname, StoreId, PortalId, UserName, isActive, isModified, flag);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteAttributeSetGroupByAttributeSetID(int attributeSetId, int groupId, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.DeleteAttributeSetGroup(attributeSetId, groupId, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributeSetGroupAliasInfo> RenameAttributeSetGroupAliasByGroupID(int groupId, string cultureName, string aliasName, int attributeSetId, int storeId, int portalId, bool isActive, bool isModified, string userName)
    {
        try
        {
            AttributeSetGroupAliasInfo attributeSetInfoToUpdate = new AttributeSetGroupAliasInfo
            {
                GroupID = groupId,
                CultureName = cultureName,
                AliasName = aliasName,
                AttributeSetID = attributeSetId,
                StoreID = storeId,
                PortalID = portalId,
                IsActive = isActive,
                IsModified = isModified,
                UpdatedBy = userName
            };
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            return obj.RenameAttributeSetGroupAlias(attributeSetInfoToUpdate);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteAttributeByAttributeSetID(int attributeSetId, int groupId, int attributeId, int storeId, int portalId, string userName)
    {
        try
        {
            ItemAttributesManagementSqlProvider obj = new ItemAttributesManagementSqlProvider();
            obj.DeleteAttribute(attributeSetId, groupId, attributeId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Items Management
    [WebMethod]
    public List<ItemsInfo> GetItemsList(int offset, int limit, string Sku, string name, string itemType, string attributesetName, string visibility, System.Nullable<bool> isActive, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetAllItems(offset, limit, Sku, name, itemType, attributesetName, visibility, isActive, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteMultipleItemsByItemID(string itemIds, int storeId, int portalId, string userName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            obj.DeleteMultipleItems(itemIds, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteItemByItemID(string itemId, int storeId, int portalId, string userName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            obj.DeleteSingleItem(itemId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributeFormInfo> GetItemFormAttributes(int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<AttributeFormInfo> frmItemFieldList = obj.GetItemFormAttributes(attributeSetID, itemTypeID, storeID, portalID, userName, culture);
        return frmItemFieldList;
    }

    [WebMethod]
    public List<AttributeFormInfo> GetItemFormAttributesByitemSKUOnly(string itemSKU, int storeID, int portalID, string userName, string culture)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<AttributeFormInfo> frmItemFieldList = obj.GetItemFormAttributesByItemSKUOnly(itemSKU, storeID, portalID, userName, culture);
        return frmItemFieldList;
    }

    [WebMethod]
    public List<AttributeFormInfo> GetItemFormAttributesValuesByItemID(int itemID, int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<AttributeFormInfo> frmItemAttributes = obj.GetItemAttributesValuesByItemID(itemID, attributeSetID, itemTypeID, storeID, portalID, userName, culture);
        return frmItemAttributes;
    }

    [WebMethod]
    public void SaveItemAndAttributes(int itemID, int itemTypeID, int attributeSetID, int storeID, int portalID, string userName, string culture, int taxRuleID, string categoriesIds, string relatedItemsIds, string upSellItemsIds, string crossSellItemsIds, string downloadItemsValue, string sourceFileCol, string dataCollection, ASPXNameValue[] formVars)
    {
        try
        {
           string uplodedDownlodableFormValue = string.Empty;

            if (itemTypeID == 2 && downloadItemsValue != "")
            {
                FileHelperController downLoadableObj = new FileHelperController();
                string tempFolder = @"Upload\temp";
                uplodedDownlodableFormValue = downLoadableObj.MoveFileToDownlodableItemFolder(tempFolder,
                                                                                              downloadItemsValue,
                                                                                              @"Modules/ASPXCommerce/ASPXItemsManagement/DownloadableItems/",
                                                                                              itemID, "item_");
            }

            ItemsController itemController = new ItemsController();
            itemID = itemController.SaveUpdateItemAndAttributes(itemID, itemTypeID, attributeSetID, storeID, portalID,
                                                                userName, culture, taxRuleID,
                                                                categoriesIds, relatedItemsIds, upSellItemsIds,
                                                                crossSellItemsIds, uplodedDownlodableFormValue,
                                                                formVars);
            //return "({\"returnStatus\":1,\"Message\":'Item saved successfully.'})";
            if (itemID > 0 && sourceFileCol != "" && dataCollection != "")
            {
                int itemLargeThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemLargeThumbnailImageSize, storeID,
                                                                                                portalID, culture));
                int itemMediumThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemMediumThumbnailImageSize,
                                                                                                     storeID, portalID, culture));
                int itemSmallThumbNailSize = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.ItemSmallThumbnailImageSize, storeID,
                                                                                                    portalID, culture));
            
                dataCollection = dataCollection.Replace("../", "");
                SaveImageContents(itemID, @"Modules/ASPXCommerce/ASPXItemsManagement/uploads/", sourceFileCol,
                                  dataCollection, itemLargeThumbNailSize, itemMediumThumbNailSize,
                                  itemSmallThumbNailSize, "item_");
            }
            else if (itemID > 0 && sourceFileCol == "" && dataCollection == "")
            {
                DeleteImageContents(itemID);
            }

            //if (itemID==0)
            //{
            //    //SaveImageContents(itemID, @"Modules/ASPXCommerce/ASPXItemsManagement/uploads/", sourceFileCol, dataCollection, "item_");
            //    //TODO:: DELTE UPLOADED FILE FROM DOWNLOAD FOLDER

            //}
        }
        catch (Exception ex)
        {
            throw ex;
            //ErrorHandler errHandler = new ErrorHandler();
            //if (errHandler.LogWCFException(ex))
            //{
            //    return "({\"returnStatus\":-1,\"errorMessage\":'" + ex.Message + "'})";
            //}
            //else
            //{
            //    return "({\"returnStatus\":-1,\"errorMessage\":'Error while saving item!'})";
            //}
        }
    }

    [WebMethod]
    public void UpdateItemIsActiveByItemID(int itemId, int storeId, int portalId, string userName, bool isActive)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            obj.UpdateItemIsActive(itemId, storeId, portalId, userName, isActive);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckUniqueAttributeName(string attributeName, int attributeId, int storeId, int portalId, string cultureName)
    {
        try
        {
            AttributeSqlProvider obj = new AttributeSqlProvider();
            return obj.CheckUniqueName(attributeName, attributeId, storeId, portalId, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CategoryInfo> GetCategoryList(string prefix, bool isActive, string cultureName, Int32 storeID, Int32 portalID, string userName, int itemId)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<CategoryInfo> catList = obj.GetCategoryList(prefix, isActive, cultureName, storeID, portalID, userName, itemId);
        return catList;
    }

    [WebMethod]
    public bool CheckUniqueItemSKUCode(string SKU, int itemId, int storeId, int portalId, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.CheckUniqueSKUCode(SKU, itemId, storeId, portalId, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Multiple Image Uploader
    [WebMethod]
    public string SaveImageContents(Int32 ItemID, string imageRootPath, string sourceFileCol, string dataCollection, int itemLargeThumbNailSize, int itemMediumThumbNailSize, int itemSmallThumbNailSize, string imgPreFix)
    {

        if (dataCollection.Contains("#"))
        {
            dataCollection = dataCollection.Remove(dataCollection.LastIndexOf("#"));
        }
        SQLHandler sageSql = new SQLHandler();
        string[] individualRow = dataCollection.Split('#');
        string[] words;

        StringBuilder sbPathList = new StringBuilder();
        StringBuilder sbIsActiveList = new StringBuilder();
        StringBuilder sbImageType = new StringBuilder();
        StringBuilder sbDescription = new StringBuilder();
        StringBuilder sbDisplayOrder = new StringBuilder();
        StringBuilder sbSourcePathList = new StringBuilder();

        foreach (string str in individualRow)
        {
            words = str.Split('%');
            sbPathList.Append(words[0] + "%");
            sbIsActiveList.Append(words[1] + "%");
            sbImageType.Append(words[2] + "%");
            sbDescription.Append(words[3] + "%");
            sbDisplayOrder.Append(words[4] + "%");
        }
        string pathList = string.Empty;
        string isActive = string.Empty;
        string imageType = string.Empty;
        string description = string.Empty;
        string displayOrder = string.Empty;

        pathList = sbPathList.ToString();
        isActive = sbIsActiveList.ToString();
        imageType = sbImageType.ToString();
        description = sbDescription.ToString();
        displayOrder = sbDisplayOrder.ToString();

        if (pathList.Contains("%"))
        {
            pathList = pathList.Remove(pathList.LastIndexOf("%"));
        }
        if (isActive.Contains("%"))
        {
            isActive = isActive.Remove(isActive.LastIndexOf("%"));
        }
        if (imageType.Contains("%"))
        {
            imageType = imageType.Remove(imageType.LastIndexOf("%"));
        }

        if (sourceFileCol.Contains("%"))
        {
            sourceFileCol = sourceFileCol.Remove(sourceFileCol.LastIndexOf("%"));
        }

        ImageUploaderSqlhandler imageManager = new ImageUploaderSqlhandler();

        try
        {
            FileHelperController fhc = new FileHelperController();
            //TODO:: delete all previous files infos lists
            fhc.FileMover(ItemID, imageRootPath, sourceFileCol, pathList, isActive, imageType, description, displayOrder, imgPreFix, itemLargeThumbNailSize, itemMediumThumbNailSize, itemSmallThumbNailSize);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return "Success";

    }

    [WebMethod]
    public List<ItemsInfoSettings> GetImageContents(int itemID)
    {
        List<ItemsInfoSettings> itemsImages = new List<ItemsInfoSettings>();
        ImageGallerySqlProvider imageGalleryManager = new ImageGallerySqlProvider();
        itemsImages = imageGalleryManager.GetItemsImageGalleryInfoByItemID(itemID);
        return itemsImages;
    }

    [WebMethod]
    public void DeleteImageContents(Int32 itemID)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            obj.DeleteItemImageByItemID(itemID);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Related, Cross Sell, Up sell Items
    [WebMethod]
    public List<ItemsInfo> GetRelatedItemsList(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetRelatedItemsByItemID(offset, limit, storeId, portalId, selfItemId, userName, culture);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemsInfo> GetUpSellItemsList(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetUpSellItemsByItemID(offset, limit, storeId, portalId, selfItemId, userName, culture);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemsInfo> GetCrossSellItemsList(int offset, int limit, int storeId, int portalId, int selfItemId, string userName, string culture)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetCrossSellItemsByItemID(offset, limit, storeId, portalId, selfItemId, userName, culture);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Item Cost Variants Management
    [WebMethod]
    public List<CostVariantInfo> GetCostVariantsOptionsList(int itemId, int storeId, int portalId, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetAllCostVariantOptions(itemId, storeId, portalId, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------bind Item Cost Variants in Grid--------------------------    
    [WebMethod]
    public List<ItemCostVariantInfo> GetItemCostVariants(int offset, int limit, int storeID, int portalID, string cultureName, int itemID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            SQLHandler sqLH = new SQLHandler();
            List<ItemCostVariantInfo> bind = sqLH.ExecuteAsList<ItemCostVariantInfo>("usp_ASPX_BindItemCostVariantsInGrid", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------ delete Item Cost Variants management------------------------    
    [WebMethod]
    public void DeleteSingleItemCostVariant(string itemCostVariantID, int itemId, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemCostVariantsID", itemCostVariantID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteSingleItemCostVariants", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------ add Item Cost Variants ------------------------    
    [WebMethod]
    public void AddItemCostVariant(int itemId, int costVariantID, int storeId, int portalId, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_InsertItemCostVariant", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- bind (edit) item cost Variant details --------------------    
    [WebMethod]
    public List<CostVariantsGetByCostVariantIDInfo> GetItemCostVariantInfoByCostVariantID(int itemCostVariantId, int itemId, int costVariantID, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<CostVariantsGetByCostVariantIDInfo> bind = new List<CostVariantsGetByCostVariantIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemCostVariantsID", itemCostVariantId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return Sq.ExecuteAsList<CostVariantsGetByCostVariantIDInfo>("usp_ASPX_ItemCostVariantsGetByCostVariantID", ParaMeterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- bind (edit) item cost Variant values for cost variant ID --------------------    
    [WebMethod]
    public List<CostVariantsvalueInfo> GetItemCostVariantValuesByCostVariantID(int itemCostVariantId, int itemId, int costVariantID, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<CostVariantsGetByCostVariantIDInfo> bind = new List<CostVariantsGetByCostVariantIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemCostVariantsID", itemCostVariantId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return Sq.ExecuteAsList<CostVariantsvalueInfo>("usp_ASPX_GetItemCostVariantValuesByCostVariantID", ParaMeterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------ delete costvariant value ------------------------    
    [WebMethod]
    public void DeleteCostVariantValue(int costVariantValueID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            if (costVariantValueID > 0)
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantValueID", costVariantValueID));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                SQLHandler sqlH = new SQLHandler();
                sqlH.ExecuteNonQuery("usp_ASPX_DeleteCostVariantValue", ParaMeter);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------Save and update Item Costvariant options-------------------------    
    [WebMethod]
    public void SaveAndUpdateItemCostVariant(int costVariantID, string costVariantName, string description, string cultureName, int itemId, int inputTypeID,
        int displayOrder, bool showInGrid, bool showInSearch, bool showInAdvanceSearch, bool showInComparison, bool isEnableSorting, bool isUseInFilter,
        bool isIncludeInPriceRule, bool isIncludeInPromotions, bool isShownInRating, int storeId, int portalId,
        bool isActive, bool isModified, string userName, string variantOptions, bool isNewflag)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantName", costVariantName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Description", description));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@InputTypeID", inputTypeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInGrid", showInGrid));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInSearch", showInSearch));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInAdvanceSearch", showInAdvanceSearch));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInComparison", showInComparison));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsEnableSorting", isEnableSorting));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsUseInFilter", isUseInFilter));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPriceRule", isIncludeInPriceRule));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPromotions", isIncludeInPromotions));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsShownInRating", isShownInRating));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", isModified));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@VariantOption", variantOptions));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsNewFlag", isNewflag));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantsValueID", 0));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemCostVariantsID", 0));
            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("usp_ASPX_SaveAndUpdateItemCostVariants", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    //------------------------ delete item costvariant value ------------------------    
    [WebMethod]
    public void DeleteItemCostVariantValue(int itemCostVariantId, int costVariantValueId, int itemId, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            if (itemCostVariantId > 0 && costVariantValueId > 0)
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@ItemCostVariantsID", itemCostVariantId));
                ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantValueID", costVariantValueId));
                ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemId));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                SQLHandler sqlH = new SQLHandler();
                sqlH.ExecuteNonQuery("usp_ASPX_DeleteItemCostVariantValue", ParaMeter);
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Item Tax
    [WebMethod]
    public List<TaxRulesInfo> GetAllTaxRules(int storeID, int portalID, bool isActive)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<TaxRulesInfo> lstTaxManageRule = obj.GetAllTaxRules(storeID, portalID, isActive);
        return lstTaxManageRule;
    }
    #endregion

    #region Downloadable Item Details
    [WebMethod]
    public List<DownLoadableItemInfo> GetDownloadableItem(int storeId, int portalId, string userName, string cultureName, int ItemID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ItemID));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<DownLoadableItemInfo>("usp_ASPX_GetDownloadableItem", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #endregion

    #region Front Image Gallery
    [WebMethod]
    public List<ItemsInfoSettings> GetItemsImageGalleryInfoBySKU(string itemSKU, int storeID,int portalID)
    {
        List<ItemsInfoSettings> itemsInfo = new List<ItemsInfoSettings>();
        ImageGallerySqlProvider imageSqlProvider = new ImageGallerySqlProvider();
        itemsInfo = imageSqlProvider.GetItemsImageGalleryInfoByItemSKU(itemSKU,storeID,portalID);
        return itemsInfo;
    }

    [WebMethod]
    public List<ImageGalleryItemsInfo> GetItemsImageGalleryInfo(Int32 storeID, Int32 portalID, string userName, string culture)
    {
        List<ImageGalleryItemsInfo> itemsInfo = new List<ImageGalleryItemsInfo>();
        ImageGallerySqlProvider imageSettingsProvider = new ImageGallerySqlProvider();
        itemsInfo = imageSettingsProvider.GetItemsImageGalleryList(storeID, portalID, userName, culture);
        return itemsInfo;
    }

    [WebMethod]
    public List<ImageGalleryItemsInfo> GetItemsGalleryInfo(Int32 storeID, Int32 portalID, string culture)
    {
        List<ImageGalleryItemsInfo> itemsInfo = new List<ImageGalleryItemsInfo>();
        ImageGallerySqlProvider imageSettingsProvider = new ImageGallerySqlProvider();
        itemsInfo = imageSettingsProvider.GetItemInfoList(storeID, portalID, culture);
        return itemsInfo;
    }

    [WebMethod]
    public ImageGalleryInfo ReturnSettings(Int32 UserModuleID, Int32 PortalID, string culture)
    {
        ImageGalleryInfo gallerySettingsInfo = new ImageGalleryInfo();
        ImageGallerySqlProvider settings = new ImageGallerySqlProvider();
        gallerySettingsInfo = settings.GetGallerySettingValues(UserModuleID, PortalID, culture);
        return gallerySettingsInfo;
    }

    [WebMethod]
    public List<int> ReturnDimension(Int32 UserModuleID, Int32 PortalID, string culture)
    {
        List<int> param = new List<int>();
        ImageGalleryInfo info = new ImageGalleryInfo();
        ImageGallerySqlProvider settings = new ImageGallerySqlProvider();

        info = settings.GetGallerySettingValues(UserModuleID, PortalID, culture);
        param.Add(int.Parse(info.ImageWidth));
        param.Add(int.Parse(info.ImageHeight));
        param.Add(int.Parse(info.ThumbWidth));
        param.Add(int.Parse(info.ThumbHeight));
        //param.Add(int.Parse(info.ZoomShown));
        return param;
    }
    #endregion

    #region Category Management
    [WebMethod]
    public bool CheckUniqueCategoryName(string catName, int catId, int storeId, int portalId, string cultureName)
    {
        try
        {
            CategorySqlProvider obj = new CategorySqlProvider();
            return obj.CheckUniqueName(catName, catId, storeId, portalId, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool IsUnique(Int32 storeID, Int32 portalID, Int32 itemID, Int32 attributeID, Int32 attributeType, string attributeValue)
    {
        try
        {
            AttributeSqlProvider attributeSqlProvider = new AttributeSqlProvider();
            /*
            1	TextField
            2	TextArea
            3	Date
            4	Boolean
            5	MultipleSelect
            6	DropDown
            7	Price
            8	File
            9	Radio
            10	RadioButtonList
            11	CheckBox
            12	CheckBoxList
             */
            bool isUnique = false;
            switch (attributeType)
            {
                case 1:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_NVARCHAR(1, storeID, portalID, attributeID, attributeValue);
                    break;
                case 2:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_TEXT(1, storeID, portalID, attributeID, attributeValue);
                    break;
                case 3:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_DATE(1, storeID, portalID, attributeID, DateTime.Parse(attributeValue));
                    break;
                case 4:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_Boolean(1, storeID, portalID, attributeID, bool.Parse(attributeValue));
                    break;
                case 5:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
                case 6:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
                case 7:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_Decimal(1, storeID, portalID, attributeID, decimal.Parse(attributeValue));
                    break;
                case 8:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_FILE(1, storeID, portalID, attributeID, attributeValue);
                    break;
                case 9:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
                case 10:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
                case 11:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
                case 12:
                    isUnique = attributeSqlProvider.aspx_sp_CheckUniqueness_INT(1, storeID, portalID, attributeID, Int32.Parse(attributeValue));
                    break;
            }
            return isUnique;
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            errHandler.LogWCFException(ex);
            return false;
        }
    }

    [WebMethod]
    public List<AttributeFormInfo> GetCategoryFormAttributes(Int32 categoryID, Int32 portalID, Int32 storeID, string userName, string culture)
    {
        try
        {
            CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
            List<AttributeFormInfo> frmFieldList = categorySqlProvider.GetCategoryFormAttributes(categoryID, portalID, storeID, userName, culture);
            return frmFieldList;
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            errHandler.LogWCFException(ex);
            throw ex;
        }
    }

    [WebMethod]
    public List<CategoryInfo> GetCategoryAll(bool isActive, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
            List<CategoryInfo> catList = categorySqlProvider.GetCategoryAll(isActive, storeID, portalID, userName, culture);
            return catList;
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            errHandler.LogWCFException(ex);
            throw ex;
        }
    }

    [WebMethod]
    public List<CategoryAttributeInfo> GetCategoryByCategoryID(Int32 categoryID, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
        List<CategoryAttributeInfo> catList = categorySqlProvider.GetCategoryByCategoryID(categoryID, storeID, portalID, userName, culture);
        return catList;
    }

    [WebMethod]
    public string SaveCategory(Int32 storeID, Int32 portalID, Int32 categoryID, Int32 parentID, ASPXNameValue[] formVars, string selectedItems, string userName, string culture, int categoryLargeThumbImage, int categoryMediumThumbImage, int categorySmallThumbImage)
    {
        try
        {
            CategoryController categoryController = new CategoryController();
            categoryController.SaveCategory(storeID, portalID, categoryID, parentID, formVars, selectedItems, userName, culture, categoryLargeThumbImage, categoryMediumThumbImage, categorySmallThumbImage);
            return "({\"returnStatus\":1,\"Message\":\"Category save successfully.\"})";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({\"returnStatus\":-1,\"errorMessage\":'" + ex.Message + "'})";
            }
            else
            {
                return "({\"returnStatus\":-1,\"errorMessage\":\"Error while saving category!\"})";
            }
        }
    }

    [WebMethod]
    public string DeleteCategory(Int32 storeID, Int32 portalID, Int32 categoryID, string userName, string culture)
    {
        try
        {
            CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
            categorySqlProvider.DeleteCategory(storeID, portalID, categoryID, userName, culture);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Category delete successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while deleting category!\" })";
            }
        }
    }

    [WebMethod]
    public List<CategoryItemInfo> GetCategoryItems(Int32 offset, Int32 limit, Int32 categoryID, string sku, string name, System.Nullable<decimal> priceFrom, System.Nullable<decimal> priceTo, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            List<CategoryItemInfo> listCategoryItem = new List<CategoryItemInfo>();
            CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
            listCategoryItem = categorySqlProvider.GetCategoryItems(offset, limit, categoryID, sku, name, priceFrom, priceTo, storeID, portalID, userName, culture);
            return listCategoryItem;
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            errHandler.LogWCFException(ex);
            throw ex;
        }
    }

    [WebMethod]
    public string SaveChangesCategoryTree(Int32 storeID, Int32 portalID, string categoryIDs, string userName)
    {
        try
        {
            CategorySqlProvider categorySqlProvider = new CategorySqlProvider();
            categorySqlProvider.SaveChangesCategoryTree(storeID, portalID, categoryIDs, userName);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Save category tree successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while saving category tree!\" })";
            }
        }
    }
    #endregion

    ////---------------- File Uploader --------------
    //    [WebMethod]
    //    public string SaveUploadFiles(string fileList)
    //    {
    //        try
    //        {
    //            string fileName = string.Empty;
    //            //HttpPostedFile ss; 
    //            //string strFileName = Path.GetFileName(HttpContext.Current.Request.Files[0].FileName);
    //            //string strExtension = Path.GetExtension(HttpContext.Current.Request.Files[0].FileName).ToLower();
    //            //string strSaveLocation = HttpContext.Current.Server.MapPath("Upload") + "" + strFileName;
    //            //HttpContext.Current.Request.Files[0].SaveAs(strSaveLocation);

    //            ////contentType: "application/json; charset=utf-8",
    //            //// contentType: "multipart/form-data"
    //            ////contentType: "text/html; charset=utf-8"
    //            //HttpContext.Current.Response.ContentType = "text/plain; charset=utf-8";
    //            //HttpContext.Current.Response.Write(strSaveLocation);
    //            //HttpContext.Current.Response.End();

    //            if (HttpContext.Current.Request.Files != null)
    //            {
    //                HttpFileCollection files = HttpContext.Current.Request.Files;
    //                for (int i = 0; i < files.Count; i++)
    //                {
    //                    HttpPostedFile file = files[i];
    //                    if (file.ContentLength > 0)
    //                    {
    //                        fileName = file.FileName;
    //                    }
    //                }
    //            }
    //            ////Code ommited
    //            //string jsonClient = null;
    //            //var j = new { fileName = response.key1 };
    //            //var s = new JavaScriptSerializer();
    //            //jsonClient = s.Serialize(j);
    //            //return jsonClient;

    //            return fileName;
    //        }
    //        catch (Exception ex)
    //        {
    //            throw ex;
    //        }
    //    }

    //--------------------CategoryItems------------------------------
    //[WebMethod]
    //public List<ItemsGetCategoryIDInfo> BindCategoryItems(int categoryID, int storeID, int portalID, string userName, string cultureName)
    //{
    //    try
    //    {
    //        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
    //        ParaMeter.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
    //        SQLHandler sqlH = new SQLHandler();
    //        List<ItemsGetCategoryIDInfo> Bind = sqlH.ExecuteAsList<ItemsGetCategoryIDInfo>("usp_ASPX_ItemsGetAllBycategoryID", ParaMeter);
    //        return Bind;

    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    //----------------General Search View As DropDown Options----------------------------
    #region Featured Items Management
    [WebMethod]
    public List<FeaturedItemsInfo> GetFeaturedItemsList(int storeId, int portalId, string userName, string cultureName, int count)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetFeaturedItemsByCount(storeId, portalId, userName, cultureName, count);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Recently Added/ Latest Items Management
    [WebMethod]
    public List<LatestItemsInfo> GetLatestItemsList(int storeId, int portalId, string userName, string cultureName, int count)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetLatestItemsByCount(storeId, portalId, userName, cultureName, count);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region CompareItems
    [WebMethod]
    public void SaveCompareItems(int ID, int storeID, int portalID, string userName, string IP, string countryName, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CompareItemID", 0));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IP", IP));
            ParaMeter.Add(new KeyValuePair<string, object>("@CountryName", countryName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_AddItemsToCompare", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemsCompareInfo> GetItemCompareList(int storeID, int portalID, string userName, string cultureName, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemsCompareInfo>("usp_ASPX_GetCompareItemsList", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteCompareItem(int ID, int storeID, int portalID, string userName, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("[usp_ASPX_DeleteCompareItem]", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void ClearAll(int storeID, int portalID, string userName, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("[usp_ASPX_ClearCompareItems]", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckCompareItems(int ID, int storeID, int portalID, string userName, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteNonQueryAsGivenType<bool>("[usp_ASPX_CheckCompareItems]", ParaMeter, "@IsExist");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Compare Items Details view-------------------------------
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetCompareListImage(string itemIDs, int storeID, int portalID, string userName, string cultureName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", itemIDs));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqlH = new SQLHandler();
        return sqlH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetCompareList", ParaMeter);
    }

    [WebMethod]
    public List<CompareItemListInfo> GetCompareList(string itemIDs, int storeID, int portalID, string userName, string cultureName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", itemIDs));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqlH = new SQLHandler();
        return sqlH.ExecuteAsList<CompareItemListInfo>("usp_ASPX_GetItemCompareList", ParaMeter);
    }

    #region RecentlyComparedProducts
    [WebMethod]
    public void AddComparedItems(string IDs, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", IDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_AddComparedItems", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemsCompareInfo> GetRecentlyComparedItemList(int count, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemsCompareInfo>("usp_ASPX_GetRecentlyComparedItemList", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #endregion

    #region WishItems
    [WebMethod]
    public bool CheckWishItems(int ID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteNonQueryAsGivenType<bool>("[usp_ASPX_CheckWishItems]", ParaMeter, "@IsExist");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveWishItems(int ID, int storeID, int portalID, string userName, string IP, string countryName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", ID));
        ParaMeter.Add(new KeyValuePair<string, object>("@WishItemID", 0));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
        ParaMeter.Add(new KeyValuePair<string, object>("@IP", IP));
        ParaMeter.Add(new KeyValuePair<string, object>("@CountryName", countryName));
        SQLHandler sqlH = new SQLHandler();
        sqlH.ExecuteNonQuery("usp_ASPX_SaveWishItems", ParaMeter);
    }

    [WebMethod]
    public List<WishItemsInfo> GetWishItemList(int storeID, int portalID, string userName, string cultureName, string flagShowAll, int count)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@flag", flagShowAll));
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<WishItemsInfo>("usp_ASPX_GetWishItemList", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteWishItem(int ID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteWishItem", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateWishList(string ID, string comment, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("ItemID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Comment", comment));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_UpdateWishItem", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void ClearWishList(int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_ClearWishItem", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------------Save AND SendEmail Messages For ShareWishList----------------
    [WebMethod]
    public void ShareWishListEmailSend(int StoreID, int PortalID, string ItemID, string SenderName, string SenderEmail, string ReceiverEmailID, string Subject, string Message, string Link, string CultureName)
    {
        try
        {
            string MessageBody = Link;
            ReferToFriendSqlHandler obj = new ReferToFriendSqlHandler();
            obj.SaveShareWishListEmailMessage(StoreID, PortalID, ItemID, SenderName, SenderEmail, ReceiverEmailID, Subject, Message, CultureName);
            obj.SendShareWishItemEmail(SenderEmail, ReceiverEmailID, Subject, MessageBody);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public int CountWishItems(int storeID, int portalID, string sessionCode, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsScalar<int>("usp_ASPX_GetWishItemsCount", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Related Items You may also like
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetYouMayAlsoLikeItemsListByItemSKU(string itemSKU, int storeID, int portalID, string userName, string cultureName, int count)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetYouMayAlsoLikeItemsByItemSKU", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region RecentlyViewedItems
    [WebMethod]
    public List<RecentlyViewedItemsInfo> GetRecentlyViewedItems(int count, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            List<RecentlyViewedItemsInfo> view = sqlH.ExecuteAsList<RecentlyViewedItemsInfo>("usp_ASPX_GetRecentlyViewedItemList", ParaMeter);
            return view;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdateRecentlyViewedItems(string itemSKU, string sessionCode, string IP, string countryName, string userName, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewFromIP", IP));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewedFromCountry", countryName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_AddRecentlyViewedItems", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Item Details Module
    [WebMethod]
    public ItemBasicDetailsInfo GetItemBasicInfoByitemSKU(string itemSKU, int storeID, int portalID, string userName, string culture)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        ItemBasicDetailsInfo frmItemAttributes = obj.GetItemBasicInfo(itemSKU, storeID, portalID, userName, culture);
        return frmItemAttributes;
    }

    [WebMethod]
    public List<ItemCostVariantsInfo> GetCostVariantsByitemSKU(string _itemSKU, int _storeID, int _portalID, string _cultureName, string _userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", _itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", _storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", _portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", _cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", _userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemCostVariantsInfo>("usp_ASPX_GetCostVariantsByItemID", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributeFormInfo> GetItemDetailsByitemSKU(string itemSKU, int attributeSetID, int itemTypeID, int storeID, int portalID, string userName, string culture)
    {
        ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
        List<AttributeFormInfo> frmItemAttributes = obj.GetItemDetailsInfoByItemSKU(itemSKU, attributeSetID, itemTypeID, storeID, portalID, userName, culture);
        return frmItemAttributes;
    }

    #endregion

    #region PopularTags Module
    [WebMethod]
    public void AddTagsOfItem(string itemSKU, string Tags, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Tags", Tags));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_AddTagsOfItem", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemTagsInfo> GetItemTags(string itemSKU, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemTagsInfo>("[usp_ASPX_GetTagsByItemID]", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteUserOwnTag(string itemTagID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemTagID", itemTagID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteUserOwnTag", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    [WebMethod]
    public void DeleteMultipleTag(string itemTagIDs, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@TagsIDS", itemTagIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteMultipleTags", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    [WebMethod]
    public List<TagDetailsInfo> GetTagDetailsListPending(int offset, int limit, string tag, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@Tags", tag));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            List<TagDetailsInfo> nir = sqLH.ExecuteAsList<TagDetailsInfo>("[dbo].[usp_ASPX_GetAllTagsPending]", ParaMeter);
            return nir;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<TagDetailsInfo> GetTagDetailsList(int offset, int limit, string tag, string tagStatus, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@Tags", tag));
            ParaMeter.Add(new KeyValuePair<string, object>("@TagStatus", tagStatus));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            List<TagDetailsInfo> nir = sqLH.ExecuteAsList<TagDetailsInfo>("usp_ASPX_GetAllTags", ParaMeter);
            return nir;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<TagDetailsInfo> GetAllPopularTags(int storeID, int portalID, string userName, int count)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@Count", count));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<TagDetailsInfo>("usp_ASPX_GetPopularTags", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<TagDetailsInfo> GetTagsByUserName(string userName, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<TagDetailsInfo>("usp_ASPX_GetTagsOfUser", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Tags Reports
    //---------------------Customer tags------------
    [WebMethod]
    public List<CustomerTagInfo> GetCustomerTagDetailsList(int offset, int limit, int storeId, int portalId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            List<CustomerTagInfo> bhu = sqLH.ExecuteAsList<CustomerTagInfo>("usp_ASPX_GetCustomerItemTags", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Show Customer tags list------------
    [WebMethod]
    public List<ShowCustomerTagsListInfo> ShowCustomerTagList(int offset, int limit, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            List<ShowCustomerTagsListInfo> bhu = sqLH.ExecuteAsList<ShowCustomerTagsListInfo>("usp_ASPX_ShowCustomerTagList", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Item tags details------------
    [WebMethod]
    public List<ItemTagsDetailsInfo> GetItemTagDetailsList(int offset, int limit, int storeId, int portalId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            List<ItemTagsDetailsInfo> bhu = sqLH.ExecuteAsList<ItemTagsDetailsInfo>("usp_ASPX_GetItemTagsDetails", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Show Item tags list------------
    [WebMethod]
    public List<ShowItemTagsListInfo> ShowItemTagList(int offset, int limit, int storeId, int portalId, int itemID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            SQLHandler sqLH = new SQLHandler();
            List<ShowItemTagsListInfo> bhu = sqLH.ExecuteAsList<ShowItemTagsListInfo>("usp_ASPX_ShowTagsByItems", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Popular tags details------------
    [WebMethod]
    public List<PopularTagsInfo> GetPopularTagDetailsList(int offset, int limit, int storeId, int portalId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            List<PopularTagsInfo> bhu = sqLH.ExecuteAsList<PopularTagsInfo>("usp_ASPX_GetPopularityTags", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Show Popular tags list------------
    [WebMethod]
    public List<ShowpopulartagsDetailsInfo> ShowPopularTagList(int offset, int limit, int storeId, int portalId, string tagName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@TagName", tagName));
            SQLHandler sqLH = new SQLHandler();
            List<ShowpopulartagsDetailsInfo> bhu = sqLH.ExecuteAsList<ShowpopulartagsDetailsInfo>("usp_ASPX_ShowPopularTagsDetails", ParaMeter);
            return bhu;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemBasicDetailsInfo> GetUserTaggedItems(string TagIDs, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@TagIDs", TagIDs));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetItemsByTagID", parameterCollection);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
    #endregion

    #region Tags Management
    [WebMethod]
    public void UpdateTag(string ItemTagIDs, string newTag, int StatusID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemTagIDs", ItemTagIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@NewTag", newTag));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusID", StatusID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_UpdateTag", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteTag(string ItemTagIDs, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemTagIDs", ItemTagIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteTag", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemBasicDetailsInfo> GetItemsByMultipleItemID(string ItemIDs, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", ItemIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetItemsByMultipleItemID", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    #endregion

    #region ShoppingOptions
    [WebMethod]
    public List<DisplayItemsOptionsInfo> BindItemsViewAsList()
    {
        try
        {

            SQLHandler sqlH = new SQLHandler();
            List<DisplayItemsOptionsInfo> Bind = sqlH.ExecuteAsList<DisplayItemsOptionsInfo>("usp_ASPX_DisplayItemViewAsOptions");
            return Bind;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------ShoppingOptionsByPrice----------------------------
    [WebMethod]
    public List<ShoppingOptionsInfo> ShoppingOptionsByPrice(int storeID, int portalID, string userName, string cultureName, int upperLimit)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@Limit", upperLimit));
            SQLHandler sqlH = new SQLHandler();
            List<ShoppingOptionsInfo> Count = sqlH.ExecuteAsList<ShoppingOptionsInfo>("usp_ASPX_ShoppingOptions", ParaMeter);
            return Count;


        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------ShoppingOptionsByPriceResults----------------------------
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetShoppingOptionsItemsResult(string itemIds, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", itemIds));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetShoppingOptionsItemsResult", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Search
    //Auto Complete search Box
    [WebMethod]
    public List<SearchTermList> GetSearchedTermList(string search, int storeID, int portalID)
    {
        List<SearchTermList> srInfo = new List<SearchTermList>();

        List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
        paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        paramCol.Add(new KeyValuePair<string, object>("@Search", search));
        SQLHandler sageSQL = new SQLHandler();
        srInfo = sageSQL.ExecuteAsList<SearchTermList>("[dbo].[usp_ASPX_GetListSearched]", paramCol);
        return srInfo;
    }

    #region General Search
    //----------------General Search Sort By DropDown Options----------------------------
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetSimpleSearchResult(int categoryID, string searchText, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SearchText", searchText));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetSimpleSearchResult", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<SortOptionTypeInfo> BindItemsSortByList()
    {
        try
        {

            SQLHandler sqlH = new SQLHandler();
            List<SortOptionTypeInfo> Bind = sqlH.ExecuteAsList<SortOptionTypeInfo>("usp_ASPX_DisplayItemSortByOptions");
            return Bind;

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ItemBasicDetailsInfo> GetItemsByGeneralSearch(int storeID, int portalID, string NameSearchText, float PriceFrom, float PriceTo,
        string SKUSearchText, int CategoryID, string CategorySearchText, bool IsByName, bool IsByPrice, bool IsBySKU, bool IsByCategory, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@NameSearchText", NameSearchText));
            ParaMeter.Add(new KeyValuePair<string, object>("@PriceFrom", PriceFrom));
            ParaMeter.Add(new KeyValuePair<string, object>("@PriceTo", PriceTo));
            ParaMeter.Add(new KeyValuePair<string, object>("@SKUSearchText", SKUSearchText));
            ParaMeter.Add(new KeyValuePair<string, object>("@CategoryID", CategoryID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CategorySearchText", CategorySearchText));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsByName", IsByName));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsByPrice", IsByPrice));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsBySKU", IsBySKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsByCategory", IsByCategory));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetItemsByGeneralSearch", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CategoryInfo> GetAllCategoryForSearch(string prefix, bool isActive, string culture, int storeID, int portalID, string userName)
    {
        try
        {
            int itemID = 0;
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@Prefix", prefix));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", culture));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            SQLHandler sqLH = new SQLHandler();
            List<CategoryInfo> catList = sqLH.ExecuteAsList<CategoryInfo>("dbo.usp_ASPX_GetCategoryList", parameterCollection);
            return catList;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Advance Search
    [WebMethod]
    public List<ItemTypeInfo> GetItemTypeList()
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemTypeInfo>("usp_ASPX_GetItemTypeList");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributeFormInfo> GetAttributeByItemType(int itemTypeID, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@ItemTypeID", itemTypeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<AttributeFormInfo>("usp_ASPX_GetAttributeByItemType", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region More Advanced Search
    //------------------get dyanamic Attributes for serach-----------------------   
    [WebMethod]
    public List<AttributeShowInAdvanceSearchInfo> GetAttributes(int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<AttributeShowInAdvanceSearchInfo>("usp_ASPX_GetAttributesShowInAdvanceSearch", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------get items by dyanamic Advance serach-----------------------
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetItemsByDyanamicAdvanceSearch(int storeID, int portalID, System.Nullable<int> categoryID, string SearchText, string checkValue,
        System.Nullable<float> PriceFrom, System.Nullable<float> PriceTo, string userName, string cultureName, string attributeIDS)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SearchText", SearchText));
            ParaMeter.Add(new KeyValuePair<string, object>("@CheckValues", checkValue));
            ParaMeter.Add(new KeyValuePair<string, object>("@PriceFrom", PriceFrom));
            ParaMeter.Add(new KeyValuePair<string, object>("@PriceTo", PriceTo));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@AttributeIDs", attributeIDS));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_GetItemsByDynamicAdvanceSearch", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #endregion

    #region Category Details
    [WebMethod]
    public List<CategoryDetailsInfo> BindCategoryDetails(int storeID, int portalID, int categoryID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@CategoryID", categoryID));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CategoryDetailsInfo>("usp_ASPX_GetCategoryDetails", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CategoryDetailsOptionsInfo> GetCategoryDetailsOptions(string categorykey, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameterCollection.Add(new KeyValuePair<string, object>("@categorykey", categorykey));
            parameterCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            parameterCollection.Add(new KeyValuePair<string, object>("@Culture", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CategoryDetailsOptionsInfo>("usp_ASPX_CategoryDetailsOptions", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #endregion

    #region Rating/Reviews

    #region rating/ review
    //---------------------save rating/ review Items-----------------------
    [WebMethod]
    public List<ItemRatingAverageInfo> GetItemAverageRating(string itemSKU, int storeID, int portalID, string cultureName)
    {
        try
        {
            //ItemRatingAverageInfo
            SQLHandler sqlH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            List<ItemRatingAverageInfo> avgRating = sqlH.ExecuteAsList<ItemRatingAverageInfo>("usp_ASPX_ItemRatingGetAverage", ParaMeter);
            return avgRating;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------rating/ review Items criteria--------------------------
    [WebMethod]
    public List<RatingCriteriaInfo> GetItemRatingCriteria(int storeID, int portalID, string cultureName, bool isFlag)
    {
        try
        {
            SQLHandler sqlH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsFlag", isFlag));
            List<RatingCriteriaInfo> rating = sqlH.ExecuteAsList<RatingCriteriaInfo>("usp_ASPX_GetItemRatingCriteria", ParaMeter);
            return rating;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<RatingCriteriaInfo> GetItemRatingCriteriaByReviewID(int storeID, int portalID, string cultureName, int itemReviewID,bool isFlag)
    {
        try
        {
            SQLHandler sqlH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsFlag", isFlag));
            List<RatingCriteriaInfo> rating = sqlH.ExecuteAsList<RatingCriteriaInfo>("usp_ASPX_GetItemRatingCriteriaForPending", ParaMeter);
            return rating;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------save rating/ review Items-----------------------
    [WebMethod]
    public void SaveItemRating(string ratingCriteriaValue, int statusID, string summaryReview, string review, string userIP, string viewFromCountry, int itemID, int storeID, int portalID, string nickName, string addedBy)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@RatingCriteriaValue", ratingCriteriaValue));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusID", statusID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", 0));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReviewSummary", summaryReview));
            ParaMeter.Add(new KeyValuePair<string, object>("@Review", review));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewFromIP", userIP));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewFromCountry", viewFromCountry));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", nickName));
            ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", addedBy));
            sqLH.ExecuteNonQuery("usp_ASPX_SaveItemRating", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------update rating/ review Items-----------------------
    [WebMethod]
    public void UpdateItemRating(string ratingCriteriaValue, int statusID, string summaryReview, string review, int itemReviewID, string viewFromIP, string viewFromCountry, int itemID, int storeID, int portalID, string nickName, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@RatingCriteriaValue", ratingCriteriaValue));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusID", statusID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReviewSummary", summaryReview));
            ParaMeter.Add(new KeyValuePair<string, object>("@Review", review));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewFromIP", viewFromIP));
            ParaMeter.Add(new KeyValuePair<string, object>("@ViewFromCountry", viewFromCountry));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", nickName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserBy", userName));
            sqLH.ExecuteNonQuery("usp_ASPX_UpdateItemRating", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Get rating/ review of Item Per User ------------------
    [WebMethod]
    public List<ItemRatingByUserInfo> GetItemRatingPerUser(string itemSKU, int storeID, int portalID, string cultureName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return sqLH.ExecuteAsList<ItemRatingByUserInfo>("usp_ASPX_GetItemAverageRatingByUser", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Get rating/ review of Item Per User ------------------
    [WebMethod]
    public List<RatingLatestInfo> GetRecentItemReviewsAndRatings(int storeID, int portalID, string cultureName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return sqLH.ExecuteAsList<RatingLatestInfo>("usp_ASPX_GetRecentReviewsAndRatings", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Get rating/ review of Item Per User ------------------
    [WebMethod]
    public List<ItemReviewDetailsInfo> GetItemRatingByReviewID(int itemReviewID, int storeID, int portalID, string cultureName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return sqLH.ExecuteAsList<ItemReviewDetailsInfo>("usp_ASPX_GetItemReviewDetails", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------Item single rating management------------------------
    [WebMethod]
    public void DeleteSingleItemRating(string ItemReviewID, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", ItemReviewID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteSingleItemRatingInformation", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Delete multiple item rating informations--------------------------
    [WebMethod]
    public void DeleteMultipleItemRatings(string itemReviewIDs, int storeId, int portalId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewIDs", itemReviewIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteMultipleSelectionItemRating", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Bind in Item Rating Information in grid-------------------------
    [WebMethod]
    public List<UserRatingInformationInfo> GetAllUserReviewsAndRatings(int offset, int limit, int storeID, int portalID, string userName, string statusName, string itemName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusName", statusName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemName", itemName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            List<UserRatingInformationInfo> bind = sqLH.ExecuteAsList<UserRatingInformationInfo>("usp_ASPX_GetAllReviewsAndRatings", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------------list item names in dropdownlist/item rating management---------------------
    [WebMethod]
    public List<ItemsReviewInfo> GetAllItemList(int storeID, int portalID, string cultureName)
    {
        try
        {
            //ItemRatingAverageInfo
            SQLHandler sqlH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            List<ItemsReviewInfo> items = sqlH.ExecuteAsList<ItemsReviewInfo>("usp_ASPX_GetAllItemsListReview", ParaMeter);
            return items;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Item Rating Criteria Manage/Admin
    //--------------------Item Rating Criteria Manage/Admin--------------------------
    [WebMethod]
    public List<ItemRatingCriteriaInfo> ItemRatingCriteriaManage(int offset, int limit, string ratingCriteria, System.Nullable<bool> isActive, int storeId, int portalId, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@RatingCriteria", ratingCriteria));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ItemRatingCriteriaInfo>("usp_ASPX_GetAllItemRatingCriteria", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- ItemRating Criteria Manage-------------------------------
    [WebMethod]
    public void AddUpdateItemCriteria(int ID, string criteria, string IsActive, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Criteria", criteria));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_AddUpdateItemRatingCriteria", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- ItemRating Criteria Manage-------------------------------
    [WebMethod]
    public void DeleteItemRatingCriteria(string IDs, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CriteriaID", IDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteItemRatingCriteria", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion
    #endregion

    #region Cost Variants Management
    //--------------------bind Cost Variants in Grid--------------------------
    [WebMethod]
    public List<CostVariantInfo> GetCostVariants(int offset, int limit, string variantName, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@VariantName", variantName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            List<CostVariantInfo> bind = sqLH.ExecuteAsList<CostVariantInfo>("usp_ASPX_BindCostVariantsInGrid", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Delete multiple cost variants --------------------------
    [WebMethod]
    public void DeleteMultipleCostVariants(string costVariantIDs, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantIds", costVariantIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteMultipleCostVariants", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------ single Cost Variants management------------------------
    [WebMethod]
    public void DeleteSingleCostVariant(string CostVariantID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantID", CostVariantID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteSingleCostVariants", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AttributesInputTypeInfo> GetCostVariantInputTypeList()
    {
        try
        {
            List<AttributesInputTypeInfo> ml = new List<AttributesInputTypeInfo>();
            SQLHandler Sq = new SQLHandler();
            ml = Sq.ExecuteAsList<AttributesInputTypeInfo>("dbo.usp_ASPX_CostVariantsInputTypeGetAll");
            return ml;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- bind (edit) cost Variant management--------------------
    [WebMethod]
    public List<CostVariantsGetByCostVariantIDInfo> GetCostVariantInfoByCostVariantID(int costVariantID, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<CostVariantsGetByCostVariantIDInfo> bind = new List<CostVariantsGetByCostVariantIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return Sq.ExecuteAsList<CostVariantsGetByCostVariantIDInfo>("usp_ASPX_CostVariantsGetByCostVariantID", ParaMeterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------- bind (edit) cost Variant values for cost variant ID --------------------
    [WebMethod]
    public List<CostVariantsvalueInfo> GetCostVariantValuesByCostVariantID(int costVariantID, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<CostVariantsGetByCostVariantIDInfo> bind = new List<CostVariantsGetByCostVariantIDInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            return Sq.ExecuteAsList<CostVariantsvalueInfo>("usp_ASPX_GetCostVariantValuesByCostVariantID", ParaMeterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------Save and update Costvariant options-------------------------
    [WebMethod]
    public void SaveAndUpdateCostVariant(int costVariantID, string costVariantName, string description, string cultureName, int inputTypeID,
        int displayOrder, bool showInGrid, bool showInSearch, bool showInAdvanceSearch, bool showInComparison, bool isEnableSorting, bool isUseInFilter,
        bool isIncludeInPriceRule, bool isIncludeInPromotions, bool isShownInRating, int storeId, int portalId,
        bool isActive, bool isModified, string userName, string variantOptions, bool isNewflag)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantName", costVariantName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Description", description));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@InputTypeID", inputTypeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInGrid", showInGrid));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInSearch", showInSearch));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInAdvanceSearch", showInAdvanceSearch));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInComparison", showInComparison));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsEnableSorting", isEnableSorting));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsUseInFilter", isUseInFilter));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPriceRule", isIncludeInPriceRule));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsIncludeInPromotions", isIncludeInPromotions));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsShownInRating", isShownInRating));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsModified", isModified));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@VariantOption", variantOptions));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsNewFlag", isNewflag));
            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("usp_ASPX_SaveAndUpdateCostVariants", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    //---------------- Added for unique name check ---------------------
    [WebMethod]
    public bool CheckUniqueCostVariantName(string costVariantName, int costVariantId, int storeId, int portalId)
    {
        try
        {
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantName", costVariantName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CostVariantID", costVariantId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            return Sq.ExecuteNonQueryAsBool("usp_ASPX_CostVariantUniquenessCheck", ParaMeterCollection, "@IsUnique");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Refer-A-Friend
    //-------------------------Save AND SendEmail Messages For Refer-A-Friend----------------
    [WebMethod]
    public void SaveAndSendEmailMessage(int storeID, int portalID, int itemID, string senderName, string senderEmail, string receiverName, string receiverEmail, string subject, string message, string messageBodyHtml)
    {
        try
        {
            ReferToFriendSqlHandler obj = new ReferToFriendSqlHandler();
            obj.SaveEmailMessage(storeID, portalID, itemID, senderName, senderEmail, receiverName, receiverEmail, subject, message);
            obj.SendEmail(senderEmail, receiverEmail, subject, messageBodyHtml);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------bind Email list in Grid--------------------------
    [WebMethod]
    public List<ReferToFriendInfo> GetAllReferToAFriendEmailList(int offset, int limit, string senderName, string senderEmail, string receiverName, string receiverEmail, string subject, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderName", senderName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderEmail", senderEmail));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReceiverName", receiverName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReceiverEmail", receiverEmail));
            ParaMeter.Add(new KeyValuePair<string, object>("@Subject", subject));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            List<ReferToFriendInfo> bind = sqLH.ExecuteAsList<ReferToFriendInfo>("usp_ASPX_GetAllReferAFriendEmailsInGrid", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------Delete Email list --------------------------------
    [WebMethod]
    public void DeleteReferToFriendEmailUser(string emailAFriendIDs, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@EmailAFriendID", emailAFriendIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteReferToFriendUser", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Get UserReferred Friends--------------------------
    [WebMethod]
    public List<ReferToFriendInfo> GetUserReferredFriends(int offset, int limit, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<ReferToFriendInfo>("usp_ASPX_GetUserReferredFriends", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Shipping method management
    //-----------Bind Shipping methods In grid-----------------------------
    [WebMethod]
    public List<ShippingMethodInfo> GetShippingMethodList(int offset, int limit, string shippingMethodName, string deliveryTime, System.Nullable<Decimal> weightLimitFrom, System.Nullable<Decimal> weightLimitTo, System.Nullable<bool> isActive, int storeID, int portalID, string cultureName)
    {
        try
        {
            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            return obj.GetShippingMethods(offset, limit, shippingMethodName, deliveryTime, weightLimitFrom, weightLimitTo, isActive, storeID, portalID, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------delete multiple shipping methods----------------------
    [WebMethod]
    public void DeleteShippingByShippingMethodID(string shippingMethodIds, int storeId, int portalId, string userName)
    {
        try
        {
            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            obj.DeleteShippings(shippingMethodIds, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //----------------bind shipping service list---------------
    [WebMethod]
    public List<ShippingProviderListInfo> GetShippingProviderList(int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler Sq = new SQLHandler();
            return Sq.ExecuteAsList<ShippingProviderListInfo>("usp_ASPX_BindShippingProvider", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------------SaveAndUpdate shipping methods-------------------
    [WebMethod]
    public void SaveAndUpdateShippingMethods(int shippingMethodID, string shippingMethodName, string prevFilePath, string newFilePath, string alternateText, int displayOrder, string deliveryTime,
            decimal weightLimitFrom, decimal weightLimitTo, int shippingProviderID, int storeID, int portalID, bool isActive, string userName, string cultureName)
    {
        try
        {
            FileHelperController fileObj = new FileHelperController();
            string uplodedValue = string.Empty;
            if (newFilePath != null && prevFilePath != newFilePath)
            {
                string tempFolder = @"Upload\temp";
                uplodedValue = fileObj.MoveFileToSpecificFolder(tempFolder, prevFilePath, newFilePath, @"Modules\ASPXCommerce\ASPXShippingManagement\uploads\", shippingMethodID, "ship_");
            }
            else
            {
                uplodedValue = prevFilePath;
            }
            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            obj.SaveAndUpdateShippings(shippingMethodID, shippingMethodName, uplodedValue, alternateText, displayOrder, deliveryTime, weightLimitFrom, weightLimitTo, shippingProviderID, storeID, portalID, isActive, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------bind Cost dependencies  in Grid--------------------------
    [WebMethod]
    public List<ShippingCostDependencyInfo> GetCostDependenciesListInfo(int offset, int limit, int storeID, int portalID, int shippingMethodId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodId));
            SQLHandler sqLH = new SQLHandler();
            List<ShippingCostDependencyInfo> bind = sqLH.ExecuteAsList<ShippingCostDependencyInfo>("usp_ASPX_BindShippingCostDependencies", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------bind Weight dependencies  in Grid--------------------------
    [WebMethod]
    public List<ShippingWeightDependenciesInfo> GetWeightDependenciesListInfo(int offset, int limit, int storeID, int portalID, int shippingMethodId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodId));
            SQLHandler sqLH = new SQLHandler();
            List<ShippingWeightDependenciesInfo> bind = sqLH.ExecuteAsList<ShippingWeightDependenciesInfo>("usp_ASPx_BindWeightDependencies", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------bind Item dependencies  in Grid--------------------------
    [WebMethod]
    public List<ShippingItemDependenciesInfo> GetItemDependenciesListInfo(int offset, int limit, int storeID, int portalID, int shippingMethodId)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", shippingMethodId));
            SQLHandler sqLH = new SQLHandler();
            List<ShippingItemDependenciesInfo> bind = sqLH.ExecuteAsList<ShippingItemDependenciesInfo>("usp_ASPX_bindItemDependencies", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Delete multiple cost Depandencies --------------------------
    [WebMethod]
    public void DeleteCostDependencies(string shippingProductCostIds, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingProductCostIDs", shippingProductCostIds));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteCostDependencies", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Delete multiple weight Depandencies --------------------------
    [WebMethod]
    public void DeleteWeightDependencies(string shippingProductWeightIds, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingProductWeightIDs", shippingProductWeightIds));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteShippingWeightDependencies", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------Delete multiple item Depandencies --------------------------
    [WebMethod]
    public void DeleteItemDependencies(string shippingItemIds, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ShippingItemIDs", shippingItemIds));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteShippingItemDependencies", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------save  cost dependencies----------------
    [WebMethod]
    public void SaveCostDependencies(int shippingProductCostID, int shippingMethodID, string costDependenciesOptions, int storeID, int portalID, string userName)
    {
        try
        {

            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            obj.AddCostDependencies(shippingProductCostID, shippingMethodID, costDependenciesOptions, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------- save weight dependencies-------------------------------
    [WebMethod]
    public void SaveWeightDependencies(int shippingProductWeightID, int shippingMethodID, string weightDependenciesOptions, int storeID, int portalID, string userName)
    {
        try
        {
            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            obj.AddWeightDependencies(shippingProductWeightID, shippingMethodID, weightDependenciesOptions, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------- save item dependencies-------------------------------
    [WebMethod]
    public void SaveItemDependencies(int shippingItemID, int shippingMethodID, string itemDependenciesOptions, int storeID, int portalID, string userName)
    {
        try
        {
            ShippingMethodSqlProvider obj = new ShippingMethodSqlProvider();
            obj.AddItemDependencies(shippingItemID, shippingMethodID, itemDependenciesOptions, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Shipping Service Providers management
    [WebMethod]
    public List<ShippingProviderNameListInfo> GetShippingProviderNameList(int offset, int limit, int StoreID, int PortalID, string CultureName, string UserName, string ShippingProviderName, System.Nullable<bool> IsActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            parameter.Add(new KeyValuePair<string, object>("@ShippingProviderName", ShippingProviderName));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShippingProviderNameListInfo>("[dbo].[usp_ASPX_GetShippingProviderNameList]", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ShippingProviderNameListInfo> ShippingProviderAddUpdate(Int32 ShippingProviderID, int StoreID, int PortalID, string UserName, string CultureName, string ShippingProviderServiceCode, string ShippingProviderName, string ShippingProviderAliasHelp, bool IsActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();

            parameter.Add(new KeyValuePair<string, object>("@ShippingProviderID", ShippingProviderID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", UserName));

            parameter.Add(new KeyValuePair<string, object>("@ShippingProviderServiceCode", ShippingProviderServiceCode));
            parameter.Add(new KeyValuePair<string, object>("@ShippingProviderName", ShippingProviderName));
            parameter.Add(new KeyValuePair<string, object>("@ShippingProviderAliasHelp", ShippingProviderAliasHelp));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));

            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShippingProviderNameListInfo>("[dbo].[usp_ASPX_ShippingProviderAddUpdate]", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteShippingProviderByID(int ShippingProviderID, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShippingProviderID", ShippingProviderID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteShippingProviderByID]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    [WebMethod]
    public void DeleteShippingProviderMultipleSelected(string ShippingProviderIDs, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShippingProviderIDs", ShippingProviderIDs));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteShippingProviderMultipleSelected]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    #endregion

    #region Coupon Management

    #region Coupon Type Manage
    [WebMethod]
    public List<CouponTypeInfo> GetCouponTypeDetails(int offset, int limit, string couponTypeName, int storeId, int portalId, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponTypeName", couponTypeName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponTypeInfo>("usp_ASPX_GetAllCouponType", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdateCouponType(int couponTypeID, string couponType, string isActive, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponTypeID", couponTypeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponType", couponType));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_AddUpdateCouponType", ParaMeter);
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteCouponType(string IDs, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponTypeID", IDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteCouponType", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Coupon Manage
    [WebMethod]
    public List<CouponInfo> GetCouponDetails(int offset, int limit, System.Nullable<int> couponTypeID, string couponCode, System.Nullable<DateTime> validateFrom, System.Nullable<DateTime> validateTo, int storeId, int portalId, string cultureName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            return cmSQLProvider.BindAllCouponDetails(offset, limit, couponTypeID, couponCode, validateFrom, validateTo, storeId, portalId, cultureName);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdateCouponDetails(int couponID, int couponTypeID, string couponCode, string couponAmount, string validateFrom, string validateTo,
        string isActive, int storeID, int portalID, string cultureName, string userName, string settingIDs, string settingValues,
        string PortalUser_CustomerName, string PortalUser_EmailID, string PortalUser_UserName, string SenderEmail, string Subject, ArrayList MessageBody)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            if (PortalUser_EmailID != "")
            {
                cmSQLProvider.SendCouponCodeEmail(SenderEmail, PortalUser_EmailID, Subject, MessageBody);
            }
            cmSQLProvider.AddUpdateCoupons(couponID, couponTypeID, couponCode, couponAmount, validateFrom, validateTo, isActive, storeID, portalID, cultureName, userName, settingIDs, settingValues, PortalUser_UserName);        
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CouponStatusInfo> GetCouponStatus()
    {
        try
        {
            CouponManageSQLProvider cmSqlProvider = new CouponManageSQLProvider();
            return cmSqlProvider.BindCouponStatus();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CouponSettingKeyValueInfo> GetSettinKeyValueByCouponID(int couponID, int storeID, int portalID)
    {
        try
        {
            CouponManageSQLProvider cmSqlProvider = new CouponManageSQLProvider();
            return cmSqlProvider.GetCouponSettingKeyValueInfo(couponID, storeID, portalID);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CouponPortalUserListInfo> GetPortalUsersByCouponID(int offset, int limit, int couponID, int storeID, int portalID, string customerName, string cultureName)
    {
        try
        {
            CouponManageSQLProvider cmSqlProvider = new CouponManageSQLProvider();
            return cmSqlProvider.GetPortalUsersList(offset, limit, couponID, storeID, portalID, customerName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //----------------delete coupons(admin)-----------
    [WebMethod]
    public void DeleteCoupons(string couponIDs, int storeID, int portalID, string userName)
    {
        try
        {
            CouponManageSQLProvider cmSqlProvider = new CouponManageSQLProvider();
            cmSqlProvider.DeleteCoupons(couponIDs, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------Verify Coupon Code-----------------------------
    [WebMethod]
    public CouponVerificationInfo VerifyCouponCode(decimal totalCost, string couponCode, int storeID, int portalID, string userName, int appliedCount)
    {
        try
        {
            CouponManageSQLProvider cmSqlProvider = new CouponManageSQLProvider();
            CouponVerificationInfo info = cmSqlProvider.VerifyUserCoupon(totalCost, couponCode, storeID, portalID, userName, appliedCount);
            return info;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------update wherever necessary after coupon verification is successful----------
    [WebMethod]
    public void UpdateCouponUserRecord(string CouponCode, int storeID, int portalID, string userName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            cmSQLProvider.UpdateCouponUserRecord(CouponCode, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Coupons Per Sales Management
    [WebMethod]
    public List<CouponPerSales> GetCouponDetailsPerSales(int offset, int limit, string couponCode, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));

            return sqLH.ExecuteAsList<CouponPerSales>("usp_ASPX_GetCouponListPerSales", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Coupon User Management
    [WebMethod]
    public List<CouponUserInfo> GetCouponUserDetails(int offset, int limit, string couponCode, string userName, System.Nullable<int> couponStatusId, System.Nullable<DateTime> validFrom, System.Nullable<DateTime> validTo, int storeId, int portalId, string cultureName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            return cmSQLProvider.GetCouponUserDetails(offset, limit, couponCode, userName, couponStatusId, validFrom, validTo, storeId, portalId, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CouponUserListInfo> GetCouponUserList(int offset, int limit, int CouponID, string CouponCode, string UserName, System.Nullable<int> CouponStatusID, int StoreID, int PortalID, string CultureName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            return cmSQLProvider.GetCouponUserList(offset, limit, CouponID, CouponCode, UserName, CouponStatusID, StoreID, PortalID, CultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    [WebMethod]
    public void DeleteCouponUser(string couponUserID, int storeID, int portalID, string userName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            cmSQLProvider.DeleteCouponUser(couponUserID, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    [WebMethod]
    public void UpdateCouponUser(int couponUserID, int couponStatusID, int storeID, int portalID, string cultureName)
    {
        try
        {
            CouponManageSQLProvider cmSQLProvider = new CouponManageSQLProvider();
            cmSQLProvider.UpdateCouponUser(couponUserID, couponStatusID, storeID, portalID, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Coupon Setting Manage/Admin
    [WebMethod]
    public void DeleteCouponSettingsKey(string SettingID, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@SettingIDs", SettingID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteCouponSettingsKey", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CouponSettingKeyInfo> CouponSettingManageKey()
    {
        try
        {

            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponSettingKeyInfo>("usp_ASPX_GetAllCouponSettingsKey");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdateCouponSettingKey(int ID, string settingKey, int validationTypeID, string isActive, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ID", ID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SettingKey", settingKey));
            ParaMeter.Add(new KeyValuePair<string, object>("@ValidationTypeID", validationTypeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_AddUpdateCouponSettingKey", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Front Coupon Show
    [WebMethod]
    public List<CouponDetailFrontInfo> GetCouponDetailListFront(int Count, int StoreID, int PortalID, string UserName, string CultureName, int CustomerID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", Count));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", CustomerID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponDetailFrontInfo>("usp_ASPX_GetCouponDetailsForFront", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #endregion

    #region Admin DashBoard
    [WebMethod]
    public List<SearchTermInfo> GetSearchStatistics(int count, string commandName, int storeID, int portalID, string cultureName)
    {
        SearchTermSQLProvider stSQLprovider = new SearchTermSQLProvider();
        return stSQLprovider.GetSearchStatistics(count, commandName, storeID, portalID, cultureName);
    }

    [WebMethod]
    public List<LatestOrderStaticsInfo> GetLatestOrderItems(int count, int storeID, int portalID, string cultureName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsList<LatestOrderStaticsInfo>("usp_ASPX_GetLatestOrderStatics", ParaMeter);
    }

    [WebMethod]
    public List<MostViewItemInfoAdminDash> GetMostViwedItemAdmindash(int count, int storeID, int portalID)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        //ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsList<MostViewItemInfoAdminDash>("usp_ASPX_GetMostViewdItemAdminDashboard", ParaMeter);
    }

    [WebMethod]
    public List<StaticOrderStatusAdminDashInfo> GetStaticOrderStatusAdminDash(int count, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            //ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<StaticOrderStatusAdminDashInfo>("usp_ASPX_GetStaticOrderStatusAdminDash", ParaMeter);

        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<TopCustomerOrdererInfo> GetTopCustomerOrderAdmindash(int count, int storeID, int portalID)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        //ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsList<TopCustomerOrdererInfo>("usp_ASPX_GetTopCustomerAdmindash", ParaMeter);
    }

    [WebMethod]
    public List<TotalOrderAmountInfo> GetTotalOrderAmountAdmindash(int storeID, int portalID)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        //  ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        //ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsList<TotalOrderAmountInfo>("usp_ASPX_GetTotalOrderAmountStatus", ParaMeter);
    }

    [WebMethod]
    public List<InventoryDetailAdminDashInfo> GetInventoryDetails(int count, int storeID, int portalID)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@LowStockCount", count));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsList<InventoryDetailAdminDashInfo>("usp_ASPX_GetInventoryDetailsAdminDash", ParaMeter);
    }
    #endregion

    #region For User DashBoard

    #region Shared Wishlists
    //--------------------bind ShareWishList Email  in Grid--------------------------
    [WebMethod]
    public List<ShareWishListItemInfo> GetAllShareWishListItemMail(int offset, int limit, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShareWishListItemInfo>("[dbo].[usp_ASPX_GetShareWishListMailDetailGrid]", ParaMeter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ShareWishListItemInfo> GetShareWishListItemByID(int SharedWishID, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@SharedWishID", SharedWishID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShareWishListItemInfo>("[dbo].[usp_ASPX_GetShareWishListByID]", ParaMeter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------Delete ShareWishList --------------------------------
    [WebMethod]
    public void DeleteShareWishListItem(string ShareWishListID, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ShareWishIDs", ShareWishListID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("[usp_ASPX_DeleteShareWishList]", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    //-------------------------Update Customer Account Information----------------------------------------  
    [WebMethod]
    public int UpdateCustomer(int storeID, int portalID, int customerID, string userName, string firstName, string lastName, string email)
    {

        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@FirstName", firstName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@LastName", lastName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Email", email));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            SQLHandler sqlh = new SQLHandler();
            int errorCode = sqlh.ExecuteNonQueryAsGivenType<int>("dbo.usp_ASPX_UpdateCustomer", ParaMeterCollection, "@ErrorCode");
            return errorCode;
        }
        catch (Exception)
        {
            throw;
        }
    }
    [WebMethod]
    public bool ChangePassword(int portalID, int storeID, string userName, string newPassword, string retypePassword)
    {
        MembershipController m = new MembershipController();
        try
        {
            if (newPassword != "" && retypePassword != "" && newPassword == retypePassword && userName != "")
            {
                UserInfo sageUser = m.GetUserDetails(portalID, userName);

                MembershipUser member = Membership.GetUser(userName);
               // Guid userID = (Guid)member.ProviderUserKey;
                string Password, PasswordSalt;
                PasswordHelper.EnforcePasswordSecurity(m.PasswordFormat, newPassword, out Password, out PasswordSalt);
                UserInfo user = new UserInfo(sageUser.UserID, Password, PasswordSalt, m.PasswordFormat);
                m.ChangePassword(user);
                return true;
            }
            else
            {
                return false;
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    //---------------User Item Reviews and Ratings-----------------------
    [WebMethod]
    public List<UserRatingInformationInfo> GetUserReviewsAndRatings(int offset, int limit, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            List<UserRatingInformationInfo> bind = sqLH.ExecuteAsList<UserRatingInformationInfo>("usp_ASPX_GetUserItemReviews", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------update rating/ review Items From User DashBoard-----------------------
    [WebMethod]
    public void UpdateItemRatingByUser(string summaryReview, string review, int itemReviewID, int itemID, int storeID, int portalID, string nickName, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ReviewSummary", summaryReview));
            ParaMeter.Add(new KeyValuePair<string, object>("@Review", review));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemReviewID", itemReviewID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Username", nickName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserBy", userName));
            sqLH.ExecuteNonQuery("usp_ASPX_UpdateItemRatingByUser", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------User DashBoard/Recent History-------------------
    [WebMethod]
    public List<UserRecentHistoryInfo> GetUserRecentlyViewedItems(int offset, int limit, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<UserRecentHistoryInfo>("usp_ASPX_GetUserRecentlyViewedItems", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------User DashBoard/Recent History-------------------
    [WebMethod]
    public List<UserRecentHistoryInfo> GetUserRecentlyComparedItems(int offset, int limit, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<UserRecentHistoryInfo>("usp_ASPX_GetUserRecentlyComparedItems", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdateUserAddress(int addressID, int customerID, string firstName, string lastName, string email, string company,
        string address1, string address2, string city, string state, string zip, string phone, string mobile,
        string fax, string webSite, string countryName, bool isDefaultShipping, bool isDefaultBilling, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            UserDashboardSQLProvider udsqlProvider = new UserDashboardSQLProvider();
            udsqlProvider.AddUpdateUserAddress(addressID, customerID, firstName, lastName, email, company, address1, address2, city,
                state, zip, phone, mobile, fax, webSite, countryName, isDefaultShipping, isDefaultBilling, storeID, portalID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<AddressInfo> GetAddressBookDetails(int storeID, int portalID, int customerID, string userName, string cultureName)
    {
        try
        {
            UserDashboardSQLProvider sqlProvider = new UserDashboardSQLProvider();
            return sqlProvider.GetUserAddressDetails(storeID, portalID, customerID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteAddressBook(int addressID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            UserDashboardSQLProvider DashBoardSqlProvider = new UserDashboardSQLProvider();
            DashBoardSqlProvider.DeleteAddressBookDetails(addressID, storeID, portalID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<UserProductReviewInfo> GetUserProductReviews(int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            UserDashboardSQLProvider DashBoardSqlProvider = new UserDashboardSQLProvider();
            return DashBoardSqlProvider.GetUserProductReviews(storeID, portalID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateUserProductReview(int itemID, int itemReviewID, string ratingIDs, string ratingValues, string reviewSummary, string review, int storeID, int portalID, string userName)
    {
        try
        {
            UserDashboardSQLProvider DashBoardSqlProvider = new UserDashboardSQLProvider();
            DashBoardSqlProvider.UpdateUserProductReview(itemID, itemReviewID, ratingIDs, ratingValues, reviewSummary, review, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteUserProductReview(int itemID, int itemReviewID, int storeID, int portalID, string userName)
    {
        UserDashboardSQLProvider dashSqlProvider = new UserDashboardSQLProvider();
        dashSqlProvider.DeleteUserProductReview(itemID, itemReviewID, storeID, portalID, userName);
    }

    //---------------userDashBord/My Order List in grid----------------------------
    [WebMethod]
    public List<MyOrderListInfo> GetMyOrderList(int offset, int limit, int StoreID, int PortalID, int CustomerID, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CustomerID", CustomerID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<MyOrderListInfo>("usp_ASPX_GetMyOrdersList", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------------UserDashBoard/ My Orders-------------------
    [WebMethod]
    public List<OrderItemsInfo> GetMyOrders(int orderID, int storeID, int portalID, int customerID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlh = new SQLHandler();
            List<OrderItemsInfo> info;
            info = sqlh.ExecuteAsList<OrderItemsInfo>("usp_ASPX_GetMyOrders", ParaMeter);
            return info;
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------------UserDashBoard/User Downloadable Items------------------------------
    [WebMethod]
    public List<DownloadableItemsByCustomerInfo> GetCustomerDownloadableItems(int offset, int limit, string Sku, string name, int storeId, int portalId, string cultureName, string userName)
    {
        try
        {
            List<DownloadableItemsByCustomerInfo> ml = new List<DownloadableItemsByCustomerInfo>();
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@SKU", Sku));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Name", name));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            ml = Sq.ExecuteAsList<DownloadableItemsByCustomerInfo>("dbo.usp_ASPX_GetCustomerDownloadableItems", ParaMeterCollection);
            return ml;
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteCustomerDownloadableItem(string orderItemID, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();

            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@OrderItemID", orderItemID));
            parameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));

            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteCustomerDownloadableItem", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateDownloadCount(int itemID, int orderItemID, string DownloadIP, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@OrderItemID", orderItemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@DownloadIP", DownloadIP));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_UpdateDownloadCount", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckRemainingDownload(int itemId, int orderItemId, int storeId, int portalId, string userName)
    {
        try
        {
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();

            ParaMeterCollection.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@OrderItemID", orderItemId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
            return Sq.ExecuteNonQueryAsBool("dbo.usp_ASPX_CheckRemainingDownloadForCustomer", ParaMeterCollection, "@IsRemainDowload");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region CartManage
    //------------------------------Check Cart--------------------------
    [WebMethod]
    public bool CheckCart(int itemID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            CartManageSQLProvider cartSqlProvider = new CartManageSQLProvider();
            return cartSqlProvider.CheckCart(itemID, storeID, portalID, userName, cultureName);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------------Add to Cart--------------------------
    [WebMethod]
    public bool AddtoCart(int itemID, int storeID, int portalID, string userName, string cultureName)
    {

        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsGivenType<bool>("usp_ASPX_CheckCostVariantForItem", ParaMeter, "@IsExist");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------------Cart Details--------------------------
    [WebMethod]
    public List<CartInfo> GetCartDetails(int storeID, int portalID, int customerID, string userName, string cultureName, string sessionCode)
    {
        try
        {
            CartManageSQLProvider crtManSQLProvider = new CartManageSQLProvider();
            return crtManSQLProvider.GetCartDetails(storeID, portalID, customerID, userName, cultureName, sessionCode);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //Cart Item Qty Discount Calculations
    [WebMethod]
    public decimal GetDiscountQuantityAmount(int storeID, int portalID, string userName, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteNonQueryAsGivenType<decimal>("usp_ASPX_GetItemQuantityDiscountAmount", ParaMeter, "@QtyDiscount");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------------Delete Cart Items--------------------------
    [WebMethod]
    public void DeleteCartItem(int cartID, int cartItemID, int customerID, string sessionCode, int storeID, int portalID, string userName)
    {
        try
        {
            CartManageSQLProvider crtManSQLProvider = new CartManageSQLProvider();
            crtManSQLProvider.DeleteCartItem(cartID, cartItemID, customerID, sessionCode, storeID, portalID, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------Clear My Carts----------------------------
    [WebMethod]
    public void ClearAllCartItems(int cartID, int customerID, string sessionCode, int storeID, int portalID)
    {
        CartManageSQLProvider crtManSQLProvider = new CartManageSQLProvider();
        crtManSQLProvider.ClearAllCartItems(cartID, customerID, sessionCode, storeID, portalID);
    }

    [WebMethod]
    public decimal CheckItemQuantityInCart(int itemID, int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsScalar<decimal>("usp_ASPX_CheckCustomerQuantityInCart", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckCustomerCartExist(int customerID, int storeID, int portalID)
    {

        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteNonQueryAsGivenType<bool>("usp_ASPX_CheckCartExists", ParaMeter, "@IsCartExist");

    }

    //------------------------------Get ShippingMethodByTotalItemsWeight--------------------------
    [WebMethod]
    public List<ShippingMethodInfo> GetShippingMethodByWeight(int storeID, int portalID, int customerID, string userName, string cultureName, string sessionCode)
    {
        try
        {
            CartManageSQLProvider cmSQLProvider = new CartManageSQLProvider();
            return cmSQLProvider.GetShippingMethodByWeight(storeID, portalID, customerID, userName, cultureName, sessionCode);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ShippingCostInfo> GetShippingCostByItem(int storeID, int portalID, int customerID, string sessionCode, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ShippingCostInfo>("usp_ASPX_ShippingDetailsForItem", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateShoppingCart(int cartID, string quantitys, int storeID, int portalID, string cartItemIDs,string userName,string cultureName)
    {
        try
        {
            CartManageSQLProvider crtManSQLProvider = new CartManageSQLProvider();
            crtManSQLProvider.UpdateShoppingCart(cartID, quantitys, storeID, portalID, cartItemIDs, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool UpdateCartAnonymoususertoRegistered(int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteNonQueryAsBool("usp_ASPX_UpdateCartAnonymoususertoRegistered", ParaMeter, "@IsUpdate");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Quantity Discount Management
    [WebMethod]
    public List<ItemQuantityDiscountInfo> GetItemQuantityDiscountsByItemID(int itemId, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemId));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            return sqLH.ExecuteAsList<ItemQuantityDiscountInfo>("usp_ASPX_GetQuantityDiscountByItemID", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------save quantity discount------------------
    [WebMethod]
    public void SaveItemDiscountQuantity(string discountQuantity, int itemID, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@DiscountQuantity", discountQuantity));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            sqLH.ExecuteNonQuery("usp_ASPX_SaveItemQuantityDiscounts", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------delete quantity discount------------------
    [WebMethod]
    public void DeleteItemQuantityDiscount(int quantityDiscountID, int itemID, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@QuantityDiscountID", quantityDiscountID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteItemQuantityDiscounts", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------quantity discount shown in Item deatils ------------------
    [WebMethod]
    public List<ItemQuantityDiscountInfo> GetItemQuantityDiscountByUserName(int storeID, int portalID, string userName, string itemSKU)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
            return sqLH.ExecuteAsList<ItemQuantityDiscountInfo>("usp_ASPX_GetItemQuantityDiscountByUserName", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Search Term Management
    [WebMethod]
    public void AddUpdateSearchTerm(string searchTerm, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            SearchTermSQLProvider stSQLprovider = new SearchTermSQLProvider();
            stSQLprovider.AddUpdateSearchTerm(searchTerm, storeID, portalID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<SearchTermInfo> ManageSearchTerms(int offset, int limit, int storeID, int portalID, string cultureName, string searchTerm)
    {
        try
        {
            SearchTermSQLProvider stSQLprovider = new SearchTermSQLProvider();
            return stSQLprovider.ManageSearchTerm(offset, limit, storeID, portalID, cultureName, searchTerm);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteSearchTerm(string searchTermID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            SearchTermSQLProvider stSQLprovider = new SearchTermSQLProvider();
            stSQLprovider.DeleteSearchTerm(searchTermID, storeID, portalID, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Tax management
    //--------------item tax classes------------------
    [WebMethod]
    public List<TaxItemClassInfo> GetTaxItemClassDetails(int offset, int limit, string itemClassName, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@ItemClassName", itemClassName));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<TaxItemClassInfo>("usp_ASPX_GetItemTaxClasses", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------save item tax class--------------------
    [WebMethod]
    public void SaveAndUpdateTaxItemClass(int taxItemClassID, string taxItemClassName, string cultureName, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@TaxItemClassID", taxItemClassID));
            paraMeter.Add(new KeyValuePair<string, object>("@TaxItemClassName", taxItemClassName));
            paraMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlh = new SQLHandler();
            sqlh.ExecuteNonQuery("usp_ASPX_SaveAndUpdateTaxItemClass", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------Delete tax item classes --------------------------------
    [WebMethod]
    public void DeleteTaxItemClass(string taxItemClassIDs, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@TaxItemClassIDs", taxItemClassIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteTaxItemClass", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------customer tax classes------------------
    [WebMethod]
    public List<TaxCustomerClassInfo> GetTaxCustomerClassDetails(int offset, int limit, string className, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@ClassName", className));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<TaxCustomerClassInfo>("usp_ASPX_GetTaxCustomerClass", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------save customer tax class--------------------
    [WebMethod]
    public void SaveAndUpdateTaxCustmerClass(int taxCustomerClassID, string taxCustomerClassName, string cultureName, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@TaxCustomerClassID", taxCustomerClassID));
            paraMeter.Add(new KeyValuePair<string, object>("@TaxCustomerClassName", taxCustomerClassName));
            paraMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlh = new SQLHandler();
            sqlh.ExecuteNonQuery("usp_ASPX_SaveAndUpdateTaxCustomerClass", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------Delete tax customer classes --------------------------------
    [WebMethod]
    public void DeleteTaxCustomerClass(string taxCustomerClassIDs, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@TaxCustomerClassIDs", taxCustomerClassIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteTaxCustomerClass", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------tax rates------------------
    [WebMethod]
    public List<TaxRateInfo> GetTaxRateDetails(int offset, int limit, string taxName, string searchCountry, string searchState, string zip, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@TaxName", taxName));
            paraMeter.Add(new KeyValuePair<string, object>("@SearchCountry", searchCountry));
            paraMeter.Add(new KeyValuePair<string, object>("@SerachState", searchState));
            paraMeter.Add(new KeyValuePair<string, object>("@Zip", zip));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<TaxRateInfo>("usp_ASPX_GetTaxRates", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //----------------- save and update tax rates--------------------------
    [WebMethod]
    public void SaveAndUpdateTaxRates(int taxRateID, string taxRateTitle, string taxCountryCode, string taxStateCode, string taxZipCode, bool isTaxZipRange, decimal taxRateValue, bool rateType, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> Parameter = new List<KeyValuePair<string, object>>();
            Parameter.Add(new KeyValuePair<string, object>("@TaxRateID", taxRateID));
            Parameter.Add(new KeyValuePair<string, object>("@TaxRateTitle", taxRateTitle));
            Parameter.Add(new KeyValuePair<string, object>("@TaxCountryCode", taxCountryCode));
            Parameter.Add(new KeyValuePair<string, object>("@TaxStateCode", taxStateCode));
            Parameter.Add(new KeyValuePair<string, object>("@ZipPostCode", taxZipCode));
            Parameter.Add(new KeyValuePair<string, object>("@IsZipPostRange", isTaxZipRange));
            Parameter.Add(new KeyValuePair<string, object>("@TaxRateValue", taxRateValue));
            Parameter.Add(new KeyValuePair<string, object>("@RateType", rateType));
            Parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            Parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            Parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_SaveAndUpdateTaxRates", Parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------dalete Tax rates-----------------------
    [WebMethod]
    public void DeleteTaxRates(string taxRateIDs, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@TaxRateIDs", taxRateIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteTaxRates", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--------------------------get customer class----------------
    [WebMethod]
    public List<TaxManageRulesInfo> GetTaxRules(int offset, int limit, string ruleName, string customerClassName, string itemClassName, string rateTitle, string priority, string displayOrder, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@RuleName", ruleName));
            paraMeter.Add(new KeyValuePair<string, object>("@CustomerClassName", customerClassName));
            paraMeter.Add(new KeyValuePair<string, object>("@ItemClassName", itemClassName));
            paraMeter.Add(new KeyValuePair<string, object>("@RateTitle", rateTitle));
            paraMeter.Add(new KeyValuePair<string, object>("@SearchPriority", priority));
            paraMeter.Add(new KeyValuePair<string, object>("@SearchDisplayOrder", displayOrder));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paraMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlh = new SQLHandler();
            return sqlh.ExecuteAsList<TaxManageRulesInfo>("usp_ASPX_GetTaxManageRules", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind tax customer class name list-------------------------------
    [WebMethod]
    public List<TaxCustomerClassInfo> GetCustomerTaxClass(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<TaxCustomerClassInfo>("usp_ASPX_GetCustomerTaxClassList", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind tax item class name list-------------------------------
    [WebMethod]
    public List<TaxItemClassInfo> GetItemTaxClass(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<TaxItemClassInfo>("usp_ASPX_GetItemTaxClassList", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind tax rate list-------------------------------
    [WebMethod]
    public List<TaxRateInfo> GetTaxRate(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<TaxRateInfo>("usp_ASPX_GetTaxRateList", paraMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-------------------save and update tax rules--------------------------------------
    [WebMethod]
    public void SaveAndUpdateTaxRule(int taxManageRuleID, string taxManageRuleName, int taxCustomerClassID, int taxItemClassID, int taxRateID, int priority, int displayOrder, string cultureName, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@TaxManageRuleID", taxManageRuleID));
            parameter.Add(new KeyValuePair<string, object>("@TaxManageRuleName", taxManageRuleName));
            parameter.Add(new KeyValuePair<string, object>("@TaxCustomerClassID", taxCustomerClassID));
            parameter.Add(new KeyValuePair<string, object>("@TaxItemClassID", taxItemClassID));
            parameter.Add(new KeyValuePair<string, object>("@TaxRateID", taxRateID));
            parameter.Add(new KeyValuePair<string, object>("@Priority", priority));
            parameter.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_SaveAndUpdateTaxRules", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //-------------- delete Tax Rules----------------------------

    [WebMethod]
    public void DeleteTaxManageRules(string taxManageRuleIDs, int storeID, int portalID, string cultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@TaxManageRuleIDs", taxManageRuleIDs));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteTaxRules", parameter);
        }
        catch (Exception exe)
        {
            throw exe;
        }
    }
    #endregion

    #region Catalog Pricing Rule

    [WebMethod]
    public List<PricingRuleAttributeInfo> GetPricingRuleAttributes(int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<PricingRuleAttributeInfo> portalRoleCollection = new List<PricingRuleAttributeInfo>();
            PriceRuleSqlProvider priceRuleController = new PriceRuleSqlProvider();
            portalRoleCollection = priceRuleController.GetPricingRuleAttributes(portalID, storeID, userName, cultureName);
            return portalRoleCollection;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CatalogPriceRulePaging> GetPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
    {
        PriceRuleController priceRuleController = new PriceRuleController();
        return priceRuleController.GetCatalogPricingRules(ruleName, startDate, endDate, isActive, storeID, portalID, userName, culture, offset, limit);
    }


    [WebMethod]
    public CatalogPricingRuleInfo GetPricingRule(Int32 catalogPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        CatalogPricingRuleInfo catalogPricingRuleInfo = new CatalogPricingRuleInfo();
        PriceRuleController priceRuleController = new PriceRuleController();
        catalogPricingRuleInfo = priceRuleController.GetCatalogPricingRule(catalogPriceRuleID, storeID, portalID, userName, culture);
        return catalogPricingRuleInfo;
    }

    [WebMethod]
    public string SavePricingRule(CatalogPricingRuleInfo objCatalogPricingRuleInfo, Int32 storeID, Int32 portalID, string userName, string culture, object parentID)
    {
        try
        {
            List<KeyValuePair<string, object>> P1 = new List<KeyValuePair<string, object>>();
            P1.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            P1.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sql = new SQLHandler();
            int count = sql.ExecuteAsScalar<int>("usp_ASPX_CatalogPriceRuleCount", P1);
            int maxAllowed = 3;
            int catalogPriceRuleId = objCatalogPricingRuleInfo.CatalogPriceRule.CatalogPriceRuleID;
            if (catalogPriceRuleId > 0)
            {
                maxAllowed++;
            }
            if (count < maxAllowed)
            {
                PriceRuleController priceRuleController = new PriceRuleController();
                priceRuleController.SaveCatalogPricingRule(objCatalogPricingRuleInfo, storeID, portalID, userName,
                                                           culture, parentID);
                //return "({ \"returnStatus\" : 1 , \"Message\" : \"Saving catalog pricing rule successfully.\" })";
                return "success";
            }
            else
            {
                //return "({ \"returnStatus\" : -1 , \"Message\" : \"No more than 3 rules are allowed in Free version of AspxCommerce!\" })";
                return "notify";
            }
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while saving catalog pricing rule!\" })";
            }
        }
    }

    [WebMethod]
    public string DeletePricingRule(Int32 catalogPricingRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            PriceRuleController priceRuleController = new PriceRuleController();
            priceRuleController.CatalogPriceRuleDelete(catalogPricingRuleID, storeID, portalID, userName, culture);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Deleting catalog pricing rule successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while deleting catalog pricing rule!\" })";
            }
        }
    }

    [WebMethod]
    public string DeleteMultipleCatPricingRules(string catRulesIds, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            PriceRuleController priceRuleController = new PriceRuleController();
            priceRuleController.CatalogPriceMultipleRulesDelete(catRulesIds, storeID, portalID, userName, culture);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Deleting multiple catalog pricing rules successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while deleting pricing rule!\" })";
            }
        }
    }
    #endregion

    #region Cart Pricing Rule
    [WebMethod]
    public List<ShippingMethodInfo> GetShippingMethods(System.Nullable<bool> isActive, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler Sq = new SQLHandler();
            return Sq.ExecuteAsList<ShippingMethodInfo>("usp_ASPX_GetShippingMethods", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CartPricingRuleAttributeInfo> GetCartPricingRuleAttributes(int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<CartPricingRuleAttributeInfo> lst = new List<CartPricingRuleAttributeInfo>();
            PriceRuleSqlProvider priceRuleProvider = new PriceRuleSqlProvider();
            lst = priceRuleProvider.GetCartPricingRuleAttributes(portalID, storeID, userName, cultureName);
            return lst;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public string SaveCartPricingRule(CartPricingRuleInfo objCartPriceRule, Int32 storeID, Int32 portalID, string userName, string culture, object parentID)
    {
        try
        {
            List<KeyValuePair<string, object>> P1 = new List<KeyValuePair<string, object>>();
            //P1.Add(new KeyValuePair<string,object>("@StoreID", storeID));
            P1.Add(new KeyValuePair<string, object>("PortalID", portalID));
            SQLHandler sql = new SQLHandler();
            int count = sql.ExecuteAsScalar<int>("usp_ASPX_CartPrincingRuleCount", P1);
            int maxAllowed = 3;
            int cartPriceRuleId = objCartPriceRule.CartPriceRule.CartPriceRuleID;
            if (cartPriceRuleId > 0)
            {
                maxAllowed++;
            }
            if (count < maxAllowed)
            {
                PriceRuleController priceRuleController = new PriceRuleController();
                priceRuleController.SaveCartPricingRule(objCartPriceRule, storeID, portalID, userName, culture, parentID);
                //return "({ \"returnStatus\" : 1 , \"Message\" : \"Saving cart pricing rule successfully.\" })";
                return "success";
            }
            else
            {
                //return "({ \"returnStatus\" : -1 , \"Message\" : \"No more than 3 rules are allowed in Free version of AspxCommerce!\" })";
                return "notify";
            }
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while saving cart pricing rule!\" })";
            }
        }
    }

    [WebMethod]
    public List<CartPriceRulePaging> GetCartPricingRules(string ruleName, System.Nullable<DateTime> startDate, System.Nullable<DateTime> endDate, System.Nullable<bool> isActive, Int32 storeID, Int32 portalID, string userName, string culture, int offset, int limit)
    {
        PriceRuleController priceRuleController = new PriceRuleController();
        return priceRuleController.GetCartPricingRules(ruleName, startDate, endDate, isActive, storeID, portalID, userName, culture, offset, limit);
    }


    [WebMethod]
    public CartPricingRuleInfo GetCartPricingRule(Int32 cartPriceRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        CartPricingRuleInfo cartPricingRuleInfo = new CartPricingRuleInfo();
        PriceRuleController priceRuleController = new PriceRuleController();
        cartPricingRuleInfo = priceRuleController.GetCartPriceRules(cartPriceRuleID, storeID, portalID, userName, culture);
        return cartPricingRuleInfo;
    }

    [WebMethod]
    public string DeleteCartPricingRule(Int32 cartPricingRuleID, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            PriceRuleController priceRuleController = new PriceRuleController();
            priceRuleController.CartPriceRuleDelete(cartPricingRuleID, storeID, portalID, userName, culture);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Deleting cart pricing rule successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while deleting cart pricing rule!\" })";
            }
        }
    }

    [WebMethod]
    public string DeleteMultipleCartPricingRules(string cartRulesIds, Int32 storeID, Int32 portalID, string userName, string culture)
    {
        try
        {
            PriceRuleController priceRuleController = new PriceRuleController();
            priceRuleController.CartPriceMultipleRulesDelete(cartRulesIds, storeID, portalID, userName, culture);
            return "({ \"returnStatus\" : 1 , \"Message\" : \"Deleting multiple cart pricing rules successfully.\" })";
        }
        catch (Exception ex)
        {
            ErrorHandler errHandler = new ErrorHandler();
            if (errHandler.LogWCFException(ex))
            {
                return "({ \"returnStatus\" : -1 , \"errorMessage\" : \"" + ex.Message + "\" })";
            }
            else
            {
                return "({ \"returnStatus\" : -1, \"errorMessage\" : \"Error while deleting cart pricing rule!\" })";
            }
        }
    }
    #endregion

    #region AddToCart
    //
    //[WebMethod]
    //public bool AddtoCart(int itemID, int storeID, int portalID, string userName, string cultureName)
    //{

    //    try
    //    {
    //        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
    //        ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
    //        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
    //        SQLHandler sqLH = new SQLHandler();
    //        return sqLH.ExecuteNonQueryAsGivenType<bool>("usp_ASPX_CheckCostVariantForItem", ParaMeter, "@IsExist");

    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //}

    [WebMethod]
    public bool AddItemstoCart(int itemID, decimal itemPrice, int itemQuantity, int storeID, int portalID, string userName, int custometID, string sessionCode, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Price", itemPrice));
            ParaMeter.Add(new KeyValuePair<string, object>("@Quantity", itemQuantity));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsGivenType<bool>("usp_ASPX_CheckCostVariantForItem", ParaMeter, "@IsExist");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddItemstoCartFromDetail(int itemID, decimal itemPrice, decimal weight, int itemQuantity, string itemCostVariantIDs, int storeID, int portalID, string userName, int custometID, string sessionCode, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Price", itemPrice));
            ParaMeter.Add(new KeyValuePair<string, object>("@Weight", weight));
            ParaMeter.Add(new KeyValuePair<string, object>("@Quantity", itemQuantity));
            ParaMeter.Add(new KeyValuePair<string, object>("@CostVariantsValueIDs", itemCostVariantIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("dbo.usp_ASPX_AddToCart", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region MiniCart Display
    //----------------------Count my cart items--------------------
    [WebMethod]
    public int GetCartItemsCount(int storeID, int portalID, int customerID, string sessionCode, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            parameter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsScalar<int>("usp_ASPX_GetCartItemsCount", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Reporting Module

    //--------------- New Account Reports--------------------------
    [WebMethod]
    public List<NewAccountReportInfo> GetNewAccounts(int offset, int limit, int storeID, int portalID, string cultureName, bool Monthly, bool Weekly, bool Hourly)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            if (Monthly == true)
            {
                return sqlH.ExecuteAsList<NewAccountReportInfo>("usp_ASPX_GetNewAccountDetails", ParaMeter);
            }
            if (Weekly == true)
            {
                return sqlH.ExecuteAsList<NewAccountReportInfo>("usp_ASPX_GetNewAccountDetailsByCurrentMonth", ParaMeter);
            }
            if (Hourly == true)
            {
                return sqlH.ExecuteAsList<NewAccountReportInfo>("usp_ASPX_GetNewAccountDetailsBy24hours", ParaMeter);
            }
            else
                return new List<NewAccountReportInfo>();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #region Sales Tax Report
    [WebMethod]
    public List<StoreTaxesInfo> GetStoreSalesTaxes(int offset, int limit, string taxRuleName, int storeID, int portalID, bool Monthly, bool Weekly, bool Hourly)
    {
        try
        {
            List<KeyValuePair<string, object>> paraMeter = new List<KeyValuePair<string, object>>();
            paraMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            paraMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            paraMeter.Add(new KeyValuePair<string, object>("@TaxManageRuleName", taxRuleName));
            paraMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paraMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlh = new SQLHandler();
            if (Monthly == true)
            {
                return sqlh.ExecuteAsList<StoreTaxesInfo>("usp_ASPX_GetTaxRuleForStoreTaxReport", paraMeter);
            }
            if (Weekly == true)
            {
                return sqlh.ExecuteAsList<StoreTaxesInfo>("usp_ASPX_GetTaxDetailsByCurrentMonth", paraMeter);
            }
            if (Hourly == true)
            {
                return sqlh.ExecuteAsList<StoreTaxesInfo>("usp_ASPX_GetTaxReportDetailsBy24hours", paraMeter);
            }
            else
                return new List<StoreTaxesInfo>();
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Items Reporting
    //----------------------GetMostViewedItems----------------------
    [WebMethod]
    public List<MostViewedItemsInfo> GetMostViewedItemsList(int offset, int limit, string name, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetAllMostViewedItems(offset, limit, name, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    // --------------------------Get Low Stock Items----------------------------------------------------
    [WebMethod]
    public List<LowStockItemsInfo> GetLowStockItemsList(int offset, int limit, string Sku, string name, System.Nullable<bool> isActive, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetAllLowStockItems(offset, limit, Sku, name, isActive, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------------------Get Ordered Items List-----------------------------------
    [WebMethod]
    public List<OrderItemsGroupByItemIDInfo> GetOrderedItemsList(int offset, int limit, string name, int storeId, int portalId, string userName, string cultureName)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetOrderedItemsList(offset, limit, name, storeId, portalId, userName, cultureName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    // --------------------------Get DownLoadable Items----------------------------------------------------
    [WebMethod]
    public List<DownLoadableItemGetInfo> GetDownLoadableItemsList(int offset, int limit, string Sku, string name, int storeId, int portalId, string userName, string cultureName, System.Nullable<bool> CheckUser)
    {
        try
        {
            ItemsManagementSqlProvider obj = new ItemsManagementSqlProvider();
            return obj.GetDownLoadableItemsList(offset, limit, Sku, name, storeId, portalId, userName, cultureName, CheckUser);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    //---------------------Shipping Reports--------------------
    [WebMethod]
    public List<ShippedReportInfo> GetShippedDetails(int offset, int limit, int storeID, int portalID, string cultureName, string shippingMethodName, bool Monthly, bool Weekly, bool Hourly)
    {
        try
        {
            List<ShippedReportInfo> shipInfo = new List<ShippedReportInfo>();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@offset", offset));
            paramCol.Add(new KeyValuePair<string, object>("@limit", limit));
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramCol.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            paramCol.Add(new KeyValuePair<string, object>("@ShppingMethod", shippingMethodName));
            SQLHandler sageSQL = new SQLHandler();
            if (Monthly == true)
            {
                shipInfo = sageSQL.ExecuteAsList<ShippedReportInfo>("[dbo].[usp_ASPX_ShippingReportDetails]", paramCol);
                return shipInfo;
            }
            if (Weekly == true)
            {
                shipInfo = sageSQL.ExecuteAsList<ShippedReportInfo>("[dbo].[usp_ASPX_GetShippingDetailsByCurrentMonth]", paramCol);
                return shipInfo;
            }
            if (Hourly == true)
            {
                shipInfo = sageSQL.ExecuteAsList<ShippedReportInfo>("[dbo].[usp_ASPX_GetShippingReportDetailsBy24hours]", paramCol);
                return shipInfo;
            }
            else
                return new List<ShippedReportInfo>();
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }

    // ShoppingCartManagement ---------------------get Cart details in grid-------------------------------
    [WebMethod]
    public List<ShoppingCartInfo> GetShoppingCartItemsDetails(int offset, int limit, int storeID, string itemName, string quantity, int portalID, string userName, string cultureName, decimal timeToAbandonCart)
    {
        // quantity = quantity == "" ? null : quantity;
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@ItemName", itemName));
            parameter.Add(new KeyValuePair<string, object>("@Quantity", quantity));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameter.Add(new KeyValuePair<string, object>("@TimeToAbandonCart", timeToAbandonCart));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShoppingCartInfo>("usp_ASPX_GetLiveCarts", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------bind Abandoned cart details-------------------------
    [WebMethod]
    public List<AbandonedCartInfo> GetAbandonedCartDetails(int offset, int limit, int storeID, int portalID, string userName, string cultureName, decimal timeToAbandonCart)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@TimeToAbandonCart", timeToAbandonCart));
            SQLHandler sqLH = new SQLHandler();
            List<AbandonedCartInfo> bind = sqLH.ExecuteAsList<AbandonedCartInfo>("usp_ASPX_GetAbandonedCarts", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    // OrderManagement ---------------------get order details in grid-----------------------
    [WebMethod]
    public List<MyOrderListInfo> GetOrderDetails(int offset, int limit, int storeID, int portalID, string cultureName, string orderStatusName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameter.Add(new KeyValuePair<string, object>("@StatusName", orderStatusName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<MyOrderListInfo>("usp_ASPX_GetOrderDetails", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------------Send Email for status update----------------------- 
    [WebMethod]
    public void NotifyOrderStatusUpdate(string senderEmail, string receiverEmail, string subject, string message)
    {
        try
        {
            string emailSuperAdmin;
            string emailSiteAdmin;
            SageFrameConfig pagebase = new SageFrameConfig();
            emailSuperAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);
            emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
            MailHelper.SendMailNoAttachment(senderEmail, receiverEmail, subject, message, emailSiteAdmin, emailSuperAdmin);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------------------Update Order Status by Admin-----------------------   
    [WebMethod]
    public void SaveOrderStatus(int storeID, int portalID, int orderStatusID, int orderID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@OrderStatusID", orderStatusID));
            parameter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_UpdateOrderStatus", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    // InvoiceListMAnagement -----------------------get invoice details-----------------------
    [WebMethod]
    public List<InvoiceDetailsInfo> GetInvoiceDetailsList(int offset, int limit, string invoiceNumber, string billToNama, string status, int storeID, int portalID, string userName, string cultureName)
    {
        //status = status == "" ? null : status;
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@InvoiceNumber", invoiceNumber));
            //parameter.Add(new KeyValuePair<string, object>("@OrderID", orderId));
            parameter.Add(new KeyValuePair<string, object>("@BillToName", billToNama));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<InvoiceDetailsInfo>("usp_ASPX_GetInvoiceDetails", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //Get Invoice Details
    [WebMethod]
    public List<InvoiceDetailByorderIDInfo> GetInvoiceDetailsByOrderID(int orderID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
            SQLHandler sqlh = new SQLHandler();
            List<InvoiceDetailByorderIDInfo> info;
            info = sqlh.ExecuteAsList<InvoiceDetailByorderIDInfo>("usp_ASPX_GetInvoiceDetailsByOrderID", ParaMeter);
            return info;
        }

        catch (Exception ex)
        {
            throw ex;
        }
    }

    //--ShipmentsListManagement
    [WebMethod]
    public List<ShipmentsDetailsInfo> GetShipmentsDetails(int offset, int limit, string shippimgMethodName, string shipToName, string orderId, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@ShippingMethodName", shippimgMethodName));
            parameter.Add(new KeyValuePair<string, object>("@ShipToName", shipToName));
            parameter.Add(new KeyValuePair<string, object>("@OrderID", orderId));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShipmentsDetailsInfo>("usp_ASPX_GetShipmentsDetails", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //-----------View Shipments Details--------------------------
    [WebMethod]
    public List<ShipmentsDetailsViewInfo> BindAllShipmentsDetails(int orderID, int portalID, int storeID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ShipmentsDetailsViewInfo>("usp_ASPX_GetShipmentsDetalisForView", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Rating Reviews Reporting
    //--------------------bind Customer Reviews Roports-------------------------
    [WebMethod]
    public List<CustomerReviewReportsInfo> GetCustomerReviews(int offset, int limit, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            List<CustomerReviewReportsInfo> bind = sqLH.ExecuteAsList<CustomerReviewReportsInfo>("usp_ASPX_GetCustomerReviews", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Show All Customer Reviews-------------------------
    [WebMethod]
    public List<UserRatingInformationInfo> GetAllCustomerReviewsList(int offset, int limit, int storeID, int portalID, string cultureName, string userName, string user, string statusName, string itemName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@User", user));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusName", statusName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemName", itemName));
            SQLHandler sqLH = new SQLHandler();
            List<UserRatingInformationInfo> bind = sqLH.ExecuteAsList<UserRatingInformationInfo>("usp_ASPX_GetCustomerWiseReviewsList", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------Bind User List------------------------------
    [WebMethod]
    public List<UserListInfo> GetUserList(int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<UserListInfo>("sp_PortalUserList", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Item Reviews Reports-------------------------
    [WebMethod]
    public List<ItemReviewsInfo> GetItemReviews(int offset, int limit, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            List<ItemReviewsInfo> bind = sqLH.ExecuteAsList<ItemReviewsInfo>("usp_ASPX_GetItemReviewsList", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //---------------------Show All Item Reviews-------------------------
    [WebMethod]
    public List<UserRatingInformationInfo> GetAllItemReviewsList(int offset, int limit, int storeID, int portalID, string cultureName, int itemID, string userName, string statusName, string itemName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StatusName", statusName));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemName", itemName));
            SQLHandler sqLH = new SQLHandler();
            List<UserRatingInformationInfo> bind = sqLH.ExecuteAsList<UserRatingInformationInfo>("usp_ASPX_GetItemWiseReviewsList", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #endregion

    //-----------------------RelatedUPSellANDCrossSellItemsByCartItems-------------------
    [WebMethod]
    public List<ItemBasicDetailsInfo> GetRelatedItemsByCartItems(int storeID, int portalID, string userName, int customerID, string sessionCode, string cultureName, int count)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            parameter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            parameter.Add(new KeyValuePair<string, object>("@Count", count));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ItemBasicDetailsInfo>("usp_ASPX_RelatedItemsByCartItems", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind order status name list-------------------------------
    [WebMethod]
    public List<StatusInfo> GetStatusList(int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<StatusInfo>("usp_ASPX_BindOrderStatusList", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region Special Items
    [WebMethod]
    public List<SpecialItemsInfo> GetSpecialItems(int storeID, int portalID, string userName, int count)
    {
        List<SpecialItemsInfo> slInfo = new List<SpecialItemsInfo>();
        List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
        paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        paramCol.Add(new KeyValuePair<string, object>("@UserName", userName));
        paramCol.Add(new KeyValuePair<string, object>("@count", count));
        SQLHandler sageSQL = new SQLHandler();
        slInfo = sageSQL.ExecuteAsList<SpecialItemsInfo>("[dbo].[usp_ASPX_GetSpecialItems]", paramCol);
        return slInfo;
    }
    #endregion

    #region Best Seller
    [WebMethod]
    public List<BestSellerInfo> GetBestSoldItems(int storeID, int portalID, string userName, int count)
    {
        List<BestSellerInfo> slInfo = new List<BestSellerInfo>();
        List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
        paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        paramCol.Add(new KeyValuePair<string, object>("@UserName", userName));
        paramCol.Add(new KeyValuePair<string, object>("@count", count));
        SQLHandler sageSQL = new SQLHandler();
        slInfo = sageSQL.ExecuteAsList<BestSellerInfo>("[dbo].[usp_ASPX_GetBestSoldItems]", paramCol);
        return slInfo;
    }
    #endregion

    #region Payment Gateway and CheckOUT PROCESS
    [WebMethod]
    public bool CheckDownloadableItemOnly(int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsBool("[dbo].[usp_ASPX_CheckForDownloadableItemsInCart]", ParaMeter, "@IsAllDownloadable");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<PaymentGatewayListInfo> GetPGList(int storeID, int portalID, string cultureName)
    {
        List<PaymentGatewayListInfo> pginfo = new List<PaymentGatewayListInfo>();

        List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
        paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        paramCol.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sageSQL = new SQLHandler();
        pginfo = sageSQL.ExecuteAsList<PaymentGatewayListInfo>("[dbo].[usp_ASPX_GetPaymentGatewayList]", paramCol);

        return pginfo;
    }

    [WebMethod]
    public List<PaymentGateway> GetPaymentGateway(int _portalID, string _cultureName, string _userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", _portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", _cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", _userName));
            SQLHandler sqlH = new SQLHandler();
            List<PaymentGateway> Count = sqlH.ExecuteAsList<PaymentGateway>("sp_GetPaymentGateway", ParaMeter);
            return Count;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<userAddressInfo> GetUserAddressForCheckOut(int storeID, int portalID, string userName, string CultureName)
    {

        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<userAddressInfo>("usp_ASPX_GetUserAddressBookDetails", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckCreditCard(int storeID, int portalID, string creditCardNo)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@CreditCard", creditCardNo));
            //parameter.Add(new KeyValuePair<string, object>("@IsExist", 0));
            return sqLH.ExecuteNonQueryAsBool("usp_ASPX_CheckCreditCardBlackList", parameter, "@IsExist");
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod(EnableSession = true)]
    public void SaveOrderDetails(OrderDetailsCollection OrderDetail)
    {
        try
        {
            OrderDetail.objOrderDetails.OrderStatusID = 7;
            AddOrderDetails(OrderDetail);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod(EnableSession = true)]
    public void AddOrderDetails(OrderDetailsCollection OrderData)
    {
        SQLHandler sqlH = new SQLHandler();
        SqlTransaction tran;
        tran = (SqlTransaction)sqlH.GetTransaction();
        //ASPXCommerceSession sn = new ASPXCommerceSession();
        OrderData.objOrderDetails.InvoiceNumber = DateTime.Now.ToString("yyyyMMddhhmmss");
        try
        {
            ASPXOrderDetails objOrderDetails = new ASPXOrderDetails();

            int billingAddressID = 0;
            int shippingAddressId = 0;
            int orderID = 0;
            if (OrderData.objOrderDetails.IsMultipleCheckOut == false)
            {
                if (OrderData.objBillingAddressInfo.IsBillingAsShipping == true)
                {
                    if (int.Parse(OrderData.objBillingAddressInfo.AddressID) == 0 &&
                        int.Parse(OrderData.objShippingAddressInfo.AddressID) == 0)
                    {
                        int addressID = objOrderDetails.AddAddress(OrderData, tran);
                        billingAddressID = objOrderDetails.AddBillingAddress(OrderData, tran, addressID);
                        shippingAddressId = objOrderDetails.AddShippingAddress(OrderData, tran, addressID);
                    }
                }
                else
                {
                    if (int.Parse(OrderData.objBillingAddressInfo.AddressID) == 0)
                        billingAddressID = objOrderDetails.AddBillingAddress(OrderData, tran);
                  
                    if (int.Parse(OrderData.objShippingAddressInfo.AddressID) == 0)
                    {
                        if (!OrderData.objOrderDetails.IsDownloadable)
                        {
                            shippingAddressId = objOrderDetails.AddShippingAddress(OrderData, tran);
                        }

                    }
                }
            }
            int paymentMethodID = objOrderDetails.AddPaymentInfo(OrderData, tran);

            if (billingAddressID > 0)
            {
                orderID = objOrderDetails.AddOrder(OrderData, tran, billingAddressID, paymentMethodID);
                //sn.SetSessionVariable("OrderID", orderID);
                SetSessionVariable("OrderID", orderID);
                SetSessionVariable("OrderCollection", OrderData);
            }
            else
            {
                orderID = objOrderDetails.AddOrderWithMultipleCheckOut(OrderData, tran, paymentMethodID);

                //sn.SetSessionVariable("OrderID", orderID);
                SetSessionVariable("OrderID", orderID);
                SetSessionVariable("OrderCollection", OrderData);
            }

            if (shippingAddressId > 0)
                objOrderDetails.AddOrderItems(OrderData, tran, orderID, shippingAddressId);
            else
                objOrderDetails.AddOrderItemsList(OrderData, tran, orderID);

            tran.Commit();
        }
        catch (SqlException sqlEX)
        {

            throw new ArgumentException(sqlEX.Message);
        }
        catch (Exception ex)
        {
            tran.Rollback();
            throw ex;
        }
    }
    #endregion

    #region Payment Gateway Installation

    [WebMethod]
    public List<PaymentGateWayInfo> GetAllPaymentMethod(int offset, int limit, int storeId, int portalId, string paymentGatewayName, System.Nullable<bool> isActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@offset", offset));
            parameterCollection.Add(new KeyValuePair<string, object>("@limit", limit));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewayName", paymentGatewayName));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));

            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<PaymentGateWayInfo>("usp_ASPX_GetPaymentGateWayMethod", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    [WebMethod]
    public void DeletePaymentMethod(string paymentGatewayID, int storeId, int portalId, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();

            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", paymentGatewayID));
            parameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));

            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeletePaymentMethodName", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdatePaymentMethod(int storeId, int portalId, int paymentGatewayID, string paymentGatewayName, bool isActive, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();


            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", paymentGatewayID));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeName", paymentGatewayName));
            parameterCollection.Add(new KeyValuePair<string, object>("@UserName", userName));

            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_UpdatePaymentMethod", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void AddUpdatePaymentGateWaySettings(int paymentGatewaySettingValueID, int paymentGatewayID, string settingKeys, string settingValues, bool isActive, int storeId, int portalId, string updatedBy, string addedBy)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewaySettingValueID", paymentGatewaySettingValueID));
            parameterCollection.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", paymentGatewayID));
            parameterCollection.Add(new KeyValuePair<string, object>("@SettingKeys", settingKeys));
            parameterCollection.Add(new KeyValuePair<string, object>("@SettingValues ", settingValues));
            parameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@UpdatedBy", updatedBy));
            parameterCollection.Add(new KeyValuePair<string, object>("@AddedBy", addedBy));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_GetPaymentGatewaySettingsSaveUpdate", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<GetOrderdetailsByPaymentGatewayIDInfo> GetOrderDetailsbyPayID(int offset, int limit, string billToName, string ShipToName, string orderStatusName, int paymentGatewayID, int storeID, int portalID, string userName, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@BillToName", billToName));
            parameter.Add(new KeyValuePair<string, object>("@ShipToName", ShipToName));
            parameter.Add(new KeyValuePair<string, object>("@OrderStatusAliasName", orderStatusName));
            parameter.Add(new KeyValuePair<string, object>("@PaymentGatewayTypeID", paymentGatewayID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<GetOrderdetailsByPaymentGatewayIDInfo>("usp_ASPX_GetOrderDetailsByPaymentGetwayID", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<OrderDetailsByOrderIDInfo> GetAllOrderDetailsByOrderID(int orderId, int storeId, int portalId)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@OrderID", orderId));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<OrderDetailsByOrderIDInfo>("usp_ASPX_GetBillingAndShippingAddressDetailsByOrderID", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<OrderItemsInfo> GetAllOrderDetailsForView(int orderId, int storeId, int portalId, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameterCollection = new List<KeyValuePair<string, object>>();
            parameterCollection.Add(new KeyValuePair<string, object>("@OrderID", orderId));
            parameterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            parameterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            parameterCollection.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<OrderItemsInfo>("usp_ASPX_GetAddressDetailsByOrderID", parameterCollection);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region "StoreSetings"
    [WebMethod(EnableSession = true)]
    public StoreSettingInfo GetAllStoreSettings(int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            StoreSettingInfo DefaultStoreSettings = new StoreSettingInfo();
            DefaultStoreSettings = sqLH.ExecuteAsObject<StoreSettingInfo>("usp_ASPX_GetAllStoreSettings", ParaMeter);
            Session["DefaultStoreSettings"] = DefaultStoreSettings;
            return DefaultStoreSettings;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateStoreSettings(string settingKeys, string settingValues, string prevFilePath, string newFilePath, int storeID, int portalID, string cultureName)
    {

        try
        {
            FileHelperController fileObj = new FileHelperController();
            string uplodedValue = string.Empty;
            if (newFilePath != null && prevFilePath != newFilePath)
            {
                string tempFolder = @"Upload\temp";
                uplodedValue = fileObj.MoveFileToSpecificFolder(tempFolder, prevFilePath, newFilePath, @"Modules\ASPXCommerce\ASPXStoreSettingsManagement\uploads\", storeID, "store_");
            }
            else
            {
                uplodedValue = prevFilePath;
            }
            settingKeys = "DefaultProductImageURL" + '*' + settingKeys;
            settingValues = uplodedValue + '*' + settingValues;

            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@SettingKeys", settingKeys));
            parameter.Add(new KeyValuePair<string, object>("@SettingValues", settingValues));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLh = new SQLHandler();
            sqLh.ExecuteNonQuery("usp_ASPX_GetStoreSettingsUpdate", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region CardType_Management
    //------------------------bind All CardType name list-------------------------------        
    [WebMethod]
    public List<CardTypeInfo> GetAllCardTypeList(int offset, int limit, int StoreID, int PortalID, string CultureName, string CardTypeName, System.Nullable<bool> IsActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@CardTypeName", CardTypeName));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CardTypeInfo>("usp_ASPX_GetCardTypeInGrid", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<CardTypeInfo> AddUpdateCardType(int StoreID, int PortalID, string CultureName, string UserName, int CardTypeID, string CardTypeName, bool IsActive, string NewFilePath, string PrevFilePath, string AlternateText)
    {

        FileHelperController imageObj = new FileHelperController();
        string uploadedFile = string.Empty;

        if (NewFilePath != "" && PrevFilePath != NewFilePath)
        {
            string tempFolder = @"Upload\temp";
            uploadedFile = imageObj.MoveFileToSpecificFolder(tempFolder, PrevFilePath, NewFilePath, @"Modules\ASPXCommerce\ASPXCardTypeManagement\uploads\", CardTypeID, "cardType_");

        }
        else
        {
            uploadedFile = PrevFilePath;
        }
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();

            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            parameter.Add(new KeyValuePair<string, object>("@CardTypeID", CardTypeID));
            parameter.Add(new KeyValuePair<string, object>("@CardTypeName", CardTypeName));
            parameter.Add(new KeyValuePair<string, object>("@ImagePath", uploadedFile));
            parameter.Add(new KeyValuePair<string, object>("@AlternateText", AlternateText));

            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));

            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CardTypeInfo>("[dbo].[usp_ASPX_AddUpdateCardType]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteCardTypeByID(int CardTypeID, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CardTypeID", CardTypeID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteCardTypeByID]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    [WebMethod]
    public void DeleteCardTypeMultipleSelected(string CardTypeIDs, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CardTypeIDs", CardTypeIDs));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteCardTypeMultipleSelected]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    #endregion

    #region OrderStatusManagement
    //------------------------bind Allorder status name list-------------------------------    
    [WebMethod]
    public List<OrderStatusListInfo> GetAllStatusList(int offset, int limit, int StoreID, int PortalID, string CultureName, string UserName, string orderStatusName, System.Nullable<bool> IsActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            parameter.Add(new KeyValuePair<string, object>("@OrderStatusName", orderStatusName));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderStatusListInfo>("[dbo].[usp_ASPX_GetOrderAliasStatusList]", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<OrderStatusListInfo> AddUpdateOrderStatus(int StoreID, int PortalID, string CultureName, string UserName, Int32 OrderStatusID, string OrderStatusAliasName, string AliasToolTip, string AliasHelp, bool IsSystem, bool IsActive)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();

            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            parameter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            parameter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            parameter.Add(new KeyValuePair<string, object>("@OrderStatusID", OrderStatusID));
            parameter.Add(new KeyValuePair<string, object>("@OrderStatusAliasName", OrderStatusAliasName));
            parameter.Add(new KeyValuePair<string, object>("@AliasToolTip", AliasToolTip));
            parameter.Add(new KeyValuePair<string, object>("@AliasHelp", AliasHelp));
            parameter.Add(new KeyValuePair<string, object>("@IsSystem", IsSystem));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));

            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderStatusListInfo>("[dbo].[usp_ASPX_OrderStatusAddUpdate]", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteOrderStatusByID(int OrderStatusID, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@OrderStatusID", OrderStatusID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteOrderStatusByID]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    [WebMethod]
    public void DeleteOrderStatusMultipleSelected(string OrderStatusIDs, int StoreID, int PortalID, string UserName, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@OrderStatusIDs", OrderStatusIDs));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler Sq = new SQLHandler();
            Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteOrderStatusMultipleSelected]", ParaMeterCollection);
        }
        catch (Exception e)
        {
            throw e;
        }
    }
    #endregion
    #region Admin DashBoard Chart
    //------------------------bind order Chart by last week-------------------------------

    [WebMethod]
    public List<OrderChartInfo> GetOrderChartDetailsByLastWeek(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID)); ;
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderChartInfo>("usp_ASPX_GetOrderChartDetailsByLastWeek", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind order Chart by current month-------------------------------    
    [WebMethod]
    public List<OrderChartInfo> GetOrderChartDetailsBycurentMonth(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID)); ;
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderChartInfo>("usp_ASPX_GetOrderDetailsByCurrentMonth", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind order Chart by one year-------------------------------    
    [WebMethod]
    public List<OrderChartInfo> GetOrderChartDetailsByOneYear(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID)); ;
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderChartInfo>("usp_ASPX_GetOrderChartDetailsByOneYear", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    //------------------------bind order Chart by last 24 hours-------------------------------    
    [WebMethod]
    public List<OrderChartInfo> GetOrderChartDetailsBy24hours(int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID)); ;
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<OrderChartInfo>("usp_ASPX_GetOrderChartBy24hours", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Store Locator
    [WebMethod]
    public List<StoreLocatorInfo> GetAllStoresLocation(int PortalID, int StoreID)
    {
        List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
        ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
        try
        {
            SQLHandler SageHandler = new SQLHandler();
            return SageHandler.ExecuteAsList<StoreLocatorInfo>("usp_ASPX_StoreLocatorGetAllStore", ParameterCollection);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public List<StoreLocatorInfo> GetLocationsNearBy(double Latitude, double Longitude, double SearchDistance, int PortalID, int StoreID)
    {
        //GeoCoder.Coordinate Coordinate = GeoCoder.Geocode.GetCoordinates(Address, GoogleAPIKey);

        List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
        ParameterCollection.Add(new KeyValuePair<string, object>("@CenterLatitude", Latitude));
        ParameterCollection.Add(new KeyValuePair<string, object>("@CenterLongitude", Longitude));
        ParameterCollection.Add(new KeyValuePair<string, object>("@SearchDistance", SearchDistance));
        ParameterCollection.Add(new KeyValuePair<string, object>("@EarthRadius", 3961));
        ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
		ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));

        try
        {
            SQLHandler SageHandler = new SQLHandler();
            return SageHandler.ExecuteAsList<StoreLocatorInfo>("usp_ASPX_StoreLocatorGetNearbyStore", ParameterCollection);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public bool UpdateStoreLocation(int StoreID, int PortalID, string StoreName, String StoreDescription, string StreetName, string LocalityName, string City, string State, string Country, string ZIP, double Latitude, double Longitude, string Username)
    {
        List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreName", StoreName));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreDescription", StoreDescription));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StreetName", StreetName));
        ParameterCollection.Add(new KeyValuePair<string, object>("@LocalityName", LocalityName));
        ParameterCollection.Add(new KeyValuePair<string, object>("@City", City));
        ParameterCollection.Add(new KeyValuePair<string, object>("@State", State));
        ParameterCollection.Add(new KeyValuePair<string, object>("@Country", Country));
        ParameterCollection.Add(new KeyValuePair<string, object>("@ZIP", ZIP));
        ParameterCollection.Add(new KeyValuePair<string, object>("@Latitude", Latitude));
        ParameterCollection.Add(new KeyValuePair<string, object>("@Longitude", Longitude));
        ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", Username));

        try
        {
            SQLHandler SageHandler = new SQLHandler();
            SageHandler.ExecuteNonQuery("usp_ASPX_StoreLocatorLocationUpdate", ParameterCollection);
            return true;
        }
        catch (Exception ex)
        {
            return false;
            throw ex;
        }
    }

    [WebMethod]
    public void AddStoreLocatorSettings(string SettingKey, string SettingValue, string CultureName, int StoreID, int PortalID, string UserName)
    {
        List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
        ParameterCollection.Add(new KeyValuePair<string, object>("@SettingKey", SettingKey));
        ParameterCollection.Add(new KeyValuePair<string, object>("@SettingValue", SettingValue));
        ParameterCollection.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@AddedBy", UserName));
        try
        {
            SQLHandler SageHandler = new SQLHandler();
            SageHandler.ExecuteNonQuery("usp_ASPX_StoreLocatorSettingsAdd", ParameterCollection);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion

    #region Online Users
    [WebMethod]
    public List<OnLineUserBaseInfo> GetRegisteredUserOnlineCount(int offset, int limit, string SearchUserName, string SearchHostAddress, string SearchBrowser, int StoreID, int PortalID, string UserName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();
            ParameterCollection.Add(new KeyValuePair<string, object>("@Offset", offset));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Limit", limit));
            ParameterCollection.Add(new KeyValuePair<string, object>("@SearchUserName", SearchUserName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@HostAddress", SearchHostAddress));
            ParameterCollection.Add(new KeyValuePair<string, object>("@Browser", SearchBrowser));
            ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
            SQLHandler SageHandler = new SQLHandler();
            return SageHandler.ExecuteAsList<OnLineUserBaseInfo>("usp_ASPX_GetOnlineRegisteredUsers", ParameterCollection);
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public List<OnLineUserBaseInfo> GetAnonymousUserOnlineCount(int offset, int limit, string SearchHostAddress, string SearchBrowser, int StoreID, int PortalID, string UserName)
    {
        List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

        ParameterCollection.Add(new KeyValuePair<string, object>("@Offset", offset));
        ParameterCollection.Add(new KeyValuePair<string, object>("@Limit", limit));

        ParameterCollection.Add(new KeyValuePair<string, object>("@HostAddress", SearchHostAddress));
        ParameterCollection.Add(new KeyValuePair<string, object>("@Browser", SearchBrowser));
        ParameterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
        ParameterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
        try
        {
            SQLHandler SageHandler = new SQLHandler();
            List<OnLineUserBaseInfo> lst = new List<OnLineUserBaseInfo>();
            lst = SageHandler.ExecuteAsList<OnLineUserBaseInfo>("usp_ASPX_GetOnlineAnomymousUsers", ParameterCollection);
            return lst;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }
    #endregion

    #region Customer Reports By Order Total
    //--------------------bind Customer Order Total Roports-------------------------    
    [WebMethod]
    public List<CustomerOrderTotalInfo> GetCustomerOrderTotal(int offset, int limit, int storeID, int portalID, string cultureName, string user)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@User", user));
            SQLHandler sqLH = new SQLHandler();
            List<CustomerOrderTotalInfo> bind = sqLH.ExecuteAsList<CustomerOrderTotalInfo>("usp_ASPX_GetCustomerOrderTotal", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Store Access Management
    [WebMethod]
    public List<StoreAccessAutocomplete> SearchStoreAccess(string text, int KeyID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessKeyID", KeyID));
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessData", text));
            return sqLH.ExecuteAsList<StoreAccessAutocomplete>("[dbo].[usp_ASPX_GetSearchAutoComplete]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveUpdateStoreAccess(int Edit, int StoreAccessKeyID, string StoreAccessData, string Reason, bool IsActive, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessKeyID", StoreAccessKeyID));
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessData", StoreAccessData));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
            parameter.Add(new KeyValuePair<string, object>("@Reason", Reason));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessID", Edit));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_StoreAccessAddUpdate]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeletStoreAccess(int storeAccessID, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@StoreAccessID", storeAccessID));
            parameter.Add(new KeyValuePair<string, object>("@DeletedBy", userName));

            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_StoreAccessDelete]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ASPXUserList> GetASPXUser(string userName, int StoreID, int PortalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ASPXUserList>("[dbo].[usp_ASPX_GetListOfCurrentCustomer]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ASPXUserList> GetASPXUserEmail(string email, int StoreID, int PortalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@Email", email));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<ASPXUserList>("[dbo].[usp_ASPX_GetListOfCurrentCustomerEmail]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    [WebMethod]
    public List<StoreAccessKey> GetStoreKeyID()
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<StoreAccessKey>("[dbo].[usp_ASPX_GetStoreAccessKeyID]");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<StoreAccessInfo> LoadStoreAccessCustomer(int offset, int limit, string search, System.Nullable<DateTime> addedon, System.Nullable<bool> status, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@Search", search));
            parameter.Add(new KeyValuePair<string, object>("@AddedOn", addedon));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));

            return sqLH.ExecuteAsList<StoreAccessInfo>("[dbo].[usp_ASPX_GetStoreAccessCustomer]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<StoreAccessInfo> LoadStoreAccessEmails(int offset, int limit, string search, System.Nullable<DateTime> addedon, System.Nullable<bool> status, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@Search", search));
            parameter.Add(new KeyValuePair<string, object>("@AddedOn", addedon));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));

            return sqLH.ExecuteAsList<StoreAccessInfo>("[dbo].[usp_ASPX_GetStoreAccessEmail]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<StoreAccessInfo> LoadStoreAccessIPs(int offset, int limit, string search, System.Nullable<DateTime> addedon, System.Nullable<bool> status, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@Search", search));
            parameter.Add(new KeyValuePair<string, object>("@AddedOn", addedon));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));

            return sqLH.ExecuteAsList<StoreAccessInfo>("[dbo].[usp_ASPX_GetStoreAccessIP]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<StoreAccessInfo> LoadStoreAccessDomains(int offset, int limit, string search, System.Nullable<DateTime> addedon, System.Nullable<bool> status, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@Search", search));
            parameter.Add(new KeyValuePair<string, object>("@AddedOn", addedon));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));

            return sqLH.ExecuteAsList<StoreAccessInfo>("[dbo].[usp_ASPX_GetStoreAccessDomain]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<StoreAccessInfo> LoadStoreAccessCreditCards(int offset, int limit, string search, System.Nullable<DateTime> addedon, System.Nullable<bool> status, int storeID, int portalID)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@Search", search));
            parameter.Add(new KeyValuePair<string, object>("@AddedOn", addedon));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));

            return sqLH.ExecuteAsList<StoreAccessInfo>("[dbo].[usp_ASPX_GetStoreAccessCreditCard]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Store Close
    [WebMethod]
    public void SaveStoreClose(System.Nullable<bool> temporary, System.Nullable<bool> permanent, System.Nullable<DateTime> closeFrom, System.Nullable<DateTime> closeTill, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@Temporary", temporary));
            ParaMeter.Add(new KeyValuePair<string, object>("@Permanent", permanent));
            ParaMeter.Add(new KeyValuePair<string, object>("@CloseFrom", closeFrom));
            ParaMeter.Add(new KeyValuePair<string, object>("@CloseTill", closeTill));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_SaveStoreClose", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region CustomerDetails
    [WebMethod]
    public List<CustomerDetailsInfo> GetCustomerDetails(int offset, int limit, int StoreID, int PortalID, string CultureName, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));

            SQLHandler sqLH = new SQLHandler();
            List<CustomerDetailsInfo> bind = sqLH.ExecuteAsList<CustomerDetailsInfo>("[dbo].[usp_ASPX_GetCustomerDetails]", ParaMeter);
            return bind;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteMultipleCustomersByCustomerID(string CustomerIDs, int storeId, int portalId, string userName)
    {
        try
        {
            CustomerManagementSQLProvider obj = new CustomerManagementSQLProvider();
            obj.DeleteMultipleCustomers(CustomerIDs, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteCustomerByCustomerID(int customerId, int storeId, int portalId, string userName)
    {
        try
        {
            CustomerManagementSQLProvider obj = new CustomerManagementSQLProvider();
            obj.DeleteCustomer(customerId, storeId, portalId, userName);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Order Request Return
    [WebMethod]
    public void UpdateReturnRequests(int id, int status, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@ID", id));
            parameter.Add(new KeyValuePair<string, object>("@StatusID", status));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[usp_ASPX_UpdateRequestReturn]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteStatus(int ID, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@ID", ID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[usp_ASPX_DeleteReturnStatus]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void DeleteReason(int ID, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@ID", ID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteReturnReason]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnRequestAction> GetListReturnAction(int offset, int limit, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ReturnRequestAction>("[dbo].[usp_ASPX_GetListReturnAction]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnRequestStatus> GetListReturnStatus(int offset, int limit, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ReturnRequestStatus>("[dbo].[usp_ASPX_GetListReturnStatus]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnRequestsReason> GetListReturnReason(int offset, int limit, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@limit", limit));
            parameter.Add(new KeyValuePair<string, object>("@offset", offset));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<ReturnRequestsReason>("[usp_ASPX_GetListReturnReason]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void UpdateAction(int isupdate, string action, int displayOrder, bool isActive, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@ID", isupdate));
            parameter.Add(new KeyValuePair<string, object>("@Action", action));
            parameter.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_UpdateReturnAction]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveUpdateReason(int isupdate, string reason, int displayOrder, bool isActive, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@IsUpdate", isupdate));
            parameter.Add(new KeyValuePair<string, object>("@Reason", reason));
            parameter.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_SaveUpdateReturnReason]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public void SaveUpdateStatus(int isupdate, string status, int displayOrder, bool isActive, int storeID, int portalID, string userName)
    {
        try
        {
            SQLHandler sqLH = new SQLHandler();
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@IsUpdate", isupdate));
            parameter.Add(new KeyValuePair<string, object>("@Status", status));
            parameter.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            parameter.Add(new KeyValuePair<string, object>("@AddedBy", userName));
            sqLH.ExecuteNonQuery("[dbo].[usp_ASPX_SaveUpdateReturnStatus]", parameter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnReasonList> LoadReason(int storeID, int portalID)
    {
        try
        {
            List<ReturnReasonList> catInfo = new List<ReturnReasonList>();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sageSQL = new SQLHandler();
            catInfo = sageSQL.ExecuteAsList<ReturnReasonList>("[usp_ASPX_GetReturnReason]", paramCol);
            return catInfo;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnActionList> LoadAction(int storeID, int portalID)
    {
        try
        {
            List<ReturnActionList> catInfo = new List<ReturnActionList>();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sageSQL = new SQLHandler();
            catInfo = sageSQL.ExecuteAsList<ReturnActionList>("[usp_ASPX_GetReturnAction]", paramCol);
            return catInfo;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnStatusList> LoadRequestStatus(int storeID, int portalID)
    {
        try
        {
            List<ReturnStatusList> catInfo = new List<ReturnStatusList>();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sageSQL = new SQLHandler();
            catInfo = sageSQL.ExecuteAsList<ReturnStatusList>("[dbo].[usp_ASPX_GetRequestStatus]", paramCol);
            return catInfo;
        }
        catch (Exception ex)
        {

            throw ex;
        }
    }

    [WebMethod]
    public List<ReturnRequestList> LoadReturnRequest(int offset, int limit, string customer, System.Nullable<int> status, string email, int storeID, int portalID)
    {
        try
        {
            List<ReturnRequestList> catInfo = new List<ReturnRequestList>();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            paramCol.Add(new KeyValuePair<string, object>("@limit", limit));
            paramCol.Add(new KeyValuePair<string, object>("@offset", offset));
            paramCol.Add(new KeyValuePair<string, object>("@Customer", customer));
            paramCol.Add(new KeyValuePair<string, object>("@Email", email));
            paramCol.Add(new KeyValuePair<string, object>("@Status", status));
            SQLHandler sageSQL = new SQLHandler();
            catInfo = sageSQL.ExecuteAsList<ReturnRequestList>("[dbo].[usp_ASPX_GetRequestReturn]", paramCol);
            return catInfo;
        }
        catch (Exception ex)
        {

            throw ex;
        }

    }
    #endregion

    //------------------------Multiple Delete Recently viewed Items-------------------------------    
    [WebMethod]
    public void DeleteViewedItems(string viewedItems, int storeID, int portalID, string userName)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@ViewedItems", viewedItems));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            parameter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteMultipleViewedItems", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    //------------------------Multiple Delete Compared viewed Items-------------------------------    
    [WebMethod]
    public void DeleteComparedItems(string compareItems, int storeID, int portalID)
    {
        try
        {
            List<KeyValuePair<string, object>> parameter = new List<KeyValuePair<string, object>>();
            parameter.Add(new KeyValuePair<string, object>("@CompareItems", compareItems));
            parameter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            parameter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteMultipleComparedItems", parameter); ;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public string GetDiscountPriceRule(int cartID, int storeID, int portalID, string userName, string cultureName, decimal shippingCost)
    {

        try
        {
            SqlConnection SQLConn = new SqlConnection(SystemSetting.SageFrameConnectionString);
            SqlCommand SQLCmd = new SqlCommand();
            SqlDataAdapter SQLAdapter = new SqlDataAdapter();
            DataSet SQLds = new DataSet();
            SQLCmd.Connection = SQLConn;
            SQLCmd.CommandText = "[dbo].[usp_ASPX_GetDiscountCartPriceRule]";
            SQLCmd.CommandType = CommandType.StoredProcedure;
            SQLCmd.Parameters.AddWithValue("@CartID", cartID);
            SQLCmd.Parameters.AddWithValue("@StoreID", storeID);
            SQLCmd.Parameters.AddWithValue("@PortalID", portalID);
            SQLCmd.Parameters.AddWithValue("@CultureName", cultureName);
            SQLCmd.Parameters.AddWithValue("@UserName", userName);
            SQLCmd.Parameters.AddWithValue("@ShippingCost", shippingCost);
            SQLAdapter.SelectCommand = SQLCmd;
            SQLConn.Open();
            SqlDataReader dr = null;
            
            dr = SQLCmd.ExecuteReader();

            string discount = string.Empty;
            if (dr.Read())
            {
                discount = dr["Discount"].ToString();

            }

            return discount;
        }
        catch (Exception e)
        {
            throw e;
        }
    }   

    [WebMethod]
    public int GetCartId(int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            SqlConnection SQLConn = new SqlConnection(SystemSetting.SageFrameConnectionString);
            SqlCommand SQLCmd = new SqlCommand();
            SqlDataAdapter SQLAdapter = new SqlDataAdapter();
            DataSet SQLds = new DataSet();
            SQLCmd.Connection = SQLConn;
            SQLCmd.CommandText = "[dbo].[usp_ASPX_GetCartID]";
            SQLCmd.CommandType = CommandType.StoredProcedure;
            SQLCmd.Parameters.AddWithValue("@CustomerID", customerID);
            SQLCmd.Parameters.AddWithValue("@StoreID", storeID);
            SQLCmd.Parameters.AddWithValue("@PortalID", portalID);
            SQLCmd.Parameters.AddWithValue("@SessionCode", sessionCode);

            SQLAdapter.SelectCommand = SQLCmd;
            SQLConn.Open();
            SqlDataReader dr = null;

            dr = SQLCmd.ExecuteReader();

            int cartId = 0;
            if (dr.Read())
            {
                cartId = int.Parse(dr["CartID"].ToString());

            }

            return cartId;
        }
        catch (Exception e)
        {
            throw e;
        }
    }

    #region GetStoreSetting
    [WebMethod]
    public string GetStoreSettingValueByKey(string settingKey, int storeID, int portalID, string cultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@SettingKey", settingKey));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsGivenType<string>("usp_ASPX_GetStoreSettingValueBYKey", ParaMeter, "@SettingValue");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    #region Session Setting/Getting
    [WebMethod(EnableSession = true)]
    public void SetSessionVariableCoupon(string key, int value)
    {
        if (System.Web.HttpContext.Current.Session[key] != null)
        {
            value = int.Parse(System.Web.HttpContext.Current.Session[key].ToString()) + 1;
        }
        else
        {
            value = value + 1;
        }

        System.Web.HttpContext.Current.Session[key] = value;
        //  string asdf = System.Web.HttpContext.Current.Session["OrderID"].ToString();
        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }

    [WebMethod(EnableSession = true)]
    public void SetSessionVariable(string key, object value)
    {
        HttpContext.Current.Session[key] = value;
        //  string asdf = System.Web.HttpContext.Current.Session["OrderID"].ToString();
        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }

    [WebMethod(EnableSession = true)]
    public void ClearSessionVariable(string key)
    {
        System.Web.HttpContext.Current.Session.Remove(key);
        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }

    [WebMethod(EnableSession = true)]
    public void ClearALLSessionVariable()
    {
        System.Web.HttpContext.Current.Session.Clear();
        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }

    [WebMethod(EnableSession = true)]
    public int GetSessionVariable(string key)
    {
        if (System.Web.HttpContext.Current.Session[key] != null)
        {
            string i = System.Web.HttpContext.Current.Session[key].ToString();
            return Convert.ToInt32(i.ToString());
        }
        else
        {
            return 0;
        }

        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }
    [WebMethod(EnableSession = true)]
    public string GetSessionVariableCart(string key)
    {
        string val = string.Empty;
        if (System.Web.HttpContext.Current.Session[key] != null)
        {
           val= System.Web.HttpContext.Current.Session[key].ToString();
           
        }
        return val;
       
        // return System.Web.HttpContext.Current.Session["MySessionObject"] = "OderID";
    }
    #endregion

    #region StoreSettingImplementation
    [WebMethod]
    public decimal GetTotalCartItemPrice(int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsScalar<decimal>("usp_ASPX_GetCartItemsTotalAmount", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public int GetCompareItemsCount(int storeID, int portalID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsScalar<int>("usp_ASPX_GetCompareItemsCount", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckAddressAlreadyExist(int storeID, int portalID, int customerID, string sessionCode)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", customerID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", sessionCode));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteNonQueryAsGivenType<bool>("usp_ASPX_CheckForMultipleAddress", ParaMeter, "@IsExist");

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
    #endregion

    [WebMethod]
    public List<PortalUserRoleListInfo> GetAllPortalUserList(int StoreID,int PortalID)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));

            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<PortalUserRoleListInfo>("usp_ASPX_GetPortalUserList", ParaMeter);

        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    #region "Currency conversion"

    [WebMethod]
    public List<CurrencyInfo> BindCurrencyList(int StoreID, int PortalID, string CultureName)
    {
        try
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));

            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CurrencyInfo>("usp_ASPX_BindCurrencyList", ParaMeter);
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


    [WebMethod]
    public double GetCurrencyRate(string from, string to)
    {
        try
        {
            double result = 0.0;
            result = CurrencyConverter.CurrencyConverter.GetRate(from, to);
            return result;
        }
        catch (Exception)
        {
            return 1;

        }
    }

    #endregion

    [WebMethod]
    public bool CheckCatalogPriorityUniqueness(int CatalogPriceRuleID, int Priority, int StoreID, int PortalID)
    {
        try
        {
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CatalogPriceRuleID", CatalogPriceRuleID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Priority", Priority));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            return Sq.ExecuteNonQueryAsBool("[usp_ASPX_CatalogPriorityUniquenessCheck]", ParaMeterCollection, "@IsUnique");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }

    [WebMethod]
    public bool CheckCartPricePriorityUniqueness(int @CartPriceRuleID, int Priority, int PortalID)
    {
        try
        {
            SQLHandler Sq = new SQLHandler();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@CartPriceRuleID", @CartPriceRuleID));
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@Priority", Priority));          
            ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            return Sq.ExecuteNonQueryAsBool("[usp_ASPX_CartPricePriorityUniquenessCheck]", ParaMeterCollection, "@IsUnique");
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}

