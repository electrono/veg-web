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
using System.Web;
using System.Collections;
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    public class AttributeFormInfo
    {
        #region Constructor
        public AttributeFormInfo()
        {
        }
        #endregion

        #region Private Fields

        private int _AttributeID;

        private string _AttributeName;

        private string _ToolTip;

        private string _Help;

        private Int32 _InputTypeID;

        private string _InputTypeValues;

        private string _DefaultValue;

        private System.Nullable<int> _ValidationTypeID;

        private System.Nullable<int> _Length;

        private System.Nullable<bool> _IsUnique;

        private System.Nullable<bool> _IsRequired;

        private System.Nullable<bool> _IsEnableEditor;

        private System.Nullable<int> _GroupID;

        private string _GroupName;

        private int _StoreID;

        private int _PortalID;

        private System.Nullable<bool> _IsIncludeInPriceRule;

        private System.Nullable<bool> _IsIncludeInPromotions;

        private int _DisplayOrder;

        private string _NVARCHARValue;

        private string _TEXTValue;

        private string _BooleanValue;

        private string _INTValue;

        private string _DATEValue;

        private string _DECIMALValue;

        private string _FILEValue;

        private string _OPTIONValues;

        private System.Nullable<int> _AttributeSetID;

        private System.Nullable<int> _ItemTypeID;

        private System.Nullable<int> _ItemTaxRule;
        #endregion

        #region Public Fields
        [DataMember]
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
        [DataMember]
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
        [DataMember]
        public string ToolTip
        {
            get
            {
                return this._ToolTip;
            }
            set
            {
                if ((this._ToolTip != value))
                {
                    this._ToolTip = value;
                }
            }
        }
        [DataMember]
        public string Help
        {
            get
            {
                return this._Help;
            }
            set
            {
                if ((this._Help != value))
                {
                    this._Help = value;
                }
            }
        }
        [DataMember]
        public Int32 InputTypeID
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
        public string InputTypeValues
        {
            get
            {
                return this._InputTypeValues;
            }
            set
            {
                if ((this._InputTypeValues != value))
                {
                    this._InputTypeValues = value;
                }
            }
        }
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
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
        [DataMember]
        public System.Nullable<int> GroupID
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
        [DataMember]
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
        public int DisplayOrder
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
        public string NVARCHARValue
        {
            get
            {
                return this._NVARCHARValue;
            }
            set
            {
                if ((this._NVARCHARValue != value))
                {
                    this._NVARCHARValue = value;
                }
            }
        }
        [DataMember]
        public string TEXTValue
        {
            get
            {
                return this._TEXTValue;
            }
            set
            {
                if ((this._TEXTValue != value))
                {
                    this._TEXTValue = value;
                }
            }
        }
        [DataMember]
        public string BooleanValue
        {
            get
            {
                return this._BooleanValue;
            }
            set
            {
                if ((this._BooleanValue != value))
                {
                    this._BooleanValue = value;
                }
            }
        }
        [DataMember]
        public string INTValue
        {
            get
            {
                return this._INTValue;
            }
            set
            {
                if ((this._INTValue != value))
                {
                    this._INTValue = value;
                }
            }
        }
        [DataMember]
        public string DATEValue
        {
            get
            {
                return this._DATEValue;
            }
            set
            {
                if ((this._DATEValue != value))
                {
                    this._DATEValue = value;
                }
            }
        }
        [DataMember]
        public string DECIMALValue
        {
            get
            {
                return this._DECIMALValue;
            }
            set
            {
                if ((this._DECIMALValue != value))
                {
                    this._DECIMALValue = value;
                }
            }
        }
        [DataMember]
        public string FILEValue
        {
            get
            {
                return this._FILEValue;
            }
            set
            {
                if ((this._FILEValue != value))
                {
                    this._FILEValue = value;
                }
            }
        }
        [DataMember]
        public string OPTIONValues
        {
            get
            {
                return this._OPTIONValues;
            }
            set
            {
                if ((this._OPTIONValues != value))
                {
                    this._OPTIONValues = value;
                }
            }
        }
        [DataMember]
        public System.Nullable<int> AttributeSetID
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
        [DataMember]
        public System.Nullable<int> ItemTypeID
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

           [DataMember]
        public System.Nullable<int> ItemTaxRule
        {
            get
            {
                return this._ItemTaxRule;
            }
            set
            {
                if ((this._ItemTaxRule != value))
                {
                    this._ItemTaxRule = value;
                }
            }
        }
        


        #endregion
    }
}