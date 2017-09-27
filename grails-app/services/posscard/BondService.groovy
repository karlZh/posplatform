package posscard

import org.springframework.web.context.request.RequestContextHolder

import java.text.SimpleDateFormat

class BondService {
    def settle() {
         def result=[status:200,message:"",data:[:]]
        Calendar cale = null;
        cale = Calendar.getInstance();
        // 获取当月第一天和最后一天
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String firstday, lastday;
        // 获取前月的第一天
        cale = Calendar.getInstance();
        cale.add(Calendar.MONTH, 0);
        cale.set(Calendar.DAY_OF_MONTH, 1);
//        firstday = format.format(cale.getTime());
        firstday = cale.getTime()
        // 获取前月的最后一天
//        cale = Calendar.getInstance();
//        cale.add(Calendar.MONTH, 1);
//        cale.set(Calendar.DAY_OF_MONTH, 0);
//        lastday = format.format(cale.getTime());
        def user_id = getSession().user.id
        def orderList= Orders.findAllByUserIdAndOrderStatusAndDateCreatedGreaterThan(user_id,1 ,firstday)
        if (!orderList){
            result.status=301
//            result.data=[totalCount:0,totalAmount:0]
            result.message="暂没有要打印的数据"
            return result
        }
        result.message=""
        result.data=[totalCount:orderList.num.sum(),totalAmount:orderList.amount.sum()]
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
