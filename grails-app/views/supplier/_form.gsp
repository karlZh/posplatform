<%@ page import="posscard.Supplier" %>



<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')} required form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="supplier.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="name" maxlength="10" required="" value="${supplierInstance?.name}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'ratio', 'error')} required form-group">
	<label for="ratio" class="col-sm-2 control-label">
		<g:message code="supplier.ratio.label" default="Ratio" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="ratio" value="${fieldValue(bean: supplierInstance, field: 'ratio')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'price', 'error')} required form-group">
	<label for="price" class="col-sm-2 control-label">
		<g:message code="supplier.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="price" value="${fieldValue(bean: supplierInstance, field: 'price')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'address', 'error')}  form-group">
	<label for="address" class="col-sm-2 control-label">
		<g:message code="supplier.address.label" default="Address" />
		
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="address" value="${supplierInstance?.address}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'phone', 'error')} required form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="supplier.phone.label" default="Phone" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="phone" pattern="${supplierInstance.constraints.phone.matches}" required="" value="${supplierInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'remark', 'error')}  form-group">
	<label for="remark" class="col-sm-2 control-label">
		<g:message code="supplier.remark.label" default="Remark" />
		
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="remark" maxlength="50" value="${supplierInstance?.remark}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'parentId', 'error')} required form-group">
	<label for="parentId" class="col-sm-2 control-label">
		<g:message code="supplier.parentId.label" default="Parent Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="parentId" type="number" value="${supplierInstance.parentId}" required=""/>
	</div>
</div>

