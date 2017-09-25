
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
			<h2>订单表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li>订单表</li>
				<li class="active">操作订单</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示订单</h3>
						</div>
						<div class="content">

							
							<g:if test="${ordersInstance?.cardNum}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.cardNum.label" default="卡号" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="cardNum"/></div>
									
								</div>
							</g:if>
							

							
							<g:if test="${ordersInstance?.amount}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.amount.label" default="应扣订单总金额" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="amount"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.actualAmount}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.actualAmount.label" default="实扣总金额" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="actualAmount"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.cardPlatformId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.cardPlatformId.label" default="商户" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10">${posscard.CardPlatform.findById(ordersInstance.cardPlatformId).name}</div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.supplierId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.supplierId.label" default="供应商" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10">${posscard.Supplier.findById(ordersInstance.supplierId).name}</div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.dateCreated.label" default="创建日期" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${ordersInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							
							
							<g:if test="${ordersInstance?.num}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.num.label" default="张数" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="num"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.ticketTypeId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.ticketTypeId.label" default="票类型 " /></label>
									</div>
									
									<div class="col-sm-10 col-md-10">${posscard.TicketType.findById(ordersInstance.ticketTypeId).name}</div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.validity}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.validity.label" default="有效期" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="validity"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ordersInstance?.orderSn}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.orderSn.label" default="订单号" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="orderSn"/></div>
									
								</div>
							</g:if>

							<g:if test="${ordersInstance?.serialNum}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="orders.serialNum.label" default="流水号" /></label>
									</div>

									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ordersInstance}" field="serialNum"/></div>

								</div>
							</g:if>
							
							%{--<g:form>--}%
								%{--<g:hiddenField name="id" value="${ordersInstance?.id}" />--}%
								%{--<g:link action="edit"  id="${ordersInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>--}%
								%{--<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />--}%
							%{--</g:form>--}%
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
