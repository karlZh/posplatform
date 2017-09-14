package posscard

import org.omg.CORBA.NameValuePair
import org.springframework.web.context.request.RequestContextHolder

class UserService {
    def result = [status: 200,message: "",data:[:]]
    def signIn(data) {
        def user = User.findByUsernameAndPassword(data.username,data.password)
        if(user){
            getSession().user = user
        }else{
            result.status = 301
            result.message = "用户不存在或密码错误！"
            return result
        }
        result.message = "签到成功！"
        return result
    }

    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
