
<%@ page import="posscard.TicketType" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'ticketType.label', default: 'TicketType')}" />
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
										
										<g:sortableColumn property="name" title="${message(code: 'ticketType.name.label', default: 'Name')}" />
										
										<g:sortableColumn property="point" title="${message(code: 'ticketType.point.label', default: 'Point')}" />
										
										<g:sortableColumn property="accountPoint" title="${message(code: 'ticketType.accountPoint.label', default: 'Account Point')}" />
										
										<g:sortableColumn property="accountRatio" title="${message(code: 'ticketType.accountRatio.label', default: 'Account Ratio')}" />
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'ticketType.dateCreated.label', default: 'Date Created')}" />
										
										<th><g:message code="ticketType.supplierId.label" default="Supplier Id" /></th>
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${ticketTypeInstanceList}" status="i" var="ticketTypeInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${ticketTypeInstance.id}">${fieldValue(bean: ticketTypeInstance, field: "name")}</g:link></td>
											
											<td>${fieldValue(bean: ticketTypeInstance, field: "point")}</td>
											
											<td>${fieldValue(bean: ticketTypeInstance, field: "accountPoint")}</td>
											
											<td>${fieldValue(bean: ticketTypeInstance, field: "accountRatio")}</td>
											
											<td><g:formatDate date="${ticketTypeInstance.dateCreated}" /></td>gi
										
											<td>${fieldValue(bean: ticketTypeInstance, field: "supplierId")}</td>
											
											<td class="center ">
												<g:link action="show" id="${ticketTypeInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${ticketTypeInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${ticketTypeInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${ticketTypeInstanceTotal}" />
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
