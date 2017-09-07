<%@ page import="posscard.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required form-group">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="Username" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="username" maxlength="10" required="" value="${userInstance?.username}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field type="password" class="form-control" name="password" maxlength="20" required="" value="${userInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')} required form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="user.phone.label" default="Phone" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="phone" pattern="${userInstance.constraints.phone.matches}" required="" value="${userInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="user.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
<<<<<<< HEAD
	<g:textField class="form-control" name="supplierId" required="" value="${userInstance?.supplierId}"/>
=======
	<g:select id="supplierId" name="supplierId.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${userInstance?.supplierId?.id}" class="many-to-one"/>
>>>>>>> cb6f977e8cb707ad9d1e35fee36052ff4f7d32c9
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountType', 'error')} required form-group">
	<label for="accountType" class="col-sm-2 control-label">
		<g:message code="user.accountType.label" default="Account Type" />
		<span class="required-indicator">*</span>
<<<<<<< HEAD
	</label>
	<div class="col-sm-10">
	<g:select name="accountType" from="${userInstance.constraints.accountType.inList}" required="" value="${userInstance?.accountType}" valueMessagePrefix="user.accountType"/>
=======
	</label>
	<div class="col-sm-10">
	<g:select name="accountType" from="${userInstance.constraints.accountType.inList}" required="" value="${userInstance?.accountType}" valueMessagePrefix="user.accountType"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'createTime', 'error')} required form-group">
	<label for="createTime" class="col-sm-2 control-label">
		<g:message code="user.createTime.label" default="Create Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="createTime" type="number" value="${userInstance.createTime}" required=""/>
>>>>>>> cb6f977e8cb707ad9d1e35fee36052ff4f7d32c9
	</div>
</div>

