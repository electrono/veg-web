<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ViewContactTable.ascx.cs"
            Inherits="SageFrame.Modules.FeedBack.ViewContactTable" %>
<div class="cssClassGridWrapper">
    <asp:GridView ID="gdvContactUs" runat="server" AutoGenerateColumns="False" Width="100%"
                  AllowPaging="True" OnRowDataBound="gdvContactUs_RowDataBound" OnRowDeleting="gdvContactUs_RowDeleting"
                  OnRowCommand="gdvContactUs_RowCommand" PageSize="15" 
                  OnPageIndexChanging="gdvContactUs_PageIndexChanging" 
                  meta:resourcekey="gdvContactUsResource1">
        <Columns>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                <ItemTemplate>
                    <asp:HiddenField ID="hdnFID" runat="server" Value='<%# Eval("FeedbackID") %>' />
                    <asp:Panel ID="pnlCon" runat="server" meta:resourcekey="pnlConResource1">
                    </asp:Panel>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("FeedbackID") %>'
                                     CommandName="Delete" ImageUrl='<%# GetTemplateImageUrl("imgdelete.png", true) %>'
                                     ToolTip="Delete" CssClass="cssClassColumnDelete" 
                                     meta:resourcekey="imgDeleteResource1" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerStyle CssClass="cssClassPageNumber" />
        <HeaderStyle CssClass="cssClassHeadingOne" />
        <RowStyle CssClass="cssClassAlternativeOdd" />
        <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
    </asp:GridView>
</div>