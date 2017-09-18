package posscard

import java.text.SimpleDateFormat

class BondService {
    def result=[status:200,message:"",data:[:]]
    def serviceMethod() {

        Calendar cale = null;
        cale = Calendar.getInstance();
        // 获取当月第一天和最后一天
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String firstday, lastday;
        // 获取前月的第一天
        cale = Calendar.getInstance();
        cale.add(Calendar.MONTH, 0);
        cale.set(Calendar.DAY_OF_MONTH, 1);
        firstday = format.format(cale.getTime());
        // 获取前月的最后一天
        cale = Calendar.getInstance();
        cale.add(Calendar.MONTH, 1);
        cale.set(Calendar.DAY_OF_MONTH, 0);
        lastday = format.format(cale.getTime());
       // System.out.println("本月第一天和最后一天分别是 ： " + firstday + " and " + lastday);
//
//        def book = Orders.listOrderByDateCreated()
//        book = Orders.findByDateCreatedBetween( firstday, lastday )
        def point=Orders.findByAmountAndDateCreatedBetween( firstday, lastday )
        if (point){
            result.status=301
            result.message="信息错误"
            return result
        }
        result.message=""
        result.data=point
        result result




    }
}
