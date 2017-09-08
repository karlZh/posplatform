
<%@ page import="posscard.CardbinPlatform" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardbinPlatform.label', default: 'CardbinPlatform')}" />
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
							
							<g:if test="${cardbinPlatformInstance?.cardbinId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardbinPlatform.cardbinId.label" default="Cardbin Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:link controller="cardBin" action="show" id="${cardbinPlatformInstance?.cardbinId?.id}">${cardbinPlatformInstance?.cardbinId?.encodeAsHTML()}</g:link></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardbinPlatformInstance?.cardPlatformId}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardbinPlatform.cardPlatformId.label" default="Card Platform Id" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:link controller="cardPlatform" action="show" id="${cardbinPlatformInstance?.cardPlatformId?.id}">${cardbinPlatformInstance?.cardPlatformId?.encodeAsHTML()}</g:link></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardbinPlatformInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardbinPlatform.dateCreated.label" default="Date Created" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${cardbinPlatformInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${cardbinPlatformInstance?.id}" />
								<g:link action="edit"  id="${cardbinPlatformInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
