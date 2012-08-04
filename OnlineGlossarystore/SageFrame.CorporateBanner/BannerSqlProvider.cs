using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using SageFrame.Web.Utilities;
using SageFrame.Core.Pages;

namespace SageFrame.CorporateBanner
{
    public class BannerSqlProvider
    {
        //BannerInfo bannerObj = new BannerInfo(); 

        public List<BannerInfo> GetAllCorporateBanners(int UserModuleID, int PortalID, bool showInActive)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserModuleID", UserModuleID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ShowInActive", showInActive));
                SQLHandler objsql = new SQLHandler();
                return objsql.ExecuteAsList<BannerInfo>("[dbo].[usp_CorporateBannersGetAll]", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        //public sp_PagePortalGetByCustomPrefixResult GetAllPagesLists(string prefix, System.Nullable<bool>  isActive, System.Nullable<bool>  isDeleted, System.Nullable<int> portalID, string username, System.Nullable<bool> isVisible, System.Nullable<bool> isRequiredPage)
        //{
        //    try
        //    {
        //        List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@prefix", prefix));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", isActive));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsDeleted", isDeleted));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalID));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@Username", username));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsVisible", isVisible));
        //        ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsRequiredPage", isRequiredPage));
        //        SQLHandler objsql = new SQLHandler();
        //        return objsql.ExecuteAsObject<sp_PagePortalGetByCustomPrefixResult>("[dbo].[sp_PagePortalGetByCustomPrefix]", ParaMeterCollection);
        //    }
        //    catch (Exception e)
        //    {
        //        throw e;
        //    }
        //}

        public BannerInfo GetCorporateBannerDetailsByBannerID(int BannerID, int PortalID)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@BannerID", BannerID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                SQLHandler objsql = new SQLHandler();
                return objsql.ExecuteAsObject<BannerInfo>("[dbo].[usp_CorporateBannerGetByBannerID]", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void CorporateBannerDeleteByBannerID(int BannerID, int PortalID, string UserName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@BannerID", BannerID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
                SQLHandler objsql = new SQLHandler();
                objsql.ExecuteNonQuery("[dbo].[usp_CorporateBannerDeleteByBannerID]", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }

        public void CorporateBannerAddUpdate(int BannerID, int UserModuleID, string Title, string Description, string NavigationTitle, string NavigationImage, int BannerOrder, string BannerImage, string ImageToolTip, string ReadButtonText, string ReadMorePageName, bool IsActive, DateTime AddedOn, int PortalID, string UserName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@BannerID", BannerID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserModuleID", UserModuleID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Title", Title));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@Description", Description));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@NavigationTitle", NavigationTitle));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@NavigationImage", NavigationImage));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@BannerOrder", BannerOrder));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@BannerImage", BannerImage));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ImageToolTip", ImageToolTip));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ReadButtonText", ReadButtonText));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@ReadMorePage", ReadMorePageName));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@IsActive", IsActive));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@AddedOn", AddedOn));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
                ParaMeterCollection.Add(new KeyValuePair<string, object>("@UserName", UserName));
                SQLHandler objsql = new SQLHandler();
                objsql.ExecuteNonQuery("[dbo].[usp_CorporateBannerAddUpdate]", ParaMeterCollection);
            }
            catch (Exception e)
            {
                throw e;
            }
        }
    }
}
