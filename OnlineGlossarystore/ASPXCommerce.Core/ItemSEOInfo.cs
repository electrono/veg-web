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

    public class ItemSEOInfo
    {
        public ItemSEOInfo()
        {
        }

        private int _ItemID;

        private string _SKU;

        private string _Name;

        private string _MetaTitle;

        private string _MetaKeywords;

        private string _MetaDescription;

        public int ItemID
        {
            get
            {
                return this._ItemID;
            }
            set
            {
                if ((this._ItemID != value))
                {
                    this._ItemID = value;
                }
            }
        }

        public string SKU
        {
            get
            {
                return this._SKU;
            }
            set
            {
                if ((this._SKU != value))
                {
                    this._SKU = value;
                }
            }
        }

        public string Name
        {
            get
            {
                return this._Name;
            }
            set
            {
                if ((this._Name != value))
                {
                    this._Name = value;
                }
            }
        }

        public string MetaTitle
        {
            get
            {
                return this._MetaTitle;
            }
            set
            {
                if ((this._MetaTitle != value))
                {
                    this._MetaTitle = value;
                }
            }
        }

        public string MetaKeywords
        {
            get
            {
                return this._MetaKeywords;
            }
            set
            {
                if ((this._MetaKeywords != value))
                {
                    this._MetaKeywords = value;
                }
            }
        }

        public string MetaDescription
        {
            get
            {
                return this._MetaDescription;
            }
            set
            {
                if ((this._MetaDescription != value))
                {
                    this._MetaDescription = value;
                }
            }
        }
    }
}
