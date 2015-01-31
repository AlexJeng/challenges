<html>

<head></head>

<body>
    <div class="filter hero-unit">
        <h3>Filter by tag name:</h3>
        <g:form controller="blog" action="listByTagName" class="form-inline">
            <g:textField name="tagName" class="typeahead span4 search-query edit-btn-large typeahead" placeholder="Tag name..." autocomplete="off"/>
            <button type="submit" class="btn">
                <i class="icon-search"></i> Filter
            </button>
        </g:form>
    </div>

    <g:render template="posts" model="['posts': posts, 'postsCount': postsCount]"/>
</body>

</html>
