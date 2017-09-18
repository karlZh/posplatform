<%@ page import="posscard.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required form-group">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="用户名" />
		<span class="required-indicator">*</span>
	</label>

  <div class="col-sm-6">
	<g:textField class="form-control" name="username" maxlength="10" required="" value="${userInstance?.username}"/>
	</div>
  </div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="密码" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field type="password" class="form-control" name="password" maxlength="20" required="" value="${userInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')}  form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="user.phone.label" default="电话" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" pattern="${userInstance.constraints.phone.matches}" value="${userInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountType', 'error')}  form-group">
	<label for="accountType" class="col-sm-2 control-label">
		<g:message code="user.accountType.label" default="用户类型" />
		
	</label>
	<div class="col-sm-6">
	<g:select name="accountType" from="${userInstance.constraints.accountType.inList}" value="${fieldValue(bean: userInstance, field: 'accountType')}" valueMessagePrefix="user.accountType" noSelection="['': '']"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="user.supplierId.label" default="供应商ID" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="supplierId" name="supplierId.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${userInstance?.supplierId?.id}" class="many-to-one"/>
	</div>
</div>

