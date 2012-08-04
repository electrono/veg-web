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
    public class InventoryDetailAdminDashInfo
    {
        public InventoryDetailAdminDashInfo()
        {
        }

        private System.Nullable<int> _TotalItem;

        private System.Nullable<int> _Active;

        private System.Nullable<int> _Hidden;

        private System.Nullable<int> _DItemscountNo;

        private string _DownlodableIDs;

        private System.Nullable<int> _SItemsCountNo;

        private string _SpecialItemsIDs;

        private System.Nullable<int> _LowStockItemCount;

        [DataMember]
        public System.Nullable<int> TotalItem
        {
            get
            {
                return this._TotalItem;
            }
            set
            {
                if ((this._TotalItem != value))
                {
                    this._TotalItem = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> Active
        {
            get
            {
                return this._Active;
            }
            set
            {
                if ((this._Active != value))
                {
                    this._Active = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> Hidden
        {
            get
            {
                return this._Hidden;
            }
            set
            {
                if ((this._Hidden != value))
                {
                    this._Hidden = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> DItemscountNo
        {
            get
            {
                return this._DItemscountNo;
            }
            set
            {
                if ((this._DItemscountNo != value))
                {
                    this._DItemscountNo = value;
                }
            }
        }

        [DataMember]
        public string DownlodableIDs
        {
            get
            {
                return this._DownlodableIDs;
            }
            set
            {
                if ((this._DownlodableIDs != value))
                {
                    this._DownlodableIDs = value;
                }
            }
        }

        [DataMember]
        public System.Nullable<int> SItemsCountNo
        {
            get
            {
                return this._SItemsCountNo;
            }
            set
            {
                if ((this._SItemsCountNo != value))
                {
                    this._SItemsCountNo = value;
                }
            }
        }

        [DataMember]
        public string SpecialItemsIDs
        {
            get
            {
                return this._SpecialItemsIDs;
            }
            set
            {
                if ((this._SpecialItemsIDs != value))
                {
                    this._SpecialItemsIDs = value;
                }
            }
        }
        
        [DataMember]        
        public System.Nullable<int> LowStockItemCount
        {
            get
            {
                return this._LowStockItemCount;
            }
            set
            {
                if ((this._LowStockItemCount != value))
                {
                    this._LowStockItemCount = value;
                }
            }
        }

    }
}
