
<%@ page import="posscard.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>用户信息表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="platformList">商户信息表</g:link></li>
				<li class="active">操作商户</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>显示商户</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							
							<g:if test="${userInstance?.username}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="user.username.label" default="用户名" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${userInstance}" field="username"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${userInstance?.password}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="user.password.label" default="密码" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${userInstance}" field="password"/></div>
									
								</div>
							</g:if>
							
							<g:if test="${userInstance?.phone}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="user.phone.label" default="电话" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="${userInstance}" field="phone"/></div>
									
								</div>
							</g:if>

							%{--</g:if>--}%
                            %{--<g:if test="${userInstance?.accountType}">--}%
                                %{--<div class="row">--}%
                                    %{--<div class="col-sm-2 col-md-2 text-right">--}%
                                        %{--<label class="control-label"><g:message code="user.uTypeId.label" default="用户类别" /></label>--}%
                                    %{--</div>--}%

                                    %{--<div class="col-sm-10 col-md-10">${posscard.CardPlatform.get(userInstance.uTypeId).name}</div>--}%
                                %{--</div>--}%
                            %{--</g:if>--}%

							<g:if test="${userInstance?.dateCreated}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="user.dateCreated.label" default="创建时间" /></label>
									</div>
									
									<div class="col-sm-10 col-md-10"><g:formatDate date="${userInstance?.dateCreated}" /></div>
									
								</div>
							</g:if>



                            <g:hiddenField name="uTypeId" value="${uTypeId}"/>
							
							<g:form>


								<g:link action="platformEdit"  id="${userInstance?.id}" params="[uTypeId:uTypeId]" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
								%{--<g:actionSubmit class="btn btn-danger" action="platformDelete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />--}%
						　　　　<g:link action="kcreate"  id="${uTypeId}" class="btn btn-primary">下一步</g:link>

                            </g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
