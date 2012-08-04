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
     public class CostVariantsvalueInfo
    {
        private int _CostVariantsValueID;
		
		private string _CostVariantsValueName;
		
		private string _CostVariantsPriceValue;
		
		private string _CostVariantsWeightValue;
		
		private System.Nullable<bool> _IsPriceInPercentage;
		
		private System.Nullable<bool> _IsWeightInPercentage;
		
		private System.Nullable<int> _DisplayOrder;
		
		private System.Nullable<bool> _IsActive;
		
		private System.Nullable<System.DateTime> _AddedOn;
		
		private string _AddedBy;

        public CostVariantsvalueInfo()
		{
		}
		
		[DataMember]
		public int CostVariantsValueID
		{
			get
			{
				return this._CostVariantsValueID;
			}
			set
			{
				if ((this._CostVariantsValueID != value))
				{
					this._CostVariantsValueID = value;
				}
			}
		}

        [DataMember]
		public string CostVariantsValueName
		{
			get
			{
				return this._CostVariantsValueName;
			}
			set
			{
				if ((this._CostVariantsValueName != value))
				{
					this._CostVariantsValueName = value;
				}
			}
		}

        [DataMember]
		public string CostVariantsPriceValue
		{
			get
			{
				return this._CostVariantsPriceValue;
			}
			set
			{
				if ((this._CostVariantsPriceValue != value))
				{
					this._CostVariantsPriceValue = value;
				}
			}
		}

        [DataMember]
		public string CostVariantsWeightValue
		{
			get
			{
				return this._CostVariantsWeightValue;
			}
			set
			{
				if ((this._CostVariantsWeightValue != value))
				{
					this._CostVariantsWeightValue = value;
				}
			}
		}

        [DataMember]
		public System.Nullable<bool> IsPriceInPercentage
		{
			get
			{
				return this._IsPriceInPercentage;
			}
			set
			{
				if ((this._IsPriceInPercentage != value))
				{
					this._IsPriceInPercentage = value;
				}
			}
		}

        [DataMember]
		public System.Nullable<bool> IsWeightInPercentage
		{
			get
			{
				return this._IsWeightInPercentage;
			}
			set
			{
				if ((this._IsWeightInPercentage != value))
				{
					this._IsWeightInPercentage = value;
				}
			}
		}

        [DataMember]
		public System.Nullable<int> DisplayOrder
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

        [DataMember]
		public System.Nullable<bool> IsActive
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

        [DataMember]
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

        [DataMember]
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
