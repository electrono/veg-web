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
    public class CartPricingRuleAttributeInfo
    {
        #region Private Properties
        private int _AttributeID;
        private string _AttributeName;
        private string _AttributeNameAlias;
        private int _InputTypeID;
        private string _InputType;
        private string _Values;
        private string _Operators;
        #endregion

        #region Public Properties
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
        public string AttributeNameAlias
        {
            get
            {
                return this._AttributeNameAlias;
            }
            set
            {
                if ((this._AttributeNameAlias != value))
                {
                    this._AttributeNameAlias = value;
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
        public string InputType
        {
            get
            {
                return this._InputType;
            }
            set
            {
                if ((this._InputType != value))
                {
                    this._InputType = value;
                }
            }
        }

        [DataMember]
        public string Values
        {
            get
            {
                return this._Values;
            }
            set
            {
                if ((this._Values != value))
                {
                    this._Values = value;
                }
            }
        }

        [DataMember]
        public string Operators
        {
            get
            {
                return this._Operators;
            }
            set
            {
                if ((this._Operators != value))
                {
                    this._Operators = value;
                }
            }
        }
        #endregion
    }
}
