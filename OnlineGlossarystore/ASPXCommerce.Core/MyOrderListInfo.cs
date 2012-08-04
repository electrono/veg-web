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
    public class MyOrderListInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_OrderID", Order = 1)]
        private System.Nullable<int> _OrderID;

        [DataMember(Name = "_InVoiceNumber", Order = 2)]
        private string _InVoiceNumber;

        [DataMember(Name = "_CustomerID", Order = 3)]
        private System.Nullable<int> _CustomerID;

        [DataMember(Name = "_UserName", Order = 4)]
        private string _UserName;        

        [DataMember(Name = "_Email", Order = 5)]
        private string _Email; 
        [DataMember(Name = "_OrderStatus", Order = 6)]
        private string _OrderStatus;

        [DataMember(Name = "_GrandTotal", Order = 7)]
        private System.Nullable<decimal> _GrandTotal;

        [DataMember(Name = "_PaymentGatewayTypeName", Order = 8)]
        private string _PaymentGatewayTypeName;

        [DataMember(Name = "_PaymentMethodName", Order = 9)]
        private string _PaymentMethodName;
		
		[DataMember(Name = "_OrderedDate", Order = 10)]
        private string _OrderedDate;

        public MyOrderListInfo()
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
        public System.Nullable<int> OrderID
        {
            get
            {
                return this._OrderID;
            }
            set
            {
                if ((this._OrderID != value))
                {
                    this._OrderID = value;
                }
            }
        }


        public string InVoiceNumber
        {
            get
            {
                return this._InVoiceNumber;
            }
            set
            {
                if ((this._InVoiceNumber != value))
                {
                    this._InVoiceNumber = value;
                }
            }
        }

         public System.Nullable<int> CustomerID
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

         public string Email
         {
             get
             {
                 return this._Email;
             }
             set
             {
                 if ((this._Email != value))
                 {
                     this._Email = value;
                 }
             }
         }

        public string OrderStatus
        {
            get
            {
                return this._OrderStatus;
            }
            set
            {
                if ((this._OrderStatus != value))
                {
                    this._OrderStatus = value;
                }
            }
        }


        public System.Nullable<decimal> GrandTotal
        {
            get
            {
                return this._GrandTotal;
            }
            set
            {
                if ((this._GrandTotal != value))
                {
                    this._GrandTotal = value;
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


        public string PaymentMethodName
        {
            get
            {
                return this._PaymentMethodName;
            }
            set
            {
                if ((this._PaymentMethodName != value))
                {
                    this._PaymentMethodName = value;
                }
            }
        }
		
		public string OrderedDate
        {
            get
            {
                return this._OrderedDate;
            }
            set
            {
                if ((this._OrderedDate != value))
                {
                    this._OrderedDate = value;
                }
            }
        }
    }
}
