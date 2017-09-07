<%@ page import="posscard.PosMachine" %>



<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'createTime', 'error')} required form-group">
	<label for="createTime" class="col-sm-2 control-label">
		<g:message code="posMachine.createTime.label" default="Create Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="createTime" type="number" value="${posMachineInstance.createTime}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="posMachine.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="supplierId" type="number" value="${posMachineInstance.supplierId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'userId', 'error')} required form-group">
	<label for="userId" class="col-sm-2 control-label">
		<g:message code="posMachine.userId.label" default="User Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="userId" type="number" value="${posMachineInstance.userId}" required=""/>
	</div>
</div>

