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
    public class GetOrderdetailsByPaymentGatewayIDInfo
    {
       
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;
        [DataMember(Name = "_PaymentGatewayTypeID", Order = 1)]
        private int _PaymentGatewayTypeID;

        [DataMember(Name = "_OrderID", Order = 2)]
        private int _OrderID;

        [DataMember(Name = "_StoreID", Order = 3)]
        private int _StoreID;

        [DataMember(Name = "_AddedOn", Order = 4)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_BillToName", Order = 5)]
        private string _BillToName;

        [DataMember(Name = "_ShipToName", Order = 6)]
        private string _ShipToName;

        [DataMember(Name = "_GrandTotal", Order = 7)]
        private decimal _GrandTotal;

        [DataMember(Name = "_OrderStatusName", Order = 8)]
        private string _OrderStatusName;
        [DataMember(Name = "_IsMultipleShipping", Order = 9)]
        private System.Nullable<bool> _IsMultipleShipping;
        
        public GetOrderdetailsByPaymentGatewayIDInfo()
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

        public int PaymentGatewayTypeID
        {
            get
            {
                return this._PaymentGatewayTypeID;
            }
            set
            {
                if ((this._PaymentGatewayTypeID != value))
                {
                    this._PaymentGatewayTypeID = value;
                }
            }
        }

        public int OrderID
        {
            get
            {
                return this._OrderID;
            }
            set
            {
                if ((this._OrderID != value))
                {
                    this._OrderID = value;
                }
            }
        }

        public int StoreID
        {
            get
            {
                return this._StoreID;
            }
            set
            {
                if ((this._StoreID != value))
                {
                    this._StoreID = value;
                }
            }
        }

        public System.Nullable<System.DateTime> AddedOn
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

        public string BillToName
        {
            get
            {
                return this._BillToName;
            }
            set
            {
                if ((this._BillToName != value))
                {
                    this._BillToName = value;
                }
            }
        }

        public string ShipToName
        {
            get
            {
                return this._ShipToName;
            }
            set
            {
                if ((this._ShipToName != value))
                {
                    this._ShipToName = value;
                }
            }
        }

        public decimal GrandTotal
        {
            get
            {
                return this._GrandTotal;
            }
            set
            {
                if ((this._GrandTotal != value))
                {
                    this._GrandTotal = value;
                }
            }
        }
        public string OrderStatusName
        {
            get
            {
                return this._OrderStatusName;
            }
            set
            {
                if ((this._OrderStatusName != value))
                {
                    this._OrderStatusName = value;
                }
            }
        }

        public System.Nullable<bool> IsMultipleShipping
        {
            get
            {
                return this._IsMultipleShipping;
            }
            set
            {
                if ((this._IsMultipleShipping != value))
                {
                    this._IsMultipleShipping = value;
                }
            }
        }
    }
}
