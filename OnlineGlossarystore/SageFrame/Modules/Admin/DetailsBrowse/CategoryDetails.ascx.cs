using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using SageFrame;
using SageFrame.Framework;
using SageFrame.Web.Common.SEO;
using SageFrame.Web.Utilities;
using ASPXCommerce.Core;

public partial class Modules_ASPXDetails_ASPXCategoryDetails_CategoryDetails : BaseAdministrationUserControl
{
    public int storeID, portalID, customerID;
    public string userName, cultureName;
    public string userIP;
    public string countryName = string.Empty;
    public string sessionCode = string.Empty;
    //public string categoryName = "";
    public string categorykey = "";
    public string noImageCategoryDetailPath, allowOutStockPurchase, allowWishListCategory;
    protected void page_init(object sender, EventArgs e)
    {
        try
        {
            // categoryId = "";// Int32.Parse(Request.QueryString["catId"]);
            // categoryName = ""; // Request.QueryString["catName"];
            SageFrameRoute parentPage = (SageFrameRoute)this.Page;
            categorykey = parentPage.Key;
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
                OverRideSEOInfo(categorykey, storeID, portalID, userName, cultureName);

                userIP = HttpContext.Current.Request.UserHostAddress;
                IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
                ipToCountry.GetCountry(userIP, out countryName);
				noImageCategoryDetailPath = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
                allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
                allowWishListCategory = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList,storeID,portalID,cultureName);
            }
            
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

    private void OverRideSEOInfo(string categorykey, int storeID, int portalID, string userName, string cultureName)
    {
        CategorySEOInfo dtCatSEO = GetSEOSettingsByCategoryName(categorykey, storeID, portalID, userName, cultureName);
        if (dtCatSEO != null)
        {
            string PageTitle = dtCatSEO.MetaTitle.ToString();
            string PageKeyWords = dtCatSEO.MetaKeywords.ToString();
            string PageDescription = dtCatSEO.MetaDescription.ToString();

            if (!string.IsNullOrEmpty(PageTitle))
                SEOHelper.RenderTitle(this.Page, PageTitle, false, true, this.GetPortalID);

            if (!string.IsNullOrEmpty(PageKeyWords))
                SEOHelper.RenderMetaTag(this.Page, "KEYWORDS", PageKeyWords, true);

            if (!string.IsNullOrEmpty(PageDescription))
                SEOHelper.RenderMetaTag(this.Page, "DESCRIPTION", PageDescription, true);
        }
    }

    private CategorySEOInfo GetSEOSettingsByCategoryName(string categorykey, int storeID, int portalID, string userName, string cultureName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@CatName", categorykey));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsObject<CategorySEOInfo>("usp_ASPX_CategorySEODetailsByCatName", ParaMeter);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));

        Page.ClientScript.RegisterClientScriptInclude("template", ResolveUrl("~/js/Templating/tmpl.js"));
        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
        Page.ClientScript.RegisterClientScriptInclude("Paging", ResolveUrl("~/js/Paging/jquery.pagination.js"));
    }
}
