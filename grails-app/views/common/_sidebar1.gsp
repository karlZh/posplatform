<div class="cl-sidebar">
    <div class="cl-toggle"><i class="fa fa-bars"></i></div>
    <div class="cl-navblock">
        <div class="menu-space">
            <div class="content">
                <div class="side-user">
                    <div class="info">

                            <div style="width: 40%" aria-valuemax="100" aria-valuemin="0" aria-valuenow="40"
                                 role="progressbar" class="progress-bar progress-bar-info">


                        </div>
                    </div>
                </div>
                <ul class="cl-vnavigation">
                    <li><g:link controller="user" action="list"><!--<i class="fa fa-home"></i>--><span>用户信息</span></g:link>

                    </li>
                    <li><g:link controller="cardPlatform" action="list"> <!--<i class="fa fa-smile-o"></i>--><span>商户信息</span></li></g:link>

                    </li>
                    <li><g:link controller="supplier" action="list"> 供应商</span></g:link>

                    </li>
                    <li><g:link controller="orders" action="list"><span>订单</span></g:link>

                    </li>
                    <li><g:link controller="cardBin" action="list"><span>卡BIN</span></g:link>

                    </li>

                    <li><g:link controller="posMachine" action="list"><span>Pos机</span></g:link>
                    </li>
                    <li><g:link controller="ticketType" action="list"><span>消费类型</span></g:link></li>
                    <!--<li><a href="typography.html"><span>Pos机</span></a>

                    </li>
                    <li><a href="charts.html"><span>消费类型</span></a></li>-->

                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <div class="text-right collapse-button" style="padding:7px 9px;">
            <g:form controller="search" action="list">
            <input type="text" name="username" class="form-control search" placeholder="Search..." />

           <button id="sidebar-collapse" class="btn btn-default" style=""><i style="color:#fff;" class="fa fa-angle-left"></i></button>
            </g:form>
        </div>
    </div>
</div>