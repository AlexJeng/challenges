
<div class="fieldcontain ${hasErrors(bean: employeeInstance, field: 'fullName', 'error')} required">
  <label for="fullName">
    <g:message code="employee.fullName.label"/>
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="fullName" required="" value="${employeeInstance?.fullName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: employeeInstance, field: 'startDate', 'error')} required">
  <label for="startDate">
    <g:message code="employee.startDate.label"/>
    <span class="required-indicator">*</span>
  </label>
  <input type="text" class="datepicker" name="startDate" value="${employeeInstance?.startDate?.format(grailsApplication.config.datePattern)}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: employeeInstance, field: 'holidayAllowance', 'error')} required">
  <label for="holidayAllowance">
    <g:message code="employee.holidayAllowance.label"/>
    <span class="required-indicator">*</span>
  </label>
  <g:field name="holidayAllowance" type="number" min="20" value="${employeeInstance.holidayAllowance}" required=""/>
</div>
