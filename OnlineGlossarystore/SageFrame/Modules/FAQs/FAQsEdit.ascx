<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FAQsEdit.ascx.cs" Inherits="SageFrame.Modules.Admin.FAQs.FAQsEdit" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<script language="javascript" type="text/javascript">

    function ValidateContentText(source, args) {
        var BEditor = source.id.replace( /cvQuestion$/ , "FCKeditorQuestionField");
        var fckBody = FCKeditorAPI.GetInstance(BEditor);
        args.IsValid = fckBody.GetXHTML(true) != "";
    }

</script>

<asp:HiddenField ID="hdnUserModuleID" runat="server" Value="0" />
<cc1:TabContainer ID="TabContainerFAQsEdit" runat="server" ActiveTabIndex="0" 
                  meta:resourcekey="TabContainerFAQsEditResource1">
    <cc1:TabPanel ID="TabPanelManageFAQs" runat="server" 
                  meta:resourcekey="TabPanelManageFAQsResource1">
        <HeaderTemplate>
            Manage FAQs
        </HeaderTemplate>
        <ContentTemplate>
            <asp:Label ID="lblManageFAQsHelp" runat="server" CssClass="cssClassHelpTitle" 
                       Text="In this section, you can manage the FAQs for the portal." 
                       meta:resourcekey="lblManageFAQsHelpResource1"></asp:Label>
            <div class="cssClassFormWraper">
                <asp:Panel ID="pnlAddFAQs" runat="server" Width="100%" 
                           meta:resourcekey="pnlAddFAQsResource1">
                    <div class="cssClassFormWrapper">
                        <table width="100%">
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblCategoryField" runat="server" Text="Category:" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblCategoryFieldResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlCategory" runat="server" Width="200px" 
                                                      CssClass="cssClassDropDown" meta:resourcekey="ddlCategoryResource1">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblQuestionField" runat="server" Text="Question:" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblQuestionFieldResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:CustomValidator runat="server" ID="cvQuestion" SetFocusOnError="True" Display="Dynamic"
                                                         OnServerValidate="FCKeditorQuestionField_ServerValidate" ControlToValidate="FCKeditorQuestionField"
                                                         ErrorMessage="*" CssClass="cssClasssNormalRed" ClientValidationFunction="ValidateContentText"
                                                         ValidationGroup="Announcement" meta:resourcekey="cvQuestionResource1"></asp:CustomValidator>
                                    <FCKeditorV2:FCKeditor ID="FCKeditorQuestionField" runat="server" Height="350px"
                                                           Width="100%" ToolbarSet="SageFrameLimited">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblAnswerField" runat="server" Text="Answer:" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblAnswerFieldResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:CustomValidator runat="server" ID="cvAnswer" SetFocusOnError="True" Display="Dynamic"
                                                         OnServerValidate="FCKeditorAnswerField_ServerValidate" ControlToValidate="FCKeditorAnswerField"
                                                         ErrorMessage="*" CssClass="cssClasssNormalRed" ClientValidationFunction="ValidateContentText"
                                                         ValidationGroup="Announcement" meta:resourcekey="cvAnswerResource1"></asp:CustomValidator>
                                    <FCKeditorV2:FCKeditor ID="FCKeditorAnswerField" runat="server" Height="350px" Width="100%"
                                                           ToolbarSet="SageFrameLimited">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblIsActive" runat="server" Text="Is Active?" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblIsActiveResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkIsActive" runat="server" CssClass="cssClassCheckBox" 
                                                  meta:resourcekey="chkIsActiveResource1" />
                                </td>
                            </tr>
                        </table>
                        <div class="cssClassButtonWrapper">
                            <asp:ImageButton ID="imbSave" runat="server" OnClick="imbSave_Click" 
                                             ValidationGroup="Announcement" meta:resourcekey="imbSaveResource1" />
                            <asp:Label ID="lblSave" runat="server" Text="Save" AssociatedControlID="imbSave"
                                       Style="cursor: pointer;" meta:resourcekey="lblSaveResource1"></asp:Label>
                            <asp:ImageButton ID="imbReturn" runat="server" OnClick="imbReturn_Click" 
                                             CausesValidation="False" meta:resourcekey="imbReturnResource1" />
                            <asp:Label ID="lblReturn" runat="server" Text="Cancel" AssociatedControlID="imbReturn"
                                       Style="cursor: pointer;" meta:resourcekey="lblReturnResource1"></asp:Label>
                            <asp:ImageButton ID="imbDelete" runat="server" OnClick="imbDelete_Click" Visible="False"
                                             CausesValidation="False" meta:resourcekey="imbDeleteResource1" />
                            <asp:Label ID="lblDelete" runat="server" Text="Delete" AssociatedControlID="imbDelete"
                                       Style="cursor: pointer;" Visible="False" 
                                       meta:resourcekey="lblDeleteResource1"></asp:Label>
                        </div>
                        <div id="auditBar" runat="server" class="cssClassAuditBar" visible="False">
                            <asp:Label ID="lblCreatedBy" runat="server" CssClass="cssClassFormLabel" 
                                       Visible="False" meta:resourcekey="lblCreatedByResource1" /><br />
                            <asp:Label ID="lblUpdatedBy" runat="server" CssClass="cssClassFormLabel" 
                                       Visible="False" meta:resourcekey="lblUpdatedByResource1" />
                        </div>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlFAQsInGrid" runat="server" Width="100%" 
                           meta:resourcekey="pnlFAQsInGridResource1">
                    <div class="cssClassButtonWrapper">
                        <asp:ImageButton ID="imbAddFAQs" runat="server" CausesValidation="False" 
                                         OnClick="imbAddFAQs_Click" meta:resourcekey="imbAddFAQsResource1" />
                        <asp:Label ID="lblAddFAQs" runat="server" Text="Add FAQs" AssociatedControlID="imbAddFAQs"
                                   Style="cursor: pointer;" meta:resourcekey="lblAddFAQsResource1"></asp:Label>
                    </div>
                    <div class="cssClassGridWrapper">
                        <asp:GridView Width="100%" runat="server" ID="gdvManageFAQs" AutoGenerateColumns="False"
                                      AllowPaging="True" EmptyDataText="---FAQs Not Available---" OnPageIndexChanged="gdvManageFAQs_PageIndexChanged"
                                      OnRowCommand="gdvManageFAQs_RowCommand" OnRowDeleting="gdvManageFAQs_RowDeleting"
                                      OnRowEditing="gdvManageFAQs_RowEditing" OnRowUpdating="gdvManageFAQs_RowUpdating"
                                      OnSelectedIndexChanged="gdvManageFAQs_SelectedIndexChanged" OnPageIndexChanging="gdvManageFAQs_PageIndexChanging"
                                      OnRowDataBound="gdvManageFAQs_RowDataBound" 
                                      meta:resourcekey="gdvManageFAQsResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="FAQs Category" 
                                                   meta:resourcekey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFAQsCategory" runat="server" 
                                                   Text='<%# Eval("CATEGORYNAME") %>' meta:resourcekey="lblFAQsCategoryResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FAQs Category Description" 
                                                   meta:resourcekey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFAQsCategoryDesc" runat="server" 
                                                   Text='<%# Server.HtmlDecode(Eval("CATEGORYDESC").ToString()) %>' 
                                                   meta:resourcekey="lblFAQsCategoryDescResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Question" 
                                                   meta:resourcekey="TemplateFieldResource3">
                                    <ItemTemplate>
                                        <asp:Label ID="lblQuestion" runat="server" 
                                                   Text='<%# Server.HtmlDecode(Eval("Org_Question").ToString()) %>' 
                                                   meta:resourcekey="lblQuestionResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View Count" 
                                                   meta:resourcekey="TemplateFieldResource4">
                                    <ItemTemplate>
                                        <asp:Label ID="lblViewCount" runat="server" Text='<%# Eval("VIEWCOUNT") %>' 
                                                   meta:resourcekey="lblViewCountResource1" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="View Answer" 
                                                   meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imbViewAnswer" runat="server" CausesValidation="False" ToolTip="View Answer"
                                                         ImageUrl='<%# GetTemplateImageUrl("imgview.png", true) %>' 
                                                         meta:resourcekey="imbViewAnswerResource1" />
                                        <cc1:ModalPopupExtender BackgroundCssClass="ModalPopupBG" ID="mpeFaqAns" CancelControlID="btnCancelView"
                                                                TargetControlID="imbViewAnswer" PopupControlID="pnlFAQViewAns" runat="server"
                                                                PopupDragHandleControlID="divDrag" 
                                                                RepositionMode="RepositionOnWindowScroll" DynamicServicePath="" Enabled="True">
                                        </cc1:ModalPopupExtender>
                                        <asp:Panel ID="pnlFAQViewAns" CssClass="Popup" runat="server" 
                                                   Style="display: none" meta:resourcekey="pnlFAQViewAnsResource1">
                                            <div class="cssClassOnClickPopUp">
                                                <div class="cssClassOnClickPopUpClose">
                                                    <input type="button" runat="server" id="btnCancelView" value="Cancel" /> </div>
                                                <div class="cssClassOnClickPopUpInside">
                                                    <div class="cssClassOnClickPopUpTitle" runat="server" id="divDrag">
                                                        <%# Server.HtmlDecode(Eval("Org_Question").ToString()) %>
                                                    </div>
                                                    <div class="cssClassOnClickPopUpInfo">
                                                        <asp:Label ID="lblAnswer" runat="server" 
                                                                   Text='<%# Server.HtmlDecode(Eval("Org_Answer").ToString()) %>' 
                                                                   meta:resourcekey="lblAnswerResource1" />
                                                    </div>
                                                </div>
                                            </div>
                                        </asp:Panel>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource6">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imbEdit" runat="server" CausesValidation="False" CommandArgument='<%# Eval("FAQID") %>'
                                                         CommandName="Edit" ToolTip="Edit FAQs" 
                                                         ImageUrl='<%# GetTemplateImageUrl("imgedit.png", true) %>' 
                                                         meta:resourcekey="imbEditResource1" />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="cssClassColumnEdit" />
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource7">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("FAQID") %>'
                                                         CommandName="Delete" ToolTip="Delete FAQs" 
                                                         ImageUrl='<%# GetTemplateImageUrl("imgdelete.png", true) %>' 
                                                         meta:resourcekey="imbDeleteResource2" />
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="cssClassColumnDelete" />
                                </asp:TemplateField>
                            </Columns>
                            <HeaderStyle CssClass="cssClassHeadingOne" />
                            <RowStyle CssClass="cssClassAlternativeOdd" />
                            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                        </asp:GridView>
                    </div>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </cc1:TabPanel>
    <cc1:TabPanel ID="TabPanelManageFAQsCategory" runat="server" 
                  meta:resourcekey="TabPanelManageFAQsCategoryResource1">
        <HeaderTemplate>
            Manage FAQs Category
        </HeaderTemplate>
        <ContentTemplate>
            <asp:Label ID="lblManageFAQsCategory" runat="server" CssClass="cssClassHelpTitle"
                       Text="In this section, you can manage the FAQs Category for the portal." 
                       meta:resourcekey="lblManageFAQsCategoryResource1"></asp:Label>
            <div class="cssClassFromWraper">
                <asp:Panel ID="pnlManageFAQsCategory" runat="server" 
                           meta:resourcekey="pnlManageFAQsCategoryResource1">
                    <div class="cssClassButtonWrapper">
                        <asp:ImageButton ID="imbAddFAQsCategory" runat="server" CausesValidation="False"
                                         OnClick="imbAddFAQsCategory_Click" 
                                         meta:resourcekey="imbAddFAQsCategoryResource1" />
                        <asp:Label ID="lblAddFAQsCategory" runat="server" Text="Add FAQs Category" AssociatedControlID="imbAddFAQsCategory"
                                   Style="cursor: pointer;" meta:resourcekey="lblAddFAQsCategoryResource1"></asp:Label>
                    </div>
                    <div class="cssClassGridWrapper">
                        <asp:GridView Width="100%" runat="server" ID="gdvCategory" AutoGenerateColumns="False"
                                      AllowPaging="True" EmptyDataText="---FAQs Category Not Available---" OnPageIndexChanged="gdvCategory_PageIndexChanged"
                                      OnPageIndexChanging="gdvCategory_PageIndexChanging" OnRowCommand="gdvCategory_RowCommand"
                                      OnRowDataBound="gdvCategory_RowDataBound" OnRowDeleting="gdvCategory_RowDeleting"
                                      OnRowEditing="gdvCategory_RowEditing" OnRowUpdating="gdvCategory_RowUpdating"
                                      OnSelectedIndexChanged="gdvCategory_SelectedIndexChanged" 
                                      OnSelectedIndexChanging="gdvCategory_SelectedIndexChanging" 
                                      meta:resourcekey="gdvCategoryResource1">
                            <Columns>
                                <asp:TemplateField HeaderText="FAQs Category" 
                                                   meta:resourcekey="TemplateFieldResource8">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFAQsCategory" runat="server" 
                                                   Text='<%# Eval("FAQCategoryName") %>' 
                                                   meta:resourcekey="lblFAQsCategoryResource2"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FAQs Category Description" 
                                                   meta:resourcekey="TemplateFieldResource9">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFAQCategoryDescription" runat="server" 
                                                   CssClass="cssClassFormLabel" 
                                                   meta:resourcekey="lblFAQCategoryDescriptionResource1"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource10">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imbEditCategory" runat="server" CommandArgument='<%# Eval("FAQCategoryID") %>'
                                                         CommandName="Edit" ToolTip="Edit FAQs Category" ImageUrl='<%# GetTemplateImageUrl("imgedit.png", true) %>'
                                                         CausesValidation="False" meta:resourcekey="imbEditCategoryResource1"></asp:ImageButton>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="cssClassColumnEdit" />
                                </asp:TemplateField>
                                <asp:TemplateField meta:resourcekey="TemplateFieldResource11">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imbDeleteCategory" CommandArgument='<%# Eval("FAQCategoryID") %>'
                                                         CommandName="Delete" ToolTip="Delete FAQs Category" runat="server" ImageUrl='<%# GetTemplateImageUrl("imgdelete.png", true) %>'
                                                         CausesValidation="False" meta:resourcekey="imbDeleteCategoryResource1"></asp:ImageButton>
                                    </ItemTemplate>
                                    <HeaderStyle CssClass="cssClassColumnDelete" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="cssClassPageNumber" />
                            <HeaderStyle CssClass="cssClassHeadingOne" />
                            <RowStyle CssClass="cssClassAlternativeOdd" />
                            <AlternatingRowStyle CssClass="cssClassAlternativeEven" />
                        </asp:GridView>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlAddFAQsCategory" runat="server" 
                           meta:resourcekey="pnlAddFAQsCategoryResource1">
                    <div class="cssClassFormWrapper">
                        <table cellspacing="3" cellpadding="3" border="0">
                            <tr id="rowFAQCategoryID" runat="server">
                                <td valign="top" runat="server">
                                    <asp:Label ID="lblCategoryID" runat="server" Text="CategoryID" CssClass="cssClassFormLabel"></asp:Label>
                                </td>
                                <td runat="server">
                                    <asp:Label ID="lblID" runat="server" CssClass="cssClassFormLabel"></asp:Label>
                                    <asp:HiddenField ID="hdfCategoryID" runat="server" Value="0" />
                                </td>
                                <td runat="server">
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblCategoryName" runat="server" Text="Category Name:" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblCategoryNameResource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtCategoryName" runat="server" Width="304px" CssClass="cssClassNormalTextBox"
                                                 MaxLength="100" meta:resourcekey="txtCategoryNameResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:RequiredFieldValidator ID="rfvCategoryName" runat="server" ControlToValidate="txtCategoryName"
                                                                CssClass="cssClasssNormalRed" ErrorMessage="<b>Name is required</b>" 
                                                                meta:resourcekey="rfvCategoryNameResource1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" height="53">
                                    <asp:Label ID="lblCategoryDescription" runat="server" 
                                               Text="Category Description:" meta:resourcekey="lblCategoryDescriptionResource1"></asp:Label>
                                </td>
                                <td height="53">
                                    <asp:TextBox ID="txtCategoryDescription" runat="server" Width="304px" CssClass="cssClassNormalTextBox"
                                                 TextMode="MultiLine" Height="93px" MaxLength="250" 
                                                 meta:resourcekey="txtCategoryDescriptionResource1"></asp:TextBox>
                                </td>
                                <td valign="top" height="53">
                                    <asp:RequiredFieldValidator ID="rfvCategoryDescription" runat="server" CssClass="cssClassNormalRed"
                                                                ErrorMessage="<b> Description is Required </b>" 
                                                                ControlToValidate="txtCategoryDescription" 
                                                                meta:resourcekey="rfvCategoryDescriptionResource1"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label ID="lblPublish" runat="server" Text="Publish" 
                                               CssClass="cssClassFormLabel" meta:resourcekey="lblPublishResource1"/>
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkPublish" runat="server" CssClass="cssClassCheckBox" 
                                                  Checked="True" meta:resourcekey="chkPublishResource1" />
                                </td>
                                <td valign="top">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <asp:ImageButton ID="imbUpdate" runat="server" OnClick="imbUpdate_Click" 
                                                     meta:resourcekey="imbUpdateResource1" />
                                    <asp:Label ID="lblUpdate" runat="server" Text="Save" AssociatedControlID="imbUpdate"
                                               Style="cursor: pointer;" meta:resourcekey="lblUpdateResource1"></asp:Label>
                                    <asp:ImageButton ID="imbCancel" runat="server" CausesValidation="False" 
                                                     OnClick="imbCancel_Click" meta:resourcekey="imbCancelResource1" />
                                    <asp:Label ID="lblCancel" runat="server" Text="Cancel" AssociatedControlID="imbCancel"
                                               Style="cursor: pointer;" meta:resourcekey="lblCancelResource1"></asp:Label>
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
            </div>
        </ContentTemplate>
    </cc1:TabPanel>
</cc1:TabContainer>