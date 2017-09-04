<%@ page import="posscard.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountType', 'error')} required">
	<label for="accountType">
		<g:message code="user.accountType.label" default="Account Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="accountType" type="number" value="${userInstance.accountType}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} ">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		
	</label>
	<g:textField name="password" value="${userInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')} ">
	<label for="phone">
		<g:message code="user.phone.label" default="Phone" />
		
	</label>
	<g:textField name="phone" value="${userInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'supplierId', 'error')} required">
	<label for="supplierId">
		<g:message code="user.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="supplierId" type="number" value="${userInstance.supplierId}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} ">
	<label for="username">
		<g:message code="user.username.label" default="Username" />
		
	</label>
	<g:textField name="username" value="${userInstance?.username}"/>
</div>

