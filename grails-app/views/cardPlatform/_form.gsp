<%@ page import="posscard.CardPlatform" %>



<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'address', 'error')} ">
	<label for="address">
		<g:message code="cardPlatform.address.label" default="Address" />
		
	</label>
	<g:textField name="address" value="${cardPlatformInstance?.address}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: cardPlatformInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="cardPlatform.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${cardPlatformInstance?.name}"/>
</div>

