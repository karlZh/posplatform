
<%@ page import="posscard.TicketType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'ticketType.label', default: 'TicketType')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>消费类型表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="list">消费类型表</g:link></li>
				<li class="active">操作消费类型</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示消费类型</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.name}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="ticketType.name.label" default="类型名称" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ticketTypeInstance}" field="name"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.point}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="ticketType.point.label" default="扣点数" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ticketTypeInstance}" field="point"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.accountPoint}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="ticketType.accountPoint.label" default="结算点数" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ticketTypeInstance}" field="accountPoint"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.accountRatio}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="ticketType.accountRatio.label" default="结算比例" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${ticketTypeInstance}" field="accountRatio"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="ticketType.dateCreated.label" default="创建日期" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${ticketTypeInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${ticketTypeInstance?.supplier}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">

									<label class="control-label"><g:message code="ticketType.supplier.label" default="供应商" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:link controller="supplier" action="show" id="${ticketTypeInstance?.supplier?.id}">${ticketTypeInstance?.supplier?.encodeAsHTML()}</g:link></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${ticketTypeInstance?.id}" />
								<g:link action="edit"  id="${ticketTypeInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
