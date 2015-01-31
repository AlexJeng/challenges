<%@ page import="co.uk.tribalddb.Project" %>



<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="project.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${projectInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'code', 'error')} required">
	<label for="code">
		<g:message code="project.code.label" default="Code" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="code" required="" value="${projectInstance?.code}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'techLead', 'error')} required">
	<label for="techLead">
		<g:message code="project.techLead.label" default="Tech Lead" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="techLead" required="" value="${projectInstance?.techLead}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'manager', 'error')} required">
	<label for="manager">
		<g:message code="project.manager.label" default="Manager" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="manager" required="" value="${projectInstance?.manager}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'priority', 'error')} required">
	<label for="priority">
		<g:message code="project.priority.label" default="Priority" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="priority" type="number" min="1" value="${projectInstance.priority}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'delivery', 'error')} required">
	<label for="delivery">
		<g:message code="project.delivery.label" default="Delivery" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="delivery" precision="day"  value="${projectInstance?.delivery}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: projectInstance, field: 'phase', 'error')} required">
	<label for="phase">
		<g:message code="project.phase.label" default="Phase" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="phase" from="${co.uk.tribalddb.Phase?.values()}" keys="${co.uk.tribalddb.Phase.values()*.name()}" required="" value="${projectInstance?.phase?.name()}"/>
</div>

