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
    [DataContract]
    [Serializable]
    public class ShippingCostDependencyInfo
    {
         [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ShippingProductCostID", Order = 1)]
		private int _ShippingProductCostID;

        [DataMember(Name = "_ShippingMethodID", Order = 2)]
        private int _ShippingMethodID;

        [DataMember(Name = "_Cost", Order = 3)]
        private string _Cost;

        [DataMember(Name = "_RateValue", Order = 4)]
		private System.Nullable<decimal> _RateValue;

        [DataMember(Name = "_IsRateInPercentage", Order = 5)]
        private string _IsRateInPercentage;

        //[DataMember(Name = "_IsWeightInPercentage", Order = 5)]
        //private string _IsWeightInPercentage;

        [DataMember(Name = "_AddedOn", Order = 6)]
		private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_AddedBy", Order = 7)]
		private string _AddedBy;





        public ShippingCostDependencyInfo()
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
		
	
		public int ShippingProductCostID
		{
			get
			{
				return this._ShippingProductCostID;
			}
			set
			{
				if ((this._ShippingProductCostID != value))
				{
					this._ShippingProductCostID = value;
				}
			}
		}

        public int ShippingMethodID
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
		
		public string Cost
		{
			get
			{
				return this._Cost;
			}
			set
			{
				if ((this._Cost != value))
				{
					this._Cost = value;
				}
			}
		}
		

		public System.Nullable<decimal> RateValue
		{
			get
			{
				return this._RateValue;
			}
			set
			{
				if ((this._RateValue != value))
				{
					this._RateValue = value;
				}
			}
		}

        public string IsRateInPercentage
        {
            get
            {
                return this._IsRateInPercentage;
            }
            set
            {
                if ((this._IsRateInPercentage != value))
                {
                    this._IsRateInPercentage = value;
                }
            }
        }

        //public  string IsWeightInPercentage
        //{
        //    get
        //    {
        //        return this._IsWeightInPercentage;
        //    }
        //    set
        //    {
        //        if ((this._IsWeightInPercentage != value))
        //        {
        //            this._IsWeightInPercentage = value;
        //        }
        //    }
        //}
	
		public System.Nullable<System.DateTime> AddedOn
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
	
		public string AddedBy
		{
			get
			{
				return this._AddedBy;
			}
			set
			{
				if ((this._AddedBy != value))
				{
					this._AddedBy = value;
				}
			}
		}
		
		
		
    }
}
