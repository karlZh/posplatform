package posscard

import org.springframework.dao.DataIntegrityViolationException

class  OrdersController {
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

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)

        def result = Orders.findAllByIsdelete(0,[offset: params.offset,max: params.max ])
        def ordersInstanceTotal=Orders.countByIsdelete(0)
      render (view:'list' ,model:  [ordersInstanceList: result,ordersInstanceTotal: ordersInstanceTotal])
    }

    def search(Integer max){
        def name =params.name
        def result= Orders.findAllByOrderSnLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:max])

        def ordersInstanceTotal=Orders.countByOrderSnLikeAndIsdelete("%"+name+"%",0)

        render (view:'list' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }

    def create() {
        [ordersInstance: new Orders(params)]
    }
    def save() {
        def ordersInstance = new Orders(params)
        if (!ordersInstance.save(flush: true)) {
            render(view: "create", model: [ordersInstance: ordersInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'orders.label', default: 'Orders'), ordersInstance.id])
        redirect(action: "show", id: ordersInstance.id)
    }
    def show(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [ordersInstance: ordersInstance]
    }
    def edit(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        [ordersInstance: ordersInstance]
    }
    def update(Long id, Long version) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (ordersInstance.version > version) {
                ordersInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'orders.label', default: 'Orders')] as Object[],
                        "Another user has updated this Orders while you were editing")
                render(view: "edit", model: [ordersInstance: ordersInstance])
                return
            }
        }

        ordersInstance.properties = params

        if (!ordersInstance.save(flush: true)) {
            render(view: "edit", model: [ordersInstance: ordersInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'orders.label', default: 'Orders'), ordersInstance.id])
        redirect(action: "show", id: ordersInstance.id)
    }
    def delete(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
            return
        }

        try {
            ordersInstance.save(flush: true)
            ordersInstance.executeUpdate("update Orders u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "show", id: id)
        }
    }
    def platformList(Integer max){
        params.max = Math.min(max ?: 10, 100)
//        def result=User.findAllByAccountType(3,[offset:params.offset,max:max])
////        def result=User.list(params)
////        def userInstanceTotal=User.countByAccountType(3)
//        def userInstanceTotal=User.countByAccountType(3)
        def result=Orders.findAllByCardPlatformIdAndIsdelete(session.uTypeId,0,[offset:params.offset,max: params.max])

        def ordersInstanceTotal=Orders.countByCardPlatformIdAndIsdelete(session.uTypeId,0)

        render (view:'platformList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def platformShow(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "platformShow")
            return
        }

        [ordersInstance: ordersInstance]
    }
    def platformSearch(Integer max) {

        def orderSn=params.orderSn
        def result=Orders.findAllByOrderSnLikeAndCardPlatformIdAndIsdelete("%"+orderSn+"%",session.uTypeId,0,[offset:params.offset,max:max])

        def ordersInstanceTotal=Orders.countByOrderSnLikeAndCardPlatformIdAndIsdelete("%"+orderSn+"%",session.uTypeId,0)

        render (view:'platformList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def supplierformList(Integer max){

        params.max = Math.min(max ?: 10, 100)
        def result=Orders.findAllBySupplierIdAndIsdelete(session.uTypeId,0,[offset:params.offset,max:params.max])

        def ordersInstanceTotal=Orders.countBySupplierIdAndIsdelete(session.uTypeId,0)

        render (view:'supplierList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def supplierShow(Long id) {
        def ordersInstance = Orders.get(id)
        if (!ordersInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "supplierShow")
            return
        }

        [ordersInstance: ordersInstance]
    }
    def supplierSearch(Integer max){
        def name=params.name
        def result=Orders.findAllByOrderSnLikeAndSupplierIdAndIsdelete("%"+name+"%",session.uTypeId,0,[offset:params.offset,max:max])
        def ordersInstanceTotal=Orders.countByOrderSnLikeAndSupplierIdAndIsdelete("%"+name+"%",session.uTypeId,0)
        render (view:'supplierList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def supplierZList(Long id,Integer max){
        def result=Orders.findAllBySupplierIdLikeAndIsdelete(id,0,[offset:params.offset,max:max])
        def ordersInstanceTotal=Orders.countBySupplierIdLikeAndIsdelete(id,0)
        render (view:'supplierZList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal,id: id])
    }
    def supplierZSearch(Long id,Integer max){
        def name=params.name
        def result=Orders.findAllByOrderSnLikeAndSupplierIdAndIsdelete("%"+name+"%",id,0,[offset:params.offset,max:max])
        def ordersInstanceTotal=Orders.countByOrderSnLikeAndSupplierIdAndIsdelete("%"+name+"%",id,0)
        render (view:'supplierZList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal,id: id])
    }
}
