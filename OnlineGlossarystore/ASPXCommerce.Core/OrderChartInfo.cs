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
    public class OrderChartInfo
    {

        private decimal _GrandTotal;
        private string _Date;
        private int _CustomerVisit;
        private int _Orders;
        

        public OrderChartInfo()
        {
        }

        [DataMember]
        public decimal GrandTotal
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

        [DataMember]
        public string Date
        {
            get
            {
                return this._Date;
            }
            set
            {
                if ((this._Date != value))
                {
                    this._Date = value;
                }
            }
        }
         [DataMember]
        public int CustomerVisit
        {
            get
            {
                return this._CustomerVisit;
            }
            set
            {
                if ((this._CustomerVisit != value))
                {
                    this._CustomerVisit = value;
                }
            }
        }
         [DataMember]
         public int Orders
         {
             get
             {
                 return this._Orders;
             }
             set
             {
                 if ((this._Orders != value))
                 {
                     this._Orders = value;
                 }
             }
         }
    }
}
