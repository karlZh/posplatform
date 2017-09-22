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
        def supplier = Supplier.get(data.supplierid)
        def cardb = data.cardnum.substring(0,6)
        def cardbinList = []
        for(cardbin in supplier.cardbins){
            cardbinList.add(cardbin.cardbin)
        }
        if(!cardbinList.contains(cardb)){
            result.status = 301
            result.message = "不支持该卡消费"
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
    def scanCode(data){
        def result = [status: 200,message: "",data:[:]]
        if(!data.encryptStr){
            result.status = 302
            result.message = "请输入卡号"
            return result
        }
        if(!data.supplierid){
            result.status = 302
            result.message = "供应商id缺失"
            return result
        }
        def channel = '07'
        def product = '10'
        String keyStr = '+p!ZKg$?xFZ,dynZ';
        def urlK = data.encryptStr.decodeURL()
        def encText = urlK.substring(urlK.indexOf(channel+product)+4)
        String decString = CryptAES.AES_Decrypt(keyStr, encText);
        def cardnum = decString.substring(0,decString.indexOf("="))
        def supplier = Supplier.get(data.supplierid)
        def cardb = cardnum.substring(0,6)
        def cardbinList = []
        for(cardbin in supplier.cardbins){
            cardbinList.add(cardbin.cardbin)
        }
        if(!cardbinList.contains(cardb)){
            result.status = 301
            result.message = "不支持该卡消费"
            return result
        }
        def platRes = zftPlatformService.cardinfo(cardnum)
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
        if(!cardbinInfo){
            result.status = 301
            result.message = "没有对应的卡bin"
            return result
        }
        def orderAmount = ticketType.point.toFloat() * data.num.toFloat()
        def orderInstance = new Orders(
                orderSn: orderSn,
                userId: getSession().user.id,
                serialNum: serialNum,
                amount: orderAmount,
                num: data.num,
                orderType: 1,
                supplierId: data.supplierid,
                ticketTypeId: ticketType.id,
                cardNum: data.cardnum,
                cardPlatformId: cardbinInfo.cardPlatform.id,
                validity: data.validity,
                orderStatus: 0,
                refundStatus: 0
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
    //退款操作
    def orderRefund(data){
        def result = [status: 200,message: "",data:[:]]
        if(!data.tradeno){
            result.status = 302
            result.message = "流水号缺失"
            return result
        }
        if(!data.cardnum){
            result.status = 302
            result.message = "卡号缺失"
            return result
        }

        def orderInfo = Orders.findByOrderSnAndCardNum(data.tradeno,data.cardnum)
        if(!orderInfo){
            result.status = 301
            result.message = "未找到该订单"
            return result
        }
        def date = new Date()
        def randomStr = (int)(Math.random())*10000
        def orderSn = date.format("yyyyMMddHHmmss") + randomStr.toString()
        def serialNum = "100"+ orderSn

        def orderInstance = new OrderRefund(
                orderSn: orderSn,
                userId: getSession().user.id,
                refundOrderSn: orderInfo.orderSn,
                serialNum: serialNum,
                amount: orderInfo.amount,
                num: orderInfo.num,
                supplierId: orderInfo.supplierId,
                ticketTypeId: orderInfo.ticketTypeId,
                cardNum: orderInfo.cardNum,
                cardPlatformId: orderInfo.cardPlatformId,
                orderStatus: 0,
        )
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "创建订单失败"
            return result
        }

        def platRes = zftPlatformService.rollBack(data.cardnum,orderInfo.transId,serialNum)
        if(platRes.state != 0){
            result.status = 401
            result.message = platRes.msg
            return result
        }
        orderInstance.orderStatus = 1
        orderInstance.transId = platRes.data.RefundTransId
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "订单更新失败"
            return result
        }
        orderInfo.refundStatus=1
        if (!orderInfo.save(flush: true)) {
            result.status = 303
            result.message = "订单更新失败"
            return result
        }

        result.message = "退款成功"
        return result

    }
    //退款操作
    def scanCodeRefund(data){
        def result = [status: 200,message: "",data:[:]]
        if(!data.tradeno){
            result.status = 302
            result.message = "流水号缺失"
            return result
        }
        if(!data.cardnum){
            result.status = 302
            result.message = "卡号缺失"
            return result
        }
        def channel = '07'
        def product = '10'
        String keyStr = '+p!ZKg$?xFZ,dynZ';
        def urlK = data.encryptStr.decodeURL()
        def encText = urlK.substring(urlK.indexOf(channel+product)+4)
        String decString = CryptAES.AES_Decrypt(keyStr, encText);
        def cardnum = decString.substring(0,decString.indexOf("="))
        def orderInfo = Orders.findByOrderSnAndCardNum(data.tradeno,cardnum)
        if(!orderInfo){
            result.status = 301
            result.message = "未找到该订单"
            return result
        }
        def date = new Date()
        def randomStr = (int)(Math.random())*10000
        def orderSn = date.format("yyyyMMddHHmmss") + randomStr.toString()
        def serialNum = "100"+ orderSn

        def orderInstance = new OrderRefund(
                orderSn: orderSn,
                userId: getSession().user.id,
                refundOrderSn: orderInfo.orderSn,
                serialNum: serialNum,
                amount: orderInfo.amount,
                num: orderInfo.num,
                supplierId: orderInfo.supplierId,
                ticketTypeId: orderInfo.ticketTypeId,
                cardNum: orderInfo.cardNum,
                cardPlatformId: orderInfo.cardPlatformId,
                orderStatus: 0,
        )
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "创建订单失败"
            return result
        }

        def platRes = zftPlatformService.rollBack(cardnum,orderInfo.transId,serialNum)
        if(platRes.state != 0){
            result.status = 401
            result.message = platRes.msg
            return result
        }
        orderInstance.orderStatus = 1
        orderInstance.transId = platRes.data.RefundTransId
        if (!orderInstance.save(flush: true)) {
            result.status = 303
            result.message = "订单更新失败"
            return result
        }
        orderInfo.refundStatus=1
        if (!orderInfo.save(flush: true)) {
            result.status = 303
            result.message = "订单更新失败"
            return result
        }

        result.message = "退款成功"
        return result

    }
    //    查询订单
    def orderSearch(data){
        def result = [status: 200, message: "", data: [:]]
        if(!data.tradeno){
            result.status = 302
            result.message = "输入流水号"
            return result
        }
        def orderInfo = Orders.findByOrderSn(data.tradeno)
        if (!orderInfo) {
            result.status = 301
            result.message = "流水号不存在"
            return result
        }
        def ticketTypeInfo = TicketType.findById(orderInfo.ticketTypeId)
        def supplierInfo = Supplier.findById(orderInfo.supplierId);
        def ticketTypeCnbc= ticketTypeInfo.name+'影片('+ticketTypeInfo.point.toString()+')'
        result.message = "查询成功！"
        result.data = [
                orderSn:orderInfo.orderSn,
                amount: orderInfo.amount,
                cardNum: orderInfo.cardNum,
                ticketTypeCn: ticketTypeCnbc,
                num: orderInfo.num,
                supplier: supplierInfo.name,
                dateCreated: orderInfo.dateCreated.format("yyyy-MM-dd HH:mm:ss"),
                statusCn: orderInfo.refundStatus?'已退款':(orderInfo.orderStatus?"扣款成功":"扣款失败")
        ]
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
