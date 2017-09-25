package posscard

import org.springframework.dao.DataIntegrityViolationException

class RecordController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [recordInstanceList: Record.list(params), recordInstanceTotal: Record.count()]
    }

    def create() {
        [recordInstance: new Record(params)]
    }
    def search(Integer max){

        def name=params.name
        def result=Record.findAllByUserLike("%"+name+"%",[offset:params.offset,max:max])
        def recordInstanceTotal=Record.countByUserLike("%"+name+"%")

        render (view:'list' , model: [recordInstanceList: result, recordInstanceTotal:recordInstanceTotal])
    }


    def save() {
        def recordInstance = new Record(params)
        if (!recordInstance.save(flush: true)) {
            render(view: "create", model: [recordInstance: recordInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'record.label', default: 'Record'), recordInstance.id])
        redirect(action: "show", id: recordInstance.id)
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

    def edit(Long id) {
        def recordInstance = Record.get(id)
        if (!recordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "list")
            return
        }

        [recordInstance: recordInstance]
    }

    def update(Long id, Long version) {
        def recordInstance = Record.get(id)
        if (!recordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (recordInstance.version > version) {
                recordInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'record.label', default: 'Record')] as Object[],
                          "Another user has updated this Record while you were editing")
                render(view: "edit", model: [recordInstance: recordInstance])
                return
            }
        }

        recordInstance.properties = params

        if (!recordInstance.save(flush: true)) {
            render(view: "edit", model: [recordInstance: recordInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'record.label', default: 'Record'), recordInstance.id])
        redirect(action: "show", id: recordInstance.id)
    }

    def delete(Long id) {
        def recordInstance = Record.get(id)
        if (!recordInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "list")
            return
        }

        try {
            recordInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'record.label', default: 'Record'), id])
            redirect(action: "show", id: id)
        }
    }
}
