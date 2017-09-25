
<%@ page import="posscard.Record" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'record.label', default: 'Record')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
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
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="Record" action="Search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入用户名" />
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
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
										
										<g:sortableColumn property="user" title="${message(code: 'record.user.label', default: '用户名')}" />
										
										<g:sortableColumn property="loginTime" title="${message(code: 'record.loginTime.label', default: '登陆时间')}" />
										
										%{--<g:sortableColumn property="userType" title="${message(code: 'record.userType.label', default: '用户类型')}" />--}%
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${recordInstanceList}" status="i" var="recordInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td>${fieldValue(bean: recordInstance, field: "user")}</td>
											
											<td><g:formatDate date="${recordInstance.loginTime}" />${}</td>
										
											%{--<td>${fieldValue(bean: recordInstance, field: "userType")}</td>--}%
											
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
