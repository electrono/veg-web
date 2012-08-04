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
using SageFrame.Web.Utilities;

namespace ASPXCommerce.Core
{[DataContract]
    [Serializable]
    public class StoreSettingInfo
    {
        [DataMember]
        private string _DefaultProductImageURL;

        [DataMember]
        private string _MyAccountURL;

        [DataMember]
        private string _ShoppingCartURL;

        [DataMember]
        private string _WishListURL;

        [DataMember]
        private string _MainCurrency;

        [DataMember]
        private string _DefaultCountry;

        [DataMember]
        private string _StoreName;

        [DataMember]
        private string _StoreClosePageContent;

        [DataMember]
        private string _StoreClosed;

        [DataMember]
        private string _StoreNOTAccessPageContent; 
       
        [DataMember]
        private string _TimeToDeleteAbandonedCart;

        [DataMember]
        private string _CartAbandonedTime;


        [DataMember]
        private string _GoogleMapAPIKey;

        [DataMember]
        private int _LowStockQuantity;

        [DataMember]
        private string _ShoppingOptionRange; 

        [DataMember]
        private string _AllowAnonymousCheckOut;

        [DataMember]
        private string _AllowMultipleShippingAddress;

        [DataMember]
        private string _SSLSecurePages;

        [DataMember]
        private string _AllowOutStockPurchase;

        [DataMember]
        private string _SendEcommerceEmailsFrom;

        [DataMember]
        private string _SendEcommerceEmailTo;

         [DataMember]
        private string _SendOrderNotification;

         [DataMember]
        private string _SendPaymentNotification;

         [DataMember]
        private string _StoreAdminEmail;

         [DataMember]
        private string _EnableStoreNamePrefix;

         [DataMember]
        private string _DefaultTitle;

         [DataMember]
        private string _DefaultMetaDescription;

         [DataMember]
        private string _DefaultMetaKeyWords;

         [DataMember]
        private string _ShowWelcomeMessageOnHomePage;

         [DataMember]
        private string _DisplayNewsRSSFeedLinkInBrowserAddressBar;

         [DataMember]
        private string _DisplayBlogRSSFeedLinkInBrowserAddressBar;

         [DataMember]
        private string _MaximumImageSize;

         [DataMember]
         private string _ItemLargeThumbnailImageSize;

         [DataMember]
         private string _ItemMediumThumbnailImageSize;

         [DataMember]
         private string _ItemSmallThumbnailImageSize;

         [DataMember]
         private string _CategoryLargeThumbnailImageSize;

         [DataMember]
         private string _CategoryMediumThumbnailImageSize;

         [DataMember]
         private string _CategorySmallThumbnailImageSize;

         [DataMember]
        private string _ShowItemImagesInCart;

         [DataMember]
        private string _ShowItemImagesInWishList;

         [DataMember]
        private string _AllowUsersToCreateMultipleAddress;

         [DataMember]
        private string _AllowUsersToStoreCreditCardDataInProfile;

         [DataMember]
        private string _MinimumOrderAmount;

         [DataMember]
         private string _MinimumItemQuantity;

         [DataMember]
         private string _MaximumItemQuantity;

         [DataMember]
        private string _AllowCustomerToSignUpForUserGroup;

         [DataMember]
        private string _AllowCustomersToPayOrderAgainIfTransactionWasDeclined;

         [DataMember]
        private string _AllowPrivateMessages;

         [DataMember]
        private string _DefaultStoreTimeZone;

         [DataMember]
        private string _EnableCompareItems;
        
        [DataMember]
         private string _MaxNoOfItemsToCompare;
    
         [DataMember]
        private string _EnableWishList;

         [DataMember]
        private string _EnableEmailAFriend;

         [DataMember]
        private string _ShowMiniShoppingCart;

         [DataMember]
        private string _NotifyAboutNewItemReviews;

         [DataMember]
        private string _ItemReviewMustBeApproved;

         [DataMember]
        private string _AllowAnonymousUserToWriteItemRatingAndReviews;

         [DataMember]
        private string _EnableRecentlyViewedItems;

         [DataMember]
        private string _NoOfRecentlyViewedItemsDispay;

         [DataMember]
        private string _EnableLatestItems;

         [DataMember]
        private string _NoOfLatestItemsDisplay;

         [DataMember]
         private string _NoOfLatestItemsInARow;

         [DataMember]
         private string _EnableBestSellerItems;

         [DataMember]
         private string _NoOfBestSellersItemDisplay;

         [DataMember]
         private string _EnableSpecialItems;

         [DataMember]
         private string _NoOfSpecialItemDisplay;

         [DataMember]
        private string _EnableRecentlyComparedItems;

         [DataMember]
        private string _NoOfRecentlyComparedItems;

         [DataMember]
         private string _EnableRelatedCartItems;

         [DataMember]
         private string _NoOfRelatedCartItems;

         [DataMember]
        private string _WeightUnit;

         [DataMember]
         private string _NoOfPopularTags;
    
        public StoreSettingInfo()
        {

        }


        public string DefaultProductImageURL
        {
            get
            {
                return this._DefaultProductImageURL;
            }
            set
            {
                if ((this._DefaultProductImageURL != value))
                {
                    this._DefaultProductImageURL = value;
                }
            }
        }


        public string MyAccountURL
        {
            get
            {
                return this._MyAccountURL;
            }
            set
            {
                if ((this._MyAccountURL != value))
                {
                    this._MyAccountURL = value;
                }
            }
        }


        public string ShoppingCartURL
        {
            get
            {
                return this._ShoppingCartURL;
            }
            set
            {
                if ((this._ShoppingCartURL != value))
                {
                    this._ShoppingCartURL = value;
                }
            }
        }


        public string WishListURL
        {
            get
            {
                return this._WishListURL;
            }
            set
            {
                if ((this._WishListURL != value))
                {
                    this._WishListURL = value;
                }
            }
        }


        public string MainCurrency
        {
            get
            {
                return this._MainCurrency;
            }
            set
            {
                if ((this._MainCurrency != value))
                {
                    this._MainCurrency = value;
                }
            }
        }


        public string DefaultCountry
        {
            get
            {
                return this._DefaultCountry;
            }
            set
            {
                if ((this._DefaultCountry != value))
                {
                    this._DefaultCountry = value;
                }
            }
        }


        public string StoreName
        {
            get
            {
                return this._StoreName;
            }
            set
            {
                if ((this._StoreName != value))
                {
                    this._StoreName = value;
                }
            }
        }


        public string StoreClosePageContent
        {
            get
            {
                return this._StoreClosePageContent;
            }
            set
            {
                if ((this._StoreClosePageContent != value))
                {
                    this._StoreClosePageContent = value;
                }
            }
        }

        public string StoreClosed
        {
            get
            {
                return this._StoreClosed;
            }
            set
            {
                if ((this._StoreClosed != value))
                {
                    this._StoreClosed = value;
                }
            }
        }
    
        public string StoreNOTAccessPageContent 
        {
            get
            {
                return this._StoreNOTAccessPageContent;
            }
            set
            {
                if ((this._StoreNOTAccessPageContent != value))
                {
                    this._StoreNOTAccessPageContent = value;
                }
            }
        }
    
        public string TimeToDeleteAbandonedCart 
        {
            get
            {
                return this._TimeToDeleteAbandonedCart;
            }
            set
            {
                if ((this._TimeToDeleteAbandonedCart != value))
                {
                    this._TimeToDeleteAbandonedCart = value;
                }
            }
        }

        public string CartAbandonedTime 
        {
            get
            {
                return this._CartAbandonedTime;
            }
            set
            {
                if ((this._CartAbandonedTime != value))
                {
                    this._CartAbandonedTime = value;
                }
            }
        }

        public string GoogleMapAPIKey
        {
            get
            {
                return this._GoogleMapAPIKey;
            }
            set
            {
                if ((this._GoogleMapAPIKey != value))
                {
                    this._GoogleMapAPIKey = value;
                }
            }
        }

        public int LowStockQuantity
        {
            get
            {
                return this._LowStockQuantity;
            }
            set
            {
                if ((this._LowStockQuantity != value))
                {
                    this._LowStockQuantity = value;
                }
            }
        }

        public string ShoppingOptionRange
        {
            get
            {
                return this._ShoppingOptionRange;
            }
            set
            {
                if ((this._ShoppingOptionRange != value))
                {
                    this._ShoppingOptionRange = value;
                }
            }
        }

        public string AllowAnonymousCheckOut
        {
            get
            {
                return this._AllowAnonymousCheckOut;
            }
            set
            {
                if ((this._AllowAnonymousCheckOut != value))
                {
                    this._AllowAnonymousCheckOut = value;
                }
            }
        }

        public string AllowMultipleShippingAddress
        {
            get
            {
                return this._AllowMultipleShippingAddress;
            }
            set
            {
                if ((this._AllowMultipleShippingAddress != value))
                {
                    this._AllowMultipleShippingAddress = value;
                }
            }
        }

        public string SSLSecurePages
        {
            get
            {
                return this._SSLSecurePages;
            }
            set
            {
                if ((this._SSLSecurePages != value))
                {
                    this._SSLSecurePages = value;
                }
            }
        }

        public string AllowOutStockPurchase
        {
            get
            {
                return this._AllowOutStockPurchase;
            }
            set
            {
                if ((this._AllowOutStockPurchase != value))
                {
                    this._AllowOutStockPurchase = value;
                }
            }
        }

        public string SendEcommerceEmailsFrom
        {
            get
            {
                return this._SendEcommerceEmailsFrom;
            }
            set
            {
                if ((this._SendEcommerceEmailsFrom != value))
                {
                    this._SendEcommerceEmailsFrom = value;
                }
            }
        }

        public string SendEcommerceEmailTo
        {
            get
            {
                return this._SendEcommerceEmailTo;
            }
            set
            {
                if ((this._SendEcommerceEmailTo != value))
                {
                    this._SendEcommerceEmailTo = value;
                }
            }
        }

        public string SendOrderNotification
        {
            get
            {
                return this._SendOrderNotification;
            }
            set
            {
                if ((this._SendOrderNotification != value))
                {
                    this._SendOrderNotification = value;
                }
            }
        }

        public string SendPaymentNotification
        {
            get
            {
                return this._SendPaymentNotification;
            }
            set
            {
                if ((this._SendPaymentNotification != value))
                {
                    this._SendPaymentNotification = value;
                }
            }
        }

        public string StoreAdminEmail
        {
            get
            {
                return this._StoreAdminEmail;
            }
            set
            {
                if ((this._StoreAdminEmail != value))
                {
                    this._StoreAdminEmail = value;
                }
            }
        }

        public string EnableStoreNamePrefix
        {
            get
            {
                return this._EnableStoreNamePrefix;
            }
            set
            {
                if ((this._EnableStoreNamePrefix != value))
                {
                    this._EnableStoreNamePrefix = value;
                }
            }
        }

        public string DefaultTitle
        {
            get
            {
                return this._DefaultTitle;
            }
            set
            {
                if ((this._DefaultTitle != value))
                {
                    this._DefaultTitle = value;
                }
            }
        }

        public string DefaultMetaDescription
        {
            get
            {
                return this._DefaultMetaDescription;
            }
            set
            {
                if ((this._DefaultMetaDescription != value))
                {
                    this._DefaultMetaDescription = value;
                }
            }
        }

        public string DefaultMetaKeyWords
        {
            get
            {
                return this._DefaultMetaKeyWords;
            }
            set
            {
                if ((this._DefaultMetaKeyWords != value))
                {
                    this._DefaultMetaKeyWords = value;
                }
            }
        }

        public string ShowWelcomeMessageOnHomePage
        {
            get
            {
                return this._ShowWelcomeMessageOnHomePage;
            }
            set
            {
                if ((this._ShowWelcomeMessageOnHomePage != value))
                {
                    this._ShowWelcomeMessageOnHomePage = value;
                }
            }
        }

        public string DisplayNewsRSSFeedLinkInBrowserAddressBar
        {
            get
            {
                return this._DisplayNewsRSSFeedLinkInBrowserAddressBar;
            }
            set
            {
                if ((this._DisplayNewsRSSFeedLinkInBrowserAddressBar != value))
                {
                    this._DisplayNewsRSSFeedLinkInBrowserAddressBar = value;
                }
            }
        }

        public string DisplayBlogRSSFeedLinkInBrowserAddressBar
        {
            get
            {
                return this._DisplayBlogRSSFeedLinkInBrowserAddressBar;
            }
            set
            {
                if ((this._DisplayBlogRSSFeedLinkInBrowserAddressBar != value))
                {
                    this._DisplayBlogRSSFeedLinkInBrowserAddressBar = value;
                }
            }
        }

        public string MaximumImageSize
        {
            get
            {
                return this._MaximumImageSize;
            }
            set
            {
                if ((this._MaximumImageSize != value))
                {
                    this._MaximumImageSize = value;
                }
            }
        }

        public string ItemLargeThumbnailImageSize
        {
            get
            {
                return this._ItemLargeThumbnailImageSize;
            }
            set
            {
                if ((this._ItemLargeThumbnailImageSize != value))
                {
                    this._ItemLargeThumbnailImageSize = value;
                }
            }
        }

        public string ItemMediumThumbnailImageSize
        {
            get
            {
                return this._ItemMediumThumbnailImageSize;
            }
            set
            {
                if ((this._ItemMediumThumbnailImageSize != value))
                {
                    this._ItemMediumThumbnailImageSize = value;
                }
            }
        }

        public string ItemSmallThumbnailImageSize
        {
            get
            {
                return this._ItemSmallThumbnailImageSize;
            }
            set
            {
                if ((this._ItemSmallThumbnailImageSize != value))
                {
                    this._ItemSmallThumbnailImageSize = value;
                }
            }
        }

        public string CategoryLargeThumbnailImageSize
        {
            get
            {
                return this._CategoryLargeThumbnailImageSize;
            }
            set
            {
                if ((this._CategoryLargeThumbnailImageSize != value))
                {
                    this._CategoryLargeThumbnailImageSize = value;
                }
            }
        }

        public string CategoryMediumThumbnailImageSize
        {
            get
            {
                return this._CategoryMediumThumbnailImageSize;
            }
            set
            {
                if ((this._CategoryMediumThumbnailImageSize != value))
                {
                    this._CategoryMediumThumbnailImageSize = value;
                }
            }
        }

        public string CategorySmallThumbnailImageSize
        {
            get
            {
                return this._CategorySmallThumbnailImageSize;
            }
            set
            {
                if ((this._CategorySmallThumbnailImageSize != value))
                {
                    this._CategorySmallThumbnailImageSize = value;
                }
            }
        }

        public string ShowItemImagesInCart
        {
            get
            {
                return this._ShowItemImagesInCart;
            }
            set
            {
                if ((this._ShowItemImagesInCart != value))
                {
                    this._ShowItemImagesInCart = value;
                }
            }
        }

        public string ShowItemImagesInWishList
        {
            get
            {
                return this._ShowItemImagesInWishList;
            }
            set
            {
                if ((this._ShowItemImagesInWishList != value))
                {
                    this._ShowItemImagesInWishList = value;
                }
            }
        }

        public string AllowUsersToCreateMultipleAddress
        {
            get
            {
                return this._AllowUsersToCreateMultipleAddress;
            }
            set
            {
                if ((this._AllowUsersToCreateMultipleAddress != value))
                {
                    this._AllowUsersToCreateMultipleAddress = value;
                }
            }
        }

        public string AllowUsersToStoreCreditCardDataInProfile
        {
            get
            {
                return this._AllowUsersToStoreCreditCardDataInProfile;
            }
            set
            {
                if ((this._AllowUsersToStoreCreditCardDataInProfile != value))
                {
                    this._AllowUsersToStoreCreditCardDataInProfile = value;
                }
            }
        }

        public string MinimumOrderAmount
        {
            get
            {
                return this._MinimumOrderAmount;
            }
            set
            {
                if ((this._MinimumOrderAmount != value))
                {
                    this._MinimumOrderAmount = value;
                }
            }
        }

        public string MinimumItemQuantity
        {
            get
            {
                return this._MinimumItemQuantity;
            }
            set
            {
                if ((this._MinimumItemQuantity != value))
                {
                    this._MinimumItemQuantity = value;
                }
            }
        }

        public string MaximumItemQuantity
        {
            get
            {
                return this._MaximumItemQuantity;
            }
            set
            {
                if ((this._MaximumItemQuantity != value))
                {
                    this._MaximumItemQuantity = value;
                }
            }
        }

        public string AllowCustomerToSignUpForUserGroup
        {
            get
            {
                return this._AllowCustomerToSignUpForUserGroup;
            }
            set
            {
                if ((this._AllowCustomerToSignUpForUserGroup != value))
                {
                    this._AllowCustomerToSignUpForUserGroup = value;
                }
            }
        }

        public string AllowCustomersToPayOrderAgainIfTransactionWasDeclined
        {
            get
            {
                return this._AllowCustomersToPayOrderAgainIfTransactionWasDeclined;
            }
            set
            {
                if ((this._AllowCustomersToPayOrderAgainIfTransactionWasDeclined != value))
                {
                    this._AllowCustomersToPayOrderAgainIfTransactionWasDeclined = value;
                }
            }
        }

        public string AllowPrivateMessages
        {
            get
            {
                return this._AllowPrivateMessages;
            }
            set
            {
                if ((this._AllowPrivateMessages != value))
                {
                    this._AllowPrivateMessages = value;
                }
            }
        }

        public string DefaultStoreTimeZone
        {
            get
            {
                return this._DefaultStoreTimeZone;
            }
            set
            {
                if ((this._DefaultStoreTimeZone != value))
                {
                    this._DefaultStoreTimeZone = value;
                }
            }
        }

        public string EnableCompareItems
        {
            get
            {
                return this._EnableCompareItems;
            }
            set
            {
                if ((this._EnableCompareItems != value))
                {
                    this._EnableCompareItems = value;
                }
            }
        }

        public string MaxNoOfItemsToCompare
        {
            get
            {
                return this._MaxNoOfItemsToCompare;
            }
            set
            {
                if ((this._MaxNoOfItemsToCompare != value))
                {
                    this._MaxNoOfItemsToCompare = value;
                }
            }
        }

        public string EnableWishList
        {
            get
            {
                return this._EnableWishList;
            }
            set
            {
                if ((this._EnableWishList != value))
                {
                    this._EnableWishList = value;
                }
            }
        }

        public string EnableEmailAFriend
        {
            get
            {
                return this._EnableEmailAFriend;
            }
            set
            {
                if ((this._EnableEmailAFriend != value))
                {
                    this._EnableEmailAFriend = value;
                }
            }
        }

        public string ShowMiniShoppingCart
        {
            get
            {
                return this._ShowMiniShoppingCart;
            }
            set
            {
                if ((this._ShowMiniShoppingCart != value))
                {
                    this._ShowMiniShoppingCart = value;
                }
            }
        }

        public string NotifyAboutNewItemReviews
        {
            get
            {
                return this._NotifyAboutNewItemReviews;
            }
            set
            {
                if ((this._NotifyAboutNewItemReviews != value))
                {
                    this._NotifyAboutNewItemReviews = value;
                }
            }
        }

        public string ItemReviewMustBeApproved
        {
            get
            {
                return this._ItemReviewMustBeApproved;
            }
            set
            {
                if ((this._ItemReviewMustBeApproved != value))
                {
                    this._ItemReviewMustBeApproved = value;
                }
            }
        }

        public string AllowAnonymousUserToWriteItemRatingAndReviews
        {
            get
            {
                return this._AllowAnonymousUserToWriteItemRatingAndReviews;
            }
            set
            {
                if ((this._AllowAnonymousUserToWriteItemRatingAndReviews != value))
                {
                    this._AllowAnonymousUserToWriteItemRatingAndReviews = value;
                }
            }
        }

        public string EnableRecentlyViewedItems
        {
            get
            {
                return this._EnableRecentlyViewedItems;
            }
            set
            {
                if ((this._EnableRecentlyViewedItems != value))
                {
                    this._EnableRecentlyViewedItems = value;
                }
            }
        }

        public string NoOfRecentlyViewedItemsDispay
        {
            get
            {
                return this._NoOfRecentlyViewedItemsDispay;
            }
            set
            {
                if ((this._NoOfRecentlyViewedItemsDispay != value))
                {
                    this._NoOfRecentlyViewedItemsDispay = value;
                }
            }
        }

        public string EnableLatestItems
        {
            get
            {
                return this._EnableLatestItems;
            }
            set
            {
                if ((this._EnableLatestItems != value))
                {
                    this._EnableLatestItems = value;
                }
            }
        }

        public string NoOfLatestItemsDisplay
        {
            get
            {
                return this._NoOfLatestItemsDisplay;
            }
            set
            {
                if ((this._NoOfLatestItemsDisplay != value))
                {
                    this._NoOfLatestItemsDisplay = value;
                }
            }
        }

        public string NoOfLatestItemsInARow
        {
            get
            {
                return this._NoOfLatestItemsInARow;
            }
            set
            {
                if ((this._NoOfLatestItemsInARow != value))
                {
                    this._NoOfLatestItemsInARow = value;
                }
            }
        }


        public string EnableBestSellerItems
        {
            get
            {
                return this._EnableBestSellerItems;
            }
            set
            {
                if ((this._EnableBestSellerItems != value))
                {
                    this._EnableBestSellerItems = value;
                }
            }
        }

        public string NoOfBestSellersItemDisplay
        {
            get
            {
                return this._NoOfBestSellersItemDisplay;
            }
            set
            {
                if ((this._NoOfBestSellersItemDisplay != value))
                {
                    this._NoOfBestSellersItemDisplay = value;
                }
            }
        }

        public string EnableSpecialItems
        {
            get
            {
                return this._EnableSpecialItems;
            }
            set
            {
                if ((this._EnableSpecialItems != value))
                {
                    this._EnableSpecialItems = value;
                }
            }
        }

        public string NoOfSpecialItemDisplay
        {
            get
            {
                return this._NoOfSpecialItemDisplay;
            }
            set
            {
                if ((this._NoOfSpecialItemDisplay != value))
                {
                    this._NoOfSpecialItemDisplay = value;
                }
            }
        }

        public string EnableRecentlyComparedItems
        {
            get
            {
                return this._EnableRecentlyComparedItems;
            }
            set
            {
                if ((this._EnableRecentlyComparedItems != value))
                {
                    this._EnableRecentlyComparedItems = value;
                }
            }
        }

        public string NoOfRecentlyComparedItems
        {
            get
            {
                return this._NoOfRecentlyComparedItems;
            }
            set
            {
                if ((this._NoOfRecentlyComparedItems != value))
                {
                    this._NoOfRecentlyComparedItems = value;
                }
            }
        }

        public string EnableRelatedCartItems
        {
            get
            {
                return this._EnableRelatedCartItems;
            }
            set
            {
                if ((this._EnableRelatedCartItems != value))
                {
                    this._EnableRelatedCartItems = value;
                }
            }
        }
    

        public string NoOfRelatedCartItems
        {
            get
            {
                return this._NoOfRelatedCartItems;
            }
            set
            {
                if ((this._NoOfRelatedCartItems != value))
                {
                    this._NoOfRelatedCartItems = value;
                }
            }
        }

        public string NoOfPopularTags
        {
            get
            {
                return this._NoOfPopularTags;
            }
            set
            {
                if ((this._NoOfPopularTags != value))
                {
                    this._NoOfPopularTags = value;
                }
            }
        }

        public string WeightUnit
        {
            get
            {
                return this._WeightUnit;
            }
            set
            {
                if ((this._WeightUnit != value))
                {
                    this._WeightUnit = value;
                }
            }
        }      
    }
}

