<%@ page import="posscard.Record" %>



<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'user', 'error')} required form-group">
	<label for="user" class="col-sm-2 control-label">
		<g:message code="record.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="user" maxlength="10" required="" value="${recordInstance?.user}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'loginTime', 'error')} required form-group">
	<label for="loginTime" class="col-sm-2 control-label">
		<g:message code="record.loginTime.label" default="Login Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:datePicker name="loginTime" precision="day"  value="${recordInstance?.loginTime}"  />
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'userType', 'error')}  form-group">
	<label for="userType" class="col-sm-2 control-label">
		<g:message code="record.userType.label" default="User Type" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="userType" value="${recordInstance?.userType}"/>
	</div>
</div>

