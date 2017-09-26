
<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
		<title>供应商表</title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>供应商表</h2>
			<ol class="breadcrumb">
				<li>首页</li>
				<li class="active">父供应商表</li>
			</ol>

		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">

						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										%{--<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: '院线名称')}" />--}%
                                        <g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: '供应商姓名')}" />

                                        <g:sortableColumn property="ratio" title="${message(code: 'supplier.ratio.label', default: '结算比例')}" />

                                        <g:sortableColumn property="price" title="${message(code: 'supplier.price.label', default: '结算价格')}" />

                                        <g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: '地址')}" />

                                        <g:sortableColumn property="phone" title="${message(code: 'supplier.phone.label', default: '电话')}" />

                                        <g:sortableColumn property="remark" title="${message(code: 'supplier.remark.label', default: '备注')}" />
									</tr>
									</thead>
									<tbody>
									<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											%{--<td>${fieldValue(bean: supplierInstance, field: "name")}</td>--}%
                                            <td>${fieldValue(bean: supplierInstance, field: "name")}</td>

                                            <td>${fieldValue(bean: supplierInstance, field: "ratio")}</td>

                                            <td>${fieldValue(bean: supplierInstance, field: "price")}</td>

                                            <td>${fieldValue(bean: supplierInstance, field: "address")}</td>

                                            <td>${fieldValue(bean: supplierInstance, field: "phone")}</td>

                                            <td>${fieldValue(bean: supplierInstance, field: "remark")}</td>

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
	</div>
	</body>
</html>
