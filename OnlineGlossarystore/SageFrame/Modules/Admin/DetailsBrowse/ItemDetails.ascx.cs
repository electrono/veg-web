using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SageFrame.Web;
using System.Collections;
using SageFrame.Framework;
using System.Web.Security;
using SageFrame;
using SageFrame.Web.Utilities;
using SageFrame.Web.Common.SEO;
using ASPXCommerce.Core;

public partial class Modules_ASPXDetails__ASPXItemDetails_ItemDetails : BaseAdministrationUserControl
{
    public string itemSKU;
    public int itemID;
    public string itemName;
    public int storeID, portalID, UserModuleID, customerID, minimumItemQuantity, maximumItemQuantity, maxCompareItemCount,relatedItemsCount;
    public string userName, cultureName;
    public string userEmail = string.Empty;
    //public string attributeSetId;
    //public string itemTypeId;
    public string userIP;
    public string countryName = string.Empty;
    public string sessionCode = string.Empty;
    //public string userEmail = string.Empty;
    public string aspxfilePath;
    public string noItemDetailImagePath, enableEmailFriend,allowAnonymousReviewRate,allowOutStockPurchase, allowWishListItemDetail, allowCompareItemDetail;
    public bool IsUseFriendlyUrls = true;
    //public string costVariantData = string.Empty;   

    protected void page_init(object sender, EventArgs e)
    {
        // modulePath = ResolveUrl(this.AppRelativeTemplateSourceDirectory);
        ////This is for Download file Path  
        aspxfilePath = ResolveUrl("~") + "Modules/ASPXCommerce/ASPXItemsManagement/"; 

        try
        {
            SageFrameConfig pagebase = new SageFrameConfig();
            IsUseFriendlyUrls = pagebase.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);
            SageFrameRoute parentPage = (SageFrameRoute)this.Page;

            itemSKU = parentPage.Key;//Request.QueryString["itemId"];
            //itemName = "item3"; //Request.QueryString["itemName"];

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
                OverRideSEOInfo(itemSKU, storeID, portalID, userName, cultureName);
                userIP = HttpContext.Current.Request.UserHostAddress;
                IPAddressToCountryResolver ipToCountry = new IPAddressToCountryResolver();
                ipToCountry.GetCountry(userIP, out countryName);

                if (Membership.GetUser() != null)
                {
                    MembershipUser userDetail = Membership.GetUser(GetUsername);
                    userEmail = userDetail.Email;
                }

				noItemDetailImagePath = StoreSetting.GetStoreSettingValueByKey(StoreSetting.DefaultProductImageURL, storeID, portalID, cultureName);
				enableEmailFriend = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableEmailAFriend, storeID, portalID, cultureName);
            	allowAnonymousReviewRate = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowAnonymousUserToWriteItemRatingAndReviews, storeID, portalID, cultureName);
                minimumItemQuantity = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MinimumItemQuantity, storeID, portalID, cultureName));
                maximumItemQuantity=Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MaximumItemQuantity,storeID,portalID,cultureName));
                allowOutStockPurchase = StoreSetting.GetStoreSettingValueByKey(StoreSetting.AllowOutStockPurchase, storeID, portalID, cultureName);
                maxCompareItemCount = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.MaxNoOfItemsToCompare, storeID, portalID, cultureName));
                relatedItemsCount = Convert.ToInt32(StoreSetting.GetStoreSettingValueByKey(StoreSetting.NoOfRelatedCartItems, storeID, portalID, cultureName));
                allowWishListItemDetail = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableWishList, storeID, portalID, cultureName);
                allowCompareItemDetail = StoreSetting.GetStoreSettingValueByKey(StoreSetting.EnableCompareItems, storeID, portalID, cultureName);
            }
           
            if (SageUserModuleID != "")
            {
                UserModuleID = int.Parse(SageUserModuleID);
            }
            else
            {
                UserModuleID = 0;
            }

            InitializeJS();

            string strTemplatePath = "";
            ArrayList cssList = new ArrayList();
            cssList.Add("~/Templates/" + TemplateName + "/css/ImageGallery/styles.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/ImageGallery/jquery.gzoom.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/PopUp/style.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/StarRating/jquery.rating.css");
            cssList.Add("~/Templates/" + TemplateName + "/css/JQueryUIFront/jquery.ui.all.css");
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

    private void OverRideSEOInfo(string itemSKU, int storeID, int portalID, string userName, string cultureName)
    {
        ItemSEOInfo dtItemSEO = GetSEOSettingsBySKU(itemSKU, storeID, portalID, userName, cultureName);
         if (dtItemSEO != null)
         {
             itemID = int.Parse(dtItemSEO.ItemID.ToString());
             itemName = dtItemSEO.Name.ToString();
             string PageTitle = dtItemSEO.MetaTitle.ToString();
             string PageKeyWords = dtItemSEO.MetaKeywords.ToString();
             string PageDescription = dtItemSEO.MetaDescription.ToString();           

             if (!string.IsNullOrEmpty(PageTitle))
                 SEOHelper.RenderTitle(this.Page, PageTitle, false, true, this.GetPortalID);

             if (!string.IsNullOrEmpty(PageKeyWords))
                 SEOHelper.RenderMetaTag(this.Page, "KEYWORDS", PageKeyWords, true);

             if (!string.IsNullOrEmpty(PageDescription))
                 SEOHelper.RenderMetaTag(this.Page, "DESCRIPTION", PageDescription, true);
         }
    }

    public ItemSEOInfo GetSEOSettingsBySKU(string itemSKU, int storeID, int portalID, string userName, string cultureName)
    {
        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
        ParaMeter.Add(new KeyValuePair<string, object>("@itemSKU", itemSKU));
        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        ParaMeter.Add(new KeyValuePair<string, object>("@Username", userName));
        ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
        SQLHandler sqLH = new SQLHandler();
        return sqLH.ExecuteAsObject <ItemSEOInfo>("usp_ASPX_ItemsSEODetailsBySKU", ParaMeter);
    }

    protected void Page_Load(object sender, EventArgs e)
    {        
       
    }

    private void InitializeJS()
    {
        Page.ClientScript.RegisterClientScriptInclude("JQueryGallery1", ResolveUrl("~/js/ImageGallery/jquery.pikachoose.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryGallery2", ResolveUrl("~/js/ImageGallery/jquery.gzoom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryGallery3", ResolveUrl("~/js/ImageGallery/jquery.mousewheel.js"));

        Page.ClientScript.RegisterClientScriptInclude("JQueryUICustomA2", ResolveUrl("~/js/JQueryUI/jquery-ui-1.8.10.custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("JDownload", ResolveUrl("~/js/jDownload/jquery.jdownload.js"));
        //Page.ClientScript.RegisterClientScriptInclude("JQueryAlertEase", ResolveUrl("~/js/MessageBox/jquery.easing.1.3.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryAlert", ResolveUrl("~/js/MessageBox/alertbox.js"));  

        Page.ClientScript.RegisterClientScriptInclude("JQueryUIDate", ResolveUrl("~/js/DateTime/date.js"));

        Page.ClientScript.RegisterClientScriptInclude("J12", ResolveUrl("~/js/encoder.js"));
        Page.ClientScript.RegisterClientScriptInclude("PopUp", ResolveUrl("~/js/PopUp/custom.js"));
        Page.ClientScript.RegisterClientScriptInclude("FormValidate", ResolveUrl("~/js/FormValidation/jquery.validate.js"));

        Page.ClientScript.RegisterClientScriptInclude("rating", ResolveUrl("~/js/StarRating/jquery.rating.js"));
        Page.ClientScript.RegisterClientScriptInclude("pack", ResolveUrl("~/js/StarRating/jquery.rating.pack.js"));
        Page.ClientScript.RegisterClientScriptInclude("metadata", ResolveUrl("~/js/StarRating/jquery.MetaData.js"));
        Page.ClientScript.RegisterClientScriptInclude("Paging", ResolveUrl("~/js/Paging/jquery.pagination.js"));

        Page.ClientScript.RegisterClientScriptInclude("JQueryCurrencyFormat", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency-1.4.0.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQueryRegionAll", ResolveUrl("~/js/CurrencyFormat/jquery.formatCurrency.all.js"));
        Page.ClientScript.RegisterClientScriptInclude("JQuerySession", ResolveUrl("~/js/Session.js"));

    }
}
