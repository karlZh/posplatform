package posscard

import org.springframework.dao.DataIntegrityViolationException

class CardPlatformController {

    static allowedMethods = [save: "POST", update: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {//[offset:params.offset,max:max])

        def result=CardPlatform.findAllByIsdelete(0,[offset:params.offset,max:max])
        def cardPlatformInstanceTotal=CardPlatform.countByIsdelete(0)
        [cardPlatformInstanceList:result, cardPlatformInstanceTotal:cardPlatformInstanceTotal]
    }

    def search(Integer max){

        def name=params.name
        def result=CardPlatform.findAllByNameLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:max])
        def cardPlatformInstanceTotal=CardPlatform.countByNameLikeAndIsdelete("%"+name+"%",0)

        render (view:'list' , model: [cardPlatformInstanceList: result, cardPlatformInstanceTotal:cardPlatformInstanceTotal])
    }

    def create() {
        [cardPlatformInstance: new CardPlatform(params)]
    }

    def save() {
        def cardPlatformInstance = new CardPlatform(params)
        if (!cardPlatformInstance.save(flush: true)) {
            render(view: "create", model: [cardPlatformInstance: cardPlatformInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), cardPlatformInstance.id])
        redirect(action: "show", id: cardPlatformInstance.id)
    }

    def show(Long id) {
        def cardPlatformInstance = CardPlatform.get(id)
        if (!cardPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
            return
        }

        [cardPlatformInstance: cardPlatformInstance]
    }

    def edit(Long id) {
        def cardPlatformInstance = CardPlatform.get(id)
        if (!cardPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
            return
        }

        [cardPlatformInstance: cardPlatformInstance]
    }

    def update(Long id, Long version) {
        def cardPlatformInstance = CardPlatform.get(id)
        if (!cardPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cardPlatformInstance.version > version) {
                cardPlatformInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'cardPlatform.label', default: 'CardPlatform')] as Object[],
                          "Another user has updated this CardPlatform while you were editing")
                render(view: "edit", model: [cardPlatformInstance: cardPlatformInstance])
                return
            }
        }

        cardPlatformInstance.properties = params

        if (!cardPlatformInstance.save(flush: true)) {
            render(view: "edit", model: [cardPlatformInstance: cardPlatformInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), cardPlatformInstance.id])
        redirect(action: "show", id: cardPlatformInstance.id)
    }

    def delete(Long id) {
        def cardPlatformInstance = CardPlatform.get(id)
        if (!cardPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
            return
        }

        try {
            cardPlatformInstance.save(flush: true)
            cardPlatformInstance.executeUpdate("update CardPlatform u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "show", id: id)
        }
    }
}
