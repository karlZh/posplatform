package posscard

import org.springframework.dao.DataIntegrityViolationException

class CardBinController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
       def result=CardBin.findAllByIsdelete(0,[offset:params.offset,max:max])
        def cardBinInstanceTotal=CardBin.countByIsdelete(0)
        [cardBinInstanceList: result, cardBinInstanceTotal:cardBinInstanceTotal]
    }

    def search(Integer max){

        def name=params.name
        //def result1=CardBin.findAllByCardbinAndIsdelete(name,0,[offset:params.offset,max:max])
        def result =CardBin.findAllByCardbinLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:max])
        def cardBinInstanceTotal=CardBin.countByCardbinLikeAndIsdelete("%"+name+"%",0)

        render (view:'list' , model: [cardBinInstanceList: result, cardBinInstanceTotal:cardBinInstanceTotal])
    }

    def create() {
        [cardBinInstance: new CardBin(params)]
    }

    def save() {
        def cardBinInstance = new CardBin(params)
        if (!cardBinInstance.save(flush: true)) {
            render(view: "create", model: [cardBinInstance: cardBinInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cardBin.label', default: 'CardBin'), cardBinInstance.id])
        redirect(action: "show", id: cardBinInstance.id)
    }

    def show(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
            return
        }

        [cardBinInstance: cardBinInstance]
    }

    def edit(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
            return
        }

        [cardBinInstance: cardBinInstance]
    }

    def update(Long id, Long version) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cardBinInstance.version > version) {
                cardBinInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cardBin.label', default: 'CardBin')] as Object[],
                          "Another user has updated this CardBin while you were editing")
                render(view: "edit", model: [cardBinInstance: cardBinInstance])
                return
            }
        }

        cardBinInstance.properties = params

        if (!cardBinInstance.save(flush: true)) {
            render(view: "edit", model: [cardBinInstance: cardBinInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cardBin.label', default: 'CardBin'), cardBinInstance.id])
        redirect(action: "show", id: cardBinInstance.id)
    }

    def delete(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
            return
        }

        try {
            cardBinInstance.save(flush: true)
            cardBinInstance.executeUpdate("update CardBin u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "show", id: id)
        }
    }
}
