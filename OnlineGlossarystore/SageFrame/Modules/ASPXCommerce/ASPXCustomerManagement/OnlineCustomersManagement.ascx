<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OnlineCustomersManagement.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCustomerManagement_OnlineCustomersManagement" %>
<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        SelectFirstTab();
        LoadCustomerOnlineStaticImage();
        bindRegisteredUserGrid(null, null, null);
        bindAnonymousUserGrid(null, null);
    });

    function LoadCustomerOnlineStaticImage() {
        $('#ajaxCustomerOnline').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
        $('#ajaxCustomerOnline2').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function SelectFirstTab() {
        var $tabs = $('#container-7').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });
        $tabs.tabs('select', 0);
    }

    function bindRegisteredUserGrid(searchUsername, hostaddress, browser) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvOnlineRegisteredUser_pagesize").length > 0) ? $("#gdvOnlineRegisteredUser_pagesize :selected").text() : 10;

        $("#gdvOnlineRegisteredUser").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetRegisteredUserOnlineCount',
            colModel: [
                { display: 'User Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session User Host Address', name: 'hostaddress_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session User Agent', name: 'agent_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session Browser', name: 'browser_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session URL', name: 'url_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Start Time', name: 'start_time', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { SearchUserName: searchUsername, SearchHostAddress: hostaddress, SearchBrowser: browser, PortalID: portalId, StoreID: storeId, PortalID: portalId, UserName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 10: { sorter: false } }
        });
    }

    function bindAnonymousUserGrid(hostaddress, browser) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvOnlineAnonymousUser_pagesize").length > 0) ? $("#gdvOnlineAnonymousUser_pagesize :selected").text() : 10;

        $("#gdvOnlineAnonymousUser").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAnonymousUserOnlineCount',
            colModel: [
            // { display: 'S.No.', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'center', hide: true },
            // { display: 'RowID', name: 'attr_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', checkFor: '5', elemClass: 'attrChkbox', elemDefault: false, controlclass: 'attribHeaderChkbox' },
                { display: 'User Name', name: 'user_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Session User Host Address', name: 'hostaddress_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session User Agent', name: 'agent_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session Browser', name: 'browser_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Session URL', name: 'url_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
            //{ display: 'SessionUserAgent', name: 'attr_alias', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Start Time', name: 'start_time', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { SearchHostAddress: hostaddress, SearchBrowser: browser, PortalID: portalId, StoreID: storeId, PortalID: portalId, UserName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 10: { sorter: false } }
        });
    }

    function SearchOnlineAnonymousUser() {
        var HostAddress = $.trim($("#txtSearchHostAddress0").val());
        var Browser = $.trim($("#txtBrowserName0").val());

        if (HostAddress.length < 1) {
            HostAddress = null;
        }
        if (Browser.length < 1) {
            Browser = null;
        }
        bindAnonymousUserGrid(HostAddress, Browser);
    }

    function SearchOnlineRegisteredUser() {
        var SearchUserName = $.trim($("#txtSearchUserName1").val());
        var HostAddress = $.trim($("#txtSearchHostAddress1").val());
        var Browser = $.trim($("#txtBrowserName1").val());

        if (SearchUserName.length < 1) {
            SearchUserName = null;
        }
        if (HostAddress.length < 1) {
            HostAddress = null;
        }
        if (Browser.length < 1) {
            Browser = null;
        }
        bindRegisteredUserGrid(SearchUserName, HostAddress, Browser);
    }

</script>

<div id="divAttrForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrFormHeading" runat="server" Text="Online Users"></asp:Label>
            </h2>
        </div>
        <div class="cssClassTabPanelTable">
            <div id="container-7">
                <ul>
                    <li><a href="#fragment-1">
                            <asp:Label ID="lblTabTitle1" runat="server" Text="Registered Users"></asp:Label>
                        </a></li>
                    <li><a href="#fragment-2">
                            <asp:Label ID="lblTabTitle2" runat="server" Text="Anonymous User"></asp:Label>
                        </a></li>
                </ul>
                <div id="fragment-1">
                    <div class="cssClassFormWrapper">
                        <div id="divRegisteredUsers">
                            <div class="cssClassCommonBox Curve">
                                <div class="cssClassGridWrapper">
                                    <div class="cssClassGridWrapperContent">
                                        <div class="cssClassSearchPanel cssClassFormWrapper">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <label class="cssClassLabel">
                                                            User Name:</label>
                                                        <input type="text" id="txtSearchUserName1" class="cssClassTextBoxSmall" />
                                                    </td>
                                                    <td>
                                                        <label class="cssClassLabel">
                                                            Host Address:</label>
                                                        <input type="text" id="txtSearchHostAddress1" class="cssClassTextBoxSmall" />
                                                    </td>
                                                    <td>
                                                        <label class="cssClassLabel">
                                                            Browser Name:</label>
                                                        <input type="text" id="txtBrowserName1" class="cssClassTextBoxSmall" />
                                                    </td>
                                                    <td>
                                                        <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                            <p>
                                                                <button type="button" onclick=" SearchOnlineRegisteredUser() ">
                                                                    <span><span>Search</span></span></button>
                                                            </p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="loading">
                                            <img id="ajaxCustomerOnline"/>
                                        </div>
                                        <div class="log">
                                        </div>
                                        <table id="gdvOnlineRegisteredUser" cellspacing="0" cellpadding="0" border="0" width="100%">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="fragment-2">
                    <div class="cssClassFormWrapper">
                        <div id="divAnonymousUser">
                            <div class="cssClassCommonBox Curve">
                                <div class="cssClassGridWrapper">
                                    <div class="cssClassGridWrapperContent">
                                        <div class="cssClassSearchPanel cssClassFormWrapper">
                                            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                <tr>
                                                    <td>
                                                        <label class="cssClassLabel">
                                                            Host Address:</label>
                                                        <input type="text" id="txtSearchHostAddress0" class="cssClassTextBoxSmall" />
                                                    </td>
                                                    <td>
                                                        <label class="cssClassLabel">
                                                            Browser Name:</label>
                                                        <input type="text" id="txtBrowserName0" class="cssClassTextBoxSmall" />
                                                    </td>
                                                    <td>
                                                        <div class="cssClassButtonWrapper cssClassPaddingNone">
                                                            <p>
                                                                <button type="button" onclick=" SearchOnlineAnonymousUser() ">
                                                                    <span><span>Search</span></span></button>
                                                            </p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <div class="loading">
                                            <img id="ajaxCustomerOnlie2"/>
                                        </div>
                                        <div class="log">
                                        </div>
                                        <table id="gdvOnlineAnonymousUser" cellspacing="0" cellpadding="0" border="0" width="100%">
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>