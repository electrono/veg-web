﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="LocalizerSwitchSettings.ascx.cs"
            Inherits="Modules_Language_LocalizerSwitchSettings" %>
<script type="text/javascript">
    $(document).ready(function() {
        // BindDefaultSettings();
        LoadSettings();
        InitializeCarousel();
        $('#carousel_container').hide();
        $('#ddlFlags').msDropDown().data("dd");
        $('#txtFlagButton,#divFlagsDDL,#divDropDownSubSetting,#ddlNames').hide();


        $('input[type="radio"]').change(function() {
            var id = $(this).attr("id");
            switch (id) {
            case "rbIsList":
                $('#divListSubSetting,#divFlagAlignment,#imgFlagButton').fadeIn("slow");
                $('#txtFlagButton,#divDropDownSubSetting,#divFlagsDDL,#ddlNames,#carousel_container').hide();
                $('#chkFlags,#chkNames').attr("checked", true);
                break;
            case "rbIsDropDown":
                $('#divDropDownSubSetting').fadeIn("slow");
                $('#ddlNames').fadeIn("slow");
                $('#rbIsNormal').attr("checked", true);
                $('#divListSubSetting,#divFlagAlignment,#imgFlagButton,#carousel_container').hide();
                break;
            case "rbIsFlag":
                $('#divFlagsDDL').fadeIn("slow");
                $('#ddlNames,#carousel_container').hide();
                break;
            case "rbIsNormal":
                $('#ddlNames').fadeIn("slow");
                $('#divFlagsDDL').hide();
                break;
            case "rbHorizontal":
                $('#imgFlagButton li').addClass("cssClassListItemStyleHor").removeClass("cssClassListItemStyleVer").removeClass("defaultButtonClass").fadeIn("slow");
                break;
            case "rbVertical":
                $('#imgFlagButton').removeClass("defaultButtonClass");
                $('#imgFlagButton li').addClass("cssClassListItemStyleVer").removeClass("cssClassListItemStyleHor").fadeIn("slow");
                break;
            case "chkShowCarousel":
                if ($(this).attr("checked") == true && $('#rbHorizontal').attr("checked") == true) {

                    $('#carousel_container').fadeIn();
                    $('#imgFlagButton,#ddlNames,#divFlagsDDL,#divDropDownSubSetting,#divFlagAlignment,#divListSubSetting').hide();
                } else if ($(this).attr("checked") == true && $('#rbVertical').attr("checked") == true) {

                    $('#carousel_container').show();
                    $('#imgFlagButton,#ddlNames,#divFlagsDDL').hide();

                } else {
                    if ($('#rbIsList').attr("checked") == true) {
                        $('#carousel_container').hide();
                        $('#imgFlagButton').show();
                    } else if ($('#rbIsDropDown').attr("checked") == true) {
                        if ($('#rbIsFlag').attr("checked") == true) {
                            $('#carousel_container').hide();
                            $('#divFlagsDDL').show();
                        } else {
                            $('#carousel_container').hide();
                            $('#ddlNames').show();
                        }
                    }
                }
                break;
            }
        });
        $('input[type="checkbox"]').change(function() {
            var id = $(this).attr("id");
            switch (id) {
            case "chkFlags":
                if ($('#chkNames').attr("checked") == true && $(this).attr("checked") == true) {
                    $('#imgFlagButton li img,#imgFlagButton li span').show();
                } else if ($('#chkNames').attr("checked") == true && $(this).attr("checked") == false) {
                    $('#imgFlagButton li img').hide();
                    $('#imgFlagButton li span').show();
                } else if ($('#chkNames').attr("checked") == false && $(this).attr("checked") == true) {
                    $('#imgFlagButton li img').show();
                    $('#imgFlagButton li span').hide();
                } else if ($('#chkNames').attr("checked") == false && $(this).attr("checked") == false) {
                    $('#imgFlagButton li img').hide();
                    $('#imgFlagButton li span').hide();
                }

                break;
            case "chkNames":
                if ($('#chkFlags').attr("checked") == true && $(this).attr("checked") == true) {
                    $('#imgFlagButton li img,#imgFlagButton li span').show();
                } else if ($('#chkFlags').attr("checked") == false && $(this).attr("checked") == true) {
                    $('#imgFlagButton li img').hide();
                    $('#imgFlagButton li span').show();
                } else if ($('#chkFlags').attr("checked") == true && $(this).attr("checked") == false) {
                    $('#imgFlagButton li img').show();
                    $('#imgFlagButton li span').hide();
                } else if ($('#chkFlags').attr("checked") == false && $(this).attr("checked") == false) {
                    $('#imgFlagButton li img').hide();
                    $('#imgFlagButton li span').hide();
                }
                break;
            }

        });
        BindEvents();
    });

    function BindDefaultSettings() {
        $('#rbIsList').attr("checked", true);
        $('#divListSubSetting,#divFlagAlignment,#imgFlagButton').fadeIn("slow");
        $('#txtFlagButton,#divDropDownSubSetting,#divFlagsDDL,#ddlNames,#carousel_container').hide();
        $('#chkFlags,#chkNames').attr("checked", true);
    }

    function BindEvents() {
        $('#btnSaveSettings').bind("click", function() {
            //declare the setting variables
            var _SwitchType = "";
            var _ListTypeFlags = false;
            var _ListTypeName = false;
            var _ListTypeBoth = false;
            var _ListAlign = "H";
            var _EnableCarousel = false;
            var _DropDownType = "Flag";
            //end of setting variables declaration
            var jsonObj = "";

            var id = ""
            var chkFlag = $('#chkFlags');
            var chkName = $('#chkNames');
            if ($('#rbIsList').attr("checked") == true) {
                id = "rbIsList";
                _SwitchType = "List";
            } else if ($('#rbIsDropDown').attr("checked")) {
                id = "rbIsDropDown";
                _SwitchType = "DropDown";
            } else {
                id = "chkShowCarousel";

            }

            switch (id) {
            case "rbIsList":
                if ($(chkFlag).attr("checked") == true && $(chkName).attr("checked") == false) {
                    _ListTypeFlags = true;
                } else if ($(chkFlag).attr("checked") == false && $(chkName).attr("checked") == true) {
                    _ListTypeName = true;
                } else if ($(chkFlag).attr("checked") == true && $(chkName).attr("checked") == true) {
                    _ListTypeBoth = true;
                } else if ($(chkFlag).attr("checked") == false && $(chkName).attr("checked") == false) {
                }
                if ($('#rbHorizontal').attr("checked") == true) {
                    _ListAlign = "H";
                } else if ($('#rbVertical').attr("checked") == true) {
                    _ListAlign = "V";
                }
                break;
            case "rbIsDropDown":
                if ($('#rbIsFlag').attr("checked") == true) {
                    _DropDownType = "Flag";
                } else if ($('#rbIsNormal').attr("checked") == true) {
                    _DropDownType = "Normal";
                }
                break;
            case "chkShowCarousel":
                if ($('#chkShowCarousel').attr("checked") == true) {
                    _EnableCarousel = true;
                    _SwitchType = "list";
                    break;
                }
            }

            var param = JSON2.stringify({ SwitchType: _SwitchType, ListTypeFlags: _ListTypeFlags, ListTypeName: _ListTypeName, ListTypeBoth: _ListTypeBoth, ListAlign: _ListAlign, EnableCarousel: _EnableCarousel, DropDownType: _DropDownType });
            var method = LanguageSwitchSettingFilepath + "js/WebMethods.aspx/AddLanguageSwitchSettings";

            $.ajax({
                type: "POST",
                url: method,
                contentType: "application/json; charset=utf-8",
                data: param,
                dataType: "json",
                success: function(msg) {
                    alert("settings added");
                }
            });

        });
    }

    function InitializeCarousel() {
        //move he last list item before the first item. The purpose of this is if the user clicks to slide left he will be able to see the last item.
        $('#carousel_ul li:first').before($('#carousel_ul li:last'));

        //when user clicks the image for sliding right        
        $('#right_scroll img').click(function() {

            //get the width of the items ( i like making the jquery part dynamic, so if you change the width in the css you won't have o change it here too ) '
            var item_width = $('#carousel_ul li').outerWidth() + 10;

            //calculae the new left indent of the unordered list
            var left_indent = parseInt($('#carousel_ul').css('left')) - item_width;

            //make the sliding effect using jquery's anumate function '
            $('#carousel_ul:not(:animated)').animate({ 'left': left_indent }, 500, function() {

                //get the first list item and put it after the last list item (that's how the infinite effects is made) '
                $('#carousel_ul li:last').after($('#carousel_ul li:first'));

                //and get the left indent to the default -210px
                $('#carousel_ul').css({ 'left': '-5px' });
            });
        });

        //when user clicks the image for sliding left
        $('#left_scroll img').click(function() {

            var item_width = $('#carousel_ul li').outerWidth() + 10;

            /* same as for sliding right except that it's current left indent + the item width (for the sliding right it's - item_width) */
            var left_indent = parseInt($('#carousel_ul').css('left')) + item_width;

            $('#carousel_ul:not(:animated)').animate({ 'left': left_indent }, 500, function() {

                /* when sliding to left we are moving the last item before the first list item */
                $('#carousel_ul li:first').before($('#carousel_ul li:last'));

                /* and again, when we make that change we are setting the left indent of our unordered list to the default -210px */
                $('#carousel_ul').css({ 'left': '-5px' });
            });


        });
    }

    function LoadSettings() {
        var method = LanguageSwitchSettingFilepath + "js/WebMethods.aspx/GetLanguageSettings";
        $.ajax({
            type: "POST",
            url: method,
            contentType: "application/json; charset=utf-8",
            data: '{}',
            dataType: "json",
            success: function(msg) {
                var switchSettings = msg.d;
                var _SwitchType = "";
                var _ListTypeFlags = "false";
                var _ListTypeName = "false";
                var _ListTypeBoth = "false";
                var _ListAlign = "H";
                var _EnableCarousel = "false";
                var _DropDownType = "Flag";

                $.each(switchSettings, function(index, item) {

                    if (item.Key == "ListTypeBoth") {
                        _ListTypeBoth = item.Value;
                    }
                    if (item.Key == "ListTypeFlag") {
                        _ListTypeFlags = item.Value;
                    }
                    if (item.Key == "ListTypeName") {
                        _ListTypeName = item.Value;
                    }
                    if (item.Key == "ListAlign") {
                        _ListAlign = item.Value;
                    }
                    if (item.Key == "EnableCarousel") {
                        _EnableCarousel = item.Value;
                    }
                    if (item.Key == "SwitchType") {
                        _SwitchType = item.Value;
                    }
                    if (item.Key == "DropDownType") {
                        _DropDownType = item.Value;
                    }

                });
                if (_EnableCarousel.toLowerCase() == "false") {
                    switch (_SwitchType.toLowerCase()) {
                    case "list":
                        $('#rbIsList').attr("checked", true);
                        $('#rbIsDropDown').attr("checked", false);
                        if (_ListTypeBoth.toLowerCase() == "true") {
                            $('#chkFlags').attr("checked", true);
                            $('#chkNames').attr("checked", true);
                            $('#imgFlagButton li img').show();
                            $('#imgFlagButton li span').show();
                        }
                        if (_ListTypeFlags.toLowerCase() == "true") {
                            $('#chkFlags').attr("checked", true);
                            $('#chkNames').attr("checked", false);
                            $('#imgFlagButton li img').show();
                            $('#imgFlagButton li span').hide();
                        }
                        if (_ListTypeName.toLowerCase() == "true") {
                            $('#chkFlags').attr("checked", false);
                            $('#chkNames').attr("checked", true);
                            $('#imgFlagButton li img').hide();
                            $('#imgFlagButton li span').show();
                        }
                        break;
                    case "dropdown":
                        $('#rbIsList').attr("checked", false);
                        $('#rbIsDropDown').attr("checked", true);
                        $('#divDropDownSubSetting').fadeIn("slow");
                        $('#divListSubSetting,#divFlagAlignment,#imgFlagButton,#carousel_container').hide();
                        switch (_DropDownType.toLowerCase()) {
                        case "normal":
                            $('#divFlagsDDL,#imgFlagButton,#carousel_container').hide();
                            $('#ddlNames').show();
                            $('#rbIsNormal').attr("checked", true);
                            break;
                        case "flag":
                            $('#ddlNames,#imgFlagButton,#carousel_container').hide();
                            $('#divFlagsDDL').show();
                            $('#rbIsFlag').attr("checked", true);
                            break;
                        }
                        break;
                    }
                } else {
                    $('#imgFlagButton,#ddlNames,#divFlagsDDL,#divDropDownSubSetting,#divFlagAlignment,#divListSubSetting').hide();
                    $('#chkShowCarousel').attr("checked", true);
                    $('#rbIsList,#rbIsDropDown,#chkFlags,#chkNames').attr("checked", false);
                    $('#carousel_container').fadeIn("slow");
                }
            }
        });
    }

</script>

<div class="cssClassFormWrapper">
    <div class="cssClassLocalizerSwitchSetting">
        <h2> Language Switch Settings</h2>
        <div id="divMainSetting" class="cssClassRadioBtnWrapper">
            <input type="radio" id="rbIsList" class="mainSwitch" checked="checked" name="displayStyle" />
            <span>Lists</span>
            <input type="radio" id="rbIsDropDown" class="mainSwitch" name="displayStyle" />
            <span>DropDown</span> 
            <input type="radio" id="chkShowCarousel" class="mainSwitch" name="displayStyle" />
            <span>Carousel</span> 
        </div>
        <div id="divListSubSetting" class="cssClassCheckBoxWrapper">
            <input type="checkbox" id="chkFlags" checked="checked" />
            <span>Flags</span>
            <input type="checkbox" id="chkNames" checked="checked" />
            <span>Names</span> </div>
        <div id="divFlagAlignment" class="cssClassFlagAlignment">
            <input type="radio" id="rbHorizontal" checked="checked" name="alignment" />
            <span>Horizontal</span>
            <input type="radio" id="rbVertical" name="alignment" />
            <span>Vertical</span> </div>
        <div id="divDropDownSubSetting" class="cssClassDropDownSubSetting">
            <input type="radio" id="rbIsNormal" checked="checked" name="ddlType" />
            <span>Plain</span>
            <input type="radio" id="rbIsFlag" name="ddlType" />
            <span>With Flags</span> </div>
        <%--<div class="cssClassShowCarousel">
      <input type="checkbox" id="chkShowCarousel" />
      <span>Show Carousel</span></div>--%>
        <div class="cssClassclear"></div>
        <div id="divPreviewHeader">
            <h2>Preview</h2>
        </div>
        <div id="divPreview">
            <div class="cssClassFlagButtonWrapper">
                <ul id="imgFlagButton" class="defaultButtonClass">
                    <li> <img src="<%= ImagePath %>flags/us.png"/><span>Nep</span></li>
                    <li> <img src="<%= ImagePath %>flags/np.png" /><span>Eng</span></li>
                    <li> <img src="<%= ImagePath %>flags/in.png" /><span>Jpn</span></li>
                    <li> <img src="<%= ImagePath %>flags/jp.png" /><span>Ger</span></li>
                    <li> <img src="<%= ImagePath %>flags/ar.png" /><span>Urd</span></li>
                </ul>
                <div class="cssClassDropDownFlag">
                    <select id="ddlNames">
                        <option value="ad.png">English</option>
                        <option value="ad.png">Nepali</option>
                        <option value="ad.png">French</option>
                        <option value="ad.png">German</option>
                        <option value="ad.png">Hindi</option>
                        <option value="ad.png">Bengali</option>
                    </select>
                </div>
                <div id="divFlagsDDL">
                    <select id="ddlFlags">
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/us.png">en-US</option>
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/np.png">ne-NP</option>
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/jp.png">ar-YE</option>
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/in.png">hi-IN</option>
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/ad.png">ad-AR</option>
                        <option value="en-US" selected="selected" title="<%= ImagePath %>flags/ar.png">ap-YB</option>
                    </select>
                </div>
                <div id='carousel_container' class="CssClassLanguageWrapper">
                    <div class="CssClassLanguageWrapperInside">
                        <div id='left_scroll'> <img src='<%= ImagePath %>images/left.png' /></div>
                        <div id='carousel_inner'>
                            <ul id='carousel_ul'>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/an.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/ad.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/ae.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/af.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/ag.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/ai.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/al.png' /></a></li>
                                <li><a href='#'> <img src='<%= ImagePath %>flags/am.png' /></a></li>
                            </ul>
                        </div>
                        <div id='right_scroll'> <img src='<%= ImagePath %>images/right.png' /></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="cssClassButtonWrapper">
            <input type="button" id="btnSaveSettings" value="Save Settings" class="cssClassBtn" />
        </div>
    </div>
</div>