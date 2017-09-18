<div id="head-nav" class="navbar navbar-default navbar-fixed-top">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="fa fa-gear"></span>
            </button>
            %{--<a class="navbar-brand" href="#"><span>聚优福利</span></a>--}%
            %{--<img src="juyoufuli.png" style="width:30px;height:30px;">--}%
            <g:img dir="images" file="juyoufuli.png"/>
            %{--<img src="${resource(dir: 'resources',file:'juyoufuli.png')}">--}%
        </div>
        <div class="navbar-collapse collapse">


            <ul class="nav navbar-nav navbar-right user-nav">
                <li class="dropdown profile_menu">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><img alt="Avatar" src="\${resource(dir: 'images', file: 'avatar2.jpg')}" />Jeff Hanneman <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">My Account</a></li>
                        <li><a href="#">Profile</a></li>
                        <li><a href="#">Messages</a></li>
                        <li class="divider"></li>
                        <li><g:link controller="login" action="login">Sign Out</g:link></li>
                    </ul>
                </li>
            </ul>


        </div><!--/.nav-collapse -->
    </div>
</div>