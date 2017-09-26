
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
			<h2><g:message code="orders.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li>首页</li>
				<li class="active"><g:message code="orders.label" args="[entityName]" /></li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="orders" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入订单号" />
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="orders.label" args="[entityName]" /><g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
                                        <g:sortableColumn property="orderSn" title="${message(code: 'orders.orderSn.label', default: '订单号')}" />

										<g:sortableColumn property="cardNum" title="${message(code: 'orders.cardNum.label', default: '用户名')}" />

										<g:sortableColumn property="amount" title="${message(code: 'orders.amount.label', default: '应扣订单总金额')}" />
										
										<g:sortableColumn property="actualAmount" title="${message(code: 'orders.actualAmount.label', default: '实扣总金额')}" />
										
										<g:sortableColumn property="cardPlatformId" title="${message(code: 'orders.cardPlatform.label', default: '商户id')}" />
										
										<g:sortableColumn property="supplierId" title="${message(code: 'orders.supplier.label', default: '供应商id')}" />



                                        <g:sortableColumn property="serialNum" title="${message(code: 'orders.serialNum.label', default: '流水号')}" />
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <td>${fieldValue(bean: ordersInstance, field: "orderSn")}</td>

											<td><g:link action="show" id="${ordersInstance.id}">${fieldValue(bean: ordersInstance, field: "cardNum")}</g:link></td>
											
											<td>${fieldValue(bean: ordersInstance, field: "amount")}</td>
											
											<td>${fieldValue(bean: ordersInstance, field: "actualAmount")}</td>
											
											<td>${posscard.CardPlatform.findById(ordersInstance.cardPlatformId)}</td>
											
											<td>${posscard.Supplier.findById(ordersInstance.supplierId).name}</td>



                                            <td>${fieldValue(bean: ordersInstance, field: "serialNum")}</td>
											
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
