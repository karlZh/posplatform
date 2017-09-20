
<%@ page import="posscard.CardBin" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'cardBin.label', default: 'CardBin')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="cardBin.label" default="CardBin"/></h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">Home</a></li>
				<li class="active"><g:message code="cardBin.label" default="CardBin"/></li>
			</ol>
		</div>
        <div style="padding:25px 12px">
            <div class="text-right collapse-button" style="padding:7px 3px;">
                <g:form controller="cardPlatform" action="search">
                    <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入卡Bin" />
                    <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                    <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
                </g:form>

            </div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="cardBin.label" default="CardBin"/><g:link action="create" id="not-primary" class="btn btn-primary pull-right">添加</g:link></h3>
						</div>
						<div class="content">
							<div>
								<table>
									<thead>
									<tr>
										
										<g:sortableColumn property="cardbin" title="${message(code: 'cardBin.cardbin.label', default: '卡Bin')}" />
										
										<g:sortableColumn property="dateCreated" title="${message(code: 'cardBin.dateCreated.label', default: '创建时间')}" />
										
										<th><g:message code="cardBin.cardPlatform.label" default="商户" /></th>
										
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="${cardBinInstanceList}" status="i" var="cardBinInstance">
										<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
											
											<td><g:link action="show" id="${cardBinInstance.id}">${fieldValue(bean: cardBinInstance, field: "cardbin")}</g:link></td>
											
											<td><g:formatDate date="${cardBinInstance.dateCreated}" /></td>
										
											<td>${fieldValue(bean: cardBinInstance, field: "cardPlatform")}</td>
											
											<td class="center ">
												<g:link action="show" id="${cardBinInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="${cardBinInstance.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="${cardBinInstance.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="${cardBinInstanceTotal}" />
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
