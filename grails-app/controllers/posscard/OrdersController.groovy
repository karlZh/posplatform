package posscard

import org.springframework.dao.DataIntegrityViolationException

class OrdersController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [ordersInstanceList: Orders.list(params), ordersInstanceTotal: Orders.count()]
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
}
