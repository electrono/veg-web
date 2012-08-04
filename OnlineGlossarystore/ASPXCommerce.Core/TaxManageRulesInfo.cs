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
    public class TaxManageRulesInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_TaxManageRuleID", Order = 1)]
		private int _TaxManageRuleID;

        [DataMember(Name = "_TaxManageRuleName", Order = 2)]
		private string _TaxManageRuleName;

        [DataMember(Name = "_TaxCustomerClassName", Order = 3)]
		private string _TaxCustomerClassName;

        [DataMember(Name = "_TaxItemClassName", Order = 4)]
		private string _TaxItemClassName;

        [DataMember(Name = "_TaxRateTitle", Order = 5)]
		private string _TaxRateTitle;

        [DataMember(Name = "_Priority", Order = 6)]
		private System.Nullable<int> _Priority;

        [DataMember(Name = "_DisplayOrder", Order = 7)]
		private System.Nullable<int> _DisplayOrder;

        public TaxManageRulesInfo()
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

		public int TaxManageRuleID
		{
			get
			{
				return this._TaxManageRuleID;
			}
			set
			{
				if ((this._TaxManageRuleID != value))
				{
					this._TaxManageRuleID = value;
				}
			}
		}

		public string TaxManageRuleName
		{
			get
			{
				return this._TaxManageRuleName;
			}
			set
			{
				if ((this._TaxManageRuleName != value))
				{
					this._TaxManageRuleName = value;
				}
			}
		}

		public string TaxCustomerClassName
		{
			get
			{
				return this._TaxCustomerClassName;
			}
			set
			{
				if ((this._TaxCustomerClassName != value))
				{
					this._TaxCustomerClassName = value;
				}
			}
		}

		public string TaxItemClassName
		{
			get
			{
				return this._TaxItemClassName;
			}
			set
			{
				if ((this._TaxItemClassName != value))
				{
					this._TaxItemClassName = value;
				}
			}
		}

		public string TaxRateTitle
		{
			get
			{
				return this._TaxRateTitle;
			}
			set
			{
				if ((this._TaxRateTitle != value))
				{
					this._TaxRateTitle = value;
				}
			}
		}

		public System.Nullable<int> Priority
		{
			get
			{
				return this._Priority;
			}
			set
			{
				if ((this._Priority != value))
				{
					this._Priority = value;
				}
			}
		}

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
    }
}
