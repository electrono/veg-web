<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AttributesSetManage.ascx.cs"
            Inherits="Modules_ASPXAttributesManagement_AttributesSetManage" %>

<script type="text/javascript">
    //jQuery.noConflict();
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var treeHTML = '';
    var attGroup = new Array();

    //jQuery.noConflict();
    $(document).ready(function() {
        BindAttributeSetGrid(null, null, null);
        LoadAttributeSetMgmtStaticImage();
        $("divAttribSetGrid").show();
        $("#divAttribSetAddForm").hide();
        $("#divAttribSetEditForm").hide();

        $('#btnSaveAttributeSet').click(function() {
            var errors = '';
            var attributeSetName = $('#txtAttributeSetName').val();
            if (!attributeSetName) {
                errors += ' - Please enter attribute set name';
            }
            if (errors == '') {
                CheckUniqueness(0, attributeSetName, storeId, portalId, false);
            } else {
                csscody.error('<h1>Error Message</h1><p>' + errors + '</p>');
                $('#txtAttributeSetName').focus();
                return false;
            }
        })

        $('.btnUpdateAttributeSet').click(function() {
            var errors = '';
            var attributeSetName = $('#txtOldAttributeSetName').val();
            if (!attributeSetName) {
                errors += ' - Please enter attribute set name';
            }
            if (errors == '') {
                var attributeSet_Id = 0;
                if ($(this).attr("id")) {
                    attributeSet_Id = $(this).attr("id").replace( /[^0-9]/gi , '');
                }
                CheckUniqueness(attributeSet_Id, attributeSetName, storeId, portalId, true);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>' + errors + '</p>');
                $('#txtOldAttributeSetName').focus();
                return false;
            }
        })

        $('#btnAddNewGroup').click(function() {
            var attributeSetId = $(".btnResetEdit").attr("id").replace( /[^0-9]/gi , '');
            AddGroupName(attributeSetId);
        })

        $('#btnBackAdd').click(function() {
            clearForm();
            //show grid only            
            $("#divAttribSetAddForm").hide();
            $("#divAttribSetEditForm").hide();
            $("#divAttribSetGrid").show();
        })

        $('#btnBackEdit').click(function() {
            clearForm();
            $("#divAttribSetAddForm").hide();
            $("#divAttribSetEditForm").hide();
            $("#divAttribSetGrid").show();
        })

        $('#btnAddNewSet').click(function() {
            clearForm();
            BindAttributesSet();
            $("#divAttribSetGrid").hide();
            $("#divAttribSetEditForm").hide();
            $("#divAttribSetAddForm").show();
        })

        $(".btnResetEdit").click(function() {
            $('#dvTree').html('');
            treeHTML = '';
            attGroup = new Array();
            //Get the Id of the attribute to delete
            var attributeSetId = $(this).attr("id").replace( /[^0-9]/gi , '');
            CallEditFunction(attributeSetId);
        })

        $(".btnDeleteAttributeSet").click(function() {
            //Get the Id of the attribute to delete
            var attributeSetId = $(this).attr("id").replace( /[^0-9]/gi , '');
            DeleteAttributeSet(attributeSetId, storeId, portalId, userName);
        })
    });

    function LoadAttributeSetMgmtStaticImage() {
        $('#ajaxAttributeSetMgmtImage').attr('src', '' + aspxTemplateFolderPath + '/images/ajax-loader.gif');
    }

    function AddGroupName(_attributeSetId) {
        var x = '';
        var properties = { 'onComplete': function(x) { AddNewGroup(_attributeSetId, x); } };
        csscody.prompt("<h1>Please Enter the Group Name</h1><p>write a name here</p>", x, properties);
    }

    function AddNewGroup(_attributeSetId, node) {
        //alert(_attributeSetId+'::'+node);  
        if (node) {
            var _isActive = true;
            var _isModified = false;
            var _updateFlag = false;
            var _groupId = 0;
            //First call [sp_ASPXAttributeGroupAddUpdate] then bind again the tree with id and then add JQuery dragdrop
            var params = { attributeSetId: _attributeSetId, groupName: node, GroupID: _groupId, CultureName: cultureName, Aliasname: node, StoreId: storeId, PortalId: portalId, UserName: userName, isActive: _isActive, isModified: _isModified, flag: _updateFlag };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveUpdateAttributeGroupInfo",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    CallEditFunction(_attributeSetId);
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to update attribute group</p>');
                }
            });
        }
    }

    function BindAttributeSetGrid(attributeSetNm, isAct, userInSystem) {
        var offset_ = 1;
        var current_ = 1;
        var perpage = ($("#gdvAttributeSet_pagesize").length > 0) ? $("#gdvAttributeSet_pagesize :selected").text() : 10;

        $("#gdvAttributeSet").sagegrid({
            url: aspxservicePath + "ASPXCommerceWebService.asmx/",
            functionMethod: 'GetAttributeSetGrid',
            colModel: [
                { display: 'Attribute Set ID', name: 'attr_id', cssclass: 'cssClassHeadCheckBox', hide: true, coltype: 'checkbox', align: 'center' },
                { display: 'Attribute Set Name', name: 'attr_name', cssclass: '', controlclass: '', coltype: 'label', align: 'left' },
                { display: 'Used In System', name: 'IsSystemUsed', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Is Active', name: 'IsActive', cssclass: 'cssClassHeadBoolean', controlclass: '', coltype: 'label', align: 'left', type: 'boolean', format: 'Yes/No' },
                { display: 'Actions', name: 'action', cssclass: 'cssClassAction', controlclass: '', coltype: 'label', align: 'center' }
            ],
            buttons: [{ display: 'Edit', name: 'edit', enable: true, _event: 'click', trigger: '1', callMethod: 'EditAttributesSet', arguments: '2' },
                { display: 'Delete', name: 'delete', enable: true, _event: 'click', trigger: '2', callMethod: 'DeleteAttributesSet', arguments: '2' },
                { display: 'Active', name: 'active', enable: true, _event: 'click', trigger: '4', callMethod: 'ActiveAttributesSet', arguments: '2' },
                { display: 'Deactive', name: 'deactive', enable: true, _event: 'click', trigger: '5', callMethod: 'DeactiveAttributesSet', arguments: '2' }
            ],
            rp: perpage,
            nomsg: "No Records Found!",
            param: { attributeSetName: attributeSetNm, isActive: isAct, usedInSystem: userInSystem, storeId: storeId, portalId: portalId, cultureName: cultureName, userName: userName },
            current: current_,
            pnew: offset_,
            sortcol: { 0: { sorter: false }, 4: { sorter: false } }
        });
    }

    function show(id) {
        el = document.getElementById(id);
        if (el.style.display == 'none') {
            el.style.display = '';
        } else {
            el.style.display = 'none';
        }
    }

    function DeleteAttributesSet(tblID, argus) {
        switch (tblID) {
        case "gdvAttributeSet":
            if (argus[3].toLowerCase() != "yes") {
                DeleteAttributeSet(argus[0], storeId, portalId, userName);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t delete System Attribute Set</p>');
                return false;
            }
            break;
        default:
            break;
        }
    }

    function ActiveAttributesSet(tblID, argus) {
        switch (tblID) {
        case "gdvAttributeSet":
            if (argus[3].toLowerCase() != "yes") {
                ActivateAttributeSet(argus[0], storeId, portalId, userName, true);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t activate System Attribute Set</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeactiveAttributesSet(tblID, argus) {
        switch (tblID) {
        case "gdvAttributeSet":
            if (argus[3].toLowerCase() != "yes") {
                ActivateAttributeSet(argus[0], storeId, portalId, userName, false);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t deactivate System Attribute Set</p>');
            }
            break;
        default:
            break;
        }
    }

    function DeleteAttributeSet(_attributeSetId, _storeId, _portalId, _userName) {
        // Ask user's confirmation before delete records
        var properties = {
            onComplete: function(e) {
                DeleteAttributeSetID(_attributeSetId, _storeId, _portalId, _userName, e);
            }
        }
        csscody.confirm("<h1>Delete Confirmation</h1><p>Do you want to delete this attribute set?</p>", properties);
    }

    function DeleteAttributeSetID(_attributeSetId, _storeId, _portalId, _userName, event) {
        if (event) {
            //Pass the selected attribute id and other parameters
            var params = { attributeSetId: parseInt(_attributeSetId), storeId: _storeId, portalId: _portalId, userName: _userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/DeleteAttributeSetByAttributeSetID",
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    BindAttributeSetGrid(null, null, null);
                    clearForm();
                    $("#divAttribSetAddForm").hide();
                    $("#divAttribSetEditForm").hide();
                    $("#divAttribSetGrid").show();
                }
            });
        }
        return false;
    }

    function ActivateAttributeSet(_attributeSetId, _storeId, _portalId, _userName, _isActive) {
        //Pass the selected attribute id and other parameters
        var params = { attributeSetId: parseInt(_attributeSetId), storeId: _storeId, portalId: _portalId, userName: _userName, isActive: _isActive };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/UpdateAttributeSetIsActiveByAttributeSetID",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                BindAttributeSetGrid(null, null, null);
            }
        });
        return false;
    }

    function CheckUniqueness(AttributeSetID, AttributeSetName, StoreID, PortalID, UpdateFlag) {
        var errors = '';
        var isActive = true;
        var params = { attributeSetId: AttributeSetID, attributeSetName: AttributeSetName, storeId: StoreID, portalId: PortalID, updateFlag: UpdateFlag };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/CheckAttributeSetUniqueness",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (!msg.d) {
                    var saveString = '';
                    var _AttributeSetBaseID = 0;
                    _AttributeSetBaseID = $("#ddlAttributeSet").val();
                    if (!_AttributeSetBaseID) {
                        _AttributeSetBaseID = 0;
                    }
                    var isModified = false;
                    if (UpdateFlag) {
                        isModified = true;
                        saveString = SaveAttributeSetTree();
                    }
                    AddUpdateAttributeSet(AttributeSetID, _AttributeSetBaseID, AttributeSetName, StoreID, PortalID, isActive, isModified, userName, UpdateFlag, saveString);
                    BindAttributeSetGrid(null, null, null);
                } else {
                    errors += ' - Please enter unique attribute set name! "' + AttributeSetName + '" already exists.<br/>';
                    //errors += "Attribute set with the '" + $('#txtAttributeSetName').val() + "' name already exists."; //' - Please enter unique attribute set name'; //Attribute set with the "sss" name already exists.
                    //$('#txtAttributeSetName').val('');
                    csscody.alert('<h1>Information Alert</h1><p>' + errors + '</p>');
                    $('#txtAttributeSetName').focus();
                    return false;
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to check attribute set uniqueness</p>');
            }
        });
    }

    function SaveAttributeSetTree() {
        var saveString = '';
        var attributeIds = '';
        $("#tree>li").each(function(i) {
            if (!isUnassignedNode($(this))) {
                var groupIds = this.id.replace( /[^0-9]/gi , '');
                $(this).find('li').each(function() {
                    attributeIds += this.id.replace( /[^0-9]/gi , '') + ',';
                });
                attributeIds = attributeIds.substr(0, attributeIds.length - 1);
                if (attributeIds == '') {
                    attributeIds = 0;
                }
                saveString += groupIds + '-' + attributeIds + '#';
                attributeIds = '';
            }
        });
        return saveString = saveString.substr(0, saveString.length - 1);
    }

    function isUnassignedNode(li) {
        return (li.hasClass('unassigned-attributes'));
    }

    function AddUpdateAttributeSet(attributeSet_id, _attributeSetBaseID, attributeSetName, storeId, portalId, isActive, isModified, userName, _updateFlag, _saveString) {

        AttributeSetAddUpdate(attributeSet_id, _attributeSetBaseID, attributeSetName, storeId, portalId, isActive, isModified, userName, _updateFlag, _saveString);
    }

    function clearForm() {
        $(".btnResetEdit").removeAttr("id");
        $(".btnDeleteAttributeSet").removeAttr("id");
        $(".btnUpdateAttributeSet").removeAttr("id");
        $("#txtAttributeSetName").val('');
        $("#<%= lblAttributeSetInfo.ClientID %>").html("Edit Attribute Set");
        $("#txtAttributeSetName").val('');
    }

    function EditAttributesSet(tblID, argus) {
        switch (tblID) {
        case "gdvAttributeSet":
            if (argus[3].toLowerCase() != "yes") {
                CallEditFunction(argus[0]);
            } else {
                csscody.alert('<h1>Information Alert</h1><p>You can\'t edit System Attribute Set</p>');
                return false;
            }
            break;
        default:
            break;
        }
    }

    function FillForm(response) {
        $.each(response.d, function(index, item) {
            if (index == 0) {
                $("#<%= lblAttributeSetInfo.ClientID %>").html("Edit Attribute Set: '" + item.AttributeSetName + "'");
                $("#txtOldAttributeSetName").val(item.AttributeSetName);

                if (item.IsSystemUsed) {
                    $(".btnDeleteAttributeSet").hide();
                } else {
                    $(".btnDeleteAttributeSet").show();
                }
            }
        });
    }


    function AttributeSetAddUpdate(_attributeSetId, _attributeSetBaseId, _attributeSetName, _storeId, _portalId, _isActive, _isModified, _userName, _flag, _saveString) {
        var params = { attributeSetId: _attributeSetId, attributeSetBaseId: _attributeSetBaseId, attributeSetName: _attributeSetName, storeId: _storeId, portalId: _portalId, isActive: _isActive, isModified: _isModified, userName: _userName, flag: _flag, saveString: _saveString };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveUpdateAttributeSetInfo",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (!_flag) {
                    CallEditFunction(msg.d);
                } else {
                    clearForm();
                    $("#divAttribSetAddForm").hide();
                    $("#divAttribSetEditForm").hide();
                    $("#divAttribSetGrid").show();
                }
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to update attribute set</p>');
            }
        });
    }

    function BindAttributesSet() {
        var _attributeSetId = 0;
        var params = { attributeSetId: _attributeSetId, storeId: storeId, portalId: portalId, userName: userName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAttributeSetList",
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                $("#ddlAttributeSet").get(0).options.length = 0;
                $.each(msg.d, function(index, item) {
                    $("#ddlAttributeSet").get(0).options[$("#ddlAttributeSet").get(0).options.length] = new Option(item.AttributeSetName, item.AttributeSetID);
                });
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to load attribute set</p>');
            }
        });
    }

    function CallEditFunction(_attributeSetId) {
        $(".btnResetEdit").attr("id", 'attributesetid_' + _attributeSetId);
        $(".btnDeleteAttributeSet").attr("id", 'attributesetid_' + _attributeSetId);
        $(".btnUpdateAttributeSet").attr("id", 'attributesetid_' + _attributeSetId);
        $("#divAttribSetGrid").hide();
        $("#divAttribSetAddForm").hide();
        $("#divAttribSetEditForm").show();
        var functionName = 'GetAttributeSetDetailsByAttributeSetID';
        var params = { attributeSetId: _attributeSetId, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName };
        var mydata = JSON2.stringify(params);
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
            data: mydata,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                treeHTML = '';
                $("#tree").removeClass('ui-tree');
                $("#tree").html('');
                FillForm(msg);
                BindTreeView(msg);
                attGroup = new Array();
                AddDragDrop();
                AddContextMenu();
            },
            error: function() {
                csscody.error('<h1>Error Message</h1><p>Failed to edit attributes</p>');
            }
        });
    }

    function AddDragDrop() {
        $("#tree").tree({
            expand: '*',
            drop: function(event, ui) {
                $('.ui-tree-droppable').removeClass('ui-tree-droppable ui-tree-droppable-top ui-tree-droppable-center ui-tree-droppable-bottom');
                switch (ui.overState) {
                case 'top':
                    if ((ui.sender.isNode(ui.draggable) == ui.target.isNode(ui.droppable)) && !ui.sender.isUnassignedNode(ui.draggable) && !ui.target.isUnassignedNode(ui.droppable)) {
                        ui.target.before(ui.sender.getJSON(ui.draggable), ui.droppable);
                        ui.sender.remove(ui.draggable);
                    }
                    break;
                case 'bottom':
                    if ((ui.sender.isNode(ui.draggable) == ui.target.isNode(ui.droppable)) && !ui.sender.isUnassignedNode(ui.draggable) && !ui.target.isUnassignedNode(ui.droppable)) {
                        ui.target.after(ui.sender.getJSON(ui.draggable), ui.droppable);
                        ui.sender.remove(ui.draggable);
                    }
                    break;
                case 'center':
                    if (!ui.sender.isNode(ui.draggable) && ui.target.isNode(ui.droppable)) {
                        ui.target.append(ui.sender.getJSON(ui.draggable), ui.droppable);
                        ui.sender.remove(ui.draggable);
                    }
                    break;
                }
            },
            over: function(event, ui) {
                $(ui.droppable).addClass('ui-tree-droppable');
                //                if (ui.target.isUnassignedNode(ui.droppable)) {
                //                    $('.ui-tree-droppable').removeClass('ui-tree-droppable ui-tree-droppable-top ui-tree-droppable-center ui-tree-droppable-bottom');
                //                }
            },
            out: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable');
            },
            overtop: function(event, ui) {
                //if (ui.sender.isNode(ui.draggable) == ui.target.isNode(ui.droppable)) {
                $(ui.droppable).addClass('ui-tree-droppable-top');
                // }
            },
            overcenter: function(event, ui) {
                //if (!ui.sender.isNode(ui.draggable) && ui.target.isNode(ui.droppable)) {
                $(ui.droppable).addClass('ui-tree-droppable-center');
                //}
            },
            overbottom: function(event, ui) {
                //if (ui.sender.isNode(ui.draggable) == ui.target.isNode(ui.droppable)) {
                $(ui.droppable).addClass('ui-tree-droppable-bottom');
                //}
            },
            outtop: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-top');
            },
            outcenter: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-center');
            },
            outbottom: function(event, ui) {
                $(ui.droppable).removeClass('ui-tree-droppable-bottom');
            }
        });
    }

    function AddContextMenu() {
        $('#tree>li').each(function(i) {
            if (!isUnassignedNode($(this))) {
                $(this).contextMenu('myMenu1', {
                //                    onContextMenu: function(e) {
                //                        //$("p").parent(".selected").css("background", "yellow");
                //                        //alert($(e.target).parent("li").html());
                //                        //if ($(e.target).parent("li").html() == null) return true;
                //                        //else return false;

                //                    },
                    onShowMenu: function(e, menu) {
                        if (isNode(getSelect().parent('li'))) {
                            if (isSystemUsedGroup(getSelect().parent('li'))) {
                                $('#remove, #delete', menu).remove();
                            } else {
                                $('#remove', menu).remove();
                            }
                        } else if (isSystemUsedAttribute(getSelect().parent('li'))) {
                            $('#rename, #delete, #remove', menu).remove();
                            $(menu).html('');
                        } else {
                            $('#rename, #delete', menu).remove();
                        }
                        return menu;
                    },
                    bindings: {
                        'rename': function(t) {
                            var value = GetTitle(t);
                            //alert('Trigger was ' + t.id + '\nAction was Open');
                            var html = "<input id=\"txtEdit\" type=\"text\" value=\"" + value + "\" onblur=\"SaveValue(this, '" + value + "')\" onfocus=\"PutCursorAtEnd(this)\" />";
                            SetTitle(t, html);
                            $("#txtEdit").focus();
                        },
                        'delete': function(t) {
                            var attributeSetId = $(".btnResetEdit").attr("id").replace( /[^0-9]/gi , '');
                            var groupId = t.id.replace( /[^0-9]/gi , '');

                            // Ask user's confirmation before delete records
                            var properties = {
                                onComplete: function(x) {
                                    DeleteGroupFromAttributeSetID(attributeSetId, groupId, x);
                                }
                            }
                            csscody.confirm("<h1>Delete Confirmation</h1><p>Are you sure to delete this group?</p>", properties);
                            //$('#tree').tree('nodeName', $('#tree').find('li'))
                            //$('#tree').tree('remove',$(this));
                            //alert(t);
                        },
                        'remove': function(t) {
                            //alert($(t).html());
                            var attributeSetId = $(".btnResetEdit").attr("id").replace( /[^0-9]/gi , '');
                            var groupId = t.id.replace( /[^0-9]/gi , '');
                            var is = getSelect();
                            var liElement = is.parent("LI");
                            var attributeId = liElement[0].id.replace( /[^0-9]/gi , '');
                            // Ask user's confirmation before delete records
                            var properties = {
                                onComplete: function(x) {
                                    DeleteAttributeFromAttributeSetID(attributeSetId, groupId, attributeId, x);
                                }
                            }
                            csscody.confirm("<h1>Remove Confirmation</h1><p>Are you sure to remove this attribute?</p>", properties);
                        }
                    },
                    menuStyle: {
                        border: '1px solid #000'
                    },
                    itemStyle: {
                        display: 'block',
                        cursor: 'pointer',
                        padding: '3px',
                        border: '1px solid #fff',
                        backgroundColor: 'transparent'
                    },
                    itemHoverStyle: {
                        border: '1px solid #0a246a',
                        backgroundColor: '#b6bdd2'
                    }
                });
            }
        });
    }

    function getSelect() {
        var select = $('.ui-tree-selected', this.element);
        if (select.length) return select;
        else return null;
    }

    function isNode(li) {
        return (li.hasClass('ui-tree-node'));
    }

    function isSystemUsedGroup(li) {
        return (li.hasClass('systemused-groups'));
    }

    function isSystemUsedAttribute(li) {
        return (li.hasClass('systemused-attributes'));
    }

    function PutCursorAtEnd(obj) {
//        if (obj.value == obj.defaultValue) {
//            $(obj).putCursorAtEnd(obj.length);
        //        }
        //bugs on js 1.4 fix if use 1.4.1
        // $('#txtEdit').focus().val($('#txtEdit').val());

    }

    function GetTitle(node) {
        var title = $('>span.ui-tree-title', node);
        var html = '';
        if (title.length) {
            html = title.text().replace( /<span class="?ui-tree-title-img"?[^>]*>[\s\S]*?<\/span>/gi , '');
        } else {
            node = node.length ? node : $(node);
            html = node.text().replace( /<ul[^>]*>[\s\S]*<\/ul>/gi , '').replace( /\s*style="[^"]*"/gi , '');
        }
        return $.trim(html.replace( /\n/g , '').replace( /<a[^>]*>/gi , '').replace( /<\/a>/gi , ''));
    }

    function SetTitle(node, title) {
        this.GetSPAN(node).html(title);
    }

    function GetSPAN(node) {
        node = node.length ? node : $(node);
        if (this.parentNodeName(node) == 'li') return $('>span.ui-tree-title:eq(0)', node);
        else if (this.parentNodeName(node) == 'ul') return $('span.ui-tree-title:eq(0)', node.parent());
        else return node;
    }

    function parentNodeName(node) {
        if (node.attr != undefined) {
            return (node.length ? node.attr('nodeName') : $(node).attr('nodeName')).toLowerCase();
        }
    }

    function SaveValue(obj, oldValue) {
        var functionName = 'RenameAttributeSetGroupAliasByGroupID';
        var value = $(obj).val();
        //$(obj).parent().removeClass("edit");
        if (value != "") {
            if (value != oldValue) {
                //var property = $(obj).parent().attr("id");
                var attributeSetId = $(".btnResetEdit").attr("id").replace( /[^0-9]/gi , '');
                var id = $(obj).parent().parent().attr("id");
                id = id.replace( /[^0-9]/gi , '');

                $(obj).parent().html('<img id="imgSaving' + id + '" src="' + aspxTemplateFolderPath + '/images/saving.gif" alt="Saving..." />');

                var params = { groupId: id, cultureName: cultureName, aliasName: value, attributeSetId: attributeSetId, storeId: storeId, portalId: portalId, isActive: true, isModified: true, userName: userName };
                var mydata = JSON2.stringify(params);
                $.ajax({
                    type: "POST",
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
                    data: mydata,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: SaveGroup_Success,
                    error: Error
                });
            } else {
                $(obj).parent().html('<b>' + oldValue + '</b>');
            }
        } else {
            csscody.alert('<h1>Information Alert</h1><p>You need to enter group name.</p>');
            $(obj).parent().html('<b>' + oldValue + '</b>');
        }
    }

    function SaveGroup_Success(data, status) {
        $.each(data.d, function(index, item) {
            $("#imgSaving" + item.GroupID).parent().html('<b>' + item.AliasName + '</b>');
        });
    }

    function Error(request, status, error) {
        csscody.error('<h1>Error Message</h1><p>' + request.statusText + '</p>');
    }

    function DeleteAttributeFromAttributeSetID(attributeSetId, groupId, attributeId, event) {
        if (event) {
            var functionName = 'DeleteAttributeByAttributeSetID';
            var params = { attributeSetId: attributeSetId, groupId: groupId, attributeId: attributeId, storeId: storeId, portalId: portalId, userName: userName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function() {
                    CallEditFunction(attributeSetId);
                    AddDragDrop();
                    AddContextMenu();
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to remove attribute</p>');
                }
            });
        }
        return false;
    }

    function DeleteGroupFromAttributeSetID(attributeSetId, groupId, event) {
        if (event) {
            var functionName = 'DeleteAttributeSetGroupByAttributeSetID';
            var params = { attributeSetId: attributeSetId, groupId: groupId, storeId: storeId, portalId: portalId, userName: userName, cultureName: cultureName };
            var mydata = JSON2.stringify(params);
            $.ajax({
                type: "POST",
                url: aspxservicePath + "ASPXCommerceWebService.asmx/" + functionName,
                data: mydata,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function(msg) {
                    CallEditFunction(attributeSetId)
                },
                error: function() {
                    csscody.error('<h1>Error Message</h1><p>Failed to delete attribute set group</p>');
                }
            });
        }
        return false;
    }

    function BindTreeView(response) {
        var unassignedAttributeExist = false;
        var unassignedAttributesIds = '';
        var unassignedAttributesName = '';
        var groupId = '';
        treeHTML += '<ul id="tree">';
        $.each(response.d, function(index, item) {
            BindGroup(index, item.GroupID, item.GroupName, item.AttributeID, item.AttributeName, item.IsSystemUsed, item.IsSystemUsedGroup);
            groupId = item.GroupID;
            if (index == 0 && item.UnassignedAttributes != "") {
                unassignedAttributeExist = true;
                unassignedAttributesIds = item.UnassignedAttributes;
                unassignedAttributesName = item.UnassignedAttributesName;
            }
        });

        if (unassignedAttributeExist) {
            AddUnassignedAttribute(groupId, unassignedAttributesIds, unassignedAttributesName);
        }
        if (groupId > 0) {
            treeHTML += '</ul></li>';
        }
        treeHTML += '</ul>';
        $("#dvTree").html(treeHTML);
    }

    function AddUnassignedAttribute(groupId, unassignedAttributesIds, unassignedAttributesName) {
        if (groupId > 0) {
            treeHTML += '</ul></li>';
        }
        treeHTML += '<li id="group" class="file-folder unassigned-attributes"><b>Unassigned Attributes</b><ul>';
        var unassignedName = unassignedAttributesName.split(',');
        var unassignedId = unassignedAttributesIds.split(',');
        for (var i = 0; i < unassignedId.length; i++) {
            //alert(unassignedId[i] + '::' + unassignedName[i]);
            treeHTML += '<li id="attribute' + unassignedId[i] + '" class="file php">' + unassignedName[i] + '</li>';
        }
        treeHTML += '</ul></li>';
    }

    function BindGroup(index, groupID, groupName, attributeID, attributeName, isSystemUsedAttrib, isSystemUsedGroup) {
        if (groupID > 0) {
            var isGroupExist = false;
            for (var i = 0; i < attGroup.length; i++) {
                if (attGroup[i].key == groupID) {
                    isGroupExist = true;
                    break;
                }
            }
            if (!isGroupExist) {
                if (attGroup.length != 0) {
                    treeHTML += '</ul></li>';
                }
                if (isSystemUsedGroup) {
                    treeHTML += '<li id="group' + groupID + '" class="file-folder systemused-groups"><b>' + groupName + '</b><ul>';
                } else {
                    treeHTML += '<li id="group' + groupID + '" class="file-folder"><b>' + groupName + '</b><ul>';
                }
            }
            if (attributeName != "") {
                if (isSystemUsedAttrib) {
                    treeHTML += '<li id="attribute' + attributeID + '" class="file html systemused-attributes">' + attributeName + '</li>';
                } else {
                    treeHTML += '<li id="attribute' + attributeID + '" class="file html">' + attributeName + '</li>';
                }
            }
            if (!isGroupExist) {
                attGroup.push({ key: groupID, value: groupName });
            }
        }
    }

    function SearchAttributeSetName() {
        var attributeSetNm = $.trim($("#txtSearchAttributeSetName").val());
        var isAct = $.trim($('#ddlIsActive').val()) == "" ? null : $.trim($('#ddlIsActive').val()) == "True" ? true : false;
        var userInSystem = $.trim($("#ddlUserInSystem").val()) == "" ? null : $.trim($("#ddlUserInSystem").val()) == "True" ? true : false;
        if (attributeSetNm.length < 1) {
            attributeSetNm = null;
        }
        BindAttributeSetGrid(attributeSetNm, isAct, userInSystem);
    }
</script>

<!-- Grid -->
<div id="divAttribSetGrid">
    <td class="cssClassBodyContentBox">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrSetsGridHeading" runat="server" Text="Manage Attribute Sets"></asp:Label>
            </h2>
            <div class="cssClassHeaderRight">
                <div class="cssClassButtonWrapper">
                    <p>
                        <button type="button" id="btnAddNewSet">
                            <span><span>Add New Set</span></span></button>
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
                                    Attribute Set Name:</label>
                                <input type="text" id="txtSearchAttributeSetName" class="cssClassTextBoxSmall" />
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    IsActive:</label>
                                <select id="ddlIsActive" class="cssClassDropDown">
                                    <option value="">-- All -- </option>
                                    <option value="True">Yes </option>
                                    <option value="False">No </option>
                                </select>
                            </td>
                            <td>
                                <label class="cssClassLabel">
                                    Used In System:</label>
                                <select id="ddlUserInSystem" class="cssClassDropDown">
                                    <option value="">--All--</option>
                                    <option value="True">Yes</option>
                                    <option value="False">No</option>
                                </select>
                            </td>
                            <td>
                                <div class="cssClassButtonWrapper cssClassPaddingNone">
                                    <p>
                                        <button type="button" onclick=" SearchAttributeSetName() ">
                                            <span><span>Search</span></span></button>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="loading">
                    <img id="ajaxAttributeSetMgmtImage" src="<%= ResolveUrl("~/") %>Templates/ASPXCommerce/images/ajax-loader.gif" />
                </div>
                <div class="log">
                </div>
                <table id="gdvAttributeSet" width="100%" border="0" cellpadding="0" cellspacing="0">
                </table>
            </div>
        </div>
    </div>
</div>
<!-- End of Grid -->
<div id="divAttribSetAddForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttrSetsFormHeading" runat="server" Text="Add New Attribute Set"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="cssClassPadding tdpadding">
                <tr>
                    <td>
                        <asp:Label ID="lblAttributeSetName" runat="server" Text="Name:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <input type="text" class="cssClassNormalTextBox" name="" id="txtAttributeSetName">
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblType" runat="server" Text="Based On:" CssClass="cssClassLabel"></asp:Label>
                        <span class="cssClassRequired">*</span>
                    </td>
                    <td class="cssClassTableRightCol">
                        <select class="cssClassDropDown" name="" id="ddlAttributeSet">
                        </select>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button id="btnBackAdd" type="button">
                    <span><span>Back</span></span>
                </button>
            </p>
            <p>
                <button id="btnSaveAttributeSet" type="button">
                    <span><span>Save Attribute Set</span></span>
                </button>
            </p>
        </div>
        <div class="cssClassClear">
        </div>
    </div>
</div>
<div id="divAttribSetEditForm">
    <div class="cssClassCommonBox Curve">
        <div class="cssClassHeader">
            <h2>
                <asp:Label ID="lblAttributeSetInfo" runat="server" CssClass="cssClassLabel"></asp:Label>
            </h2>
        </div>
        <div class="cssClassFormWrapper">
            <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                <tr>
                    <td width="50%">
                        <h3>
                            <asp:Label ID="lblAttributeNameTitle" runat="server" Text="Edit Set Name" CssClass="cssClassLabel"></asp:Label>
                        </h3>
                        <table cellspacing="0" cellpadding="0" border="0" width="100%" class="cssClassPadding">
                            <tr>
                                <td>
                                    <asp:Label ID="lblAttributeSetNameTitle" runat="server" Text="Name:" CssClass="cssClassLabel"></asp:Label>
                                    <span class="cssClassRequired">*</span>
                                </td>
                                <td class="cssClassTableRightCol">
                                    <input type="text" class="cssClassNormalTextBox" name="" id="txtOldAttributeSetName">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td width="50%">
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>
                                <td>
                                    <h3>
                                        <asp:Label ID="lblGroups" runat="server" Text="Groups" CssClass="cssClassLabel"></asp:Label>
                                    </h3>
                                </td>
                                <td>
                                    <div class="cssClassButtonWrapper cssClassPaddingNone">
                                        <p>
                                            <button type="button" id="btnAddNewGroup">
                                                <span><span>Add New Group</span></span></button>
                                        </p>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <div class="contextMenu" id="myMenu1">
                                        <ul>
                                            <li id="rename" class="cssClassSeparator">
                                                <img runat="server" id="imgRename" alt="Rename" title="Rename" />
                                                <b>Rename</b></li>
                                            <li id="delete" class="cssClassSeparator">
                                                <img runat="server" id="imgDelete" alt="Delete" title="Delete" />
                                                <b>Delete</b></li>
                                            <li id="remove" class="cssClassSeparator">
                                                <img runat="server" id="imgRemove" alt="Remove" title="Remove" />
                                                <b>Remove</b></li>
                                        </ul>
                                    </div>
                                    <div id="dvTree" style="float: left;">
                                    </div>
                                    <%--<div>
                                                                                                            <a href="#" id="aCollapse" onclick="$('#tree').tree('closeNode', $('#tree').find('li'));">
                                                                                                                Collapse all</a> | <a href="#" id="aExpand" onclick="$('#tree').tree('openNode', $('#tree').find('li'));">
                                                                                                                    Expand all</a>
                                                                                                        </div>--%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <div class="cssClassButtonWrapper">
            <p>
                <button id="btnBackEdit" type="button">
                    <span><span>Back</span></span>
                </button>
            </p>
            <p>
                <button class="btnResetEdit" type="button">
                    <span><span>Reset</span></span>
                </button>
            </p>
            <p>
                <button class="btnDeleteAttributeSet" type="button">
                    <span><span>Delete Attribute Set</span></span>
                </button>
            </p>
            <p>
                <button class="btnUpdateAttributeSet" type="button">
                    <span><span>Save Attribute Set</span></span>
                </button>
            </p>
        </div>
    </div>
</div>