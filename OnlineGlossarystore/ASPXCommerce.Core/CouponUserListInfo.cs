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
    
    public class CouponUserListInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_CouponUserID", Order = 1)]
        private int _CouponUserID;

        [DataMember(Name = "_CouponID", Order = 2)]
        private int _CouponID;

        [DataMember(Name = "_CouponCode", Order = 3)]
        private string _CouponCode;

        [DataMember(Name = "_UserName", Order = 4)]
        private string _UserName;

        [DataMember(Name = "_CouponAmount", Order = 5)]
        private System.Nullable<decimal> _CouponAmount;

        [DataMember(Name = "_CouponStatusID", Order = 6)]
        private System.Nullable<int> _CouponStatusID;

        [DataMember(Name = "_CouponStatus", Order = 7)]
        private string _CouponStatus;

        [DataMember(Name = "_CouponLife", Order = 8)]
        private string _CouponLife;

        [DataMember(Name = "_NoOfUse", Order = 9)]
        private System.Nullable<int> _NoOfUse;

        [DataMember(Name = "_ValidateFrom", Order = 10)]
        private System.Nullable<System.DateTime> _ValidateFrom;

        [DataMember(Name = "_ValidateTo", Order = 11)]
        private System.Nullable<System.DateTime> _ValidateTo;        

        public CouponUserListInfo()
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

        public int CouponUserID
        {
            get
            {
                return this._CouponUserID;
            }
            set
            {
                if ((this._CouponUserID != value))
                {
                    this._CouponUserID = value;
                }
            }
        }

        public int CouponID
        {
            get
            {
                return this._CouponID;
            }
            set
            {
                if ((this._CouponID != value))
                {
                    this._CouponID = value;
                }
            }
        }

        public string CouponCode
        {
            get
            {
                return this._CouponCode;
            }
            set
            {
                if ((this._CouponCode != value))
                {
                    this._CouponCode = value;
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

        public System.Nullable<decimal> CouponAmount
        {
            get
            {
                return this._CouponAmount;
            }
            set
            {
                if ((this._CouponAmount != value))
                {
                    this._CouponAmount = value;
                }
            }
        }

        public System.Nullable<int> CouponStatusID
        {
            get
            {
                return this._CouponStatusID;
            }
            set
            {
                if ((this._CouponStatusID != value))
                {
                    this._CouponStatusID = value;
                }
            }
        }

        public string CouponStatus
        {
            get
            {
                return this._CouponStatus;
            }
            set
            {
                if ((this._CouponStatus != value))
                {
                    this._CouponStatus = value;
                }
            }
        }

        public string CouponLife
        {
            get
            {
                return this._CouponLife;
            }
            set
            {
                if ((this._CouponLife != value))
                {
                    this._CouponLife = value;
                }
            }
        }

        public System.Nullable<int> NoOfUse
        {
            get
            {
                return this._NoOfUse;
            }
            set
            {
                if ((this._NoOfUse != value))
                {
                    this._NoOfUse = value;
                }
            }
        }

        public System.Nullable<System.DateTime> ValidateFrom
        {
            get
            {
                return this._ValidateFrom;
            }
            set
            {
                if ((this._ValidateFrom != value))
                {
                    this._ValidateFrom = value;
                }
            }
        }

        public System.Nullable<System.DateTime> ValidateTo
        {
            get
            {
                return this._ValidateTo;
            }
            set
            {
                if ((this._ValidateTo != value))
                {
                    this._ValidateTo = value;
                }
            }
        }

     
    }
}
