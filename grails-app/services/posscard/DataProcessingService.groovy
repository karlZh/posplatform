package posscard

import grails.converters.JSON

class DataProcessingService {
    def poskey = "posplatformsystem"

    def formatResult(data){
        def jsonMap = [status:0,message:"",data:[:]]
        if(data.status == 200){
            jsonMap.message = data.message
            jsonMap.data = data.data
        }else{
            jsonMap.status = 1
            jsonMap.message = data.message
            jsonMap.data = data.data
        }
        return jsonMap
    }
    //返回数据加密
    def dataEncode(data) {
        def dataStr = new JSON(formatResult(data))
        return dataStr
//        return DESUtil.encode(poskey,dataStr.toString())
    }

    //接收数据解密
    def dataDecode(dataStr) {
        def dataJson = DESUtil.decode(poskey,dataStr)
        return JSON.parse(dataJson)
    }
}
