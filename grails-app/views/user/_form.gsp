<%@ page import="posscard.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountType', 'error')} required form-group">
	<label for="accountType" class="col-sm-2 control-label">
		<g:message code="user.accountType.label" default="Account Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="accountType" type="number" value="${userInstance.accountType}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'createTime', 'error')} required form-group">
	<label for="createTime" class="col-sm-2 control-label">
		<g:message code="user.createTime.label" default="Create Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="createTime" type="number" value="${userInstance.createTime}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')}  form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="Password" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="password" value="${userInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')}  form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="user.phone.label" default="Phone" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" value="${userInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="user.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="supplierId" type="number" value="${userInstance.supplierId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')}  form-group">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="Username" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="username" value="${userInstance?.username}"/>
	</div>
</div>

