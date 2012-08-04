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
   public class PaymentGatewayListInfo
    {
        [DataMember]
        private int _PaymentGatewayTypeID;
        [DataMember]
        private string _PaymentGatewayTypeName;
        [DataMember]
        private string _ControlSource;
        [DataMember]
        private string _FriendlyName;


        public PaymentGatewayListInfo()
        {
        }

     
        public int PaymentGatewayTypeID
        {
            get
            {
                return this._PaymentGatewayTypeID;
            }
            set
            {
                if ((this._PaymentGatewayTypeID != value))
                {
                    this._PaymentGatewayTypeID = value;
                }
            }
        }

       
        public string PaymentGatewayTypeName
        {
            get
            {
                return this._PaymentGatewayTypeName;
            }
            set
            {
                if ((this._PaymentGatewayTypeName != value))
                {
                    this._PaymentGatewayTypeName = value;
                }
            }
        }
        public string FriendlyName
        {
            get
            {
                return this._FriendlyName;
            }
            set
            {
                if ((this._FriendlyName != value))
                {
                    this._FriendlyName = value;
                }
            }
        }
       
        public string ControlSource
        {
            get
            {
                return this._ControlSource;
            }
            set
            {
                if ((this._ControlSource != value))
                {
                    this._ControlSource = value;
                }
            }
        }
    }
   
}
