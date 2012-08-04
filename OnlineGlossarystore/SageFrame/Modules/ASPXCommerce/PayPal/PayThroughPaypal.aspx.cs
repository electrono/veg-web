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
using SageFrame;
using SageFrame.Framework;
using System.Web.Services;
using System.IO;
using ASPXCommerce.PayPal;
using ASPXCommerce.Core;

public partial class Modules_ASPXCommerce_PayPalGateWay_PayThroughPaypal : PageBase
{
    public string aspxPaymentModulePath;
    public int storeID;
    public int portalID;
    public int customerID;
    public string userName;
    public string cultureName;
    public string sessionCode = string.Empty;
    public int PayPal;
    public string Spath;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                if (Session["PaypalData"] != null)
                {
                    string[] data = Session["PaypalData"].ToString().Split('#');
                    storeID = int.Parse(data[0].ToString());
                    portalID = int.Parse(data[1].ToString());
                    userName = data[2];
                    customerID = int.Parse(data[3].ToString());
                    sessionCode = data[4].ToString();
                    cultureName = data[5];
                    Spath = ResolveUrl("~/Modules/ASPXCommerce/ASPXCommerceServices/");
                    clickhere.Attributes.Add("onclick", "javascript:return document.PaypalForm.submit()");
                    LoadSetting();
                    GetCartDetails();                 
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "test", "document.PaypalForm.submit();", true);

                }
                else
                {
                    lblnotity.Text = "Something goes wrong, hit refresh or go back to checkout";
                    clickhere.Visible = false;
                }
            }

        }
        catch (Exception ex)
        {
            lblnotity.Text = "Something goes wrong, hit refresh or go back to checkout";
            clickhere.Visible = false;
            ProcessException(ex);      
        }       

    } 

    [WebMethod]
    public static void SetSessionVariable(string key, string value)
    {
        HttpContext.Current.Session[key] = value;

    }
    public void LoadSetting()
    {
        PayPalWCFService pw = new PayPalWCFService();
        List<PayPalSettingInfo> sf;
        OrderDetailsCollection orderdata2 = new OrderDetailsCollection();
        orderdata2 = (OrderDetailsCollection)HttpContext.Current.Session["OrderCollection"];

        try
        {
            sf = pw.GetAllPayPalSetting(int.Parse(Session["GateWay"].ToString()), storeID, portalID);

            string sAdd;

            if (bool.Parse(sf[0].IsTestPaypal.ToString()))
            {
                PaypalForm.Action = "https://www.sandbox.paypal.com/us/cgi-bin/webscr";
                HttpContext.Current.Session["IsTestPayPal"] = true;
                // clickhere.NavigateUrl="https://www.sandbox.paypal.com/us/cgi-bin/webscr";
            }
            else
            {
                PaypalForm.Action = "https://www.paypal.com/us/cgi-bin/webscr";
                HttpContext.Current.Session["IsTestPayPal"] = false;
                // clickhere.NavigateUrl = "https://www.paypal.com/us/cgi-bin/webscr";
            }
            sAdd = "<input name=\"business\" type=\"hidden\" value=\"" + sf[0].BusinessAccount.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input name=\"cancel_return\"  type=\"hidden\" value=\"" + sf[0].CancelUrl.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));

            sAdd = "<input name=\"return\" type=\"hidden\" value=\"" + sf[0].ReturnUrl.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input name=\"notify_url\"  type=\"hidden\" value=\"" + sf[0].VerificationUrl.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input type=\"hidden\" name=\"cmd\" value=\"_cart\" />";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input type=\"hidden\" name=\"upload\" value=\"1\" />";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input type=\"hidden\" name=\"rm\" value=\"1\" />";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            //43#1#1#usern#44#session
            string ids = Session["OrderID"].ToString() + "#" + storeID + "#" + portalID + "#" + userName + "#" + customerID + "#" + sessionCode + "#" + Session["IsTestPayPal"].ToString();
            sAdd = "<input type=\"hidden\" name=\"custom\" value=\"" + ids + "\" />";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
         
            //string itemReduce = string.Empty;
            //string coupon = string.Empty;
            //foreach (OrderItemInfo objItems in orderdata2.lstOrderItemsInfo)
            //{
            //    itemReduce += objItems.ItemID + "," + objItems.Quantity + "," + objItems.IsDownloadable + "#";
            //}
            //sAdd = "<input type=\"hidden\" name=\"custom_1\" value=\"" + itemReduce + "\" />";
            //plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));

            //if (orderdata2.objOrderDetails.CouponCode != null && Session["CouponApplied"] != null)
            //{
            //    coupon = orderdata2.objOrderDetails.CouponCode + "#" + Session["CouponApplied"].ToString();
            //}
            //sAdd = "<input type=\"hidden\" name=\"custom_2\" value=\"" + coupon + "\" />";
            //plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));



        }
        catch (Exception ex)
        {
            lblnotity.Text = "Something goes wrong, hit refresh or go back to checkout";
            clickhere.Visible = false;
            ProcessException(ex);
        }

    }

    public void GetCartDetails()
    {
        //Response.Write(GetCustomerID.ToString() + "st" + GetStoreID.ToString());
        PayPalWCFService pw = new PayPalWCFService();
        List<CartInfoforPaypal> cd;
        try
        {
        cd = pw.GetCartDetails(storeID, portalID,customerID, userName, GetCurrentCultureName, sessionCode);
        int nCount = 1;
        string sAdd;

        foreach (CartInfoforPaypal oItem in cd)
        {


            sAdd = "<input name=\"item_name_" + nCount.ToString() + "\" type=\"hidden\" value=\"" + oItem.ItemName.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));        
            sAdd = "<input name=\"amount_" + nCount.ToString() + "\" type=\"hidden\" value=\"" + oItem.Price.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            sAdd = "<input name=\"quantity_" + nCount.ToString() + "\" type=\"hidden\" value=\"" + oItem.Quantity.ToString() + "\"> ";
            plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
            nCount++;
        }
        nCount--;
        sAdd = "<input name=\"num_cart_items\" type=\"hidden\" value=\"" + nCount.ToString() + "\"> ";
        plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));     
        sAdd = "<input type=\"hidden\" name=\"discount_amount_cart\" value=\"" + Session["DiscountAll"].ToString() + "\" />";
        plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
        sAdd = "<input type=\"hidden\" name=\"tax_cart\" value=\"" + Session["TaxAll"].ToString() + "\" />";  
        plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
        sAdd = "<input type=\"hidden\" name=\"no_shipping\" value=\"1\" />";
        plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));
        sAdd = " <input type=\"hidden\" name=\"shipping_1\" value=\"" + Session["ShippingCostAll"].ToString() + "\" />";
        plHej.Controls.Add(new System.Web.UI.LiteralControl(sAdd));        
       
        }
        catch (Exception ex)
        {
            lblnotity.Text = "Something goes wrong, hit refresh or go back to checkout";
            clickhere.Visible = false;
            ProcessException(ex);
        }
      
     //  HttpContext.Current.Session.Remove("")

    }
}
