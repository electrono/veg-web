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
    public class CouponInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_CouponID", Order = 1)]
        private System.Nullable<int> _CouponID;

        [DataMember(Name = "_CouponTypeID", Order = 2)]
        private System.Nullable<int> _CouponTypeID;

        [DataMember(Name = "_CouponType", Order = 3)]
        private string _CouponType;

        [DataMember(Name = "_CouponCode", Order = 4)]
        private string _CouponCode;

        [DataMember(Name = "_NumberOfUses", Order = 5)]
        private System.Nullable<int> _NumberOfUses;

        //[DataMember(Name = "_CouponStatusID", Order = 6)]
        //private System.Nullable<int> _CouponStatusID;

        //[DataMember(Name = "_CouponStatus", Order = 7)]
        //private string _CouponStatus;

        [DataMember(Name = "_ValidateFrom", Order = 8)]
        private string _ValidateFrom;

        [DataMember(Name = "_ValidateTo", Order = 9)]
        private string _ValidateTo;

        [DataMember(Name = "_BalanceAmount", Order = 10)]
        private System.Nullable<decimal> _BalanceAmount;

        [DataMember(Name = "_IsFreeShipping", Order = 11)]
        private string _IsFreeShipping;

        [DataMember(Name = "_AddedOn", Order = 12)]
        private string _AddedOn;

        [DataMember(Name = "_UpdatedOn", Order = 13)]
        private string _UpdatedOn;

        [DataMember(Name = "_IsActive", Order = 14)]
        private System.Nullable<bool> _IsActive;      

        public CouponInfo()
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

        public System.Nullable<int> CouponID
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

        public System.Nullable<int> CouponTypeID
        {
            get
            {
                return this._CouponTypeID;
            }
            set
            {
                if ((this._CouponTypeID != value))
                {
                    this._CouponTypeID = value;
                }
            }
        }

        public string CouponType
        {
            get
            {
                return this._CouponType;
            }
            set
            {
                if ((this._CouponType != value))
                {
                    this._CouponType = value;
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

        public System.Nullable<int> NumberOfUses
        {
            get
            {
                return this._NumberOfUses;
            }
            set
            {
                if ((this._NumberOfUses != value))
                {
                    this._NumberOfUses = value;
                }
            }
        }

        //public System.Nullable<int> CouponStatusID
        //{
        //    get
        //    {
        //        return this._CouponStatusID;
        //    }
        //    set
        //    {
        //        if ((this._CouponStatusID != value))
        //        {
        //            this._CouponStatusID = value;
        //        }
        //    }
        //}

        //public string CouponStatus
        //{
        //    get
        //    {
        //        return this._CouponStatus;
        //    }
        //    set
        //    {
        //        if ((this._CouponStatus != value))
        //        {
        //            this._CouponStatus = value;
        //        }
        //    }
        //}

        public string ValidateFrom
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

        public string ValidateTo
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

        public System.Nullable<decimal> BalanceAmount
        {
            get
            {
                return this._BalanceAmount;
            }
            set
            {
                if ((this._BalanceAmount != value))
                {
                    this._BalanceAmount = value;
                }
            }
        }

        public string IsFreeShipping
        {
            get
            {
                return this._IsFreeShipping;
            }
            set
            {
                if ((this._IsFreeShipping != value))
                {
                    this._IsFreeShipping = value;
                }
            }
        }

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

        public string UpdatedOn
        {
            get
            {
                return this._UpdatedOn;
            }
            set
            {
                if ((this._UpdatedOn != value))
                {
                    this._UpdatedOn = value;
                }
            }
        }

        public System.Nullable<bool> IsActive
        {
            get
            {
                return this._IsActive;
            }
            set
            {
                if ((this._IsActive != value))
                {
                    this._IsActive = value;
                }
            }
        }   

    }

}
