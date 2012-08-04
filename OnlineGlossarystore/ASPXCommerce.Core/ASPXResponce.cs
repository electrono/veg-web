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
using System.Runtime.Serialization;
using System.Text;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
    public class ASPXResponce
    {
        #region Private Fields

        private string _InvoiceNumber;
        private string _CustomerID;
        private string _PurchaseOrderNumber;
        private string _Sequence;
        private int _Stamp;
        private string _FingerPrint;

        private string _ResponceCode;
        private string _ResponceReasonCode;
        private string _TransactionCode;
        private string _AuthorizationCode;
        private string _Message;
        private Array _arrResponse; 
        #endregion

        #region Public Fields
        [DataMember]
        public string InvoiceNumber
        {
            get
            {
                return this._InvoiceNumber;
            }
            set
            {
                if ((this._InvoiceNumber != value))
                {
                    this._InvoiceNumber = value;
                }
            }
        }
        [DataMember]
        public string CustomerID
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

        [DataMember]
        public string PurchaseOrderNumber
        {
            get
            {
                return this._PurchaseOrderNumber;
            }
            set
            {
                if ((this._PurchaseOrderNumber != value))
                {
                    this._PurchaseOrderNumber = value;
                }
            }
        }

        [DataMember]
        public string Sequence
        {
            get
            {
                return this._Sequence;
            }
            set
            {
                if ((this._Sequence != value))
                {
                    this._Sequence = value;
                }
            }
        }
        [DataMember]
        public int Stamp
        {
            get
            {
                return this._Stamp;
            }
            set
            {
                if ((this._Stamp != value))
                {
                    this._Stamp = value;
                }
            }
        }

        [DataMember]
        public string FingerPrint
        {
            get
            {
                return this._FingerPrint;
            }
            set
            {
                if ((this._FingerPrint != value))
                {
                    this._FingerPrint = value;
                }
            }
        }


        [DataMember]
        public string ResponceCode
        {
            get
            {
                return this._ResponceCode;
            }
            set
            {
                if ((this._ResponceCode != value))
                {
                    this._ResponceCode = value;
                }
            }
        }

        [DataMember]
        public string ResponceReasonCode
        {
            get
            {
                return this._ResponceReasonCode;
            }
            set
            {
                if ((this._ResponceReasonCode != value))
                {
                    this._ResponceReasonCode = value;
                }
            }
        }

        [DataMember]
        public string TransactionCode
        {
            get
            {
                return this._TransactionCode;
            }
            set
            {
                if ((this._TransactionCode != value))
                {
                    this._TransactionCode = value;
                }
            }
        }

        [DataMember]
        public string AuthorizationCode
        {
            get
            {
                return this._AuthorizationCode;
            }
            set
            {
                if ((this._AuthorizationCode != value))
                {
                    this._AuthorizationCode = value;
                }
            }
        }

        [DataMember]
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

        [DataMember]
        public Array arrResponse
        {
            get
            {
                return this._arrResponse;
            }
            set
            {
                if ((this._arrResponse != value))
                {
                    this._arrResponse = value;
                }
            }
        }


        #endregion
    }
}
