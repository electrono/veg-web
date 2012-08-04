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
   public class CardTypeInfo
    {
        public CardTypeInfo()
        {
        }

        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "CardTypeID", Order = 1)]
        private int _CardTypeID;

        [DataMember(Name = "CardTypeName", Order = 2)]
        private string _CardTypeName;

        [DataMember(Name = "IsSystemUsed", Order = 3)]
        private System.Nullable<bool> _IsSystemUsed;

        [DataMember(Name = "IsActive", Order = 4)]
        private System.Nullable<bool> _IsActive;     

        [DataMember(Name = "IsDeleted", Order = 5)]
        private System.Nullable<bool> _IsDeleted;

        [DataMember(Name = "ImagePath", Order = 6)]
        private string _ImagePath;

        [DataMember(Name = "AlternateText", Order = 7)]
        private string _AlternateText;

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

        public int CardTypeID
        {
            get
            {
                return this._CardTypeID;
            }
            set
            {
                if ((this._CardTypeID != value))
                {
                    this._CardTypeID = value;
                }
            }
        }

        public string CardTypeName
        {
            get
            {
                return this._CardTypeName;
            }
            set
            {
                if ((this._CardTypeName != value))
                {
                    this._CardTypeName = value;
                }
            }
        }

        public System.Nullable<bool> IsSystemUsed
        {
            get
            {
                return this._IsSystemUsed;
            }
            set
            {
                if ((this._IsSystemUsed != value))
                {
                    this._IsSystemUsed = value;
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

        public System.Nullable<bool> IsDeleted
        {
            get
            {
                return this._IsDeleted;
            }
            set
            {
                if ((this._IsDeleted != value))
                {
                    this._IsDeleted = value;
                }
            }
        }

        public string ImagePath
        {
            get
            {
                return this._ImagePath;
            }
            set
            {
                if ((this._ImagePath != value))
                {
                    this._ImagePath = value;
                }
            }
        }

        public string AlternateText
        {
            get
            {
                return this._AlternateText;
            }
            set
            {
                if ((this._AlternateText != value))
                {
                    this._AlternateText = value;
                }
            }
        }
    }
}
