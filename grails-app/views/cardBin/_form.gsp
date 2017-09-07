<%@ page import="posscard.CardBin" %>



<div class="fieldcontain ${hasErrors(bean: cardBinInstance, field: 'cardPlatformId', 'error')} required form-group">
	<label for="cardPlatformId" class="col-sm-2 control-label">
		<g:message code="cardBin.cardPlatformId.label" default="Card Platform Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="cardPlatformId" type="number" value="${cardBinInstance.cardPlatformId}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: cardBinInstance, field: 'createTime', 'error')} required form-group">
	<label for="createTime" class="col-sm-2 control-label">
		<g:message code="cardBin.createTime.label" default="Create Time" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-10">
	<g:field name="createTime" type="number" value="${cardBinInstance.createTime}" required=""/>
	</div>
</div>

