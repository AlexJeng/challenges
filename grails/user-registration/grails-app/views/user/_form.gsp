
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
  <label for="username">
    <g:message code="user.username.label" default="Username" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'postalCode', 'error')} required">
  <label for="postalCode">
    <g:message code="user.postalCode.label" default="Postal Code" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="postalCode" required="" value="${userInstance?.postalCode}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
  <label for="email">
    <g:message code="user.email.label" default="Email" />
    <span class="required-indicator">*</span>
  </label>
  <g:textField name="email" required="" value="${userInstance?.email}"/>
</div>
