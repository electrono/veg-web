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
   public class CostVariantsGetByCostVariantIDInfo
    {
        private int _CostVariantID;
		
		private string _CostVariantName;
		
		private string _CultureName;
		
		private int _InputTypeID;
		
		private System.Nullable<int> _DisplayOrder;
		
		private System.Nullable<bool> _ShowInSearch;
		
		private System.Nullable<bool> _ShowInGrid;
		
		private System.Nullable<bool> _ShowInAdvanceSearch;
		
		private System.Nullable<bool> _ShowInComparison;
		
		private System.Nullable<bool> _IsEnableSorting;
		
		private System.Nullable<bool> _IsSystemUsed;
		
		private System.Nullable<bool> _IsUseInFilter;
		
		private System.Nullable<bool> _IsIncludeInPriceRule;
		
		private System.Nullable<bool> _IsIncludeInPromotions;
		
		private System.Nullable<bool> _IsShownInRating;
		
		private System.Nullable<bool> _IsUsedInConfigItem;

        private System.Nullable<bool> _Flag;
		
		private string _Description;
		
		private int _StoreID;
		
		private int _PortalID;
		
		private System.Nullable<bool> _IsActive;
		
		private System.Nullable<bool> _IsDeleted;
		
		private System.Nullable<bool> _IsModified;
		
		private System.Nullable<System.DateTime> _AddedOn;
		
		private System.Nullable<System.DateTime> _UpdatedOn;
		
		private System.Nullable<System.DateTime> _DeletedOn;
		
		private string _AddedBy;
		
		private string _UpdatedBy;
		
		private string _DeletedBy;

        public CostVariantsGetByCostVariantIDInfo()
		{
		}
		
		[DataMember]
		public int CostVariantID
		{
			get
			{
				return this._CostVariantID;
			}
			set
			{
				if ((this._CostVariantID != value))
				{
					this._CostVariantID = value;
				}
			}
		}

        [DataMember]
		public string CostVariantName
		{
			get
			{
				return this._CostVariantName;
			}
			set
			{
				if ((this._CostVariantName != value))
				{
					this._CostVariantName = value;
				}
			}
		}

        [DataMember]
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

        [DataMember]
		public int InputTypeID
		{
			get
			{
				return this._InputTypeID;
			}
			set
			{
				if ((this._InputTypeID != value))
				{
					this._InputTypeID = value;
				}
			}
		}
       
        [DataMember]
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
        
        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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
        [DataMember]
        public System.Nullable<bool> Flag
        {
            get
            {
                return this._Flag;
            }
            set
            {
                if ((this._Flag != value))
                {
                    this._Flag = value;
                }
            }
        }

        [DataMember]
		public string Description
		{
			get
			{
				return this._Description;
			}
			set
			{
				if ((this._Description != value))
				{
					this._Description = value;
				}
			}
		}

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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

        [DataMember]
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
		
		[DataMember]
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

        [DataMember]
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

        [DataMember]
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
    }
}
