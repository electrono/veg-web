<%@ Control Language="C#" AutoEventWireup="true" CodeFile="FeedBack.ascx.cs" Inherits="SageFrame.Modules.FeedBack.FeedBack" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<ajax:TabContainer ID="TabContainerFeedBackSettings" runat="server" 
                   ActiveTabIndex="0" meta:resourcekey="TabContainerFeedBackSettingsResource1">
    <ajax:TabPanel ID="TabPanelContactUsSetting" runat="server" 
                   meta:resourcekey="TabPanelContactUsSettingResource1">
        <HeaderTemplate>
            ContactUs Setting
        </HeaderTemplate>
        <ContentTemplate>
            <asp:Label ID="lblContactUsSettingsHelp" runat="server" CssClass="cssClassHelpTitle"
                
                       Text="In this section, you can set up the ContactUs Settings for the FeedBack Module" 
                       meta:resourcekey="lblContactUsSettingsHelpResource1"></asp:Label>
            <div class="cssClassFormWrapper">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td width="25%">
                            <asp:Label ID="Label3" runat="server" Text="Title" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label3Resource1"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label4" runat="server" Text="Field Title" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label4Resource1"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label5" runat="server" Text="Display Order" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label5Resource1"></asp:Label>
                        </td>
                        <td width="25%">
                            <asp:Label ID="Label6" runat="server" Text="IsActive" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label6Resource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Form Title" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFormTitle" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Form Title" meta:resourcekey="txtFormTitleResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFormTitle1" runat="server" Text="1" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtFormTitle1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkFormTitle" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkFormTitleResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Form Information" 
                                       CssClass="cssClassFormLabelField" meta:resourcekey="Label2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFormInformation" runat="server" Text="Form Information" TextMode="MultiLine"
                                         Rows="2" CssClass="cssClassNormalTextBoxTextArea" 
                                         meta:resourcekey="txtFormInformationResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtFormInfo" runat="server" Text="2" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtFormInfoResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkFormInfo" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkFormInfoResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" CssClass="cssClassFormLabel" Text="Name" 
                                       meta:resourcekey="lblNameResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtName" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Name" meta:resourcekey="txtNameResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtName1" runat="server" Text="3" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtName1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkName" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkNameResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPermanentCountry" runat="server" Text="Permanent Country" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblPermanentCountryResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentCountry" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent Country" meta:resourcekey="txtPermanentCountryResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentCountry1" runat="server" Text="5" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentCountry1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPCountry" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPCountryResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblParmanentState" runat="server" Text="Permanent State" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblParmanentStateResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentState" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent State" meta:resourcekey="txtPermanentStateResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentState1" runat="server" Text="6" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentState1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPState" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPStateResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPermanentCity" runat="server" Text="Permanent City" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblPermanentCityResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentCity" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent City" meta:resourcekey="txtPermanentCityResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentCity1" runat="server" Text="7" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentCity1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPCity" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPCityResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblParmanentZipCode" runat="server" Text="Permanent ZipCode" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblParmanentZipCodeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentZipCode" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent ZipCode" meta:resourcekey="txtPermanentZipCodeResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentZipCode1" runat="server" Text="8" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentZipCode1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPZC" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPZCResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblParmanentPostalCode" runat="server" Text="Permanent PostalCode"
                                       CssClass="cssClassFormLabel" 
                                       meta:resourcekey="lblParmanentPostalCodeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentPostCode" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent PostalCode" 
                                         meta:resourcekey="txtPermanentPostCodeResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentPostalCode1" runat="server" Text="9" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentPostalCode1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPPC" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPPCResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblParmanentAddress" runat="server" Text="Permanent Address" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblParmanentAddressResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentAddress" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Permanent Address" meta:resourcekey="txtPermanentAddressResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPermanentAdd" runat="server" Text="10" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtPermanentAddResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPAdd" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPAddResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryCountry" runat="server" Text="Temporary Country" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblTemporaryCountryResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryCountry" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary Country" meta:resourcekey="txtTemporaryCountryResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryCountry1" runat="server" Text="12" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryCountry1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTCountry" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTCountryResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryState" runat="server" Text="Temporary State" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblTemporaryStateResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryState" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary State" meta:resourcekey="txtTemporaryStateResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryState1" runat="server" Text="13" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryState1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTState" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTStateResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryCity" runat="server" Text="Temporary City" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblTemporaryCityResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryCity" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary City" meta:resourcekey="txtTemporaryCityResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryCity1" runat="server" Text="14" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryCity1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTCity" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTCityResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryZipCode" runat="server" Text="Temporary ZipCode" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblTemporaryZipCodeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryZipCode" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary ZipCode" meta:resourcekey="txtTemporaryZipCodeResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryZipCode1" runat="server" Text="15" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryZipCode1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTZC" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTZCResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryPostalCode" runat="server" Text="Temporary PostalCode"
                                       CssClass="cssClassFormLabel" 
                                       meta:resourcekey="lblTemporaryPostalCodeResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryPostalCode" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary Postal Code" 
                                         meta:resourcekey="txtTemporaryPostalCodeResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryPostalCode1" runat="server" Text="16" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryPostalCode1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTPC" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTPCResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblTemporaryAddress" runat="server" Text="Temporary Address" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblTemporaryAddressResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryAddress" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Temporary Address" meta:resourcekey="txtTemporaryAddressResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtTemporaryAdd" runat="server" Text="17" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtTemporaryAddResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkTAdd" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkTAddResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail1" runat="server" Text="Email1" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblEmail1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail1" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Email1" meta:resourcekey="txtEmail1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail11" runat="server" Text="18" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtEmail11Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkEmail1" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkEmail1Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail2" runat="server" Text="Email2" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblEmail2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail2" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Email2" meta:resourcekey="txtEmail2Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmaill2" runat="server" Text="19" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtEmaill2Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkEmail2" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkEmail2Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPhone1" runat="server" Text="Phone1" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblPhone1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhone1" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Phone1" meta:resourcekey="txtPhone1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhonee1" runat="server" Text="20" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtPhonee1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPhone1" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPhone1Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPhone2" runat="server" Text="Phone2" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblPhone2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhone2" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Phone2" meta:resourcekey="txtPhone2Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhonee2" runat="server" Text="21" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtPhonee2Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkPhone2" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkPhone2Resource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMobile" runat="server" Text="Mobile" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblMobileResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="cssClassNormalTextBoxText" 
                                         Text="Mobile" meta:resourcekey="txtMobileResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMobile1" runat="server" Text="22" 
                                         CssClass="cssClassNormalTextBoxFeedBack" meta:resourcekey="txtMobile1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkMobile" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkMobileResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCompany" runat="server" Text="Company" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblCompanyResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCompany" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Company" meta:resourcekey="txtCompanyResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCompany1" runat="server" Text="23" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtCompany1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkCompany" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkCompanyResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblWebsite" runat="server" Text="Website" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblWebsiteResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtWebsite" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Website" meta:resourcekey="txtWebsiteResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtWebsite1" runat="server" Text="24" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtWebsite1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkWebsite" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkWebsiteResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMessage" runat="server" Text="Message" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblMessageResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMessage" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Message" meta:resourcekey="txtMessageResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtMessage1" runat="server" Text="25" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtMessage1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkMessage" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkMessageResource1" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAttachment" runat="server" Text="Attachment" 
                                       CssClass="cssClassFormLabel" meta:resourcekey="lblAttachmentResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAttachment" runat="server" CssClass="cssClassNormalTextBoxText"
                                         Text="Attachment" meta:resourcekey="txtAttachmentResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAttachment1" runat="server" Text="26" 
                                         CssClass="cssClassNormalTextBoxFeedBack" 
                                         meta:resourcekey="txtAttachment1Resource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkAttachment" runat="server" CssClass="cssClassCheckBox" 
                                          meta:resourcekey="chkAttachmentResource1" />
                        </td>
                    </tr>
                </table>
                <div class="cssClassButtonWrapper">
                    <asp:ImageButton ID="imbSaveContactUsSetting" runat="server"
                                     OnClick="imbSaveContactUsSetting_Click" 
                                     meta:resourcekey="imbSaveContactUsSettingResource1" />
                    <asp:Label ID="lblSaveContactUsSetting" runat="server" Text="Save" AssociatedControlID="imbSaveContactUsSetting"
                               Style="cursor: pointer;" 
                               meta:resourcekey="lblSaveContactUsSettingResource1"></asp:Label>
                </div>
            </div>
        </ContentTemplate>
    </ajax:TabPanel>
    <ajax:TabPanel ID="TabPanelContactUsMailSetting" runat="server" 
                   meta:resourcekey="TabPanelContactUsMailSettingResource1">
        <HeaderTemplate>
            Email Setting
        </HeaderTemplate>
        <ContentTemplate>
            <asp:Label ID="lblContactUsMailSettingHelp" runat="server" CssClass="cssClassHelpTitle"
                
                       Text="In this section, you can set up the ContactUs Mail Setting for the FeedBack Module" 
                       meta:resourcekey="lblContactUsMailSettingHelpResource1"></asp:Label>
            <div class="cssClassFormWrapper">
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <asp:RadioButtonList ID="rblFeedBackSetting" runat="server" 
                                             CssClass="cssClassRadioButton" meta:resourcekey="rblFeedBackSettingResource1">
                            <asp:ListItem Text="Send Mail" Value="1" Selected="True" 
                                          meta:resourcekey="ListItemResource1"></asp:ListItem>
                            <asp:ListItem Text="Save Only" Value="2" meta:resourcekey="ListItemResource2"></asp:ListItem>
                            <asp:ListItem Text="Both Save and Send" Value="3" 
                                          meta:resourcekey="ListItemResource3"></asp:ListItem>
                        </asp:RadioButtonList>
                    </tr>
                </table>
                <div class="cssClassButtonWrapper">
                    <asp:ImageButton ID="imbSaveEmailSetting" runat="server"
                                     OnClick="imbSaveEmailSetting_Click" 
                                     meta:resourcekey="imbSaveEmailSettingResource1" />
                    <asp:Label ID="lblSaveEmailSetting" runat="server" Text="Save" AssociatedControlID="imbSaveEmailSetting"
                               Style="cursor: pointer;" meta:resourcekey="lblSaveEmailSettingResource1"></asp:Label>
                </div>
            </div>
        </ContentTemplate>
    </ajax:TabPanel>
</ajax:TabContainer>