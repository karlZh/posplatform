<%@ page import="posscard.Supplier" %>



<div class="form-group">
	<label class="col-sm-2 control-label">
		<g:message code="supplier.cardBin.label" default="卡BIN" />
	</label>
	<div class="col-sm-6">
		%{--<g:select name="cardbins" from="${posscard.CardBin.list()}" multiple="multiple" optionKey="id" size="5" value="${supplierInstance?.cardbins*.id}" class="many-to-many"/>--}%

		<g:each in="${posscard.CardBin.list()}" status="i" var="cardbin">
			<label class="checkbox-inline"><g:checkBox name="cardbins" value="${cardbin.id}" />${cardbin.cardbin}</label>
		</g:each>
	</div>

</div>