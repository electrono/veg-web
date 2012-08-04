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
   public class CurrencyInfo
    {
        private string _CurrencyName;
        private string _CurrencyCode;
        private string _CountryName;
        private string _CurrencySymbol;
        private string _BaseImage;
        private string _Region;

        public CurrencyInfo()
        {
        }

        [DataMember]
        public string CurrencyName
        {
            get
            {
                return this._CurrencyName;
            }
            set
            {
                if ((this._CurrencyName) != value)
                {
                    this._CurrencyName = value;
                }
            }

        }
        
        [DataMember]
        public string CurrencyCode
        {
            get
            {
                return this._CurrencyCode;
            }
            set
            {
                if ((this._CurrencyCode) != value)
                {
                    this._CurrencyCode = value;
                }
            }
           
        }
        [DataMember]
        public string CountryName
        {
            get
            {
                return this._CountryName;
            }
            set
            {
                if ((this._CountryName) != value)
                {
                    this._CountryName = value;
                }
            }

        }
        [DataMember]
        public string CurrencySymbol
        {
            get
            {
                return this._CurrencySymbol;
            }
            set
            {
                if ((this._CurrencySymbol) != value)
                {
                    this._CurrencySymbol = value;
                }
            }

        }
        [DataMember]
        public string BaseImage
        {
            get
            {
                return this._BaseImage;
            }
            set
            {
                if ((this._BaseImage) != value)
                {
                    this._BaseImage = value;
                }
            }

        }
        [DataMember]
        public string Region
        {
            get
            {
                return this._Region;
            }
            set
            {
                if ((this._Region) != value)
                {
                    this._Region = value;
                }
            }

        }
    }
}
