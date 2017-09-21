<div class="cl-sidebar">
    <div class="cl-toggle"><i class="fa fa-bars"></i></div>
    <div class="cl-navblock">

        <div class="menu-space">
            <div class="content">
                <ul class="cl-vnavigation">
                    %{--<li class="parent open"><a href="#"><i class="fa fa-home"></i><span>供应商</span></a>--}%
                        %{--<ul class="sub-menu" style="display: block;">--}%
                            %{--<li><g:link controller="supplier" action="list">院线</g:link></li>--}%
                            %{--<li><g:link controller="supplier" action="list">影院列表</g:link></li>--}%
                            %{--<li><g:link controller="supplier" action="list">订单查询</g:link></li>--}%
                        %{--</ul>--}%
                    %{--</li>--}%
                    <li><g:link controller="record" action="record"><span>操作记录</span></g:link></li>
                    <li><g:link controller="supplier" action="yuanxianList">院线</g:link></li>
                    <li><g:link controller="supplier" action="yingyuanList"><span>影院列表</span></g:link></li>
                    <li><g:link controller="orders" action="supplierformList"><span>订单查询</span></g:link></li>
                </ul>
            </div>
        </div>
        <div class="text-right collapse-button" style="padding:7px 9px;">
            <input type="text" class="form-control search" placeholder="Search..." />
            <button id="sidebar-collapse" class="btn btn-default" style=""><i style="color:#fff;" class="fa fa-angle-left"></i></button>
        </div>
    </div>
</div>
