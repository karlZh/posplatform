package posscard

class RecordController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
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
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [recordInstanceList:Record.list(params), recordInstanceTotal: Record.count]
    }
    def show(Long id) {
        def recordInstance = Record.get(id)
        if (!recordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "list")
            return
        }

        [recordInstance: recordInstance]
    }
}
