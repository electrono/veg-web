<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FAQs.ascx.cs" Inherits="SageFrame.Modules.Admin.FAQs.FAQs" %>

<script type="text/javascript">
    $(document).ready(function() {
        var accrcontents = $(".accrContent").find('.cssClassFAQsContent');
        $.each(accrcontents, function(i, item) {
            if (i == 0) {
                $(item).attr("style", "display: block;");
                //        if ($(item).html() == errorAccr) {
                //            $("#accordion").accordion("option", "active", i);
                //        }
            }
        });
    })
</script>

<div class="cssClassFaqPage">
    <asp:DataList ID="dtlFAQs" runat="server" CellPadding="0" DataKeyField="FAQID" OnItemCommand="dtlFAQs_ItemCommand"
                  OnItemDataBound="dtlFAQs_ItemDataBound" Width="100%" 
                  meta:resourcekey="dtlFAQsResource1">
        <HeaderTemplate>
            <asp:Label ID="lblNoFAQs" runat="server" Text="..........FAQs Not Found.........."
                       Visible="False" meta:resourcekey="lblNoFAQsResource1"></asp:Label>
        </HeaderTemplate>
        <ItemTemplate>
            <asp:HiddenField ID="hdnFAQID" runat="server" 
                             Value='<%# DataBinder.Eval(Container.DataItem, "FAQID") %>' />
            <table width="100%" border="0" cellpadding="0" cellspacing="0" class="cssClassTopTitleHeading">
                <tr>
                    <td width="89%">
                        <div class="cssClassHeadText">
                            <asp:Panel ID="pnlFAQuestion" runat="server" 
                                       meta:resourcekey="pnlFAQuestionResource1">
                                <div class="cssClassFaqQuestionInfo">
                                    <asp:Literal ID="ltrQuestion" runat="server" 
                                                 Text='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "QUESTION").ToString()) %>'></asp:Literal>
                                </div>
                            </asp:Panel>
                        </div>
                    </td>
                    <td width="8%" class="cssClassColumnCollapse">
                        <asp:ImageButton ID="imgExpandOrCollapse" runat="server" CausesValidation="False"
                                         ImageUrl='<%# GetTemplateImageUrl("imgExpand.png", true) %>' 
                                         AlternateText="Collapse/Expand" meta:resourcekey="imgExpandOrCollapseResource1"></asp:ImageButton>
                    </td>
                </tr>
            </table>
            <div class="accrContent">
                <div id='_<%# DataBinder.Eval(Container.DataItem, "FAQID") %>' style="display: none;"
                     class="cssClassFAQsContent">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <div class="cssClassFaqCurve">
                                    <div class="cssClassFaqCurve_Curve">
                                    </div>
                                    <div class="cssClasst">
                                        <div class="cssClassb">
                                            <div class="cssClassl">
                                                <div class="cssClassr">
                                                    <div class="cssClassbl">
                                                        <div class="cssClassbr">
                                                            <div class="cssClasstl">
                                                                <div class="cssClasstr">
                                                                    <asp:Literal ID="ltrAnswer" runat="server" 
                                                                                 Text='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "ANSWER").ToString()) %>'></asp:Literal>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </ItemTemplate>
    </asp:DataList>
</div>