﻿/*
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
    public class TaxRulesInfo
    {
        [DataMember(Name = "_TaxManageRuleID", Order = 1)]
        private int _TaxManageRuleID;

        [DataMember(Name = "_TaxManageRuleName", Order = 2)]
        private string _TaxManageRuleName;

        public TaxRulesInfo()
		{
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
    }
}
