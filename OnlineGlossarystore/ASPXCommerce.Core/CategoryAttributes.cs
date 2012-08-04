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
using System.Runtime.Serialization;
using System.Collections;

namespace ASPXCommerce.Core
{
    class CategoryAttribute
    {
        private Int32 _CategoryID;
        [DataMember]
        public Int32 CategoryID
        {
            get
            {
                return this._CategoryID;
            }
            set
            {
                if ((this._CategoryID != value))
                {
                    this._CategoryID = value;
                }
            }
        }

        private Int32 _AttributeID;
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

        private string _AttributeName;
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

        private Int32 _InputTypeID;
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

        private Int32 _ValidationTypeID;
        [DataMember]
        public Int32 ValidationTypeID
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

        private System.Nullable<bool> _IsUnique;
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

        private System.Nullable<bool> _IsRequired;
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

        private string _NVARCHARValue;
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

        private string _TEXTValue;
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

        private System.Nullable<bool> _BooleanValue;
        [DataMember]
        public System.Nullable<bool> BooleanValue
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

        private Int32 _INTValue;
        [DataMember]
        public Int32 INTValue
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

        private DateTime _DATEValue;
        [DataMember]
        public DateTime DATEValue
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

        private decimal _DECIMALValue;
        [DataMember]
        public decimal DECIMALValue
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

        private Int32 _FILEValue;
        [DataMember]
        public Int32 FILEValue
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
    }
}
