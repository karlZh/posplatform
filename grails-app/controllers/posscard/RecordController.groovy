package posscard

class RecordController {
    def auth(){
        if(!session.userId){
            def originReqParams = [controller:controllerName,action: actionName]
            originReqParams.putAll(params)
            session.originReqParams = originReqParams
            redirect(controller:"userLogin",action: "login")
            return false
        }
    }

    def beforeInterceptor = [action: this.&auth]
    def index() {}
    def record(Integer userId){
        def a = session.accountType
        def result= params.userId
       // [userInstanceList: User.list(params), userInstanceTotal: User.count()]
        render (view:'list' , model: [recordInstanceList: result, recordInstanceTotal:User.listOrderByUTypeId()])


    }
}
