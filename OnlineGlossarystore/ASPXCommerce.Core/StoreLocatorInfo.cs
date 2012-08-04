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

namespace ASPXCommerce.Core
{
    public class StoreLocatorInfo
    {
        private int _LocationID;
        private int _StoreID;
        private string _StoreName;
        private string _StreetName;
        private string _StoreDescription;
        private string _LocalityName;
        private string _City;
        private string _State;
        private string _Country;
        private string _ZIP;
        private double _Latitude;
        private double _Longitude;
        private int _PortalID;
        private string _AddedBy;
        private double _Distance;

        public int LocationID
        {
            get { return _LocationID; }
            set { this._LocationID = value; }
        }

        public int StoreID
        {
            get { return _StoreID; }
            set { this._StoreID = value; }
        }
        public string StoreName
        {
            get { return _StoreName; }
            set { this._StoreName = value; }
        }


        public string StreetName
        {
            get { return _StreetName; }
            set { this._StreetName = value; }
        }

        public string StoreDescription
        {
            get { return _StoreDescription; }
            set { this._StoreDescription = value; }
        }

        public string LocalityName
        {
            get { return _LocalityName; }
            set { this._LocalityName = value; }
        }

        public string City
        {
            get { return _City; }
            set { this._City = value; }
        }

        public string State
        {
            get { return _State; }
            set { this._State = value; }
        }

        public string Country
        {
            get { return _Country; }
            set { this._Country = value; }
        }

        public string ZIP
        {
            get { return _ZIP; }
            set { this._ZIP = value; }
        }

        public double Latitude
        {
            get { return _Latitude; }
            set { this._Latitude = value; }
        }
        public double Longitude
        {
            get { return _Longitude; }
            set { this._Longitude = value; }
        }

        public string AddedBy
        {
            get { return _AddedBy; }
            set { this._AddedBy = value; }
        }

        public int PortalID
        {
            get { return _PortalID; }
            set { this._PortalID = value; }
        }
        public double Distance
        {
            get { return _Distance; }
            set { this._Distance = value; }
        }

    }
}
