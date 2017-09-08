<%@ page import="posscard.CardbinPlatform" %>



<div class="fieldcontain ${hasErrors(bean: cardbinPlatformInstance, field: 'cardbinId', 'error')} required form-group">
	<label for="cardbinId" class="col-sm-2 control-label">
		<g:message code="cardbinPlatform.cardbinId.label" default="Cardbin Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="cardbinId" name="cardbinId.id" from="${posscard.CardBin.list()}" optionKey="id" required="" value="${cardbinPlatformInstance?.cardbinId?.id}" class="many-to-one"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardbinPlatformInstance, field: 'cardPlatformId', 'error')} required form-group">
	<label for="cardPlatformId" class="col-sm-2 control-label">
		<g:message code="cardbinPlatform.cardPlatformId.label" default="Card Platform Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="cardPlatformId" name="cardPlatformId.id" from="${posscard.CardPlatform.list()}" optionKey="id" required="" value="${cardbinPlatformInstance?.cardPlatformId?.id}" class="many-to-one"/>
	</div>
</div>

