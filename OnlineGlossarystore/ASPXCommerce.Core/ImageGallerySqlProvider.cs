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
using SageFrame.Shared;
using SageFrameClass;
using SageFrame;
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
    public class ImageGallerySqlProvider
    {
        /// <summary>
        /// Saves the Image Gallery keys Settings values
        /// </summary>
        /// <param name="SettingKeys"></param>
        /// <param name="SettingsValues"></param>
        /// <param name="portalID"></param>
        /// <param name="UserModuleID"></param>
        public void SaveGallerySettings(string SettingKeys, string SettingsValues, string UserModuleID, string PortalID, string culture)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserModuleID", UserModuleID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SettingKeys", SettingKeys));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@SettingValues", SettingsValues));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Culture", culture));
                SQLHandler sagesql = new SQLHandler();
                sagesql.ExecuteNonQuery("[dbo].[usp_aspx_InsertUpdateSettingsItemsGallery]", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }


        public ImageGalleryInfo GetGallerySettingValues(int UserModuleID, int PortalID, string culture)
        {
            ImageGalleryInfo infoObject = new ImageGalleryInfo();
            List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
            try
            {
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserModuleID", UserModuleID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Culture", culture));
                SQLHandler sagesql = new SQLHandler();
                infoObject = sagesql.ExecuteAsObject<ImageGalleryInfo>("[dbo].[usp_aspx_GetGallerySettings]", ParaMeterCollection);
                return infoObject;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ImageGalleryItemsInfo> GetItemInfoList(int StoreID, int PortalID, string culture)
        {
            List<ImageGalleryItemsInfo> itemsInfoList = new List<ImageGalleryItemsInfo>();
            List<KeyValuePair<string, object>> paramCollection = new List<KeyValuePair<string, object>>();
            paramCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            paramCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            paramCollection.Add(new KeyValuePair<string, object>("@Culture", culture));
            SQLHandler sageSql = new SQLHandler();
            itemsInfoList = sageSql.ExecuteAsList<ImageGalleryItemsInfo>("[dbo].[usp_aspx_GalleryItemsInfo]", paramCollection);
            return itemsInfoList;
        }

        public List<ImageGalleryItemsInfo> GetItemsImageGalleryList(int StoreID, int PortalID, string userName, string culture)
        {
            List<ImageGalleryItemsInfo> itemsInfoList = new List<ImageGalleryItemsInfo>();
            List<KeyValuePair<string, object>> paramCollection = new List<KeyValuePair<string, object>>();
            paramCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            paramCollection.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            paramCollection.Add(new KeyValuePair<string, object>("@Username", userName));
            paramCollection.Add(new KeyValuePair<string, object>("@Culture", culture));
            SQLHandler sageSql = new SQLHandler();
            itemsInfoList = sageSql.ExecuteAsList<ImageGalleryItemsInfo>("[dbo].[usp_aspx_ItemsImageGalleryInfo]", paramCollection);
            return itemsInfoList;
        }

        public List<ItemsInfoSettings> GetItemsImageGalleryInfoByItemSKU(string itemSKU, int storeID, int portalID)
        {
            List<ItemsInfoSettings> itemsInfoContainer = new List<ItemsInfoSettings>();
            SQLHandler sageSql = new SQLHandler();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@ItemSKU", itemSKU));
            paramCol.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            paramCol.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            itemsInfoContainer = sageSql.ExecuteAsList<ItemsInfoSettings>("[dbo].[usp_aspx_GetImageInformationsBySKU]", paramCol);
            return itemsInfoContainer;
        }

        public List<ItemsInfoSettings> GetItemsImageGalleryInfoByItemID(int itemID)
        {
            List<ItemsInfoSettings> itemsInfoContainer = new List<ItemsInfoSettings>();
            SQLHandler sageSql = new SQLHandler();
            List<KeyValuePair<string, object>> paramCol = new List<KeyValuePair<string, object>>();
            paramCol.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            itemsInfoContainer = sageSql.ExecuteAsList<ItemsInfoSettings>("[dbo].[usp_aspx_GetImageInformationsByItemID]", paramCol);
            return itemsInfoContainer;
        }
    }
}
