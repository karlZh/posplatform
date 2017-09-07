<%@ page import="posscard.CardbinPlatform" %>



<div class="fieldcontain ${hasErrors(bean: cardbinPlatformInstance, field: 'cardbinId', 'error')} required form-group">
	<label for="cardbinId" class="col-sm-2 control-label">
		<g:message code="cardbinPlatform.cardbinId.label" default="Cardbin Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="cardbinId" type="number" value="${cardbinPlatformInstance.cardbinId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardbinPlatformInstance, field: 'cardPlatformId', 'error')} required form-group">
	<label for="cardPlatformId" class="col-sm-2 control-label">
		<g:message code="cardbinPlatform.cardPlatformId.label" default="Card Platform Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="cardPlatformId" type="number" value="${cardbinPlatformInstance.cardPlatformId}" required=""/>
	</div>
</div>

