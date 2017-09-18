<%@ page import="posscard.TicketType" %>



<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="ticketType.name.label" default="类型名称" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" value="${ticketTypeInstance?.name}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'point', 'error')} required form-group">
	<label for="point" class="col-sm-2 control-label">
		<g:message code="ticketType.point.label" default="扣点数" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="point" value="${fieldValue(bean: ticketTypeInstance, field: 'point')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'accountPoint', 'error')} required form-group">
	<label for="accountPoint" class="col-sm-2 control-label">
		<g:message code="ticketType.accountPoint.label" default="结算点数" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="accountPoint" value="${fieldValue(bean: ticketTypeInstance, field: 'accountPoint')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'accountRatio', 'error')} required form-group">
	<label for="accountRatio" class="col-sm-2 control-label">
		<g:message code="ticketType.accountRatio.label" default="结算比例" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="accountRatio" value="${fieldValue(bean: ticketTypeInstance, field: 'accountRatio')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="ticketType.supplierId.label" default="供应商 Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="supplierId" name="supplierId.id" from="${posscard.Supplier.list()}" optionKey="id" required="" value="${ticketTypeInstance?.supplierId?.id}" class="many-to-one"/>
	</div>
</div>

