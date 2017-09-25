<%@ page import="posscard.Supplier" %>

<g:hiddenField name="type" value="${pSupplierInstance?.type}"/>
<g:hiddenField name="parentId" value="${pSupplierInstance?.id}"/>
<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')} required form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="supplier.name.label" default="供应商姓名" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" maxlength="10" required="" value="${supplierInstance?.name}"/>
	</div>
</div>
<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'ratio', 'error')} required form-group">
	<label for="ratio" class="col-sm-2 control-label">
		<g:message code="supplier.ratio.label" default="结算比例" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="ratio" value="${fieldValue(bean: supplierInstance, field: 'ratio')}" required=""/>%
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'price', 'error')} required form-group">
	<label for="price" class="col-sm-2 control-label">
		<g:message code="supplier.price.label" default="结算价格" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="price" value="${fieldValue(bean: supplierInstance, field: 'price')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'address', 'error')}  form-group">
	<label for="address" class="col-sm-2 control-label">
		<g:message code="supplier.address.label" default="地址" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="address" value="${supplierInstance?.address}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'phone', 'error')} required form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="supplier.phone.label" default="电话" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" pattern="${supplierInstance.constraints.phone.matches}" required="" value="${supplierInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'remark', 'error')}  form-group">
	<label for="remark" class="col-sm-2 control-label">
		<g:message code="supplier.remark.label" default="备注" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="remark" maxlength="50" value="${supplierInstance?.remark}"/>
	</div>
</div>

<div class="form-group">
	<label class="col-sm-2 control-label">
		<g:message code="supplier.cardBin.label" default="卡BIN" />
	</label>
	<div class="col-sm-6">
		<g:select name="cardbins" from="${posscard.CardBin.list()}" multiple="multiple" optionKey="id" size="5" value="${supplierInstance?.cardbins*.id}" class="many-to-many"/>
	</div>

</div>