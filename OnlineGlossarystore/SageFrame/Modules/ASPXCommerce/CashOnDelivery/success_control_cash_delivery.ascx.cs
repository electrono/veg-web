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
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using SageFrame.Framework;
using ASPXCommerce.Core;
using System.Net;
using System.Text;
using System.Security.Cryptography;
using SageFrame.Web;
using SageFrame.SageFrameClass.MessageManagement;
using System.Collections;

public partial class Modules_ASPXCommerce_PaymentGateways_CashOnDelivery_success_control : BaseAdministrationUserControl
{

    //  string authToken, txToken, query;
    // string strResponse;
    public string sendEmailFrom, sendOrderNotice;
    bool IsUseFriendlyUrls = true;
    string sageRedirectPath = string.Empty;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                SageFrameConfig sfConfig = new SageFrameConfig();
                IsUseFriendlyUrls = sfConfig.GetSettingBollByKey(SageFrameSettingKeys.UseFriendlyUrls);

                if (IsUseFriendlyUrls)
                {
                    if (GetPortalID > 1)
                    {
                        sageRedirectPath = ResolveUrl("~/portal/" + GetPortalSEOName + "/" + sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage) + ".aspx");
                    }
                    else
                    {
                        sageRedirectPath = ResolveUrl("~/" + sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage) + ".aspx");
                    }
                }
                else
                {
                    sageRedirectPath = ResolveUrl("{~/Default.aspx?ptlid=" + GetPortalID + "&ptSEO=" + GetPortalSEOName + "&pgnm=" + sfConfig.GetSettingsByKey(SageFrameSettingKeys.PortalDefaultPage));
                }

                Image imgProgress = (Image)UpdateProgress1.FindControl("imgPrgress");
                if (imgProgress != null)
                {
                    imgProgress.ImageUrl = GetTemplateImageUrl("ajax-loader.gif", true);
                }
                hlnkHomePage.NavigateUrl = sageRedirectPath;

                sendEmailFrom = StoreSetting.GetStoreSettingValueByKey(StoreSetting.SendEcommerceEmailsFrom, GetStoreID, GetPortalID, GetCurrentCultureName);
                sendOrderNotice = StoreSetting.GetStoreSettingValueByKey(StoreSetting.SendOrderNotification, GetStoreID, GetPortalID, GetCurrentCultureName);
                SendConfrimMessage();
            }
        }
        catch
        {
        }
    }

    protected void SendConfrimMessage()
    {
        try
        {
            if (Session["OrderID"] != null)
            {
                string transID = string.Empty; // transaction ID from Relay Response
                int responseCode = 1; // response code, defaulted to Invalid
                string responsereasontext = string.Empty;
                responsereasontext = "Transaction occured Successfully";
                int responsereasonCode = 1;
                string purchaseorderNo = string.Empty;
                string invoice = string.Empty;
                string paymentmethod = string.Empty;
                OrderDetailsCollection orderdata2 = new OrderDetailsCollection();
                if (HttpContext.Current.Session["OrderCollection"] != null)
                {
                  
                    orderdata2 = (OrderDetailsCollection)HttpContext.Current.Session["OrderCollection"];
                   
                }
                invoice = orderdata2.objOrderDetails.InvoiceNumber.ToString();
                Random random = new Random();
                purchaseorderNo = (random.Next(0, 1000)).ToString();
                string timeStamp = ((int)(DateTime.UtcNow - new DateTime(2011, 1, 1)).TotalSeconds).ToString();
                transID = (random.Next(99999, 111111)).ToString();
                lblTransaction.Text = transID;
                lblInvoice.Text = invoice;
                lblPaymentMethod.Text = "Cash On Delivery";
                lblDateTime.Text = DateTime.Now.ToString("dddd, dd MMMM yyyy ");
                int storeID = int.Parse(GetStoreID.ToString());
                int portalID = int.Parse(GetPortalID.ToString());
                string userName = GetUsername.ToString();
                int customerID = int.Parse(GetCustomerID.ToString());
                string sessionCode = HttpContext.Current.Session.SessionID.ToString();
                string result = CashOnDelivery.Parse(transID, invoice, purchaseorderNo, responseCode, responsereasonCode, responsereasontext, storeID, portalID, userName, customerID, sessionCode);
                lblerror.Text = result.ToString();
                lblerror.Text = "Your payment has been successfully processed." +
                       "A confirmation email has been sent to you with the details of the order. Please quote the order number for all future correspondence regarding this transaction.";


                ASPXCommerceWebService clSes = new ASPXCommerceWebService();
                if (Session["IsFreeShipping"] != null)
                {
                    HttpContext.Current.Session.Remove("IsFreeShipping");
                }
                if (Session["DiscountAmount"] != null)
                {
                    HttpContext.Current.Session.Remove("DiscountAmount");

                }
                if (Session["CouponCode"] != null)
                {
                    HttpContext.Current.Session.Remove("CouponCode");
                }
                if (Session["CouponApplied"] != null)
                {
                    HttpContext.Current.Session.Remove("CouponApplied");
                }
                if (Session["DiscountAll"] != null)
                {
                    HttpContext.Current.Session.Remove("DiscountAll");
                }
                if (Session["TaxAll"] != null)
                {
                    HttpContext.Current.Session.Remove("TaxAll");
                }
                if (Session["ShippingCostAll"] != null)
                {
                    HttpContext.Current.Session.Remove("ShippingCostAll");
                }
                if (Session["GrandTotalAll"] != null)
                {
                    HttpContext.Current.Session.Remove("GrandTotalAll");
                }
                if (Session["Gateway"] != null)
                {
                    HttpContext.Current.Session.Remove("Gateway");
                }  

                //invoice  transID

                if (Session["OrderCollection"] != null)
                {

                    //StringBuilder emailbody = new StringBuilder();
                    //emailbody.Append("<div style=\"width:600px;min-height:auto;background-color:#f2f2f2;color:#707070;font:13px/24px Verdana,Geneva,sans-serif;\"><div style=\"color:#49B8F4;  font-size:20px;margin:auto 0; font-family:Verdana,Geneva,sans-serif;\"> <label>Thank you for Order </label></div>");
                    //OrderDetailsCollection orderdata = new OrderDetailsCollection();
                    //orderdata = (OrderDetailsCollection)Session["OrderCollection"];
                    //emailbody.Append("<p> <strong>Dear </strong> " + orderdata.objBillingAddressInfo.FirstName.ToString() + "</p>");
                    ////if customer is registered
                    //if (orderdata.objCommonInfo.AddedBy.ToString().ToLower() == "anonymoususer" && orderdata.objOrderDetails.CustomerID ==0)
                    //{
                    //    emailbody.Append("<div>  You have ordered items from <strong>ASPXCommerce</strong>. <br /> Thanks for using <strong>ASPXCommerce</strong>. You can now ship any items. To see all the transaction details, log in to your <b>ASPXCommerce</b> <a href=" + Request.ServerVariables["SERVER_NAME"] + "/Register.aspx?session="+sessionCode +"" + ">account</a>.<br /> It may take a few moments for this transaction to appear in your account.<br /></div> ");
                    //}
                    //else
                    //{//if customer is guest..send session code 
                    //    emailbody.Append("<div> You have ordered items from <strong>ASPXCommerce</strong>. <br /> Thanks for using <strong>ASPXCommerce</strong>. You can now ship any items. To see all the transaction details, Please Resister and log in to your <b>ASPXCommerce</b> <a href=" + Request.ServerVariables["SERVER_NAME"] + "/Login.aspx" + ">account</a>.<br /> It may take a few moments for this transaction to appear in your account.<br /></div>");
                    //}
                    //emailbody.Append("<div > <strong>Your Order Details </strong><br />  Transaction ID: <strong >" + transID + "</strong><br />Invoice No: <strong>" + invoice + "</strong><br />Paymenet System Used: <strong>" + orderdata.objPaymentInfo.PaymentMethodName + "</strong><br /> </div> ");
                    //emailbody.Append("<div > If you having Issuses with transaction or any further inquiry then you can mail info@aspxcommerce.com.</div><div> Please do not reply to this email. This mail is automatic generated after you have ordered .</div><div>Thank You, <br /><a href=\"" + Request.ServerVariables["SERVER_NAME"] + "\"><img src=\"" + "http://www.aspxcommerce.com" + "/Templates/ASPXCommerce/Templates/'"+ TemplateName +"'/images/aspxcommerce.png\" alt=\"ASPXCommerce Team\"/></a></div></div>");
                    //string body = emailbody.ToString();
                    //SageFrameConfig pagebase = new SageFrameConfig();
                    //string emailSuperAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);//"milsonmun@hotmail.com";
                    //string emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
                    //MailHelper.SendMailNoAttachment("yourorder@aspxcommerce.com", orderdata.objBillingAddressInfo.EmailAddress.ToString(), "Your Order Details", body, emailSuperAdmin, emailSiteAdmin);
                    //clSes.ClearSessionVariable("OrderCollection");




                    if (sendOrderNotice.ToLower() == "true")
                    {
                        StringBuilder emailbody = new StringBuilder();
                        OrderDetailsCollection orderdata = new OrderDetailsCollection();
                        orderdata = (OrderDetailsCollection)Session["OrderCollection"];
                        emailbody.Append("<table width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"5\" bgcolor=\"#e0e0e0\" style=\"font: 12px Arial,Helvetica,sans-serif;\"> <tr><td align=\"center\" valign=\"top\"><table width=\"680\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr> <td><img src=\"" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/blank.gif\" width=\"1\" height=\"10\" alt=\" \" /></td></tr><tr><td><table width=\"680\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"><tr> <td width=\"300\">");
                        emailbody.Append("<a href=\"http://www.aspxcommerce.com\" target=\"_blank\" style=\"outline: none; border: none;\"> <img src=\"http://www.aspxcommerce.com/Templates/'" + TemplateName + "'/images/aspxcommerce.png\" width=\"143\" height=\"62\" alt=\"Aspxcommerce\" title=\"Aspxcommerce\" /></a></td><td width=\"191\" align=\"left\" valign=\"middle\">");
                        emailbody.Append("&nbsp;</td><td width=\"189\" align=\"right\" valign=\"middle\"><b style=\"padding: 0 20px 0 0; text-shadow: 1px 1px 0 #fff;\">" + DateTime.Now.ToString("dd MMMM yyyy ") + "</b>");
                        emailbody.Append("</td> </tr></table> </td> </tr> <tr>  <td bgcolor=\"#fff\"><div style=\"border:1px solid #c7c7c7; background:#fff; padding:20px\">  <img src=\"" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/blank.gif\" width=\"1\" height=\"10\" alt=\" \" /><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" bgcolor=\"#FFFFFF\">  <tr> <td> <p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 17px; line-height: 16px;color: #278ee6; margin: 0; padding: 0 0 5px 0; font-weight: bold;\"> ");
                        emailbody.Append(" Dear " + orderdata.objBillingAddressInfo.FirstName.ToString() + "</p> <p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 13px; line-height: 16px; color: #393939; margin: 0; padding: 0 0 10px 0; font-weight: bold;\">  Thank you for Order</p>");
                        emailbody.Append("<p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 18px; color: #393939; margin: 0; padding: 8px 0 15px 0; font-weight: normal;\">You have ordered items from <span style=\"font-weight: bold; font-size: 11px;\">AspxCommerce</span>.<br />");
                        emailbody.Append("Thanks for using <span style=\"font-weight: bold; font-size: 11px;\">AspxCommerce</span>. You can now ship any items. To see all the transaction details,");
                        // emailbody.Append("  Please Register and log in to your <span style=\"font-weight: bold; font-size: 11px;\">ASPXCommerce</span>");
                        string account = "";
                        if (orderdata.objCommonInfo.AddedBy.ToString().ToLower() == "anonymoususer" && orderdata.objOrderDetails.CustomerID == 0)
                        {   // future login process for annoymoususr 
                            emailbody.Append("Please Register and log in to your <span style=\"font-weight: bold; font-size: 11px;\">AspxCommerce</span>");

                            account = "<a href=" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/User-Registration.aspx" + ">account</a>";
                        }
                        else
                        {
                            emailbody.Append("  Please log in to your <span style=\"font-weight: bold; font-size: 11px;\">AspxCommerce</span>");

                            account = "<a href=" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/Login.aspx" + ">account</a>";
                        }


                        emailbody.Append(" " + account + ".<br />  It may take a few moments for this transaction to appear in your account</p>  </td></tr>  </table><div style=\"border: 1px solid #cfcfcf; background: #f1f1f1; padding: 10px\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> <tr> <td><h3 style=\"font-size: 15px; font-family: Arial, Helvetica, sans-serif; line-height: 20px; font-weight: bold; margin: 0; text-transform: capitalize; color: #000; text-shadow: 1px 1px 0 #fff;\">  Your Order Details</h3></td></tr><tr><td><img src=\"" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/blank.gif\" width=\"1\" height=\"10\" alt=\" \" /></td>");
                        emailbody.Append(" </tr><tr><td bgcolor=\"#fff\"><div style=\"border: 1px solid #c7c7c7; background: #fff; padding: 10px\">");
                        emailbody.Append("<div style=\"border: 1px solid #cfcfcf; background: #f1f1f1; padding: 10px\">");
                        emailbody.Append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                        emailbody.Append("<tr>  <td height=\"25\" style=\"border-bottom: 1px solid #fff;\">");
                        emailbody.Append("<h3 style=\"font-size: 15px; font-family: Arial, Helvetica, sans-serif; line-height: 20px;");
                        emailbody.Append("font-weight: bold; margin: 0; text-transform: capitalize; color: #000; text-shadow: 1px 1px 0 #fff;\">Order Information</h3>");
                        emailbody.Append("</td></tr><tr> <td> <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                        emailbody.Append(" <tr><td width=\"120\" height=\"20\"><span style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;\">");
                        emailbody.Append(" Merchant:</span> </td> <td>");
                        //  merchant Name
                        emailbody.Append("ASPX Commerce");
                        emailbody.Append(" </td> <td width=\"150\" style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px;");
                        emailbody.Append(" font-weight: bold; border-left: 1px solid #fff; padding-left: 20px;\"> Customer Id:  <td>");
                        // customer ID
                        emailbody.Append("" + GetCustomerID.ToString() + "");
                        emailbody.Append(" </td> </tr>  <tr>  <td height=\"20\"> <span style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;\">");
                        emailbody.Append(" Description:</span>  </td> <td> Order Remarks</td> <td style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;");
                        emailbody.Append(" border-left: 1px solid #fff; padding-left: 20px;\"> Phone No: </td> <td>");
                        // customer Phone No
                        emailbody.Append("" + orderdata.objBillingAddressInfo.Phone.ToString() + "");                        
                        emailbody.Append("  </td> </tr> <td height=\"20\"><span style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;\">");
                        emailbody.Append(" Invoice Number:</span> </td><td>");
                        //   invoice no 
                        // emailbody.Append("" + orderdata.objOrderDetails.InvoiceNumber.ToString() + "");
                        emailbody.Append("" + invoice + "");
                        emailbody.Append(" </td> <td style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;  border-left: 1px solid #fff; padding-left: 20px;\">");
                        emailbody.Append("  &nbsp;</td><td> &nbsp;</td></tr></table>  </td> </tr> </table> </div>");
                        emailbody.Append(" <div style=\"border: 1px solid #cfcfcf; background: #f1f1f1; padding: 0; margin: 10px 0 0 0;\">");
                        emailbody.Append(" <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                        emailbody.Append(" <tr> <td width=\"300\" style=\"background: #e0e0e0;\"> <h2 style=\"margin: 0; padding: 0; font-weight: bold; font-family: Arial, Helvetica, sans-serif;");
                        emailbody.Append("  font-size: 15px; padding: 3px 0 3px 10px; text-shadow: 1px 1px 0 #fff;\">");
                        emailbody.Append("  Billing Information</h2>  </td><td style=\"background: #e0e0e0; border-left: 1px solid #fff;\">");
                        emailbody.Append("   <h2 style=\"margin: 0; padding: 0; font-weight: bold; font-family: Arial, Helvetica, sans-serif;");
                        emailbody.Append("  font-size: 15px; padding: 3px 0 3px 10px; text-shadow: 1px 1px 0 #fff;\">");
                        emailbody.Append(" Shipping Information</h2> </td></tr><tr><td valign=\"top\"> <p style=\"margin: 0; padding: 10px; font-family: Arial, Helvetica, sans-serif; font-weight: normal;");
                        emailbody.Append("  line-height: 18px; font-size: 12px;\">");
                        //Milson Munakami<br />
                        //                                                               Bd<br />
                        //                                                               sda<br />
                        //                                                               Dsad, Alberta 3232<br />
                        //                                                               Afghanistan<br />
                        //                                                               milson@braindigit.com<br />
                        //                                                               +000 000 0000<br />
                        //                                                               Fax: 2222222</p>
                        //                                                       </td>

                        string billing = orderdata.objBillingAddressInfo.FirstName.ToString() + " " +
                          orderdata.objBillingAddressInfo.LastName.ToString() + "<br />";

                        if (orderdata.objBillingAddressInfo.CompanyName != null)
                        {
                            billing += orderdata.objBillingAddressInfo.CompanyName.ToString() + "<br />";
                        }

                        billing += orderdata.objBillingAddressInfo.City.ToString() + ", " + orderdata.objBillingAddressInfo.Address.ToString() + "<br />" +
                        orderdata.objBillingAddressInfo.Country.ToString() + "<br />" +
                        orderdata.objBillingAddressInfo.EmailAddress.ToString() + "<br />" +
                        orderdata.objBillingAddressInfo.Phone.ToString() + "<br />" + "<p>";

                        emailbody.Append("" + billing + "");
                        emailbody.Append("</td><td style=\"border-left: 1px solid #fff;\" valign=\"top\"> <p style=\"margin: 0; padding: 10px; font-family: Arial, Helvetica, sans-serif; font-weight: normal;");
                        emailbody.Append("line-height: 18px; font-size: 12px;\">");
                        //Milson Munakami<br />
                        //                                                              Bd<br />
                        //                                                              sda<br />
                        //                                                              Dsad, Alberta 3232<br />
                        //                                                              Afghanistan<br />
                        //                                                              milson@braindigit.com<br />
                        //                                                              +000 000 0000<br />
                        //                                                              Fax: 2222222</p>

                        if (!orderdata.objOrderDetails.IsDownloadable)
                        {
                            if (orderdata.objOrderDetails.IsMultipleCheckOut == false)
                            {
                                string shipping = orderdata.objShippingAddressInfo.FirstName.ToString() + " " +
                                    orderdata.objShippingAddressInfo.LastName.ToString() + "<br />";
                                if (orderdata.objShippingAddressInfo.CompanyName != null)
                                {
                                    shipping += orderdata.objShippingAddressInfo.CompanyName.ToString() + "<br />";
                                }

                                shipping += orderdata.objShippingAddressInfo.City.ToString() + ", " + orderdata.objShippingAddressInfo.Address.ToString() + "<br />" +
                                      orderdata.objShippingAddressInfo.Country.ToString() + "<br />" +
                                      orderdata.objShippingAddressInfo.EmailAddress.ToString() + "<br />" +
                                      orderdata.objShippingAddressInfo.Phone.ToString() + "<br />" + "<p>";
                                emailbody.Append("" + shipping + "");
                            }
                            else
                            {
                                emailbody.Append("Multiple addresses<br />Plese log in to view.");
                            }

                        }
                        emailbody.Append("</td> </tr> </table></div><div style=\"border: 1px solid #cfcfcf; background: #f1f1f1; padding: 0; margin: 10px 0 0 0;\">");
                        emailbody.Append("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                        emailbody.Append("<tr><td style=\"background: #e0e0e0;\" colspan=\"2\"><h2 style=\"margin: 0; padding: 0; font-weight: bold; font-family: Arial, Helvetica, sans-serif;");
                        emailbody.Append("font-size: 15px; padding: 3px 0 3px 10px; text-shadow: 1px 1px 0 #fff;\">");
                        // card type Visa
                        emailbody.Append("" + orderdata.objPaymentInfo.PaymentMethodName.ToString() + "");
                        // emailbody.Append("" + orderdata.objPaymentInfo.CardType.ToString() + "");
                        emailbody.Append("</h2> </td></tr><tr><td style=\"padding: 5px 10px;\"><table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">");
                        emailbody.Append("<tr><td width=\"100\" height=\"20\" style=\"width: 200\">  <p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;");
                        emailbody.Append(" margin: 0; padding: 0;\"> Date/Time:</p></td><td>");
                        //    order date
                        emailbody.Append("" + DateTime.Now.ToString("dddd, dd MMMM yyyy") + "");
                        emailbody.Append("</td></tr><tr><td height=\"20\"><p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 11px; font-weight: bold;");
                        emailbody.Append(" margin: 0; padding: 0;\">Transaction Id:</p> </td>  <td>");
                        //     transaction ID
                        // emailbody.Append("" + orderdata.objOrderDetails.TransactionID.ToString() + "");
                        emailbody.Append("" + transID + "");
                        emailbody.Append("</td> </tr></table> </td> </tr> </table></div></div>  </td> </tr>  </table>  </div>");
                        emailbody.Append(" <p style=\"font-family: Arial, Helvetica, sans-serif; font-size: 12px; font-weight: normal; color: #000;\">");
                        emailbody.Append(" if you having Issues with transaction or any further inquiry then you can mail <a");
                        emailbody.Append("href=\"mailto:info@aspxcommerce.com\" style=\"color: #278ee6;\">info@aspxcommerce.com</a></p>");
                        emailbody.Append("<p style=\"margin: 0; padding: 5px 0 0 0; font: bold 11px Arial, Helvetica, sans-serif; color: #666;\">");
                        emailbody.Append("Please do not reply to this email. This mail is automatic generated after you have ordered.</a><br />");
                        emailbody.Append("<br /> Thank You,<br />  <span style=\"font-weight: normal; font-size: 12px; font-family: Arial, Helvetica, sans-serif;\">");
                        emailbody.Append("AspxCommerce Team </span> </p> </div> </td>  </tr>");
                        emailbody.Append("  <tr> <td>   <img src=\"" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/blank.gif\" width=\"1\" height=\"20\" alt=\" \" /> </td>");
                        emailbody.Append("</tr> <tr> <td align=\"center\" valign=\"top\"> <p style=\"font-size: 11px; color: #4d4d4d\">");
                        emailbody.Append("  © " + DateTime.Now.Year.ToString() + " AspxCommerce. All Rights Reserved.</p></td>  </tr> <tr>");
                        emailbody.Append("  <td align=\"center\" valign=\"top\"> <img src=\"" + HttpContext.Current.Request.ServerVariables["SERVER_NAME"] + "/blank.gif\" width=\"1\" height=\"10\" alt=\" \" />");
                        emailbody.Append("   </td>  </tr> </table></div>   </td> </tr> </table>");
                        string body = emailbody.ToString();
                        SageFrameConfig pagebase = new SageFrameConfig();
                        string emailSuperAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SuperUserEmail);//"milsonmun@hotmail.com";
                        string emailSiteAdmin = pagebase.GetSettingsByKey(SageFrameSettingKeys.SiteAdminEmailAddress);
                        MailHelper.SendMailNoAttachment(sendEmailFrom, orderdata.objBillingAddressInfo.EmailAddress.ToString(), "Your Order Details", body, emailSuperAdmin, emailSiteAdmin);

                    }

                    clSes.ClearSessionVariable("OrderCollection");
                   
                }
            }
            else
            {
                Response.Redirect(sageRedirectPath, false);
            }
        }
        catch (Exception ex)
        {
            ProcessException(ex);
        }
    }
}
