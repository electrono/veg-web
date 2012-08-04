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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame;
using SageFrameClass;
using SageFrame.Web.Utilities;
using SageFrame.Common;
using SageFrame.Web.Common;
using SageFrame.Web;
using System.Text;

public partial class Modules_CategoryLister_CategoryViewer : BaseAdministrationUserControl
{
    public int storeID, portalID;
    public string userName, cultureName;
    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            IncludeScriptFile("~/js/jquery.cookie.js");
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                userName = GetUsername;
                cultureName = GetCurrentCultureName;
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    //protected void BindCategory()
    //{
    //    int PortalID = GetPortalID;
    //    int StoreID = 1;
    //    string cultureName = GetCurrentCultureName;
    //    CategoryHandler catHdlr = new CategoryHandler();
    //    List<CategoryInfo> catInfo = new List<CategoryInfo>();
    //    catInfo = catHdlr.GetCategoryMenuList(StoreID, PortalID, cultureName);
    //    int categoryID;
    //    int parentID;
    //    int categoryLevel;
    //    string path;
    //    string attributeValue;
    //    StringBuilder catListmaker = new StringBuilder();
    //    string catList = string.Empty;
    //    //string path = string.Empty;
    //    catListmaker.Append("<div class=\"cssClassNavigation\">");
    //    foreach (CategoryInfo eachCat in catInfo)
    //    {
    //        categoryID = eachCat.CategoryID;
    //        parentID = eachCat.ParentID;
    //        categoryLevel = int.Parse(eachCat.CategoryLevel.ToString());
    //        path = string.Empty;
    //        attributeValue = eachCat.AttributeValue;
    //        if (eachCat.CategoryLevel == 0)
    //        {
    //            catListmaker.Append("<ul><li><a href=\"" + attributeValue + ".aspx\">");
    //            catListmaker.Append(eachCat.AttributeValue);
    //            catListmaker.Append("</a>");
    //            if (eachCat.ChildCount > 0)
    //            {
    //                catListmaker.Append("<ul>");
    //                itemPath += eachCat.AttributeValue;
    //                catListmaker.Append(BindChildCategory(catInfo, categoryID));
    //                catListmaker.Append("</ul>");
    //            }
    //            catListmaker.Append("</li></ul>");
    //        }
    //        itemPath = string.Empty;
    //    }
    //    catListmaker.Append("<div class=\"cssClassclear\"></div></div>");
    //    ltrlCategryLister.Text = catListmaker.ToString();
    //}

    //private string BindChildCategory(List<CategoryInfo> catInfo, int categoryID)
    //{
    //    string strListmaker = string.Empty;
    //    string childNodes = string.Empty;
    //    string path = string.Empty;
    //    itemPath += "/";
    //    foreach (CategoryInfo eachCat in catInfo)
    //    {
    //        if (eachCat.CategoryLevel > 0)
    //        {
    //            if (eachCat.ParentID == categoryID)
    //            {
    //                itemPath += eachCat.AttributeValue;
    //                strListmaker += "<li><a href=\"" + itemPath + ".aspx\">" + eachCat.AttributeValue + "</a>";
    //                childNodes = BindChildCategory(catInfo, eachCat.CategoryID);
    //                itemPath = itemPath.Remove(itemPath.LastIndexOf(eachCat.AttributeValue));
    //                if (childNodes != string.Empty)
    //                {
    //                    strListmaker += "<ul>" + childNodes + "</ul>";
    //                }
    //                strListmaker += "</li>";
    //            }
    //        }
    //    }
    //    return strListmaker;
    //}
}
