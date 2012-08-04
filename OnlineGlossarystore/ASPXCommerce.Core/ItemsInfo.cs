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
using System.Text;
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
    public class ItemsInfo
    {
        #region Constructor
        public ItemsInfo()
        {
        }
        #endregion

        #region Private Fields
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ID", Order = 1)]
        private int _ID;

        [DataMember(Name = "_ItemID", Order = 2)]
        private int _ItemID;

        [DataMember(Name = "_SKU", Order = 3)]
        private string _SKU;

        [DataMember(Name = "_Name", Order = 4)]
        private string _Name;

        [DataMember(Name = "_ItemTypeID", Order = 5)]
        private int _ItemTypeID;

        [DataMember(Name = "_ItemTypeName", Order = 6)]
        private string _ItemTypeName;

        [DataMember(Name = "_AttributeSetID", Order = 7)]
        private int _AttributeSetID;

        [DataMember(Name = "_AttributeSetName", Order = 8)]
        private string _AttributeSetName;

        [DataMember(Name = "_Price", Order = 9)]
        private string _Price;

        [DataMember(Name = "_ListPrice", Order = 10)]
        private string _ListPrice;

        [DataMember(Name = "_Quantity", Order = 11)]
        private string _Quantity;

        [DataMember(Name = "_Visibility", Order = 12)]
        private string _Visibility;

        [DataMember(Name = "_Status", Order = 13)]
        private string _Status;


        [DataMember(Name = "_AddedOn", Order = 14)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_IsChecked", Order = 15)]
        private System.Nullable<bool> _IsChecked;
        #endregion

        #region Public Fields
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

        public int ID
        {
            get
            {
                return this._ID;
            }
            set
            {
                if ((this._ID != value))
                {
                    this._ID = value;
                }
            }
        }

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

        public string Status
        {
            get
            {
                return this._Status;
            }
            set
            {
                if ((this._Status != value))
                {
                    this._Status = value;
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

        public System.Nullable<bool> IsChecked
        {
            get
            {
                return this._IsChecked;
            }
            set
            {
                if ((this._IsChecked != value))
                {
                    this._IsChecked = value;
                }
            }
        }

        #endregion
    }
}