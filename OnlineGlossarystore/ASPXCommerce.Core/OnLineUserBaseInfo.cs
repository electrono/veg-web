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
    public class OnLineUserBaseInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_UserName", Order = 1)]
        private string _UserName;

        [DataMember(Name = "_SessionUserHostAddress", Order = 2)]
        private string _SessionUserHostAddress;

        [DataMember(Name = "_SessionUserAgent", Order = 3)]
        private string _SessionUserAgent;

        [DataMember(Name = "_SessionBrowser", Order = 4)]
        private string _SessionBrowser;

        [DataMember(Name = "_SessionURL", Order = 5)]
        private string _SessionURL;

        [DataMember(Name = "_Start", Order = 6)]
        private string _Start;

        public OnLineUserBaseInfo()
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
        public string SessionUserHostAddress
        {
            get
            {
                return this._SessionUserHostAddress;
            }
            set
            {
                if ((this._SessionUserHostAddress != value))
                {
                    this._SessionUserHostAddress = value;
                }
            }
        }
        public string SessionUserAgent
        {
            get
            {
                return this._SessionUserAgent;
            }
            set
            {
                if ((this._SessionUserAgent != value))
                {
                    this._SessionUserAgent = value;
                }
            }
        }
        public string SessionBrowser
        {
            get
            {
                return this._SessionBrowser;
            }
            set
            {
                if ((this._SessionBrowser != value))
                {
                    this._SessionBrowser = value;
                }
            }
        }
        public string SessionURL
        {
            get
            {
                return this._SessionURL;
            }
            set
            {
                if ((this._SessionURL != value))
                {
                    this._SessionURL = value;
                }
            }
        }
        public string Start
        {
            get
            {
                return this._Start;
            }
            set
            {
                if ((this._Start != value))
                {
                    this._Start = value;
                }
            }
        }
    }
}
