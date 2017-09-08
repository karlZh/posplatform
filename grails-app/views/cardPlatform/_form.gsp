<%@ page import="posscard.CardPlatform" %>



<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="cardPlatform.name.label" default="Name" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" value="${cardPlatformInstance?.name}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'address', 'error')}  form-group">
	<label for="address" class="col-sm-2 control-label">
		<g:message code="cardPlatform.address.label" default="Address" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="address" value="${cardPlatformInstance?.address}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'cardbinPlatform', 'error')}  form-group">
	<label for="cardbinPlatform" class="col-sm-2 control-label">
		<g:message code="cardPlatform.cardbinPlatform.label" default="Cardbin Platform" />
		
	</label>
	<div class="col-sm-6">
	
<ul class="one-to-many">
<g:each in="${cardPlatformInstance?.cardbinPlatform?}" var="c">
    <li><g:link controller="cardbinPlatform" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="cardbinPlatform" action="create" params="['cardPlatform.id': cardPlatformInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform')])}</g:link>
</li>
</ul>

	</div>
</div>

