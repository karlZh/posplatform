
<%@ page import="posscard.Supplier; posscard.Orders" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="admin">
    <g:set var="entityName" value="${message(code: 'orders.label', default: 'Orders')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style>
        .menu_yazhuo{
            list-style: none;
            width:150px;
            margin-left:-30px;
        }
        .dropdown-menuyazhuo{
            position:absolute;
            left:44px;
            min-width: 120px;
        }
    </style>
</head>
<body>
<div class="container-fluid" id="pcont">
    <div class="page-head">
        <h2>订单表</h2>
        <ol class="breadcrumb">
            <li>首页</li>
            <li class="active">订单表</li>
        </ol>
    </div>
    <div style="padding:25px 12px">
        <div class="text-right collapse-button" style="padding:7px 3px;">
            <div class="col-sm-6">
          %{--<g:form controller="orders" action="supplierZSearch">--}%
              %{--<g:select name="name" id="name" class="form-control" from="${posscard.Supplier.findByParentId( posscard.Supplier.findById( session.uTypeId).id)}"--}%
                       %{--optionKey="id" optionValue="name" value=""  noSelection="['0': '请选择子供应商']"/>--}%
            %{--<Button type="primary" shape="circle" style="padding: 10px">查询</Button>--}%
          %{--</g:form>--}%
            <div class="btn-group">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    请选择子供应商  <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                    <g:each in="${posscard.Supplier.findAllByParentId(Supplier.findById(session.uTypeId).id)}" status="i" var="supplier">

                    <li><g:link controller="orders" action="supplierZList" id="${supplier.id}">${supplier.name}</g:link></li>
                    </g:each>
                </ul>
            </div>
            </div>

            <g:form controller="orders" action="supplierZSearch">
                <input type="text" name="name" style="padding: 10px 23px " placeholder="请输入订单号" />
                <g:hiddenField name="id" value="${id}"/>
                <Button type="primary" shape="circle" style="padding: 10px">提交</Button>
                <!-- <button id="sidebar-collapse" class="btn btn-default" style="padding: 10px 7px" name="提交"><i style="color:#fff;" class="fa fa-angle-left"></i></button>-->
            </g:form>

        </div>
        <div class="cl-mcont">
            <div class="row">
                <div class="col-md-12">
                    <div class="block-flat">

                        <div class="content">
                            <div>
                                <table>
                                    <thead>
                                    <tr>
                                        <g:sortableColumn property="orderSn" title="${message(code: 'orders.orderSn.label', default: '订单号')}" />

                                        <g:sortableColumn property="cardNum" title="${message(code: 'orders.cardNum.label', default: '用户名')}" />

                                        <g:sortableColumn property="amount" title="${message(code: 'orders.amount.label', default: '应扣订单总金额')}" />

                                        <g:sortableColumn property="actualAmount" title="${message(code: 'orders.actualAmount.label', default: '实扣总金额')}" />

                                        <g:sortableColumn property="cardPlatformId" title="${message(code: 'orders.cardPlatformId.label', default: '商户')}" />

                                        <g:sortableColumn property="supplierId" title="${message(code: 'orders.supplierId.label', default: '供应商')}" />



                                        <g:sortableColumn property="serialNum" title="${message(code: 'orders.serialNum.label', default: '流水号')}" />
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <g:each in="${ordersInstanceList}" status="i" var="ordersInstance">
                                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
                                            <g:link action="show" id="${ordersInstance.id}"></g:link>
                                            <td>${fieldValue(bean: ordersInstance, field: "orderSn")}</td>

                                            <td>${fieldValue(bean: ordersInstance, field: "cardNum")}</td>

                                            <td>${fieldValue(bean: ordersInstance, field: "amount")}</td>

                                            <td>${fieldValue(bean: ordersInstance, field: "actualAmount")}</td>

                                            <td>${posscard.CardPlatform.findById(ordersInstance.cardPlatformId).name}</td>

                                            <td>${posscard.Supplier.findById(ordersInstance.supplierId).name}</td>



                                            <td>${fieldValue(bean: ordersInstance, field: "serialNum")}</td>

                                            <td class="center ">
                                                <g:link action="platformShow" id="${ordersInstance.id}" class="btn btn-default btn-xs" href="#" data-original-title="查看详细" data-toggle="tooltip">
                                                    查看详细
                                                </g:link>


                                            </td>
                                        </tr>
                                    </g:each>
                                    </tbody>
                                </table>
                                <div class="pagination">
                                    <g:paginate total="${ordersInstanceTotal}" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>

</body>
</html>
