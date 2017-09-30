
<%@ page import="posscard.CardPlatform" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardPlatform.label', default: 'CardPlatform')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="default.list.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="cardPlatform" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入商户" />
                    <Button type="primary" shape="circle" style="padding: 10px">搜索</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

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
										
										<g:sortableColumn property="name" title="${message(code: 'cardPlatform.name.label', default: '商户名')}" />
										
										<g:sortableColumn property="address" title="${message(code: 'cardPlatform.address.label', default: '地址')}" />
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'cardPlatform.dateCreated.label', default: '创建时间')}" />
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${cardPlatformInstanceList}" status="i" var="cardPlatformInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            %{--<g:link action="show" id="${cardPlatformInstance.id}">${fieldValue(bean: cardPlatformInstance, field: "name")}</g:link>--}%
											<td>${fieldValue(bean: cardPlatformInstance, field: "name")}</td>
											
											<td>${fieldValue(bean: cardPlatformInstance, field: "address")} </td>
											
											<td><g:formatDate date="${cardPlatformInstance.dateCreated}" /></td>
										
											<td class="center ">
												<g:link action="show" id="${cardPlatformInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${cardPlatformInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${cardPlatformInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${cardPlatformInstanceTotal}" />
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
