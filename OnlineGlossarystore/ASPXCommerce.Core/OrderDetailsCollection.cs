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

namespace ASPXCommerce.Core
{
   public class OrderDetailsCollection
   {
       #region Private Members

       private OrderDetailsInfo _objOrderDetails;
       private PaymentInfo _objPaymentInfo;
       private userAddressInfo _objBillingAddressInfo;
       private userAddressInfo _objShippingAddressInfo;
       private List<OrderItemInfo> _lstOrderItemsInfo;
       private CommonInfo _objCommonInfo;

       #endregion

       #region Public Members

       public OrderDetailsInfo objOrderDetails
       {
           get
           {
               return this._objOrderDetails;
           }
           set
           {
               if ((this._objOrderDetails != value))
               {
                   this._objOrderDetails = value;
               }
           }
       }

       public PaymentInfo objPaymentInfo
       {
           get
           {
               return this._objPaymentInfo;
           }
           set
           {
               if ((this._objPaymentInfo != value))
               {
                   this._objPaymentInfo = value;
               }
           }
       }

       public userAddressInfo objBillingAddressInfo
       {
           get
           {
               return this._objBillingAddressInfo;
           }
           set
           {
               if ((this._objBillingAddressInfo != value))
               {
                   this._objBillingAddressInfo = value;
               }
           }
       }

       public userAddressInfo objShippingAddressInfo
       {
           get
           {
               return this._objShippingAddressInfo;
           }
           set
           {
               if ((this._objShippingAddressInfo != value))
               {
                   this._objShippingAddressInfo = value;
               }
           }
       }

       public List<OrderItemInfo> lstOrderItemsInfo
       {
           get
           {
               return this._lstOrderItemsInfo;
           }
           set
           {
               if ((this._lstOrderItemsInfo != value))
               {
                   this._lstOrderItemsInfo = value;
               }
           }
       }

       public CommonInfo objCommonInfo
       {
           get
           {
               return this._objCommonInfo;
           }
           set
           {
               if ((this._objCommonInfo != value))
               {
                   this._objCommonInfo = value;
               }
           }
       }

       #endregion
   }
}
