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
    public class StaticOrderStatusAdminDashInfo
    {
        public StaticOrderStatusAdminDashInfo()
        {
        }

        [DataMember]
        private string _StatusName;

        [DataMember]
        private System.Nullable<decimal> _ThisDay;

        [DataMember]
        private System.Nullable<decimal> _ThisWeek;

        [DataMember]
        private System.Nullable<decimal> _ThisMonth;

        [DataMember]
        private System.Nullable<decimal> _ThisYear;

        public string StatusName
        {
            get
            {
                return this._StatusName;
            }
            set
            {
                if ((this._StatusName != value))
                {
                    this._StatusName = value;
                }
            }
        }

        public System.Nullable<decimal> ThisDay
        {
            get
            {
                return this._ThisDay;
            }
            set
            {
                if ((this._ThisDay != value))
                {
                    this._ThisDay = value;
                }
            }
        }

        public System.Nullable<decimal> ThisWeek
        {
            get
            {
                return this._ThisWeek;
            }
            set
            {
                if ((this._ThisWeek != value))
                {
                    this._ThisWeek = value;
                }
            }
        }

        public System.Nullable<decimal> ThisMonth
        {
            get
            {
                return this._ThisMonth;
            }
            set
            {
                if ((this._ThisMonth != value))
                {
                    this._ThisMonth = value;
                }
            }
        }

        public System.Nullable<decimal> ThisYear
        {
            get
            {
                return this._ThisYear;
            }
            set
            {
                if ((this._ThisYear != value))
                {
                    this._ThisYear = value;
                }
            }
        }


    }
}
