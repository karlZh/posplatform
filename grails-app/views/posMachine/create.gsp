<%@ page import="posscard.PosMachine" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'posMachine.label', default: 'PosMachine')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="posMachine.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li>首页</li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li class="active"><g:message code="posMachine.label" args="[entityName]" /></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="posMachine.label" args="[entityName]" /></h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							<g:hasErrors bean="${posMachineInstance}">
								<ul class="errors" role="alert">
									<g:eachError bean="${posMachineInstance}" var="error">
										<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
									</g:eachError>
								</ul>
							</g:hasErrors>
							<g:form class="form-horizontal" role="form" action="save" >
								<g:render template="form"/>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<g:submitButton name="create" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
										<a href="javascript:history.go(-1)" class="btn btn-default"><g:message code="default.button.chancel.label" args="[entityName]" /></a>
									</div>
								</div>
							</g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
