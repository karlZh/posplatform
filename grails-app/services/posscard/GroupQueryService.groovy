package posscard

import org.springframework.web.context.request.RequestContextHolder

class GroupQueryService {

    def searchCount(data) {
        def result=[status:200,message:"",data:[:]]
        def user_id = getSession().user.id
        def count = Orders.executeQuery("select sum(a.num) as sumNum,sum(amount) as sunAmount from Orders a where a.userId="+user_id)
        if (!count){
            result.status=301
            result.message="查询错误"
            return result
        }
        result.data=count
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
