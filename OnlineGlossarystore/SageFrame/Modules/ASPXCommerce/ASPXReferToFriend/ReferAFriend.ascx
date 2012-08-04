<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferAFriend.ascx.cs"
            Inherits="Modules_ASPXReferToFriend_ReferAFriend" %>

<script type="text/javascript" language="javascript">

    $(document).ready(function() {
        //   $('a.popup').click(function() {
        ShowPopup('a.popupEmailAFriend');
        //    });

        $(".cssClassClose").click(function() {
            $('#fade, #popuprel').fadeOut();
        });

        if (userName.toLowerCase() != "anonymoususer") {
            $("#txtYourName").val(userName);
            $("#txtYourName").attr('disabled', 'disabled');
            $("#txtYourName").attr('readonly', 'readonly');
            $("#txtYourEmail").val(userEmail);
            $("#txtYourEmail").attr('disabled', 'disabled');
            $("#txtYourEmail").attr('readonly', 'readonly');
        } else {
            $("#txtYourName").removeAttr('disabled');
            $("#txtYourName").removeAttr('readonly');
            $("#txtYourEmail").removeAttr('disabled');
            $("#txtYourEmail").removeAttr('readonly');
        }
        var m = $("#EmailForm").validate({
            ignore: ':hidden',
            rules: {
                yourname: "required",
                youremail: "required",
                friendname: "required",
                friendemail: "required",
                subj: "required",
                msg: "required"
            },
            messages: {
                yourname: "at least 2 chars",
                youremail: "*",
                friendname: "at least 2 chars",
                friendemail: "*",
                subj: "at least 2 chars",
                msg: "*"
            }
        });


        $("#btnSendEmail").click(function() {
            if (m.form()) {
                SendEmailToFriend();
                return false;
            } else {
                return false;
            }

        });
    });

    function SendEmailToFriend() {
        var senderName = $("#txtYourName").val();
        var senderEmail = $.trim($("#txtYourEmail").val());
        var receiverName = $("#txtFriendName").val();
        var receiverEmail = $("#txtFriendEmail").val();
        var subject = $("#txtSubject").val();
        var message = $("#txtMessage").val();

        var imgpath = $('.popupEmailAFriend').attr('imagepath');
        imgpath = imgpath.replace('/uploads/', '/uploads/Small/');
        var fullDate = new Date();
        var twoDigitMonth = ((fullDate.getMonth().length + 1) === 1) ? (fullDate.getMonth() + 1) : (fullDate.getMonth() + 1);
        if (twoDigitMonth.length == 2) {
        } else if (twoDigitMonth.length == 1) {
            twoDigitMonth = '0' + twoDigitMonth;
        }
        var currentDate = fullDate.getDate() + "/" + twoDigitMonth + "/" + fullDate.getFullYear();
        var dateyear = fullDate.getFullYear();

        var serverLocation = '<%= Request.ServerVariables["SERVER_NAME"] %>';
        var serverHostLoc = 'http://' + serverLocation;
        var itemprice = $('#spanPrice').html();

        var messageBodyHtml = '';

        messageBodyHtml += '<table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" align="center" cellpadding="0" cellspacing="5" bgcolor="#e0e0e0"><tr>';
        messageBodyHtml += '<td align="center" valign="top"><table width="680" border="0" cellspacing="0" cellpadding="0"><tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr>';
        messageBodyHtml += '<tr> <td><table style="font:12px Arial, Helvetica, sans-serif;" width="680" border="0" cellspacing="0" cellpadding="0"><tr>';
        messageBodyHtml += '<td width="300"><a href="' + serverHostLoc + '" target="_blank" style="outline:none; border:none;"><img src="' + serverHostLoc + aspxTemplateFolderPath + '/images/aspxcommerce.png' + '" width="143" height="62" alt="AspxCommerce" title="AspxCommerce"/></a></td>';
        messageBodyHtml += '<td width="191" align="left" valign="middle">&nbsp;</td><td width="189" align="right" valign="middle"><b style="padding:0 20px 0 0; text-shadow:1px 1px 0 #fff;"> ' + currentDate + '</b></td>';
        messageBodyHtml += '</tr></table></td> </tr><tr> <td><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td> </tr> <tr><td bgcolor="#fff"><div style="border:1px solid #c7c7c7; background:#fff; padding:20px">';
        messageBodyHtml += '<table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#FFFFFF"><tr><td><p style="font-family:Arial, Helvetica, sans-serif; font-size:17px; line-height:16px; color:#278ee6; margin:0; padding:0 0 10px 0; font-weight:bold; text-align:left;">Your Friend ';
        messageBodyHtml += '' + senderName + ' want to say Take a look at this !!</p></td> </tr>';

        messageBodyHtml += '<tr><td><span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;"><strong>' + senderName.toUpperCase() + '</strong> says-"' + message + '" </span></td></tr></table><table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0">';
        messageBodyHtml += '<tr> <td><table style="font:12px Arial, Helvetica, sans-serif;" width="100%" border="0" cellspacing="0" cellpadding="0">  <tr>';
        messageBodyHtml += '<td width="33%"><div style="border:1px solid #cfcfcf; background:#f1f1f1; padding:10px; text-align:center;"> ';

        messageBodyHtml += '<img src="' + serverHostLoc + "/" + imgpath + '" alt="Picture" width="250" />';
        messageBodyHtml += '<p style="margin:0; padding:5px 0 0 0; font-family:Arial, Helvetica, sans-serif; font-size:12px; font-weight:normal; line-height:18px;"> <span style="font-weight:bold; font-size:12px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;">';
        messageBodyHtml += '' + $('#spanItemName').html() + '</span><br />';
        messageBodyHtml += '<span style="font-weight:bold; font-size:11px; font-family:Arial, Helvetica, sans-serif; text-shadow:1px 1px 0 #fff;">Price:</span>';
        messageBodyHtml += '' + itemprice + '<br />';
        messageBodyHtml += '<span style="font-weight:bold; font-size:12px; font-family:Arial, Helvetica, sans-serif;text-decoration:blink; text-shadow:1px 1px 0 #fff;"><a style="color: rgb(39, 142, 230);" href="' + window.location + '">click here to view all details</a></span> ';
        messageBodyHtml += '</p> </div></td></tr> </table></td>';
        messageBodyHtml += '</tr></table>  <p style="margin:0; padding:10px 0 0 0; font:bold 11px Arial, Helvetica, sans-serif; color:#666;"> Thank You,<br />';
        messageBodyHtml += '<span style="font-weight:normal; font-size:12px; font-family:Arial, Helvetica, sans-serif;">AspxCommerce Team </span></p></div></td>';
        messageBodyHtml += '</tr><tr><td><img src="' + serverHostLoc + '/blank.gif" width="1" height="20" alt=" "/></td></tr><tr><td align="center" valign="top"><p style="font-size:11px; color:#4d4d4d"> © ';
        messageBodyHtml += '' + dateyear + ' AspxCommerce. All Rights Reserved.</p></td>  </tr><tr><td align="center" valign="top"><img src="' + serverHostLoc + '/blank.gif" width="1" height="10" alt=" " /></td></tr></table></td></tr></table>';
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, itemID: itemId, senderName: senderName, senderEmail: senderEmail, receiverName: receiverName, receiverEmail: receiverEmail, subject: subject, message: message, messageBodyHtml: messageBodyHtml });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/SaveAndSendEmailMessage",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function() {
                csscody.alert("<h2>Information Message</h2><p>Email has been send successfully.</p>");
                ClearForm();
                $('#fade , #popuprel').fadeOut();
            },
            error: function(msg) {
                csscody.alert("<h2>Information Alert</h2><p>Failure sending mail!</p>");
            }
        });
    }

    function ClearForm() {
        if (userName.toLowerCase() != "anonymoususer") {
            $("#txtYourName").val(userName);
            $("#txtYourEmail").val(userEmail);
        } else {
            $("#txtYourName").val('');
            $("#txtYourEmail").val('');
        }
        $("#txtFriendName").val('');
        $("#txtFriendEmail").val('');
        $("#txtSubject").val('');
        $("#txtMessage").val('');
    }
</script>

<form class="cmxform" id="EmailForm" method="post" action="">
    <div class="popupbox" id="popuprel">
        <div class="cssClassCloseIcon">
            <button type="button" class="cssClassClose">
                <span>Close</span></button>
        </div>
        <h2>
            <asp:Label ID="lblTitle" runat="server" Text="Email A Friend"></asp:Label>
        </h2>
        <div class="cssClassFormWrapper">
            <table width="100%" border="0" cellpadding="0" cellspacing="0" id="tblEmailAFriend">
                <tr>
                    <td width="20%">
                        <label id="lblYourName" class="cssClassLabel">
                            Your Name:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td width="80%">
                        <input type="text" id="txtYourName" name="yourname" class="required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="lblYourEmail" class="cssClassLabel">
                            Your Email:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtYourEmail" name="youremail" class="required email" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="lblFriendName" class="cssClassLabel">
                            Friend Name:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtFriendName" name="friendname" class="required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="lblFriendEmail" class="cssClassLabel">
                            Friend Email:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtFriendEmail" name="friendemail" class="required email" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="lblSubject" class="cssClassLabel">
                            Subject:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <input type="text" id="txtSubject" name="subj" class="required" minlength="2" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <label id="lblMessage" class="cssClassLabel">
                            Message:<span class="cssClassRequired">*</span></label>
                    </td>
                    <td>
                        <textarea id="txtMessage" cols="30" rows="6" name="msg" class="cssClassTextarea required" maxlength="300"></textarea>
                    </td>
                </tr>
            </table>
            <div class="cssClassButtonWrapper">
                <button type="submit" id="btnSendEmail">
                    <span><span>Submit</span></span></button>
            </div>
        </div>
    </div>
</form>