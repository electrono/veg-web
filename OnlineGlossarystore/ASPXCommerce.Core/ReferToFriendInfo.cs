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
   public class ReferToFriendInfo
    {
        [DataMember(Name = "_RowTotal", Order = 1)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_EmailAFriendID", Order = 2)]
		private int _EmailAFriendID;

        [DataMember(Name = "_ItemID", Order = 3)]
		private System.Nullable<int> _ItemID;

        [DataMember(Name = "_SenderName", Order = 4)]
		private string _SenderName;

        [DataMember(Name = "_SenderEmail", Order = 5)]
		private string _SenderEmail;

        [DataMember(Name = "_ReceiverName", Order = 6)]
		private string _ReceiverName;

        [DataMember(Name = "_ReceiverEmail", Order = 7)]
		private string _ReceiverEmail;

        [DataMember(Name = "_Subject", Order = 8)]
		private string _Subject;

        [DataMember(Name = "_Message", Order = 9)]
		private string _Message;

        [DataMember(Name = "_StoreID", Order = 10)]
		private int _StoreID;

        [DataMember(Name = "_PortalID", Order = 11)]
		private int _PortalID;

        [DataMember(Name = "_IsActive", Order = 12)]
		private System.Nullable<bool> _IsActive;

        [DataMember(Name = "_IsDeleted", Order = 13)]
		private System.Nullable<bool> _IsDeleted;

        [DataMember(Name = "_IsModified", Order = 14)]
		private System.Nullable<bool> _IsModified;

        [DataMember(Name = "_AddedOn", Order = 15)]
		private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_UpdatedOn", Order = 16)]
		private System.Nullable<System.DateTime> _UpdatedOn;

        [DataMember(Name = "_DeletedOn", Order = 17)]
		private System.Nullable<System.DateTime> _DeletedOn;

        [DataMember(Name = "_AddedBy", Order = 18)]
		private string _AddedBy;

        [DataMember(Name = "_UpdatedBy", Order = 19)]
		private string _UpdatedBy;

        [DataMember(Name = "_DeletedBy", Order = 20)]
		private string _DeletedBy;

        public ReferToFriendInfo()
		{
		}
		
		
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
		
		public int EmailAFriendID
		{
			get
			{
				return this._EmailAFriendID;
			}
			set
			{
				if ((this._EmailAFriendID != value))
				{
					this._EmailAFriendID = value;
				}
			}
		}
		
		public System.Nullable<int> ItemID
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
		
		public string SenderName
		{
			get
			{
				return this._SenderName;
			}
			set
			{
				if ((this._SenderName != value))
				{
					this._SenderName = value;
				}
			}
		}
		
		public string SenderEmail
		{
			get
			{
				return this._SenderEmail;
			}
			set
			{
				if ((this._SenderEmail != value))
				{
					this._SenderEmail = value;
				}
			}
		}
		
		public string ReceiverName
		{
			get
			{
				return this._ReceiverName;
			}
			set
			{
				if ((this._ReceiverName != value))
				{
					this._ReceiverName = value;
				}
			}
		}
		
		public string ReceiverEmail
		{
			get
			{
				return this._ReceiverEmail;
			}
			set
			{
				if ((this._ReceiverEmail != value))
				{
					this._ReceiverEmail = value;
				}
			}
		}
		
		public string Subject
		{
			get
			{
				return this._Subject;
			}
			set
			{
				if ((this._Subject != value))
				{
					this._Subject = value;
				}
			}
		}
		
		public string Message
		{
			get
			{
				return this._Message;
			}
			set
			{
				if ((this._Message != value))
				{
					this._Message = value;
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
    }
}
