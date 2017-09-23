package posscard

import org.springframework.dao.DataIntegrityViolationException

class PosMachineController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def result =PosMachine.findAllByIsdelete(0,[offset:params.offset,max:params.max])
        def posMachineInstanceTotal=PosMachine.countByIsdelete(0)
        [posMachineInstanceList: result, posMachineInstanceTotal: posMachineInstanceTotal]
    }

    def search(Integer max){

        def name=params.name
        def result=PosMachine.findAllByNameAndIsdelete(name,0,[offset:params.offset,max:max])
        def posMachineInstanceTotal=PosMachine.countByNameAndIsdelete(name,0)

        render (view:'list' , model: [posMachineInstanceList: result, posMachineInstanceTotal:posMachineInstanceTotal])
    }

    def create() {
        [posMachineInstance: new PosMachine(params)]
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

        [posMachineInstance: posMachineInstance]
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
            posMachineInstance.save(flush: true)
            posMachineInstance.executeUpdate("update PosMachine u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "show", id: id)
        }
    }
}
