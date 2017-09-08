package posscard

import java.text.SimpleDateFormat
import java.util.Date


class CardBinController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cardBinInstanceList: CardBin.list(params), cardBinInstanceTotal: CardBin.count()]
    }

    def create() {
        [cardBinInstance: new CardBin(params)]

    }

    def save() {
        def cardBinInstance = new CardBin(params)

        cardBinInstance.createTime?.format(form("yyyy-MM-dd HH:mm:ss"))

      //  cardBinInstance.createTime=new Date().getTime()

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
            cardBinInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "list")
        }
        catch (Exception e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "show", id: id)
        }
    }
}
