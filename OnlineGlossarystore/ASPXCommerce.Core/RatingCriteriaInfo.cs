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
    [DataContract]
    [Serializable]
    public class RatingCriteriaInfo
    {
        #region "Private Members"
        int _ItemRatingCriteriaID;
        string _ItemRatingCriteria;
        int _StoreID;
        int _PortalID;
        #endregion
        #region "Constructors"
        public RatingCriteriaInfo()
        {
        }
        public RatingCriteriaInfo(int itemRatingCreteriaId, string itemRatingCriteria,int storeId,int portalId)
        {
            this.ItemRatingCriteriaID = itemRatingCreteriaId;
            this.ItemRatingCriteria = itemRatingCriteria;
            this.StoreID = storeId;
            this.PortalID = portalId;

        }
        #endregion
        #region "Public Members"

        [DataMember]
        public int ItemRatingCriteriaID
        {
            get { return _ItemRatingCriteriaID; }
            set { _ItemRatingCriteriaID = value; }
        }
        [DataMember]
        public string ItemRatingCriteria
        {
            get { return _ItemRatingCriteria; }
            set { _ItemRatingCriteria = value; }
        }
        [DataMember]
        public int StoreID
        {
            get { return _StoreID; }
            set { _StoreID = value; }
        }
        [DataMember]
        public int PortalID
        {
            get { return _PortalID; }
            set { _PortalID = value; }
        }
        #endregion
    }
}