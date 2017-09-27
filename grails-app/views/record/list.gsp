
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
				<li>首页</li>
				<li class="active">操作记录</li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="record" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入用户名" />
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
										
										<g:sortableColumn property="user" title="${message(code: 'record.user.label', default: '用户名')}" />
										<g:sortableColumn property="accountType" title="${message(code: 'record.accountType.label', default: '用户类型')}" />
                                        <g:sortableColumn property="loginTime" title="${message(code: 'record.loginTime.label', default: '登录时间')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${recordInstanceList}" status="i" var="recordInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td>${fieldValue(bean: recordInstance, field: "user")}</td>
											
											<td>
                                                %{--${fieldValue(bean: recordInstance, field: "accountType")}--}%
                                              <g:if test="${recordInstance?.accountType == 1}">
                                                  pos用户
                                              </g:if>
                                              <g:elseif test="${recordInstance?.accountType == 2}">
                                                    管理员
                                              </g:elseif>
                                              <g:elseif test="${recordInstance?.accountType == 3}">
                                                    商户
                                              </g:elseif>
                                              <g:elseif test="${recordInstance?.accountType == 4}">
                                                供应商
                                            </g:elseif>


                                            </td>

                                            <td><g:formatDate date="${recordInstance.loginTime}" /></td>
											
											<td class="center ">
												<g:link action="show" id="${recordInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
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
