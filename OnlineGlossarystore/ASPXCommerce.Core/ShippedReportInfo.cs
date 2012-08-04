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
    public class ShippedReportInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ShippingMethodIDID", Order = 1)]
        private  int _ShippingMethodID;

        [DataMember(Name = "_ShippingMethodName", Order = 2)]
        private string _ShippingMethodName;

        [DataMember(Name = "_NumberOfOrders", Order = 3)]
        private int _NumberOfOrders;

        [DataMember(Name = "_TotalShipping", Order = 4)]
        private int _TotalShipping;

        [DataMember(Name = "_AddedOn", Order = 5)]
        private string _AddedOn;

        public ShippedReportInfo()
        {
        }
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
        public int ShippingMethodID
        {
            get
            {
                return this._ShippingMethodID;
            }
            set
            {
                if ((this._ShippingMethodID != value))
                {
                    this._ShippingMethodID = value;
                }
            }
        }


        public string ShippingMethodName
        {
            get
            {
                return this._ShippingMethodName;
            }
            set
            {
                if ((this._ShippingMethodName != value))
                {
                    this._ShippingMethodName = value;
                }
            }
        }

        public int NumberOfOrders
        {
            get
            {
                return this._NumberOfOrders;
            }
            set
            {
                if ((this._NumberOfOrders != value))
                {
                    this._NumberOfOrders = value;
                }
            }
        }

        public int TotalShipping
        {
            get
            {
                return this._TotalShipping;
            }
            set
            {
                if ((this._TotalShipping != value))
                {
                    this._TotalShipping = value;
                }
            }
        }
        public string AddedOn
        {
            get
            {
                return this._AddedOn;
            }
            set
            {
                if ((this._AddedOn != value))
                {
                    this._AddedOn = value;
                }
            }
        }
    }
}
