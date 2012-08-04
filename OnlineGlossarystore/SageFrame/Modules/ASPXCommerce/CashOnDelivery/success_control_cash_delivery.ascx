<%@ Control Language="C#" AutoEventWireup="true" CodeFile="success_control_cash_delivery.ascx.cs" Inherits="Modules_ASPXCommerce_PaymentGateways_CashOnDelivery_success_control" %>

<div>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
        <ProgressTemplate>
            <div class="cssClassLoadingBG">
                &nbsp;</div>
            <div class="cssClassloadingDiv">
                <asp:Image ID="imgPrgress" runat="server" AlternateText="Loading..." ToolTip="Loading..." />
                <br />
                <asp:Label ID="lblPrgress" runat="server" Text="Please wait..."></asp:Label>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    
    <div id="divPageOuter" class="PageOuter">
        <div id="error" runat="server">
            <asp:Label ID="lblerror" runat="server" Text=""></asp:Label>
        </div>
        <div id="divClickAway">
            <asp:HyperLink ID="hlnkHomePage" runat="server">Back to Home page</asp:HyperLink>  
        </div>
    <!--[1]-->
        <div id="divPage" class="Page" runat="server">
            
            <div id="divThankYou">
                Thank you for your order!</div>
            <hr class="HrTop"/>
            <div id="divReceiptMsg">
                You may print this receipt page for your records.
            </div>
            <div class="SectionBar">
                Order Information</div>   
            <table id="tablePaymentDetails2Rcpt" cellspacing="0" cellpadding="0">
                <tr>
                    <td id="tdPaymentDetails2Rcpt1">
                        <table>
                            <tr>
                                <td class="LabelColInfo1R">
                                    Date/Time:
                                </td>
                                <td class="DataColInfo1R"> <asp:Label ID="lblDateTime" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>                    
                        </table>
                    </td>
                    <td id="tdPaymentDetails2Rcpt2">
                        <table>
                            <tr>
                                <td class="LabelColInfo1R">
                                    Invoice Number:
                                </td>
                                <td class="DataColInfo1R"> <asp:Label ID="lblInvoice" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <hr id="hrBillingShippingBefore">
            <div id="divOrderDetailsBottomR">
                <table id="tableOrderDetailsBottom">
                    <tr>
                        <td class="LabelColTotal">
                        
                        </td>
                        <td class="DescrColTotal"> <asp:Label ID="lblTotal" runat="server" Text=""></asp:Label>
                        </td>
                        <td class="DataColTotal">
                        </td>
                    </tr>
                </table>
                <!-- tableOrderDetailsBottom -->
            </div>
            <div id="divOrderDetailsBottomSpacerR">
            </div>
            <div class="SectionBar">
            </div>
            <table class="PaymentSectionTable" cellspacing="0" cellpadding="0">
                <tr>
                    <td class="PaymentSection1">
                        <table>
                           
                            <tr>
                                <td class="LabelColInfo2R">
                                    Transaction ID:
                                </td>
                                <td class="DataColInfo2R"> <asp:Label ID="lblTransaction" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                               
                                <td class="DataColInfo2R"> <asp:Label ID="lblAuthorizationCode" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="LabelColInfo2R">
                                    Payment Method:
                                </td>
                                <td class="DataColInfo2R"> <asp:Label ID="lblPaymentMethod" runat="server" Text=""></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td class="PaymentSection2">
                        <table>
                        </table>
                    </td>
                </tr>
            </table>
            <div class="PaymentSectionSpacer">
            </div>
        </div>
        <!-- entire BODY -->
    </div>
</div>