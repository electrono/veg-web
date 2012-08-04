
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
    public class CategoryInfo
    {
        private Int32 _CategoryID;
        private string _CategoryName;
        private string _LevelCategoryName;
        private Int32 _ParentID;
        private System.Nullable<Int32> _CategoryLevel;
        private string _Path;
        private System.Nullable<bool> _IsShowInSearch;
        private System.Nullable<bool> _IsShowInCatalog;
        private System.Nullable<bool> _IsShowInMenu;
        private System.Nullable<DateTime> _ActiveFrom;
        private System.Nullable<DateTime> _ActiveTo;
        private Int32 _StoreID;
        private Int32 _PortalID;
        private System.Nullable<bool> _IsActive;
        private System.Nullable<Int32> _DisplayOrder;
        private System.Nullable<bool> _IsChecked;

        private string _AttributeValue;

        private Int32 _ChildCount;

        [DataMember]
        public Int32 CategoryID
        {
            get
            {
                return this._CategoryID;
            }
            set
            {
                    this._CategoryID = value;
            }
        }

        [DataMember]
        public string CategoryName
        {
            get
            {
                return _CategoryName;
            }
            set
            {
                    _CategoryName = value;
            }
        }

        [DataMember]
        public string LevelCategoryName
        {
            get
            {
                return _LevelCategoryName;
            }
            set
            {
                _LevelCategoryName = value;
            }
        }


        [DataMember]
        public Int32 ParentID
        {
            get
            {
                return this._ParentID;
            }
            set
            {
                    this._ParentID = value;
            }
        }
        [DataMember]
        public System.Nullable<Int32> CategoryLevel
        {
            get
            {
                return this._CategoryLevel;
            }
            set
            {
                this._CategoryLevel = value;
            }
        }

        [DataMember]
        public string Path
        {
            get
            {
                return _Path;
            }
            set
            {
                _Path = value;
            }
        }
        [DataMember]
        public System.Nullable<bool> IsShowInSearch
        {
            get
            {
                return _IsShowInSearch;
            }
            set
            {
                _IsShowInSearch = value;
            }
        }

        [DataMember]
        public System.Nullable<bool> IsShowInCatalog
        {
            get
            {
                return _IsShowInCatalog;
            }
            set
            {
                _IsShowInCatalog = value;
            }
        }

        [DataMember]
        public System.Nullable<bool> IsShowInMenu
        {
            get
            {
                return _IsShowInMenu;
            }
            set
            {
                _IsShowInMenu = value;
            }
        }

        [DataMember]
        public System.Nullable<DateTime> ActiveFrom
        {
            get
            {
                return _ActiveFrom;
            }
            set
            {
                _ActiveFrom = value;
            }
        }

        [DataMember]
        public System.Nullable<DateTime> ActiveTo
        {
            get
            {
                return _ActiveTo;
            }
            set
            {
                _ActiveTo = value;
            }
        }

        [DataMember]
        public Int32 StoreID
        {
            get
            {
                return this._StoreID;
            }
            set
            {
                this._StoreID = value;
            }
        }

        [DataMember]
        public Int32 PortalID
        {
            get
            {
                return this._PortalID;
            }
            set
            {
                this._PortalID = value;
            }
        }

        [DataMember]
        public System.Nullable<bool> IsActive
        {
            get
            {
                return _IsActive;
            }
            set
            {
                _IsActive = value;
            }
        }
        [DataMember]
        public System.Nullable<Int32> DisplayOrder
        {
            get
            {
                return this._DisplayOrder;
            }
            set
            {
                this._DisplayOrder = value;
            }
        }

        [DataMember]
        public System.Nullable<bool> IsChecked
        {
            get
            {
                return _IsChecked;
            }
            set
            {
                _IsChecked = value;
            }
        }

        [DataMember]
        public string AttributeValue
        {
            get
            {
                return this._AttributeValue;
            }
            set
            {
                this._AttributeValue = value;
            }
        }

        [DataMember]
        public Int32 ChildCount
        {
            get
            {
                return this._ChildCount;
            }
            set
            {
                this._ChildCount = value;
            }
        }
    }
}
