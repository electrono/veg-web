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
    public class AttributesItemTypeInfo
    {
        public AttributesItemTypeInfo()
        {
        }

        [DataMember(Name = "_ItemTypeID", Order = 0)]
        private int _ItemTypeID;

        [DataMember(Name = "_ItemTypeName", Order = 1)]
        private string _ItemTypeName;

        //[DataMember(Name = "_StoreID", Order = 2)]
        private int _StoreID;

        //[DataMember(Name = "_PortalID", Order = 3)]
        private int _PortalID;

        //[DataMember(Name = "_IsActive", Order = 4)]
        private System.Nullable<bool> _IsActive;

        //[DataMember(Name = "_IsDeleted", Order = 5)]
        private System.Nullable<bool> _IsDeleted;

        //[DataMember(Name = "_IsModified", Order = 6)]
        private System.Nullable<bool> _IsModified;

        //[DataMember(Name = "_AddedOn", Order = 7)]
        private System.Nullable<System.DateTime> _AddedOn;

        //[DataMember(Name = "_UpdatedOn", Order = 8)]
        private System.Nullable<System.DateTime> _UpdatedOn;

        //[DataMember(Name = "_DeletedOn", Order = 9)]
        private System.Nullable<System.DateTime> _DeletedOn;

        //[DataMember(Name = "_AddedBy", Order = 10)]
        private string _AddedBy;

        //[DataMember(Name = "_UpdatedBy", Order = 11)]
        private string _UpdatedBy;

        //[DataMember(Name = "_DeletedBy", Order = 12)]
        private string _DeletedBy;


        public int ItemTypeID
        {
            get
            {
                return this._ItemTypeID;
            }
            set
            {
                if ((this._ItemTypeID != value))
                {
                    this._ItemTypeID = value;
                }
            }
        }

        public string ItemTypeName
        {
            get
            {
                return this._ItemTypeName;
            }
            set
            {
                if ((this._ItemTypeName != value))
                {
                    this._ItemTypeName = value;
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
