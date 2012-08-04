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
    public class ItemCostVariantInfo
    {
        private System.Nullable<int> _RowTotal;
        private System.Nullable<int> _ItemCostVariantsID;
        private System.Nullable<int> _ItemID;
        private System.Nullable<int> _CostVariantID;
        private string _CostVariantName;

        public ItemCostVariantInfo()
        {
        }

        [DataMember(Name = "_RowTotal", Order = 0)]
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
        [DataMember(Name = "_ItemCostVariantsID", Order = 1)]
        public System.Nullable<int> ItemCostVariantsID
        {
            get
            {
                return this._ItemCostVariantsID;
            }
            set
            {
                if ((this._ItemCostVariantsID != value))
                {
                    this._ItemCostVariantsID = value;
                }
            }
        }
        [DataMember(Name = "_ItemID", Order = 2)]
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
        [DataMember(Name = "_CostVariantID", Order = 3)]
        public System.Nullable<int> CostVariantID
        {
            get
            {
                return this._CostVariantID;
            }
            set
            {
                if ((this._CostVariantID != value))
                {
                    this._CostVariantID = value;
                }
            }
        }

        [DataMember(Name = "_CostVariantName", Order = 4)]
        public string CostVariantName
        {
            get
            {
                return this._CostVariantName;
            }
            set
            {
                if ((this._CostVariantName != value))
                {
                    this._CostVariantName = value;
                }
            }
        }
    }
}
