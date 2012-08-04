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
    public class ReturnRequestAction
    {
        [DataMember(Name = "_IsActive", Order = 4)]
        private System.Nullable<bool> _IsActive;

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
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;
        [DataMember(Name = "_ActionID", Order = 1)]
		private int _ActionID;
        [DataMember(Name = "_Action", Order = 2)]
		private string _Action;
        [DataMember(Name = "_DisplayOrder", Order = 3)]
		private System.Nullable<int> _DisplayOrder;
		
		private System.Nullable<long> _RowNumber;

        public ReturnRequestAction()
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
		
		public int ActionID
		{
			get
			{
				return this._ActionID;
			}
			set
			{
				if ((this._ActionID != value))
				{
					this._ActionID = value;
				}
			}
		}
		
		public string Action
		{
			get
			{
				return this._Action;
			}
			set
			{
				if ((this._Action != value))
				{
					this._Action = value;
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
