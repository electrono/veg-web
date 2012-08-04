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
    public class InvoiceDetailsInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_InvoiceNumber", Order = 1)]
		private string _InvoiceNumber;

        [DataMember(Name = "_InvoiceDate", Order = 2)]
		private string _InvoiceDate;

        [DataMember(Name = "_OrderID", Order = 3)]
		private System.Nullable<int> _OrderID;

        [DataMember(Name = "_CustomerName", Order = 4)]
        private string _CustomerName;

        [DataMember(Name = "_OrderDate", Order = 5)]
		private string _OrderDate;

        [DataMember(Name = "_BillToName", Order = 6)]
		private string _BillToName;

        [DataMember(Name = "_ShipToName", Order = 7)]
        private string _ShipToName;

        [DataMember(Name = "_OrderStatusName", Order = 8)]
		private string _OrderStatusName;

        [DataMember(Name = "_Amount", Order = 9)]
		private System.Nullable<decimal> _Amount;

        [DataMember(Name = "_CustomerEmail", Order = 10)]
        private string _CustomerEmail;

       

        public InvoiceDetailsInfo()
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

		public string InvoiceDate
		{
			get
			{
				return this._InvoiceDate;
			}
			set
			{
				if ((this._InvoiceDate != value))
				{
					this._InvoiceDate = value;
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

		public string OrderDate
		{
			get
			{
				return this._OrderDate;
			}
			set
			{
				if ((this._OrderDate != value))
				{
					this._OrderDate = value;
				}
			}
		}

		public string BillToName
		{
			get
			{
				return this._BillToName;
			}
			set
			{
				if ((this._BillToName != value))
				{
					this._BillToName = value;
				}
			}
		}

        public string ShipToName
        {
            get
            {
                return this._ShipToName;
            }
            set
            {
                if ((this._ShipToName != value))
                {
                    this._ShipToName = value;
                }
            }
        }

		public string OrderStatusName
		{
			get
			{
				return this._OrderStatusName;
			}
			set
			{
				if ((this._OrderStatusName != value))
				{
					this._OrderStatusName = value;
				}
			}
		}

		public System.Nullable<decimal> Amount
		{
			get
			{
				return this._Amount;
			}
			set
			{
				if ((this._Amount != value))
				{
					this._Amount = value;
				}
			}
		}

        public string CustomerEmail
        {
            get
            {
                return this._CustomerEmail;
            }
            set
            {
                if ((this._CustomerEmail != value))
                {
                    this._CustomerEmail = value;
                }
            }
        }
    }
}
