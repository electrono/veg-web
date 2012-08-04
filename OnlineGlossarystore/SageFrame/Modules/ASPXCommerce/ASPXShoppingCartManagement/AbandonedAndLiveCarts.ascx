<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AbandonedAndLiveCarts.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXShoppingCartManagement_AbandonedAndLiveCarts" %>

<%@ Register src="LiveCart.ascx" tagname="LiveCart" tagprefix="uc1" %>
<%@ Register src="AbandonedCart.ascx" tagname="AbandonedCart" tagprefix="uc2" %>

<uc1:LiveCart ID="LiveCart1" runat="server" />
<uc2:AbandonedCart ID="AbandonedCart1" runat="server" />