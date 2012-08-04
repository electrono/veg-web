/*
*	jquery.form-validation-and-hints.js
*	2009, icograma.com 
*	Licensed under GPL license (http://www.opensource.org/licenses/gpl-license.php).
*	@version 0.201
*
*  DEMO: http://www.icograma.com/form-validation-and-hints/
*  
*/


/* --- TO SET --- */
// Prefix used to hook CSS classes to the script 
classprefix = 'verify';
// <input class="verifyInteger" type="text" name="mail" />

// Set your validation rules 

function isTypeValidExt(classprefix, type, value) {
    /* RULE EXAMPLE (Accept only integer values)
    if( type == classprefix + 'Integer' ) {
    return ( ( value.match(/^[\d|,|\.|\s]*$/) ) && ( value != '' ) );
    } 
    */
    return true;
}

var annoy = true;

function debug(msg) {
    if (annoy) {
        annoy = confirm(msg);
    }
    ;
}

/* --- DOCUMEN READY --- 
$(document).ready(function() {
    
}); // end jQuery $(document).ready*/


/* --- FUNCTIONS --- */

function addHint(field) {
    var titleHint = field.title.substring(1);
    if (field.value == "" || field.value == titleHint) {
        //in "password" inputs, set to "text" to show hint, preserve type in class attribute
        if (field.type == "password") {
            $(field).addClass("password");
            var newObject = changeInputType(field, "text") //returns false for non-ie
        } //end type == "password"
        $(field).addClass("hint");
        field.value = titleHint;
    } //end value==""
}

//end addHint


function removeHint(field) { //only on INPUT.text items 
    /*if( field.type == "text" && field.title.indexOf("*")==0 ) {*/
    var titleHint = field.title.substring(1);
    if (field.value == "" || field.value == titleHint) {
        $(field).removeClass('hint');
        field.value = "";
        //re-set password type if appropiate
        if ($(field).hasClass("password")) {
            var newObject = changeInputType(field, "password"); //returns false for non-ie
            if (newObject) {
                ///IE, element was replaced: reset focus
                $(newObject).focus();
                $(newObject).select();
            }
        } //end hasClass("password")
    } //end value == titleHint
    //}//end what.title	
}

//end rmhint


function changeInputType(oldObject, oType) {
    //based on http://arjansnaterse.nl/changing-type-attribute-in-ie
    //used to simulate change of INPUT type in IE
    if (!document.all) {
        oldObject.type = oType;
        return false;
    } else {
        //ie can't change INPUT's type, must create new element
        /*
        newObject = $(oldObject).clone(true);
        //newObject.type = oType;
        $(newObject).attr('type');
        $(newObject).insertBefore(oldObject);
        debug(newObject);
        return newObject;
        */
        var newObject = document.createElement('input');
        newObject.type = oType;
        if (oldObject.size) newObject.size = oldObject.size;
        if (oldObject.title) newObject.title = oldObject.title;
        if (oldObject.value) newObject.value = oldObject.value;
        if (oldObject.name) newObject.name = oldObject.name;
        if (oldObject.id) newObject.id = oldObject.id;
        if (oldObject.className) newObject.className = oldObject.className;
        oldObject.parentNode.replaceChild(newObject, oldObject);
        //live()
        return newObject;
    } //end document.all
}

function checkForm(form) {
    var tabIndex = 0;
    var send = true;
    var password = '';
    radioGroups = Array();

    $('.required').find('.cke_skin_v2 iframe').each(function() {
        if ($(this).contents().find("body").text() != '' && $(this).contents().find("body").text() != null) {
            $(this).parents('.required').find('.iferror').html('');
            $(this).parents().removeClass("diverror");
        } else {
            $(this).parents('.required').find('.iferror').html('Mandatory Fields');
            send = false;
        }
    });
//    if (From.length > 0) {
//        for (var vt in From) {
//            if (Date.parse($(From[vt]).val()) > Date.parse($(To[vt]).val())) {
//                if (send) moveTo($(To[vt]));
//                showErrorOn($(To[vt]));
//                $(To[vt]).parents('.required').find('.iferror').html('must be higher date than active from');
//                send = false;
//                //$(To[vt]).css("background-color","#FFCA85");   
//            }
//        }
    //    }

//    if ($('#Todatevalidation').length > 0) {       
//        var acfrom = $('#Fromdatevalidation').attr('class').split(' ');
//        var acto = $('#Todatevalidation').removeClass('error').attr('class').split(' ');       
//        for (var g in acto) {           
//            if (Date.parse($('.' + acto[g]).val()) > Date.parse($('.' + acfrom[g]).val())) {
//            }
//            else {               
//                if (send) moveTo($('.' + acto[g]));
//                showErrorOn($('.' + acto[g]));
//                $('.' + acto[g]).parents('.required').find('.iferror').html('must be higher date than active from');
//                send = false;
//            }
//        }
    //    }
    

    //for category managemnet
    if ($('.activeto').length != 0) {
        if (Date.parse($('.activefrom').val()) >= Date.parse($('.activeto').val())) {
            if (send) moveTo($('.activeto'));
            showErrorOn($('.activeto'));
            $('.activeto').parents('.required').find('.iferror').html('must be higher date than active from');
            send = false;
            //$(To[vt]).css("background-color","#FFCA85");   
        }
    }

    $(form).removeClass("haserrors");

    //inputs = $(form).find('INPUT[class*="' + classprefix + '"]'); 'INPUT[class!="notTest"]', 
    inputs = $(form).find('INPUT[class*="' + classprefix + '"], INPUT:not(:file), TEXTAREA, .required SELECT');

    $.each(inputs, function(i, val) {
        input = $(val);
        //        if (input.attr('offsetWidth') != 0) {
        switch (input.attr('type')) {
        case 'select-one':
            if (input.get(0)[input.attr('selectedIndex')].text == '') {
                if (send) moveTo(input);
                showErrorOn(input);
                send = false;
            }
            break;
        case 'radio':
            if (window.radioGroups[input.attr('name')] === undefined) radioGroups[input.attr('name')] = new Array();
            radioGroups[input.attr('name')][radioGroups[input.attr('name')].length] = input;
            break;
        //                case 'checkbox': 
        //                    if (!input.attr('checked')) { 
        //                        if (send) moveTo(input); 
        //                        showErrorOn(input); 
        //                        send = false; 
        //                    } 
        //                    break; 
        case 'file':
            if (!isFilled(input)) {
                if (send) moveTo(input);
                showErrorOn(input);
                send = false;
            }
            break;
        case 'password':
            if (input.hasClass(classprefix + 'PasswordConfirm')) {
                if (input.val() != password) {
                    if (send) moveTo(input);
                    showErrorOn(input);
                    send = false;
                }
            } else {
                password = input.val();
            }
            break;
        case 'textarea':
            if ((isFilled(input) || isRequired(input)) && (!isValid(input))) {
                if (send) moveTo(input);
                showErrorOn(input);
                send = false;
            }
            break;
        case 'text':
            if ((isFilled(input) || isRequired(input)) && (!isValid(input))) {
                if (send) moveTo(input);
                showErrorOn(input);
                send = false;
            }
            break;
        default:
            break;
        }
        //        }
    });

    for (var i in radioGroups) {
        for (var j in radioGroups[i]) {
            if (radioGroups[i][j].attr('checked')) {
                break;
            }
        }
        if (!radioGroups[i][j].attr('checked')) {
            for (var j in radioGroups[i]) {
                if (send) moveTo(radioGroups[i][j]);
                showErrorOn(radioGroups[i][j]);
            }
            send = false;
        }
    }
    return send;
}


function isRequired(input) {
    return input.parents(".required").length != 0;
}

function isFilled(input) {
    hintText = '';
    //clear HINTs before validation
    if (input.attr('title').indexOf("**") == 0) {
        var hintText = input.attr('title').substring(2);
    } else if (input.attr('title').indexOf("*") == 0) {
        var hintText = input.attr('title').substring(1);
    } //end clear hints
    return input.val() != hintText && input.val() != '';
}

function isValid(input) {
    if (!isFilled(input)) return false;
    string = input.attr('class');
    value = input.val();
    start = string.indexOf(classprefix);
    type = '';
    result = true;
    while (result && string != "notTest") {
        if (start == -1 ||
            string.charAt((start + classprefix.length)) == ' ' ||
                string.charAt((start + classprefix.length)) != string.charAt((start + classprefix.length)).toUpperCase()) {
            break;
        } else {
            for (i = start; i < string.length; i++) {
                if (string.charAt(i) == ' ') {
                    break;
                }
                type += string.charAt(i);
            }
            if (!isTypeValid(type, value)) {
                result = false;
                break;
            }
            start = string.indexOf(classprefix, start + 1);
        }
    }
    return result;
}

function isTypeValid(type, value) {

    if (type == classprefix + 'Text') {
        return true;
    }

    if (type == classprefix + 'Integer') {
        return ((value.match( /^(\+|-)?\d+$/ )) && (value != ''));
        //return ((value.match(/^[\d|,|\.|\s]*$/)) && (value != ''));
    }

    if (type == classprefix + 'Url') {
        return (value.match( /^(https?:\/\/)?(([0-9a-z_!~*'().&=+$%-]+: )?[0-9a-z_!~*'().&=+$%-]+@)?(([0-9]{1,3}\.){3}[0-9]{1,3}|([0-9a-z_!~*'()-]+\.)*([0-9a-z][0-9a-z-]{0,61})?[0-9a-z]\.[a-z]{2,6})(:[0-9]{1,4})?((\/?)|(\/[0-9a-z_!~*'().;?:@&=+$,%#-]+)+\/?)$/ ));
    }

    if (type == classprefix + 'MultipleWords') {
        return value.match( /^.*[^^]\s[^$].*$/ );
    }

    if (type == classprefix + 'Email') {
        if (value.indexOf("@example.com") > -1) {
            return false;
        }
        ;
        var emailFilter = /^.+@.+\..{2,}$/ ;
        var illegalChars = /[\(\)\<\>\,\;\:\\\/\"\[\]]/
        if (!(emailFilter.test(value)) || value.match(illegalChars)) {
            return (false);
        } else {
            return (true);
        }
        return false;
    }

    if (type == classprefix + 'AlphabetsOnly') {
        if (value.match( /^[a-zA-Z]+$/ )) {
            return true;
        } else {
            return false;
        }
    }

    if (type == classprefix + 'AlphaNumeric') {
        if (value.match( /^[a-zA-Z0-9]+$/ )) {
            return true;
        } else {
            return false;
        }
    }

    if (type == classprefix + 'Decimal') {
        if (value.match( /^\$?[0-9][0-9]{0,30}(,[0-9]{3})*(\.[0-9]{0,16})?$/ )) {
            return true;
        } else {
            return false;
        }
    }

    if (type == classprefix + 'Price') {
        ///^\$?[1-9][0-9]{0,10}(,[0-9]{3})*(\.[0-9]{0,2})?$/
        if (value.match( /^\$?[0-9]{0,10}(,[0-9]{3})*(\.[0-9]{0,2})?$/ )) {
            if (value.match( /\.[0-9]$/ )) {
                value += "0";
            } else if (value.match( /\.$/ )) {
                value += "00";
            } else if (!value.match( /\.[0-9]{2}$/ )) {
                value += ".00";
            }
            return true;
        } else {
            return false;
        }
    }

    if (typeof isTypeValidExt == 'function') {
        fr = isTypeValidExt(classprefix, type, value);
        if (isTypeValidExt(classprefix, type, value) === false) {
            return false;
        } else {
            return true;
        }
    }
    return true;
}

function moveTo(input) {
    var targetOffset = input.offset().top - 40;
    $('html,body').animate({ scrollTop: targetOffset }, 200);
    input.get(0).focus();
}

function showErrorOn(input) {
    input.bind('focus.rmErrorClass', function() {
        rmErrorClass(this);
    });
    input.bind('mousedown.rmErrorClass', function() {
        rmErrorClass(this);
    });
    input.bind('keydown.rmErrorClass', function() {
        rmErrorClass(this);
    });
    input.addClass("error");
    //input.parents(".required, .field, TR").addClass("error");
    //input.parents(".field").addClass("error");
    input.parents(".text").addClass("error");
    input.parents(".field").addClass("diverror");
    //var index = input.parents(".field").parent('DIV').html();
    //input.parents(".field").prev('DIV').attr("aria-expanded", "true");
    //alert(index);

}

function rmErrorClass(elm) {
    var ediv = $(elm).parents(".diverror");
    var etag = $(elm).parents(".error");
    var eform = $(elm).parents('FORM');
    $(ediv).removeClass("diverror");
    $(elm).removeClass("error");
    $(elm).unbind('.rmErrorClass'); //no further clicks will trigger rmErrorClass();
    if (etag) {
        $(etag).removeClass("error");
    }
    ;
}