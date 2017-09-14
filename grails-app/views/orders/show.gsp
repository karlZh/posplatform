
<%@ page import="posscard.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="default.show.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li class="active"><g:message code="default.show.label" args="[entityName]" /></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="default.show.label" args="[entityName]" /></h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${ordersInstance?.cardNum}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.cardNum.label" default="Card Num" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="cardNum"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.password}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.password.label" default="Password" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="password"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.amount}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.amount.label" default="Amount" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="amount"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.actualAmount}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.actualAmount.label" default="Actual Amount" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="actualAmount"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.cardPlatformId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.cardPlatformId.label" default="Card Platform Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="cardPlatformId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.supplierId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.supplierId.label" default="Supplier Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="supplierId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.dateCreated.label" default="Date Created" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${ordersInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.orderType}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.orderType.label" default="Order Type" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="orderType"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.num}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.num.label" default="Num" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="num"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.ticketTypeId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.ticketTypeId.label" default="Ticket Type Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="ticketTypeId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.validity}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.validity.label" default="Validity" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="validity"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.orderSn}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.orderSn.label" default="Order Sn" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="orderSn"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.serialNum}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.serialNum.label" default="Serial Num" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="serialNum"/></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${ordersInstance?.id}" />
								<g:link action="edit"  id="${ordersInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
								<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
							</g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
