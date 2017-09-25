
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
			<h2><g:message code="user.pos.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active"><g:message code="user.pos.label" args="[entityName]" /></li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="user" action="posSearch">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入用户名" />
                    <Button type="primary" shape="circle" style="padding: 10px">搜索</Button>
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="user.pos.label" args="[entityName]" /><g:link action="posCreate" id="not-primary" params="[accountType:accountType]" class="btn btn-primary pull-right">添加</g:link></h3>
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
                                            %{--<g:link action="show" id="${userInstance.id}"></g:link>--}%
											<td>${fieldValue(bean: userInstance, field: "username")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "password")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "phone")}</td>
											
											<td>${posscard.PosMachine.get(userInstance?.uTypeId)?.name}</td>
											
											<td><g:formatDate date="${userInstance.dateCreated}" /></td>
										
											%{--<td>${fieldValue(bean: userInstance, field: "supplier")}</td>--}%
											
											<td class="center ">
												<g:link action="posShow" id="${userInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="posEdit" id="${userInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="posDelete" id="${userInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
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
