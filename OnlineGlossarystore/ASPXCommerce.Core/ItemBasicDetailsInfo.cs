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
    public class ItemBasicDetailsInfo
    {
        #region Constructor
        public ItemBasicDetailsInfo()
        {
        }
        #endregion

        #region Private Fields
        [DataMember]
        private int _ItemID;

        [DataMember]
        private System.Nullable<System.DateTime> _DateFrom;

        [DataMember]
        private System.Nullable<System.DateTime> _DateTo;

        [DataMember]
        private string  _IsFeatured;

        [DataMember]
        private string _SKU;

        [DataMember]
        private string _Name;

        [DataMember]
        private string _Description;

        [DataMember]
        private string _ShortDescription;

        [DataMember]
        private int _Quantity;

        [DataMember]
        private string _Price;

        [DataMember]
        private string _Weight;

        [DataMember]
        private string _ListPrice;

        [DataMember]
        private System.Nullable<bool> _HidePrice;

        [DataMember]
        private System.Nullable<bool> _HideInRSSFeed;

        [DataMember]
        private System.Nullable<bool> _HideToAnonymous;

        [DataMember]
        private System.Nullable<bool> _IsOutOfStock;
        
        [DataMember]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember]
        private string _ImagePath;

        [DataMember]
        private string _AlternateText;

        [DataMember]
        private int _TaxRuleID;

        [DataMember]
        private string _TaxRateValue;

        [DataMember]
        private string _SampleLink;

        [DataMember]
        private string _SampleFile;

        [DataMember]
        private string _DiscountPrice;
        #endregion

        #region Public Fields     

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

        public System.Nullable<System.DateTime> DateFrom
        {
            get
            {
                return this._DateFrom;
            }
            set
            {
                if ((this._DateFrom != value))
                {
                    this._DateFrom = value;
                }
            }
        }

        public System.Nullable<System.DateTime> DateTo
        {
            get
            {
                return this._DateTo;
            }
            set
            {
                if ((this._DateTo != value))
                {
                    this._DateTo = value;
                }
            }
        }

        public string IsFeatured
        {
            get
            {
                return this._IsFeatured;
            }
            set
            {
                if ((this._IsFeatured != value))
                {
                    this._IsFeatured = value;
                }
            }
        }

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

        public string Name
        {
            get
            {
                return this._Name;
            }
            set
            {
                if ((this._Name != value))
                {
                    this._Name = value;
                }
            }
        }

        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                if ((this._Description != value))
                {
                    this._Description = value;
                }
            }
        }

        public string ShortDescription
        {
            get
            {
                return this._ShortDescription;
            }
            set
            {
                if ((this._ShortDescription != value))
                {
                    this._ShortDescription = value;
                }
            }
        }

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

        public string Price
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

        public string Weight
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

        public string ListPrice
        {
            get
            {
                return this._ListPrice;
            }
            set
            {
                if ((this._ListPrice != value))
                {
                    this._ListPrice = value;
                }
            }
        }

        public System.Nullable<bool> HidePrice
        {
            get
            {
                return this._HidePrice;
            }
            set
            {
                if ((this._HidePrice != value))
                {
                    this._HidePrice = value;
                }
            }
        }

        public System.Nullable<bool> HideInRSSFeed
        {
            get
            {
                return this._HideInRSSFeed;
            }
            set
            {
                if ((this._HideInRSSFeed != value))
                {
                    this._HideInRSSFeed = value;
                }
            }
        }

        public System.Nullable<bool> HideToAnonymous
        {
            get
            {
                return this._HideToAnonymous;
            }
            set
            {
                if ((this._HideToAnonymous != value))
                {
                    this._HideToAnonymous = value;
                }
            }
        }

        public System.Nullable<bool> IsOutOfStock
        {
            get
            {
                return this._IsOutOfStock;
            }
            set
            {
                if ((this._IsOutOfStock != value))
                {
                    this._IsOutOfStock = value;
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

        public string ImagePath
        {
            get
            {
                return this._ImagePath;
            }
            set
            {
                if ((this._ImagePath != value))
                {
                    this._ImagePath = value;
                }
            }
        }

        public string AlternateText
        {
            get
            {
                return this._AlternateText;
            }
            set
            {
                if ((this._AlternateText != value))
                {
                    this._AlternateText = value;
                }
            }
        }

        public int TaxRuleID
        {
            get
            {
                return this._TaxRuleID;
            }
            set
            {
                if ((this._TaxRuleID != value))
                {
                    this._TaxRuleID = value;
                }
            }
        }

        public string TaxRateValue
        {
            get
            {
                return this._TaxRateValue;
            }
            set
            {
                if ((this._TaxRateValue != value))
                {
                    this._TaxRateValue = value;
                }
            }
        }

        public string SampleLink
        {
            get
            {
                return this._SampleLink;
            }
            set
            {
                if ((this._SampleLink != value))
                {
                    this._SampleLink = value;
                }
            }
        }

        public string SampleFile
        {
            get
            {
                return this._SampleFile;
            }
            set
            {
                if ((this._SampleFile != value))
                {
                    this._SampleFile = value;
                }
            }
        }

         public string DiscountPrice
        {
            get
            {
                return this._DiscountPrice;
            }
            set
            {
                if ((this._DiscountPrice != value))
                {
                    this._DiscountPrice = value;
                }
            }
        }

        #endregion
    }
}
