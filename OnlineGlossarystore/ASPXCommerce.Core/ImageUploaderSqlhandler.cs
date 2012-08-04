﻿/*
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
using System.Collections;
using System.Data;


namespace ASPXCommerce.Core
{
    public class ImageUploaderSqlhandler
    {
        public ImageUploaderSqlhandler()
        { }

        //public List<ItemsInfoSettings> ReturnItemsList(int portalID, int storeID, string userName, string culture)
        //{
        //    List<ItemsInfoSettings> itemsInfo = new List<ItemsInfoSettings>();
        //    List<KeyValuePair<string, object>> paramCollection = new List<KeyValuePair<string, object>>();
        //    paramCollection.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        //    paramCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));            
        //    paramCollection.Add(new KeyValuePair<string, object>("@UserName", userName));
        //    paramCollection.Add(new KeyValuePair<string, object>("@Culture", culture));
        //    SQLHandler sageSql = new SQLHandler();
        //    itemsInfo = sageSql.ExecuteAsList<ItemsInfoSettings>("[dbo].[usp_aspx_GetAllItemsName]", paramCollection);
        //    return itemsInfo;
        //}

        public void SaveImageSettings(int ItemID, string imgName, string isActive, string imageType, string description, string displayOrder)
        {

            List<KeyValuePair<string, object>> ParameterCollection = new List<KeyValuePair<string, object>>();

            ParameterCollection.Add(new KeyValuePair<string, object>("@ItemID", ItemID));
            ParameterCollection.Add(new KeyValuePair<string, object>("@PathList", imgName));
            ParameterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
            ParameterCollection.Add(new KeyValuePair<string, object>("@ImageType", imageType));
            ParameterCollection.Add(new KeyValuePair<string, object>("@AlternateText", description));
            ParameterCollection.Add(new KeyValuePair<string, object>("@DisplayOrder", displayOrder));

            try
            {
                SQLHandler sageSql = new SQLHandler();
                sageSql.ExecuteNonQuery("[dbo].[usp_aspx_InsertUpdateImageSettings]", ParameterCollection);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }       
    }
}
