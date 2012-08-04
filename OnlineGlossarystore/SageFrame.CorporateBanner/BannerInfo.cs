using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SageFrame.CorporateBanner
{
    public class BannerInfo
    {
        #region Constructor
        public BannerInfo()
        {
        } 
        #endregion

        #region Private Field
        private int _BannerID;

        private System.Nullable<int> _UserModuleID;

        private string _Title;

        private string _Description;

        private string _NavigationTitle;

        private string _NavigationImage;

        private System.Nullable<int> _BannerOrder;

        private string _BannerImage;

        private string _ImageToolTip;

        private string _ReadButtonText;

        private string _ReadMorePage;

        private System.Nullable<bool> _IsActive;

        private System.Nullable<bool> _IsDeleted;

        private System.Nullable<bool> _IsModified;

        private System.Nullable<System.DateTime> _AddedOn;

        private System.Nullable<System.DateTime> _UpdatedOn;

        private System.Nullable<System.DateTime> _DeletedOn;

        private System.Nullable<int> _PortalID;

        private string _AddedBy;

        private string _UpdatedBy;

        private string _DeletedBy; 
        #endregion

        #region Public Field
        public int BannerID
        {
            get
            {
                return this._BannerID;
            }
            set
            {
                if ((this._BannerID != value))
                {
                    this._BannerID = value;
                }
            }
        }

        public System.Nullable<int> UserModuleID
        {
            get
            {
                return this._UserModuleID;
            }
            set
            {
                if ((this._UserModuleID != value))
                {
                    this._UserModuleID = value;
                }
            }
        }

        public string Title
        {
            get
            {
                return this._Title;
            }
            set
            {
                if ((this._Title != value))
                {
                    this._Title = value;
                }
            }
        }

        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                if ((this._Description != value))
                {
                    this._Description = value;
                }
            }
        }

        public string NavigationTitle
        {
            get
            {
                return this._NavigationTitle;
            }
            set
            {
                if ((this._NavigationTitle != value))
                {
                    this._NavigationTitle = value;
                }
            }
        }

        public string NavigationImage
        {
            get
            {
                return this._NavigationImage;
            }
            set
            {
                if ((this._NavigationImage != value))
                {
                    this._NavigationImage = value;
                }
            }
        }

        public System.Nullable<int> BannerOrder
        {
            get
            {
                return this._BannerOrder;
            }
            set
            {
                if ((this._BannerOrder != value))
                {
                    this._BannerOrder = value;
                }
            }
        }

        public string BannerImage
        {
            get
            {
                return this._BannerImage;
            }
            set
            {
                if ((this._BannerImage != value))
                {
                    this._BannerImage = value;
                }
            }
        }        

        public string ImageToolTip
        {
            get
            {
                return this._ImageToolTip;
            }
            set
            {
                if ((this._ImageToolTip != value))
                {
                    this._ImageToolTip = value;
                }
            }
        }

        public string ReadButtonText
        {
            get
            {
                return this._ReadButtonText;
            }
            set
            {
                if ((this._ReadButtonText != value))
                {
                    this._ReadButtonText = value;
                }
            }
        }

        public string ReadMorePage
        {
            get
            {
                return this._ReadMorePage;
            }
            set
            {
                if ((this._ReadMorePage != value))
                {
                    this._ReadMorePage = value;
                }
            }
        }

        public System.Nullable<bool> IsActive
        {
            get
            {
                return this._IsActive;
            }
            set
            {
                if ((this._IsActive != value))
                {
                    this._IsActive = value;
                }
            }
        }

        public System.Nullable<bool> IsDeleted
        {
            get
            {
                return this._IsDeleted;
            }
            set
            {
                if ((this._IsDeleted != value))
                {
                    this._IsDeleted = value;
                }
            }
        }

        public System.Nullable<bool> IsModified
        {
            get
            {
                return this._IsModified;
            }
            set
            {
                if ((this._IsModified != value))
                {
                    this._IsModified = value;
                }
            }
        }

        public System.Nullable<System.DateTime> AddedOn
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

        public System.Nullable<System.DateTime> UpdatedOn
        {
            get
            {
                return this._UpdatedOn;
            }
            set
            {
                if ((this._UpdatedOn != value))
                {
                    this._UpdatedOn = value;
                }
            }
        }

        public System.Nullable<System.DateTime> DeletedOn
        {
            get
            {
                return this._DeletedOn;
            }
            set
            {
                if ((this._DeletedOn != value))
                {
                    this._DeletedOn = value;
                }
            }
        }

        public System.Nullable<int> PortalID
        {
            get
            {
                return this._PortalID;
            }
            set
            {
                if ((this._PortalID != value))
                {
                    this._PortalID = value;
                }
            }
        }

        public string AddedBy
        {
            get
            {
                return this._AddedBy;
            }
            set
            {
                if ((this._AddedBy != value))
                {
                    this._AddedBy = value;
                }
            }
        }

        public string UpdatedBy
        {
            get
            {
                return this._UpdatedBy;
            }
            set
            {
                if ((this._UpdatedBy != value))
                {
                    this._UpdatedBy = value;
                }
            }
        }

        public string DeletedBy
        {
            get
            {
                return this._DeletedBy;
            }
            set
            {
                if ((this._DeletedBy != value))
                {
                    this._DeletedBy = value;
                }
            }
        } 
        #endregion
    }
}
