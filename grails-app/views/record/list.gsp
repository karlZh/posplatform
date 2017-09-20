
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
			<h2>操作记录</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">操作记录</li>
			</ol>
		</div>
        <div style="padding:25px 12px">
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>操作记录</h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="name" title="${message(code: 'supplier.name.label', default: '序号')}" />
										
										<g:sortableColumn property="ratio" title="${message(code: 'supplier.ratio.label', default: '管理员')}" />
										
										<g:sortableColumn property="price" title="${message(code: 'supplier.price.label', default: '当前状态')}" />
										
										<g:sortableColumn property="address" title="${message(code: 'supplier.address.label', default: '登录时间')}" />
										
										<g:sortableColumn property="phone" title="${message(code: 'supplier.phone.label', default: '最后一次处理')}" />

										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${recordInstanceList}" status="i" var="recordInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${recordInstance.id}">${fieldValue(bean: recordInstance, field: "name")}</g:link></td>
											
											<td>${fieldValue(bean: recordInstance, field: "ratio")}</td>
											
											<td>${fieldValue(bean: recordInstance, field: "price")}</td>
											
											<td>${fieldValue(bean: recordInstance, field: "address")}</td>
											
											<td>${fieldValue(bean: recordInstance, field: "phone")}</td>
											
											<td>${fieldValue(bean: recordInstance, field: "remark")}</td>
											
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
	</div>
	</body>
</html>
