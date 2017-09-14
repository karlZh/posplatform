
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
			<h2>消费类型</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active">消费类型</li>
			</ol>
		</div>
        <div style="padding:25px 12px">
        <div class="text-right collapse-button" style="padding:7px 3px;">
            <g:form controller="TicketType" action="search">
                <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入类型名称" />
                <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
            </g:form>

        </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>消费类型<g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>

										<g:sortableColumn property="name" title="${message(code: 'ticketType.name.label', default: '类型名称')}" />
										
										<g:sortableColumn property="point" title="${message(code: 'ticketType.point.label', default: '扣点数')}" />
										
										<g:sortableColumn property="accountPoint" title="${message(code: 'ticketType.accountPoint.label', default: '结算点数')}" />
										
										<g:sortableColumn property="accountRatio" title="${message(code: 'ticketType.accountRatio.label', default: '结算比例')}" />
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'ticketType.dateCreated.label', default: '创建时间')}" />
										
										<th><g:message code="ticketType.supplierId.label" default="供应商 Id" /></th>
										
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
											
											<td><g:formatDate date="${ticketTypeInstance.dateCreated}" /></td>
										
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
	</div>
	</body>
</html>
