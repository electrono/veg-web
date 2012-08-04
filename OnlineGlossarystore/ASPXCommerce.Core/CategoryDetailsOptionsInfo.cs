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
    public class CategoryDetailsOptionsInfo
    {

        private System.Nullable<int> _CategoryID;

        private System.Nullable<int> _ParentID;

        private string _Path;

        private System.Nullable<bool> _IsRootCategory;

        private System.Nullable<int> _PortalID;

        private System.Nullable<int> _StoreID;

        private string _CategoryName;

        private string _CategoryImage;

        private System.Nullable<int> _ItemID;

        private string _SKU;

        private System.Nullable<int> _ItemTypeID;

        private string _ItemTypeName;

        private System.Nullable<int> _AttributeSetID;

        private string _AttributeSetName;

        private string _Name;

        private string _Price;

        private string _ListPrice;

        private string _Quantity;

        private string _Visibility;

        private string _Description;

        private string _ShortDescription;

        private System.Nullable<bool> _IsOutOfStock;

        private string _IsFeatured;

        private string _BaseImage;

        private System.Nullable<System.DateTime> _ItemAddedOn;

        private System.Nullable<bool> _IsActiveItem;

        public CategoryDetailsOptionsInfo()
        {
        }

        [DataMember]
        public System.Nullable<int> CategoryID
        {
            get
            {
                return this._CategoryID;
            }
            set
            {
                if ((this._CategoryID != value))
                {
                    this._CategoryID = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> ParentID
        {
            get
            {
                return this._ParentID;
            }
            set
            {
                if ((this._ParentID != value))
                {
                    this._ParentID = value;
                }
            }
        }

        [DataMember]
        public string Path
        {
            get
            {
                return this._Path;
            }
            set
            {
                if ((this._Path != value))
                {
                    this._Path = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<bool> IsRootCategory
        {
            get
            {
                return this._IsRootCategory;
            }
            set
            {
                if ((this._IsRootCategory != value))
                {
                    this._IsRootCategory = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
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

        [DataMember]
        public string CategoryName
        {
            get
            {
                return this._CategoryName;
            }
            set
            {
                if ((this._CategoryName != value))
                {
                    this._CategoryName = value;
                }
            }
        }

        [DataMember]
        public string CategoryImage
        {
            get
            {
                return this._CategoryImage;
            }
            set
            {
                if ((this._CategoryImage != value))
                {
                    this._CategoryImage = value;
                }
            }
        }

        [DataMember]
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
        public System.Nullable<int> ItemTypeID
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

        [DataMember]
        public string ItemTypeName
        {
            get
            {
                return this._ItemTypeName;
            }
            set
            {
                if ((this._ItemTypeName != value))
                {
                    this._ItemTypeName = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> AttributeSetID
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

        [DataMember]
        public string AttributeSetName
        {
            get
            {
                return this._AttributeSetName;
            }
            set
            {
                if ((this._AttributeSetName != value))
                {
                    this._AttributeSetName = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
        public string Visibility
        {
            get
            {
                return this._Visibility;
            }
            set
            {
                if ((this._Visibility != value))
                {
                    this._Visibility = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
        public string BaseImage
        {
            get
            {
                return this._BaseImage;
            }
            set
            {
                if ((this._BaseImage != value))
                {
                    this._BaseImage = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<System.DateTime> ItemAddedOn
        {
            get
            {
                return this._ItemAddedOn;
            }
            set
            {
                if ((this._ItemAddedOn != value))
                {
                    this._ItemAddedOn = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<bool> IsActiveItem
        {
            get
            {
                return this._IsActiveItem;
            }
            set
            {
                if ((this._IsActiveItem != value))
                {
                    this._IsActiveItem = value;
                }
            }
        }
    }
}

