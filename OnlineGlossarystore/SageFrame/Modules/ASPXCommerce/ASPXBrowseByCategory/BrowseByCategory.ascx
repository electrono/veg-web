<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BrowseByCategory.ascx.cs"
            Inherits="Modules_ASPXBrowseByCategory_BrowseByCategory" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var categoryId = 0;
    var categoryOptions = '';

    $(document).ready(function() {
        GetShoppingOptionsByCategory();
    });

    function GetShoppingOptionsByCategory() {
        var param = JSON2.stringify({ storeID: storeId, portalID: portalId, categoryID: categoryId, userName: userName, cultureName: cultureName });
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/BindCategoryDetails",
            data: param,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    categoryOptions += "<h2>Browse by</h2><ul>";
                    $.each(msg.d, function(index, item) {
                        BindCategoryDetails(item, index);
                    });
                    categoryOptions += "</ul><div class=\"cssClassclear\"></div>";
                } else {
                    categoryOptions += "<span class=\"cssClassNotFound\">No category with item is found!</span>";
                }
                $("#divCategoryItemsOptions").html(categoryOptions);
            }//,
//            error: function() {
//                alert("Error!");
//            }
        });
    }

    function BindCategoryDetails(response, index) {
        //alert(response.CategoryName);
        categoryOptions += "<li><a href='" + aspxRedirectPath + 'category/' + response.CategoryName + ".aspx' alt='" + response.CategoryName + "' title='" + response.CategoryName + "'>" + response.CategoryName + "</a></li>";
    }
</script>

<div class="cssClassBrowseByCategory" id="divCategoryItemsOptions">
</div>