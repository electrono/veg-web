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
    public class AttributeSetGroupAliasInfo
    {
        #region Constructor
        public AttributeSetGroupAliasInfo()
        {
        }
        #endregion

        #region Private Fields
        [DataMember(Name = "_GroupID", Order = 0)]
        private int _GroupID;

        //[DataMember(Name = "_CultureName", Order = 0)]
        private string _CultureName;

        [DataMember(Name = "_AliasName", Order = 1)]
        private string _AliasName;

        [DataMember(Name = "_AttributeSetID", Order = 2)]
        private int _AttributeSetID;

        //[DataMember(Name = "_StoreID", Order = 0)]
        private int _StoreID;

        //[DataMember(Name = "_PortalID", Order = 0)]
        private int _PortalID;

        //[DataMember(Name = "_IsActive", Order = 0)]
        private System.Nullable<bool> _IsActive;

        //[DataMember(Name = "_IsModified", Order = 0)]
        private System.Nullable<bool> _IsModified;

        //[DataMember(Name = "_UpdatedBy", Order = 0)]
        private string _UpdatedBy;

        #endregion

        #region public Fields
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
        #endregion
    }

}