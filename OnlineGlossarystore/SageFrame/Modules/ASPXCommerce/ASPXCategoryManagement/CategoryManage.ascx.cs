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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using ASPXCommerce.Core;

public partial class Modules_ASPXCategoryManagement_CategoryManage : BaseAdministrationUserControl
{
    public int storeID, portalID;
    public string userName, cultureName;
    public int categoryLargeThumbImage, categoryMediumThumbImage, categorySmallThumbImage;
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
                categoryLargeThumbImage = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.CategoryLargeThumbnailImageSize, storeID, portalID, cultureName));
                categoryMediumThumbImage = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.CategoryMediumThumbnailImageSize, storeID, portalID, cultureName));
                categorySmallThumbImage = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.CategorySmallThumbnailImageSize, storeID, portalID, cultureName));
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            string modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "globalVariables", " var aspxCatModulePath='" + ResolveUrl(modulePath) + "';", true);
            InitializeJS();
            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/TreeView/ui.tree.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/JQueryUI/jquery.ui.all.css");
            foreach (string css in cssList)
            {
                strTemplatePath = css;
                IncludeCssFile(strTemplatePath);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("jquery", ResolveUrl("~/js/jquery-1.3.2.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryUI", ResolveUrl("~/js/JQueryUI/jquery-ui-1.8.10.custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("J1", ResolveUrl("~/js/TreeView/jquery.tree.ui.core.js"));
        Page.ClientScript.RegisterClientScriptInclude("J6", ResolveUrl("~/js/TreeView/ui.tree.js"));
        Page.ClientScript.RegisterClientScriptInclude("J7", ResolveUrl("~/js/TreeView/jquery.json-2.2.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryFormValidate", ResolveUrl("~/js/FormValidation/jquery.form-validation-and-hints.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAjaxUploader", ResolveUrl("~/js/AjaxFileUploader/ajaxupload.js"));
        Page.ClientScript.RegisterClientScriptInclude("J11", ResolveUrl("~/Editors/ckeditor/ckeditor.js"));
        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
        Page.ClientScript.RegisterClientScriptInclude("jQueryCalenderValid", ResolveUrl("~/js/FormValidation/jquery.ui.datepicker.validation.js"));
    }
}