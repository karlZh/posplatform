
<%@ page import="posscard.CardBin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardBin.label', default: 'CardBin')}" />
		<title>卡BIN表</title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>卡BIN </h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="list">卡BIN</g:link></li>
				<li class="active">操作卡BIN</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示卡BIN</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${cardBinInstance?.cardbin}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardBin.cardbin.label" default="卡BIN" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${cardBinInstance}" field="cardbin"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardBinInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="cardBin.dateCreated.label" default="创建时间" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${cardBinInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>
							
							<g:if test="${cardBinInstance?.cardPlatform}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">

									<label class="control-label"><g:message code="cardBin.cardbinPlatform.label" default="商户" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:link controller="cardPlatform" action="show" id="${cardBinInstance?.cardPlatform?.id}">${cardBinInstance?.cardPlatform?.encodeAsHTML()}</g:link></div>
									
								</div>
							</g:if>
							
							<g:form>
								<g:hiddenField name="id" value="${cardBinInstance?.id}" />
								<g:link action="edit"  id="${cardBinInstance?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
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
