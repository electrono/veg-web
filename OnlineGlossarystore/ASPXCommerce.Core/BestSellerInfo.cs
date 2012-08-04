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
    [Serializable]
    [DataContract]
     public class BestSellerInfo
    {


        [DataMember]
        private string _Sku;
        [DataMember]
        private string _ItemName;
        [DataMember]
        private int _itemid;

        [DataMember]
        private string _ImagePath;
        [DataMember]
        private System.Nullable<int> _SoldItem;
        [DataMember]
        private int _count;

        public BestSellerInfo()
        {
        }

      
        public string Sku
        {
            get
            {
                return this._Sku;
            }
            set
            {
                if ((this._Sku != value))
                {
                    this._Sku = value;
                }
            }
        }

      
        public string ItemName
        {
            get
            {
                return this._ItemName;
            }
            set
            {
                if ((this._ItemName != value))
                {
                    this._ItemName = value;
                }
            }
        }

       
        public int itemid
        {
            get
            {
                return this._itemid;
            }
            set
            {
                if ((this._itemid != value))
                {
                    this._itemid = value;
                }
            }
        }

        
        public string ImagePath
        {
            get
            {
                return this._ImagePath;
            }
            set
            {
                if ((this._ImagePath != value))
                {
                    this._ImagePath = value;
                }
            }
        }

      
        public System.Nullable<int> SoldItem
        {
            get
            {
                return this._SoldItem;
            }
            set
            {
                if ((this._SoldItem != value))
                {
                    this._SoldItem = value;
                }
            }
        }
        public int count
        {
            get
            {
                return this._count;
            }
            set
            {
                if ((this._count != value))
                {
                    this._count = value;
                }
            }
        }
       
    }
}
