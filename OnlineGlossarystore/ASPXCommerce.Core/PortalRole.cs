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
    public class PortalRole
    {
        private int _PortalRoleID;
        [DataMember(Name = "PortalRoleID", Order = 1)]
        public int PortalRoleID
        {
            get
            {
                return this._PortalRoleID;
            }
            set
            {
                if ((this._PortalRoleID != value))
                {
                    this._PortalRoleID = value;
                }
            }
        }

        
        private int _PortalID;
        [DataMember(Name = "PortalID", Order = 2)]
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


        private System.Guid _RoleID;
        [DataMember(Name = "RoleID", Order = 3)]
        public System.Guid RoleID
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


        private System.Guid _ApplicationId;
        [DataMember(Name = "ApplicationId", Order = 4)]
        public System.Guid ApplicationId
        {
            get
            {
                return this._ApplicationId;
            }
            set
            {
                if ((this._ApplicationId != value))
                {
                    this._ApplicationId = value;
                }
            }
        }

        
        private string _RoleName;
        [DataMember(Name = "RoleName", Order = 5)]
        public string RoleName
        {
            get
            {
                return this._RoleName;
            }
            set
            {
                if ((this._RoleName != value))
                {
                    this._RoleName = value;
                }
            }
        }


        private string _LoweredRoleName;
        [DataMember(Name = "LoweredRoleName", Order = 6)]
        public string LoweredRoleName
        {
            get
            {
                return this._LoweredRoleName;
            }
            set
            {
                if ((this._LoweredRoleName != value))
                {
                    this._LoweredRoleName = value;
                }
            }
        }



        private string _Description;
        [DataMember(Name = "Description", Order = 7)]
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

        
        //private System.Nullable<bool> _IsActive;
        //[DataMember(Name = "IsActive", Order = 8)]
        //public System.Nullable<bool> IsActive
        //{
        //    get
        //    {
        //        return this._IsActive;
        //    }
        //    set
        //    {
        //        if ((this._IsActive != value))
        //        {
        //            this._IsActive = value;
        //        }
        //    }
        //}

        
        //private System.Nullable<bool> _IsDeleted;
        //[DataMember(Name = "IsDeleted", Order = 9)]
        //public System.Nullable<bool> IsDeleted
        //{
        //    get
        //    {
        //        return this._IsDeleted;
        //    }
        //    set
        //    {
        //        if ((this._IsDeleted != value))
        //        {
        //            this._IsDeleted = value;
        //        }
        //    }
        //}

        
        //private System.Nullable<bool> _IsModified;
        //[DataMember(Name = "IsModified", Order = 10)]
        //public System.Nullable<bool> IsModified
        //{
        //    get
        //    {
        //        return this._IsModified;
        //    }
        //    set
        //    {
        //        if ((this._IsModified != value))
        //        {
        //            this._IsModified = value;
        //        }
        //    }
        //}

        
        //private System.Nullable<System.DateTime> _AddedOn;
        //[DataMember(Name = "AddedOn", Order = 11)]
        //public System.Nullable<System.DateTime> AddedOn
        //{
        //    get
        //    {
        //        return this._AddedOn;
        //    }
        //    set
        //    {
        //        if ((this._AddedOn != value))
        //        {
        //            this._AddedOn = value;
        //        }
        //    }
        //}


        
        //private System.Nullable<System.DateTime> _UpdatedOn;
        //[DataMember(Name = "UpdatedOn", Order = 12)]
        //public System.Nullable<System.DateTime> UpdatedOn
        //{
        //    get
        //    {
        //        return this._UpdatedOn;
        //    }
        //    set
        //    {
        //        if ((this._UpdatedOn != value))
        //        {
        //            this._UpdatedOn = value;
        //        }
        //    }
        //}

        
        //private System.Nullable<System.DateTime> _DeletedOn;
        //[DataMember(Name = "DeletedOn", Order = 13)]
        //public System.Nullable<System.DateTime> DeletedOn
        //{
        //    get
        //    {
        //        return this._DeletedOn;
        //    }
        //    set
        //    {
        //        if ((this._DeletedOn != value))
        //        {
        //            this._DeletedOn = value;
        //        }
        //    }
        //}


        
        //private string _AddedBy;
        //[DataMember(Name = "AddedBy", Order = 14)]
        //public string AddedBy
        //{
        //    get
        //    {
        //        return this._AddedBy;
        //    }
        //    set
        //    {
        //        if ((this._AddedBy != value))
        //        {
        //            this._AddedBy = value;
        //        }
        //    }
        //}

        
        //private string _UpdatedBy;
        //[DataMember(Name = "UpdatedBy", Order = 15)]
        //public string UpdatedBy
        //{
        //    get
        //    {
        //        return this._UpdatedBy;
        //    }
        //    set
        //    {
        //        if ((this._UpdatedBy != value))
        //        {
        //            this._UpdatedBy = value;
        //        }
        //    }
        //}

        
        //private string _DeletedBy;
        //[DataMember(Name = "DeletedBy", Order = 16)]
        //public string DeletedBy
        //{
        //    get
        //    {
        //        return this._DeletedBy;
        //    }
        //    set
        //    {
        //        if ((this._DeletedBy != value))
        //        {
        //            this._DeletedBy = value;
        //        }
        //    }
        //}
    }
}
