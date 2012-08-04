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
using System.Web.UI.WebControls;
using System.Web.UI;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
   public class DownLoadableItemGetInfo
   {
       #region Constructors
       public DownLoadableItemGetInfo()
       {
       }
       #endregion

       #region Private Fields
       [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ID", Order = 1)]
        private int _ID;

        [DataMember(Name = "_SKU", Order = 2)]
        private string _SKU;

        [DataMember(Name = "_ItemName", Order = 3)]
        private string _ItemName;

        [DataMember(Name = "_SampleLink", Order = 4)]
        private string _SampleLink;

        [DataMember(Name = "_ActualLink", Order = 5)]
        private string _ActualLink;

        [DataMember(Name = "_SampleFile", Order = 6)]
        private string _SampleFile;

        [DataMember(Name = "_ActualFile", Order = 7)]
        private string _ActualFile;
        
        

        [DataMember(Name = "_Purchases", Order = 8)]
        private string _Purchases;

        [DataMember(Name = "_Downloads", Order = 9)]
        private string _Downloads;
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

        public string ActualLink
        {
            get
            {
                return this._ActualLink;
            }
            set
            {
                if ((this._ActualLink != value))
                {
                    this._ActualLink = value;
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

        public string ActualFile
        {
            get
            {
                return this._ActualFile;
            }
            set
            {
                if ((this._ActualFile != value))
                {
                    this._ActualFile = value;
                }
            }
        }

       

        public string Purchases
        {
            get
            {
                return this._Purchases;
            }
            set
            {
                if ((this._Purchases != value))
                {
                    this._Purchases = value;
                }
            }
        }

        public string Downloads
        {
            get
            {
                return this._Downloads;
            }
            set
            {
                if ((this._Downloads != value))
                {
                    this._Downloads = value;
                }
            }
        }

        #endregion
    }
}
