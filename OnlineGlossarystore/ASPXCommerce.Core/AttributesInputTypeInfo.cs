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
using System.Text;
using System.Runtime.Serialization;

namespace ASPXCommerce.Core
{
    [DataContract]
    [Serializable]
    public class AttributesInputTypeInfo
    {
        #region Constructor
        public AttributesInputTypeInfo()
        {
        } 
        #endregion        

        #region Private Fields
        [DataMember(Name = "_InputTypeID", Order = 0)]
        private int _InputTypeID;

        [DataMember(Name = "_InputType", Order = 1)]
        private string _InputType;

        //[DataMember(Name = "_DisplayOrder", Order = 2)]
        private System.Nullable<int> _DisplayOrder;

        //[DataMember(Name = "_IsDefaultSelected", Order = 3)]
        private System.Nullable<bool> _IsDefaultSelected;
        #endregion

        #region Public Fields
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

        public System.Nullable<int> DisplayOrder
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

        public System.Nullable<bool> IsDefaultSelected
        {
            get
            {
                return this._IsDefaultSelected;
            }
            set
            {
                if ((this._IsDefaultSelected != value))
                {
                    this._IsDefaultSelected = value;
                }
            }
        } 
        #endregion
    }
}
