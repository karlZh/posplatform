
<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
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
							
							<g:if test="${supplierInstance?.address}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.address.label" default="Address" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="address"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.name}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.name.label" default="Name" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="name"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.parentId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.parentId.label" default="Parent Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="parentId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.phone}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.phone.label" default="Phone" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="phone"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.posmachine}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.posmachine.label" default="Posmachine" /></label>
									</div>
									
									<g:each in="${supplierInstance.posmachine}" var="p">
										<div class="col-sm-10 col-md-10"><g:link controller="posMachine" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></div>
									</g:each>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.price}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.price.label" default="Price" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="price"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.ratio}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.ratio.label" default="Ratio" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="ratio"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.remark}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.remark.label" default="Remark" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="remark"/></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${supplierInstance?.id}" />
								<g:link action="edit"  id="${supplierInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
