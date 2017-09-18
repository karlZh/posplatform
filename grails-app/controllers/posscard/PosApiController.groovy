package posscard

import grails.converters.JSON
import org.apache.commons.codec.digest.DigestUtils
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.ClientProtocolException
import org.apache.http.client.entity.UrlEncodedFormEntity
import org.apache.http.client.methods.HttpPost
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.message.BasicNameValuePair
import org.apache.http.protocol.HTTP
import org.apache.http.util.EntityUtils
import org.omg.CORBA.NameValuePair

class PosApiController {
    def userService
    def dataProcessingService
    def ordersService
    def groupQueryService
    def refundService
    def lastOrderService
    def index() {
//        def a = 'asdf'
//        def b = DESUtil.encode(poskey,a)
//        render(b)
//        return false
//        def posStr = params.pos?.trim()
//        if(!posStr){
//            jsonMap.status = 1
//            jsonMap.message = "no params"
//            render dataEcrypt(jsonMap)
//            return false
//        }
//        def posParams = dataDecrypt(posStr)
//        if(!posParams.pro||posParams.pro.trim() != 'posPlatform'){
//            jsonMap.status = 1
//            jsonMap.message = "无效项目名称"
//            render dataEcrypt(jsonMap)
//            return false
//        }
//        if(!posParams.ins||posParams.ins?.trim() != 'posSystem'){
//            jsonMap.status = 1
//            jsonMap.message = "无效指令"
//            render dataEcrypt(jsonMap)
//            return false
//        }
////        switch (posParams.act?.trim()) {
//        def data
//        render params.username
//        return false
        def data = [:]
        data = params
        def result = [:]
        switch (params.act?.trim()) {
            case "signIn":
                result = userService.signIn(data);
                break
            case "search"://通过流水号查询
                result = ordersService.orderSearch(data)
            case "searchCount"://查询总记录
                result=groupQueryService.searchCount(data)

             case "orderRefund":
                 result= refundService.orderRefund(data)
             case "last":
                 result=lastOrderService.last(data)
                break;
            case "refund":
                result = ordersService.orderRefund(data)
            default:
                result.status = false
                result.message = "未知错误"
        }

        render dataProcessingService.dataEncode(result)
        return false
    }
    def list(){
        def data = dataProcessingService.dataDecode(params.pos)
        render data.message
    }
//    des加密
    def posdes(String appId,String appSercert,String timestamp,String nonce){
        def list=[appId,appSercert,timestamp,nonce]
        list.sort()
        StringBuffer buffer = new StringBuffer()
        for (int i=0;i<4;i++){
            buffer.append(list[i])
        }
        def result = buffer.toString()
        return  DigestUtils.shaHex(result)

    }
    //调用支付接口
    def cardinfo(String CardNo,String CardPwd,String Extendinfo){
        def appId='10007'
        def appSercert ='VAMvURUUd3gLZKLONSfw'
        Random ra =new Random()
        def nonce =ra.toString()
        def date =  new Date()
        def timestamp=    String.valueOf(date.getTime())
        def Sign = posdes(appId,appSercert,timestamp,nonce)
        def url = 'http://pay.juyoufuli.cn:7001/v1/card/info'
        List <NameValuePair> sa
        sa = new ArrayList<NameValuePair>();
        sa.add(new BasicNameValuePair("AppId", appId));
        sa.add(new BasicNameValuePair("Nonce", nonce));
        sa.add(new BasicNameValuePair("Timestamp", timestamp));
        sa.add(new BasicNameValuePair("Sign", Sign));
        sa.add(new BasicNameValuePair("CardNo", CardNo));
        sa.add(new BasicNameValuePair("CardPwd", CardPwd));
        HttpPost httpRequst = new HttpPost(url);//创建HttpPost对象
        def result
        try {
            httpRequst.setEntity(new UrlEncodedFormEntity(sa,HTTP.UTF_8));
            HttpResponse httpResponse = new DefaultHttpClient().execute(httpRequst);
            if(httpResponse.getStatusLine().getStatusCode() == 200)
            {
                HttpEntity httpEntity = httpResponse.getEntity();
                result = EntityUtils.toString(httpEntity);//取出应答字符串

            }
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            result = e.getMessage().toString();
        }
        catch (ClientProtocolException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            result = e.getMessage().toString();
        }
        catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            result = e.getMessage().toString();
        }
        def rs
        rs = JSON.parse(result)
        return rs
    }
    def possCardInfo(CardNo,CardPwd,cxtendinfo){
        def rs=cardinfo(CardNo,CardPwd,cxtendinfo)
        print(rs.data.SellingCompany)
        if (params.callback) {
            render "${params.callback}(${rs as JSON})"
        } else
            render rs as JSON
    }
}
