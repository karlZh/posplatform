package posscard

class GroupQueryService {

    def result=[status:200,message:"",data:[:],data1:[:]]
    def searchCount(data) {
        def count=Orders.count(Orders.count)//总记录查询
        def count1=Orders.findOrSaveByActualAmount()  //总点数
        if (count){
            result.status=301
            result.message="查询错误"
            return result
        }
            result.message=""
            result.data=count
            result.data1=count1
            return result


    }
}
