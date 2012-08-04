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
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
   public class OrderItemsGroupByItemIDInfo
   {
       #region constructor
       public OrderItemsGroupByItemIDInfo()
        {
        }
       #endregion
       #region Private Members
       [DataMember(Name = "_RowTotal", Order = 0)]
       private System.Nullable<int> _RowTotal;

       [DataMember(Name = "_ItemID", Order = 1)]
       private int _ItemID;

       [DataMember(Name = "_ItemName", Order = 2)]
       private string _ItemName;

       [DataMember(Name = "_Quantity", Order = 5)]
       private string _Quantity;
       #endregion
       #region Public Members

       public System.Nullable<int> RowTotal
       {
           get
           {
               return this._RowTotal;
           }
           set
           {
               if ((this._RowTotal != value))
               {
                   this._RowTotal = value;
               }
           }
       }

       public int ItemID
       {
           get
           {
               return this._ItemID;
           }
           set
           {
               if ((this._ItemID != value))
               {
                   this._ItemID = value;
               }
           }
       }

       public string ItemName
       {
           get
           {
               return this._ItemName;
           }
           set
           {
               if ((this._ItemName != value))
               {
                   this._ItemName = value;
               }
           }
       }

       public string Quantity
       {
           get
           {
               return this._Quantity;
           }
           set
           {
               if ((this._Quantity != value))
               {
                   this._Quantity = value;
               }
           }
       }


       #endregion
   }
}
