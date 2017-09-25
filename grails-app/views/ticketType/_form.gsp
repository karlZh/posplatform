<%@ page import="posscard.TicketType" %>



<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="ticketType.name.label" default="类型名称" />
        <span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" value="${ticketTypeInstance?.name}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'point', 'error')} required form-group">
	<label for="point" class="col-sm-2 control-label">
		<g:message code="ticketType.point.label" default="扣点数" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="point" value="${fieldValue(bean: ticketTypeInstance, field: 'point')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'accountPoint', 'error')} required form-group">
	<label for="accountPoint" class="col-sm-2 control-label">
		<g:message code="ticketType.accountPoint.label" default="结算点数" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="accountPoint" value="${fieldValue(bean: ticketTypeInstance, field: 'accountPoint')}" required=""/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'accountRatio', 'error')} required form-group">
	<label for="accountRatio" class="col-sm-2 control-label">
		<g:message code="ticketType.accountRatio.label" default="结算比例" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field name="accountRatio" value="${fieldValue(bean: ticketTypeInstance, field: 'accountRatio')}" required=""/>%
	</div>
</div>


<div class="fieldcontain ${hasErrors(bean: ticketTypeInstance, field: 'supplierId', 'error')} required form-group">
	<label for="supplier" class="col-sm-2 control-label">
		<g:message code="ticketType.supplier.label" default="供应商 Id" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
		<g:select id="type" name="type" from="${supplierType}" optionKey="key" optionValue="value" value="${supplierInstance?.type}" noSelection="[0:'请选择分类']" />
		<g:select id="parentId" name="parentId" from="${psuppliers}" optionKey="id" optionValue="name" value="${supplierInstance?.parentId}" noSelection="[0:'请选择父供应商']" />
		<g:select id="supplier" name="supplier.id" from="${csuppliers}" optionKey="id" optionValue="name" required="" value="${ticketTypeInstance?.supplier?.id}" noSelection="[0:'请选择供应商']" class="many-to-one"/>
	</div>
</div>
<script>
    $(function () {
        //默认绑定省
        $("#type").change(function(){
            TypeBind();
        });
        //绑定事件
        $("#parentId").change( function () {
            ParenBind();
        })
    })
    function TypeBind() {
        //清空下拉数据
        var supplierType = $("#type option:selected").val();
        if(supplierType == "") return
        var str = "<option value='0'>请选择父供应商</option>";
        $("#parentId").html("");
        $("#supplier").html("");
        $.ajax({
            type: "POST",
            url: "${createLink(uri: '/Supplier/ajaxSearchSupplier')}",
            data: { "type": supplierType },
            dataType: "JSON",
            async: false,
            success: function (result) {
                console.log(result)
                //从服务器获取数据进行绑定
                $.each(result.data, function (i, item) {
                    str += "<option value=" + item.id + ">" + item.name + "</option>";
                })
                //将数据添加到省份这个下拉框里面
                $("#parentId").html(str);
            },
            error: function () { alert("Error"); }
        });
    }
    function ParenBind() {
        var supplierType = $("#type option:selected").val();
        if(supplierType == '') return
        var parentId = $("#parentId option:selected").val();
        var str = "";
        $("#supplier").html("");
        $.ajax({
            type: "POST",
            url: "${createLink(uri: '/Supplier/ajaxSearchSupplier')}",
            data: { "type": supplierType, "parentId": parentId },
            dataType: "JSON",
            async: false,
            success: function (result) {
                //从服务器获取数据进行绑定
                $.each(result.data, function (i, item) {
                    str += "<option value=" + item.id + ">" + item.name + "</option>";
                })
                //将数据添加到省份这个下拉框里面
                $("#supplier").html(str);
            },
            error: function () { alert("Error"); }
        });


    }
</script>
