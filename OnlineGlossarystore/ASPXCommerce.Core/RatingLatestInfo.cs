﻿/*
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
    public class RatingLatestInfo
    {
        private int _ItemReviewID;
        private System.Nullable<int> _ItemID;
        private string _Username;
        private decimal _RatingAverage;        
        private string _ViewFromIP;
        private string _ReviewSummary;
        private string _Review;
        private string _Status;
        private string _ItemName;
        private string _AddedOn;
        private string _AddedBy;
        private int _StatusID;
        private int _ItemRatingID;
        private string _ItemRatingCriteria;        
        private decimal _RatingValue;

        public RatingLatestInfo()
        {
        }

        [DataMember]
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
        [DataMember]
        public decimal RatingAverage
        {
            get
            {
                return this._RatingAverage;
            }
            set
            {
                if ((this._RatingAverage != value))
                {
                    this._RatingAverage = value;
                }
            }
        }
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
        public string AddedOn
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
        public int ItemRatingID
        {
            get
            {
                return this._ItemRatingID;
            }
            set
            {
                if ((this._ItemRatingID != value))
                {
                    this._ItemRatingID = value;
                }
            }
        }
        [DataMember]
        public string ItemRatingCriteria
        {
            get
            {
                return this._ItemRatingCriteria;
            }
            set
            {
                if ((this._ItemRatingCriteria != value))
                {
                    this._ItemRatingCriteria = value;
                }
            }
        }
        [DataMember]
        public decimal RatingValue
        {
            get
            {
                return this._RatingValue;
            }
            set
            {
                if ((this._RatingValue != value))
                {
                    this._RatingValue = value;
                }
            }
        }
    }
}
