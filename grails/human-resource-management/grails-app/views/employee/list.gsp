<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <title><g:message code="employee.list.label"/></title>
    <tmpl:datepicker/>
  </head>
  <body>
    <g:render template="nav" model="${tab}"/>
    <div id="list-employee" class="content scaffold-list" role="main">
      <h1><g:message code="employee.list.label"/></h1>

      <div id="filter" class="nav">
        <g:form action="filter">
          <label for="fromDate">
            <g:message code="filter.date.label.from"/>
          </label>
          <input type="text" class="datepicker" name="fromDate" value="${cmd?.fromDate?.format(grailsApplication.config.datePattern)}"/>

          <label for="toDate">
            <g:message code="filter.date.label.to"/>
          </label>
          <input type="text" class="datepicker" name="toDate" value="${cmd?.toDate?.format(grailsApplication.config.datePattern)}"/>

          <g:submitButton name="filter" value="${message(code: 'filter.date.button')}"/>
        </g:form>
      </div>

      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>

      <table>
        <thead>
          <tr>
            <g:sortableColumn property="fullName" title="${message(code: 'employee.fullName.label')}"/>
            <g:sortableColumn property="startDate" title="${message(code: 'employee.startDate.label')}"/>
            <sec:ifAnyGranted roles="ROLE_HR">
              <g:sortableColumn property="holidayAllowance" title="${message(code: 'employee.holidayAllowance.label')}"/>
            </sec:ifAnyGranted>
          </tr>
        </thead>
        <tbody>
        <g:each in="${employeeInstanceList}" status="i" var="employeeInstance">
          <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
            <td><g:link action="edit" id="${employeeInstance.id}">${fieldValue(bean: employeeInstance, field: "fullName")}</g:link></td>
            <td><g:formatDate format="${grailsApplication.config.datePattern}" date="${employeeInstance.startDate}"/></td>
            <sec:ifAnyGranted roles="ROLE_HR">
              <td>${fieldValue(bean: employeeInstance, field: "holidayAllowance")}</td>
            </sec:ifAnyGranted>
          </tr>
        </g:each>
        </tbody>
      </table>
    </div>
  </body>
</html>
