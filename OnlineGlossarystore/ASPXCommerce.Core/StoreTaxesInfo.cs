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

   public class StoreTaxesInfo
    {
        #region Constructor
       public StoreTaxesInfo()
        {
        }
       #endregion
       #region Private Fields
       [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

       [DataMember(Name = "_TaxManageRuleName", Order = 1)]
       private string _TaxManageRuleName;

       [DataMember(Name = "_TaxRate", Order = 2)]
       private string _TaxRate;

       [DataMember(Name = "_Quantity", Order = 3)]
       private int _Quantity;

       [DataMember(Name = "_IsPercent", Order = 4)]
       private bool _IsPercent;

       [DataMember(Name = "_NoOfOrders", Order = 6)]
       private int _NoOfOrders;

       [DataMember(Name = "_TotalTaxAmount", Order = 6)]
       private string _TotalTaxAmount;

       [DataMember(Name = "_AddedOn", Order = 7)]
       private string _AddedOn;
        #endregion

        #region Public Fields
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

        public string TaxRate
        {
            get
            {
                return this._TaxRate;
            }
            set
            {
                if ((this._TaxRate != value))
                {
                    this._TaxRate = value;
                }
            }
        }

        public int Quantity
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

        public bool IsPercent
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

        public int NoOfOrders
        {
            get
            {
                return this._NoOfOrders;
            }
            set
            {
                if ((this._NoOfOrders != value))
                {
                    this._NoOfOrders = value;
                }
            }
        }



        public string TotalTaxAmount
        {
            get
            {
                return this._TotalTaxAmount;
            }
            set
            {
                if ((this._TotalTaxAmount != value))
                {
                    this._TotalTaxAmount = value;
                }
            }
        }

        public string AddedOn
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

        #endregion
    }
}
