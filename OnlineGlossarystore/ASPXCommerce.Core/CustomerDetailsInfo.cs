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
    public class CustomerDetailsInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_CustomerID", Order = 1)]
        private int _CustomerID;

        [DataMember(Name = "_UserName", Order = 2)]
        private string _UserName;

        [DataMember(Name = "_CultureName", Order = 3)]
        private string _CultureName;

        [DataMember(Name = "_AddedOn", Order = 4)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_UpdatedOn", Order = 5)]
        private System.Nullable<System.DateTime> _UpdatedOn;

        [DataMember(Name = "_IsSameUser", Order = 6)]
        private bool _IsSameUser;

        public CustomerDetailsInfo()
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

        public int CustomerID
        {
            get
            {
                return this._CustomerID;
            }
            set
            {
                if ((this._CustomerID != value))
                {
                    this._CustomerID = value;
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

        public string CultureName
        {
            get
            {
                return this._CultureName;
            }
            set
            {
                if ((this._CultureName != value))
                {
                    this._CultureName = value;
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

        public System.Nullable<System.DateTime> UpdatedOn
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
        public bool IsSameUser
        {
            get
            {
                return this._IsSameUser;
            }
            set
            {
                if ((this._IsSameUser != value))
                {
                    this._IsSameUser = value;
                }
            }
        }
    }
}
