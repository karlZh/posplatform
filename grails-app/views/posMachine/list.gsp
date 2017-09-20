
<%@ page import="posscard.PosMachine" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'posMachine.label', default: 'PosMachine')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="posMachine.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">Home</a></li>
				<li class="active"><g:message code="posMachine.label" args="[entityName]" /></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="posMachine.label" args="[entityName]" /><g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="name" title="${message(code: 'posMachine.name.label', default: 'pos机名称')}" />

										<g:sortableColumn property="dateCreated" title="${message(code: 'posMachine.dateCreated.label', default: '创建时间')}" />

										<th><g:message code="posMachine.supplier.label" default="供应商" /></th>
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${posMachineInstanceList}" status="i" var="posMachineInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${posMachineInstance.id}">${fieldValue(bean: posMachineInstance, field: "name")}</g:link></td>

											<td><g:formatDate date="${posMachineInstance.dateCreated}" /></td>
										
											<td>${fieldValue(bean: posMachineInstance, field: "supplier.name")}</td>

											<td class="center ">
												<g:link action="show" id="${posMachineInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${posMachineInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${posMachineInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${posMachineInstanceTotal}" />
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
