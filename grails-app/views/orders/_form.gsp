<%@ page import="posscard.Orders" %>



<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'cardNum', 'error')}  form-group">
	<label for="cardNum" class="col-sm-2 control-label">
		<g:message code="orders.cardNum.label" default="Card Num" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="cardNum" value="${ordersInstance?.cardNum}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'password', 'error')}  form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="orders.password.label" default="Password" />
		
	</label>
	<div class="col-sm-6">
	<g:field type="password" class="form-control" name="password" value="${ordersInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'amount', 'error')} required form-group">
	<label for="amount" class="col-sm-2 control-label">
		<g:message code="orders.amount.label" default="Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="amount" value="${fieldValue(bean: ordersInstance, field: 'amount')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'actualAmount', 'error')} required form-group">
	<label for="actualAmount" class="col-sm-2 control-label">
		<g:message code="orders.actualAmount.label" default="Actual Amount" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="actualAmount" value="${fieldValue(bean: ordersInstance, field: 'actualAmount')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'cardPlatformId', 'error')} required form-group">
	<label for="cardPlatformId" class="col-sm-2 control-label">
		<g:message code="orders.cardPlatformId.label" default="Card Platform Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="cardPlatformId" type="number" value="${ordersInstance.cardPlatformId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplierId" class="col-sm-2 control-label">
		<g:message code="orders.supplierId.label" default="Supplier Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="supplierId" type="number" value="${ordersInstance.supplierId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'orderType', 'error')} required form-group">
	<label for="orderType" class="col-sm-2 control-label">
		<g:message code="orders.orderType.label" default="Order Type" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select name="orderType" from="${ordersInstance.constraints.orderType.inList}" required="" value="${fieldValue(bean: ordersInstance, field: 'orderType')}" valueMessagePrefix="orders.orderType"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'num', 'error')} required form-group">
	<label for="num" class="col-sm-2 control-label">
		<g:message code="orders.num.label" default="Num" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="num" type="number" value="${ordersInstance.num}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'ticketTypeId', 'error')} required form-group">
	<label for="ticketTypeId" class="col-sm-2 control-label">
		<g:message code="orders.ticketTypeId.label" default="Ticket Type Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="ticketTypeId" type="number" value="${ordersInstance.ticketTypeId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'validity', 'error')} required form-group">
	<label for="validity" class="col-sm-2 control-label">
		<g:message code="orders.validity.label" default="Validity" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="validity" type="number" value="${ordersInstance.validity}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'orderSn', 'error')}  form-group">
	<label for="orderSn" class="col-sm-2 control-label">
		<g:message code="orders.orderSn.label" default="Order Sn" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="orderSn" value="${ordersInstance?.orderSn}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ordersInstance, field: 'serialNum', 'error')}  form-group">
	<label for="serialNum" class="col-sm-2 control-label">
		<g:message code="orders.serialNum.label" default="Serial Num" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="serialNum" value="${ordersInstance?.serialNum}"/>
	</div>
</div>

