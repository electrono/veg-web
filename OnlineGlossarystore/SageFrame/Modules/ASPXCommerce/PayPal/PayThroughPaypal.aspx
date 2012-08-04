<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PayThroughPaypal.aspx.cs"
         Inherits="Modules_ASPXCommerce_PayPalGateWay_PayThroughPaypal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server">
        <title>Processing your Order....</title>

        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.pack.js"> </script>
    
        <script type="text/javascript">
            $(function() {
                $(this).bind("contextmenu", function(e) {
                    e.preventDefault();
                });
                $("#clickhere").click(function() {
                    document.PaypalForm.submit();

                });
            });

        </script>

        <style type="text/css">

            body {
                font-family: verdana;
                font-size: 15px;
            }
        </style>

    </head>
    <body >
        <div>
            <asp:Label ID="lblnotity" runat="server" Text="if you are not redirecting to Paypal click "></asp:Label> <asp:HyperLink ID="clickhere" runat="server" NavigateUrl="#" >here..</asp:HyperLink>
  
        </div>
        <form name="PaypalForm" id="PaypalForm" runat="server" method="post" action="https://www.paypal.com/cgi-bin/webscr">
    
            <asp:PlaceHolder ID="plHej" runat="server"></asp:PlaceHolder>
        </form>
    </body>
</html>