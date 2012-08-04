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
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    public class AttributeSetGetByAttributeSetIDInfo
    {
        #region Constructor
        public AttributeSetGetByAttributeSetIDInfo()
        {
        } 
        #endregion

        #region Private Fields
        [DataMember(Name = "_AttributeSetID", Order = 0)]
        private int _AttributeSetID;

        [DataMember(Name = "_AttributeSetName", Order = 1)]
        private string _AttributeSetName;        

        [DataMember(Name = "_StoreID", Order = 2)]
        private int _StoreID;

        [DataMember(Name = "_PortalID", Order = 3)]
        private int _PortalID;

        [DataMember(Name = "_IsActive", Order = 4)]
        private System.Nullable<bool> _IsActive;

        [DataMember(Name = "_IsDeleted", Order = 5)]
        private System.Nullable<bool> _IsDeleted;

        [DataMember(Name = "_IsModified", Order = 6)]
        private System.Nullable<bool> _IsModified;

        [DataMember(Name = "_AddedOn", Order = 7)]
        private System.Nullable<System.DateTime> _AddedOn;

        [DataMember(Name = "_UpdatedOn", Order = 8)]
        private System.Nullable<System.DateTime> _UpdatedOn;

        [DataMember(Name = "_DeletedOn", Order = 9)]
        private System.Nullable<System.DateTime> _DeletedOn;

        [DataMember(Name = "_AddedBy", Order = 10)]
        private string _AddedBy;

        [DataMember(Name = "_UpdatedBy", Order = 11)]
        private string _UpdatedBy;

        [DataMember(Name = "_DeletedBy", Order = 12)]
        private string _DeletedBy;

        [DataMember(Name = "_AttributeSetGroupID", Order = 13)]
        private int _AttributeSetGroupID;

        [DataMember(Name = "_AttributeID", Order = 14)]
        private int _AttributeID;

        [DataMember(Name = "_AttributeName", Order = 15)]
        private string _AttributeName;

        [DataMember(Name = "_IsSystemUsed", Order = 16)]
        private System.Nullable<bool> _IsSystemUsed;

        [DataMember(Name = "_GroupID", Order = 17)]
        private int _GroupID;

        [DataMember(Name = "_GroupName", Order = 18)]
        private string _GroupName;

        [DataMember(Name = "_IsSystemUsedGroup", Order = 19)]
        private System.Nullable<bool> _IsSystemUsedGroup;

        [DataMember(Name = "_CultureName", Order = 20)]
        private string _CultureName;

        [DataMember(Name = "_UnassignedAttributes", Order = 21)]
        private string _UnassignedAttributes;

        [DataMember(Name = "_UnassignedAttributesName", Order = 22)]
        private string _UnassignedAttributesName;         
        #endregion

        #region Public Fields
        public int AttributeSetID
        {
            get
            {
                return this._AttributeSetID;
            }
            set
            {
                if ((this._AttributeSetID != value))
                {
                    this._AttributeSetID = value;
                }
            }
        }

        public string AttributeSetName
        {
            get
            {
                return this._AttributeSetName;
            }
            set
            {
                if ((this._AttributeSetName != value))
                {
                    this._AttributeSetName = value;
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

        public int AttributeSetGroupID
        {
            get
            {
                return this._AttributeSetGroupID;
            }
            set
            {
                if ((this._AttributeSetGroupID != value))
                {
                    this._AttributeSetGroupID = value;
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

        public int GroupID
        {
            get
            {
                return this._GroupID;
            }
            set
            {
                if ((this._GroupID != value))
                {
                    this._GroupID = value;
                }
            }
        }

        public string GroupName
        {
            get
            {
                return this._GroupName;
            }
            set
            {
                if ((this._GroupName != value))
                {
                    this._GroupName = value;
                }
            }
        }

        public System.Nullable<bool> IsSystemUsedGroup
        {
            get
            {
                return this._IsSystemUsedGroup;
            }
            set
            {
                if ((this._IsSystemUsedGroup != value))
                {
                    this._IsSystemUsedGroup = value;
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

        public string UnassignedAttributes
        {
            get
            {
                return this._UnassignedAttributes;
            }
            set
            {
                if ((this._UnassignedAttributes != value))
                {
                    this._UnassignedAttributes = value;
                }
            }
        }

        public string UnassignedAttributesName
        {
            get
            {
                return this._UnassignedAttributesName;
            }
            set
            {
                if ((this._UnassignedAttributesName != value))
                {
                    this._UnassignedAttributesName = value;
                }
            }
        } 
        #endregion
    }
}
