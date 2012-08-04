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
    public class CartPricingRuleInfo
    {
        private CartPriceRule _CartPriceRule;

        private List<RuleCondition> _lstRuleCondition;

        private List<CartPriceRuleCondition> _lstCartPriceRuleConditions;

        private List<ProductAttributeRuleCondition> _lstProductAttributeRuleCondition;

        private List<ProductSubSelectionRuleCondition> _lstProductSubSelectionRuleCondition;

        private List<CartPriceRuleRole> _lstCartPriceRuleRoles;

        private List<CartPriceRuleStore> _lstCartPriceRuleStores;

       
        [DataMember(Name = "CartPriceRule", Order = 0)]
        public CartPriceRule CartPriceRule
        {
            get { return _CartPriceRule; }
            set { _CartPriceRule = value; }
        }

        [DataMember(Name = "lstRuleCondition", Order = 1)]
        public List<RuleCondition> lstRuleCondition
        {
            get { return _lstRuleCondition; }
            set { _lstRuleCondition = value; }
        }


        [DataMember(Name = "lstCartPriceRuleConditions", Order = 2)]
        public List<CartPriceRuleCondition> lstCartPriceRuleConditions
        {
            get { return _lstCartPriceRuleConditions; }
            set { _lstCartPriceRuleConditions = value; }
        }

        [DataMember(Name = "lstProductAttributeRuleCondition", Order = 3)]
        public List<ProductAttributeRuleCondition> lstProductAttributeRuleCondition
        {
            get { return _lstProductAttributeRuleCondition; }
            set { _lstProductAttributeRuleCondition = value; }
        }

        [DataMember(Name = "lstProductSubSelectionRuleCondition", Order = 4)]
        public List<ProductSubSelectionRuleCondition> lstProductSubSelectionRuleCondition
        {
            get { return _lstProductSubSelectionRuleCondition; }
            set { _lstProductSubSelectionRuleCondition = value; }
        }

        [DataMember(Name = "lstCartPriceRuleRoles", Order = 5)]
        public List<CartPriceRuleRole> lstCartPriceRuleRoles
        {
            get { return _lstCartPriceRuleRoles; }
            set { _lstCartPriceRuleRoles = value; }
        }

        [DataMember(Name = "lstCartPriceRuleStores", Order = 6)]
        public List<CartPriceRuleStore> lstCartPriceRuleStores
        {
            get { return _lstCartPriceRuleStores; }
            set { _lstCartPriceRuleStores = value; }
        }
    }

    [DataContract]
    [Serializable]
    public class CartConditionDetail
    {
        private System.Nullable<int> _CartPriceRuleConditionDetailID;

        private int _RuleConditionID;

        private System.Nullable<int> _CartPriceRuleID;

        private System.Nullable<int> _AttributeID;

        private System.Nullable<int> _RuleOperatorID;

        private string _Value;

        private System.Nullable<int> _Priority;

        public CartConditionDetail()
        {
        }

        [DataMember(Name = "CartPriceRuleConditionDetailID", Order = 0)]
        public System.Nullable<int> CartPriceRuleConditionDetailID
        {
            get
            {
                return this._CartPriceRuleConditionDetailID;
            }
            set
            {
                if ((this._CartPriceRuleConditionDetailID != value))
                {
                    this._CartPriceRuleConditionDetailID = value;
                }
            }
        }

        [DataMember(Name = "RuleConditionID", Order = 1)]
        public int RuleConditionID
        {
            get
            {
                return this._RuleConditionID;
            }
            set
            {
                if ((this._RuleConditionID != value))
                {
                    this._RuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "CartPriceRuleID", Order = 2)]
        public System.Nullable<int> CartPriceRuleID
        {
            get
            {
                return this._CartPriceRuleID;
            }
            set
            {
                if ((this._CartPriceRuleID != value))
                {
                    this._CartPriceRuleID = value;
                }
            }
        }

        [DataMember(Name = "AttributeID", Order = 3)]
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

        [DataMember(Name = "RuleOperatorID", Order = 4)]
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

        [DataMember(Name = "Value", Order = 5)]
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

        [DataMember(Name = "Priority", Order = 6)]
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
    public class CartPriceRule
    {
        private int _CartPriceRuleID;

        private string _CartPriceRuleName;

        private string _CartPriceRuleDescription;

        private System.Nullable<int> _Apply;

        private string _Value;
        private System.Nullable<int> _DiscountQuantity;
        private System.Nullable<int> _DiscountStep;
        private System.Nullable<bool> _ApplytoShippingAmount;
        private System.Nullable<int> _FreeShipping;
        private System.Nullable<bool> _IsFurtherProcessing;

        private System.Nullable<System.DateTime> _FromDate;

        private System.Nullable<System.DateTime> _ToDate;

        private System.Nullable<int> _Priority;

        private System.Nullable<bool> _IsActive;
        public CartPriceRule()
        {

        }
        [DataMember(Name = "CartPriceRuleID", Order = 0)]
        public int CartPriceRuleID
        {
            get
            {
                return this._CartPriceRuleID;
            }
            set
            {
                if ((this._CartPriceRuleID != value))
                {
                    this._CartPriceRuleID = value;
                }
            }
        }
        [DataMember(Name = "CartPriceRuleName", Order = 1)]
        public string CartPriceRuleName
        {
            get
            {
                return this._CartPriceRuleName;
            }
            set
            {
                if ((this._CartPriceRuleName != value))
                {
                    this._CartPriceRuleName = value;
                }
            }
        }
        [DataMember(Name = "CartPriceRuleDescription", Order = 2)]
        public string CartPriceRuleDescription
        {
            get
            {
                return this._CartPriceRuleDescription;
            }
            set
            {
                if ((this._CartPriceRuleDescription != value))
                {
                    this._CartPriceRuleDescription = value;
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
        [DataMember(Name = "DiscountQuantity", Order = 5)]
        public System.Nullable<int> DiscountQuantity
        {
            get
            {
                return this._DiscountQuantity;
            }
            set
            {
                if ((this._DiscountQuantity != value))
                {
                    this._DiscountQuantity = value;
                }
            }
        }
        [DataMember(Name = "DiscountStep", Order = 6)]
        public System.Nullable<int> DiscountStep
        {
            get
            {
                return this._DiscountStep;
            }
            set
            {
                if ((this._DiscountStep != value))
                {
                    this._DiscountStep = value;
                }
            }
        }
        [DataMember(Name = "ApplytoShippingAmount", Order = 7)]
        public System.Nullable<bool> ApplytoShippingAmount
        {
            get
            {
                return this._ApplytoShippingAmount;
            }
            set
            {
                if ((this._ApplytoShippingAmount != value))
                {
                    this._ApplytoShippingAmount = value;
                }
            }
        }
        [DataMember(Name = "FreeShipping", Order = 8)]
        public System.Nullable<int> FreeShipping
        {
            get
            {
                return this._FreeShipping;
            }
            set
            {
                if ((this._FreeShipping != value))
                {
                    this._FreeShipping = value;
                }
            }
        }
        [DataMember(Name = "IsFurtherProcessing", Order = 9)]
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
        [DataMember(Name = "FromDate", Order = 10)]
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
        [DataMember(Name = "ToDate", Order = 11)]
        public System.Nullable<System.DateTime> ToDate
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
        [DataMember(Name = "Priority", Order = 12)]
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
        [DataMember(Name = "IsActive", Order = 13)]
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
    public class RuleCondition
    {
        private System.Nullable<int> _RuleConditionID;

        private string _RuleConditionType;

        private int _CartPriceRuleID;

        private System.Nullable<int> _ParentID;

        private List<CartConditionDetail> _lstCartConditionDetails;

        private List<CartPriceRuleCondition> _lstCartPriceRuleConditions;

        private List<ProductAttributeRuleCondition> _lstProductAttributeRuleConditions;

        private List<ProductSubSelectionRuleCondition> _lstProductSublectionRuleConditions;

        public RuleCondition()
        {

        }

        [DataMember(Name = "RuleConditionID", Order = 0)]
        public System.Nullable<int> RuleConditionID
        {
            get
            {
                return this._RuleConditionID;
            }
            set
            {
                if ((this._RuleConditionID != value))
                {
                    this._RuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "RuleConditionType", Order = 1)]
        public string RuleConditionType
        {
            get
            {
                return this._RuleConditionType;
            }
            set
            {
                if ((this._RuleConditionType != value))
                {
                    this._RuleConditionType = value;
                }
            }
        }

        [DataMember(Name = "CartPriceRuleID", Order = 2)]
        public int CartPriceRuleID
        {
            get
            {
                return this._CartPriceRuleID;
            }
            set
            {
                if ((this._CartPriceRuleID != value))
                {
                    this._CartPriceRuleID = value;
                }
            }
        }

        [DataMember(Name = "ParentID", Order = 3)]
        public System.Nullable<int> ParentID
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

        [DataMember(Name = "lstCartPriceRuleConditions", Order = 4)]
        public List<CartPriceRuleCondition> lstCartPriceRuleConditions
        {
            get { return _lstCartPriceRuleConditions; }
            set { _lstCartPriceRuleConditions = value; }
        }

        [DataMember(Name = "lstProductAttributeRuleConditions", Order = 5)]
        public List<ProductAttributeRuleCondition> lstProductAttributeRuleConditions
        {
            get { return _lstProductAttributeRuleConditions; }
            set { _lstProductAttributeRuleConditions = value; }
        }

        [DataMember(Name = "lstProductSublectionRuleConditions", Order = 6)]
        public List<ProductSubSelectionRuleCondition> lstProductSublectionRuleConditions
        {
            get { return _lstProductSublectionRuleConditions; }
            set { _lstProductSublectionRuleConditions = value; }
        }

        [DataMember(Name = "lstCartConditionDetails", Order = 7)]
        public List<CartConditionDetail> lstCartConditionDetails
        {
            get { return _lstCartConditionDetails; }
            set { _lstCartConditionDetails = value; }
        }
    }

    [DataContract]
    [Serializable]
    public class CartPriceRuleCondition
    {
        private int _CartPriceRuleConditionID;

        private System.Nullable<int> _RuleConditionID;

        private System.Nullable<bool> _IsAll;

        private System.Nullable<bool> _IsTrue;

        private List<CartConditionDetail> _lstCartConditionDetails;

        public CartPriceRuleCondition()
        {
        }

        [DataMember(Name = "CartPriceRuleConditionID", Order = 0)]
        public int CartPriceRuleConditionID
        {
            get
            {
                return this._CartPriceRuleConditionID;
            }
            set
            {
                if ((this._CartPriceRuleConditionID != value))
                {
                    this._CartPriceRuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "RuleConditionID", Order = 1)]
        public System.Nullable<int> RuleConditionID
        {
            get
            {
                return this._RuleConditionID;
            }
            set
            {
                if ((this._RuleConditionID != value))
                {
                    this._RuleConditionID = value;
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

        [DataMember(Name = "lstCartConditionDetails", Order = 4)]
        public List<CartConditionDetail> lstCartConditionDetails
        {
            get { return _lstCartConditionDetails; }
            set { _lstCartConditionDetails = value; }
        }
    }

    [DataContract]
    [Serializable]
    public class ProductAttributeRuleCondition
    {
        private int _ProductAttributeRuleConditionID;

        private System.Nullable<int> _RuleConditionID;

        private System.Nullable<bool> _IsAll;

        private System.Nullable<bool> _IsFound;

        private List<CartConditionDetail> _lstCartConditionDetails;

        public ProductAttributeRuleCondition()
        {
        }

        [DataMember(Name = "ProductAttributeRuleConditionID", Order = 0)]
        public int ProductAttributeRuleConditionID
        {
            get
            {
                return this._ProductAttributeRuleConditionID;
            }
            set
            {
                if ((this._ProductAttributeRuleConditionID != value))
                {
                    this._ProductAttributeRuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "RuleConditionID", Order = 1)]
        public System.Nullable<int> RuleConditionID
        {
            get
            {
                return this._RuleConditionID;
            }
            set
            {
                if ((this._RuleConditionID != value))
                {
                    this._RuleConditionID = value;
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

        [DataMember(Name = "IsFound", Order = 3)]
        public System.Nullable<bool> IsFound
        {
            get
            {
                return this._IsFound;
            }
            set
            {
                if ((this._IsFound != value))
                {
                    this._IsFound = value;
                }
            }
        }

        [DataMember(Name = "lstCartConditionDetails", Order = 4)]
        public List<CartConditionDetail> lstCartConditionDetails
        {
            get { return _lstCartConditionDetails; }
            set { _lstCartConditionDetails = value; }
        }
    }

    [DataContract]
    [Serializable]
    public class ProductSubSelectionRuleCondition
    {
        private int _ProductSubSelectionRuleConditionID;

        private System.Nullable<int> _RuleConditionID;

        private System.Nullable<bool> _IsAll;

        private string _Value;

        private System.Nullable<bool> _IsQuantity;

        private System.Nullable<int> _RuleOperatorID;

        private List<CartConditionDetail> _lstCartConditionDetails;

        public ProductSubSelectionRuleCondition()
        {
        }

        [DataMember(Name = "ProductSubSelectionRuleConditionID", Order = 0)]
        public int ProductSubSelectionRuleConditionID
        {
            get
            {
                return this._ProductSubSelectionRuleConditionID;
            }
            set
            {
                if ((this._ProductSubSelectionRuleConditionID != value))
                {
                    this._ProductSubSelectionRuleConditionID = value;
                }
            }
        }

        [DataMember(Name = "RuleConditionID", Order = 1)]
        public System.Nullable<int> RuleConditionID
        {
            get
            {
                return this._RuleConditionID;
            }
            set
            {
                if ((this._RuleConditionID != value))
                {
                    this._RuleConditionID = value;
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

        [DataMember(Name = "Value", Order = 3)]
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

        [DataMember(Name = "IsQuantity", Order = 4)]
        public System.Nullable<bool> IsQuantity
        {
            get
            {
                return this._IsQuantity;
            }
            set
            {
                if ((this._IsQuantity != value))
                {
                    this._IsQuantity = value;
                }
            }
        }

        [DataMember(Name = "RuleOperatorID", Order = 5)]
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

        [DataMember(Name = "lstCartConditionDetails", Order = 6)]
        public List<CartConditionDetail> lstCartConditionDetails
        {
            get { return _lstCartConditionDetails; }
            set { _lstCartConditionDetails = value; }
        }

    }

    [DataContract]
    [Serializable]
    public class CartPriceRuleRole
    {
        private int _CartPriceRuleID;

        private string _RoleID;

        public CartPriceRuleRole()
        {
        }
        [DataMember(Name = "CartPriceRuleID", Order = 0)]
        public int CartPriceRuleID
        {
            get
            {
                return this._CartPriceRuleID;
            }
            set
            {
                if ((this._CartPriceRuleID != value))
                {
                    this._CartPriceRuleID = value;
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

    [DataContract]
    [Serializable]
    public class CartPriceRuleStore
    {
        private int _CartPriceRuleID;

        private string _StoreID;

        public CartPriceRuleStore()
        {
        }
        [DataMember(Name = "CartPriceRuleID", Order = 0)]
        public int CartPriceRuleID
        {
            get
            {
                return this._CartPriceRuleID;
            }
            set
            {
                if ((this._CartPriceRuleID != value))
                {
                    this._CartPriceRuleID = value;
                }
            }
        }

        [DataMember(Name = "StoreID", Order = 1)]
        public string StoreID
        {
            get
            {
                return this._StoreID;
            }
            set
            {
                if ((this._StoreID != value))
                {
                    this._StoreID = value;
                }
            }
        }
    }
}
