<%@ page import="posscard.CardBin" %>



<div class="fieldcontain ${hasErrors(bean: cardBinInstance, field: 'cardbin', 'error')} required form-group">
	<label for="cardbin" class="col-sm-2 control-label">
		<g:message code="cardBin.cardbin.label" default="卡号前6位" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="cardbin" required="" value="${cardBinInstance?.cardbin}"/>
	</div>
</div>


<div class="fieldcontain ${hasErrors(bean: cardBinInstance, field: 'cardbinPlatform', 'error')}  form-group">
	<label for="cardbinPlatform" class="col-sm-2 control-label">
		<g:message code="cardBin.cardbinPlatform.label" default="商户" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:select id="cardPlatform" name="cardPlatform.id" from="${posscard.CardPlatform.list()}" optionKey="id" required="" value="${cardBinInstance?.cardPlatform?.id}" class="many-to-one"/>
	</div>
</div>

