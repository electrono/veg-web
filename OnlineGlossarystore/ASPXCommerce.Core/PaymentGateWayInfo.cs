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
   public class PaymentGateWayInfo
    {
       public PaymentGateWayInfo()
       {

       }
        [DataMember(Name = "_RowTotal", Order = 0)]
       private System.Nullable<int> _RowTotal;
		
        [DataMember(Name = "_PaymentGatewayTypeID", Order = 1)]
		private int _PaymentGatewayTypeID;
		
        [DataMember(Name = "_PaymentGatewayTypeName", Order = 2)]
		private string _PaymentGatewayTypeName;

		[DataMember(Name = "_IsActive", Order = 3)]
		private System.Nullable<bool> _IsActive;

        [DataMember(Name = "_Edit", Order = 4)]
        private string _Edit;

        [DataMember(Name = "_Setting", Order = 5)]
        private string _Setting;

        [DataMember(Name = "_HdnEdit", Order = 6)]
        private string _HdnEdit;

        [DataMember(Name = "_HdnSetting", Order = 7)]
        private string _HdnSetting;

        [DataMember(Name = "_HdnPaymentGatewayTypeID", Order = 8)]
        private int _HdnPaymentGatewayTypeID;

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
		
		
		public int PaymentGatewayTypeID
		{
			get
			{
				return this._PaymentGatewayTypeID;
			}
			set
			{
				if ((this._PaymentGatewayTypeID != value))
				{
					this._PaymentGatewayTypeID = value;
				}
			}
		}
		
		
		public string PaymentGatewayTypeName
		{
			get
			{
				return this._PaymentGatewayTypeName;
			}
			set
			{
				if ((this._PaymentGatewayTypeName != value))
				{
					this._PaymentGatewayTypeName = value;
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
        public string Edit
        {
            get
            {
                return this._Edit;
            }
            set
            {
                if ((this._Edit != value))
                {
                    this._Edit = value;
                }
            }
        }

        public string Setting
        {
            get
            {
                return this._Setting;
            }
            set
            {
                if ((this._Setting != value))
                {
                    this._Setting = value;
                }
            }
        }
        public string HdnEdit
        {
          get
            {
                return this._HdnEdit;
            }
            set
            {
                if ((this._HdnEdit != value))
                {
                    this._HdnEdit = value;
                }
            }
        }


        public string HdnSetting
        {
            get
            {
                return this._HdnSetting;
            }
            set
            {
                if ((this._HdnSetting != value))
                {
                    this._HdnSetting = value;
                }
            }
        }
        public int HdnPaymentGatewayTypeID
        {
            get
            {
                return this._HdnPaymentGatewayTypeID;
            }
            set
            {
                if ((this._HdnPaymentGatewayTypeID != value))
                {
                    this._HdnPaymentGatewayTypeID = value;
                }
            }
        }

	}
 }

