
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
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">供应商表</li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="supplier" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入供应商" />
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>供应商表<g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: '供应商姓名')}" />
										
										<g:sortableColumn property="ratio" title="${message(code: 'supplier.ratio.label', default: '结算比例')}" />
										
										<g:sortableColumn property="price" title="${message(code: 'supplier.price.label', default: '结算价格')}" />
										
										<g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: '地址')}" />
										
										<g:sortableColumn property="phone" title="${message(code: 'supplier.phone.label', default: '电话')}" />
										
										<g:sortableColumn property="remark" title="${message(code: 'supplier.remark.label', default: '备注')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${supplierInstanceList}" status="i" var="supplierInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            %{--<g:link action="show" id="${supplierInstance.id}">${fieldValue(bean: supplierInstance, field: "name")}</g:link>--}%
											<td>${fieldValue(bean: supplierInstance, field: "name")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "ratio")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "price")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "address")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "phone")}</td>
											
											<td>${fieldValue(bean: supplierInstance, field: "remark")}</td>
											
											<td class="center ">
												<g:link action="supCardBinEdit" id="${supplierInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="${message(code: 'cardBin.label', default: 'SupplierCardBin')}" data-toggle="tooltip">
													<i class="fa fa-cogs fa-fw"></i>
												</g:link>
												<g:link action="show" id="${supplierInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="${message(code: 'supplier.show.label', default: 'Show')}" data-toggle="tooltip">
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
	</div>
	</body>
</html>
