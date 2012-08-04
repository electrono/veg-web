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

public partial class Modules_ASPXFrontStoreWelcome_FrontStoreWelcome : BaseAdministrationUserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Page_Init(object sender, EventArgs e)
    {
        try
        {
            //InitializeJS();

            //string strTemplatePath = "";
            //ArrayList cssList = new ArrayList();
            //cssList.Add("~/Templates/" + TemplateName + "/css/admin.css");
            //cssList.Add("~/Templates/" + TemplateName + "/css/JQueryUI.css");
            //cssList.Add("~/Templates/" + TemplateName + "/css/template.css");
            ////cssList.Add("~/Templates/" + TemplateName + "/css/GridView/tablesort.css");
            ////cssList.Add("~/Templates/" + TemplateName + "/css/TreeView/ui.tree.css");
            ////cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");            
            //foreach (string css in cssList)
            //{
            //    strTemplatePath = css;
            //    IncludeCssFile(strTemplatePath);
            //}
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    private void InitializeJS()
    {
        //Page.ClientScript.RegisterClientScriptInclude("jquery", ResolveUrl("~/js/jquery-1.4.4.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryUICustomA2", ResolveUrl("~/js/Accordin/jquery-ui-1.8.7.custom.min.js"));

        //Page.ClientScript.RegisterClientScriptInclude("json2", ResolveUrl("~/js/GridView/json2.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));

        //Page.ClientScript.RegisterClientScriptInclude("J1", ResolveUrl("~/js/TreeView/jquery.tree.ui.core.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J2", ResolveUrl("~/js/TreeView/effects.core.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J3", ResolveUrl("~/js/TreeView/effects.blind.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J4", ResolveUrl("~/js/TreeView/ui.draggable.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J5", ResolveUrl("~/js/TreeView/ui.droppable.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J6", ResolveUrl("~/js/TreeView/ui.tree.js"));

        //Page.ClientScript.RegisterClientScriptInclude("J7", ResolveUrl("~/js/TreeView/contextmenu.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J8", ResolveUrl("~/js/TreeView/putCursorAtEnd.1.0.js"));

        //Page.ClientScript.RegisterClientScriptInclude("JQueryUI", ResolveUrl("~/js/JQueryUI/jquery.ui.core.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryUICustom", ResolveUrl("~/js/JQueryUI/jquery.ui.datepicker.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));

        //Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

        //Page.ClientScript.RegisterClientScriptInclude("JQueryFormValidate", ResolveUrl("~/js/FormValidation/jquery.form-validation-and-hints.js"));

        //Page.ClientScript.RegisterClientScriptInclude("JQueryAjaxUploader", ResolveUrl("~/js/AjaxFileUploader/ajaxupload.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J9", ResolveUrl("~/Editors/ckeditor/ckeditor.js"));
        //Page.ClientScript.RegisterClientScriptInclude("J10", ResolveUrl("~/js/encoder.js"));
    }

}
