<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferredFriends.ascx.cs"
            Inherits="Modules_ASPXUserDashBoard_ReferredFriends" %>

<script type="text/javascript">
    $(document).ready(function() {
        LoadUserDashReferFriendStaticImage();
        GetMyReferredFriendsDetails();
        $('#btnDeleteSelected').click(function() {
            var emailAFriend_Ids = '';
            //Get the multiple Ids of the item selected
            $(".EmailsChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    emailAFriend_Ids += $(this).val() + ',';
                }
            });
            if (emailAFriend_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleEmails(emailAFriend_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        })
    });

    function LoadUserDashReferFriendStaticImage() {
        $('#ajaxUserDashReferFriendImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function GetMyReferredFriendsDetails() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvReferredFriends_pagesize").length > 0) ? $("#gdvReferredFriends_pagesize :selected").text() : 10;

        $("#gdvReferredFriends").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetUserReferredFriends',
            colModel: [
                { display: 'EmailAFriendID', name: 'emailafriend_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'EmailsChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Sendet Name', name: 'sender_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Sender Email', name: 'sender_email', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Receiver Name', name: 'receiver_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: false },
                { display: 'Receiver Email', name: 'receiver_email', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Subject', name: 'subject', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Message', name: 'massage', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'StoreID', name: 'store_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'PortalID', name: 'portal_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'IsActive', name: 'isActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'IsDeleted', name: 'isActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'IsModified', name: 'isActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Added On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd', hide: false },
                { display: 'Updated On', name: 'UpdatedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd', hide: true },
                { display: 'Deleted On', name: 'DeletedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd', hide: true },
                { display: 'Added By', name: 'AddedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Updated By', name: 'UpdatedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Deleted By', name: 'DeletedBy', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
            //{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditUserReferredFriends',arguments: '8,9,16' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteUserReferredFriends', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { storeID: storeId, portalID: portalId, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 1: { sorter: false }, 19: { sorter: false } }
        });
    }

    function ConfirmDeleteMultipleEmails(Ids, event) {
        DeleteMultipleEmailsInfo(Ids, event);
    }

    function DeleteUserReferredFriends(argus) {
        var properties = {
            onComplete: function(e) {
                DeleteMultipleEmailsInfo(argus[0], e);
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
    }

    function DeleteMultipleEmailsInfo(emailAFriend_Ids, event) {
        if (event) {
            var params = { emailAFriendIDs: emailAFriend_Ids, storeID: storeId, portalID: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteReferToFriendEmailUser",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    GetMyReferredFriendsDetails();
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }
</script>

<div class="cssClassCommonBox Curve">
    <div class="cssClassHeader">
        <h2>
            <asp:Label ID="lblReferredEmailGridHeading" runat="server" Text="My Referred Friends"></asp:Label>
        </h2>
        <div class="cssClassHeaderRight">
            <div class="cssClassButtonWrapper">
                <p>
                    <button type="button" id="btnDeleteSelected">
                        <span><span>Delete All Selected</span></span></button>
                </p>
                <div class="cssClassClear">
                </div>
            </div>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
    <div class="cssClassGridWrapper">
        <div class="cssClassGridWrapperContent">
            <div class="loading">
                <img id="ajaxUserDashReferFriendImage" />
            </div>
            <div class="log">
            </div>
            <table id="gdvReferredFriends" cellspacing="0" cellpadding="0" border="0" width="100%">
            </table>
        </div>
    </div>
</div>
<input type="hidden" id="hdnEmailaFriendID" />