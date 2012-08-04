<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UserDownloadableProducts.ascx.cs"
            Inherits="Modules_ASPXUserDashBoard_UserDownloadableProducts" %>

<script type="text/javascript">
    $(document).ready(function() {
        LoadUserDashDownloadableImage();
        BindCustomerDownLoadItemsGrid(null, null);

        $("#btnDeleteCustDownloadableItem").click(function() {
            var orderItem_Ids = '';
            //Get the multiple Ids of the item selected
            $(".orderitemsChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    orderItem_Ids += $(this).val() + ',';
                }
            });
            if (orderItem_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        ConfirmDeleteMultipleOrderItem(orderItem_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected Order Items?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one item before you can do this.<br/> To select one or more items, just check the box before each item.</p>');
            }
        });
    });

    function LoadUserDashDownloadableImage() {
        $('#ajaxUserDashBoardDownloadImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function SearchItems() {
        var sku = $.trim($("#txtSearchSKU").val());
        var Nm = $.trim($("#txtSearchName").val());
        if (sku.length < 1) {
            sku = null;
        }
        if (Nm.length < 1) {
            Nm = null;
        }
        var isAct = $.trim($("#ddlIsActive").val()) == "" ? null : ($.trim($("#ddlIsActive").val()) == "True" ? true : false);

        BindCustomerDownLoadItemsGrid(sku, Nm);
    }

    function BindCustomerDownLoadItemsGrid(sku, Nm) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCustomerDownLoadItems_pagesize").length > 0) ? $("#gdvCustomerDownLoadItems_pagesize :selected").text() : 10;

        $("#gdvCustomerDownLoadItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCustomerDownloadableItems',
            colModel: [
                { display: 'OrderItemID', name: 'orderitemid', cssclass: 'cssClassHeadCheckBox', controlclass: 'classClassCheckBox', coltype: 'checkbox', align: 'center', elemDefault: false, elemClass: 'orderitemsChkbox' },
                { display: 'OrderItemID#', name: 'order_item_id', cssclass: '', coltype: 'label', align: 'left', controlclass: '', hide: true },
                { display: 'OrderID#', name: 'orderid', cssclass: '', coltype: 'label', align: 'left', controlclass: '', hide: true },
                { display: 'RandomNo', name: 'random_no', cssclass: '', controlclass: '', coltype: 'label', align: 'left', controlclass: '', hide: true },
                { display: 'ItemID', name: 'itemid', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Item Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Sample Link', name: 'sample_link', cssclass: '', controlclass: 'cssSClassDownload', coltype: 'linklabel', align: 'left', value: '9', downloadarguments: '14,4', downloadmethod: 'DownloadSampleFile', hide: true },
                { display: 'Actual Link', name: 'actual_link', cssclass: '', controlclass: 'cssAClassDownload cssDClassDownload', coltype: 'download', align: 'left', value: '10', randomValue: '3', downloadarguments: '14,4,11,1,3', downloadmethod: 'DownloadActualFile' },
                { display: 'Sample File', name: 'sample_file', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'Actual File', name: 'actual_file', cssclass: '', controlclass: '', coltype: 'label', align: 'left', hide: true },
                { display: 'OrderStatusID', name: 'orderstatusid', cssclass: '', coltype: 'label', align: 'left', controlclass: '', hide: true },
                { display: 'STATUS', name: 'status', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Download', name: 'download', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Remaining Download', name: 'remaindownload', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Last Download Date', name: 'lastdownload', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],

            buttons: [
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteCustomerDownloadItem', arguments: '2' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { Sku: sku, name: Nm, storeId: storeId, portalId: portalId, cultureName: cultureName, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 16: { sorter: false } }
        });
    }

    function DownloadActualFile(argus) {
        var itemid = argus[1];
        var orderItemId = argus[3];
        var isRemainDownload = '';
        var param = JSON2.stringify({ itemId: itemid, orderItemId: orderItemId, storeId: storeId, portalId: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckRemainingDownload",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isRemainDownload = data.d;
            },
            error: function() {
                isRemainDownload = false;
            }
        });

        if (!isRemainDownload) {
            alert("The Download Exceeds the Maximum Download Limit!");
            return false;
        } else if (argus[2] == 3 && argus[0] > 0 && isRemainDownload) {
            $(".cssDClassDownload_" + argus[4] + "").jDownload({
                root: aspxfilePath,
                dialogTitle: 'ASPXCommerce Download Actual Item:',
                stop: function() {
                    UpdateDownloadCount(itemid, orderItemId);
                }
            });
        } else {
            alert("Your Order Is not Completed :Try Later!!");
            return false;
        }
    }

    function DownloadSampleFile(argus) {
        $(".cssSClassDownload").jDownload({
            root: aspxfilePath,
            dialogTitle: 'ASPXCommerce Download Sample Item:'
        });
    }

    function UpdateDownloadCount(itemid, orderItemId) {
        var itemID = itemid;
        var param = JSON2.stringify({ itemID: itemID, orderItemID: orderItemId, DownloadIP: downloadIP, storeID: storeId, portalID: portalId, userName: userName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateDownloadCount",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindCustomerDownLoadItemsGrid(null, null);
            }
//            ,
//            error: function() {
//                alert("Error!");
//            }
        });
    }

    function DeleteCustomerDownloadItem(tblID, argus) {
        switch (tblID) {
        case "gdvCustomerDownLoadItems":
            var properties = {
                onComplete: function(e) {
                    DeleteCustomerDownloadableItem(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function ConfirmDeleteMultipleOrderItem(Ids, event) {
        DeleteCustomerDownloadableItem(Ids, event);
    }

    function DeleteCustomerDownloadableItem(_OrderItemID, event) {
        if (event) {
            var params = { orderItemID: _OrderItemID, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCustomerDownloadableItem",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    BindCustomerDownLoadItemsGrid(null, null);
                }
            });
        }
        return false;
    }
</script>

<div id="gdvDownLoadableItems_grid">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Customer Downloadable Items"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnDeleteCustDownloadableItem">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                </div>
            </div>
            <div class="cssClassClear">
            </div>
        </div>
        <div class="cssClassGridWrapper">
            <div class="cssClassGridWrapperContent">
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Name:</label>
                                <input type="text" id="txtSearchName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    SKU:</label>
                                <input type="text" id="txtSearchSKU" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchItems() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxUserDashBoardDownloadImage"/>
                </div>
                <div class="log">
                </div>
                <table id="gdvCustomerDownLoadItems" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>