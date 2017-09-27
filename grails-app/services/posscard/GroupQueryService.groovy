package posscard

import org.springframework.web.context.request.RequestContextHolder

class GroupQueryService {

    def searchCount(data) {
        def result=[status:200,message:"",data:[:]]
        def user_id = getSession().user.id
        def orderList = Orders.findAllByUserId(user_id)
        if(!orderList){
            result.data=[totalCount:0,totalAmount:0]
            return result
        }

        result.data=[totalCount:orderList.num.sum(),totalAmount:orderList.amount.sum()]
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
