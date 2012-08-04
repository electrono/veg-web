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
    public class TopCustomerOrdererInfo
    {
        public TopCustomerOrdererInfo()
        {
        }

        [DataMember(Name = "_CustomerName", Order = 0)]
        private string _CustomerName;

        [DataMember(Name = "_NumberOfOrder", Order = 1)]
        private System.Nullable<int> _NumberOfOrder;

        [DataMember(Name = "_AverageOrderAmount", Order = 2)]
        private System.Nullable<decimal> _AverageOrderAmount;

        [DataMember(Name = "_TotalOrderAmount", Order = 3)]
        private System.Nullable<decimal> _TotalOrderAmount;


        public string CustomerName
        {
            get
            {
                return this._CustomerName;
            }
            set
            {
                if ((this._CustomerName != value))
                {
                    this._CustomerName = value;
                }
            }
        }

        public System.Nullable<int> NumberOfOrder
        {
            get
            {
                return this._NumberOfOrder;
            }
            set
            {
                if ((this._NumberOfOrder != value))
                {
                    this._NumberOfOrder = value;
                }
            }
        }

        public System.Nullable<decimal> AverageOrderAmount
        {
            get
            {
                return this._AverageOrderAmount;
            }
            set
            {
                if ((this._AverageOrderAmount != value))
                {
                    this._AverageOrderAmount = value;
                }
            }
        }

        public System.Nullable<decimal> TotalOrderAmount
        {
            get
            {
                return this._TotalOrderAmount;
            }
            set
            {
                if ((this._TotalOrderAmount != value))
                {
                    this._TotalOrderAmount = value;
                }
            }
        }
    }
   
}
