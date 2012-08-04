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
    public class OrderStatusListInfo
    {
        public OrderStatusListInfo()
        {
        }

        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "OrderStatusID", Order = 1)]
		private int _OrderStatusID;

        [DataMember(Name = "OrderStatusAliasName", Order = 2)]
        private string _OrderStatusAliasName;
               
        [DataMember(Name = "AliasToolTip", Order = 3)]
		private string _AliasToolTip;

        [DataMember(Name = "AliasHelp", Order = 4)]
		private string _AliasHelp;

        [DataMember(Name = "AddedOn", Order = 5)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_IsSystemUsed", Order = 6)]
        private System.Nullable<bool> _IsSystemUsed;

        [DataMember(Name = "IsActive", Order = 7)]
        private System.Nullable<bool> _IsActive;
		
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

		public int OrderStatusID
		{
			get
			{
				return this._OrderStatusID;
			}
			set
			{
				if ((this._OrderStatusID != value))
				{
					this._OrderStatusID = value;
				}
			}
		}

        public string OrderStatusAliasName
        {
            get
            {
                return this._OrderStatusAliasName;
            }
            set
            {
                if ((this._OrderStatusAliasName != value))
                {
                    this._OrderStatusAliasName = value;
                }
            }
        }

        public string AliasToolTip
        {
            get
            {
                return this._AliasToolTip;
            }
            set
            {
                if ((this._AliasToolTip != value))
                {
                    this._AliasToolTip = value;
                }
            }
        }

        public string AliasHelp
        {
            get
            {
                return this._AliasHelp;
            }
            set
            {
                if ((this._AliasHelp != value))
                {
                    this._AliasHelp = value;
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

        public System.Nullable<bool> IsSystemUsed
        {
            get
            {
                return this._IsSystemUsed;
            }
            set
            {
                if ((this._IsSystemUsed != value))
                {
                    this._IsSystemUsed = value;
                }
            }
        }
		
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
    }
}
