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
    public class DownloadableItemsByCustomerInfo
    {
        #region Constructor
        public DownloadableItemsByCustomerInfo()
        {
        }
        #endregion
        #region Private Fields
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        
        [DataMember(Name = "_OrderItemID", Order = 1)]
        private int _OrderItemID;

        [DataMember(Name = "_OrderItemIDDup", Order = 2)]
        private int _OrderItemIDDup;

        [DataMember(Name = "_OrderID", Order = 3)]
        private int _OrderID;

        [DataMember(Name = "_RandomNo", Order = 4)]
        private string _RandomNo;


        [DataMember(Name = "_ItemID", Order = 5)]
        private int _ItemID;

        [DataMember(Name = "_SKU", Order = 6)]
        private string _SKU;

        [DataMember(Name = "_ItemName", Order = 7)]
        private string _ItemName;

        [DataMember(Name = "_SampleLink", Order = 8)]
        private string _SampleLink;

        [DataMember(Name = "_ActualLink", Order = 9)]
        private string _ActualLink;

        [DataMember(Name = "_SampleFile", Order = 10)]
        private string _SampleFile;

        [DataMember(Name = "_ActualFile", Order = 11)]
        private string _ActualFile;

        [DataMember(Name = "_OrderStatusID", Order = 12)]
        private int _OrderStatusID;

        [DataMember(Name = "_Status", Order = 13)]
        private string _Status;

        [DataMember(Name = "_Downloads", Order = 14)]
        private string _Downloads;

        [DataMember(Name = "_RemainingDownload", Order = 15)]
        private string _RemainingDownload;

        [DataMember(Name = "_LastDownloadDate", Order = 16)]
        private System.Nullable<System.DateTime> _LastDownloadDate;


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

       

        public int OrderItemID
        {
            get
            {
                return this._OrderItemID;
            }
            set
            {
                if ((this._OrderItemID != value))
                {
                    this._OrderItemID = value;
                }
            }
        }

        public int OrderItemIDDup
        {
            get
            {
                return this._OrderItemIDDup;
            }
            set
            {
                if ((this._OrderItemIDDup != value))
                {
                    this._OrderItemIDDup = value;
                }
            }
        }

        public int OrderID
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

        public string RandomNo
        {
            get
            {
                return this._RandomNo;
            }
            set
            {
                if ((this._RandomNo != value))
                {
                    this._RandomNo = value;
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

        public int OrderStatusID
        {
            get
            {
                return this._OrderStatusID;
            }
            set
            {
                if ((this._OrderStatusID != value))
                {
                    this._OrderStatusID = value;
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

        public string RemainingDownload
        {
            get
            {
                return this._RemainingDownload;
            }
            set
            {
                if ((this._RemainingDownload != value))
                {
                    this._RemainingDownload = value;
                }
            }
        }

        public System.Nullable<System.DateTime> LastDownloadDate
        {
            get
            {
                return this._LastDownloadDate;
            }
            set
            {
                if ((this._LastDownloadDate != value))
                {
                    this._LastDownloadDate = value;
                }
            }
        }


        #endregion
    }
}
