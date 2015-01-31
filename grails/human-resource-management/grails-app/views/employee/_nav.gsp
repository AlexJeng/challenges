
<div class="nav" role="navigation">
  <ul>
    <li><g:link class="home" uri="/"><g:message code="default.home.label"/></g:link></li>

    <g:if test="${tab == 'list'}">
      <sec:ifAnyGranted roles="ROLE_HR">
        <li><g:link class="create" action="create"><g:message code="employee.new.label"/></g:link></li>
      </sec:ifAnyGranted>
    </g:if>

    <g:if test="${tab == 'create'}">
      <li><g:link class="list" action="list"><g:message code="employee.list.label"/></g:link></li>
    </g:if>

    <g:if test="${tab == 'edit'}">
      <li><g:link class="create" action="create"><g:message code="employee.new.label"/></g:link></li>
    </g:if>

    <li><g:link class="logout" controller="logout"><g:message code="default.button.logout"/></g:link></li>
  </ul>
</div>
