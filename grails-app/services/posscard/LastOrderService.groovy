package posscard

class LastOrderService {
    def result=[status: 200,message: "",data:[:]]

    def last(data) {
        def last=Orders.findByDateCreatedGreaterThanAndDateCreated(data.dateCreated)
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
