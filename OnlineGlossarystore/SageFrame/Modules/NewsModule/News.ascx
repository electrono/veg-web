<%@ Control Language="C#" AutoEventWireup="true" CodeFile="News.ascx.cs" Inherits="SageFrame.Modules.NewsModule.News" %>
<%--<div class="cssClassrightPane">
    <div class="cssClassmaincontent">--%>

<div class="cssClassSFModCommonBox cssClassRadius5">
    <div class="cssClassNewsWrapper"> <h1>
                                          <%--Latest News--%>
                                          <asp:Label ID="lblNewsModuleTitle" runat="server" 
                                                     meta:resourcekey="lblNewsModuleTitleResource1"></asp:Label>
                                      </h1>
        <asp:Literal ID="lblNews" runat="server" meta:resourcekey="lblNewsResource1" /></div>
</div>