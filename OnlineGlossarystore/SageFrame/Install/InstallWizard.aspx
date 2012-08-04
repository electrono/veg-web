<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InstallWizard.aspx.cs" Inherits="SageFrame.Install.InstallWizard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head runat="server" id="head">
        <link type="icon shortcut" media="icon" href="favicon.ico" />
        <meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
        <meta content="text/javascript" http-equiv="Content-Script-Type" />
        <meta content="text/css" http-equiv="Content-Style-Type" />
        <meta id="MetaRefresh" runat="Server" http-equiv="Refresh" name="Refresh" />
        <meta id="MetaDescription" runat="Server" name="DESCRIPTION" />
        <meta id="MetaKeywords" runat="Server" name="KEYWORDS" />
        <meta id="MetaCopyright" runat="Server" name="COPYRIGHT" />
        <meta id="MetaGenerator" runat="Server" name="GENERATOR" />
        <meta id="MetaAuthor" runat="Server" name="AUTHOR" />
        <meta name="RESOURCE-TYPE" content="DOCUMENT" />
        <meta name="DISTRIBUTION" content="GLOBAL" />
        <meta id="MetaRobots" runat="server" name="ROBOTS" />
        <meta name="REVISIT-AFTER" content="1 DAYS" />
        <meta name="RATING" content="GENERAL" />
        <meta http-equiv="PAGE-ENTER" content="RevealTrans(Duration=0,Transition=1)" />
        <link href="~/Install/css/install.css" rel="stylesheet" type="text/css" />
        <!--[if IE]> <link href="~/Install/css/IE.css" rel="stylesheet" type="text/css" /> <![endif]-->

        <script language="javascript" type="text/javascript">
            function checkDisabled(button) {
                //return false;
                if (button.className == "cssClassWizardButtonDisabled") {
                    return true;
                } else {
                    return false;
                }
            }
        </script>

        <noscript>
            <asp:Label ID="lblnoScript" runat="server" Text="This page requires java-script to be enabled. Please adjust your browser-settings."></asp:Label></noscript>
        <title>SageFrame Website Installation</title>
    </head>
    <body>
        <div id="cssClassInstallWrapper">
            <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                    <Services>
                        <asp:ServiceReference Path="~/SageFrameWebService.asmx" />
                    </Services>
                </asp:ScriptManager>
                <asp:UpdatePanel ID="udpWizard" runat="server">
                    <ContentTemplate>
                        <asp:HiddenField ID="hdnConnectionStringForAll" runat="server" Value="" />
                        <asp:HiddenField ID="hdnNextButtonClientID" runat="server" Value="0" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:Wizard ID="wizInstallWizard" runat="server" DisplaySideBar="False" ActiveStepIndex="0"
                            Width="100%" DisplayCancelButton="false" OnNextButtonClick="wizInstallWizard_NextButtonClick"
                            OnCancelButtonClick="wizInstallWizard_CancelButtonClick" OnFinishButtonClick="wizInstallWizard_FinishButtonClick"
                            OnActiveStepChanged="wizInstallWizard_ActiveStepChanged" OnPreviousButtonClick="wizInstallWizard_PreviousButtonClick">
                    <HeaderTemplate>
                        <div class="cssClassLogoWrapper">
                            <div class=" cssClassTopHeading">
                                <asp:Label ID="lblTitle" runat="server" CssClass="" /></div>
                            <div class="cssClassVerson">
                                <span>
                                    <asp:Label ID="lblVersion" runat="server" CssClass="" /></span></div>
                            <div class="cssClassLeftCorner">
                                <img src="images/top-left.jpg" width="6" height="45" alt="Left" /></div>
                            <div class="cssClassRightCorner">
                                <img src="images/top-right.jpg" width="6" height="45" alt="RIght" /></div>
                        </div>
                    </HeaderTemplate>
                    <StartNavigationTemplate>
                        <div class="cssClassButtonWrapper">
                            <asp:Button ID="StartNextButton" runat="server" AlternateText="Next" BackColor="Transparent"
                                        BorderStyle="None" CausesValidation="False" CommandName="MoveNext" CssClass="cssClassWizardButton"
                                        Text="Next" />
                        </div>
                        <div class="footer">
                        </div>
                    </StartNavigationTemplate>
                    <StepNavigationTemplate>
                        <div class="cssClassButtonWrapper">
                            <asp:Button ID="CustomButton" runat="server" AlternateText="Custom" BackColor="Transparent"
                                        BorderStyle="None" CausesValidation="False" CssClass="cssClassWizardButton" Text="Custom"
                                        Visible="False" />
                            <asp:Button ID="StepPreviousButton" runat="server" AlternateText="Previous" BackColor="Transparent"
                                        BorderStyle="None" CausesValidation="False" CommandName="MovePrevious" Text="Previous" />
                            <%--<asp:UpdatePanel ID="upnlStartButton" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>--%>
                            <asp:Button ID="StepNextButton" runat="server" AlternateText="Next" BackColor="Transparent"
                                        BorderStyle="None" CausesValidation="False" CommandName="MoveNext" Text="Next" />
                            <%--<asp:Button ID="ReturnButton" runat="server" AlternateText="Return" BackColor="Transparent"
                        BorderStyle="None" CausesValidation="False" CssClass="cssClassWizardButton" Text="Return" Visible="false"/>--%>
                            <%--</ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </div>
                        <div class="footer">
                        </div>
                    </StepNavigationTemplate>
                    <FinishNavigationTemplate>
                        <div class="cssClassButtonWrapper">
                            <asp:Button ID="FinishButton" runat="server" AlternateText="Finish (Access your Portal)"
                                        BackColor="Transparent" BorderStyle="None" CausesValidation="False" CommandName="MoveComplete"
                                        CssClass="cssClassWizardButton" Text="Finish (Access your Portal)" />
                        </div>
                        <div class="footer">
                        </div>
                    </FinishNavigationTemplate>
                    <WizardSteps>
                        <asp:WizardStep ID="StepWelcome" runat="Server" Title="Welcome" StepType="Start">
                            <div class="cssClassTitleWrapper">
                                <div class="cssClassmaincontent">
                                    <h1>
                                        <asp:Label ID="lblStepfirstTitle" runat="server" CssClass="cssClassFormLabel" />
                                    </h1>
                                    <p>
                                        <asp:Label ID="lblStepfirstDetail" runat="Server" />
                                    </p>
                                </div>
                                <div class="lt">
                                    <img src="images/topleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/topright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/btnright.jpg" width="5" height="5" /></div>
                            </div>
                            <div class="cssClassProcessWrapper">
                                <div class="cssClassmaincontent">
                                    <table id="tblWelcome" runat="server" cellpadding="0" cellspacing="0" border="0"
                                           width="100%">
                                        <tr>
                                            <td width="19%">
                                                <asp:Label ID="lblChooseInstall" runat="server" CssClass="cssClassFormLabel" />
                                            </td>
                                            <td>
                                                <asp:RadioButtonList ID="rblInstallType" runat="Server" RepeatDirection="Vertical"
                                                                     CssClass="cssClassButtonListWrapper" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lblDataBaseWarning" runat="server" CssClass="cssClasssNormalRed" EnableViewState="True"
                                               Visible="false" />
                                    <asp:Label ID="lblHostWarning" runat="server" CssClass="cssClasssNormalRed" EnableViewState="True"
                                               Visible="false" />
                                </div>
                                <div class="lt">
                                    <img src="images/ptopleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/ptopright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/pbtnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/pbtnright.jpg" width="5" height="5" /></div>
                            </div>
                        </asp:WizardStep>
                        <asp:WizardStep ID="StepFilePermissions" runat="server" Title="FilePermissions">
                            <div class="cssClassTitleWrapper">
                                <div class="cssClassmaincontent">
                                    <h1>
                                        <asp:Label ID="lblFilePermissionsTitle" runat="server" CssClass="cssClassFormLabel" />
                                    </h1>
                                    <p>
                                        <asp:Label ID="lblFilePermissionsDetail" runat="Server" />
                                    </p>
                                </div>
                                <div class="lt">
                                    <img src="images/topleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/topright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/btnright.jpg" width="5" height="5" /></div>
                            </div>
                            <div class="cssClassProcessWrapper">
                                <div class="cssClassmaincontent">
                                    <asp:Label ID="lblPermissions" runat="server" CssClass="cssClassloadingDiv" />
                                    <asp:CheckBoxList ID="lstPermissions" runat="server" DataTextField="Name" DataValueField="Permission"
                                                      TextAlign="Left" CssClass="cssClassCheckBox" />
                                    <asp:Label ID="lblPermissionsError" runat="server" CssClass="cssClasssNormalRed"
                                               EnableViewState="false" Visible="false" />
                                </div>
                                <div class="lt">
                                    <img src="images/ptopleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/ptopright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/pbtnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/pbtnright.jpg" width="5" height="5" /></div>
                            </div>
                        </asp:WizardStep>
                        <asp:WizardStep ID="StepConnectionString" runat="Server" Title="ConnectionString">
                            <div class="cssClassTitleWrapper">
                                <div class="cssClassmaincontent">
                                    <h1>
                                        <asp:Label ID="lblConnectionStringTitle" runat="server" CssClass="cssClassFormLabel"
                                                   Text="" />
                                    </h1>
                                    <p>
                                        <asp:Label ID="lblConnectionStringDetail" runat="Server" Text="" />
                                    </p>
                                </div>
                                <div class="lt">
                                    <img src="images/topleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/topright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/btnright.jpg" width="5" height="5" /></div>
                            </div>
                            <div class="cssClassProcessWrapper">
                                <div class="cssClassmaincontent">
                                    <table id="tblDatabase" runat="Server" visible="False" cellpadding="0" cellspacing="0"
                                           border="0" class="cssClassConnection">
                                        <tr>
                                            <td width="19%">
                                                <asp:Label ID="lblChooseDatabase" runat="server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td colspan="2">
                                                <asp:RadioButtonList ID="rblDatabases" runat="Server" selected="true" RepeatDirection="Horizontal"
                                                                     RepeatColumns="3" CssClass="cssClassRadioButtonList" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblServer" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtServer" runat="Server" CssClass="cssClassNormalTextBox" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblServerHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                        <tr id="trDatabase" runat="server">
                                            <td>
                                                <asp:Label ID="lblDataBase" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDatabase" runat="Server" CssClass="cssClassNormalTextBox" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDatabaseHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblIntegrated" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkIntegrated" runat="Server" AutoPostBack="True" CssClass="cssClassCheckBox"
                                                              OnCheckedChanged="chkIntegrated_CheckedChanged" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblIntegratedHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                        <tr id="trUser" runat="Server">
                                            <td>
                                                <asp:Label ID="lblUserID" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUserId" runat="Server" CssClass="cssClassNormalTextBox" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblUserHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="8">
                                            </td>
                                            <td height="8">
                                            </td>
                                            <td height="8">
                                            </td>
                                        </tr>
                                        <tr id="trPassword" runat="Server">
                                            <td>
                                                <asp:Label ID="lblPassword" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPassword" runat="Server" CssClass="cssClassNormalTextBox" TextMode="Password" EnableViewState="true" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPasswordHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblOwner" runat="Server" CssClass="cssClassNormalText" />
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkOwner" runat="Server" CssClass="cssClassCheckBox" Checked="true" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblOwnerHelp" runat="Server" CssClass="cssClassTextHelp" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Label ID="lblDataBaseError" runat="server" CssClass="cssClasssNormalRed" Visible="false"
                                               EnableViewState="false" />
                                </div>
                                <div class="lt">
                                    <img src="images/ptopleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/ptopright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/pbtnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/pbtnright.jpg" width="5" height="5" /></div>
                            </div>
                        </asp:WizardStep>
                        <asp:WizardStep ID="StepDatabase" runat="server" Title="Database">
                            <asp:Timer runat="server" ID="UpdateTimer" Interval="1000" OnTick="UpdateTimer_Tick"
                                       Enabled="false" />
                            <asp:UpdatePanel runat="server" ID="TimedPanel" UpdateMode="Conditional">
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="UpdateTimer" EventName="Tick" />
                                </Triggers>
                                <ContentTemplate>
                                    <div class="cssClassTitleWrapper">
                                        <div class="cssClassmaincontent">
                                            <h1>
                                                <asp:Label ID="lblStepDatabaseTitle" runat="server" CssClass="cssClassFormLabel" />
                                            </h1>
                                            <p>
                                                <asp:Label ID="lblStepDatabaseDetail" runat="Server" />
                                            </p>
                                        </div>
                                        <div class="lt">
                                            <img src="images/topleft.jpg" width="5" height="5" /></div>
                                        <div class="rt">
                                            <img src="images/topright.jpg" width="5" height="5" /></div>
                                        <div class="lb">
                                            <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                        <div class="rb">
                                            <img src="images/btnright.jpg" width="5" height="5" /></div>
                                    </div>
                                    <div class="cssClassProcessWrapper">
                                        <div class="cssClassmaincontent">
                                            <div class="cssClassloadingDiv" id="loadingDiv" runat="server">
                                                <asp:Label ID="lblDBProgress" runat="server" Text="Installing Database Scripts ..."
                                                           EnableViewState="false"></asp:Label>
                                                <asp:Image ID="imgDBProgress" runat="server" AlternateText="Installing Database Scripts..."
                                                           ToolTip="Installing Database Scripts..." />
                                            </div>
                                            <asp:TextBox ID="txtFeedback" runat="server" class="cssClassFeedBack" Columns="80"
                                                         Rows="12" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                            <asp:Label ID="lblInstallErrorOccur" runat="server" Visible="false" EnableViewState="false" />
                                        </div>
                                        <div class="lt">
                                            <img src="images/ptopleft.jpg" width="5" height="5" /></div>
                                        <div class="rt">
                                            <img src="images/ptopright.jpg" width="5" height="5" /></div>
                                        <div class="lb">
                                            <img src="images/pbtnleft.jpg" width="5" height="5" /></div>
                                        <div class="rb">
                                            <img src="images/pbtnright.jpg" width="5" height="5" /></div>
                                    </div>
                                </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:WizardStep>
                        <asp:WizardStep ID="StepDataBaseFeedBack" runat="server" OnActivate="StepDataBaseFeedBack_Active"
                                        Title="Database Feedback">
                            <div class="cssClassTitleWrapper">
                                <div class="cssClassmaincontent">
                                    <h1>
                                        <asp:Label ID="lblStepDataBaseFeedBackTitle" runat="server" CssClass="cssClassFormLabel" />
                                    </h1>
                                    <p>
                                        <asp:Label ID="lblStepDataBaseFeedBackDetail" runat="Server" />
                                    </p>
                                </div>
                                <div class="lt">
                                    <img src="images/topleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/topright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/btnright.jpg" width="5" height="5" /></div>
                            </div>
                            <div class="cssClassProcessWrapper">
                                <div class="cssClassmaincontent">
                                    <div class="cssClassloadingDiv">
                                        <asp:Label ID="lblReport" runat="server" Text="Installation Status Report"></asp:Label>
                                    </div>
                                    <asp:TextBox ID="txtFeedbackDetail" runat="server" class="cssClassFeedBack" Columns="80"
                                                 Rows="12" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                    <asp:Label ID="lblInstallError" runat="server" Visible="false" />
                                </div>
                                <div class="lt">
                                    <img src="images/ptopleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/ptopright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/pbtnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/pbtnright.jpg" width="5" height="5" /></div>
                            </div>
                        </asp:WizardStep>
                        <asp:WizardStep ID="StepComplete" runat="server" StepType="Finish" Title="Installation Complete"
                                        AllowReturn="false">
                            <div class="cssClassTitleWrapper">
                                <div class="cssClassmaincontent">
                                    <h1>
                                        <asp:Label ID="lblCompleteTitle" runat="server" CssClass="cssClassFormLabel" />
                                    </h1>
                                    <p>
                                        <asp:Label ID="lblCompleteDetail" runat="server" />
                                    </p>
                                </div>
                                <div class="lt">
                                    <img src="images/topleft.jpg" width="5" height="5" /></div>
                                <div class="rt">
                                    <img src="images/topright.jpg" width="5" height="5" /></div>
                                <div class="lb">
                                    <img src="images/btnleft.jpg" width="5" height="5" /></div>
                                <div class="rb">
                                    <img src="images/btnright.jpg" width="5" height="5" /></div>
                            </div>
                        </asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
            </form>
        </div>
    </body>
</html>