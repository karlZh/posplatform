<%@ page import="posscard.Supplier" %>


<g:hiddenField name="parentId" value="0" />
<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'name', 'error')} required form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="supplier.name.label" default="供应商姓名" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" maxlength="10" required="" value="${supplierInstance?.name}"/>
	</div>
</div>
<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'type', 'error')} required form-group">
	<label for="type" class="col-sm-2 control-label">
		<g:message code="supplier.type.label" default="供应商类型" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
		<g:select id="type" name="type" from="${supplierType}" optionKey="key" optionValue="value" required="" value="${supplierInstance?.type}" />
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
	<g:textField class="form-control" name="address"  maxlength="255" value="${supplierInstance?.address}"/>
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