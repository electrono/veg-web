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
    public class ShipmentsDetailsInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ShippingMethodID", Order = 1)]
		private System.Nullable<int> _ShippingMethodID;

        [DataMember(Name = "_ShippingMethodName", Order = 2)]
        private string _ShippingMethodName;

        [DataMember(Name = "_OrderID", Order = 3)]
		private System.Nullable<int> _OrderID;

        //[DataMember(Name = "_ShippedDate", Order = 4)]
        //private string _ShippedDate;

        [DataMember(Name = "_ShipToName", Order = 5)]
		private string _ShipToName;

        [DataMember(Name = "_ShippingRate", Order = 6)]
        private System.Nullable<decimal> _ShippingRate;

        public ShipmentsDetailsInfo()
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

		public System.Nullable<int> ShippingMethodID
		{
			get
			{
				return this._ShippingMethodID;
			}
			set
			{
				if ((this._ShippingMethodID != value))
				{
					this._ShippingMethodID = value;
				}
			}
		}

        public string ShippingMethodName
        {
            get
            {
                return this._ShippingMethodName;
            }
            set
            {
                if ((this._ShippingMethodName != value))
                {
                    this._ShippingMethodName = value;
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

        //public string ShippedDate
        //{
        //    get
        //    {
        //        return this._ShippedDate;
        //    }
        //    set
        //    {
        //        if ((this._ShippedDate != value))
        //        {
        //            this._ShippedDate = value;
        //        }
        //    }
        //}

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

		public System.Nullable<decimal> ShippingRate
		{
			get
			{
                return this._ShippingRate;
			}
			set
			{
                if ((this._ShippingRate != value))
				{
                    this._ShippingRate = value;
				}
			}
		}
    }
}
