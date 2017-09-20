package posscard

import org.springframework.dao.DataIntegrityViolationException

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }
    def posList(){

        def name=params.name
        def result=User.findAllByAccountType(1)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'posList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
    def platformList(){

        def name=params.name
        def result=User.findAllByAccountType(3)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'platformList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
    def search(){

        def name=params.name
        def result=User.findAllByUsername(name)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'list' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
    def posCreate(){
        def  category = PosMachine.findAll()
        [userInstance: new User(params),category: category,accountType:1]
    }
    def platformCreate(){
        def  category = PosMachine.findAll()
        [userInstance: new User(params),category: category,accountType:3]
    }
    def posSave() {
        def userInstance = new User(params)
        userInstance.accountType=1
        if (!userInstance.save(flush: true)) {
            def  category = PosMachine.findAll()
            render(view: "posCreate", model: [userInstance: userInstance,category: category])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "posShow", id: userInstance.id)
    }
    def platformSave() {
        def userInstance = new User(params)
        userInstance.accountType=3
        if (!userInstance.save(flush: true)) {
            def  category = PosMachine.findAll()
            render(view: "platformCreate", model: [userInstance: userInstance,category: category])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "platformShow", id: userInstance.id)
    }
    def posShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }

        [userInstance: userInstance]
    }
    def platformShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
            return
        }

        [userInstance: userInstance]
    }
    def posEdit(Long id) {
        def userInstance = User.get(id)
        def category = PosMachine.findAll()
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posEdit")
            return
        }

        [userInstance: userInstance,category:category,accountType:1]
//        render (view:'posEdit' , model:)
    }
    def platformEdit(Long id) {
        def userInstance = User.get(id)
        def category = PosMachine.findAll()
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformEdit")
            return
        }

        [userInstance: userInstance,category:category,accountType:3]
//        render (view:'posEdit' , model:)
    }
    def create() {
        def category
        switch (params.accountType){
            case '1':
                category = PosMachine.findAll()
                break
            case '2':
                category = [:]
                break
            case '3':
                category = CardPlatform.findAll()
                break
            case '4':
                category = Supplier.findAll()
                break
        }
        [userInstance: new User(params),category: category]
    }

    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.get(id)
        def category
        switch (params.accountType){
            case '1':
                category = PosMachine.findAll()
                break
            case '2':
                category = [:]
                break
            case '3':
                category = CardPlatform.findAll()
                break
            case '4':
                category = Supplier.findAll()
                break
        }
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance,category:category]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
}
