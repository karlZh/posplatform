package posscard

import org.springframework.dao.DataIntegrityViolationException

class TicketTypeController {

    static allowedMethods = [save: "POST", update: "POST"]

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
        def result=TicketType.findAllByNameAndIsdelete(name,0,[offset:params.offset,max:params.max])
        def ticketTypeInstanceTotal=TicketType.countByName(name,0)

        render (view:'list' , model: [ticketTypeInstanceList: result, ticketTypeInstanceTotal:ticketTypeInstanceTotal])
    }

    def create() {
        [ticketTypeInstance: new TicketType(params)]
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

        [ticketTypeInstance: ticketTypeInstance]
    }

    def update(Long id, Long version) {
        def ticketTypeInstance = TicketType.get(id)
        if (!ticketTypeInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'ticketType.label', default: 'TicketType'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (ticketTypeInstance.version > version) {
                ticketTypeInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'ticketType.label', default: 'TicketType')] as Object[],
                          "Another user has updated this TicketType while you were editing")
                render(view: "edit", model: [ticketTypeInstance: ticketTypeInstance])
                return
            }
        }

        ticketTypeInstance.properties = params

        if (!ticketTypeInstance.save(flush: true)) {
            render(view: "edit", model: [ticketTypeInstance: ticketTypeInstance])
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
