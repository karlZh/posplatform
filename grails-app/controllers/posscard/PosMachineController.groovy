package posscard

import org.springframework.dao.DataIntegrityViolationException

class PosMachineController {

    static allowedMethods = [save: "POST", update: "POST"]
    def supplierType = [1:"电影",2:"蛋糕"]
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
        [posMachineInstanceList: PosMachine.list(params), posMachineInstanceTotal: PosMachine.count()]
    }

    def create() {
        [posMachineInstance: new PosMachine(params),supplierType:supplierType]
    }

    def save() {
        def posMachineInstance = new PosMachine(params)
        if (!posMachineInstance.save(flush: true)) {
            render(view: "create", model: [posMachineInstance: posMachineInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), posMachineInstance.id])
        redirect(action: "show", id: posMachineInstance.id)
    }

    def show(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
            return
        }

        [posMachineInstance: posMachineInstance]
    }

    def edit(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
            return
        }
        def supplierInstance = Supplier.get(posMachineInstance.supplier.id)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        [posMachineInstance: posMachineInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers]
    }

    def update(Long id, Long version) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (posMachineInstance.version > version) {
                posMachineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'posMachine.label', default: 'PosMachine')] as Object[],
                        "Another user has updated this PosMachine while you were editing")
                render(view: "edit", model: [posMachineInstance: posMachineInstance])
                return
            }
        }

        posMachineInstance.properties = params

        if (!posMachineInstance.save(flush: true)) {
            render(view: "edit", model: [posMachineInstance: posMachineInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), posMachineInstance.id])
        redirect(action: "show", id: posMachineInstance.id)
    }

    def delete(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
            return
        }

        try {
            posMachineInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "show", id: id)
        }
    }
}
