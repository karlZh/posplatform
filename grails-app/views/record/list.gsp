
<%@ page import="posscard.Record" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'record.label', default: 'Record')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>操作记录</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">操作记录</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>操作记录<g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="user" title="${message(code: 'record.user.label', default: '用户名')}" />
										
										<g:sortableColumn property="state" title="${message(code: 'record.state.label', default: '状态')}" />
										
										<g:sortableColumn property="lastTime" title="${message(code: 'record.lastTime.label', default: '最后登录时间')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${recordInstanceList}" status="i" var="recordInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${recordInstance.id}">${fieldValue(bean: recordInstance, field: "user")}</g:link></td>
											
											<td>${fieldValue(bean: recordInstance, field: "state")}</td>
											
											<td><g:formatDate date="${recordInstance.lastTime}" /></td>gi
										
											<td class="center ">
												<g:link action="show" id="${recordInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${recordInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${recordInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${recordInstanceTotal}" />
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
