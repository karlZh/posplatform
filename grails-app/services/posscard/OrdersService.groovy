package posscard

import org.springframework.web.context.request.RequestContextHolder

/**
 * Created by user on 2017-09-14.
 */

class OrdersService {//根据流水号查询订单信息
    def result = [status: 200,message: "",data:[:]]
    def orderSearch(data){
        def orderInfo = Orders.findAllBySerialNum(data.serialNum)
        if (!orderInfo){

            result.status = 301
            result.message="流水号不存在"
            return result
        }
        result.message = "查询成功！"
        result.data=orderInfo
        return result

    }

}
