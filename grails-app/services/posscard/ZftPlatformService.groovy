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

class ZftPlatformService {

    private static String APPID='10007'
    private static String APPSERCERT ='VAMvURUUd3gLZKLONSfw'
    private static String URL = 'http://pay.juyoufuli.cn:7001/v1/huaying/'

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
    def formatParams(Map params){
        Random ra =new Random()
        def nonce =ra.toString()
        def date =  new Date()
        def timestamp = String.valueOf(date.getTime())
        def Sign = posdes(APPID,APPSERCERT,timestamp,nonce)

        params.AppId = APPID
        params.Nonce = nonce
        params.Timestamp = timestamp
        params.Sign = Sign
        List <NameValuePair> sa
        sa = new ArrayList<NameValuePair>();
        for (Map.Entry<Integer, String> entry : params.entrySet()) {
                //Map.entry<Integer,String> 映射项（键-值对）  有几个方法：用上面的名字entry
                //entry.getKey() ;entry.getValue(); entry.setValue();
            //map.entrySet()  返回此映射中包含的映射关系的 Set视图。
            sa.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }
//        params.each {param->
//            sa.add(new BasicNameValuePair(param.key, param.value));
//        }

        return sa
    }
    def httpRequest(url,sa){
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
        return result
    }
    //卡号信息接口
    def cardinfo(String CardNo,String Extendinfo = ""){
        def sa = [:]
        sa.CardNo = CardNo
        if(Extendinfo)
            sa.Extendinfo = Extendinfo
        def data = formatParams(sa)
        def result = httpRequest(URL+"info",data)
        def rs
        rs = JSON.parse(result)
        return rs
    }
    //调用支付接口
    def cardpay(String CardNo, String Points, String PayOrderId, String Number = "", String Extendinfo = ""){
        def sa = [:]
        sa.CardNo = CardNo
        sa.Points = Points
        sa.PayOrderId = PayOrderId
        sa.Number = Number
        sa.Extendinfo = Extendinfo
        def data = formatParams(sa)
        def result = httpRequest(URL+"pay",data)
        def rs
        rs = JSON.parse(result)
        return rs
    }
    def rollBack(String CardNo, String TransId, String PayOrderId, String  Extendinfo = ""){
        def sa = [:]
        sa.CardNo = CardNo
        sa.TransId = TransId
        sa.PayOrderId = PayOrderId
        sa.Extendinfo = Extendinfo
        def data = formatParams(sa)
        def result = httpRequest(URL+"rollback",data)
        def rs
        rs = JSON.parse(result)
        return rs
    }
}
