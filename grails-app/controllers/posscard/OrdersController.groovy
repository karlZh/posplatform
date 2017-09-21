package posscard

import org.springframework.dao.DataIntegrityViolationException

class OrdersController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [ordersInstanceList: Orders.list(params), ordersInstanceTotal: Orders.count()]
    }

    def search(){

        def orderSn=params.orderSn
        def result=Orders.findAllByOrderSn(orderSn)

        def ordersInstanceTotal=Orders.countByOrderSn(orderSn)

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
            ordersInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'orders.label', default: 'Orders'), id])
            redirect(action: "show", id: id)
        }
    }
    def platformList(){


        def result=Orders.findAllByCardPlatformId(session.uTypeId)

        def ordersInstanceTotal=Orders.countByCardPlatformId(session.uTypeId)

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
    def platformSearch(){

        def orderSn=params.orderSn
        def result=Orders.findByOrderSnAndCardPlatformId(orderSn,session.uTypeId)

        def ordersInstanceTotal=Orders.countByOrderSnAndCardPlatformId(orderSn,session.uTypeId)

        render (view:'platformList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def supplierformList(){


        def result=Orders.findBySupplierId(session.uTypeId)

        def ordersInstanceTotal=Orders.countBySupplierId(session.uTypeId)

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
    def supplierfSearch(){
        def orderSn=params.orderSn
        def result=Orders.findByOrderSnAndSupplierId(orderSn,session.uTypeId)
        def ordersInstanceTotal=Orders.countByOrderSnAndSupplierId(orderSn,session.uTypeId)
        render (view:'supplierList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
    def supplierSearch(){
        def orderSn=params.orderSn
        def result=Orders.findByOrderSnAndSupplierId(orderSn,session.uTypeId)
        def ordersInstanceTotal=Orders.countByOrderSnAndSupplierId(orderSn,session.uTypeId)
        render (view:'supplierList' , model: [ordersInstanceList: result, ordersInstanceTotal:ordersInstanceTotal])
    }
}
