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
    public class ShareWishListItemInfo
    {
        public ShareWishListItemInfo()
        {
        }
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ShareWishID", Order = 1)]
        private int _ShareWishID;

        [DataMember(Name = "_SharedWishItemIDs", Order = 2)]
        private string _SharedWishItemIDs;

        [DataMember(Name = "_SharedWishItemName", Order = 3)]
        private string _SharedWishItemName;

        [DataMember(Name = "_SenderName", Order = 4)]
        private string _SenderName;

        [DataMember(Name = "_SenderEmail", Order = 5)]
        private string _SenderEmail;

        [DataMember(Name = "_ReceiverEmailID", Order = 6)]
        private string _ReceiverEmailID;

        [DataMember(Name = "_Subject", Order = 7)]
        private string _Subject;


        [DataMember(Name = "_Message", Order = 8)]
        private string _Message;

        [DataMember(Name = "_AddedOn", Order = 9)]
        private string _AddedOn;

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

        public int ShareWishID
        {
            get
            {
                return this._ShareWishID;
            }
            set
            {
                if ((this._ShareWishID != value))
                {
                    this._ShareWishID = value;
                }
            }
        }

        public string SharedWishItemIDs
        {
            get
            {
                return this._SharedWishItemIDs;
            }
            set
            {
                if ((this._SharedWishItemIDs != value))
                {
                    this._SharedWishItemIDs = value;
                }
            }
        }

        public string SharedWishItemName
        {
            get
            {
                return this._SharedWishItemName;
            }
            set
            {
                if ((this._SharedWishItemName != value))
                {
                    this._SharedWishItemName = value;
                }
            }
        }

        public string SenderName
        {
            get
            {
                return this._SenderName;
            }
            set
            {
                if ((this._SenderName != value))
                {
                    this._SenderName = value;
                }
            }
        }

        public string SenderEmail
        {
            get
            {
                return this._SenderEmail;
            }
            set
            {
                if ((this._SenderEmail != value))
                {
                    this._SenderEmail = value;
                }
            }
        }

        public string ReceiverEmailID
        {
            get
            {
                return this._ReceiverEmailID;
            }
            set
            {
                if ((this._ReceiverEmailID != value))
                {
                    this._ReceiverEmailID = value;
                }
            }
        }

        public string Subject
        {
            get
            {
                return this._Subject;
            }
            set
            {
                if ((this._Subject != value))
                {
                    this._Subject = value;
                }
            }
        }

        public string Message
        {
            get
            {
                return this._Message;
            }
            set
            {
                if ((this._Message != value))
                {
                    this._Message = value;
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
    }
}
