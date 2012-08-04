﻿/*
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
    public class StatusInfo
    {
        public StatusInfo()
        {
        }
        private System.Nullable<int> _StatusID;
        private string _Status;
                private System.Nullable<int> _OrderStatusID;
        private string _OrderStatusName;

        [DataMember]
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
        [DataMember]
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
        [DataMember]
        public System.Nullable<int> OrderStatusID
        {
            get
            {
                return this._OrderStatusID;
            }
            set
            {
                if (this._OrderStatusID != value)
                {
                    this._OrderStatusID = value;
                }
            }
        }
        [DataMember]
        public string OrderStatusName
        {
            get
            {
                return this._OrderStatusName;
            }
            set
            {
                if (this._OrderStatusName != value)
                {
                    this._OrderStatusName = value;
                }
            }
        }
    }
}