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
    public class UserRatingInformationInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;
        [DataMember(Name = "_ItemReviewID", Order = 1)]
        private int _ItemReviewID;
        [DataMember(Name = "_ItemID", Order = 2)]
        private System.Nullable<int> _ItemID;
        [DataMember(Name = "_Username", Order = 3)]
        private string _Username;
        [DataMember(Name = "_TotalRatingAverage", Order = 4)]
        private string _TotalRatingAverage;        
        [DataMember(Name = "_ViewFromIP", Order = 5)]
        private string _ViewFromIP;
        [DataMember(Name = "_ReviewSummary", Order = 6)]
        private string _ReviewSummary;
        [DataMember(Name = "_Review", Order = 7)]
        private string _Review;
        [DataMember(Name = "_Status", Order = 8)]
        private string _Status;
        [DataMember(Name = "_ItemName", Order = 9)]
        private string _ItemName;
        [DataMember(Name = "_AddedOn", Order = 10)]
        private DateTime _AddedOn;
        [DataMember(Name = "_AddedBy", Order = 11)]
        private string _AddedBy;
        [DataMember(Name = "_StatusID", Order = 12)]
        private int _StatusID;
        [DataMember(Name = "_SKU", Order = 13)]
        private string _SKU;

        public UserRatingInformationInfo()
        {
        }

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
        public int ItemReviewID
        {
            get
            {
                return this._ItemReviewID;
            }
            set
            {
                if ((this._ItemReviewID != value))
                {
                    this._ItemReviewID = value;
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
        public string Username
        {
            get
            {
                return this._Username;
            }
            set
            {
                if ((this._Username != value))
                {
                    this._Username = value;
                }
            }
        }
        public string TotalRatingAverage
        {
            get
            {
                return this._TotalRatingAverage;
            }
            set
            {
                if ((this._TotalRatingAverage != value))
                {
                    this._TotalRatingAverage = value;
                }
            }
        }
        public string ViewFromIP
        {
            get
            {
                return this._ViewFromIP;
            }
            set
            {
                if ((this._ViewFromIP != value))
                {
                    this._ViewFromIP = value;
                }
            }
        }
        public string ReviewSummary
        {
            get
            {
                return this._ReviewSummary;
            }
            set
            {
                if ((this._ReviewSummary != value))
                {
                    this._ReviewSummary = value;
                }
            }
        }

        public string Review
        {
            get
            {
                return this._Review;
            }
            set
            {
                if ((this._Review != value))
                {
                    this._Review = value;
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

        public DateTime AddedOn
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
        public string AddedBy
        {
            get
            {
                return this._AddedBy;
            }
            set
            {
                if ((this._AddedBy != value))
                {
                    this._AddedBy = value;
                }
            }
        }
        public int StatusID
        {
            get
            {
                return this._StatusID;
            }
            set
            {
                if ((this._StatusID != value))
                {
                    this._StatusID = value;
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
    }
}
