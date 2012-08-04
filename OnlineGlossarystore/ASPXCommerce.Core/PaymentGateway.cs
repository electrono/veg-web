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
using System.Web;
using System.Runtime.Serialization;
using System.Collections;

namespace ASPXCommerce.Core
{
    
    public class PaymentGateway
    {
        #region Private members
        private int _paymentGatewayTypeId;
        private string _paymentGatewayTypeName;
        private int _PaymentGatewaySubTypeId;
        private string _paymentGatewaySubTypeName;
        #endregion

        #region Public Members

        [DataMember]
        public int paymentGatewayTypeId
        {
            get { return this._paymentGatewayTypeId; }

            set
            {
                if ((this._paymentGatewayTypeId != value))
                {
                    this._paymentGatewayTypeId = value;
                }
            }
        }

        [DataMember]
        public string paymentGatewayTypeName
        {
            get { return this._paymentGatewayTypeName; }
            set
            {
                if ((this._paymentGatewayTypeName != value))
                {
                    this._paymentGatewayTypeName = value;
                }
            }
        }
        [DataMember]
        public int paymentGatewaySubTypeID
        {
            get { return this._PaymentGatewaySubTypeId; }
            set
            {
                if((this._PaymentGatewaySubTypeId!=value))
                {
                    this._PaymentGatewaySubTypeId = value;
                }
            }
        }
        [DataMember]
        public string paymentGatewaySubTypeName
        {
            get { return this._paymentGatewaySubTypeName; }
            set
            {
                if ((this._paymentGatewaySubTypeName != value))
                {
                    this._paymentGatewaySubTypeName = value;
                }
            }
        }

        #endregion

    }
}
