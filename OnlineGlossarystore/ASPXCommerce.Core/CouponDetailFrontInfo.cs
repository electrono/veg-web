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
    public class CouponDetailFrontInfo
    {
        public CouponDetailFrontInfo()
        {
        }

        private System.Nullable<int> _CouponID;
        private string _CouponType;

        private string _CouponCode;

        private System.Nullable<decimal> _CouponAmount;

        private string _ValidateFrom;

        private string _ValidateTo;


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
    }
}
