package posscard

class UserLoginController {
    def simpleCaptchaService
    def login(){
        if(request.method == "GET"){
            session.userId = null
            session.accountType = null
            session.uTypeId = null
            session.parentId=null
        }else{
            boolean captchaValid = simpleCaptchaService.validateCaptcha(params.captcha)
            if(!captchaValid){
                flash['message'] = "验证码错误"
                render(view:'login' , model: [info: params])
                return
            }
            def userInstance = User.findByUsernameAndPasswordAndIsdelete(params.username,params.password,0)
            if(userInstance){
                session.userId = userInstance.id
                session.accountType = userInstance.accountType
                session.uTypeId = userInstance.uTypeId
                session.username=userInstance.username

                def r=new Record(user: params.username,loginTime: new Date() ,accountType: session.accountType )
                r.save(flush: true)
//                def requestParams=session.originReqParams?session.originReqParams:[controller: 'user',action: 'index']
                def requestParams
                    switch (userInstance.accountType)
                    {
                        case 1:
                            flash['message'] = "该用户名无登陆权限"
                            break
                        case 2:
                            requestParams=[controller: 'record',action: 'index']
                            break
                        case 3:
                            requestParams=[controller: 'orders',action: 'platformList']
                            break
                        case 4:
                            requestParams=[controller: 'supplier',action: 'yuanxianList']
                    }
                    if(requestParams){
                        redirect(requestParams)
                    }
                }else{
                    flash['message'] = "用户名或密码错误"
                }
        }
    }

    def logout(){
        session.userId = null
        session.accountType = null
        session.uTypeId = null
        session.parentId=null
        redirect(controller: 'userLogin',action: 'login')
    }
}
