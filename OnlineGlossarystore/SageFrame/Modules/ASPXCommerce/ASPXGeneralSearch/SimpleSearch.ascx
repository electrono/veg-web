<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SimpleSearch.ascx.cs"
            Inherits="Modules_ASPXGeneralSearch_SimpleSearch" %>

<script type="text/javascript">
    var storeId = '<%= storeID %>';
    var portalId = '<%= portalID %>';
    var userName = '<%= userName %>';
    var cultureName = '<%= cultureName %>';
    var userFriendlyURL = '<%= IsUseFriendlyUrls %>';
    userFriendlyURL = Boolean.parse(userFriendlyURL);

    $(document).ready(function() {
        $('#txtSimpleSearchText').val('');

        LoadAllCategoryForSimpleSearch();
        $('#txtSimpleSearchText').autocomplete({
            source: function(request, response) {
                $.ajax({
                    url: aspxservicePath + "ASPXCommerceWebService.asmx/GetSearchedTermList",
                    data: JSON2.stringify({ search: $('#txtSimpleSearchText').val(), storeID: storeId, portalID: portalId }),
                    dataType: "json",
                    async: false,
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataFilter: function(data) { return data; },
                    success: function(data) {
                        response($.map(data.d, function(item) {
                            return {
                                value: item.SearchTerm
                            }
                        }))
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                        alert(textStatus);
                    }
                });
            },
            minLength: 2
        });

        $("#btnSimpleSearch").click(function() {
            PassSimpleSearchTerm();
        });
        $("#lnkAdvanceSearch").click(function() {
            if (userFriendlyURL) {
                window.location.href = aspxRedirectPath + "Advance-Search.aspx";
            } else {
                window.location.href = aspxRedirectPath + "Advance-Search";
            }
        });
        $(".cssClassSageSearchBox").each(function() {
            if ($(this).val() == "") {
                $(this).addClass("lightText").val("Search items here...");
            }
        });

        $(".cssClassSageSearchBox").bind("focus", function() {
            if ($(this).val() == "Search items here...") {
                $(this).removeClass("lightText").val("");
            }
            // focus lost action
        });

        $(".cssClassSageSearchBox").bind("blur", function() {
            if ($(this).val() == "") {
                $(this).val("Search items here...").addClass("lightText");
            }
        });

        $("#txtSimpleSearchText").bind("focus", function() {
            $("#txtSimpleSearchText").val("");
        });
        $("#txtSimpleSearchText").keyup(function(event) {
            if (event.keyCode == 13) {
                $("#btnSimpleSearch").click();
            }
        });
    });

    function PassSimpleSearchTerm() {
        var categoryId = $("#ddlSimpleSearchCategory").val();
        var searchText = $("#txtSimpleSearchText").val();

        if (categoryId == "0") {
            categoryId = 0;
        }
        if (searchText == "Search items here...") {
            //alert("Enter search text");
            $("#txtSimpleSearchText").val('*').addClass("cssClassRequired");
            return false;
        } else if ($("#txtSimpleSearchText").val() != '*') {
            //Redirect HERE
            window.location.href = aspxRedirectPath + "search/simplesearch.aspx?cid=" + categoryId + " &q=" + searchText;
            return false;
        }
    }

    function LoadAllCategoryForSimpleSearch() {
        var isActive = true;
        $.ajax({
            type: "POST",
            url: aspxservicePath + "ASPXCommerceWebService.asmx/GetAllCategoryForSearch",
            data: JSON2.stringify({ prefix: '---', isActive: isActive, culture: cultureName, storeID: storeId, portalID: portalId, userName: userName }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function(msg) {
                var Elements = '';
                Elements += '<option value="0">--All Category--</option>';
                $.each(msg.d, function(index, item) {
                    Elements += "<option value=" + item.CategoryID + ">" + item.LevelCategoryName + "</option>";
                });
                $("#ddlSimpleSearchCategory").html(Elements);
            }
        });
    }
</script>

<div class="cssClassSageSearchWrapper">
    <%--<div class="cssClassFormWrapper">--%>
    <ul>
        <li> <select id="ddlSimpleSearchCategory" class="cssClassDropDown">
             </select></li>
        <li>
            <input type="text" id="txtSimpleSearchText" class="cssClassSageSearchBox" /></li>
        <li>
            <input type="button" id="btnSimpleSearch" class="cssClassSageSearchButton" value="Go" /></li>
        <li>  <a href="#" id="lnkAdvanceSearch" class="cssClassAdvanceSearch"> Advanced Search</a></li>
    </ul>
    <%--<a href="#" id="lnkAdvanceSearch" class="cssClassAdvanceSearch">Go For Advanced Search</a>--%>
</div>