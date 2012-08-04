using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using SageFrame;
using SageFrame.Framework;
using System.Collections;
using ASPXCommerce.Core;

public partial class Modules_Admin_DetailsBrowse_ItemLists : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID, categoryID;
    public string userName, cultureName, userIP, countryName;
    public string sessionCode = string.Empty;
    public string searchText = string.Empty;
    public string noImageItemListPath, allowOutStockPurchase, allowWishListItemList;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                storeID = GetStoreID;
                portalID = GetPortalID;
                customerID = GetCustomerID;
                userName = GetUsername;
                cultureName = GetCurrentCultureName;
                if (HttpContext.Current.Session.SessionID != null)
                {
                    sessionCode = HttpContext.Current.Session.SessionID.ToString();
                }

                userIP = HttpContext.Current.Request.UserHostAddress;
                IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
                ipToCountry.GetCountry(userIP, out countryName);

                categoryID = Int32.Parse(Request.QueryString["cid"]);
                searchText = Request.QueryString["q"];                
               
                noImageItemListPath = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
                allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
                allowWishListItemList = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList,storeID, portalID, cultureName);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }

    protected void page_init(object sender, EventArgs e)
    {
        try
        {
            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/MessageBox/style.css");

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
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

        //Page.ClientScript.RegisterClientScriptInclude("json2", ResolveUrl("~/js/GridView/json2.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JGrid", ResolveUrl("~/js/GridView/jquery.grid.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JSagePaging", ResolveUrl("~/js/GridView/SagePaging.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JGlobal", ResolveUrl("~/js/GridView/jquery.global.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JdateFormat", ResolveUrl("~/js/GridView/jquery.dateFormat.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JTablesorter", ResolveUrl("~/js/GridView/jquery.tablesorter.js"));
        Page.ClientScript.RegisterClientScriptInclude("template", ResolveUrl("~/js/Templating/tmpl.js"));
        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
        Page.ClientScript.RegisterClientScriptInclude("Paging", ResolveUrl("~/js/Paging/jquery.pagination.js"));
    }

}
