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
    public class CatalogPricingRuleInfo
    {
        private CatalogPriceRule _CatalogPriceRule;

        private List<CatalogPriceRuleCondition> _CatalogPriceRuleConditions;

        private List<CatalogPriceRuleRole> _CatalogPriceRuleRoles;

        [DataMember(Name = "CatalogPriceRule", Order = 0)]
        public CatalogPriceRule CatalogPriceRule
        {
            get { return _CatalogPriceRule; }
            set { _CatalogPriceRule = value; }
        }

        [DataMember(Name = "CatalogPriceRuleConditions", Order = 1)]
        public List<CatalogPriceRuleCondition> CatalogPriceRuleConditions
        {
            get { return _CatalogPriceRuleConditions; }
            set { _CatalogPriceRuleConditions = value; }
        }

        [DataMember(Name = "CatalogPriceRuleRoles", Order = 2)]
        public List<CatalogPriceRuleRole> CatalogPriceRuleRoles
        {
            get { return _CatalogPriceRuleRoles; }
            set { _CatalogPriceRuleRoles = value; }
        }

       
    }

    [DataContract]
    [Serializable]
    public class CatalogConditionDetail
    {
        private System.Nullable<int> _CatalogPriceRuleConditionID;

        private System.Nullable<int> _CatalogPriceRuleID;

        private System.Nullable<int> _AttributeID;

        private System.Nullable<int> _RuleOperatorID;

        private string _Value;

        private System.Nullable<int> _Priority;

        public CatalogConditionDetail()
        {
        }

        [DataMember(Name = "CatalogPriceRuleConditionID", Order = 0)]
        public System.Nullable<int> CatalogPriceRuleConditionID
        {
            get
            {
                return this._CatalogPriceRuleConditionID;
            }
            set
            {
                if ((this._CatalogPriceRuleConditionID != value))
                {
                    this._CatalogPriceRuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "CatalogPriceRuleID", Order = 1)]
        public System.Nullable<int> CatalogPriceRuleID
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

        [DataMember(Name = "AttributeID", Order = 2)]
        public System.Nullable<int> AttributeID
        {
            get
            {
                return this._AttributeID;
            }
            set
            {
                if ((this._AttributeID != value))
                {
                    this._AttributeID = value;
                }
            }
        }

        [DataMember(Name = "RuleOperatorID", Order = 3)]
        public System.Nullable<int> RuleOperatorID
        {
            get
            {
                return this._RuleOperatorID;
            }
            set
            {
                if ((this._RuleOperatorID != value))
                {
                    this._RuleOperatorID = value;
                }
            }
        }

        [DataMember(Name = "Value", Order = 4)]
        public string Value
        {
            get
            {
                return this._Value;
            }
            set
            {
                if ((this._Value != value))
                {
                    this._Value = value;
                }
            }
        }

        [DataMember(Name = "Priority", Order = 5)]
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
    }

    [DataContract]
    [Serializable]
    public class CatalogPriceRule
    {
        private int _CatalogPriceRuleID;

        private string _CatalogPriceRuleName;

        private string _CatalogPriceRuleDescription;

        private System.Nullable<int> _Apply;

        private string _Value;

        private System.Nullable<bool> _IsFurtherProcessing;

        private System.Nullable<DateTime> _FromDate;

        private System.Nullable<DateTime> _ToDate;

        private System.Nullable<int> _Priority;

        private System.Nullable<bool> _IsActive;
        //private CatalogPriceRuleCondition _CatalogPriceRuleConditions;

        public CatalogPriceRule()
        {

        }
        [DataMember(Name = "CatalogPriceRuleID", Order = 0)]
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
        [DataMember(Name = "CatalogPriceRuleName", Order = 1)]
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
        [DataMember(Name = "CatalogPriceRuleDescription", Order = 2)]
        public string CatalogPriceRuleDescription
        {
            get
            {
                return this._CatalogPriceRuleDescription;
            }
            set
            {
                if ((this._CatalogPriceRuleDescription != value))
                {
                    this._CatalogPriceRuleDescription = value;
                }
            }
        }
        [DataMember(Name = "Apply", Order = 3)]
        public System.Nullable<int> Apply
        {
            get
            {
                return this._Apply;
            }
            set
            {
                if ((this._Apply != value))
                {
                    this._Apply = value;
                }
            }
        }
        [DataMember(Name = "Value", Order = 4)]
        public string Value
        {
            get
            {
                return this._Value;
            }
            set
            {
                if ((this._Value != value))
                {
                    this._Value = value;
                }
            }
        }
        [DataMember(Name = "IsFurtherProcessing", Order = 5)]
        public System.Nullable<bool> IsFurtherProcessing
        {
            get
            {
                return this._IsFurtherProcessing;
            }
            set
            {
                if ((this._IsFurtherProcessing != value))
                {
                    this._IsFurtherProcessing = value;
                }
            }
        }
        [DataMember(Name = "FromDate", Order = 6)]
        public System.Nullable<DateTime> FromDate
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
        [DataMember(Name = "ToDate", Order = 7)]
        public System.Nullable<DateTime> ToDate
        {
            get
            {
                return this._ToDate;
            }
            set
            {
                if ((this._ToDate != value))
                {
                    this._ToDate = value;
                }
            }
        }
        [DataMember(Name = "Priority", Order = 8)]
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
        [DataMember(Name = "IsActive", Order = 9)]
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

    [DataContract]
    [Serializable]
    public class CatalogPriceRuleCondition
    {
        private int _CatalogPriceRuleConditionID;

        private System.Nullable<int> _CatalogPriceRuleID;

        private System.Nullable<bool> _IsAll;

        private System.Nullable<bool> _IsTrue;

        private int _ParentID;

        private List<CatalogConditionDetail> _CatalogConditionDetail;        

        public CatalogPriceRuleCondition()
        {
        }

        [DataMember(Name = "CatalogPriceRuleConditionID", Order = 0)]
        public int CatalogPriceRuleConditionID
        {
            get
            {
                return this._CatalogPriceRuleConditionID;
            }
            set
            {
                if ((this._CatalogPriceRuleConditionID != value))
                {
                    this._CatalogPriceRuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "CatalogPriceRuleID", Order = 1)]
        public System.Nullable<int> CatalogPriceRuleID
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

        [DataMember(Name = "IsAll", Order = 2)]
        public System.Nullable<bool> IsAll
        {
            get
            {
                return this._IsAll;
            }
            set
            {
                if ((this._IsAll != value))
                {
                    this._IsAll = value;
                }
            }
        }

        [DataMember(Name = "IsTrue", Order = 3)]
        public System.Nullable<bool> IsTrue
        {
            get
            {
                return this._IsTrue;
            }
            set
            {
                if ((this._IsTrue != value))
                {
                    this._IsTrue = value;
                }
            }
        }

        [DataMember(Name = "ParentID", Order = 4)]
        public int ParentID
        {
            get
            {
                return this._ParentID;
            }
            set
            {
                if ((this._ParentID != value))
                {
                    this._ParentID = value;
                }
            }
        }

        [DataMember(Name = "CatalogConditionDetail", Order = 5)]
        public List<CatalogConditionDetail> CatalogConditionDetail
        {
            get
            {
                return this._CatalogConditionDetail;
            }
            set
            {
                this._CatalogConditionDetail = value;

            }
        }
    }

    [DataContract]
    [Serializable]
    public class CatalogPriceRuleRole
    {
        private int _CatalogPriceRuleID;

        private string _RoleID;

        public CatalogPriceRuleRole()
        {
        }
        [DataMember(Name = "CatalogPriceRuleID", Order = 0)]
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

        [DataMember(Name = "RoleID", Order = 1)]
        public string RoleID
        {
            get
            {
                return this._RoleID;
            }
            set
            {
                if ((this._RoleID != value))
                {
                    this._RoleID = value;
                }
            }
        }
    }
}
