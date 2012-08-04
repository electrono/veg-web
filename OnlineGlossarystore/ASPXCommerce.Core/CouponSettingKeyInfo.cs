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
    public class CouponSettingKeyInfo
    {

        [DataMember(Name = "_SettingID", Order = 1)]
        private System.Nullable<int> _SettingID;

        [DataMember(Name = "_SettingKey", Order = 2)]
        private string _SettingKey;

        [DataMember(Name = "_ValidationTypeID", Order = 3)]
        private System.Nullable<int> _ValidationTypeID;

        [DataMember(Name = "_ValidationType", Order = 4)]
        private string _ValidationType;

        public CouponSettingKeyInfo()
        {
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

        public System.Nullable<int> ValidationTypeID
        {
            get
            {
                return this._ValidationTypeID;
            }
            set
            {
                if ((this._ValidationTypeID != value))
                {
                    this._ValidationTypeID = value;
                }
            }
        }

        public string ValidationType
        {
            get
            {
                return this._ValidationType;
            }
            set
            {
                if ((this._ValidationType != value))
                {
                    this._ValidationType = value;
                }
            }
        }

   

    }
}
