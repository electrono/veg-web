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
    public class AddressInfo
    {
        [DataMember]
        private int _AddressID;

        [DataMember]
        private string _FirstName;

        [DataMember]
        private string _LastName;

        [DataMember]
        private string _Email;

        [DataMember]
        private string _Company;

        [DataMember]
        private string _Address1;

        [DataMember]
        private string _Address2;

        [DataMember]
        private string _City;

        [DataMember]
        private string _State;

        [DataMember]
        private string _Zip;

        [DataMember]
        private string _Country;

        [DataMember]
        private string _Phone;

        [DataMember]
        private string _Mobile;

        [DataMember]
        private string _Fax;

        [DataMember]
        private string _Website;

        [DataMember]
        private System.Nullable<bool> _DefaultBilling;

        [DataMember]
        private System.Nullable<bool> _DefaultShipping;

        public AddressInfo()
        {
        }

        public int AddressID
        {
            get
            {
                return this._AddressID;
            }
            set
            {
                if ((this._AddressID != value))
                {
                    this._AddressID = value;
                }
            }
        }

        public string FirstName
        {
            get
            {
                return this._FirstName;
            }
            set
            {
                if ((this._FirstName != value))
                {
                    this._FirstName = value;
                }
            }
        }

        public string LastName
        {
            get
            {
                return this._LastName;
            }
            set
            {
                if ((this._LastName != value))
                {
                    this._LastName = value;
                }
            }
        }

        public string Email
        {
            get
            {
                return this._Email;
            }
            set
            {
                if ((this._Email != value))
                {
                    this._Email = value;
                }
            }
        }

        public string Company
        {
            get
            {
                return this._Company;
            }
            set
            {
                if ((this._Company != value))
                {
                    this._Company = value;
                }
            }
        }

        public string Address1
        {
            get
            {
                return this._Address1;
            }
            set
            {
                if ((this._Address1 != value))
                {
                    this._Address1 = value;
                }
            }
        }

        public string Address2
        {
            get
            {
                return this._Address2;
            }
            set
            {
                if ((this._Address2 != value))
                {
                    this._Address2 = value;
                }
            }
        }

        public string City
        {
            get
            {
                return this._City;
            }
            set
            {
                if ((this._City != value))
                {
                    this._City = value;
                }
            }
        }

        public string State
        {
            get
            {
                return this._State;
            }
            set
            {
                if ((this._State != value))
                {
                    this._State = value;
                }
            }
        }

        public string Zip
        {
            get
            {
                return this._Zip;
            }
            set
            {
                if ((this._Zip != value))
                {
                    this._Zip = value;
                }
            }
        }

        public string Country
        {
            get
            {
                return this._Country;
            }
            set
            {
                if ((this._Country != value))
                {
                    this._Country = value;
                }
            }
        }

        public string Phone
        {
            get
            {
                return this._Phone;
            }
            set
            {
                if ((this._Phone != value))
                {
                    this._Phone = value;
                }
            }
        }

        public string Mobile
        {
            get
            {
                return this._Mobile;
            }
            set
            {
                if ((this._Mobile != value))
                {
                    this._Mobile = value;
                }
            }
        }

        public string Fax
        {
            get
            {
                return this._Fax;
            }
            set
            {
                if ((this._Fax != value))
                {
                    this._Fax = value;
                }
            }
        }

        public string Website
        {
            get
            {
                return this._Website;
            }
            set
            {
                if ((this._Website != value))
                {
                    this._Website = value;
                }
            }
        }

        public System.Nullable<bool> DefaultBilling
        {
            get
            {
                return this._DefaultBilling;
            }
            set
            {
                if ((this._DefaultBilling != value))
                {
                    this._DefaultBilling = value;
                }
            }
        }

        public System.Nullable<bool> DefaultShipping
        {
            get
            {
                return this._DefaultShipping;
            }
            set
            {
                if ((this._DefaultShipping != value))
                {
                    this._DefaultShipping = value;
                }
            }
        }
    }
}
    

