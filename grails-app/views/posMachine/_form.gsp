<%@ page import="posscard.PosMachine" %>



<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'name', 'error')}  form-group">
	<label for="name" class="col-sm-2 control-label">
		<g:message code="posMachine.name.label" default="Name" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="name" value="${posMachineInstance?.name}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: posMachineInstance, field: 'supplier', 'error')} required form-group">
	<label for="supplier" class="col-sm-2 control-label">
		<g:message code="posMachine.supplier.label" default="供应商ID" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
		<g:select id="type" name="type" from="${supplierType}" optionKey="key" optionValue="value" value="${supplierInstance?.type}" noSelection="[0:'请选择分类']" />
		<g:select id="parentId" name="parentId" from="${psuppliers}" optionKey="id" optionValue="name" value="${supplierInstance?.parentId}" noSelection="[0:'请选择父供应商']" />
		<g:select id="supplier" name="supplier.id" from="${csuppliers}" optionKey="id" required="" value="${posMachineInstance?.supplier?.id}" noSelection="[0:'请选择供应商']" class="many-to-one"/>
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
        $("#supplier").html("<option value='0'>请选择供应商</option>");
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
        var str = "<option>请选择供应商</option>";
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
