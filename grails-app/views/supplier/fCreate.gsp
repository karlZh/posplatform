<%@ page import="posscard.Supplier" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="admin">
		<g:set var="entityName" value="${message(code: 'supplier.label', default: 'Supplier')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
	</head>
	<body>
	<div class="container-fluid" id="pcont">
		<div class="page-head">
			<h2>供应商表</h2>
			<ol class="breadcrumb">
				<li><a href="${createLink(uri: '/')}">首页</a></li>
				<li><g:link class="list" action="fList">供应商表</g:link></li>
				<li class="active">操作供应商</li>
			</ol>
		</div>
		<div class="cl-mcont">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="block-flat">
						<div class="header">
							<h3>创建供应商</h3>
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
							<g:form class="form-horizontal" role="form" action="fSave" >
								<g:render template="fform"/>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<g:submitButton name="fCreate" class="btn btn-primary" value="${message(code: 'default.button.create.label', default: 'Create')}" />
										<a href="javascript:history.go(-1)" class="btn btn-default">Cancel</a>
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


            //默认绑定省
			$("#type").change(function(){
                TypeBind();
            });
            //绑定事件
            $("#Province").change( function () {
                CityBind();
            })

            $("#City").change(function () {
                VillageBind();
            })




        })
        function Bind(str) {
            alert($("#Province").html());
            $("#Province").val(str);


        }
        function TypeBind() {
            //清空下拉数据
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
                        str += "<option value=" + item.id + ">" + item.name + "</option>";
                    })
                    //将数据添加到省份这个下拉框里面
                    $("#parentId").html(str);
                },
                error: function () { alert("Error"); }
            });




        }
        function CityBind() {


            var provice = $("#Province").attr("value");
            //判断省份这个下拉框选中的值是否为空
            if (provice == "") {
                return;
            }
            $("#City").html("");
            var str = "<option>==请选择===</option>";


            $.ajax({
                type: "POST",
                url: "/Home/GetAddress",
                data: { "parentiD": provice, "MyColums": "City" },
                dataType: "JSON",
                async: false,
                success: function (data) {
                    //从服务器获取数据进行绑定
                    $.each(data.Data, function (i, item) {
                        str += "<option value=" + item.Id + ">" + item.MyTexts + "</option>";
                    })
                    //将数据添加到省份这个下拉框里面
                    $("#City").append(str);
                },
                error: function () { alert("Error"); }
            });


        }
        function VillageBind() {


            var provice = $("#City").attr("value");
            //判断市这个下拉框选中的值是否为空
            if (provice == "") {
                return;
            }
            $("#Village").html("");
            var str = "<option>==请选择===</option>";
            //将市的ID拿到数据库进行查询，查询出他的下级进行绑定
            $.ajax({
                type: "POST",
                url: "/Home/GetAddress",
                data: { "parentiD": provice, "MyColums": "Village" },
                dataType: "JSON",
                async: false,
                success: function (data) {
                    //从服务器获取数据进行绑定
                    $.each(data.Data, function (i, item) {
                        str += "<option value=" + item.Id + ">" + item.MyTexts + "</option>";
                    })
                    //将数据添加到省份这个下拉框里面
                    $("#Village").append(str);
                },
                error: function () { alert("Error"); }
            });
            //$.post("/Home/GetAddress", { parentiD: provice, MyColums: "Village" }, function (data) {
            //    $.each(data.Data, function (i, item) {
            //        str += "<option value=" + item.Id + ">" + item.MyTexts + "</option>";
            //    })
            //    $("#Village").append(str);
            //})
        }
	</script>
	</body>
</html>
