<%@ page import="posscard.Record" %>



<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'user', 'error')}  form-group">
	<label for="user" class="col-sm-2 control-label">
		<g:message code="record.user.label" default="User" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="user" value="${recordInstance?.user}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'state', 'error')}  form-group">
	<label for="state" class="col-sm-2 control-label">
		<g:message code="record.state.label" default="State" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="state" value="${recordInstance?.state}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: recordInstance, field: 'lastTime', 'error')} required form-group">
	<label for="lastTime" class="col-sm-2 control-label">
		<g:message code="record.lastTime.label" default="Last Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:datePicker name="lastTime" precision="day"  value="${recordInstance?.lastTime}"  />
	</div>
</div>

