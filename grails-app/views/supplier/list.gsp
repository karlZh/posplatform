
<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
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
										
										<g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: 'Address')}" />
										
										<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: 'Name')}" />
										
										<g:sortableColumn property="parentId" title="${message(code: 'supplier.parentId.label', default: 'Parent Id')}" />
										
										<g:sortableColumn property="phone" title="${message(code: 'supplier.phone.label', default: 'Phone')}" />
										
										<g:sortableColumn property="price" title="${message(code: 'supplier.price.label', default: 'Price')}" />
										
										<g:sortableColumn property="ratio" title="${message(code: 'supplier.ratio.label', default: 'Ratio')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${supplierInstance.id}">${fieldValue(bean: supplierInstance, field: "address")}</g:link></td>
											
											<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "parentId")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "phone")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "price")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "ratio")}</td>
											
											<td class="center ">
												<g:link action="show" id="${supplierInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${supplierInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${supplierInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${supplierInstanceTotal}" />
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
