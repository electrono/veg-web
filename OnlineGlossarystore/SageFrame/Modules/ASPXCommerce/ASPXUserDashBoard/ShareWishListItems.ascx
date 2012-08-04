<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ShareWishListItems.ascx.cs" Inherits="Modules_ASPXCommerce_ASPXUserDashBoard_ShareWishListItems" %>
<script type="text/javascript">

    $(document).ready(function() {
        HideAllDiv();
        $('#divShareWishListItemDetails').show();
        LoadUserDahsShareWishStaticImage();
        BindShareWihsListItemMail();
        $('#btnDeleteSelected').click(function() {
            var shareWishListIDs = '';
            //Get the multiple Ids of the item selected
            $(".EmailsChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    shareWishListIDs += $(this).val() + ',';
                }
            });
            if (shareWishListIDs != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleShareWishList(shareWishListIDs, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        })
        $('#btnShareWishBack').click(function() {
            $('#divShareWishListItemDetails').show();
            $('#divViewShareWihsList').hide();
        });
    });

    function LoadUserDahsShareWishStaticImage() {
        $('#ajaxUserDashShareWishImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function HideAllDiv() {
        $('#divShareWishListItemDetails').hide();
        $('#divViewShareWihsList').hide();
        $('.cssClassShareWishItemID').hide();
    }

    function BindShareWihsListItemMail() {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvShareWishListtbl_pagesize").length > 0) ? $("#gdvShareWishListtbl_pagesize :selected").text() : 10;

        $("#gdvShareWishListtbl").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAllShareWishListItemMail',
            colModel: [
                { display: 'ShareWishID', name: 'ShareWishID', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'EmailsChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'SharedWishItemID', name: 'SharedItemIDs', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'center', hide: true },
                { display: 'Shared WishItem Name', name: 'SharedWishItemName', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Sender Name', name: 'SenderName', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Sender Email', name: 'SenderEmail', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Receivers EmailID', name: 'ReceiverEmailID', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Subject', name: 'Subject', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Message', name: 'massage', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Send On', name: 'AddedOn', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'View', name: 'view', enable: true, _event: 'click', trigger: '1', callMethod: 'ViewShareWishListEmail', arguments: '1,2,3,4,5,6,7,8' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteShareWishListEmail', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 9: { sorter: false } }
        });
    }

    function ViewShareWishListEmail(tblID, argus) {
        switch (tblID) {
        case 'gdvShareWishListtbl':
            GetWishLisDetailByID(argus[0]);
            $('#divShareWishListItemDetails').hide();
            $('#divViewShareWihsList').show();
            $('#lblWishListSharedDateD').html(argus[10]);
            $('#lblSenderNameD').html(argus[5]);
            $('#lblSenderEmailIDD').html(argus[6]);
          //$('#lblShareWishListItemIDD').html(argus[3]);
            $('#lblShareWishlListSubjectD').html(argus[8]);
            $('#lblShareWishListMessageD').html(argus[9]);
            $('#hdnShareWishItemID').val(argus[0]);

            var receiverEmailID = argus[7];
            var substrEmailID = receiverEmailID.split(',');
            var IDs = '';
            $.each(substrEmailID, function(index, value) {
                IDs += value + '</br>';
            });
            $('#lblReceiverEmailIDD').html(IDs);
            break;
        default:
            break;
        }
    }

    function GetWishLisDetailByID(shareWishedID) {

        var params = { SharedWishID: shareWishedID, StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetShareWishListItemByID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $.each(msg.d, function(index, value) {
                    var itemName = value.SharedWishItemName;
                    var substr = itemName.split(',');
                    var Name = '';
                    $.each(substr, function(index, value) {
                        Name += value + '</br>';
                    });
                    $('#lblShareWishItemNameD').html(Name);
                });

            }
//        ,
//        error: function() {
//            alert("Error!!");
//        }
        });
    }

    function DeleteShareWishListEmail(tblID, argus) {
        switch (tblID) {
        case 'gdvShareWishListtbl':
            var properties = {
                onComplete: function(e) {
                    DeleteMultipleShareWishListEmail(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteShareWish() {
        var id = $('#hdnShareWishItemID').val();
        var properties = {
            onComplete: function(e) {
                DeleteMultipleShareWishListEmail(id, e);
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
    }

    function ConfirmDeleteMultipleShareWishList(Ids, event) {
        DeleteMultipleShareWishListEmail(Ids, event);
    }

    function DeleteMultipleShareWishListEmail(emailShareWish_Ids, event) {
        if (event) {
            var params = { ShareWishListID: emailShareWish_Ids, StoreID: storeId, PortalID: portalId, UserName: userName, CultureName: cultureName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteShareWishListItem",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindShareWihsListItemMail();
                    $('#divViewShareWihsList').hide();
                    $('#divShareWishListItemDetails').show();


                },
                error: function() {
                    alert("Error!!");
                }
            });
        }
        return false;
    }

    function SearchWishListItemMail() {
        var senderName = $.trim($('#txtSearchSenderName').val());
        var senderEmailID = $.trim($('#txtSearchSenderEmail').val());
        if (senderName.length < 1) {
            senderName = null;
        }
        if (senderEmailID.length < 1) {
            senderEmailID = null
        }
        BindShareWihsListItemMail(senderName, senderEmailID);
    }

</script>

<div id="divShareWishListItemDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblShareWishTitle" runat="server" Text="My Share WishList Item"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteSelected"> <span> <span>Delete All Selected</span> </span> </button>
                    </p>
                    <div class="cssClassClear"></div>
                </div>
            </div>
            <div class="cssClassClear"></div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <%-- <div class="cssClassSearchPanel cssClassFormWrapper">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td>
                    <label class="cssClassLabel">
                        Sender Name:</label>
                    <input type="text" id="txtSearchSenderName" class="cssClassTextBoxSmall" />
                </td>
                <td>
                    <label class="cssClassLabel">
                        Sender Email:</label>
                    <input type="text" id="txtSearchSenderEmail" class="cssClassTextBoxSmall" />
                </td>
                <td>
                    <div class="cssClassButtonWrapper cssClassPaddingNone">
                        <p>
                            <button type="button" onclick="SearchWishListItemMail()">
                                <span><span>Search</span></span></button>
                        </p>
                    </div>
                </td>
            </tr>
        </table>
                </div>--%>
    
                <div class="loading"> 
                    <img id="ajaxUserDashShareWishImage"/> </div>
                <div class="log"> </div>
                <table id="gdvShareWishListtbl" cellspacing="0" cellpadding="0" border="0" width="100%">
                </table>
            </div>
        </div>
    </div>
</div>


<div id="divViewShareWihsList">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblSPHeading" runat="server" Text="ShareWish List"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td>
                        <asp:Label ID="lblWishListSharedDate" runat="server" Text="WishList Shared Date :" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblWishListSharedDateD"></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSenderName" runat="server" Text="Sender Name: " CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblSenderNameD" ></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSenderEmailID" runat="server" Text="Sender EmailID:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblSenderEmailIDD" ></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblReceiverEmailID" runat="server" Text="Receiver EmailID :" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblReceiverEmailIDD"></label>
                    </td>
                </tr>
             
                <tr class="cssClassShareWishItemID">
                    <td>
                        <asp:Label ID="lblShareWishListItemID" runat="server" Text="Shared Wish ItemIDs :" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblShareWishListItemIDD" ></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblShareWishListItemName" runat="server" Text="Shared Wish Item Name: " CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblShareWishItemNameD"></label>
                    </td>
                </tr>
               
                <tr>
                    <td>
                        <asp:Label ID="lblShareWishlListSubject" runat="server" Text="Mail's Subject :" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblShareWishlListSubjectD" ></label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblShareWishListMessage" runat="server" Text="Mail's Message :" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <label id="lblShareWishListMessageD"></label>
                    </td>
                </tr>
                            
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <button type="button" id="btnShareWishBack">
                <span><span>Back</span></span></button>
            <button type="reset" id="btnDelete" onclick=" DeleteShareWish(); ">
                <span><span>Delete</span></span></button>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<input type="hidden" id="hdnShareWishItemID" />