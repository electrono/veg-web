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
using SageFrame.Web;
using SageFrame.Web.Utilities;
using System.Data.SqlClient;
using System.Data;

namespace ASPXCommerce.Core
{
    public class ASPXOrderDetails
    {
        public int AddAddress(OrderDetailsCollection OrderData, SqlTransaction tran)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@FirstName", OrderData.objBillingAddressInfo.FirstName));
                ParaMeter.Add(new KeyValuePair<string, object>("@LastName", OrderData.objBillingAddressInfo.LastName));
                ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", OrderData.objOrderDetails.CustomerID));
                ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", OrderData.objOrderDetails.SessionCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@Email", OrderData.objBillingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@Company", OrderData.objBillingAddressInfo.CompanyName));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address1", OrderData.objBillingAddressInfo.Address));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address2", OrderData.objBillingAddressInfo.Address2));
                ParaMeter.Add(new KeyValuePair<string, object>("@City", OrderData.objBillingAddressInfo.City));
                ParaMeter.Add(new KeyValuePair<string, object>("@State", OrderData.objBillingAddressInfo.State));
                ParaMeter.Add(new KeyValuePair<string, object>("@Country", OrderData.objBillingAddressInfo.Country));
                ParaMeter.Add(new KeyValuePair<string, object>("@Zip", OrderData.objBillingAddressInfo.Zip));
                ParaMeter.Add(new KeyValuePair<string, object>("@Phone", OrderData.objBillingAddressInfo.Phone));
                ParaMeter.Add(new KeyValuePair<string, object>("@Mobile", OrderData.objBillingAddressInfo.Mobile));
                ParaMeter.Add(new KeyValuePair<string, object>("@Fax", OrderData.objBillingAddressInfo.Fax));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", OrderData.objBillingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@WebSite", OrderData.objBillingAddressInfo.WebSite));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();

                int addressID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure,
                                                            "USP_ASPX_UserAddress", ParaMeter,
                                                            "@AddressID");

                return addressID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddBillingAddress(OrderDetailsCollection OrderData, SqlTransaction tran, int addressID)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@AddressID", addressID));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsDefault",
                                                               OrderData.objBillingAddressInfo.IsDefaultBilling));

                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();

                int billingAddressID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure,
                                                            "USP_ASPX_UserBillingAddress", ParaMeter,
                                                            "@UserBillingAddressID");

                return addressID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddShippingAddress(OrderDetailsCollection OrderData, SqlTransaction tran, int addressID)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@AddressID", addressID));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsDefault",
                                                               OrderData.objShippingAddressInfo.IsDefaultShipping));

                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();

                int shippingAddressID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure,
                                                             "USP_ASPX_UserShippingAddress", ParaMeter,
                                                             "@UserShippingAddressID");

                return addressID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddBillingAddress(OrderDetailsCollection OrderData, SqlTransaction tran)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", OrderData.objOrderDetails.CustomerID));
                ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode",OrderData.objOrderDetails.SessionCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@FirstName", OrderData.objBillingAddressInfo.FirstName));
                ParaMeter.Add(new KeyValuePair<string, object>("@LastName", OrderData.objBillingAddressInfo.LastName));
                ParaMeter.Add(new KeyValuePair<string, object>("@Email", OrderData.objBillingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@Company", OrderData.objBillingAddressInfo.CompanyName));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address1", OrderData.objBillingAddressInfo.Address));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address2", OrderData.objBillingAddressInfo.Address2));
                ParaMeter.Add(new KeyValuePair<string, object>("@City", OrderData.objBillingAddressInfo.City));
                ParaMeter.Add(new KeyValuePair<string, object>("@State", OrderData.objBillingAddressInfo.State));
                ParaMeter.Add(new KeyValuePair<string, object>("@Country", OrderData.objBillingAddressInfo.Country));
                ParaMeter.Add(new KeyValuePair<string, object>("@Zip", OrderData.objBillingAddressInfo.Zip));
                ParaMeter.Add(new KeyValuePair<string, object>("@Phone", OrderData.objBillingAddressInfo.Phone));
                ParaMeter.Add(new KeyValuePair<string, object>("@Mobile", OrderData.objBillingAddressInfo.Mobile));
                ParaMeter.Add(new KeyValuePair<string, object>("@Fax", OrderData.objBillingAddressInfo.Fax));
                ParaMeter.Add(new KeyValuePair<string, object>("@WebSite", OrderData.objBillingAddressInfo.WebSite));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName", OrderData.objBillingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsDefault", OrderData.objBillingAddressInfo.IsDefaultBilling));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();

                int billingAddressID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure,
                                                            "USP_ASPX_BillingAddress", ParaMeter,
                                                            "@UserBillingAddressID");

                return billingAddressID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddShippingAddress(OrderDetailsCollection OrderData, SqlTransaction tran)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", OrderData.objOrderDetails.CustomerID));
                ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode",  OrderData.objOrderDetails.SessionCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@FirstName",  OrderData.objShippingAddressInfo.FirstName));
                ParaMeter.Add(new KeyValuePair<string, object>("@LastName",  OrderData.objShippingAddressInfo.LastName));
                ParaMeter.Add(new KeyValuePair<string, object>("@Email", OrderData.objShippingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@Company", OrderData.objShippingAddressInfo.CompanyName));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address1", OrderData.objShippingAddressInfo.Address));
                ParaMeter.Add(new KeyValuePair<string, object>("@Address2", OrderData.objShippingAddressInfo.Address2));
                ParaMeter.Add(new KeyValuePair<string, object>("@City",  OrderData.objShippingAddressInfo.City));
                ParaMeter.Add(new KeyValuePair<string, object>("@State", OrderData.objShippingAddressInfo.State));
                ParaMeter.Add(new KeyValuePair<string, object>("@Country",  OrderData.objShippingAddressInfo.Country));
                ParaMeter.Add(new KeyValuePair<string, object>("@Zip", OrderData.objShippingAddressInfo.Zip));
                ParaMeter.Add(new KeyValuePair<string, object>("@Phone", OrderData.objShippingAddressInfo.Phone));
                ParaMeter.Add(new KeyValuePair<string, object>("@Mobile", OrderData.objShippingAddressInfo.Mobile));
                ParaMeter.Add(new KeyValuePair<string, object>("@Fax", OrderData.objShippingAddressInfo.Fax));
                ParaMeter.Add(new KeyValuePair<string, object>("@WebSite", OrderData.objShippingAddressInfo.WebSite));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserName",  OrderData.objShippingAddressInfo.EmailAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsDefault", OrderData.objBillingAddressInfo.IsDefaultBilling));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                SQLHandler sqlH = new SQLHandler();                
                int shippingAddressID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure,
                                                             "USP_ASPX_ShippingAddress", ParaMeter,
                                                             "@UserShippingAddressID");

                return shippingAddressID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddPaymentInfo(OrderDetailsCollection OrderData, SqlTransaction tran)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentMethodName",
                                                               OrderData.objPaymentInfo.PaymentMethodName));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentMethodCode",
                                                               OrderData.objPaymentInfo.PaymentMethodCode));
                if (OrderData.objPaymentInfo.PaymentMethodCode == "CC")
                {
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardNumber", OrderData.objPaymentInfo.CardNumber));
                    ParaMeter.Add(new KeyValuePair<string, object>("@TransactionType",
                                                                   OrderData.objPaymentInfo.TransactionType));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardType", OrderData.objPaymentInfo.CardType));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardCode", OrderData.objPaymentInfo.CardCode));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ExpireDate", OrderData.objPaymentInfo.ExpireDate));

                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountNumber",
                                                                   ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RoutingNumber",
                                                                   ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@BankName", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountHolderName",
                                                                   ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeNumber",
                                                                   ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RecurringBillingStatus",
                                                                   false));
                }
                else if (OrderData.objPaymentInfo.PaymentMethodCode == "ECHECK")
                {
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardNumber", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@TransactionType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardCode", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ExpireDate", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountNumber", OrderData.objPaymentInfo.AccountNumber));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RoutingNumber", OrderData.objPaymentInfo.RoutingNumber));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountType", OrderData.objPaymentInfo.AccountType));
                    ParaMeter.Add(new KeyValuePair<string, object>("@BankName", OrderData.objPaymentInfo.BankName));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountHolderName", OrderData.objPaymentInfo.AccountHolderName));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeType", OrderData.objPaymentInfo.ChequeType));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeNumber", OrderData.objPaymentInfo.ChequeNumber));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RecurringBillingStatus", OrderData.objPaymentInfo.RecurringBillingStatus));
                }
                else
                {
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardNumber", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@TransactionType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CardCode", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ExpireDate", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountNumber", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RoutingNumber", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@BankName", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AccountHolderName", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeType", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ChequeNumber", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@RecurringBillingStatus", OrderData.objPaymentInfo.RecurringBillingStatus));

                }

                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                SQLHandler sqlH = new SQLHandler();
                int paymentMethodID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure, "[USP_ASPX_PaymentInfo]",
                                                           ParaMeter, "@PaymentMethodID");
                return paymentMethodID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddOrderWithMultipleCheckOut(OrderDetailsCollection OrderData, SqlTransaction tran, int paymentMethodId)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@InvoiceNumber", OrderData.objOrderDetails.InvoiceNumber));
                ParaMeter.Add(new KeyValuePair<string, object>("@TransactionID", OrderData.objOrderDetails.TransactionID));
                ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", ""));
                ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", OrderData.objOrderDetails.CustomerID));
                ParaMeter.Add(new KeyValuePair<string, object>("@GrandTotal", OrderData.objOrderDetails.GrandTotal));
                ParaMeter.Add(new KeyValuePair<string, object>("@DiscountAmount", OrderData.objOrderDetails.DiscountAmount));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", OrderData.objOrderDetails.CouponCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@PurchaseOrderNumber",  OrderData.objOrderDetails.PurchaseOrderNumber));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentGateTypeID",   OrderData.objOrderDetails.PaymentGatewayTypeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentGateSubTypeID",   OrderData.objOrderDetails.PaymentGatewaySubTypeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@ClientIPAddress",  OrderData.objOrderDetails.ClientIPAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserBillingAddressID", OrderData.objOrderDetails.UserBillingAddressID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentMethodID",  paymentMethodId));
                ParaMeter.Add(new KeyValuePair<string, object>("@OrderStatusID", OrderData.objOrderDetails.OrderStatusID));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsGuestUser", "False"));
                ParaMeter.Add(new KeyValuePair<string, object>("@TaxTotal", OrderData.objOrderDetails.TaxTotal));
                ParaMeter.Add(new KeyValuePair<string, object>("@CurrencyCode", OrderData.objOrderDetails.CurrencyCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseCode", OrderData.objOrderDetails.ResponseCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonCode", OrderData.objOrderDetails.ResponseReasonCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonText",  OrderData.objOrderDetails.ResponseReasonText));
                ParaMeter.Add(new KeyValuePair<string, object>("@Remarks", OrderData.objOrderDetails.Remarks));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();
                int orderID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure, "[USP_ASPX_OrderDetails]",
                                                   ParaMeter, "@OrderID");
                return orderID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public int AddOrder(OrderDetailsCollection OrderData, SqlTransaction tran,int billingAddressID,int paymentMethodId)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                ParaMeter.Add(new KeyValuePair<string, object>("@InvoiceNumber", OrderData.objOrderDetails.InvoiceNumber));
                if (OrderData.objOrderDetails.CustomerID == 0)
                {
                    ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", OrderData.objOrderDetails.SessionCode));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", 0));
                }
                else
                {
                    ParaMeter.Add(new KeyValuePair<string, object>("@SessionCode", ""));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CustomerID", OrderData.objOrderDetails.CustomerID));
                }
                ParaMeter.Add(new KeyValuePair<string, object>("@TransactionID", OrderData.objOrderDetails.TransactionID));
                ParaMeter.Add(new KeyValuePair<string, object>("@GrandTotal", OrderData.objOrderDetails.GrandTotal));
                ParaMeter.Add(new KeyValuePair<string, object>("@DiscountAmount",
                                                               OrderData.objOrderDetails.DiscountAmount));
                ParaMeter.Add(new KeyValuePair<string, object>("@CouponCode", OrderData.objOrderDetails.CouponCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@PurchaseOrderNumber",
                                                               OrderData.objOrderDetails.PurchaseOrderNumber));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentGateTypeID",
                                                               OrderData.objOrderDetails.PaymentGatewayTypeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentGateSubTypeID",
                                                               OrderData.objOrderDetails.PaymentGatewaySubTypeID));
                ParaMeter.Add(new KeyValuePair<string, object>("@ClientIPAddress",
                                                               OrderData.objOrderDetails.ClientIPAddress));
                ParaMeter.Add(new KeyValuePair<string, object>("@UserBillingAddressID",
                                                               billingAddressID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PaymentMethodID",
                                                               paymentMethodId));
                ParaMeter.Add(new KeyValuePair<string, object>("@OrderStatusID", OrderData.objOrderDetails.OrderStatusID));
                ParaMeter.Add(new KeyValuePair<string, object>("@IsGuestUser", OrderData.objOrderDetails.IsGuestUser));
                ParaMeter.Add(new KeyValuePair<string, object>("@TaxTotal", OrderData.objOrderDetails.TaxTotal));
                ParaMeter.Add(new KeyValuePair<string, object>("@CurrencyCode", OrderData.objOrderDetails.CurrencyCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseCode", OrderData.objOrderDetails.ResponseCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonCode",
                                                               OrderData.objOrderDetails.ResponseReasonCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonText",
                                                               OrderData.objOrderDetails.ResponseReasonText));
                ParaMeter.Add(new KeyValuePair<string, object>("@Remarks", OrderData.objOrderDetails.Remarks));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));

                SQLHandler sqlH = new SQLHandler();
                int orderID = sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure, "[USP_ASPX_OrderDetails]",
                                                   ParaMeter, "@OrderID");
                return orderID;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
     
        public void UpdateOrderDetails(OrderDetailsCollection OrderData)
        {
            try
            {
                List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

              //  ParaMeter.Add(new KeyValuePair<string, object>("@InvoiceNumber", DateTime.Now.ToString("yyyyMMddhhmmss"))); 
                ParaMeter.Add(new KeyValuePair<string, object>("@TransactionID", OrderData.objOrderDetails.TransactionID));               
                ParaMeter.Add(new KeyValuePair<string, object>("@OrderStatusID", OrderData.objOrderDetails.OrderStatusID));         
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseCode", OrderData.objOrderDetails.ResponseCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonCode", OrderData.objOrderDetails.ResponseReasonCode));
                ParaMeter.Add(new KeyValuePair<string, object>("@ResponseReasonText", OrderData.objOrderDetails.ResponseReasonText));
                ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                ParaMeter.Add(new KeyValuePair<string, object>("@OrderID", OrderData.objOrderDetails.OrderID));
                SQLHandler sqlH = new SQLHandler();
                sqlH.ExecuteNonQuery("[dbo].[usp_ASPX_UpdateOrderDetails]", ParaMeter);
               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void ReduceCouponUsed(string couponCode,int storeID,int portalID,string userName)
        {
            CouponManageSQLProvider csm = new CouponManageSQLProvider();
            csm.UpdateCouponUserRecord(couponCode, storeID, portalID, userName);
        }
     
      
        public void UpdateItemQuantity(OrderDetailsCollection OrderData)
        {
            try
            {
                if (OrderData.objOrderDetails.CouponCode.Trim() != null && System.Web.HttpContext.Current.Session["CouponApplied"] != null)
                {
                    ReduceCouponUsed(OrderData.objOrderDetails.CouponCode.Trim(), OrderData.objCommonInfo.StoreID, OrderData.objCommonInfo.PortalID, OrderData.objCommonInfo.AddedBy);
                }

                foreach (OrderItemInfo objItems in OrderData.lstOrderItemsInfo)
                {
                    if (objItems.IsDownloadable != true)
                    {
                        List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();
                        ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                        ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", objItems.ItemID));
                        ParaMeter.Add(new KeyValuePair<string, object>("@Quantity", objItems.Quantity));
                        SQLHandler sqlH = new SQLHandler();
                        sqlH.ExecuteNonQuery("[dbo].[usp_ASPX_UpdateItemQuantitybyOrder]", ParaMeter);
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        //multiple
        public void AddOrderItemsList(OrderDetailsCollection OrderData, SqlTransaction tran, int orderID)
        {
            try
            {
                foreach (OrderItemInfo objItems in OrderData.lstOrderItemsInfo)
                {
                    List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                    ParaMeter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@UserShippingAddressID", objItems.ShippingAddressID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", objItems.ShippingMethodID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", objItems.ItemID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Price", objItems.Price));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Quantity", objItems.Quantity));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Weight", objItems.Weight));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Remarks", objItems.Remarks));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ShippingRate", objItems.ShippingRate));
                    ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CostVariants", objItems.Variants));                   
                       SQLHandler sqlH = new SQLHandler();
                    sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure, "[USP_ASPX_ORDERITEM]", ParaMeter);
             
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        //single
        public void AddOrderItems(OrderDetailsCollection OrderData, SqlTransaction tran,int orderID,int shippingAddressID)
        {
            try
            {
                foreach (OrderItemInfo objItems in OrderData.lstOrderItemsInfo)
                {
                    List<KeyValuePair<string, object>> ParaMeter = new List<KeyValuePair<string, object>>();

                    ParaMeter.Add(new KeyValuePair<string, object>("@OrderID", orderID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@UserShippingAddressID", shippingAddressID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ShippingMethodID", objItems.ShippingMethodID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ItemID", objItems.ItemID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Price", objItems.Price));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Quantity", objItems.Quantity));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Weight", objItems.Weight));
                    ParaMeter.Add(new KeyValuePair<string, object>("@Remarks", objItems.Remarks));
                    ParaMeter.Add(new KeyValuePair<string, object>("@ShippingRate", objItems.ShippingRate));

                    ParaMeter.Add(new KeyValuePair<string, object>("@StoreID", OrderData.objCommonInfo.StoreID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@PortalID", OrderData.objCommonInfo.PortalID));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CultureName", OrderData.objCommonInfo.CultureName));
                    ParaMeter.Add(new KeyValuePair<string, object>("@AddedBy", OrderData.objCommonInfo.AddedBy));
                    ParaMeter.Add(new KeyValuePair<string, object>("@CostVariants", objItems.Variants));                 
                  
                    SQLHandler sqlH = new SQLHandler();
                    sqlH.ExecuteNonQuery(tran, CommandType.StoredProcedure, "[USP_ASPX_ORDERITEM]", ParaMeter);
                   
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
