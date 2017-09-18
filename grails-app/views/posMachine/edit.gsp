<%@ page import="posscard.PosMachine" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'posMachine.label', default: 'PosMachine')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>Pos机</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="list">Pos机</g:link></li>
				<li class="active">操作Pos机</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>修改Pos机</h3>
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
								<g:hiddenField name="id" value="${posMachineInstance?.id}" />
								<g:hiddenField name="version" value="${posMachineInstance?.version}" />
								<g:render template="form"/>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
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
