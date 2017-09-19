package posscard

class LastOrderService {//上个订单查询

    def last() {
        def result=[status: 200,message: "",data:[:]]
        def last=Orders.findByOrderStatusAndOrderType(1,1,[order:'desc',sort:'dateCreated'])
        if (!last){
            result.status=301
            result.message="查询失误"
            return result
        }
        result.message=""
        result.data=last
        return result
    }
}
