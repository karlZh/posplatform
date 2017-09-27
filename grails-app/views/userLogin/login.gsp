<%@ page import="posscard.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>用户登录</title>
    <link href="${resource(dir: 'js/bootstrap/dist/css', file: 'bootstrap.css')}" rel="stylesheet">
    <link rel="stylesheet" href="${resource(dir: 'fonts/font-awesome-4/css', file: 'font-awesome.min.css')}">
    <link href="${resource(dir: 'css',file: 'style.css')}" rel="stylesheet" />

</head>
<body class="texture">
<div id="cl-wrapper" class="login-container">

    <div class="middle-login">
        <div class="block-flat">
            <div class="header">
                <h3 class="text-center">后台登录</h3>
            </div>
            <div>
                <g:form style="margin-bottom: 0px !important;" class="form-horizontal" action="login">
                    <div class="content">
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                    <g:textField name="username" placeholder="账号" id="username" class="form-control" value="${info?.username}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                    <g:passwordField name="password" placeholder="密码" id="password" class="form-control" value="${info?.password}"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-6 col-xs-6">
                                <div class="input-group">
                                    <%def rn = new Random().nextInt(2245565)%>
                                    <span class="input-group-addon"><i class="fa fa-lock"></i></span>
                                    <input type="captcha" placeholder="验证码" id="captcha" name="captcha" class="form-control">

                                </div>
                            </div>
                            <div class="col-sm-6 col-xs-6">
                                <div class="input-group">
                                    <img style="height: 39px;" src="${createLink(controller: 'simpleCaptcha', action: 'captcha')}?${rn}" onclick="this.src='${createLink(controller: 'simpleCaptcha', action: 'captcha')}?'+Math.random()"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="foot">

                        <button class="btn btn-primary" data-dismiss="modal" type="submit">登录</button>
                    </div>
                </g:form>
            </div>
        </div>
        <div class="text-center out-links"><a href="#">&copy; 2013 Your Company</a></div>
    </div>

</div>
<script>
    <g:if test="${flash.message}">
    alert("${flash.message}");
    </g:if>
</script>
<script src="${resource(dir: 'js', file: 'jquery.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/behaviour', file: 'general.js')}"></script>
</body>
</html>
