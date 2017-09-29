package posscard

import org.springframework.web.context.request.RequestContextHolder

class UserlLeaderService {

    def signInL(data) {
        def result = [status: 200,message: "",data:[:]]
       def userLeader=User.findByIsLeaderAndUsernameAndPassword(data.isLeader,data.username,data.password)

        if(userLeader){
            if(userLeader.isLeader!="1"){
                result.status = 301
                result.message = "非pos主管，不可登陆"
                return result
            }
            def a = getSession().user
            getSession().userLeader = userLeader
            def uTypeInfo = getUTypeInfo(userLeader.accountType,userLeader.uTypeId)
             if (uTypeInfo.status != 200||!uTypeInfo.data.supplier.id){
                result.status = 301
                result.message = "未查该用户所属供应商，请联系客服！"
                return result
            }
            result.data.userid = userLeader.id
            result.data.supplierid = uTypeInfo.data.supplier.id
        }else{
            result.status = 301
            result.message = "用户不存在或密码错误！"
            return result
        }
       result.message = "签到成功！"
        return result
    }


    def signOutL() {
        def result = [status: 200,message: "",data:[:]]
        getSession().userLeader = null
        result.message = "签出成功！"
        return result
    }

    def checkSignL(){
        def result = [status: 200,message: "",data:[:]]

        if(!getSession().userLeader){
            result.status = 301
            result.message = "未登录请重新登陆！"
            return result
        }
        result.message = "登陆状态！"
        return result
    }

    def getUTypeInfo(Integer accountType,Long utypeId){
        def result = [status: 200,message: "",data:[:]]
        def uTypeInfo
        switch (accountType){
            case 1://pos机
                uTypeInfo = PosMachine.get(utypeId)
                break
            case 2://聚优后台管理员
                uTypeInfo = [:]
                break
            case 3://商户后台管理员
                uTypeInfo = CardPlatform.get(utypeId)
                break
            case 4:
                uTypeInfo = Supplier.get(utypeId)
                break
        }
        if(!uTypeInfo){
            result.status = 301
            result.message = "未查询到内容"
            return result
        }
        result.data = uTypeInfo
        return result
    }
    //Getting the Session object
    def getSession(){
        return RequestContextHolder.currentRequestAttributes().getSessionMutex()
    }
}
