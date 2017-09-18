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
		
	</label>
	<div class="col-sm-6">
	
<ul class="one-to-many">
<g:each in="${cardBinInstance?.cardbinPlatform?}" var="c">
    <li><g:link controller="cardbinPlatform" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="cardbinPlatform" action="create" params="['cardBin.id': cardBinInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform')])}</g:link>
</li>
</ul>

	</div>
</div>

