<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="default.list.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="\${createLink(uri: '/')}">Home</a></li>
				<li class="active"><g:message code="default.list.label" args="[entityName]" /></li>
			</ol>
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
										<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
										allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
										props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) && it.type != null && !Collection.isAssignableFrom(it.type) }
										Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
										props.eachWithIndex { p, i ->
											if (i < 6) {
												if (p.isAssociation()) { %>
										<th><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></th>
										<%      } else { %>
										<g:sortableColumn property="${p.name}" title="\${message(code: '${domainClass.propertyName}.${p.name}.label', default: '${p.naturalName}')}" />
										<%  }   }   } %>
										<th>操作</th>
									</tr>
									</thead>
									<tbody>
									<g:each in="\${${propertyName}List}" status="i" var="${propertyName}">
										<tr class="\${(i % 2) == 0 ? 'even' : 'odd'}">
											<%  props.eachWithIndex { p, i ->
												if (i == 0) { %>
											<td><g:link action="show" id="\${${propertyName}.id}">\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</g:link></td>
											<%      } else if (i < 6) {
												if (p.type == Boolean || p.type == boolean) { %>
											<td><g:formatBoolean boolean="\${${propertyName}.${p.name}}" /></td>
											<%          } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
											<td><g:formatDate date="\${${propertyName}.${p.name}}" /></td>gi
										<%          } else { %>
											<td>\${fieldValue(bean: ${propertyName}, field: "${p.name}")}</td>
											<%  }   }   } %>
											<td class="center ">
												<g:link action="show" id="\${${propertyName}.id}" class="btn btn-default btn-xs" href="#" data-original-title="Open" data-toggle="tooltip">
													<i class="fa fa-file"></i>
												</g:link>
												<g:link action="edit" id="\${${propertyName}.id}" class="btn btn-primary btn-xs" href="#" data-original-title="Edit" data-toggle="tooltip">
													<i class="fa fa-pencil"></i>
												</g:link>
												<g:link action="delete" id="\${${propertyName}.id}" class="btn btn-danger btn-xs" href="#" data-original-title="Remove" data-toggle="tooltip" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
													<i class="fa fa-times"></i>
												</g:link>
											</td>
										</tr>
									</g:each>
									</tbody>
								</table>
								<div class="pagination">
									<g:paginate total="\${${propertyName}Total}" />
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
