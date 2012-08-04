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
    public class ReturnRequestList
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
       private System.Nullable<int> _RowTotal;
        [DataMember(Name = "_ReturnID", Order =1)]
		private int _ReturnID;
        [DataMember(Name = "_UserName", Order = 3)]
		private string _UserName;
        [DataMember(Name = "_Reason", Order = 4)]
		private string _Reason;
        [DataMember(Name = "_AddedOn", Order = 5)]
        private DateTime _AddedOn;
        [DataMember(Name = "_Status", Order = 2)]
		private string _Status;
        [DataMember(Name = "_OrderID", Order = 7)]
		private System.Nullable<int> _OrderID;
        [DataMember(Name = "_Quantity", Order = 8)]
		private System.Nullable<int> _Quantity;
        [DataMember(Name = "_ReturnAction", Order = 6)]
		private string _ReturnAction;
		
		private System.Nullable<long> _RowNumber;

        public ReturnRequestList()
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
		
		
		public int ReturnID
		{
			get
			{
				return this._ReturnID;
			}
			set
			{
				if ((this._ReturnID != value))
				{
					this._ReturnID = value;
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

        public DateTime AddedOn
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
		
		
		public string Reason
		{
			get
			{
				return this._Reason;
			}
			set
			{
				if ((this._Reason != value))
				{
					this._Reason = value;
				}
			}
		}
		
		
		public string Status
		{
			get
			{
				return this._Status;
			}
			set
			{
				if ((this._Status != value))
				{
					this._Status = value;
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
		
		
		public System.Nullable<int> Quantity
		{
			get
			{
				return this._Quantity;
			}
			set
			{
				if ((this._Quantity != value))
				{
					this._Quantity = value;
				}
			}
		}
		
		
		public string ReturnAction
		{
			get
			{
				return this._ReturnAction;
			}
			set
			{
				if ((this._ReturnAction != value))
				{
					this._ReturnAction = value;
				}
			}
		}
		
	
		public System.Nullable<long> RowNumber
		{
			get
			{
				return this._RowNumber;
			}
			set
			{
				if ((this._RowNumber != value))
				{
					this._RowNumber = value;
				}
			}
		}
    	
		
		
	}
}
