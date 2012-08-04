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
    public class TaxRateInfo
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_TaxRateID", Order = 1)]
		private int _TaxRateID;

        [DataMember(Name = "_TaxRateTitle", Order = 2)]
		private string _TaxRateTitle;

        [DataMember(Name = "_Country", Order = 3)]
		private string _Country;

        [DataMember(Name = "_State", Order = 4)]
		private string _State;

        [DataMember(Name = "_ZipPostCode", Order = 5)]
        private string _ZipPostCode;

        [DataMember(Name = "_IsZipPostRange", Order = 6)]
        private string _IsZipPostRange;

        [DataMember(Name = "_TaxRateValue", Order = 7)]
		private System.Nullable<decimal> _TaxRateValue;

        [DataMember(Name = "_IsPercent", Order = 8)]
        private string _IsPercent;

        public TaxRateInfo()
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
		
		public int TaxRateID
		{
			get
			{
				return this._TaxRateID;
			}
			set
			{
				if ((this._TaxRateID != value))
				{
					this._TaxRateID = value;
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
		
		public string Country
		{
			get
			{
				return this._Country;
			}
			set
			{
				if ((this._Country != value))
				{
					this._Country = value;
				}
			}
		}
		
		public string State
		{
			get
			{
				return this._State;
			}
			set
			{
				if ((this._State != value))
				{
					this._State = value;
				}
			}
		}

        public string ZipPostCode
		{
			get
			{
                return this._ZipPostCode;
			}
			set
			{
                if ((this._ZipPostCode != value))
				{
                    this._ZipPostCode = value;
				}
			}
		}

        public string IsZipPostRange
		{
			get
			{
                return this._IsZipPostRange;
			}
			set
			{
                if ((this._IsZipPostRange != value))
				{
                    this._IsZipPostRange = value;
				}
			}
		}
		
		
		public System.Nullable<decimal> TaxRateValue
		{
			get
			{
				return this._TaxRateValue;
			}
			set
			{
				if ((this._TaxRateValue != value))
				{
					this._TaxRateValue = value;
				}
			}
		}

        public string IsPercent
        {
            get
            {
                return this._IsPercent;
            }
            set
            {
                if ((this._IsPercent != value))
                {
                    this._IsPercent = value;
                }
            }
        }
    }
}
