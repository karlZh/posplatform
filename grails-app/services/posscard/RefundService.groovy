package posscard

import org.springframework.web.context.request.RequestContextHolder

class RefundService {

    def result = [status: 200,message: "",data:[:]]
    def orderRefund(data){//退款  根据流水号退款
        def orders=Orders.findAllBySerialNum(data.serialNum)
        if (!orders){

            result.status = 301
            result.message="退款不成功"
            return result
        }
        result.message = "退款成功成功！"
        result.data=orders
        return result

    }

}