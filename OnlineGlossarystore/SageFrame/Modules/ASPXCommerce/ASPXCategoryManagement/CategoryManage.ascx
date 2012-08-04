<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoryManage.ascx.cs"
            Inherits="Modules_ASPXCategoryManagement_CategoryManage" %>

<script type="text/javascript">

    var arrTree = [];

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var treeHTML = '';
    var CategoryList = null;
    var catGroup;
    var DatePickerIDs = new Array();
    var FileUploaderIDs = new Array();
    var htmlEditorIDs = new Array();
    var from = '';
    var to = '';

    $(document).ready(function() {
        GetCategoryAll();
        GetFormFieldList();
    });

    function GetCategoryAll() {
        var treeHTML = '';
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryAll",
            data: JSON2.stringify({ isActive: true, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                if (data.d.length > 0) {
                    CategoryList = data.d;
                    treeHTML += '<ul id="categoryTree">';
                    var deepLevel = 0;
                    $.each(CategoryList, function(i, item) {
                        if (item.CategoryLevel == 0) {
                            treeHTML += '<li id="category_' + item.CategoryID + '" class="file-folder"><b>' + item.CategoryName + '</b>';
                            htmlChild = BindTreeViewChild(item.CategoryID, item.CategoryName, item.CategoryID, item.CategoryLevel + 1, deepLevel);
                            if (htmlChild != "") {
                                treeHTML += "<ul>" + htmlChild + "</ul>";
                            }
                            treeHTML += "</li>";
                        }
                    });
                    treeHTML += '</ul>';
                    treeHTML += '<div class="cssClassButtonWrapper"><p><button type="button" id="btnCatTreeSave" onclick="SaveChangesCategoryTree()"><span><span>Save Changes</span></span></button></p></div>'
                    $("#CategoryTree_Container").html(treeHTML);
                    AddDragDrop();
                } else {
                    $("#CategoryTree_Container").html("<span class=\"cssClassNotFound\">This store has no Category listed yet!</span>");
                }
            },
            error: function(err) {
                csscody.error('<h1>Error Message</h1><p>' + JSON2.stringify(err) + '</p>');
            }
        });
    }

    function BindTreeViewChild(CategoryID, CategoryName, ParentID, CategoryLevel, deepLevel) {
        deepLevel = deepLevel + 1;
        var hasChild = false;
        var html = '';
        $.each(CategoryList, function(index, item) {
            if (item.CategoryLevel == CategoryLevel) {
                if (item.ParentID == ParentID) {
                    html += '<li id="category_' + item.CategoryID + '" class="file-folder"><b>' + item.CategoryName + '</b>';
                    htmlChild = BindTreeViewChild(item.CategoryID, item.CategoryName, item.CategoryID, item.CategoryLevel + 1, deepLevel);
                    if (htmlChild != "") {
                        html += "<ul>" + htmlChild + "</ul>";
                    }
                    html += '</li>';
                }
            }
        });
        return html;
    }

    function AddDragDrop() {
        $('#categoryTree').tree({
            expand: '*',
            //For Category management to have multiple level
            //            // drop options: object or array of object
            droppable: [
                {
                    element: 'li.ui-tree-node',
                    tolerance: 'around',
                    aroundTop: '25%',
                    aroundBottom: '25%',
                    aroundLeft: 0,
                    aroundRight: 0
                },
                {
                    element: 'li.ui-tree-list',
                    tolerance: 'around',
                    aroundTop: '25%',
                    aroundBottom: '25%',
                    aroundLeft: 0,
                    aroundRight: 0
                }
            ],
            drop: function(event, ui) {
                $('.ui-tree-droppable').removeClass('ui-tree-droppable ui-tree-droppable-top ui-tree-droppable-center ui-tree-droppable-bottom');
                //debugger;
                //alert(ui.target.getJSON(ui.droppable));
                switch (ui.overState) {
                case 'top':
                    ui.target.before(ui.sender.getJSON(ui.draggable), ui.droppable);
                    ui.sender.remove(ui.draggable);
                        //$(ui.droppable).parent('li').addClass('ui-tree-expanded');
                    break;
                case 'bottom':
                    ui.target.after(ui.sender.getJSON(ui.draggable), ui.droppable);
                    ui.sender.remove(ui.draggable);
                        //$(ui.droppable).parent('li').addClass('ui-tree-expanded');
                    break;
                case 'center':
                    ui.target.append(ui.sender.getJSON(ui.draggable), ui.droppable);
                    ui.sender.remove(ui.draggable);
                    $(ui.droppable).parent('li').addClass('ui-tree-expanded');
                    $(ui.droppable).parent('li').removeClass('ui-tree-list');
                    $(ui.droppable).parent('li').addClass('ui-tree-node');
                    break;
                }
            },
            over: function(event, ui) {
                $(ui.droppable).addClass('ui-tree-droppable');
            },
            out: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable');
            },
            overtop: function(event, ui) {
                $(ui.droppable).addClass('ui-tree-droppable-top');
            },
            overcenter: function(event, ui) {
                $(ui.droppable).addClass('ui-tree-droppable-center');
            },
            overbottom: function(event, ui) {
                $(ui.droppable).addClass('ui-tree-droppable-bottom');
            },
            outtop: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-top');
            },
            outcenter: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-center');
            },
            outbottom: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-bottom');
            },
            click: function(event, ui) {
                var id = ui.draggable[0].id;
                id = ui.draggable[0].id.replace( /[^0-9]/gi , '');
                GetCategoryByCagetoryID(id);
                ResetImageTab();
            }
        });
    }

    function GetCategoryByCagetoryID(catID) {
        isAlreadyClickAddSubCategory = false;
        $("#lblCategoryID").html(catID);
        $("#CagetoryMgt_categoryID").val(catID);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryByCategoryID",
            data: JSON2.stringify({ categoryID: catID, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                var searchTable = '';
                searchTable += '<table cellspacing="0" cellpadding="0" border="0" width="100%"><tr>';
                searchTable += '<td><label class="cssClassLabel">SKU:</label><input type="text" id="txtCategoryItemSKU" name="txtCategoryItemSKU" class="cssClassTextBoxSmall"/></td>';
                searchTable += '<td><label class="cssClassLabel">Name:</label><input type="text" id="txtCategoryItemName" name="txtCategoryItemName" class="cssClassTextBoxSmall" /></td>';
                searchTable += '<td><label class="cssClassLabel">Price From:</label><input type="text" id="txtCategoryItemPriceFrom" name="txtCategoryItemPriceFrom" class="cssClassTextBoxSmall" /></td>';
                searchTable += '<td><label class="cssClassLabel">Price To:</label><input type="text" id="txtCategoryItemPriceTo" name="txtCategoryItemPriceTo" class="cssClassTextBoxSmall" /></td>';
                searchTable += '<td><div class="cssClassButtonWrapper cssClassPaddingNone"> <p><button type="button" onclick="SearchCategoryItems()"><span><span>Search</span></span></button></p></div></td></tr></table>';
                $("#ItemSearchPanel").html(searchTable);
                for (var i = 0; i < editorList.length; i++) {
                    editorList[i].Editor.setData('');
                }
                EditCategory(data.d);
                $('#categoryReset').hide();
                BindCategoryItemsGrid(catID, '', '', null, null);
                $("#gdvCategoryItems .categoryCheckBox").each(function(i) {
                    $(this).attr("checked", "checked")
                });
            }
        });
    }

    function EditCategory(data) {
        $("#CategorManagement_TabContainer").find("input[type=reset]").click();
        $(".error").removeClass("error");
        $(".diverror").removeClass("diverror");
        $.each(data, function(index, item) {
            if (index == 0) {
                $("#CagetoryMgt_categoryID").val(item.CategoryID);
                $("#CagetoryMgt_parentCagetoryID").val(item.ParentID);
            }
            FillCategoryForm(item);
        });
        var $tabs = $('#CategorManagement_TabContainer').tabs(); // first tab selected
        $tabs.tabs('select', 0);
    }

    function FillCategoryForm(item) {
        //item.AttributeID, item.AttributeName, item.InputTypeID, item.BooleanValue, item.INTValue, item.DATEValue, item.DECIMALValue, item.FILEValue, item.OPTIONValues, item.ValidationTypeID, item.IsUnique, item.IsRequired
        var attNameNoSpace = "_" + item.AttributeName.replace(' ', '-');
        attNameNoSpace = '';
        var id = item.AttributeID + '_' + item.InputTypeID + '_' + item.ValidationTypeID + '_' + item.IsRequired + attNameNoSpace;
        var val;
        switch (item.InputTypeID) {
        case 1:
//TextField
            $("#" + id).val(unescape(item.NVARCHARValue));
            $("#" + id).removeClass('hint');
            break;
        case 2:
//TextArea
            $("#" + id).val(item.TEXTValue);
            for (var i = 0; i < editorList.length; i++) {
                if (editorList[i].ID == id + "_editor") {
                    editorList[i].Editor.setData(Encoder.htmlDecode(item.TEXTValue));
                }
            }
            $("#" + id).removeClass('hint');
            break;
        case 3:
//Date
            var test = 'new ' + item.DATEValue.replace( /[/]/gi , '');
            date = eval(test);
            $("#" + id).val(formatDate(date, "yyyy/M/d"));
            $("#" + id).removeClass('hint');
            break;
        case 4:
//Boolean
            if (item.BooleanValue) {
                $("#" + id).attr("checked", "checked");
            } else {
                $("#" + id).removeAttr("checked");
            }

            break;
        case 5:
//MultipleSelect
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("#" + id + " option[value=" + vals[i] + "]").attr("selected", "selected");
            });

            break;
        case 6:
//DropDown
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("#" + id + " option[value=" + vals[i] + "]").attr("selected", "selected");
            });
            break;
        case 7:
//Price
            $("#" + id).val(item.DECIMALValue);
            $("#" + id).removeClass('hint');
            break;
        case 8:
//File
//alert(item.FILEValue);
            var d = $("#" + id).parent();
            var filePath = item.FILEValue;
            var fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
            if (filePath != "") {
                var fileExt = (-1 !== filePath.indexOf('.')) ? filePath.replace( /.*[.]/ , '') : '';
                myregexp = new RegExp("(jpg|jpeg|jpe|gif|bmp|png|ico)", "i");
                if (myregexp.test(fileExt)) {
                    $(d).find('span.response').html('<div class="cssClassLeft"><img src="' + aspxRootPath + filePath + '" class="uploadImage" height="90px" width="100px" /></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    //alert($(d).find('span.response').html());
                } else {
                    $(d).find('span.response').html('<div class="cssClassLeft"><a href="' + aspxRootPath + filePath + '" class="uploadFile" target="_blank">' + fileName + '</a></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                }
                $(d).find('input[type="hidden"]').val(filePath);
            }
            break;
        case 9:
//Radio
            if (item.OPTIONValues == "") {
                $("#" + id).removeAttr("checked");
            } else {
                $("#" + id).attr("checked", "checked");
            }
            break;
        case 10:
//RadioButtonList
            $("input[value=" + item.OPTIONValues + "]:radio").attr("checked", "checked");
            break;
        case 11:
//CheckBox
            if (item.OPTIONValues == "") {
                $("#" + id).removeAttr("checked");
            } else {
                $("#" + id).attr("checked", "checked");
            }
            break;
        case 12:
//CheckBoxList
            var inputs = $("input[name=" + id + "]");
            $.each(inputs, function(i) {
                $(this).removeAttr("checked");
            });
            val = item.OPTIONValues;
            vals = val.split(',');
            $.each(vals, function(i) {
                $("input[value=" + vals[i] + "]").attr("checked", "checked");
            });
            break;
        case 13:
//Password
            $("#" + id).val(item.NVARCHARValue);
            $("#" + id).removeClass('hint');
            break;
        }
    }

    function ClickToDeleteImage(objImg) {
        $(objImg).closest('span').html('');
        return false;
    }

    function BindCategoryItemsGrid(categoryId, itemSKU, itemName, itemPriceFrom, itemPriceTo) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvCategoryItems_pagesize").length > 0) ? $("#gdvCategoryItems_pagesize :selected").text() : 10;

        var isChecked = false;
        if (categoryId * 1 > 0) {
            isChecked = true;
        }
        $("#gdvCategoryItems").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetCategoryItems',
            colModel: [
                { display: 'ItemID', name: 'id', cssclass: 'cssClassCheckBox', coltype: 'checkbox', align: 'center', elemClass: 'categoryCheckBox', elemDefault: isChecked, controlclass: 'mainchkbox2' },
                { display: 'Item ID', name: 'item_id', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'center' },
                { display: 'SKU', name: 'sku', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Name', name: 'item_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Price', name: 'price', cssclass: 'cssClassHeadNumber', controlclass: '', coltype: 'label', align: 'left' }
            ],
            txtClass: 'cssClassNormalTextBox',
            rp: perpage,
            nomsg: "No Records Found!",
            param: { categoryID: categoryId, sku: itemSKU, name: itemName, priceFrom: itemPriceFrom, priceTo: itemPriceTo, storeID: storeId, portalID: portalId, userName: userName, culture: cultureName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false } }
        });
    }

    function ResetImageTab() {
        var tabHeading = $(".ui-tabs-panel").find('div>.response');
        $.each(tabHeading, function(i) {
            tabHeading.html('');
            tabHeading.siblings('input').val('');
        });
    }

    function SaveChangesCategoryTree() {
        arrTree = [];
        var saveString = $.toJSON(parseTree($("#categoryTree")));
        data = '{"storeID":' + storeId + ', "portalID" : ' + portalId + ', "categoryIDs":' + saveString + ', "userName" : "' + userName + '"}';
        var url = aspxservicePath + "ASPXCommerceWebService.asmx/SaveChangesCategoryTree";
        PostData(data, url, "Post", SaveChangesCategoryTreeSuccess, errorFn);
    }

    function parseTree(ul) {
        var strChild = "";
        var saveString = "";
        ul.children("li").each(function() {
            if ($(this).parents("li").length > 0) {
                var strChild = $(this).attr("id").replace( /[^0-9]/gi , '');

                var strcc = "";
                $(this).parents("li").each(function() {
                    if (strcc == "") {
                        strcc = $(this).attr("id").replace( /[^0-9]/gi , '') + '/' + strcc + '/';
                    } else {
                        strcc = $(this).attr("id").replace( /[^0-9]/gi , '') + '/' + strcc;
                    }
                });
                strcc = strcc.substr(0, strcc.length - 1);
                strChild = '/' + strcc + strChild;
            } else {
                strChild = '/' + $(this).attr("id").replace( /[^0-9]/gi , '');
            }
            arrTree.push(strChild);

            var subtree = $(this).children("ul");
            if (subtree.size() > 0)
                parseTree(subtree);
        });
        return arrTree.join('#');
    }

    function PostData(data, url, method, successFn, errorFn) {
        $.ajax({
            url: url,
            type: method,
            contentType: "application/json",
            data: data,
            dataType: "json",
            success: successFn,
            error: errorFn
        });
    }

    function errorFn(xhr, status) {
        var err = null;
        if (xhr.readyState == 4) {
            var res = xhr.responseText;
            if (res && res.charAt(0) == '{' && status != "parsererror")
                var err = JSON.parse(res);
            if (!err) {
                if (xhr.status && xhr.status != 200)
                    err = new CallbackException(xhr.status + " " + xhr.statusText);
                else {
                    if (status == "parsererror")
                        status = "Unable to parse JSON response.";
                    else if (status == "timeout")
                        status = "Request timed out.";
                    else if (status == "error")
                        status = "Unknown error";
                    err = new CallbackException("Callback Error: " + status);
                }
                err.detail = res;
            }
        }
        if (!err)
            err = new CallbackException("Callback Error: " + status);
        csscody.error('<h1>Error Message</h1><p>Failed to save item. ' + err + '</p>');
    }

    function SaveChangesCategoryTreeSuccess(response) {
        var res = eval(response.d);
        if (res.returnStatus > 0) {
            var jEl = $("#divMessage");
            jEl.html(res.Message).fadeIn(1000);
            setTimeout(function() { jEl.fadeOut(1000) }, 5000);
        } else {
            csscody.error('<h1>Error Message</h1><p>' + res.errorMessage + '</p>');
        }
    }

    var FormCount = new Array();

    function GetFormFieldList() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryFormAttributes",
            data: JSON2.stringify({ categoryID: 0, portalID: portalId, storeID: storeId, userName: userName, culture: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                CreateForm(data.d);
                BindCategoryItemsGrid(0, '', '', null, null);
            }
        });
    }

    function CreateForm(CategoryFormFields) {
        var strDyn = '';
        var attGroup = new Array();

        $.each(CategoryFormFields, function(index, item) {
            var isGroupExist = false;
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == item.GroupID) {
                    isGroupExist = true;
                    break;
                }
            }
            if (!isGroupExist) {
                attGroup.push({ key: item.GroupID, value: item.GroupName, html: '' });
            }
        });

        $.each(CategoryFormFields, function(index, item) {
            strDynRow = createRow(item.AttributeID, item.AttributeName, item.InputTypeID, item.InputTypeValues != "" ? eval(item.InputTypeValues) : '', item.DefaultValue, item.Length, item.ValidationTypeID, item.IsEnableEditor, item.IsUnique, item.IsRequired, item.ToolTip);
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == item.GroupID) {
                    attGroup[i].html += strDynRow;
                }
            }
        });
        CreateTabPanel(attGroup);
        $("#categoryReset").bind('click', function() {
            ResetImageTab();
        });
    }

    var hdnCatNameTxtBox = "";

    function createRow(attID, attName, attType, attTypeValue, attDefVal, attLen, attValType, isEditor, isUnique, isRequired, attToolTip) {
        var retString = '';
        var attNameNoSpace = "_" + attName.replace(new RegExp(" ", "g"), '-');
        attNameNoSpace = '';
        retString += '<tr><td class="cssClassTableLeftCol"><label class="cssClassLabel">' + attName + ': </label></td>';
        switch (attType) {
        case 1:
//TextField
            if (attID == 1) { //Name of Category
                hdnCatNameTxtBox = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                // alert( $("#hdnCatNameTxtBox").val());
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + CreateValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + '" onblur="CheckUniqueness(this.value)"/>'
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            } else {
                retString += '<td class="cssClassTableRightCol"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text" maxlength="' + attLen + '"  class="cssClassNormalTextBox dynFormItem ' + CreateValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '" title="' + attToolTip + ' "/>'
                retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            }
            break;
        case 2:
//TextArea
            var editorDiv = '';
            if (isEditor) {
                htmlEditorIDs[htmlEditorIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + "_editor";
                editorDiv = '<div id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_editor"></div>';
            }
            retString += '<td><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><textarea id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" ' + ((isEditor == true) ? ' style="display: none !important;" ' : '') + ' rows="' + attLen + '"  class="cssClassTextArea dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" title="' + attToolTip + '">' + attDefVal + '</textarea>' + editorDiv + '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 3:
//Date
            if (attID == 22 || attID == 23) {

                switch (attID) {
                case 22:
                    DatePickerIDs[DatePickerIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                    retString += '<td class="cssClassBigBox"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text"  class="cssClassNormalTextBox dynFormItem activefrom' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
                    from = "#" + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                    break;
                case 23:
                    DatePickerIDs[DatePickerIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                    retString += '<td class="cssClassBigBox"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text"  class="cssClassNormalTextBox dynFormItem activeto' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
                    to = "#" + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                    break;
                }
                break;
            } else {

                DatePickerIDs[DatePickerIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
                retString += '<td class="cssClassBigBox"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text"  class="cssClassNormalTextBox dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span><p><!-- /field --></p></div></td>';
                break;
            }
        case 4:
//Boolean
            retString += '<td class="cssClassBigBox"><div class="cssClassCheckBox"><div class="field ' + (isRequired == true ? "required" : "") + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" value="1" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="checkbox"  class="cssClassCheckBox dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            break;
        case 5:
//MultipleSelect
            retString += '<td><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '"  title="' + attToolTip + '" size="' + attLen + '" multiple class="cssClassMultiSelect dynFormItem" >';
            if (attTypeValue.length > 0) {
                for (var i = 0; i < attTypeValue.length; i++) {
                    var val = attTypeValue[i];
                    //var vals = attTypeValue[i].split(':');
                    retString += '<option value="' + val.value + '">' + val.text + '</option>';
                }
            }
            retString += '</select><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 6:
//DropDown
            retString += '<td><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><select id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '"  title="' + attToolTip + '" class="cssClassDropDown dynFormItem" >';
            var arr = new Array()
            for (var i = 0; i < attTypeValue.length; i++) {
                var val = attTypeValue[i];
                retString += '<option value="' + val.value + '">' + val.text + '</option>';
            }
            retString += '</select><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 7:
//Price
            retString += '<td class="cssClassBigBox"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attDefVal + '"  title="' + attToolTip + '"/><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 8:
//File                  
            FileUploaderIDs[FileUploaderIDs.length] = attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace;
            retString += '<td><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><div class="' + attDefVal + '" name="Upload/temp" lang="' + attLen + '"><input type="hidden" id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_hidden" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_hidden" value="" class="cssClassBrowse dynFormItem"/>';
            retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="file" class="cssClassBrowse dynFormItem ' + CreateValidation(attID, attType, attValType, isUnique, isRequired) + '" title="' + attToolTip + '" />';
                //retString += '<span id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_span" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="file" class="cssClassBrowse">Browse</span>';
            retString += ' <span class="response"></span></div><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        case 9:
//Radio
            if (attDefVal) {
                retString += '<td><div class="cssClassRadioBtn"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" checked value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="radio"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + (attDefVal.toString().length > 0 ? attDefVal.toString() : "") + '"  title="' + attToolTip + '"/><label>' + attName + '</label><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            } else {
                retString += '<td><div class="cssClassRadioBtn"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="radio"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + (attDefVal.toString().length > 0 ? attDefVal.toString() : "") + '"  title="' + attToolTip + '"/><label>' + attName + '</label><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            }
            break;
        case 10:
//RadioButtonList
            retString += '<td><div class="cssClassRadioBtn"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">'
            for (var i = 0; i < attTypeValue.length; i++) {
                var option = attTypeValue[i];
                if (i == 0) {
                    retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_' + i + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="radio"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + option.value + '" checked /><label>' + option.text + '</label>';
                } else {
                    if (option.isDefault) {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_' + i + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="radio"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + option.value + '" checked /><label>' + option.text + '</label>';
                    } else {
                        retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_' + i + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="radio"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + option.value + '" /><label>' + option.text + '</label>';
                    }
                }
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            break;
        case 11:
//CheckBox
            retString += '<td><div class="cssClassRadioBtn"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="checkbox"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + attID + '"  /><label>' + attName + '</label><span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            break;
        case 12:
//CheckBoxList
            retString += '<td><div class="cssClassRadioBtn"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '">'
            for (var i = 0; i < attTypeValue.length; i++) {
                var option = attTypeValue[i];
                if (option.isDefault) {
                    retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_' + i + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="checkbox"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + option.value + '" checked /><label>' + option.text + '</label>';
                } else {
                    retString += '<input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '_' + i + '" value="' + attID + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="checkbox"  class="text dynFormItem ' + CreateValidation(attID + attNameNoSpace, attType, attValType, isUnique, isRequired) + '" value="' + option.value + '" /><label>' + option.text + '</label>';
                }
            }
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></div></td>';
            break;
        case 13:
//Password
            retString += '<td class="cssClassBigBox"><div class="field ' + GetValidationTypeClasses(attValType, isUnique, isRequired) + '"><input id="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" name="' + attID + '_' + attType + '_' + attValType + '_' + isRequired + attNameNoSpace + '" type="text" maxlength="' + attLen + '"  class="text dynFormItem ' + CreateValidation(attID + '_' + attName, attType, attValType, isUnique, isRequired) + ' Password" value="' + attDefVal + '" title="*"/>'
            retString += '<span class="iferror">' + GetValidationTypeErrorMessage(attValType) + '</span></div></td>';
            break;
        default:
            break;
        }
        retString += '</tr>';
        return retString;
    }

    function activatedatetimevalidation() {
        if (to != '') {

            $(to).bind('change', function() {

                if (Date.parse($(from).val()) < Date.parse($(to).val())) {
                } else {
                    alert('you must select higher date than active from');
                    $(to).val('');
                    return false;
                }

            });
        }
    }

    function GetValidationTypeClasses(attValType, isUnique, isRequired) {
        var returnClass = ''
        if (isRequired == true) {
            returnClass = "required";
        }
        return returnClass;
    }

    function GetValidationTypeErrorMessage(attValType) {
        var retString = ''
        switch (attValType) {
        case 1:
//AlphabetsOnly
            retString = 'Alphabets Only';
            break;
        case 2:
//AlphaNumeric
            retString = 'AlphaNumeric';
            break;
        case 3:
//DecimalNumber
            retString = 'Decimal Number';
            break;
        case 4:
//Email
            retString = 'Email Address';
            break;
        case 5:
//IntegerNumber
            retString = 'Integer Number';
            break;
        case 6:
//Price
            retString = 'Price';
            break;
        case 7:
//WebURL
            retString = 'Web URL';
            break;
        }
        return retString;
    }

    function CreateValidation(id, attType, attValType, isUnique, isRequired) {
        var retString = '';
        var validationClass = '';

        switch (attValType) {
        case 1:
//AlphabetsOnly
            validationClass += 'verifyAlphabetsOnly" ';
            break;
        case 2:
//AlphaNumeric
            validationClass += 'verifyAlphaNumeric" ';
            break;
        case 3:
//DecimalNumber
            validationClass += 'verifyDecimal" ';
            break;
        case 4:
//Email
            validationClass += 'verifyEmail';
            break;
        case 5:
//IntegerNumber
            validationClass += 'verifyInteger';
            break;
        case 6:
//Price
            validationClass += 'verifyPrice';
            break;
        case 7:
// URL
            validationClass += 'verifyUrl';
            break;
        }

        retString = validationClass;
        return retString;
    }

    function CreateTabPanel(attGroup) {
        if (FormCount) {
            FormCount = new Array();
        }
        var FormID = "form_" + (FormCount.length * 10 + Math.floor(Math.random() * 10));
        FormCount[FormCount.length] = FormID;
        var dynHTML = '';
        var tabs = '';
        var tabBody = '';
        dynHTML += '<div class="cssClassTabPanelTable">';

        dynHTML += '<div id="CategorManagement_TabContainer" class="cssClassTabpanelContent">';
        dynHTML += '<ul>';
        for (var i = 0; i < attGroup.length; i++) {
            tabs += '<li><a href="#CategoryTab-' + attGroup[i].key + '"><span>' + attGroup[i].value + '</span></a>';
            tabBody += '<div id="CategoryTab-' + attGroup[i].key + '"><table width="100%" border="0" cellpadding="0" cellspacing="0">' + attGroup[i].html + '</table></div></li>';
        }
        tabs += '<li><a href="#CategoryTab-' + eval(attGroup.length + 1) + '"><span>Category Products</span></a>';

        tabBody += '<div id="CategoryTab-' + eval(attGroup.length + 1) + '">';

        tabBody += '<div class="cssClassCommonBox Curve">';
        tabBody += '<div class="cssClassGridWrapper"><div class="cssClassGridWrapperContent"><div id="ItemSearchPanel" class="cssClassSearchPanel cssClassFormWrapper"></div><div class="loading"><img src="' + aspxTemplateFolderPath + '/images/ajax-loader.gif" /></div><div class="log"></div>';
        tabBody += '<table id="gdvCategoryItems" cellspacing="0" cellpadding="0" border="0" width="100%"></table></div></div>';
        tabBody += '</div></div></li>';

        dynHTML += tabs;
        dynHTML += '</ul>';
        dynHTML += tabBody;
        var frmIDQuoted = "'" + FormID + "'";
        var buttons = '<div class="cssClassButtonWrapper"><p><button type="button" id="saveForm" onclick="submitForm(' + frmIDQuoted + ')"><span><span>Save</span></span></button> </p>';
        buttons += '<p><input id="categoryReset" type="reset" value="Reset" class="cssClassButtonSubmit" /></p><p><button type="button" onclick="DeleteCategory()" ><span><span>Delete</span></span></button></div><div class="cssClassClear"></div>';
        $("#dynForm").html('<div id="' + FormID + '">' + dynHTML + buttons + '</div>');

        $('#CategorManagement_TabContainer').tabs({ fx: [null, { height: 'show', opacity: 'show' }] });

        EnableFormValidation(FormID);
        EnableDatePickers();
        EnableFileUploaders();
        EnableHTMLEditors();

        var searchTable = '';
        searchTable += '<table cellspacing="0" cellpadding="0" border="0" width="100%"><tr>';
        searchTable += '<td><label class="cssClassLabel">SKU:</label><input type="text" id="txtCategoryItemSKU" name="txtCategoryItemSKU" class="cssClassTextBoxSmall"/></td>';
        searchTable += '<td><label class="cssClassLabel">Name:</label><input type="text" id="txtCategoryItemName" name="txtCategoryItemName" class="cssClassTextBoxSmall" /></td>';
        searchTable += '<td><label class="cssClassLabel">Price From:</label><input type="text" id="txtCategoryItemPriceFrom" name="txtCategoryItemPriceFrom" class="cssClassTextBoxSmall" /></td>';
        searchTable += '<td><label class="cssClassLabel">Price To:</label><input type="text" id="txtCategoryItemPriceTo" name="txtCategoryItemPriceTo" class="cssClassTextBoxSmall" /></td>';
        searchTable += '<td><div class="cssClassButtonWrapper cssClassPaddingNone"> <p><button type="button" onclick="SearchCategoryItems()"><span><span>Search</span></span></button></p></div></td></tr></table>';
        $("#ItemSearchPanel").html(searchTable);
        activatedatetimevalidation();
    }

    function DeleteCategory() {
        var categoryID = $("#CagetoryMgt_categoryID").val() * 1;
        if (categoryID > 0) {
            var cofig = {
                onComplete: function(e) {
                    if (e) {
                        data = '{"storeID":' + storeId + ', "portalID" : ' + portalId + ', "categoryID":"' + categoryID + '", "userName" : "' + userName + '", "culture": "' + cultureName + '"}';
                        var url = aspxservicePath + "ASPXCommerceWebService.asmx/DeleteCategory";
                        PostData(data, url, "Post", deleteCategorySuccess, errorFn);
                    }
                }
            }
            csscody.confirm("<h1>Confirmation Message</h1><p>Are you sure to delete?</p>", cofig);
        } else {
            csscody.alert("<h1>Alert Message</h1><p>Select the category first.</p>");
        }
    }

    function deleteCategorySuccess(response) {
        var res = eval(response.d);
        if (res.returnStatus > 0) {
            var jEl = $("#divMessage");
            jEl.html(res.Message).fadeIn(1000);
            setTimeout(function() { jEl.fadeOut(1000) }, 5000);
            $("#CagetoryMgt_categoryID").val(0);
            $("#CagetoryMgt_parentCagetoryID").val(0);
            $("#CategoryTree_Container").html('');
            GetCategoryAll();
            $("#CategorManagement_TabContainer input[type=reset]").click();
            BindCategoryItemsGrid(0, '', '', null, null);
            ResetHTMLEditors();
            var $tabs = $('#CategorManagement_TabContainer').tabs(); // first tab selected
            $tabs.tabs('select', 0);
        } else {
            csscody.error('<h1>Error Message</h1><p>' + res.errorMessage + '</p>');
        }
    }

    function submitForm(frmID) {
        var frm = $("#" + frmID);
        for (var i = 0; i < editorList.length; i++) {
            var id = String(editorList[i].ID);
            var textArea = $("#" + id.replace("_editor", ""));
            textArea.val(Encoder.htmlEncode(editorList[i].Editor.getData()));
        }
        // Prevent submit if validation fails   
        var catNameTxtBoxID = hdnCatNameTxtBox; //$("input["hidden"]#hdnCatNameTxtBox").val();
        var CatName = $("#" + catNameTxtBoxID).val();
        //alert(checkForm(frm) && CheckUniqueness($("#"+catNameTxtBoxID+"").val()));        
        if (checkForm(frm) && CheckUniqueness(CatName)) { //$(".cssClassError").html().length == 0
            SaveCategory("#" + frmID);
        } else {
            var errorTabName = $("#CategorManagement_TabContainer").find('.diverror:first').parents('div').attr("id");
            var $tabs = $('#CategorManagement_TabContainer').tabs();
            $tabs.tabs('select', errorTabName);
            return false;
        }
    }

    function SaveCategory(formID) {
        var catID = $("#CagetoryMgt_categoryID").val();
        var parID = $("#CagetoryMgt_parentCagetoryID").val();
        var item_ids = '';
        $("#gdvCategoryItems .categoryCheckBox").each(function(i) {
            if ($(this).attr("checked")) {
                item_ids += $(this).val() + ',';
            }
        });
        if (item_ids.length > 0) {
            item_ids = item_ids.substr(0, item_ids.length - 1);
        }
        arForm = '{"storeID":"' + storeId + '", "portalID":"' + portalId + '", "categoryID":"' + catID + '","parentID":"' + parID + '","formVars":' + SerializeForm(formID) + ',"selectedItems" : "' + item_ids + '" , "userName" : "' + userName + '", "culture": "' + cultureName + '","categoryLargeThumbImage":"' + '<%= categoryLargeThumbImage %>' + '","categoryMediumThumbImage":"' + '<%= categoryMediumThumbImage %>' + '","categorySmallThumbImage":"' + '<%= categorySmallThumbImage %>' + '"}';
        var url = aspxservicePath + "ASPXCommerceWebService.asmx/SaveCategory";
        PostData(arForm, url, "Post", saveCategorySuccess, errorFn);
    }

    function SerializeForm(formID, remove) {
        jsonStr = ''
        var frmValues = new Array();
        radioGroups = new Array();
        checkboxGroups = new Array();
        selectGroups = new Array();
        inputs = $(formID).find('INPUT, SELECT, TEXTAREA');
        $.each(inputs, function(i, item) {
            input = $(item);
            if (input.hasClass("dynFormItem")) {
                var found = false;
                switch (input.attr('type')) {
                case 'select-multiple':
                    for (var i = 0; i < selectGroups.length; i++) {
                        if (selectGroups[i] == input.attr('name')) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        selectGroups[selectGroups.length] = input.attr('name');
                    }
                    break;
                case 'select-one':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + input.get(0)[input.attr('selectedIndex')].value + '"},';
                    break;
                case 'checkbox':
                    var ids = String(input.attr('name')).split("_");
                    if (ids[1] == 4) {
                        jsonStr += '{"name":"' + input.attr('name') + '","value":"' + input.is(':checked') + '"},';
                    } else {
                        for (var i = 0; i <= checkboxGroups.length; i++) {
                            if (checkboxGroups[i] == input.attr('name')) {
                                found = true;
                                break;
                            }
                        }
                        if (!found) {
                            checkboxGroups[checkboxGroups.length] = input.attr('name');
                        }
                    }
                    break;
                case 'radio':
                    for (var i = 0; i <= radioGroups.length; i++) {
                        if (radioGroups[i] == input.attr('name')) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        radioGroups[radioGroups.length] = input.attr('name');
                    }
                    break;
                case 'file':
                    var d = input.parent();
                    var img = $(d).find('span.response img.uploadImage');
                    var imgToUpload = "";
                    if (img.attr("src") != undefined) {
                        imgToUpload = img.attr("src");
                    }
                    if (img) {
                        jsonStr += '{"name":"' + input.attr('name') + '","value":"' + imgToUpload.replace(aspxRootPath, "") + '"},';
                    } else {
                        var a = $(d).find('span.response a');
                        var fileToUpload = "";
                        if (a.attr("href") != undefined) {
                            fileToUpload = a.attr("href");
                        }
                        if (a) {
                            jsonStr += '{"name":"' + input.attr('name') + '","value":"' + fileToUpload.replace(aspxRootPath, "") + '"},';
                        }
                    }
                    var hdn = $(d).find('input[type="hidden"]');
                    if (hdn) {
                        jsonStr += '{"name":"' + hdn.attr('name') + '","value":"' + hdn.val() + '"},';
                    }
                    break;
                case 'password':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    break;
                case 'textarea':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    break;
                case 'text':
                    jsonStr += '{"name":"' + input.attr('name') + '","value":"' + $.trim(input.val()) + '"},';
                    break;
                default:
                    break;
                }
            }
        });


        for (var i = 0; i < selectGroups.length; i++) {
            var selIDs = '';
            $('#' + selectGroups[i] + ' :selected').each(function(i, selected) {
                selIDs += $(selected).val() + ",";
            });
            selIDs = selIDs.substr(0, selIDs.length - 1);
            jsonStr += '{"name":"' + selectGroups[i] + '","value":"' + selIDs + '"},';
        }


        for (var i = 0; i < checkboxGroups.length; i++) {
            var chkValues = '';
            $('input[name=' + checkboxGroups[i] + ']').each(function(i, item) {
                if ($(this).is(':checked')) {
                    chkValues += chkValues + $(this).val() + ",";
                }
            });
            chkValues = chkValues.substr(0, chkValues.length - 1);
            jsonStr += '{"name":"' + checkboxGroups[i] + '","value":"' + chkValues + '"},';
        }

        for (var i = 0; i < radioGroups.length; i++) {
            var radValues = '';
            radValues = $('input[name=' + radioGroups[i] + ']:radio').val();
            radValues = radValues.substr(0, radValues.length - 1);
            jsonStr += '{"name":"' + radioGroups[i] + '","value":"' + radValues + '"},';
        }
        jsonStr = jsonStr.substr(0, jsonStr.length - 1);
        return '[' + jsonStr + ']';
    }

    function saveCategorySuccess(result) {
        var res = eval(result.d);
        if (res.returnStatus > 0) {
            var jEl = $("#divMessage");
            jEl.html(res.Message).fadeIn(1000);
            setTimeout(function() { jEl.fadeOut(1000) }, 5000);

            $("#lblCategoryID").html(0);
            $("#CagetoryMgt_categoryID").val(0);
            $("#CagetoryMgt_parentCagetoryID").val(0);
            $("#CategoryTree_Container").html('');
            GetCategoryAll();
            $("#CategorManagement_TabContainer").find("input[type=reset]").click();
            ResetHTMLEditors();
            ResetImageTab();
            var $tabs = $('#CategorManagement_TabContainer').tabs(); // first tab selected
            $tabs.tabs('select', 0);
        } else {
            csscody.error('<h1>Error Message</h1><p>' + res.ErrorMessage + '</p>');
        }
    }

    function EnableFormValidation(frmID) {
        mustCheck = true;
        $("#" + frmID + " ." + classprefix + "Cancel").click(function(event) {
            mustCheck = false;
        });
        var fe = $("#" + frmID + " input");
        for (var j = 0; j < fe.length; j++) {
            if ((fe[j]).title.indexOf("**") == 0) {
                if ((fe[j]).value == "" || (fe[j]).value == titleHint) {
                    var titleHint = (fe[j]).title.substring(2);
                    (fe[j]).value = titleHint;
                }
            } else if (((fe[j]).type == "text" || (fe[j]).type == "password" || (fe[j]).type == "textarea") && (fe[j]).title.indexOf("*") == 0) {
                addHint((fe[j]));
                $(fe[j]).blur(function(event) { addHint(this); });
                $(fe[j]).focus(function(event) { removeHint(this); });
            }
        }
    }

    function EnableDatePickers() {
        for (var i = 0; i < DatePickerIDs.length; i++) {
            $("#" + DatePickerIDs[i]).datepicker({ dateFormat: 'yy/mm/dd' });
        }
    }

    function EnableFileUploaders() {
        for (var i = 0; i < FileUploaderIDs.length; i++) {
            CreateFileUploader(String(FileUploaderIDs[i]));
        }
    }

    function CreateFileUploader(uploaderID) {
        d = $('#' + uploaderID).parent();
        baseLocation = d.attr("name");
        validExt = d.attr("class");
        maxFileSize = d.attr("lang");
        //alert(d.html());
        new AjaxUpload(String(uploaderID), {
            action: aspxCatModulePath + "FileUploader.aspx",
            name: 'myfile',
            onSubmit: function(file, ext) {
                var regExp = /\s+/g ;
                myregexp = new RegExp("(" + validExt.replace(regExp, "|") + ")", "i");
                if (ext != "exe") {
                    if (ext && myregexp.test(ext)) {
                        this.setData({
                            'BaseLocation': baseLocation,
                            'ValidExtension': validExt,
                            'MaxFileSize': maxFileSize
                        });
                    } else {
                        csscody.alert('<h1>Information Alert</h1><p>You are trying to upload invalid File!</p>');
                        return false;
                    }
                } else {
                    csscody.alert('<h1>Information Alert</h1><p>You are trying to upload invalid File!</p>');
                    return false;
                }
            },
            onComplete: function(file, ajaxFileResponse) {
                d = $('#' + uploaderID).parent();
                var res = eval(ajaxFileResponse);
                if (res.Message != null && res.Status > 0) {
                    baseLocation = d.attr("name");
                    validExt = d.attr("class");
                    var fileExt = (-1 !== file.indexOf('.')) ? file.replace( /.*[.]/ , '') : '';
                    myregexp = new RegExp("(jpg|jpeg|jpe|gif|bmp|png|ico)", "i");
                    if (myregexp.test(fileExt)) {
                        $(d).find('span.response').html('<div class="cssClassLeft"><img src="' + aspxRootPath + res.UploadedPath + '" class="uploadImage" height="90px" width="100px" /></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    } else {
                        $(d).find('span.response').html('<div class="cssClassLeft"><a href="' + aspxRootPath + res.UploadedPath + '" class="uploadFile" target="_blank">' + file + '</a></div><div class="cssClassRight"><img src="' + aspxTemplateFolderPath + '/images/admin/icon_delete.gif" class="cssClassDelete" onclick="ClickToDeleteImage(this)" alt="Delete" title="Delete"/></div>');
                    }
                } else {
                    csscody.error('<h1>Error Message</h1><p>' + res.Message + '</p>');
                }
            }
        });
    }

    var editorList = new Array();

    function EnableHTMLEditors() {
        for (var i = 0; i < htmlEditorIDs.length; i++) {
            config = { skin: "v2" };
            var html = "Initially Text if necessary";
            var editor = CKEDITOR.replace(htmlEditorIDs[i], config, html);
            var obj = new HTMLEditor(htmlEditorIDs[i], editor);
            editorList[editorList.length] = obj;
        }
    }

    function ResetHTMLEditors() {
        for (var i = 0; i < htmlEditorIDs.length; i++) {
            editorList[i].Editor.setData('');
        }
    }

    function HTMLEditor(editorID, editorObject) {
        this.ID = editorID;
        this.Editor = editorObject;
    }

    //    function NameValue(_name, _value) {
    //        this.name = _name;
    //        this.value = _value;
    //    }

    //    function CheckUnique(id) {
    //        var val = $('#' + id).val();
    //        if (val) {
    //            var arrID = id.split('_');
    //            $.ajax({
    //                type: "POST",
    //                url: aspxservicePath + "ASPXCommerceWebService.asmx/IsUnique",
    //                data: JSON2.stringify({ storeID: storeId, portalID: portalId, ItemID: 1, AttributeID: arrID[0], AttributeType: arrID[1], AttributeValue: val }),
    //                contentType: "application/json; charset=utf-8",
    //                dataType: "json",
    //                success: function(data) {
    //                    return data.d;
    //                }
    //            });
    //        }
    //        else {
    //            return false;
    //        }
    //    }

    function CheckUniqueness(catName) {
        // Validate name
        var CatId = $("#CagetoryMgt_categoryID").val();
        var errors = '';
        catName = $.trim(catName);
        if (!catName) {
            errors += ' - Please enter Category Name';
        }
            //check uniqueness
        else if (!IsUnique(catName, CatId)) {
            errors += ' - Please enter unique Category Name! "' + catName.trim() + '" already exists.<br/>';
        }

        if (errors) {
            csscody.alert('<h1>Information Alert</h1><p>' + errors + '</p>');
            return false;
        } else {
            return true;
        }
    }

    function IsUnique(catName, CatId) {
        var isUnique = false;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckUniqueCategoryName",
            data: JSON2.stringify({ catName: catName, catId: CatId, storeId: storeId, portalId: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(data) {
                isUnique = data.d;
            }
        });
        return isUnique;
    }

    function AddCategory() {
        $("#lblCategoryID").html(0);
        $("#CagetoryMgt_categoryID").val(0);
        $("#CagetoryMgt_parentCagetoryID").val(0);
        $("#CategorManagement_TabContainer").find("input[type=reset]").click();
        ResetHTMLEditors();
        ResetImageTab();
        var $tabs = $('#CategorManagement_TabContainer').tabs(); // first tab selected
        $tabs.tabs('select', 0);
        BindCategoryItemsGrid(0, '', '', null, null)
        $('#categoryReset').show();
    }

    var isAlreadyClickAddSubCategory = true;

    function AddSubCategory() {
        $("#lblCategoryID").html(0);
        if (!isAlreadyClickAddSubCategory) {
            isAlreadyClickAddSubCategory = true;
            var ParentID = $("#CagetoryMgt_parentCagetoryID").val();
            var CategoryID = $("#CagetoryMgt_categoryID").val();
            $("#CategorManagement_TabContainer").find("input[type=reset]").click();
            ResetHTMLEditors();
            ResetImageTab();
            $("#CagetoryMgt_categoryID").val(0);
            $("#CagetoryMgt_parentCagetoryID").val(CategoryID);

        }
        var $tabs = $('#CategorManagement_TabContainer').tabs(); // first tab selected
        $tabs.tabs('select', 0);
        BindCategoryItemsGrid(0, '', '', null, null)
        $('#categoryReset').show();
    }

    function SearchCategoryItems() {
        var catID = $.trim($("#CagetoryMgt_categoryID").val());
        var sku = $.trim($("#txtCategoryItemSKU").val());
        var name = $.trim($("#txtCategoryItemName").val());
        var priceFrom = $.trim($("#txtCategoryItemPriceFrom").val());
        var priceTo = $.trim($("#txtCategoryItemPriceTo").val());
        //if(priceFrom.length > 0 && isNaN(priceFrom) && priceTo.length>0 && isNaN(
        if (priceFrom.length > 0) {
            if (isNaN(priceFrom)) {
                csscody.alert('<h1>Alert Message</h1><p>Invalid price! Price should be number..</p>');
                return;
            }
        } else {
            priceFrom = null;
        }
        if (priceTo.length > 0) {
            if (isNaN(priceTo)) {
                csscody.alert('<h1>Alert Message</h1><p>Invalid price! Price should be number..</p>');
                return;
            }
        } else {
            priceTo = null
        }
        if (priceFrom > priceTo) {
            csscody.alert('<h1>Alert Message</h1><p>Invalid price range! Price From should be less than Price To..</p>');
            return false;
        }
        BindCategoryItemsGrid(catID, sku, name, priceFrom, priceTo);
    }
</script>
<div>
    <input type="hidden" id="hdnCatNameTxtBox"  /></div>
<div id="divMessage">
</div>
<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cssClassTableLeftCol">
                <div class="cssClassSideBox">
                    <div class="cssClassSideBoxNavi Curve">
                        <h2>
                            Navigation Category</h2>
                        <%--<div>
                    <a href="#" id="aCollapse" onclick="$('#categoryTree').tree('closeNode', $('#categoryTree').find('li'));">
                      Collapse all</a> | <a href="#" id="aExpand" onclick="$('#categoryTree').tree('openNode', $('#categoryTree').find('li'));">
                        Expand all</a>
                  </div>--%>
                        <div id="CategoryTree_Container">
                        </div>
                    </div>
                </div>
            </td>
            <td>
                <div>
                    <div class="cssClassCommonBox Curve">
                        <div class="cssClassHeader">
                            <h2>
                                Categories (ID: <span id="lblCategoryID">0</span>)
                            </h2>
                            <div class="cssClassHeaderRight">
                                <div class="cssClassButtonWrapper ">
                                    <p>
                                        <button type="button" class="" onclick=" AddCategory() "><span><span>Add Category</span></span></button>
                                    </p>
                                    <p>
                                        <button type="button" class="" onclick=" AddSubCategory() "><span><span>Add Sub Category</span></span></button>
                                    </p>
                                    <div class="cssClassClear">
                                    </div>
                                </div>
                            </div>
                            <div class="cssClassClear">
                            </div>
                        </div>
                        <div class="cssClassTabPanelTable">
                            <input type="hidden" id="CagetoryMgt_categoryID" value="0" />
                            <input type="hidden" id="CagetoryMgt_parentCagetoryID" value="0" />
                            <div id="dynForm" class="cssClassFormWrapper">
                            </div>
                        </div>
                    </div>
                </div>
            </td>
        </tr>
    </table>
    <div class="cssClassClear">
    </div>
</div>