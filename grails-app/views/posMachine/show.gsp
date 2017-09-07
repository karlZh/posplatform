
<%@ page import="posscard.PosMachine" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'posMachine.label', default: 'PosMachine')}" />
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
							
							<g:if test="${posMachineInstance?.supplierId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.supplierId.label" default="Supplier Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:link controller="supplier" action="show" id="${posMachineInstance?.supplierId?.id}">${posMachineInstance?.supplierId?.encodeAsHTML()}</g:link></div>
									
								</div>
							</g:if>
							
							<g:if test="${posMachineInstance?.userId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.userId.label" default="User Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${posMachineInstance}" field="userId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${posMachineInstance?.createTime}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.createTime.label" default="Create Time" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${posMachineInstance}" field="createTime"/></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${posMachineInstance?.id}" />
								<g:link action="edit"  id="${posMachineInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
