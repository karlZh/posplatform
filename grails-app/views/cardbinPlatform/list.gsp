
<%@ page import="posscard.CardbinPlatform" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardbinPlatform.label', default: 'CardbinPlatform')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>商户&卡BIN</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">商户&卡BIN</li>
			</ol>
		</div>

		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>商户&卡BIN<g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<th><g:message code="cardbinPlatform.cardbinId.label" default="卡 Id" /></th>
										
										<th><g:message code="cardbinPlatform.cardPlatformId.label" default="商户 Id" /></th>
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'cardbinPlatform.dateCreated.label', default: '创建时间')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${cardbinPlatformInstanceList}" status="i" var="cardbinPlatformInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${cardbinPlatformInstance.id}">${fieldValue(bean: cardbinPlatformInstance, field: "cardbinId")}</g:link></td>
											
											<td>${fieldValue(bean: cardbinPlatformInstance, field: "cardPlatformId")}</td>
											
											<td><g:formatDate date="${cardbinPlatformInstance.dateCreated}" /></td>
										
											<td class="center ">
												<g:link action="show" id="${cardbinPlatformInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${cardbinPlatformInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${cardbinPlatformInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${cardbinPlatformInstanceTotal}" />
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
