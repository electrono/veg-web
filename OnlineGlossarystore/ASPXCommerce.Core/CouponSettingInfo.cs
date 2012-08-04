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
    public class CouponSettingInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_SettingID", Order = 1)]
        private System.Nullable<int> _SettingID;

        [DataMember(Name = "_SettingKey", Order = 2)]
        private string _SettingKey;

        [DataMember(Name = "_InputTypeID", Order = 3)]
        private System.Nullable<int> _InputTypeID;

        [DataMember(Name = "_InputType", Order = 4)]
        private string _InputType;

        [DataMember(Name = "_AddedOn", Order = 5)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_IsActive", Order = 6)]
        private System.Nullable<bool> _IsActive;


        public CouponSettingInfo()
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


        public System.Nullable<int> SettingID
        {
            get
            {
                return this._SettingID;
            }
            set
            {
                if ((this._SettingID != value))
                {
                    this._SettingID = value;
                }
            }
        }


        public string SettingKey
        {
            get
            {
                return this._SettingKey;
            }
            set
            {
                if ((this._SettingKey != value))
                {
                    this._SettingKey = value;
                }
            }
        }

        public System.Nullable<int> InputTypeID
        {
            get
            {
                return this._InputTypeID;
            }
            set
            {
                if ((this._InputTypeID != value))
                {
                    this._InputTypeID = value;
                }
            }
        }

        public string InputType
        {
            get
            {
                return this._InputType;
            }
            set
            {
                if ((this._InputType != value))
                {
                    this._InputType = value;
                }
            }
        }

        public System.Nullable<System.DateTime> AddedOn
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
