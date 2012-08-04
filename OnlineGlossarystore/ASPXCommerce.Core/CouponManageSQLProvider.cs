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
using SageFrame.Web.Utilities;
using SageFrame.Web;
using SageFrame.SageFrameClass.MessageManagement;
using System.Collections;

namespace ASPXCommerce.Core
{
    public class CouponManageSQLProvider
    {
        public List<CouponInfo> BindAllCouponDetails(int offset, int limit, System.Nullable<int> couponTypeId, string couponCode, System.Nullable<DateTime> validateFrom, System.Nullable<DateTime> validateTo, int storeId, int portalId, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponTypeID", couponTypeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@ValidateFrom", validateFrom));
            ParaMeter.Add(new KeyValuePair<string, object>("@ValidateTo", validateTo));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeId));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalId));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponInfo>("usp_ASPX_GetCouponDetails", ParaMeter);
        }

        public List<CouponPortalUserListInfo> GetPortalUsersList(int offset, int limit, int couponID, int storeID, int portalID, string customerName, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponID", couponID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CustomerName", customerName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CouponPortalUserListInfo>("usp_ASPX_GetAllPortalUserLists", ParaMeter);
        }

        public void AddUpdateCoupons(int couponID, int couponTypeID, string couponCode, string couponAmount, string validateFrom, string validateTo,
        string isActive, int storeID, int portalID, string cultureName, string userName, string settingIDs, string settingValues, string portalUser_UserName)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponID", couponID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponTypeID", couponTypeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponAmount", couponAmount));
                ParaMeter.Add(new KeyValuePair<string, object>("@ValidateFrom", validateFrom));
                ParaMeter.Add(new KeyValuePair<string, object>("@ValidateTo", validateTo));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsActive", isActive));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeter.Add(new KeyValuePair<string, object>("@SettingIDs", settingIDs));
                ParaMeter.Add(new KeyValuePair<string, object>("@SettingValues", settingValues));
                ParaMeter.Add(new KeyValuePair<string, object>("@portalUser_UserName", portalUser_UserName));
                SQLHandler sqLH = new SQLHandler();
                sqLH.ExecuteNonQuery("usp_ASPX_AddUpdateCoupons", ParaMeter);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public List<CouponStatusInfo> BindCouponStatus()
        {
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponStatusInfo>("usp_ASPX_GetCouponStatus");
        }

        public List<CouponSettingKeyValueInfo> GetCouponSettingKeyValueInfo(int couponID, int storeID, int portalID)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponID", couponID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            SQLHandler sqLH = new SQLHandler();
            return sqLH.ExecuteAsList<CouponSettingKeyValueInfo>("usp_ASPX_GetCouponSettingKeyValueByCouponID", ParaMeter);
        }

        public void DeleteCoupons(string couponIDs, int storeID, int portalID, string userName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponID", couponIDs));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqLH = new SQLHandler();
            sqLH.ExecuteNonQuery("usp_ASPX_DeleteCoupons", ParaMeter);
        }

        public CouponVerificationInfo VerifyUserCoupon(decimal totalCost, string couponCode, int storeID, int portalID, string userName, int appliedCount)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@totalCost", totalCost));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@AppliedCount", appliedCount));            
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsObject<CouponVerificationInfo>("[usp_ASPX_VerifyCouponCode]",ParaMeter);
        }

        public void UpdateCouponUserRecord(string CouponCode, int storeID, int portalID, string userName)
        {
            if (System.Web.HttpContext.Current.Session["CouponApplied"] != null)
            {
                int ac =int.Parse( System.Web.HttpContext.Current.Session["CouponApplied"].ToString());
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", CouponCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponUsedCount", ac));
                SQLHandler sqlH = new SQLHandler();
                sqlH.ExecuteNonQuery("usp_ASPX_UpdateCouponUserRecord", ParaMeter);
            }
        }
     
        public List<CouponUserInfo> GetCouponUserDetails(int offset, int limit, string couponCode, string userName, System.Nullable<int> couponStatusId, System.Nullable<DateTime> validFrom, System.Nullable<DateTime> validTo, int storeID, int portalID, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponStatusID", couponStatusId));
            ParaMeter.Add(new KeyValuePair<string, object>("@ValidFrom", validFrom));
            ParaMeter.Add(new KeyValuePair<string, object>("@ValidTo", validTo));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CouponUserInfo>("usp_ASPX_CouponUserDetails", ParaMeter);
        }

        public List<CouponUserListInfo> GetCouponUserList(int offset, int limit, int CouponID, string couponCode, string UserName, System.Nullable<int> CouponStatusID, int storeID, int portalID, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@offset", offset));
            ParaMeter.Add(new KeyValuePair<string, object>("@limit", limit));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponID", CouponID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", couponCode));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", UserName));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponStatusID", CouponStatusID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            return sqlH.ExecuteAsList<CouponUserListInfo>("[usp_ASPX_GetCouponUserList]", ParaMeter);
        }


        public void DeleteCouponUser(string couponUserID, int storeID, int portalID, string userName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponUserID", couponUserID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_DeleteCouponUser", ParaMeter);
        }
        public void UpdateCouponUser(int couponUserID,int couponStatusID, int storeID, int portalID, string cultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponUserID", couponUserID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CouponStatusID", couponStatusID));
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_UpdateCouponUser", ParaMeter);
        }

        public void SendCouponCodeEmail(string SenderEmail, string ReceiverEmailDs, string Subject,ArrayList MessageBody)
        {
            string[] receiverIDs;
            char[] spliter = { '#' };
            receiverIDs = ReceiverEmailDs.Split(spliter);

            for (int i = 0; i < receiverIDs.Length; i++)
            {
                string receiverEmailID = receiverIDs[i];
                string emailSuperAdmin;
                string emailSiteAdmin;
                SageFrameConfig pagebase = new SageFrameConfig();
                emailSuperAdmin =pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);
                emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
              string individualMsgBody = MessageBody[i].ToString();
              MailHelper.SendMailNoAttachment(SenderEmail, receiverEmailID, Subject, individualMsgBody, emailSiteAdmin, emailSuperAdmin);
            }
        }
    }
}
