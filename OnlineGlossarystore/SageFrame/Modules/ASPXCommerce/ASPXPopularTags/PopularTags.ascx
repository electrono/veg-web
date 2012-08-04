<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PopularTags.ascx.cs" Inherits="Modules_ASPXPopularTags_PopularTags" %>

<script type="text/javascript">

    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';

    var popularTagsCount = '<%= noOfPopTags %>';

    $(document).ready(function() {
        BindAllPopularTags();
    });

    function BindAllPopularTags() {
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllPopularTags",
            data: JSON2.stringify({ storeID: storeId, portalID: portalId, userName: userName, count: popularTagsCount }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(msg) {
                if (msg.d.length > 0) {
                    var totalTagCount = 0;
                    var tagCount = 0;
                    //create list for tag links
                    $("<ul>").attr("id", "tagList").appendTo("#divPopularTags");
                    $.each(msg.d, function(index, item) {
                        if (index == 0) {
                            tagCount = item.RowTotal;
                        }
                        //create item
                        var li = $("<li>");
                        // alert(item.ItemIDs);
                        $("<a>").text(item.Tag).attr({ title: "See all items tagged with " + item.Tag, href: aspxRedirectPath + 'tagsitems/tags.aspx?tagsId=' + item.ItemTagIDs + '' }).appendTo(li);

                        totalTagCount = item.TagCount;
                        //set tag size
                        li.children().css("fontSize", (totalTagCount / 10 < 1) ? totalTagCount / 10 + 1 + "em" : (totalTagCount / 10 > 2) ? "2em" : totalTagCount / 10 + "em");

                        //add to list
                        li.appendTo("#tagList");
                    });
                    if (tagCount > popularTagsCount && tagCount > 0) {
                        $("#divViewAllTags").html('<a href="' + aspxRedirectPath + 'tags/alltags.aspx" title="View all tags">View All Tags</a>');
                        $("#divViewAllTags").show();
                    } else {
                        $("#divViewAllTags").hide();
                    }
                } else {
                    $("#divPopularTags").html("<span class=\"cssClassTagsNotFound\">Not any items have been tagged yet!</span>");
                    $("#divViewAllTags").hide();
                }
            }
//            ,
//            error: function() {
//                alert("Failed!");
//            }
        });
    }

</script>

<div class="cssClassCommonSideBox">
    <h2>
        <asp:Label ID="lblPopularTagsTitle" runat="server" Text="Popular Tags" CssClass="cssClassPopularTags"></asp:Label>
    </h2>
    <div id="divPopularTags" class="cssClassPopularTags">
    </div>
    <div class="cssClassClear">
    </div>
    <div id="divViewAllTags" class="cssClassViewAllTags">
    </div>
    <div class="cssClassClear">
    </div>
</div>