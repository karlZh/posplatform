<%@ page import="posscard.Test" %>



<div class="fieldcontain ${hasErrors(bean: testInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="test.name.label" default="Name" />
		
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="name" value="${testInstance?.name}"/>
	</div>
</div>

