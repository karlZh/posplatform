<%@ page import="posscard.User" %>


<g:hiddenField name="accountType" value="${accountType}" />
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
	<label for="uTypeId" class="col-sm-2 control-label">
		<g:message code="user.accountType.label" default="用户类别" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
        <g:select name="uTypeId" id="uTypeId" class="form-control" from="${posscard.CardPlatform.findAllByIsdelete(0)}" required="" optionKey="id" optionValue="name" value="${userInstance?.uTypeId}" />
    </div>
</div>