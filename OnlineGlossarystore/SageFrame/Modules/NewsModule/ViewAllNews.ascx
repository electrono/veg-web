<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewAllNews.ascx.cs" Inherits="SageFrame.Modules.NewsModule.ViewAllNews" %>
<asp:HiddenField ID="hdnUserModuleID" runat="server" Value="0" />
<asp:Panel ID="pnlDetailNews" runat="server" 
           meta:resourcekey="pnlDetailNewsResource1">
    <div class="cssClassFormWrapper">
        <div class="cssClassNewsDetail">
            <div class="cssClassnews">
                <div class="cssClassNewsHeading">
                    <asp:Label ID="lblNewsTitle" runat="server" 
                               meta:resourcekey="lblNewsTitleResource1"></asp:Label>
                </div>
                <div class="cssClassNewsInfo cssClassNewsDetailPageContent">
                    <div class="cssClassDateFormat">
                        <asp:Label ID="lblNewsDate1" runat="server" 
                                   meta:resourcekey="lblNewsDate1Resource1"></asp:Label>
                    </div>
                    <div class="cssClassNewsLongDesc">
                        <asp:Literal ID="ltrNewsLong" runat="server" 
                                     meta:resourcekey="ltrNewsLongResource1"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
        
    </div>
    
    <div class="cssClassButtonWrapper cssClassbutton">
        <asp:ImageButton ID="imgCancel" runat="server" OnClick="imbBack_Click" 
                         meta:resourcekey="imgCancelResource1" />
        <asp:Label ID="lblCancel" runat="server" Text="Back" AssociatedControlID="imgCancel"
                   Style="cursor: pointer;" meta:resourcekey="lblCancelResource1"></asp:Label>
    </div>
</asp:Panel>
<asp:Panel ID="pnlMoreNews" runat="server" 
           meta:resourcekey="pnlMoreNewsResource1">
    <div class="cssClassFormWrapper">
        <asp:Label ID="lblNewsCatList" runat="server" Text="News Category:" 
                   CssClass="cssClassFormLabel" meta:resourcekey="lblNewsCatListResource1"></asp:Label>
        <asp:DropDownList ID="ddlNewsCatList" runat="server" Width="200px" CssClass="cssClassDropDown"
                          AutoPostBack="True" 
                          OnSelectedIndexChanged="ddlNewsCatList_SelectedIndexChanged" 
                          meta:resourcekey="ddlNewsCatListResource1">
        </asp:DropDownList>
    </div>
    <div class="cssClassGridWrapper">
        <div class="cssClassNewsWrapper">
            <asp:GridView ID="gdvAllNews" ShowHeader="False" GridLines="None" AutoGenerateColumns="False"
                          AllowPaging="True" runat="server" Width="100%" OnRowCommand="gdvAllNews_RowCommand"
                          EmptyDataText=".........No News filed under this category........." OnRowDeleting="gdvAllNews_RowDeleting"
                          OnRowEditing="gdvAllNews_RowEditing" 
                          OnRowUpdating="gdvAllNews_RowUpdating" OnSelectedIndexChanging="gdvAllNews_SelectedIndexChanging"
                          OnRowDataBound="gdvAllNews_RowDataBound" OnPageIndexChanging="gdvAllNews_PageIndexChanging"
                          PageSize="5" meta:resourcekey="gdvAllNewsResource1">
                <Columns>
                    <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                        <ItemTemplate>
                            <div class="cssClassnews">
                                <div class="cssClassNewsHeading">
                                    <asp:HiddenField ID="hdfNewsID" runat="server" 
                                                     Value='<%# DataBinder.Eval(Container.DataItem, "NewsID") %>' />
                                    <asp:HyperLink ID="hlnknewsInDetails" runat="server" 
                                                   Text='<%# DataBinder.Eval(Container.DataItem, "NewsTitle") %>' 
                                                   meta:resourcekey="hlnknewsInDetailsResource1"></asp:HyperLink>
                                </div>
                                <div class="cssClassNewsInfo">
                                    <div class="cssClassDateFormat">
                                        <asp:Label ID="lblNewsDate" runat="server" 
                                                   Text='<%# DataBinder.Eval(Container.DataItem, "NewsDate") %>' 
                                                   meta:resourcekey="lblNewsDateResource1"></asp:Label>
                                    </div>
                                    <p>
                                        <asp:Label runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "NewsShortDescription") %>'
                                                   ID="lblShortNews" meta:resourcekey="lblShortNewsResource1" />
                                    </p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                <HeaderStyle CssClass="cssClassHeadingOne" />
                <PagerStyle CssClass="cssClassPageNumber" />
                <RowStyle CssClass="cssClassAlternativeOdd" />
            </asp:GridView>
        </div>
    </div>
    <div class="cssClassButtonWrapper cssClassbutton">
        <asp:ImageButton ID="imbBack" runat="server" OnClick="imbBack_Click" 
                         meta:resourcekey="imbBackResource1" />
        <asp:Label ID="lblBack" runat="server" Text="Back" AssociatedControlID="imbBack"
                   Style="cursor: pointer;" meta:resourcekey="lblBackResource1"></asp:Label>
    </div>
</asp:Panel>