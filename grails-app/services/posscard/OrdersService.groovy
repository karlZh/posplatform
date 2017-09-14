package posscard

import org.springframework.web.context.request.RequestContextHolder

/**
 * Created by user on 2017-09-14.
 */
class OrdersService {
    def result = [status: 200,message: "",data:[:]]
    def orderRefund(data){
        def orderInfo = Orders.findById(data.orderid)

    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
