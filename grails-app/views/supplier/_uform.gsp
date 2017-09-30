<%@ page import="posscard.PosMachine; posscard.User" %>


<g:hiddenField name="accountType" value="${accountType}" />
<g:hiddenField name="uTypeId" value="${uTypeId}" />
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

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'isLeader', 'error')} required form-group">
    <label for="orderType" class="col-sm-2 control-label">
        <g:message code="user.isLeader.label" default="主管" />
        <span class="required-indicator">*</span>
    </label>
    <div class="col-sm-6">
        %{--<g:select name="orderType"  class="form-control"  from="${userInstance.constraints.isLeader.inList}" required="" value="${fieldValue(bean: userInstance, field: 'isLeader')}" valueMessagePrefix="user.isLeader"/>--}%
        <g:select id="isLeader" name="isLeader" from="${isLeader}" optionKey="key" optionValue="value" required="" value="${userInstance?.isLeader}" />
    </div>
</div>