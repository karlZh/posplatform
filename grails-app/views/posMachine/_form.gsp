<%@ page import="posscard.PosMachine" %>



<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="posMachine.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
<<<<<<< HEAD
	<g:field name="supplierId" type="number" value="${posMachineInstance.supplierId}" required=""/>
=======
	<g:select id="supplierId" name="supplierId.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${posMachineInstance?.supplierId?.id}" class="many-to-one"/>
>>>>>>> cb6f977e8cb707ad9d1e35fee36052ff4f7d32c9
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'userId', 'error')} required form-group">
	<label for="userId" class="col-sm-2 control-label">
		<g:message code="posMachine.userId.label" default="User Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="userId" type="number" value="${posMachineInstance.userId}" required=""/>
	</div>
</div>

