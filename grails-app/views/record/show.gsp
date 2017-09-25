
<%@ page import="posscard.Record" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'record.label', default: 'Record')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>操作记录</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li>操作记录</li>
				<li class="active">操作记录</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">

						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${recordInstance?.user}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="record.user.label" default="用户名" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${recordInstance}" field="user"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${recordInstance?.loginTime}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="record.loginTime.label" default="登录时间" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${recordInstance?.loginTime}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${recordInstance?.userType}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="record.userType.label" default="用户类型" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${recordInstance}" field="userType"/></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${recordInstance?.id}" />
								<g:link action="edit"  id="${recordInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
