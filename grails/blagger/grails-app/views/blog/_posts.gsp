<g:each in="${posts}" var="post">
    <h1>${post.title}</h1>
    <p class="lead">By <span class="text-info">${post.email}</span> on <g:formatDate format="dd/MM/yyyy @ HH:mm" date="${post.dateCreated}"/></p>

    <p>${post.content}</p>

    <g:if test="${post.category}">
        <div class="label label-info">
            ${post.category.tagName}
        </div>
    </g:if>

    <hr/>
</g:each>
<g:paginate class="btn" controller="blog" action="${actionName}" max="5" total="${postsCount}" params="['tagName': params.tagName]" />
