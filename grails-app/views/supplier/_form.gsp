<%@ page import="posscard.Supplier" %>



<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'address', 'error')}  form-group">
	<label for="address" class="col-sm-2 control-label">
		<g:message code="supplier.address.label" default="Address" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="address" value="${supplierInstance?.address}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="supplier.name.label" default="Name" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" value="${supplierInstance?.name}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'parentId', 'error')} required form-group">
	<label for="parentId" class="col-sm-2 control-label">
		<g:message code="supplier.parentId.label" default="Parent Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="parentId" type="number" value="${supplierInstance.parentId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'phone', 'error')}  form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="supplier.phone.label" default="Phone" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" value="${supplierInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'posmachine', 'error')}  form-group">
	<label for="posmachine" class="col-sm-2 control-label">
		<g:message code="supplier.posmachine.label" default="Posmachine" />
		
	</label>
	<div class="col-sm-6">
	<g:select name="posmachine" from="${posscard.PosMachine.list()}" multiple="multiple" optionKey="id" size="5" value="${supplierInstance?.posmachine*.id}" class="many-to-many"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'price', 'error')} required form-group">
	<label for="price" class="col-sm-2 control-label">
		<g:message code="supplier.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="price" value="${fieldValue(bean: supplierInstance, field: 'price')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'ratio', 'error')} required form-group">
	<label for="ratio" class="col-sm-2 control-label">
		<g:message code="supplier.ratio.label" default="Ratio" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="ratio" value="${fieldValue(bean: supplierInstance, field: 'ratio')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'remark', 'error')}  form-group">
	<label for="remark" class="col-sm-2 control-label">
		<g:message code="supplier.remark.label" default="Remark" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="remark" value="${supplierInstance?.remark}"/>
	</div>
</div>

