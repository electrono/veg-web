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
   
    public  class StoreAccessInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;
        [DataMember(Name = "_StoreAccessID", Order = 1)]
        private int _StoreAccessID;
        [DataMember(Name = "_StoreAccessData", Order = 2)]
        private string _StoreAccessData;
        [DataMember(Name = "_Reason", Order = 3)]
        private string _Reason;
        [DataMember(Name = "_IsActive", Order = 5)]
        private System.Nullable<bool> _IsActive;
        [DataMember(Name = "_AddedOn", Order = 4)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_StoreAccessKeyValue", Order = 6)]
        private string _StoreAccessKeyValue;
        [DataMember(Name = "_SKID", Order = 7)]
        private int _SKID;  

        public StoreAccessInfo()
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
        public int StoreAccessID
        {
            get
            {
                return this._StoreAccessID;
            }
            set
            {
                if ((this._StoreAccessID != value))
                {
                    this._StoreAccessID = value;
                }
            }
        }

        public string StoreAccessData
        {
            get
            {
                return this._StoreAccessData;
            }
            set
            {
                if ((this._StoreAccessData != value))
                {
                    this._StoreAccessData = value;
                }
            }
        }

       
        public string Reason
        {
            get
            {
                return this._Reason;
            }
            set
            {
                if ((this._Reason != value))
                {
                    this._Reason = value;
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

     
        public string StoreAccessKeyValue
        {
            get
            {
                return this._StoreAccessKeyValue;
            }
            set
            {
                if ((this._StoreAccessKeyValue != value))
                {
                    this._StoreAccessKeyValue = value;
                }
            }
        }

        public int SKID
        {
            get
            {
                return this._SKID;
            }
            set
            {
                if ((this._SKID != value))
                {
                    this._SKID = value;
                }
            }
        }
    }
}
