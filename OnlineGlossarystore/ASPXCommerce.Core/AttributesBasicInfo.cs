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
    public class AttributesBasicInfo
    {
        #region Constructor
        public AttributesBasicInfo()
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

        [DataMember(Name = "_AliasName", Order = 3)]
        private string _AliasName;

        [DataMember(Name = "_IsRequired", Order = 4)]
        private System.Nullable<bool> _IsRequired;

        [DataMember(Name = "_IsActive", Order = 5)]
        private bool _IsActive;

        [DataMember(Name = "_IsSystemUsed", Order = 6)]
        private System.Nullable<bool> _IsSystemUsed;

        [DataMember(Name = "_ShowInSearch", Order = 7)]
        private System.Nullable<bool> _ShowInSearch;

        [DataMember(Name = "_IsUsedInConfigItem", Order = 8)]
        private System.Nullable<bool> _IsUsedInConfigItem;

        [DataMember(Name = "_ShowInComparison", Order = 9)]
        private System.Nullable<bool> _ShowInComparison;

        [DataMember(Name = "_AddedOn", Order = 10)]
        private System.Nullable<System.DateTime> _AddedOn;
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

        public bool IsActive
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

        #endregion
       
    }


}
