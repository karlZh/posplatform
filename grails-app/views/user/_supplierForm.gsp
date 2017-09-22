<%@ page import="posscard.User" %>


<g:hiddenField name="accountType" value="${accountType}" />
<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required form-group">
	<label for="username" class="col-sm-2 control-label">
		<g:message code="user.username.label" default="用户名" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="username" maxlength="10" required="" value="${userInstance?.username}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required form-group">
	<label for="password" class="col-sm-2 control-label">
		<g:message code="user.password.label" default="密码" />
		<span class="required-indicator">*</span>
	</label>
	<div class="col-sm-6">
	<g:field type="password" class="form-control" name="password" maxlength="20" required="" value="${userInstance?.password}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'phone', 'error')}  form-group">
	<label for="phone" class="col-sm-2 control-label">
		<g:message code="user.phone.label" default="电话" />
		
	</label>
	<div class="col-sm-6">
	<g:textField class="form-control" name="phone" pattern="${userInstance.constraints.phone.matches}" value="${userInstance?.phone}"/>
	</div>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'accountType', 'error')}  form-group">
	<label for="uTypeId" class="col-sm-2 control-label">
		<g:message code="user.accountType.label" default="用户类别" />

	</label>
	<div class="col-sm-6">
		<g:select id="type" name="type" from="${supplierType}" optionKey="key" optionValue="value" value="${supplierInstance?.type}" noSelection="[0:'请选择分类']" />
		<g:select id="parentId" name="parentId" from="${psuppliers}" optionKey="id" optionValue="name" value="${supplierInstance?.parentId}" noSelection="[0:'请选择父供应商']" />
		<g:select name="uTypeId" id="supplier" from="${csuppliers}" optionKey="id" optionValue="name" value="${userInstance?.uTypeId}"  noSelection="['0': '请选择类别']" />
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