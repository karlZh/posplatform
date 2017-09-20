<%@ page import="posscard.PosMachine" %>



<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'supplier', 'error')} required form-group">
	<label for="supplier" class="col-sm-2 control-label">
		<g:message code="posMachine.supplier.label" default="供应商ID" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="supplier" name="supplier.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${posMachineInstance?.supplier?.id}" class="many-to-one"/>
	</div>
</div>

