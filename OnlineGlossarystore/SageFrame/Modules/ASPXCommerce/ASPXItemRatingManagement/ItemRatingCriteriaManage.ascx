<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ItemRatingCriteriaManage.ascx.cs"
            Inherits="Modules_ASPXItemRatingManagement_ItemRatingCriteriaManage" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    $(document).ready(function() {
        LoadItemRatingCriteriaStaticImage();
        BindItemRatingCriterialDetails(null, null);
        HideAll();
        $("#divShowItemCriteriaDetails").show();

        $("#btnAddNewCriteria").click(function() {
            $("#<%= lblItemRatingFormTitle.ClientID %>").html("Add New Rating Criteria");
            $("#hdnItemCriteriaID").val(0);
            HideAll();
            $("#divItemCriteriaForm").show();
            $("#txtNewCriteria").val('');
            $("#chkIsActive").attr("checked", true);
        });

        $("#btnSubmitCriteria").click(function() {
            //   AddUpdateCriteria();
            var v = $("#form1").validate({
                messages: {
                    CriteriaTypeName: {
                        required: '*',
                        minlength: "* (at least 2 chars)"
                    }
                }
            });
            if (v.form()) {
                AddUpdateCriteria();
            } else {
                return false;
            }
        });

        $("#btnCancelCriteriaUpdate").click(function() {
            HideAll();
            $("#divShowItemCriteriaDetails").show();

            $('#txtNewCriteria').removeClass('error');
            $('#txtNewCriteria').parents('td').find('label').remove();
        });

        $('#btnDeleteSelectedCriteria').click(function() {
            var criteria_Ids = '';
            //Get the multiple Ids of the item selected
            $(".itemRatingCriteriaChkbox").each(function(i) {
                if ($(this).attr("checked")) {
                    criteria_Ids += $(this).val() + ',';
                }
            });
            if (criteria_Ids != "") {
                var properties = {
                    onComplete: function(e) {
                        DeleteMultipleCriteria(criteria_Ids, e);
                    }
                }
                csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete all selected rating criteria?</p>", properties);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You need to select at least one criteria before you can do this.<br/> To select one or more criteria, just check the box before each criteria.</p>');
            }
        });
    });

    function LoadItemRatingCriteriaStaticImage() {
        $('#ajaxItemRatingCriteriaImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }


    function DeleteMultipleCriteria(Ids, event) {
        DeleteRatingCriteria(Ids, event);
    }

    function HideAll() {
        $("#divShowItemCriteriaDetails").hide();
        $("#divItemCriteriaForm").hide();
    }

    function AddUpdateCriteria() {
        var criteriaName = $("#txtNewCriteria").val();
        var criteriaId = $("#hdnItemCriteriaID").val();
        //$("#hdnItemCriteriaID").val();
        var isActive = $("#chkIsActive").attr("checked");
//        if (criteriaName == "") {
//            alert("Enter a criteria");
//            return false;
//        }
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/AddUpdateItemCriteria",
            data: JSON2.stringify({ ID: criteriaId, criteria: criteriaName, IsActive: isActive, storeID: storeId, portalID: portalId, cultureName: cultureName, userName: userName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                BindItemRatingCriterialDetails(null, null);
                HideAll();
                $("#divShowItemCriteriaDetails").show();
            },
            error: function() {
                alert("error");
            }
        });
    }

    function BindItemRatingCriterialDetails(criteria, isAct) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvItemRatingCriteria_pagesize").length > 0) ? $("#gdvItemRatingCriteria_pagesize :selected").text() : 10;

        $("#gdvItemRatingCriteria").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'ItemRatingCriteriaManage',
            colModel: [
                { display: 'Rating Criteria ID', name: 'ratingcriteria_id', cssclass: 'cssClassHeadCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'itemRatingCriteriaChkbox', elemDefault: false, controlclass: 'itemsHeaderChkbox' },
                { display: 'Rating Criteria', name: 'ratingcriteria', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Added On', name: 'added_on', cssclass: 'cssClassHeadDate', controlclass: '', coltype: 'label', align: 'left', type: 'date', format: 'yyyy/MM/dd' },
                { display: 'Is Active', name: 'isactive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', coltype: 'label', align: 'center' }
            ],
            buttons: [
                { display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditItemRatingCriteria', arguments: '1,3' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteItemRatingCriteria', arguments: '' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { ratingCriteria: criteria, isActive: isAct, storeId: storeId, portalId: portalId, cultureName: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 4: { sorter: false } }
        });
    }

    Boolean.parse = function(str) {
        switch (str.toLowerCase()) {
        case "yes":
            return true;
        case "no":
            return false;
        default:
            return false;
        }
    };

    function EditItemRatingCriteria(tblID, argus) {
        switch (tblID) {
        case "gdvItemRatingCriteria":
            $("#<%= lblItemRatingFormTitle.ClientID %>").html("Edit Rating Criteria: '" + argus[3] + "'");
            $("#hdnItemCriteriaID").val(argus[0]);
            $("#txtNewCriteria").val(argus[3]);
            $("#chkIsActive").attr("checked", Boolean.parse(argus[4]));
            HideAll();
            $("#divItemCriteriaForm").show();
            break;
        default:
            break;
        }
    }

    function DeleteItemRatingCriteria(tblID, argus) {
        switch (tblID) {
        case "gdvItemRatingCriteria":
            var properties = {
                onComplete: function(e) {
                    DeleteRatingCriteria(argus[0], e);
                }
            }
            csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete?</p>", properties);
            break;
        default:
            break;
        }
    }

    function DeleteRatingCriteria(criteriaId, event) {
        if (event) {
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteItemRatingCriteria",
                data: JSON2.stringify({ IDs: criteriaId, storeID: storeId, portalID: portalId, userName: userName }),
                contentType: "application/json;charset=utf-8",
                dataType: "json",
                success: function() {
                    BindItemRatingCriterialDetails(null, null);
                },
                error: function() {
                    alert("error");
                }
            });
        }
        return false;
    }

    function SearchCriteria() {
        var criteria = $.trim($("#txtSearchCriteria").val());
        var isAct = $("#ddlIsActive").val() == "" ? null : $("#ddlIsActive").val() == "True" ? true : false;
        if (criteria.length < 1) {
            criteria = null;
        }
        BindItemRatingCriterialDetails(criteria, isAct);
    }
</script>

<div id="divShowItemCriteriaDetails">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblTitle" runat="server" Text="Manage Rating Criteria"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" class="" id="btnDeleteSelectedCriteria">
                            <span><span>Delete All Selected</span></span></button>
                    </p>
                    <%--<p> <input type="button" class="" id="btnDeactivateSelected" value="Deactivate All Selected" /> </p>--%>
                    <p>
                        <button type="button" class="" id="btnAddNewCriteria">
                            <span><span>Add New Criteria</span></span></button>
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
                <div class="cssClassSearchPanel cssClassFormWrapper">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                            <td>
                                <label class="cssClassLabel">
                                    Criteria:</label>
                                <input type="text" id="txtSearchCriteria" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Is Active:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchCriteria() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxItemRatingCriteriaImage" />
                </div>
                <div class="log">
                </div>
                <table id="gdvItemRatingCriteria" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<div id="divItemCriteriaForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblItemRatingFormTitle" runat="server"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table border="0" width="100%" id="tblEditReviewForm" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblCriteria" runat="server" Text="Criteria:" CssClass="cssClassLabel"> </asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" id="txtNewCriteria" name="CriteriaTypeName" class="cssClassNormalTextBox required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblIsActive" runat="server" Text="Is Active:" CssClass="cssClassLabel"></asp:Label>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="checkbox" id="chkIsActive" class="cssClassCheckBox" />
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button type="button" id="btnCancelCriteriaUpdate">
                    <span><span>Cancel</span></span></button>
            </p>
            <p>
                <button type="button" id="btnSubmitCriteria" />
                <span><span>Save</span></span> </button>
            </p>
        </div>
        <input type="hidden" id="hdnItemCriteriaID" />
    </div>
</div>