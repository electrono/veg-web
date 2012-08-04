<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CategoryViewer.ascx.cs"
            Inherits="Modules_CategoryLister_CategoryViewer" %>
<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var itemPath = '';

    //jQuery.noConflict();
    $(document).ready(function() {
        BindCategory();
    });

    function fixedEncodeURIComponent(str) {
        return encodeURIComponent(str).replace( /!/g , '%21').replace( /'/g , '%27').replace( /\(/g , '%28').
            replace( /\)/g , '%29').replace( /\*/g , '%2A');
    }

    function BindCategory() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetCategoryMenuList",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, cultureName: cultureName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                if (msg.d.length > 0) {
                    var categoryID = '';
                    var parentID = '';
                    var categoryLevel = '';
                    var attributeValue;
                    var catListmaker = '';
                    var catList = '';
                    catListmaker += "<div class=\"cssClassNavigation\"><ul>";
                    $.each(msg.d, function(index, eachCat) {
                        categoryID = eachCat.CategoryID;
                        parentID = eachCat.ParentID;
                        categoryLevel = eachCat.CategoryLevel;
                        attributeValue = eachCat.AttributeValue;
                        if (eachCat.CategoryLevel == 0) {
                            var hrefParentCategory = aspxRedirectPath + "category/" + fixedEncodeURIComponent(eachCat.AttributeValue) + ".aspx";
                            catListmaker += "<li><a href=" + hrefParentCategory + ">";
                            catListmaker += eachCat.AttributeValue;
                            catListmaker += "</a>";

                            if (eachCat.ChildCount > 0) {
                                catListmaker += "<ul>";
                                itemPath += eachCat.AttributeValue;
                                catListmaker += BindChildCategory(msg.d, categoryID);
                                catListmaker += "</ul>";
                            }
                            catListmaker += "</li>";
                        }
                        itemPath = '';
                    });
                    catListmaker += "<div class=\"cssClassclear\"></div></ul></div>";
                    $("#divCategoryLister").html(catListmaker);
                    if ($('#breadcrumb').length > 0) {
                        if (aspxRootPath == "/") {
                            getBreadcrumforlive();
                        } else {
                            getBreadcrum();
                        }
                    }
                } else {
                    $("#divCategoryLister").html("<span class=\"cssClassNotFound\">This store has no category found!</span>");
                }
            },
            error: function() {
                alert("error");
            }
        });
    }

    function BindChildCategory(response, categoryID) {
        var strListmaker = '';
        var childNodes = '';
        var path = '';
        itemPath += "/";
        $.each(response, function(index, eachCat) {
            if (eachCat.CategoryLevel > 0) {
                if (eachCat.ParentID == categoryID) {

                    var hrefCategory = aspxRedirectPath + "category/" + fixedEncodeURIComponent(eachCat.AttributeValue) + ".aspx";
                    itemPath += eachCat.AttributeValue;
                    strListmaker += "<li><a href=" + hrefCategory + ">" + eachCat.AttributeValue + "</a>";
                    childNodes = BindChildCategory(response, eachCat.CategoryID);
                    //x.replace("$", "");
                    //alert(itemPath + '::' + eachCat.AttributeValue + '::' + itemPath.lastIndexOf(eachCat.AttributeValue));
                    itemPath = itemPath.replace(itemPath.lastIndexOf(eachCat.AttributeValue), '');
                    if (childNodes != '') {
                        strListmaker += "<ul>" + childNodes + "</ul>";
                    }
                    strListmaker += "</li>";
                }
            }
        });
        return strListmaker;
    }
</script>
<div class="cssClassNavigationWrapper" id="divCategoryLister">
</div>

<%--<div class="navigation">
    <asp:Literal runat="server" ID="ltrlCategryLister">
    </asp:Literal>
</div>--%>