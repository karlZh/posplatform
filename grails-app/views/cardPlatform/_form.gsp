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

