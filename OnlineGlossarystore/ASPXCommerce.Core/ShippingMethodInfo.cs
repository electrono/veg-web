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
    public class ShippingMethodInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ShippingMethodID", Order = 1)]
		private int _ShippingMethodID;

        [DataMember(Name = "_ShippingMethodName", Order = 2)]
		private string _ShippingMethodName;

        [DataMember(Name = "_ShippingProviderID", Order = 3)]
        private int _ShippingProviderID;

        [DataMember(Name = "_ImagePath", Order = 4)]
		private string _ImagePath;

        [DataMember(Name = "_AlternateText", Order = 5)]
		private string _AlternateText;

        [DataMember(Name = "_DisplayOrder", Order = 6)]
		private int _DisplayOrder;

        [DataMember(Name = "_DeliveryTime", Order = 7)]
		private string _DeliveryTime;

        [DataMember(Name = "_WeightLimitFrom", Order = 8)]
		private System.Nullable<decimal> _WeightLimitFrom;

        [DataMember(Name = "_WeightLimitTo", Order = 9)]
		private System.Nullable<decimal> _WeightLimitTo;

  		 [DataMember(Name = "_IsActive", Order = 10)]
		 private string _IsActive;


        [DataMember(Name = "_AddedOn", Order = 11)]
		private System.Nullable<System.DateTime> _AddedOn;


        [DataMember(Name = "_AddedBy", Order = 12)]
		private string _AddedBy;

        [DataMember(Name = "_ShippingCost", Order = 13)]
        private string _ShippingCost;
	

        public ShippingMethodInfo()
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

        public int ShippingProviderID
        {
            get
            {
                return this._ShippingProviderID;
            }
            set
            {
                if ((this._ShippingProviderID != value))
                {
                    this._ShippingProviderID = value;
                }
            }
        }
		
		public string ImagePath
		{
			get
			{
				return this._ImagePath;
			}
			set
			{
				if ((this._ImagePath != value))
				{
					this._ImagePath = value;
				}
			}
		}
		
		public string AlternateText
		{
			get
			{
				return this._AlternateText;
			}
			set
			{
				if ((this._AlternateText != value))
				{
					this._AlternateText = value;
				}
			}
		}
		
		public int DisplayOrder
		{
			get
			{
				return this._DisplayOrder;
			}
			set
			{
				if ((this._DisplayOrder != value))
				{
					this._DisplayOrder = value;
				}
			}
		}
		
		public string DeliveryTime
		{
			get
			{
				return this._DeliveryTime;
			}
			set
			{
				if ((this._DeliveryTime != value))
				{
					this._DeliveryTime = value;
				}
			}
		}
		
		public System.Nullable<decimal> WeightLimitFrom
		{
			get
			{
				return this._WeightLimitFrom;
			}
			set
			{
				if ((this._WeightLimitFrom != value))
				{
					this._WeightLimitFrom = value;
				}
			}
		}
		
		public System.Nullable<decimal> WeightLimitTo
		{
			get
			{
				return this._WeightLimitTo;
			}
			set
			{
				if ((this._WeightLimitTo != value))
				{
					this._WeightLimitTo = value;
				}
			}
		}		

		public string IsActive

        {
            get
            {
                return this._IsActive;
            }
            set
            {
                if ((this._IsActive != value))
                {
                    this._IsActive = value;
                }
            }
        }

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

        public string ShippingCost
        {
            get
            {
                return this._ShippingCost;
            }
            set
            {
                if ((this._ShippingCost != value))
                {
                    this._ShippingCost = value;
                }
            }
        }

    }
}
