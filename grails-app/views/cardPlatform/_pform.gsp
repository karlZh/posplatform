<%@ page import="posscard.User" %>


<g:hiddenField name="accountType" value="${accountType}" />
<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'username', 'error')} required form-group">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="用户名" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="username" maxlength="10" required="" value="${cardPlatformInstance?.username}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'password', 'error')} required form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="密码" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field type="password" class="form-control" name="password" maxlength="20" required="" value="${cardPlatformInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'phone', 'error')}  form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="user.phone.label" default="电话" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" value="${cardPlatformInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: uTypeId, field: 'uTypeId', 'error')}  form-group">
	<label for="uTypeId" class="col-sm-2 control-label">
		%{--<g:message code="user.uTypeId.label" default="用户类别" />--}%

	</label>
	<div class="col-sm-6">
        <g:hiddenField name="uTypeId" value="${uTypeId}"/>
        %{--<g:select name="uTypeId" id="uTypeId" class="form-control" from="${posscard.CardPlatform.findAllByIsdelete(0)}" required="" optionKey="id" optionValue="name" value="${cardPlatformInstance?.uTypeId}" />--}%
    </div>
</div>