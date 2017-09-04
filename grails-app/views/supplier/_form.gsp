<%@ page import="posscard.Supplier" %>



<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="supplier.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${supplierInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="supplier.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${supplierInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'parentId', 'error')} required">
	<label for="parentId">
		<g:message code="supplier.parentId.label" default="Parent Id" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="parentId" type="number" value="${supplierInstance.parentId}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'phone', 'error')} ">
	<label for="phone">
		<g:message code="supplier.phone.label" default="Phone" />
		
	</label>
	<g:textField name="phone" value="${supplierInstance?.phone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'price', 'error')} required">
	<label for="price">
		<g:message code="supplier.price.label" default="Price" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="price" value="${fieldValue(bean: supplierInstance, field: 'price')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'ratio', 'error')} required">
	<label for="ratio">
		<g:message code="supplier.ratio.label" default="Ratio" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="ratio" value="${fieldValue(bean: supplierInstance, field: 'ratio')}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'remark', 'error')} ">
	<label for="remark">
		<g:message code="supplier.remark.label" default="Remark" />
		
	</label>
	<g:textField name="remark" value="${supplierInstance?.remark}"/>
</div>

