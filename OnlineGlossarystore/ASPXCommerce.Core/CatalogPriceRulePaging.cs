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
using System.Text;
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
    public class CatalogPriceRulePaging
    {
        [DataMember(Name = "_RowTotal", Order = 0)]
        private int _RowTotal;

        [DataMember(Name = "_CatalogPriceRuleID", Order = 1)]
        private int _CatalogPriceRuleID;

        [DataMember(Name = "_CatalogPriceRuleName", Order = 2)]
        private string _CatalogPriceRuleName;

        [DataMember(Name = "_FromDate", Order = 3)]
        private System.Nullable<System.DateTime> _FromDate;

        [DataMember(Name = "_ToDate", Order = 4)]
        private System.Nullable<System.DateTime> _ToDate;

        [DataMember(Name = "_IsActive", Order = 5)]
        private System.Nullable<bool> _IsActive;

        [DataMember(Name = "_Priority", Order = 6)]
        private int _Priority;

        //private int _RowNumber;

        public CatalogPriceRulePaging()
        {

        }
                
        public int RowTotal
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
        
        public int CatalogPriceRuleID
        {
            get
            {
                return this._CatalogPriceRuleID;
            }
            set
            {
                if ((this._CatalogPriceRuleID != value))
                {
                    this._CatalogPriceRuleID = value;
                }
            }
        }
       
        public string CatalogPriceRuleName
        {
            get
            {
                return this._CatalogPriceRuleName;
            }
            set
            {
                if ((this._CatalogPriceRuleName != value))
                {
                    this._CatalogPriceRuleName = value;
                }
            }
        }
        
        public System.Nullable<System.DateTime> FromDate
        {
            get
            {
                return this._FromDate;
            }
            set
            {
                if ((this._FromDate != value))
                {
                    this._FromDate = value;
                }
            }
        }
        
        public System.Nullable<System.DateTime> ToDate
        {
            get { return _ToDate; }
            set { _ToDate = value; }
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
        [DataMember(Name = "RowNumber", Order = 6)]
        public int Priority
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
    }
}
