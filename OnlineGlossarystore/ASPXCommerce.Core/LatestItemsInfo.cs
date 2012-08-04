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
    public class LatestItemsInfo
    {
        #region Constructor
        public LatestItemsInfo()
        {
        }
        #endregion

        #region Private Fields
        [DataMember]
        private int _ItemID;

        [DataMember]
        private int _AttributeSetID;

        [DataMember]
        private int _ItemTypeID;

        [DataMember]
        private System.Nullable<System.DateTime> _DateFrom;

        [DataMember]
        private System.Nullable<System.DateTime> _DateTo;

        [DataMember]
        private System.Nullable<bool> _IsFeatured;

        [DataMember]
        private string _SKU;

        [DataMember]
        private string _Name;

        [DataMember]
        private decimal _Price;

        [DataMember]
        private decimal _ListPrice;

        [DataMember]
        private int _Quantity;

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

        public int AttributeSetID
        {
            get
            {
                return this._AttributeSetID;
            }
            set
            {
                if ((this._AttributeSetID != value))
                {
                    this._AttributeSetID = value;
                }
            }
        }

        public int ItemTypeID
        {
            get
            {
                return this._ItemTypeID;
            }
            set
            {
                if ((this._ItemTypeID != value))
                {
                    this._ItemTypeID = value;
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

        public System.Nullable<bool> IsFeatured
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

        public decimal ListPrice
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
        #endregion
    }
}
