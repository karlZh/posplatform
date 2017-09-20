
<%@ page import="posscard.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>用户信息表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">商户信息表</li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="user" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入用户名" />
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>商户信息表<g:link action="platformCreate" id="not-primary" params="[accountType:accountType]" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: '用户名')}" />
										
										<g:sortableColumn property="password" title="${message(code: 'user.password.label', default: '密码')}" />
										
										<g:sortableColumn property="phone" title="${message(code: 'user.phone.label', default: '电话')}" />
										
										<g:sortableColumn property="uTypeId" title="${message(code: 'user.uTypeId.label', default: '用户类别')}" />
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'user.dateCreated.label', default: '创建时间')}" />
										
										%{--<th><g:message code="user.supplier.label" default="供应商" /></th>--}%
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${userInstanceList}" status="i" var="userInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
											
											<td>${fieldValue(bean: userInstance, field: "password")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "phone")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "uTypeId")}</td>
											
											<td><g:formatDate date="${userInstance.dateCreated}" /></td>
										
											%{--<td>${fieldValue(bean: userInstance, field: "supplier")}</td>--}%
											
											<td class="center ">
												<g:link action="platformShow" id="${userInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="platformEdit" id="${userInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${userInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${userInstanceTotal}" />
								</div>
							</div>
						</div>
                        </div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
