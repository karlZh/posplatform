
<%@ page import="posscard.Orders" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
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
										
										<g:sortableColumn property="cardNum" title="${message(code: 'orders.cardNum.label', default: 'Card Num')}" />
										
										<g:sortableColumn property="password" title="${message(code: 'orders.password.label', default: 'Password')}" />
										
										<g:sortableColumn property="amount" title="${message(code: 'orders.amount.label', default: 'Amount')}" />
										
										<g:sortableColumn property="actualAmount" title="${message(code: 'orders.actualAmount.label', default: 'Actual Amount')}" />
										
										<g:sortableColumn property="cardPlatformId" title="${message(code: 'orders.cardPlatformId.label', default: 'Card Platform Id')}" />
										
										<g:sortableColumn property="supplierId" title="${message(code: 'orders.supplierId.label', default: 'Supplier Id')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${ordersInstance.id}">${fieldValue(bean: ordersInstance, field: "cardNum")}</g:link></td>
											
											<td>${fieldValue(bean: ordersInstance, field: "password")}</td>
											
											<td>${fieldValue(bean: ordersInstance, field: "amount")}</td>
											
											<td>${fieldValue(bean: ordersInstance, field: "actualAmount")}</td>
											
											<td>${fieldValue(bean: ordersInstance, field: "cardPlatformId")}</td>
											
											<td>${fieldValue(bean: ordersInstance, field: "supplierId")}</td>
											
											<td class="center ">
												<g:link action="show" id="${ordersInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${ordersInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${ordersInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${ordersInstanceTotal}" />
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
