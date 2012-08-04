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
    public class ShipmentsDetailsViewInfo
    {
        private int _ShippingMethodID;
        private string _ShippingMethod;
        private string _ItemName;
        private string _SKU;
        private decimal _Price;
        private int _Quantity;
        private int _Weight;
        private decimal _DiscountAmount;
        private decimal _CouponAmount;
        private decimal _TaxTotal;
        private decimal _ShippingRate;
        private decimal _GrandTotal;
        private string _ShippingAddress;
        private string _ShipmentDate;
        private decimal _TotalCoupon;
        private decimal _TotalShippingRate;
        private string _costVariants;
        public ShipmentsDetailsViewInfo()
        {
        }
        [DataMember]
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
        [DataMember]
        public string CostVariants
        {
            get
            {
                return this._costVariants;
            }
            set
            {
                if ((this._costVariants != value))
                {
                    this._costVariants = value;
                }
            }
        }

        [DataMember]
        public string ShippingMethod
        {
            get
            {
                return this._ShippingMethod;
            }
            set
            {
                if ((this._ShippingMethod != value))
                {
                    this._ShippingMethod = value;
                }
            }
        }
        [DataMember]
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

        [DataMember]
        public string SKU
        {
            get
            {
                return this._SKU;
            }
            set
            {
                if ((this._SKU != value))
                {
                    this._SKU = value;
                }
            }
        }

        [DataMember]
        public decimal Price
        {
            get
            {
                return this._Price;
            }
            set
            {
                if ((this._Price != value))
                {
                    this._Price = value;
                }
            }
        }

        [DataMember]
        public int Quantity
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

        [DataMember]
        public int Weight
        {
            get
            {
                return this._Weight;
            }
            set
            {
                if ((this._Weight != value))
                {
                    this._Weight = value;
                }
            }
        }
        [DataMember]
        public decimal DiscountAmount
        {
            get
            {
                return this._DiscountAmount;
            }
            set
            {
                if ((this._DiscountAmount != value))
                {
                    this._DiscountAmount = value;
                }
            }
        }
        [DataMember]
        public decimal CouponAmount
        {
            get
            {
                return this._CouponAmount;
            }
            set
            {
                if ((this._CouponAmount != value))
                {
                    this._CouponAmount = value;
                }
            }
        }
        [DataMember]
        public decimal TaxTotal
        {
            get
            {
                return this._TaxTotal;
            }
            set
            {
                if ((this._TaxTotal != value))
                {
                    this._TaxTotal = value;
                }
            }
        }

        [DataMember]
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
        [DataMember]
        public decimal ShippingRate
        {
            get
            {
                return this._ShippingRate;
            }
            set
            {
                if ((this._ShippingRate != value))
                {
                    this._ShippingRate = value;
                }
            }
        }

        [DataMember]
        public string ShippingAddress
        {
            get
            {
                return this._ShippingAddress;
            }
            set
            {
                if ((this._ShippingAddress != value))
                {
                    this._ShippingAddress = value;
                }
            }
        }
        [DataMember]
        public string ShipmentDate
        {
            get
            {
                return this._ShipmentDate;
            }
            set
            {
                if((this._ShipmentDate!=value))
                {
                    this._ShipmentDate=value;
                }
            }
        }

        [DataMember]
        public decimal TotalCoupon
        {
            get
            {
                return this._TotalCoupon;
            }
            set
            {
                if ((this._TotalCoupon != value))
                {
                    this._TotalCoupon = value;
                }
            }
        }
        [DataMember]
        public decimal TotalShippingRate
        {
            get
            {
                return this._TotalShippingRate;
            }
            set
            {
                if ((this._TotalShippingRate != value))
                {
                    this._TotalShippingRate = value;
                }
            }
        }
    }
}
