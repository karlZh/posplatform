package posscard

import org.springframework.dao.DataIntegrityViolationException

class TicketTypeController {

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
        def result =TicketType.findAllByIsdelete(0,[offset:params.offset,max:params.max])
        def ticketTypeInstanceTotal=TicketType.countByIsdelete(0)

        [ticketTypeInstanceList: result, ticketTypeInstanceTotal: ticketTypeInstanceTotal]
    }

    def search(Integer max){
        params.max = Math.min(max ?: 10, 100)
        def name=params.name
        def result=TicketType.findAllByNameLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:params.max])
        def ticketTypeInstanceTotal=TicketType.countByNameLikeAndIsdelete("%"+name+"%",0)

        render (view:'list' , model: [ticketTypeInstanceList: result, ticketTypeInstanceTotal:ticketTypeInstanceTotal])
    }

    def create() {
        [ticketTypeInstance: new TicketType(params),supplierType:supplierType]
    }

    def save() {
        def ticketTypeInstance = new TicketType(params)
        if (!ticketTypeInstance.save(flush: true)) {
            render(view: "create", model: [ticketTypeInstance: ticketTypeInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'ticketType.label', default: 'TicketType'), ticketTypeInstance.id])
        redirect(action: "show", id: ticketTypeInstance.id)
    }

    def show(Long id) {
        def ticketTypeInstance = TicketType.get(id)
        if (!ticketTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
            return
        }

        [ticketTypeInstance: ticketTypeInstance]
    }

    def edit(Long id) {
        def ticketTypeInstance = TicketType.get(id)
        if (!ticketTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
            return
        }
        def supplierInstance = Supplier.get(ticketTypeInstance.supplier.id)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        [ticketTypeInstance: ticketTypeInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers]
    }

    def update(Long id, Long version) {
        def ticketTypeInstance = TicketType.get(id)
        if (!ticketTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
            return
        }
        def supplierInstance = Supplier.get(ticketTypeInstance.supplier.id)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商

        if (version != null) {
            if (ticketTypeInstance.version > version) {
                ticketTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'ticketType.label', default: 'TicketType')] as Object[],
                          "Another user has updated this TicketType while you were editing")
                render(view: "edit", model: [ticketTypeInstance: ticketTypeInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
                return
            }
        }

        ticketTypeInstance.properties = params

        if (!ticketTypeInstance.save(flush: true)) {
            render(view: "edit", model: [ticketTypeInstance: ticketTypeInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'ticketType.label', default: 'TicketType'), ticketTypeInstance.id])
        redirect(action: "show", id: ticketTypeInstance.id)
    }

    def delete(Long id) {
        def ticketTypeInstance = TicketType.get(id)
        if (!ticketTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
            return
        }

        try {
            ticketTypeInstance.save(flush: true)

            ticketTypeInstance.executeUpdate("update TicketType u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "show", id: id)
        }
    }
}
