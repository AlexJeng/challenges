
<%@ page import="co.uk.tribalddb.Project" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'project.label', default: 'Project')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-project" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-project" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="name" title="${message(code: 'project.name.label', default: 'Name')}" />
					
						<g:sortableColumn property="code" title="${message(code: 'project.code.label', default: 'Code')}" />
					
						<g:sortableColumn property="techLead" title="${message(code: 'project.techLead.label', default: 'Tech Lead')}" />
					
						<g:sortableColumn property="manager" title="${message(code: 'project.manager.label', default: 'Manager')}" />
					
						<g:sortableColumn property="priority" title="${message(code: 'project.priority.label', default: 'Priority')}" />
					
						<g:sortableColumn property="delivery" title="${message(code: 'project.delivery.label', default: 'Delivery')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${projectInstanceList}" status="i" var="projectInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${projectInstance.id}">${fieldValue(bean: projectInstance, field: "name")}</g:link></td>
					
						<td>${fieldValue(bean: projectInstance, field: "code")}</td>
					
						<td>${fieldValue(bean: projectInstance, field: "techLead")}</td>
					
						<td>${fieldValue(bean: projectInstance, field: "manager")}</td>
					
						<td>${fieldValue(bean: projectInstance, field: "priority")}</td>
					
						<td><g:formatDate date="${projectInstance.delivery}" /></td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
		</div>
	</body>
</html>
