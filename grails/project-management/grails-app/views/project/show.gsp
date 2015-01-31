
<%@ page import="co.uk.tribalddb.Project" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-project" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-project" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list project">
			
				<g:if test="${projectInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="project.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${projectInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.code}">
				<li class="fieldcontain">
					<span id="code-label" class="property-label"><g:message code="project.code.label" default="Code" /></span>
					
						<span class="property-value" aria-labelledby="code-label"><g:fieldValue bean="${projectInstance}" field="code"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.techLead}">
				<li class="fieldcontain">
					<span id="techLead-label" class="property-label"><g:message code="project.techLead.label" default="Tech Lead" /></span>
					
						<span class="property-value" aria-labelledby="techLead-label"><g:fieldValue bean="${projectInstance}" field="techLead"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.manager}">
				<li class="fieldcontain">
					<span id="manager-label" class="property-label"><g:message code="project.manager.label" default="Manager" /></span>
					
						<span class="property-value" aria-labelledby="manager-label"><g:fieldValue bean="${projectInstance}" field="manager"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.priority}">
				<li class="fieldcontain">
					<span id="priority-label" class="property-label"><g:message code="project.priority.label" default="Priority" /></span>
					
						<span class="property-value" aria-labelledby="priority-label"><g:fieldValue bean="${projectInstance}" field="priority"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.delivery}">
				<li class="fieldcontain">
					<span id="delivery-label" class="property-label"><g:message code="project.delivery.label" default="Delivery" /></span>
					
						<span class="property-value" aria-labelledby="delivery-label"><g:formatDate date="${projectInstance?.delivery}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${projectInstance?.phase}">
				<li class="fieldcontain">
					<span id="phase-label" class="property-label"><g:message code="project.phase.label" default="Phase" /></span>
					
						<span class="property-value" aria-labelledby="phase-label"><g:fieldValue bean="${projectInstance}" field="phase"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${projectInstance?.id}" />
					<g:link class="edit" action="edit" id="${projectInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
