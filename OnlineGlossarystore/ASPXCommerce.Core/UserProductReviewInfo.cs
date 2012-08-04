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
    [Serializable]
  public  class UserProductReviewInfo
    {
      [DataMember]
      private int _ItemRatingID;

      [DataMember]
		private int _ItemID;

      [DataMember]
		private string _ItemName;

      [DataMember]
		private string _ImagePath;

      [DataMember]
		private System.Nullable<int> _ItemReviewID;

      [DataMember]
		private string _Username;

      [DataMember]
		private System.Nullable<System.DateTime> _AddedOn;

      [DataMember]
		private string _AddedBy;

      [DataMember]
		private string _ReviewSummary;

      [DataMember]
		private string _Review;

      [DataMember]
		private string _ItemRatingCriteria;

      [DataMember]
		private System.Nullable<int> _ItemRatingCriteriaID;

      [DataMember]
		private System.Nullable<decimal> _RatingValue;

      [DataMember]
		private System.Nullable<decimal> _RatingAverage;

        public UserProductReviewInfo()
		{
		}
		
		public int ItemRatingID
		{
			get
			{
				return this._ItemRatingID;
			}
			set
			{
				if ((this._ItemRatingID != value))
				{
					this._ItemRatingID = value;
				}
			}
		}
		
		public int ItemID
		{
			get
			{
				return this._ItemID;
			}
			set
			{
				if ((this._ItemID != value))
				{
					this._ItemID = value;
				}
			}
		}		
		
		public string ItemName
		{
			get
			{
				return this._ItemName;
			}
			set
			{
				if ((this._ItemName != value))
				{
					this._ItemName = value;
				}
			}
		}
		
		
		public string ImagePath
		{
			get
			{
				return this._ImagePath;
			}
			set
			{
				if ((this._ImagePath != value))
				{
					this._ImagePath = value;
				}
			}
		}
		
		
		public System.Nullable<int> ItemReviewID
		{
			get
			{
				return this._ItemReviewID;
			}
			set
			{
				if ((this._ItemReviewID != value))
				{
					this._ItemReviewID = value;
				}
			}
		}
		
		
		public string Username
		{
			get
			{
				return this._Username;
			}
			set
			{
				if ((this._Username != value))
				{
					this._Username = value;
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
		
		
		public string ReviewSummary
		{
			get
			{
				return this._ReviewSummary;
			}
			set
			{
				if ((this._ReviewSummary != value))
				{
					this._ReviewSummary = value;
				}
			}
		}
		
		public string Review
		{
			get
			{
				return this._Review;
			}
			set
			{
				if ((this._Review != value))
				{
					this._Review = value;
				}
			}
		}		
		
		public string ItemRatingCriteria
		{
			get
			{
				return this._ItemRatingCriteria;
			}
			set
			{
				if ((this._ItemRatingCriteria != value))
				{
					this._ItemRatingCriteria = value;
				}
			}
		}
		
		public System.Nullable<int> ItemRatingCriteriaID
		{
			get
			{
				return this._ItemRatingCriteriaID;
			}
			set
			{
				if ((this._ItemRatingCriteriaID != value))
				{
					this._ItemRatingCriteriaID = value;
				}
			}
		}
		
		public System.Nullable<decimal> RatingValue
		{
			get
			{
				return this._RatingValue;
			}
			set
			{
				if ((this._RatingValue != value))
				{
					this._RatingValue = value;
				}
			}
		}
		
		public System.Nullable<decimal> RatingAverage
		{
			get
			{
				return this._RatingAverage;
			}
			set
			{
				if ((this._RatingAverage != value))
				{
					this._RatingAverage = value;
				}
			}
		}
	}
}

