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
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
    public class CouponPerSales
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_couponCode", Order = 1)]
        private string _couponCode;

        [DataMember(Name = "_UseCount", Order = 2)]
        private int _UseCount;

        [DataMember(Name = "_TotalAmountDiscountedbyCoupon", Order = 3)]
        private System.Nullable<decimal> _TotalAmountDiscountedbyCoupon;

        [DataMember(Name = "_TotalSalesAmount", Order = 4)]
        private System.Nullable<decimal> _TotalSalesAmount;


        public CouponPerSales()
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

        public string couponCode
        {
            get
            {
                return this._couponCode;
            }
            set
            {
                if ((this._couponCode != value))
                {
                    this._couponCode = value;
                }
            }
        }

        public int UseCount
        {
            get
            {
                return this._UseCount;
            }
            set
            {
                if ((this._UseCount != value))
                {
                    this._UseCount = value;
                }
            }
        }

        public System.Nullable<decimal> TotalAmountDiscountedbyCoupon
        {
            get
            {
                return this._TotalAmountDiscountedbyCoupon;
            }
            set
            {
                if ((this._TotalAmountDiscountedbyCoupon != value))
                {
                    this._TotalAmountDiscountedbyCoupon = value;
                }
            }
        }

        public System.Nullable<decimal> TotalSalesAmount
        {
            get
            {
                return this._TotalSalesAmount;
            }
            set
            {
                if ((this._TotalSalesAmount != value))
                {
                    this._TotalSalesAmount = value;
                }
            }
        }
    }
}
