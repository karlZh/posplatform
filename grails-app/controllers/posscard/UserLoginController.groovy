package posscard

class UserLoginController {

    def login(){
        if(request.method == "GET"){
            session.userId = null
            session.accountType = null
            session.uTypeId = null


        }else{
            def userInstance = User.findByUsernameAndPassword(params.username,params.password)
            if(userInstance){
                session.userId = userInstance.id
                session.accountType = userInstance.accountType
                session.uTypeId = userInstance.uTypeId
                session.username=userInstance.username
                def r=new Record(user: params.username,loginTime: new Date() ,userType: session.uTypeId)
                r.save()

//                def requestParams=session.originReqParams?session.originReqParams:[controller: 'user',action: 'index']
                def requestParams=[controller: 'record',action: 'index']
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
