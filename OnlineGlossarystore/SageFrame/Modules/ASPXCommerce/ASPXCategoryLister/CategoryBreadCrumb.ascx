<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoryBreadCrumb.ascx.cs"
            Inherits="Modules_ASPXCommerce_ASPXCategoryLister_CategoryBreadCrumb" %>

<script type="text/javascript">
    var itmName = '';
    var current = '';
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);
    var itemCat = '';

    $(document).ready(function() {
        if ($('.cssClassNavigation').length == 0) {
            if (aspxRootPath == "/") {
                getBreadcrumforlive();
            } else {
                getBreadcrum();
            }


        }
    });

    function getBreadcrum() {
        var path = window.location.href;
        var cat = path.split('/');


        if (cat[4] == 'category') {
            var x = cat[5];
            x = x.split('.');
            itmName = x[0];
            var tag = new Array();
            var hrefarr = new Array();

            // current = decodeURI(itmName);
            current = decodeURIComponent(itmName);

            var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
            $('.cssClassNavigation a:contains(' + current + ')').parents('li').find('a:eq(0)').each(function() {
                if ($(this).html() != current) {
                    tag.push($(this).html());
                    hrefarr.push($(this).attr('href'));
                }
            });
            hrefarr.reverse();
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul li:gt(0)').remove();
            for (var x in tag.reverse()) {
                $('#breadcrumb ul').append('<li><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
            }
            tag = [];
            hrefarr = [];
            // $('#breadcrumb ul li:last').addClass('last');
            $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
            $('#breadcrumb ul li').not('.last').click(function() {
                if ($(this).attr('class') == 'first') {
                } else {
                    var current = $(this).children().html();
                    //alert(current);
                    $(this).nextAll().remove();
                    $('#breadcrumb li:last').remove();
                    $('#breadcrumb ul').append('<li class="last">' + current + '</li>');
                }
            });
            $('#breadcrumb ul li.first').click(function() {
                // $('#breadcrumb ul').html('');
                //  $('#breadcrumb ul').append('<li class="first"><a href="sageframe/default.aspx" >home</a></li>');
            });
        } else if (cat[4] == 'item') {
            var y = cat[5];
            y = y.split('.');
            itmName = y[0];
            getCategoryForItem(itmName);
        } else if (cat[4] == 'tagsitems') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Tags</li>');
        } else if (cat[4] == 'search') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Search</li>');
        } else if (cat[4] == 'option') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Shopping Options</li>');
        } else if (cat[4] == 'portal') {

            if (cat[6] == 'item') {
                var m = cat[7];
                m = m.split('.');
                itmName = m[0];
                getCategoryForItemPortal(itmName);
            } else if (cat[6] == 'category') {
                var x3 = cat[7];
                x3 = x3.split('.');
                itmName = x3[0];
                var tag = new Array();
                var hrefarr = new Array();

                // current = decodeURI(itmName);
                current = decodeURIComponent(itmName);
                var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
                $('.cssClassNavigation a:contains(' + current + ')').parents('li').find('a:eq(0)').each(function() {
                    if ($(this).html() != current) {
                        tag.push($(this).html());
                        hrefarr.push($(this).attr('href'));
                    }
                });
                hrefarr.reverse();
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }

                for (var x in tag.reverse()) {
                    $('#breadcrumb ul').append('<li><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
                }
                // $('#breadcrumb ul li:last').addClass('last');
                $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
                tag = [];
                hrefarr = [];

//                $('#breadcrumb ul li').not('.last').click(function() {
//                    if ($(this).attr('class') == 'first') {
//                    }
//                    else {
//                        var current3 = $(this).children().html();
//                        //alert(current);
//                        $(this).nextAll().remove();
//                        $('#breadcrumb li:last').remove();
//                        $('#breadcrumb ul').append('<li class="last">' + current3 + '</li>');
//                    }
//                });
            } else if (cat[6] == 'tagsitems') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Tags</li>');
            } else if (cat[6] == 'search') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Search</li>');
            } else if (cat[6] == 'option') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Shopping Options</li>');
            } else {

                var x2 = cat[6];
                if (x2 != undefined) {
                    x2 = x2.split('.')[0];
                }
                x2 = x2.replace(new RegExp("-", "g"), ' ');
                if (x != '' && x2.toLowerCase() != 'default' && x2.toLowerCase() != 'home') {
                    $('#breadcrumb ul').html('');
                    if (userFriendlyURL) {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                    } else {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                    }
                    //$('#breadcrumb ul').append('<li class="first"><a href="' + aspxRedirectPath + 'home.aspx" >home</a></li>');
                    $('#breadcrumb ul').append('<li class="last">' + x2 + '</li>');
                } else {
                    $('#breadcrumb ul').html('');
                    $('#breadcrumb').hide();
                }
            }

        } else {
            var x = cat[4];
            if (x != undefined) {
                x = x.split('.')[0];
            }
            x = x.replace(new RegExp("-", "g"), ' ');
            if (x != '' && x.toLowerCase() != 'default' && x.toLowerCase() != 'home') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }

                // $('#breadcrumb ul').append('<li class="first"><a href="' + aspxRootPath + 'home.aspx" >home</a></li>');
                $('#breadcrumb ul').append('<li class="last">' + x + '</li>');
            } else {
                $('#breadcrumb ul').html('');
                $('#breadcrumb').hide();
            }
        }
    }

    function getBreadcrumforlive() {
        var path = window.location.href;
        var cat = path.split('/');


        if (cat[5] == 'category') {
            var x = cat[6];
            x = x.split('.');
            itmName = x[0];
            var tag = new Array();
            var hrefarr = new Array();

            // current = decodeURI(itmName);
            current = decodeURIComponent(itmName);

            var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
            $('.cssClassNavigation a:contains(' + current + ')').parents('li').find('a:eq(0)').each(function() {
                if ($(this).html() != current) {
                    tag.push($(this).html());
                    hrefarr.push($(this).attr('href'));
                }
            });
            hrefarr.reverse();
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul li:gt(0)').remove();
            for (var x in tag.reverse()) {
                $('#breadcrumb ul').append('<li><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
            }
            tag = [];
            hrefarr = [];
            // $('#breadcrumb ul li:last').addClass('last');
            $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
            $('#breadcrumb ul li').not('.last').click(function() {
                if ($(this).attr('class') == 'first') {
                } else {
                    var current = $(this).children().html();
                    //alert(current);
                    $(this).nextAll().remove();
                    $('#breadcrumb li:last').remove();
                    $('#breadcrumb ul').append('<li class="last">' + current + '</li>');
                }
            });
            $('#breadcrumb ul li.first').click(function() {
                // $('#breadcrumb ul').html('');
                //  $('#breadcrumb ul').append('<li class="first"><a href="sageframe/default.aspx" >home</a></li>');
            });
        } else if (cat[5] == 'item') {
            var y = cat[6];
            y = y.split('.');
            itmName = y[0];
            getCategoryForItem(itmName);
        } else if (cat[5] == 'tagsitems') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Tags</li>');
        } else if (cat[5] == 'search') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Search</li>');
        } else if (cat[5] == 'option') {
            $('#breadcrumb ul').html('');
            if (userFriendlyURL) {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
            } else {
                $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
            }
            $('#breadcrumb ul').append('<li class="last">Shopping Options</li>');
        } else if (cat[5] == 'portal') {

            if (cat[7] == 'item') {
                var m = cat[8];
                m = m.split('.');
                itmName = m[0];
                getCategoryForItemPortal(itmName);
            } else if (cat[7] == 'category') {
                var x3 = cat[8];
                x3 = x3.split('.');
                itmName = x3[0];
                var tag = new Array();
                var hrefarr = new Array();

                // current = decodeURI(itmName);
                current = decodeURIComponent(itmName);
                var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
                $('.cssClassNavigation a:contains(' + current + ')').parents('li').find('a:eq(0)').each(function() {
                    if ($(this).html() != current) {
                        tag.push($(this).html());
                        hrefarr.push($(this).attr('href'));
                    }
                });
                hrefarr.reverse();
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }

                for (var x in tag.reverse()) {
                    $('#breadcrumb ul').append('<li><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
                }
                // $('#breadcrumb ul li:last').addClass('last');
                $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
                tag = [];
                hrefarr = [];

                //                $('#breadcrumb ul li').not('.last').click(function() {
                //                    if ($(this).attr('class') == 'first') {
                //                    }
                //                    else {
                //                        var current3 = $(this).children().html();
                //                        //alert(current);
                //                        $(this).nextAll().remove();
                //                        $('#breadcrumb li:last').remove();
                //                        $('#breadcrumb ul').append('<li class="last">' + current3 + '</li>');
                //                    }
                //                });
            } else if (cat[7] == 'tagsitems') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Tags</li>');
            } else if (cat[7] == 'search') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Search</li>');
            } else if (cat[7] == 'option') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }
                $('#breadcrumb ul').append('<li class="last">Shopping Options</li>');
            } else {

                var x2 = cat[7];
                if (x2 != undefined) {
                    x2 = x2.split('.')[0];
                }
                x2 = x2.replace(new RegExp("-", "g"), ' ');
                if (x != '' && x2.toLowerCase() != 'default' && x2.toLowerCase() != 'home') {
                    $('#breadcrumb ul').html('');
                    if (userFriendlyURL) {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                    } else {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                    }
                    //$('#breadcrumb ul').append('<li class="first"><a href="' + aspxRedirectPath + 'home.aspx" >home</a></li>');
                    $('#breadcrumb ul').append('<li class="last">' + x2 + '</li>');
                } else {
                    $('#breadcrumb ul').html('');
                    $('#breadcrumb').hide();
                }
            }

        } else {
            var x = cat[5];
            if (x != undefined) {
                x = x.split('.')[0];
            }
            x = x.replace(new RegExp("-", "g"), ' ');
            if (x != '' && x.toLowerCase() != 'default' && x.toLowerCase() != 'home') {
                $('#breadcrumb ul').html('');
                if (userFriendlyURL) {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                } else {
                    $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                }

                // $('#breadcrumb ul').append('<li class="first"><a href="' + aspxRootPath + 'home.aspx" >home</a></li>');
                $('#breadcrumb ul').append('<li class="last">' + x + '</li>');
            } else {
                $('#breadcrumb ul').html('');
                $('#breadcrumb').hide();
            }
        }
    }


    function getCategoryForItemPortal(itmName) {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryForItem",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, itemSku: itmName }),
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d != null) {
                    itemCat = msg.d;
                    var tag = new Array();
                    var hrefarr = new Array();
                    tag = [];
                    hrefarr = [];
                    $('#breadcrumb ul').html('');
                    // current = decodeURI(itmName);
                    current = decodeURIComponent(itmName);

                    var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
                    $('.cssClassNavigation a:contains(' + itemCat + ')').parents('li').find('a:eq(0)').each(function() {
                        if ($(this).html() != current) {
                            tag.push($(this).html());
                            hrefarr.push($(this).attr('href'));
                        }
                    });
                    hrefarr.reverse();
                    $('#breadcrumb ul').html('');
                    // $('#breadcrumb ul').append('<li class="first"><a href="' + aspxRedirectPath + 'home.aspx" >home</a></li>');
                    if (userFriendlyURL) {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                    } else {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                    }
                    for (var x in tag.reverse()) {
                        $('#breadcrumb ul').append('<li ><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
                    }
                    // $('#breadcrumb ul li:last').addClass('last');
                    $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
                    tag = [];
                    hrefarr = [];

                    //  $('#breadcrumb ul li').not('.last').click(function() {
                    //    if ($(this).attr('class') == 'first') {
                    //    }
                    //   else {
                    //        var current = $(this).children().html();
                    //        $(this).nextAll().remove();
                    //        $('#breadcrumb li:last').remove();
                    //        $('#breadcrumb ul').append('<li class="last">' + current + '</li>');
                    //      }
                    //   });

                } else {
                    $('#breadcrumb li:last').remove();
                }
            },
            error: function(errorMessage) {

            }
        });
    }

    function getCategoryForItem(itmName) {
        $.ajax({
            type: 'post',
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryForItem",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, itemSku: itmName }),
            contentType: "application/json; charset=utf-8",
            dataType: 'json',
            success: function(msg) {
                if (msg.d != null) {
                    itemCat = msg.d;
                    var tag = new Array();
                    var hrefarr = new Array();

                    // current = decodeURI(itmName);
                    current = decodeURIComponent(itmName);

                    var href = $(".cssClassNavigation a:contains(" + current + ")").attr('href');
                    $('.cssClassNavigation a:contains(' + itemCat + ')').parents('li').find('a:eq(0)').each(function() {
                        if ($(this).html() != current) {
                            tag.push($(this).html());
                            hrefarr.push($(this).attr('href'));
                        }
                    });
                    hrefarr.reverse();
                    $('#breadcrumb ul').html('');
                    if (userFriendlyURL) {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home.aspx' + ' >home</a></li>');
                    } else {
                        $('#breadcrumb ul').append('<li class="first"><a href=' + aspxRedirectPath + 'home' + ' >home</a></li>');
                    }
                    $('#breadcrumb ul li:gt(0)').remove();
                    for (var x in tag.reverse()) {
                        $('#breadcrumb ul').append('<li ><a href="' + hrefarr[x] + '">' + tag[x] + '</a></li>');
                    }

                    // $('#breadcrumb ul li:last').addClass('last');
                    $('#breadcrumb ul').append('<li class="last">' + current + ' </li>');
                    tag = [];
                    hrefarr = [];

                    $('#breadcrumb ul li').not('.last').click(function() {
                        if ($(this).attr('class') == 'first') {
                        } else {
                            var current = $(this).children().html();
                            $(this).nextAll().remove();
                            $('#breadcrumb li:last').remove();
                            $('#breadcrumb ul').append('<li class="last">' + current + '</li>');
                        }
                    });
                } else {
                    $('#breadcrumb li:last').remove();
                }
            },
            error: function(errorMessage) {

            }
        });
    }
</script>

<div id="breadcrumb" class="breadCrumb">
    <ul>      
    </ul>
</div>