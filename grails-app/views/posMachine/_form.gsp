<%@ page import="posscard.PosMachine" %>



<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="posMachine.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="supplierId" name="supplierId.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${posMachineInstance?.supplierId?.id}" class="many-to-one"/>
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

