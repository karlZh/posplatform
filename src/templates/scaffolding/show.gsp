<% import grails.persistence.Event %>
<%=packageName%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="\${message(code: '${domainClass.propertyName}.label', default: '${className}')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2><g:message code="default.show.label" args="[entityName]" /></h2>
			<ol class="breadcrumb">
				<li><a href="\${createLink(uri: '/')}">Home</a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li class="active"><g:message code="default.show.label" args="[entityName]" /></li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3><g:message code="default.show.label" args="[entityName]" /></h3>
						</div>
						<div class="content">
							<g:if test="\${flash.message}">
								<div class="message" role="status">\${flash.message}</div>
							</g:if>
							<%  excludedProps = Event.allEvents.toList() << 'id' << 'version'
							allowedNames = domainClass.persistentProperties*.name << 'dateCreated' << 'lastUpdated'
							props = domainClass.properties.findAll { allowedNames.contains(it.name) && !excludedProps.contains(it.name) }
							Collections.sort(props, comparator.constructors[0].newInstance([domainClass] as Object[]))
							props.each { p -> %>
							<g:if test="\${${propertyName}?.${p.name}}">
								<div class="row">
									<div class="col-sm-2 col-md-2 text-right">
									<label class="control-label"><g:message code="${domainClass.propertyName}.${p.name}.label" default="${p.naturalName}" /></label>
									</div>
									<%  if (p.isEnum()) { %>
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></div>
									<%  } else if (p.oneToMany || p.manyToMany) { %>
									<g:each in="\${${propertyName}.${p.name}}" var="${p.name[0]}">
										<div class="col-sm-10 col-md-10"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${p.name[0]}.id}">\${${p.name[0]}?.encodeAsHTML()}</g:link></div>
									</g:each>
									<%  } else if (p.manyToOne || p.oneToOne) { %>
									<div class="col-sm-10 col-md-10"><g:link controller="${p.referencedDomainClass?.propertyName}" action="show" id="\${${propertyName}?.${p.name}?.id}">\${${propertyName}?.${p.name}?.encodeAsHTML()}</g:link></div>
									<%  } else if (p.type == Boolean || p.type == boolean) { %>
									<div class="col-sm-10 col-md-10"><g:formatBoolean boolean="\${${propertyName}?.${p.name}}" /></div>
									<%  } else if (p.type == Date || p.type == java.sql.Date || p.type == java.sql.Time || p.type == Calendar) { %>
									<div class="col-sm-10 col-md-10"><g:formatDate date="\${${propertyName}?.${p.name}}" /></div>
									<%  } else if (!p.type.isArray()) { %>
									<div class="col-sm-10 col-md-10"><g:fieldValue bean="\${${propertyName}}" field="${p.name}"/></div>
									<%  } %>
								</div>
							</g:if>
							<%  } %>
							<g:form>
								<g:hiddenField name="id" value="\${${propertyName}?.id}" />
								<g:link action="edit"  id="\${${propertyName}?.id}" class="btn btn-primary"><g:message code="default.button.edit.label" default="Edit" /></g:link>
								<g:actionSubmit class="btn btn-danger" action="delete" value="\${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('\${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
							</g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</body>
</html>
