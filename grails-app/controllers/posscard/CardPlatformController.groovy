package posscard

import org.springframework.dao.DataIntegrityViolationException

class CardPlatformController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cardPlatformInstanceList: CardPlatform.list(params), cardPlatformInstanceTotal: CardPlatform.count()]
    }

    def create() {
        [cardPlatformInstance: new CardPlatform(params)]
    }

    def save() {
        def cardPlatformInstance = new CardPlatform(params)
        cardPlatformInstance.createTime = new Date().getTime()
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
            cardPlatformInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardPlatform.label', default: 'CardPlatform'), id])
            redirect(action: "show", id: id)
        }
    }
}
