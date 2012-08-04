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
{[Serializable]
    [DataContract]
    public class CartInfo
    {
        [DataMember]
        private int _CartID;
        [DataMember]
        private int _ItemTypeID;

        [DataMember]
        private int _CartItemID;

        [DataMember]
        private string _SKU;

        [DataMember]
        private System.Nullable<int> _ItemID;

        [DataMember]
        private string _ItemName;

        [DataMember]
        private string _ImagePath;

        [DataMember]
        private string _AlternateText;

        [DataMember]
        private System.Nullable<decimal> _Price;

        [DataMember]
        private System.Nullable<int> _Quantity;

        [DataMember]
        private System.Nullable<int> _ItemQuantity;

        [DataMember]
        private System.Nullable<decimal> _Weight;

        [DataMember]
        private System.Nullable<decimal> _TaxRateValue;

        [DataMember]
        private string _ShortDescription;

        [DataMember]
        private string _CostVariants;

        [DataMember]
        private System.Nullable<decimal>  _TotalItemCost;

        [DataMember]
        private string _Remarks;

        [DataMember]
        private string _SessionCode;

        [DataMember]
        private string _CostVariantsValueIDs;

        [DataMember]
        private string _UserName;

        [DataMember]
        private System.Nullable<int> _StoreID;

        [DataMember]
        private System.Nullable<int> _PortalID;

        public CartInfo()
        {
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
        public int CartID
        {
            get
            {
                return this._CartID;
            }
            set
            {
                if ((this._CartID != value))
                {
                    this._CartID = value;
                }
            }
        }

        public int CartItemID
        {
            get
            {
                return this._CartItemID;
            }
            set
            {
                if ((this._CartItemID != value))
                {
                    this._CartItemID = value;
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

        public System.Nullable<int> ItemID
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
        public System.Nullable<int> Quantity
        {
            get
            {
                return this._Quantity;
            }
            set
            {
                if((this._Quantity != value))
                {
                    this._Quantity=value;
                }
            }
        }

        public System.Nullable<int> ItemQuantity
        {
            get
            {
                return this._ItemQuantity;
            }
            set
            {
                if ((this._ItemQuantity != value))
                {
                    this._ItemQuantity = value;
                }
            }
        }

        public System.Nullable<decimal> Weight
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

        public System.Nullable<decimal> TaxRateValue
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

        public string CostVariants
        {
            get
            {
                return this._CostVariants;
            }
            set
            {
                if ((this._CostVariants != value))
                {
                    this._CostVariants = value;
                }
            }
        }

        public System.Nullable<decimal> TotalItemCost
        {
            get
            {
                return this._TotalItemCost;
            }
            set
            {
                if ((this._TotalItemCost != value))
                {
                    this._TotalItemCost = value;
                }
            }
        }
        public string Remarks
        {
            get
            {
                return this._Remarks;
            }
            set
            {
                if ((this._Remarks != value))
                {
                    this._Remarks = value;
                }
            }
        }

        public string SessionCode
        {
            get
            {
                return this._SessionCode;
            }
            set
            {
                if ((this._SessionCode != value))
                {
                    this._SessionCode = value;
                }
            }
        }

        public string CostVariantsValueIDs
        {
            get
            {
                return this._CostVariantsValueIDs;
            }
            set
            {
                if ((this._CostVariantsValueIDs != value))
                {
                    this._CostVariantsValueIDs = value;
                }
            }
        }

        public string UserName
        {
            get
            {
                return this._UserName;
            }
            set
            {
                if ((this._UserName != value))
                {
                    this._UserName = value;
                }
            }
        }

        public System.Nullable<int> StoreID
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

        public System.Nullable<int> PortalID
        {
            get
            {
                return this._PortalID;
            }
            set
            {
                if ((this._PortalID != value))
                {
                    this._PortalID = value;
                }
            }
        }
    }
}

