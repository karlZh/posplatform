
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
				<li>Home</li>
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
							
							<g:if test="${posMachineInstance?.name}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.name.label" default="Name" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${posMachineInstance}" field="name"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${posMachineInstance?.supplier}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.supplier.label" default="Supplier" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10">${posMachineInstance?.supplier?.encodeAsHTML()}</div>
									
								</div>
							</g:if>
							
							<g:if test="${posMachineInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="posMachine.dateCreated.label" default="Date Created" /></label>
									</div>
									<div class="col-sm-10 col-md-10"><g:formatDate date="${posMachineInstance?.dateCreated}" /></div>
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${posMachineInstance?.id}" />
                                <g:hiddenField name="uTypeId" value="${uTypeId}"/>
								<g:link action="pEdit"  id="${posMachineInstance?.id}" params="[uTypeId:uTypeId]" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
								<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                <g:link action="posCreate"  id="${posMachineInstance?.id}" params="[uTypeId:uTypeId]" class="btn btn-primary">添加pos机用户</g:link>

                            </g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
