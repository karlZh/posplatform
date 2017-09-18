package posscard

import org.springframework.web.context.request.RequestContextHolder

class UserService {

    def signIn(data) {
        def result = [status: 200,message: "",data:[:]]
        def user = User.findByUsernameAndPassword(data.username,data.password)
        
        if(user){
            if(user.accountType != 1){
                result.status = 301
                result.message = "非pos机用户,请用pos机用户登录！"
                return result
            }
            getSession().user = user
            result.data.userid = user.id
            result.data.supplierid = user.supplier.id
        }else{
            result.status = 301
            result.message = "用户不存在或密码错误！"
            return result
        }
        result.message = "签到成功！"
        return result
    }

    def signOut() {
        def result = [status: 200,message: "",data:[:]]

        getSession().user = null
        result.message = "签出成功！"
        return result
    }

    def checkSign(){
        def result = [status: 200,message: "",data:[:]]

        if(!getSession().user){
            result.status = 301
            result.message = "未登录请重新登陆！"
            return result
        }
        result.message = "登陆状态！"
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
