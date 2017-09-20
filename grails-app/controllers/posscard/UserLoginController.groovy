package posscard

class UserLoginController {

    def login(){
        if(request.method == "GET"){
            session.userId = null
            session.accountType = null
        }else{
            def userInstance = User.findByUsernameAndPassword(params.username,params.password)
            if(userInstance){
                session.userId = userInstance.id
                session.accountType = userInstance.accountType
                session.uTypeId = userInstance.uTypeId
                def requestParams=session.originReqParams?session.originReqParams:[controller: 'user',action: 'index']
                redirect(requestParams)
            }else{
                flash['message'] = "用户名或密码错误"
            }
        }
    }

    def logout(){
        session.userId = null
        session.accountType = null
        session.uTypeId = null
        redirect(controller: 'userLogin',action: 'login')
    }
}
