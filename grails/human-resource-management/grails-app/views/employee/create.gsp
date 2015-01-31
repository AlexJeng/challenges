<!DOCTYPE html>
<html>
  <head>
    <meta name="layout" content="main">
    <title><g:message code="employee.create.label"/></title>
    <tmpl:datepicker/>
  </head>
  <body>
    <g:render template="nav" model="${tab}"/>
    <div id="create-employee" class="content scaffold-create" role="main">
      <h1><g:message code="employee.create.label"/></h1>

      <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
      </g:if>

      <g:hasErrors bean="${employeeInstance}">
        <ul class="errors" role="alert">
          <g:eachError bean="${employeeInstance}" var="error">
            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
          </g:eachError>
        </ul>
      </g:hasErrors>

      <g:form action="save" >
        <fieldset class="form">
          <g:render template="form"/>
        </fieldset>

        <fieldset class="buttons">
          <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label')}"/>
        </fieldset>
      </g:form>
    </div>
  </body>
</html>
