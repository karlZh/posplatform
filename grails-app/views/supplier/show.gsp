
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
			<h2>供应商表</h2>
			<ol class="breadcrumb">
				<li>首页</li>
				<li><g:link class="list" action="list">供应商表</g:link></li>
				<li class="active">操作供应商</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示供应商</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${supplierInstance?.name}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.name.label" default="供应商名" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="name"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.ratio}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.ratio.label" default="结算比例" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="ratio"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.price}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.price.label" default="结算价格" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="price"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.address}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.address.label" default="地址" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="address"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.phone}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.phone.label" default="电话" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="phone"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.remark}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.remark.label" default="备注" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="remark"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.parentId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.parentId.label" default="夫供应商 Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${supplierInstance}" field="parentId"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.dateCreated.label" default="创建时间" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${supplierInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.posmachine}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.posmachine.label" default="POS机" /></label>
									</div>
									
									<g:each in="${supplierInstance.posmachine}" var="p">
										<div class="col-sm-10 col-md-10"><g:link controller="posMachine" action="show" id="${p.id}">${p?.encodeAsHTML()}</g:link></div>
									</g:each>
									
								</div>
							</g:if>
							
							<g:if test="${supplierInstance?.tickettype}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="supplier.tickettype.label" default="票类型" /></label>
									</div>
									
									<g:each in="${supplierInstance.tickettype}" var="t">
										<div class="col-sm-10 col-md-10"><g:link controller="ticketType" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></div>
									</g:each>
									
								</div>
							</g:if>
							<g:if test="${supplierInstance?.cardbins}">

								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
										<label class="control-label"><g:message code="supplier.cardbins.label" default="卡BIN" /></label>
									</div>
									<div class="col-sm-10 col-md-10">
										<g:each in="${supplierInstance.cardbins}" var="card">
											<span class="property-value" aria-labelledby="tags-label">${card?.encodeAsHTML()},</span>
										</g:each>
									</div>
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
