package posscard

import org.springframework.dao.DataIntegrityViolationException

class CardbinPlatformController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [cardbinPlatformInstanceList: CardbinPlatform.list(params), cardbinPlatformInstanceTotal: CardbinPlatform.count()]
    }

    def create() {
        [cardbinPlatformInstance: new CardbinPlatform(params)]
    }

    def save() {
        def cardbinPlatformInstance = new CardbinPlatform(params)
        cardbinPlatformInstance.createTime = new Date().getTime()
        if (!cardbinPlatformInstance.save(flush: true)) {
            render(view: "create", model: [cardbinPlatformInstance: cardbinPlatformInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), cardbinPlatformInstance.id])
        redirect(action: "show", id: cardbinPlatformInstance.id)
    }

    def show(Long id) {
        def cardbinPlatformInstance = CardbinPlatform.get(id)
        if (!cardbinPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "list")
            return
        }

        [cardbinPlatformInstance: cardbinPlatformInstance]
    }

    def edit(Long id) {
        def cardbinPlatformInstance = CardbinPlatform.get(id)
        if (!cardbinPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "list")
            return
        }

        [cardbinPlatformInstance: cardbinPlatformInstance]
    }

    def update(Long id, Long version) {
        def cardbinPlatformInstance = CardbinPlatform.get(id)
        if (!cardbinPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (cardbinPlatformInstance.version > version) {
                cardbinPlatformInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform')] as Object[],
                        "Another user has updated this CardbinPlatform while you were editing")
                render(view: "edit", model: [cardbinPlatformInstance: cardbinPlatformInstance])
                return
            }
        }

        cardbinPlatformInstance.properties = params

        if (!cardbinPlatformInstance.save(flush: true)) {
            render(view: "edit", model: [cardbinPlatformInstance: cardbinPlatformInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), cardbinPlatformInstance.id])
        redirect(action: "show", id: cardbinPlatformInstance.id)
    }

    def delete(Long id) {
        def cardbinPlatformInstance = CardbinPlatform.get(id)
        if (!cardbinPlatformInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "list")
            return
        }

        try {
            cardbinPlatformInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardbinPlatform.label', default: 'CardbinPlatform'), id])
            redirect(action: "show", id: id)
        }
    }
}
