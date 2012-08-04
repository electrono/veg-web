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
    public class TagDetailsInfo
    {
        public TagDetailsInfo()
        {
        }

        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ItemTagIDs", Order = 1)]
        private string _ItemTagIDs;

        [DataMember(Name = "_Tag", Order = 2)]
        private string _Tag;

        [DataMember(Name = "_UserCount", Order = 3)]
        private System.Nullable<int> _UserCount;

        [DataMember(Name = "_ItemCount", Order = 4)]
        private System.Nullable<int> _ItemCount;

        [DataMember(Name = "_Status", Order = 5)]
        private string _Status;

        [DataMember(Name = "_StatusID", Order = 6)]
        private System.Nullable<int> _StatusID;

        [DataMember(Name = "_UserIDs", Order = 7)]
        private string _UserIDs;

        [DataMember(Name = "_ItemIDs", Order = 8)]
        private string _ItemIDs;

        [DataMember(Name = "_TagCount", Order = 9)]
        private System.Nullable<int> _TagCount;

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

        public string ItemTagIDs
        {
            get
            {
                return this._ItemTagIDs;
            }
            set
            {
                if (this._ItemTagIDs != value)
                {
                    this._ItemTagIDs = value;
                }
            }
        }

        public string Tag
        {
            get
            {
                return this._Tag;
            }
            set
            {
                if ((this._Tag != value))
                {
                    this._Tag = value;
                }
            }
        }

        public System.Nullable<int> UserCount
        {
            get
            {
                return this._UserCount;
            }
            set
            {
                if ((this._UserCount != value))
                {
                    this._UserCount = value;
                }
            }
        }

        public System.Nullable<int> ItemCount
        {
            get
            {
                return this._ItemCount;
            }
            set
            {
                if ((this._ItemCount != value))
                {
                    this._ItemCount = value;
                }
            }
        }

        public string Status
        {
            get
            {
                return this._Status;
            }
            set
            {
                if (this._Status != value)
                {
                    this._Status = value;
                }
            }
        }
        public System.Nullable<int> StatusID
        {
            get
            {
                return this._StatusID;
            }
            set
            {
                if (this._StatusID != value)
                {
                    this._StatusID = value;
                }
            }
        }

        public string UserIDs
        {
            get
            {
                return this._UserIDs;
            }
            set
            {
                if ((this._UserIDs != value))
                {
                    this._UserIDs = value;
                }
            }
        }

        public string ItemIDs
        {
            get
            {
                return this._ItemIDs;
            }
            set
            {
                if ((this._ItemIDs != value))
                {
                    this._ItemIDs = value;
                }
            }
        }

        public System.Nullable<int> TagCount
        {
            get
            {
                return this._TagCount;
            }
            set
            {
                if ((this._TagCount != value))
                {
                    this._TagCount = value;
                }
            }
        }
    }
}
 
