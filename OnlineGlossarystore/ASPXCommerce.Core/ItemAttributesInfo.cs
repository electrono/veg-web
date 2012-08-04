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
    public class ItemAttributesInfo
    {
        #region Constructor
        public ItemAttributesInfo()
        {
        }
        #endregion

        #region Private Members
        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_AttributeID", Order = 1)]
        private int _AttributeID;

        [DataMember(Name = "_AttributeName", Order = 2)]
        private string _AttributeName;

        //[DataMember(Name = "_InputType", Order = 9)]
        private string _InputType;

        //[DataMember(Name = "_DefaultValue", Order = 10)]
        private string _DefaultValue;

        //[DataMember(Name = "_ValidationTypeID", Order = 11)]
        private System.Nullable<int> _ValidationTypeID;

        //[DataMember(Name = "_Length", Order = 12)]
        private System.Nullable<int> _Length;

        //[DataMember(Name = "_IsUnique", Order = 2)]
        private System.Nullable<bool> _IsUnique;

        [DataMember(Name = "_IsRequired", Order = 4)]
        private System.Nullable<bool> _IsRequired;

        //[DataMember(Name = "_IsEnableEditor", Order = 2)]
        private System.Nullable<bool> _IsEnableEditor;

        [DataMember(Name = "_ShowInSearch", Order = 7)]
        private System.Nullable<bool> _ShowInSearch;

        //[DataMember(Name = "_ShowInGrid", Order = 2)]
        private System.Nullable<bool> _ShowInGrid;

        //[DataMember(Name = "_ShowInAdvanceSearch", Order = 2)]
        private System.Nullable<bool> _ShowInAdvanceSearch;

        [DataMember(Name = "_ShowInComparison", Order = 9)]
        private System.Nullable<bool> _ShowInComparison;

        //[DataMember(Name = "_IsEnableSorting", Order = 2)]
        private System.Nullable<bool> _IsEnableSorting;

        [DataMember(Name = "_IsSystemUsed", Order = 6)]
        private System.Nullable<bool> _IsSystemUsed;

        //[DataMember(Name = "_IsUseInFilter", Order = 2)]
        private System.Nullable<bool> _IsUseInFilter;

        //[DataMember(Name = "_IsIncludeInPriceRule", Order = 2)]
        private System.Nullable<bool> _IsIncludeInPriceRule;

        //[DataMember(Name = "_IsIncludeInPromotions", Order = 2)]
        private System.Nullable<bool> _IsIncludeInPromotions;

        //[DataMember(Name = "_IsShownInRating", Order = 2)]
        private System.Nullable<bool> _IsShownInRating;

        //[DataMember(Name = "_StoreID", Order = 2)]
        private int _StoreID;

        //[DataMember(Name = "_PortalID", Order = 2)]
        private int _PortalID;

        [DataMember(Name = "_IsActive", Order = 5)]
        private System.Nullable<bool> _IsActive;

        //[DataMember(Name = "_IsDeleted", Order = 2)]
        private System.Nullable<bool> _IsDeleted;

        //[DataMember(Name = "_IsModified", Order = 2)]
        private System.Nullable<bool> _IsModified;

        [DataMember(Name = "_AddedOn", Order = 10)]
        private System.Nullable<System.DateTime> _AddedOn;

        //[DataMember(Name = "_UpdatedOn", Order = 5)]
        private System.Nullable<System.DateTime> _UpdatedOn;

        //[DataMember(Name = "_DeletedOn", Order = 2)]
        private System.Nullable<System.DateTime> _DeletedOn;

        //[DataMember(Name = "_AddedBy", Order = 2)]
        private string _AddedBy;

        //[DataMember(Name = "_UpdatedBy", Order = 2)]
        private string _UpdatedBy;

        //[DataMember(Name = "_DeletedBy", Order = 2)]
        private string _DeletedBy;

        //[DataMember(Name = "_AttributeAliasID", Order = 2)]
        private System.Nullable<int> _AttributeAliasID;

        [DataMember(Name = "_AliasName", Order = 3)]
        private string _AliasName;

        //[DataMember(Name = "_AliasToolTip", Order = 2)]
        private string _AliasToolTip;

        //[DataMember(Name = "_AliasHelp", Order = 2)]
        private string _AliasHelp;

        //[DataMember(Name = "_CultureName", Order = 2)]
        private string _CultureName;

        //[DataMember(Name = "_RowNumber", Order = 2)]
        private int _RowNumber;

        [DataMember(Name = "_IsUsedInConfigItem", Order = 8)]
        private System.Nullable<bool> _IsUsedInConfigItem;
        #endregion

        #region Public Members
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

        public int AttributeID
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

        public string AttributeName
        {
            get
            {
                return this._AttributeName;
            }
            set
            {
                if ((this._AttributeName != value))
                {
                    this._AttributeName = value;
                }
            }
        }

        public string InputType
        {
            get
            {
                return this._InputType;
            }
            set
            {
                if ((this._InputType != value))
                {
                    this._InputType = value;
                }
            }
        }

        public string DefaultValue
        {
            get
            {
                return this._DefaultValue;
            }
            set
            {
                if ((this._DefaultValue != value))
                {
                    this._DefaultValue = value;
                }
            }
        }

        public System.Nullable<int> ValidationTypeID
        {
            get
            {
                return this._ValidationTypeID;
            }
            set
            {
                if ((this._ValidationTypeID != value))
                {
                    this._ValidationTypeID = value;
                }
            }
        }

        public System.Nullable<int> Length
        {
            get
            {
                return this._Length;
            }
            set
            {
                if ((this._Length != value))
                {
                    this._Length = value;
                }
            }
        }

        public System.Nullable<bool> IsUnique
        {
            get
            {
                return this._IsUnique;
            }
            set
            {
                if ((this._IsUnique != value))
                {
                    this._IsUnique = value;
                }
            }
        }

        public System.Nullable<bool> IsRequired
        {
            get
            {
                return this._IsRequired;
            }
            set
            {
                if ((this._IsRequired != value))
                {
                    this._IsRequired = value;
                }
            }
        }

        public System.Nullable<bool> IsEnableEditor
        {
            get
            {
                return this._IsEnableEditor;
            }
            set
            {
                if ((this._IsEnableEditor != value))
                {
                    this._IsEnableEditor = value;
                }
            }
        }

        public System.Nullable<bool> ShowInSearch
        {
            get
            {
                return this._ShowInSearch;
            }
            set
            {
                if ((this._ShowInSearch != value))
                {
                    this._ShowInSearch = value;
                }
            }
        }

        public System.Nullable<bool> ShowInGrid
        {
            get
            {
                return this._ShowInGrid;
            }
            set
            {
                if ((this._ShowInGrid != value))
                {
                    this._ShowInGrid = value;
                }
            }
        }

        public System.Nullable<bool> ShowInAdvanceSearch
        {
            get
            {
                return this._ShowInAdvanceSearch;
            }
            set
            {
                if ((this._ShowInAdvanceSearch != value))
                {
                    this._ShowInAdvanceSearch = value;
                }
            }
        }

        public System.Nullable<bool> ShowInComparison
        {
            get
            {
                return this._ShowInComparison;
            }
            set
            {
                if ((this._ShowInComparison != value))
                {
                    this._ShowInComparison = value;
                }
            }
        }

        public System.Nullable<bool> IsEnableSorting
        {
            get
            {
                return this._IsEnableSorting;
            }
            set
            {
                if ((this._IsEnableSorting != value))
                {
                    this._IsEnableSorting = value;
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

        public System.Nullable<bool> IsUseInFilter
        {
            get
            {
                return this._IsUseInFilter;
            }
            set
            {
                if ((this._IsUseInFilter != value))
                {
                    this._IsUseInFilter = value;
                }
            }
        }

        public System.Nullable<bool> IsIncludeInPriceRule
        {
            get
            {
                return this._IsIncludeInPriceRule;
            }
            set
            {
                if ((this._IsIncludeInPriceRule != value))
                {
                    this._IsIncludeInPriceRule = value;
                }
            }
        }

        public System.Nullable<bool> IsIncludeInPromotions
        {
            get
            {
                return this._IsIncludeInPromotions;
            }
            set
            {
                if ((this._IsIncludeInPromotions != value))
                {
                    this._IsIncludeInPromotions = value;
                }
            }
        }

        public System.Nullable<bool> IsShownInRating
        {
            get
            {
                return this._IsShownInRating;
            }
            set
            {
                if ((this._IsShownInRating != value))
                {
                    this._IsShownInRating = value;
                }
            }
        }

        public int StoreID
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

        public int PortalID
        {
            get
            {
                return this._PortalID;
            }
            set
            {
                if ((this._PortalID != value))
                {
                    this._PortalID = value;
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

        public System.Nullable<bool> IsDeleted
        {
            get
            {
                return this._IsDeleted;
            }
            set
            {
                if ((this._IsDeleted != value))
                {
                    this._IsDeleted = value;
                }
            }
        }

        public System.Nullable<bool> IsModified
        {
            get
            {
                return this._IsModified;
            }
            set
            {
                if ((this._IsModified != value))
                {
                    this._IsModified = value;
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

        public System.Nullable<System.DateTime> UpdatedOn
        {
            get
            {
                return this._UpdatedOn;
            }
            set
            {
                if ((this._UpdatedOn != value))
                {
                    this._UpdatedOn = value;
                }
            }
        }

        public System.Nullable<System.DateTime> DeletedOn
        {
            get
            {
                return this._DeletedOn;
            }
            set
            {
                if ((this._DeletedOn != value))
                {
                    this._DeletedOn = value;
                }
            }
        }

        public string AddedBy
        {
            get
            {
                return this._AddedBy;
            }
            set
            {
                if ((this._AddedBy != value))
                {
                    this._AddedBy = value;
                }
            }
        }

        public string UpdatedBy
        {
            get
            {
                return this._UpdatedBy;
            }
            set
            {
                if ((this._UpdatedBy != value))
                {
                    this._UpdatedBy = value;
                }
            }
        }

        public string DeletedBy
        {
            get
            {
                return this._DeletedBy;
            }
            set
            {
                if ((this._DeletedBy != value))
                {
                    this._DeletedBy = value;
                }
            }
        }

        public System.Nullable<int> AttributeAliasID
        {
            get
            {
                return this._AttributeAliasID;
            }
            set
            {
                if ((this._AttributeAliasID != value))
                {
                    this._AttributeAliasID = value;
                }
            }
        }

        public string AliasName
        {
            get
            {
                return this._AliasName;
            }
            set
            {
                if ((this._AliasName != value))
                {
                    this._AliasName = value;
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

        public string CultureName
        {
            get
            {
                return this._CultureName;
            }
            set
            {
                if ((this._CultureName != value))
                {
                    this._CultureName = value;
                }
            }
        }

        public int RowNumber
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

        public System.Nullable<bool> IsUsedInConfigItem
        {
            get
            {
                return this._IsUsedInConfigItem;
            }
            set
            {
                if ((this._IsUsedInConfigItem != value))
                {
                    this._IsUsedInConfigItem = value;
                }
            }
        }        
        #endregion
    }
}
