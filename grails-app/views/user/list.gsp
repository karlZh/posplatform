
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
			<h2><g:message code="default.list.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">Home</a></li>
				<li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="default.list.label" args="[entityName]" /><g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: 'Username')}" />
										
										<g:sortableColumn property="password" title="${message(code: 'user.password.label', default: 'Password')}" />
										
										<g:sortableColumn property="phone" title="${message(code: 'user.phone.label', default: 'Phone')}" />
										
										<g:sortableColumn property="supplierId" title="${message(code: 'user.supplierId.label', default: 'Supplier Id')}" />
										
										<g:sortableColumn property="accountType" title="${message(code: 'user.accountType.label', default: 'Account Type')}" />
										
										<g:sortableColumn property="createTime" title="${message(code: 'user.createTime.label', default: 'Create Time')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${userInstanceList}" status="i" var="userInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "username")}</g:link></td>
											
											<td>${fieldValue(bean: userInstance, field: "password")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "phone")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "supplierId")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "accountType")}</td>
											
											<td>${fieldValue(bean: userInstance, field: "createTime")}</td>
											
											<td class="center ">
												<g:link action="show" id="${userInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${userInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
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
	</body>
</html>
