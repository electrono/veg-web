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
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{
   public class CustomerManagementSQLProvider
    {
       public void DeleteMultipleCustomers(string CustomerIDs, int storeId, int portalId, string userName)
       {
           try
           {
               List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@CustomerIDs", CustomerIDs));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));
              
              
               SQLHandler Sq = new SQLHandler();
               Sq.ExecuteNonQuery("dbo.usp_ASPX_CustomerDeleteMultipleSelected", ParaMeterCollection);
           }
           catch (Exception e)
           {
               throw e;
           }
       }
       public void DeleteCustomer(int customerId, int storeId, int portalId, string userName)
       {
           try
           {
               List<KeyValuePair<string, object>> ParaMeterCollection = new List<KeyValuePair<string, object>>();
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@CustomerID", customerId));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@StoreID", storeId));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@PortalID", portalId));
               ParaMeterCollection.Add(new KeyValuePair<string, object>("@DeletedBy", userName));


               SQLHandler Sq = new SQLHandler();
               Sq.ExecuteNonQuery("[dbo].[usp_ASPX_DeleteCustomerByCustomerID]", ParaMeterCollection);
           }
           catch (Exception e)
           {
               throw e;
           }


       }


    }
}
