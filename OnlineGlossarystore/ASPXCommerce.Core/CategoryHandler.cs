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
using SageFrame;
using SageFrame.Web;
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
    public class CategoryHandler
    {
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
    }
}
