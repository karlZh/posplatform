package posscard

import org.springframework.dao.DataIntegrityViolationException

class UserController {

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
        redirect(controller: "record", action: "list", params: params)
    }
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }
    def search(){

        def name=params.name
        def result=User.findAllByUsername(name)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'list' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
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
    def posList(Integer max){

        def result=User.findAllByAccountType(1,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountType(1)

        [userInstanceList: result, userInstanceTotal:userInstanceTotal]
    }
    def posCreate(){
        def  category = PosMachine.findAll()
        [userInstance: new User(params),category: category,accountType:1]
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
    def posShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }

        [userInstance: userInstance]
    }
    def posEdit(Long id) {
        def userInstance = User.get(id)
        def category = PosMachine.findAll()
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }

        [userInstance: userInstance,category:category,accountType:1]
//        render (view:'posEdit' , model:)
    }
    def posUpdate(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }


        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "posEdit1", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            def  category =CardPlatform.findAll()

            render(view: "posEdit", model: [userInstance: userInstance,category:category])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "posShow", id: userInstance.id)
    }
    def posDelete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posShow", id: id)
        }
    }
    def posSearch(){

        def name=params.name
        def result=User.findAllByUsernameAndAccountType(name,1)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'posList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
def platformList(Integer max){
//        params.max = Math.min(max ?: 10, 100)
//        params.accountType = 3
        def result=User.findAllByAccountType(3,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountType(3)

       [userInstanceList: result, userInstanceTotal:userInstanceTotal]
    }
def platformCreate(){
    def  category =CardPlatform.findAll()
    [userInstance: new User(params),category: category,accountType:3]
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
def platformShow(Long id) {
    def userInstance = User.get(id)
    if (!userInstance) {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
        redirect(action: "platformList")
        return
    }

    [userInstance: userInstance]
}
def platformEdit(Long id) {
    def userInstance = User.get(id)
    def  category =CardPlatform.findAll()
    if (!userInstance) {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
        redirect(action: "platformList")
        return
    }

    [userInstance: userInstance,category:category,accountType:3]
//        render (view:'posEdit' , model:)
}
def platformUpdate(Long id, Long version) {
    def userInstance = User.get(id)
    if (!userInstance) {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
        redirect(action: "platformList")
        return
    }


    if (version != null) {
        if (userInstance.version > version) {
            userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                    [message(code: 'user.label', default: 'User')] as Object[],
                    "Another user has updated this User while you were editing")
            render(view: "platformEdit", model: [userInstance: userInstance])
            return
        }
    }

    userInstance.properties = params

    if (!userInstance.save(flush: true)) {
        def  category =CardPlatform.findAll()
        render(view: "platformEdit", model: [userInstance: userInstance,category:category])
        return
    }

    flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
    redirect(action: "platformShow", id: userInstance.id)
}
def platformDelete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformShow", id: id)
        }
    }
def platformSearch(){

        def name=params.name
        def result=User.findAllByUsernameAndAccountType(name,3)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'platformList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
    def supplierList(Integer max){

//        def name=params.name
//        def result=User.findAllByAccountType(4)
//        def userInstanceTotal=User.countByUsername(name)
//
//        render (view:'supplierList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
        def result=User.findAllByAccountType(4,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountType(4)

        [userInstanceList: result, userInstanceTotal:userInstanceTotal]
    }
    def supplierCreate(){
        def  category =Supplier.findAll()
        [userInstance: new User(params),category: category,accountType:4,supplierType:supplierType]
    }
    def supplierSave() {
        def userInstance = new User(params)
        userInstance.accountType=4
        if (!userInstance.save(flush: true)) {
            def  category = Supplier.findAll()
            render(view: "platformCreate", model: [userInstance: userInstance,category: category])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "supplierShow", id: userInstance.id)
    }
    def supplierShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }

        [userInstance: userInstance]
    }
    def supplierEdit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }
        def supplierInstance = Supplier.get(userInstance.uTypeId)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        [userInstance: userInstance,accountType:4,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers]

//        render (view:'posEdit' , model:)
    }
    def supplierUpdate(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }


        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "platformEdit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            def  category =CardPlatform.findAll()
            render(view: "platformEdit", model: [userInstance: userInstance,category:category])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "platformShow", id: userInstance.id)
    }
    def supplierDelete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }

        try {
            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformShow", id: id)
        }
    }
    def supplierSearch(){

        def name=params.name
        def result=User.findAllByUsernameAndAccountType(name,4)
        def userInstanceTotal=User.countByUsername(name)

        render (view:'supplierList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
}
