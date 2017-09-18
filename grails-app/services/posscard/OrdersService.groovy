package posscard

import org.springframework.web.context.request.RequestContextHolder

/**
 * Created by user on 2017-09-14.
 */

class OrdersService {
    def zftPlatformService
    def checkCard(data){
        def result = [status: 200,message: "",data:[:]]
        if(!data.cardnum){
            result.status = 302
            result.message = "请输入卡号"
            return result
        }
        if(!data.supplierid){
            result.status = 302
            result.message = "供应商id缺失"
            return result
        }
        def platRes = zftPlatformService.cardinfo(data.cardnum)
        if(platRes.state != 0){
            result.status = 401
            result.message = platRes.msg
            return result
        }

        def ticketType = TicketType.findAllBySupplier(Supplier.get(data.supplierid))
        result.data.cardInfo = platRes.data
        result.data.ticketType = ticketType
        return result
    }
    def orderPay(data){
        def result = [status: 200,message: "",data:[:]]
        if(!data.cardnum){
            result.status = 302
            result.message = "请输入卡号"
            return result
        }
        if(!data.supplierid){
            result.status = 302
            result.message = "供应商id缺失"
            return result
        }
        if(!data.point){
            result.status = 302
            result.message = "缺少单价点数"
            return result
        }
        if(!data.num){
            result.status = 302
            result.message = "输入购票张数"
            return result
        }
        if(!data.typeid){
            result.status = 302
            result.message = "选择购票类型"
            return result
        }
        if(!data.validity){
            result.status = 302
            result.message = "卡有效期为空"
            return result
        }
        def supplierInfo = Supplier.get(data.supplierid)
        if(!supplierInfo){
            result.status = 301
            result.message = "没有对应的供应商"
            return result
        }
        def ticketType = TicketType.findBySupplierAndId(supplierInfo,data.typeid)
        if(!ticketType){
            result.status = 301
            result.message = "没有对应的票类型"
            return result
        }
        if(data.point.toDouble() != ticketType.point.toDouble()){
            result.status = 302
            result.message = "价格已更改请重新选择类型"
            return result
        }
        def date = new Date()
        def randomStr = (int)(Math.random())*10000
        def orderSn = date.format("yyyyMMddHHmmss") + randomStr.toString()
        def serialNum = "100"+ orderSn
        def cardbin = data.cardnum.substring(0,6)

        def cardbinInfo = CardBin.findByCardbin(cardbin)
        def orderAmount = ticketType.point.toFloat() * data.num.toFloat()
        def orderInstance = new Orders(
                orderSn: orderSn,
                serialNum: serialNum,
                amount: orderAmount,
                num: data.num,
                orderType: 1,
                supplierId: data.supplierid,
                ticketTypeId: ticketType.id,
                cardNum: data.cardnum,
                cardPlatformId: cardbinInfo.cardPlatform.id,
                validity: data.validity,
                orderStatus: 0
        )
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "创建订单失败"
            return result
        }
        def platRes = zftPlatformService.cardpay(data.cardnum,ticketType.point.toString(),serialNum,data.num.toString())
        if(platRes.state != 0){
            result.status = 401
            result.message = platRes.msg
            return result
        }
        orderInstance.orderStatus = 1
        orderInstance.transId = platRes.data.TransId
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "订单更新失败"
            return result
        }
        result.data = [orderSn: orderSn,cardNum: data.cardnum,ticketType: ticketType.name, amount: orderAmount,num: data.num,cardPlatform: cardbinInfo.cardPlatform.name]
        result.message = "支付成功"
        return result
    }
    def orderRefund(data){
        def result = [status: 200,message: "",data:[:]]


        def orderInfo = Orders.findByOrderSn(data.tradeno)
        if(!orderInfo){
            result.status = 30
            result.message = "未找到该订单"
            return result
        }
        
    }
    def orderSearch(data){
        def result = [status: 200, message: "", data: [:]]
        def orderInfo = Orders.findAllBySerialNum(data.serialNum)
        if (!orderInfo) {

            result.status = 301
            result.message = "流水号不存在"
            return result
        }
        result.message = "查询成功！"
        result.data = orderInfo
        return result
    }
}
