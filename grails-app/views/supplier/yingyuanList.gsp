
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
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="supplier" action="yingyuanSearch">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入供应商" />
                    <g:hiddenField name="id" value="${id}"/>
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">

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
												<g:link action="fShow" id="${supplierInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													查看
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
