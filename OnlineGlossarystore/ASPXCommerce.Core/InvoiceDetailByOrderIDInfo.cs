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
    public class InvoiceDetailByorderIDInfo
    {
        private System.Nullable<int> _OrderID;
        private string _OrderDate;
        private System.Nullable<int> _AddressID;

        private string _BillingName;

        private string _Email;

        private string _Company;

        private string _Address1;

        private string _Address2;

        private string _City;

        private string _State;

        private string _Zip;

        private string _Country;

        private string _Phone;

        private string _Mobile;

        private string _Fax;

        private string _Website;

        private string _StoreName;

        private string _StoreDescription;

        private string _ShippingName;

        private string _ShipEmail;

        private string _ShipCompany;

        private string _shipAddress1;

        private string _shipAddress2;

        private string _shipCity;

        private string _shipState;

        private string _shipZip;

        private string _ShipCountry;

        private string _shipPhone;

        private string _shipMobile;

        private string _shipFax;

        private string _shipWebsite;

        private string _ShippingMethodName;

        private string _PaymentMethodName;

        private string _OrderStatusName;
        private string _ItemName;

        private System.Nullable<decimal> _ShippingCost;

        private System.Nullable<int> _ItemId;

        private System.Nullable<int> _Quantity;

        private System.Nullable<decimal> _Price;

        private System.Nullable<decimal> _TaxTotal;

        private System.Nullable<decimal> _CouponAmount;
        private System.Nullable<decimal> _SubTotal;
        private System.Nullable<bool> _IsMultipleShipping;
        private System.Nullable<decimal> _GrandTotal;
        private System.Nullable<decimal> _GrandSubTotal;
        private System.Nullable<decimal> _TotalShippingCost;
        private System.Nullable<decimal> _DiscountAmount;
        private string _costVariants;


        public InvoiceDetailByorderIDInfo()
        {
        }

        [DataMember]
        public System.Nullable<int> OrderID
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
        
        [DataMember]
        public string OrderDate
        {
            get
            {
                return this._OrderDate;
            }
            set
            {
                if ((this._OrderDate != value))
                {
                    this._OrderDate = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> AddressID
        {
            get
            {
                return this._AddressID;
            }
            set
            {
                if ((this._AddressID != value))
                {
                    this._AddressID = value;
                }
            }
        }

        [DataMember]
        public string BillingName
        {
            get
            {
                return this._BillingName;
            }
            set
            {
                if ((this._BillingName != value))
                {
                    this._BillingName = value;
                }
            }
        }

        [DataMember]
        public string Email
        {
            get
            {
                return this._Email;
            }
            set
            {
                if ((this._Email != value))
                {
                    this._Email = value;
                }
            }
        }

        [DataMember]
        public string Company
        {
            get
            {
                return this._Company;
            }
            set
            {
                if ((this._Company != value))
                {
                    this._Company = value;
                }
            }
        }

        [DataMember]
        public string Address1
        {
            get
            {
                return this._Address1;
            }
            set
            {
                if ((this._Address1 != value))
                {
                    this._Address1 = value;
                }
            }
        }

        [DataMember]
        public string Address2
        {
            get
            {
                return this._Address2;
            }
            set
            {
                if ((this._Address2 != value))
                {
                    this._Address2 = value;
                }
            }
        }

        [DataMember]
        public string City
        {
            get
            {
                return this._City;
            }
            set
            {
                if ((this._City != value))
                {
                    this._City = value;
                }
            }
        }

        [DataMember]
        public string State
        {
            get
            {
                return this._State;
            }
            set
            {
                if ((this._State != value))
                {
                    this._State = value;
                }
            }
        }

        [DataMember]
        public string Zip
        {
            get
            {
                return this._Zip;
            }
            set
            {
                if ((this._Zip != value))
                {
                    this._Zip = value;
                }
            }
        }

        [DataMember]
        public string Country
        {
            get
            {
                return this._Country;
            }
            set
            {
                if ((this._Country != value))
                {
                    this._Country = value;
                }
            }
        }

        [DataMember]
        public string Phone
        {
            get
            {
                return this._Phone;
            }
            set
            {
                if ((this._Phone != value))
                {
                    this._Phone = value;
                }
            }
        }

        [DataMember]
        public string Mobile
        {
            get
            {
                return this._Mobile;
            }
            set
            {
                if ((this._Mobile != value))
                {
                    this._Mobile = value;
                }
            }
        }

        [DataMember]
        public string Fax
        {
            get
            {
                return this._Fax;
            }
            set
            {
                if ((this._Fax != value))
                {
                    this._Fax = value;
                }
            }
        }

        [DataMember]
        public string Website
        {
            get
            {
                return this._Website;
            }
            set
            {
                if ((this._Website != value))
                {
                    this._Website = value;
                }
            }
        }

        [DataMember]
        public string StoreName
        {
            get
            {
                return this._StoreName;
            }
            set
            {
                if ((this._StoreName != value))
                {
                    this._StoreName = value;
                }
            }
        }

        [DataMember]
        public string StoreDescription
        {
            get
            {
                return this._StoreDescription;
            }
            set
            {
                if ((this._StoreDescription != value))
                {
                    this._StoreDescription = value;
                }
            }
        }

        [DataMember]
        public string ShippingName
        {
            get
            {
                return this._ShippingName;
            }
            set
            {
                if ((this._ShippingName != value))
                {
                    this._ShippingName = value;
                }
            }
        }

        [DataMember]
        public string ShipEmail
        {
            get
            {
                return this._ShipEmail;
            }
            set
            {
                if ((this._ShipEmail != value))
                {
                    this._ShipEmail = value;
                }
            }
        }

        [DataMember]
        public string ShipCompany
        {
            get
            {
                return this._ShipCompany;
            }
            set
            {
                if ((this._ShipCompany != value))
                {
                    this._ShipCompany = value;
                }
            }
        }

        [DataMember]
        public string shipAddress1
        {
            get
            {
                return this._shipAddress1;
            }
            set
            {
                if ((this._shipAddress1 != value))
                {
                    this._shipAddress1 = value;
                }
            }
        }

        [DataMember]
        public string shipAddress2
        {
            get
            {
                return this._shipAddress2;
            }
            set
            {
                if ((this._shipAddress2 != value))
                {
                    this._shipAddress2 = value;
                }
            }
        }

        [DataMember]
        public string shipCity
        {
            get
            {
                return this._shipCity;
            }
            set
            {
                if ((this._shipCity != value))
                {
                    this._shipCity = value;
                }
            }
        }

        [DataMember]
        public string shipState
        {
            get
            {
                return this._shipState;
            }
            set
            {
                if ((this._shipState != value))
                {
                    this._shipState = value;
                }
            }
        }

        [DataMember]
        public string shipZip
        {
            get
            {
                return this._shipZip;
            }
            set
            {
                if ((this._shipZip != value))
                {
                    this._shipZip = value;
                }
            }
        }

        [DataMember]
        public string ShipCountry
        {
            get
            {
                return this._ShipCountry;
            }
            set
            {
                if ((this._ShipCountry != value))
                {
                    this._ShipCountry = value;
                }
            }
        }

        [DataMember]
        public string shipPhone
        {
            get
            {
                return this._shipPhone;
            }
            set
            {
                if ((this._shipPhone != value))
                {
                    this._shipPhone = value;
                }
            }
        }

        [DataMember]
        public string shipMobile
        {
            get
            {
                return this._shipMobile;
            }
            set
            {
                if ((this._shipMobile != value))
                {
                    this._shipMobile = value;
                }
            }
        }

        [DataMember]
        public string shipFax
        {
            get
            {
                return this._shipFax;
            }
            set
            {
                if ((this._shipFax != value))
                {
                    this._shipFax = value;
                }
            }
        }

        [DataMember]
        public string shipWebsite
        {
            get
            {
                return this._shipWebsite;
            }
            set
            {
                if ((this._shipWebsite != value))
                {
                    this._shipWebsite = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
        public string PaymentMethodName
        {
            get
            {
                return this._PaymentMethodName;
            }
            set
            {
                if ((this._PaymentMethodName != value))
                {
                    this._PaymentMethodName = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
        public System.Nullable<int> ItemId
        {
            get
            {
                return this._ItemId;
            }
            set
            {
                if ((this._ItemId != value))
                {
                    this._ItemId = value;
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
        public System.Nullable<int> Quantity
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
        public System.Nullable<decimal> Price
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
        public System.Nullable<decimal> TaxTotal
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
        public System.Nullable<decimal> CouponAmount
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
        public System.Nullable<decimal> SubTotal
        {
            get
            {
                return this._SubTotal;
            }
            set
            {
                if ((this._SubTotal != value))
                {
                    this._SubTotal = value;
                }
            }
        }


        [DataMember]
        public System.Nullable<decimal> ShippingCost
        {
            get
            {
                return this._ShippingCost;
            }
            set
            {
                if ((this._ShippingCost != value))
                {
                    this._ShippingCost = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
        public System.Nullable<decimal> GrandTotal
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
        public System.Nullable<decimal> GrandSubTotal
        {
            get
            {
                return this._GrandSubTotal;
            }
            set
            {
                if ((this._GrandSubTotal != value))
                {
                    this._GrandSubTotal = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<decimal> TotalShippingCost
        {
            get
            {
                return this._TotalShippingCost;
            }
            set
            {
                if ((this._TotalShippingCost != value))
                {
                    this._TotalShippingCost = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<decimal> DiscountAmount
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
    }  
}
