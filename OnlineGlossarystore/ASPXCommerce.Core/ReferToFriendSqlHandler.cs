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

namespace ASPXCommerce.Core
{
    public class ReferToFriendSqlHandler
    {
        public void SaveEmailMessage(int storeID, int portalID, int itemID, string senderName, string senderEmail, string receiverName, string receiverEmail, string subject, string message)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", itemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderName", senderName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderEmail", senderEmail));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReceiverName", receiverName));
            ParaMeter.Add(new KeyValuePair<string, object>("@Receiveremail", receiverEmail));
            ParaMeter.Add(new KeyValuePair<string, object>("@Subject", subject));
            ParaMeter.Add(new KeyValuePair<string, object>("@Message", message));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("usp_ASPX_SaveMessage", ParaMeter);

        }

        public void SendEmail(string senderEmail, string receiverEmail, string subject, string message)
        {
            string emailSuperAdmin;
            string emailSiteAdmin;
            SageFrameConfig pagebase = new SageFrameConfig();
            emailSuperAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);
            emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
            MailHelper.SendMailNoAttachment(senderEmail, receiverEmail, subject, message, emailSiteAdmin, emailSuperAdmin);
        }
        public void SaveShareWishListEmailMessage(int StoreID, int PortalID, string ItemID, string SenderName, string SenderEmail, string receiverEmailID, string Subject, string message, string CultureName)
        {
            List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
            ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", StoreID));
            ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", PortalID));
            ParaMeter.Add(new KeyValuePair<string, object>("@ItemIDs", ItemID));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderName", SenderName));
            ParaMeter.Add(new KeyValuePair<string, object>("@SenderEmail", SenderEmail));
            ParaMeter.Add(new KeyValuePair<string, object>("@ReceiverEmailID", receiverEmailID));
            ParaMeter.Add(new KeyValuePair<string, object>("@Subject", Subject));
            ParaMeter.Add(new KeyValuePair<string, object>("@Message", message));
            ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", CultureName));
            SQLHandler sqlH = new SQLHandler();
            sqlH.ExecuteNonQuery("[usp_ASPX_SaveShareWishListEmail]", ParaMeter);

        }

        public void SendShareWishItemEmail(string SenderEmail, string ReceiverEmailDs, string Subject, string Message)
        {
            string[] receiverIDs;
            char[] spliter = {','};
            receiverIDs = ReceiverEmailDs.Split(spliter);

            for (int i = 0; i < receiverIDs.Length; i++)
            {
                string receiverEmailID= receiverIDs[i];
                string emailSuperAdmin;
                string emailSiteAdmin;
                SageFrameConfig pagebase = new SageFrameConfig();
                emailSuperAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);
                emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
                MailHelper.SendMailNoAttachment(SenderEmail, receiverEmailID, Subject, Message, emailSiteAdmin, emailSuperAdmin);
            }
        }
    }
}
