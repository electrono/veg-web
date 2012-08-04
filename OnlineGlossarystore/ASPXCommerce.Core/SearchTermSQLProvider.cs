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

namespace ASPXCommerce.Core
{
  public  class SearchTermSQLProvider
    {
      public List<SearchTermInfo> ManageSearchTerm(int offset, int limit, int storeID, int portalID, string cultureName,string searchTerm)
      {
          List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
          ParaMeter.Add(new KeyValuePair<string, object>("@Offset", offset));
          ParaMeter.Add(new KeyValuePair<string, object>("@Limit", limit));
          ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
          ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
          ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
          ParaMeter.Add(new KeyValuePair<string, object>("@SearchTerm", searchTerm));
          SQLHandler sqLH = new SQLHandler();
          return sqLH.ExecuteAsList<SearchTermInfo>("usp_ASPX_GetSearchTermDetails", ParaMeter);
      }
      public void DeleteSearchTerm(string Ids, int storeID, int portalID,string userName, string cultureName)
      {
          List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
          ParaMeter.Add(new KeyValuePair<string, object>("@SearchTermID", Ids));
          ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
          ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
          ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
          ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
          SQLHandler sqLH = new SQLHandler();
          sqLH.ExecuteNonQuery("usp_ASPX_DeleteSearchTerm", ParaMeter);
      }
      public List<SearchTermInfo> GetSearchStatistics(int count, string commandName, int storeID, int portalID, string cultureName)
      {
          List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
          ParaMeter.Add(new KeyValuePair<string, object>("@Count", count));
          ParaMeter.Add(new KeyValuePair<string, object>("@CommandName", commandName));
          ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
          ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
          ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
          SQLHandler sqLH = new SQLHandler();
          return sqLH.ExecuteAsList<SearchTermInfo>("usp_ASPX_GetSearchTermStatistics", ParaMeter);
      }
      public void AddUpdateSearchTerm(string searchTerm, int storeID, int portalID, string userName, string cultureName)
      {
          List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
          ParaMeter.Add(new KeyValuePair<string, object>("@SearchTerm", searchTerm));
          ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", storeID));
          ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", portalID));
          ParaMeter.Add(new KeyValuePair<string, object>("@UserName", userName));
          ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", cultureName));
          SQLHandler sqlh = new SQLHandler();
          sqlh.ExecuteNonQuery("usp_ASPX_AddUpdateSearchTerm", ParaMeter);
      }
    }
   
}
