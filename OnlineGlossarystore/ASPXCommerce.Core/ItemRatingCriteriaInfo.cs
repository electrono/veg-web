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
    public class ItemRatingCriteriaInfo
    {

        [DataMember(Name = "_RowTotal", Order = 0)]
        private System.Nullable<int> _RowTotal;

        [DataMember(Name = "_ItemRatingCriteriaID", Order = 1)]
        private System.Nullable<int> _ItemRatingCriteriaID;

        [DataMember(Name = "_ItemRatingCriteria", Order = 2)]
        private string _ItemRatingCriteria;

        [DataMember(Name = "_AddedOn", Order = 3)]
        private DateTime _AddedOn;

        [DataMember(Name = "_IsActive", Order = 4)]
        private bool _IsActive;


        public System.Nullable<int> RowTotal
        {
            get
            {
                return this._RowTotal;
            }
            set
            {
                if ((this._RowTotal != value))
                {
                    this._RowTotal = value;
                }
            }
        }
        public System.Nullable<int> ItemRatingCriteriaID
        {
            get
            {
                return this._ItemRatingCriteriaID;
            }
            set
            {
                if((this._ItemRatingCriteriaID != value))
                {
                    this._ItemRatingCriteriaID=value;
                }
            }
        }
        public string ItemRatingCriteria
        {
            get
            {
                return this._ItemRatingCriteria;
            }
            set
            {
                if ((this._ItemRatingCriteria != value))
                {
                    this._ItemRatingCriteria = value;
                }
            }
        }
        public DateTime AddedOn
        {
            get
            {
                return this._AddedOn;
            }
            set
            {
                if ((this._AddedOn != value))
                {
                    this._AddedOn = value;
                }
            }
        }
        public bool IsActive
        {
            get
            {
                return this._IsActive;
            }
            set
            {
                if ((this._IsActive != value))
                    this._IsActive = value;
            }
        }
    }
       
}
