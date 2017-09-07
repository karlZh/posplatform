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

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'remark', 'error')} required form-group">
	<label for="remark" class="col-sm-2 control-label">
		<g:message code="supplier.remark.label" default="Remark" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:textField class="form-control" name="remark" maxlength="50" required="" value="${supplierInstance?.remark}"/>
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

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'createTime', 'error')} required form-group">
	<label for="createTime" class="col-sm-2 control-label">
		<g:message code="supplier.createTime.label" default="Create Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="createTime" type="number" value="${supplierInstance.createTime}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'posmachine', 'error')}  form-group">
	<label for="posmachine" class="col-sm-2 control-label">
		<g:message code="supplier.posmachine.label" default="Posmachine" />
		
	</label>
	<div class="col-sm-10">
	
<ul class="one-to-many">
<g:each in="${supplierInstance?.posmachine?}" var="p">
    <li><g:link controller="posMachine" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="posMachine" action="create" params="['supplier.id': supplierInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'posMachine.label', default: 'PosMachine')])}</g:link>
</li>
</ul>

	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'tickettype', 'error')}  form-group">
	<label for="tickettype" class="col-sm-2 control-label">
		<g:message code="supplier.tickettype.label" default="Tickettype" />
		
	</label>
	<div class="col-sm-10">
	
<ul class="one-to-many">
<g:each in="${supplierInstance?.tickettype?}" var="t">
    <li><g:link controller="ticketType" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="ticketType" action="create" params="['supplier.id': supplierInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'ticketType.label', default: 'TicketType')])}</g:link>
</li>
</ul>

	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: supplierInstance, field: 'user', 'error')}  form-group">
	<label for="user" class="col-sm-2 control-label">
		<g:message code="supplier.user.label" default="User" />
		
	</label>
	<div class="col-sm-10">
	
<ul class="one-to-many">
<g:each in="${supplierInstance?.user?}" var="u">
    <li><g:link controller="user" action="show" id="${u.id}">${u?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="user" action="create" params="['supplier.id': supplierInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'user.label', default: 'User')])}</g:link>
</li>
</ul>

	</div>
</div>

