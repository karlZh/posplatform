
<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-supplier" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-supplier" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list supplier">
			
				<g:if test="${supplierInstance?.address}">
				<li class="fieldcontain">
					<span id="address-label" class="property-label"><g:message code="supplier.address.label" default="Address" /></span>
					
						<span class="property-value" aria-labelledby="address-label"><g:fieldValue bean="${supplierInstance}" field="address"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="supplier.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${supplierInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.parentId}">
				<li class="fieldcontain">
					<span id="parentId-label" class="property-label"><g:message code="supplier.parentId.label" default="Parent Id" /></span>
					
						<span class="property-value" aria-labelledby="parentId-label"><g:fieldValue bean="${supplierInstance}" field="parentId"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.phone}">
				<li class="fieldcontain">
					<span id="phone-label" class="property-label"><g:message code="supplier.phone.label" default="Phone" /></span>
					
						<span class="property-value" aria-labelledby="phone-label"><g:fieldValue bean="${supplierInstance}" field="phone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.price}">
				<li class="fieldcontain">
					<span id="price-label" class="property-label"><g:message code="supplier.price.label" default="Price" /></span>
					
						<span class="property-value" aria-labelledby="price-label"><g:fieldValue bean="${supplierInstance}" field="price"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.ratio}">
				<li class="fieldcontain">
					<span id="ratio-label" class="property-label"><g:message code="supplier.ratio.label" default="Ratio" /></span>
					
						<span class="property-value" aria-labelledby="ratio-label"><g:fieldValue bean="${supplierInstance}" field="ratio"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${supplierInstance?.remark}">
				<li class="fieldcontain">
					<span id="remark-label" class="property-label"><g:message code="supplier.remark.label" default="Remark" /></span>
					
						<span class="property-value" aria-labelledby="remark-label"><g:fieldValue bean="${supplierInstance}" field="remark"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${supplierInstance?.id}" />
					<g:link class="edit" action="edit" id="${supplierInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
