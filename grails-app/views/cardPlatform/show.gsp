
<%@ page import="posscard.CardPlatform" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardPlatform.label', default: 'CardPlatform')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>商户信息表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="list">商户信息表</g:link></li>
				<li class="active">操作商户</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示商户信息</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${cardPlatformInstance?.name}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardPlatform.name.label" default="商户姓名" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${cardPlatformInstance}" field="name"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardPlatformInstance?.address}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardPlatform.address.label" default="地址" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${cardPlatformInstance}" field="address"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardPlatformInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardPlatform.dateCreated.label" default="创建时间" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${cardPlatformInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardPlatformInstance?.cardbinPlatform}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardPlatform.cardbinPlatform.label" default="Cardbin Platform" /></label>
									</div>
									
									<g:each in="${cardPlatformInstance.cardbinPlatform}" var="c">
										<div class="col-sm-10 col-md-10"><g:link controller="cardbinPlatform" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></div>
									</g:each>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${cardPlatformInstance?.id}" />
								<g:link action="edit"  id="${cardPlatformInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
