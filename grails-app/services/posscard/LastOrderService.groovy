package posscard

class LastOrderService {//上个订单查询

    def last() {
        def result=[status: 200,message: "",data:[:]]
        def last=Orders.findByOrderStatusAndOrderType(1,1,[order:'desc',sort:'dateCreated'])
        def ticketType = TicketType.findById(last.ticketTypeId)
        def supplierInfo = Supplier.findById(last.supplierId)
        if (!last){
            result.status=301
            result.message="查询失误"
            return result
        }
        result.message=""
        result.data=[orderSn: last.orderSn,cardNum: last.cardNum,ticketType: ticketType.name, amount: last.amount,num: last.num,supplierCn: supplierInfo.name]
        return result
    }
}
