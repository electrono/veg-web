﻿/*
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
   public class CompareItemListInfo
    {
        #region PrivateMember
        [DataMember]
        private int _itemID;
        [DataMember]
        private int _inputTypeID;
        [DataMember]
        private string _attributeName;
        [DataMember]
        private string _attributeValue; 
        #endregion

        #region Public Member
        public int ItemID
        {
            get
            {
                return this._itemID;
            }
            set
            {
                if ((this._itemID != value))
                {
                    this._itemID = value;
                }
            }
        }

        public int InputTypeID
        {
            get
            {
                return this._inputTypeID;
            }
            set
            {
                if ((this._inputTypeID != value))
                {
                    this._inputTypeID = value;
                }
            }
        }

        public string AttributeName
        {
            get
            {
                return this._attributeName;
            }
            set
            {
                if ((this._attributeName != value))
                {
                    this._attributeName = value;
                }
            }
        }

        public string AttributeValue
        {
            get
            {
                return this._attributeValue;
            }
            set
            {
                if ((this._attributeValue != value))
                {
                    this._attributeValue = value;
                }
            }
        } 
        #endregion
    }
}