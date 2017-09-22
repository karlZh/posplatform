<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>供应商表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="list">供应商表</g:link></li>
				<li class="active">操作供应商</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>修改供应商</h3>
						</div>
						<div class="content">
							<g:if test="${flash.message}">
								<div class="message" role="status">${flash.message}</div>
							</g:if>
							<g:hasErrors bean="${supplierInstance}">
								<ul class="errors" role="alert">
									<g:eachError bean="${supplierInstance}" var="error">
										<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
									</g:eachError>
								</ul>
							</g:hasErrors>
							<g:form class="form-horizontal" role="form" action="save" >
								<g:hiddenField name="id" value="${supplierInstance?.id}" />
								<g:hiddenField name="version" value="${supplierInstance?.version}" />
								<g:render template="form"/>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<g:actionSubmit class="btn btn-primary" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
										<g:actionSubmit class="btn btn-danger" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
									</div>
								</div>
							</g:form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
        $(function () {
            TypeBind();
            //默认绑定省
            $("#type").change(function(){
                TypeBind();
            });
            //绑定事件
            $("#Province").change( function () {
                CityBind();
            });

            $("#City").change(function () {
                VillageBind();
            })

        })
        function TypeBind() {
            //清空下拉数据
            var parentid = ${supplierInstance.parentId}
            var supplierType = $("#type option:selected").val();
            var str = "<option value='0'>顶级供应商</option>";
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
                        var selected = parentid==item.id&&"selected"
                        str += "<option value=" + item.id + " "+selected+">" + item.name + "</option>";
                    })
                    //将数据添加到省份这个下拉框里面
                    $("#parentId").html(str);
                },
                error: function () { alert("Error"); }
            });




        }
	</script>

	</body>
</html>
