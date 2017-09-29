package posscard

import org.springframework.dao.DataIntegrityViolationException

class UserController {

    static allowedMethods = [save: "POST", update: "POST"]
    def isLeader = [1:"主管",0:"非主管"]
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
        def result =User.findAllByIsdelete(0,[offset:params.offset,max:max])
        def userInstanceTotal=User.countByIsdelete(0)
        [userInstanceList: result, userInstanceTotal: userInstanceTotal,isLeader:isLeader]
    }
    def search(Integer max){

        def name=params.name
        def result=User.findAllByUsernameLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:max])
        def userInstanceTotal=User.countByUsernameLikeAndIsdelete("%"+name+"%",0)

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
            userInstance.save(flush: true)
            userInstance.executeUpdate("update User u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
    def posList(Integer max){

        def result=User.findAllByAccountTypeAndIsdelete(1,0,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountTypeAndIsdelete(1,0)

        [userInstanceList: result, userInstanceTotal:userInstanceTotal,isLeader:isLeader]
    }
    def posCreate(){
        [userInstance: new User(params),accountType:1,isLeader:isLeader]
    }
    def posSave() {
        def userInstance = new User(params)

        if(!(params.username =~'^[0-9]{1}[1-9]{1}$')){
            flash.message = message(code: 'user.posname.invalid.max.size.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "posCreate", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
            return
        }
        def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountTypeAndIsLeader(params.username,params.password,params.uTypeId,params.accountType,params.isLeader)
        if(userInfo){
            flash.message = message(code: 'user.posname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "posCreate", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
            return
        }
        userInstance.accountType=1

        if (!userInstance.save(flush: true)) {
            render(view: "posCreate", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
      //  redirect(action: "posShow", id: userInstance.id)
        render (view:"posShow",model:[userInstance: userInstance,accountType:1,isLeader:isLeader])
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
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
            return
        }

        [userInstance: userInstance,accountType:1,isLeader:isLeader]
//        render (view:'posEdit' , model:)
    }
    def posUpdate(Long id, Long version) {
        def userInstance = User.get(id)
        if(!(params.username =~'^[0-9]{1}[1-9]{1}$')){
            flash.message = message(code: 'user.posname.invalid.max.size.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "posEdit", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
            return
        }
        if(params.username!=userInstance.username){
            def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)

            if(userInfo){
                flash.message = message(code: 'user.posname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                render(view: "posEdit", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
                return
            }
        }

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
                render(view: "posEdit", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "posEdit", model: [userInstance: userInstance,accountType:1,isLeader:isLeader])
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
            userInstance.save(flush: true)

            userInstance.executeUpdate("update User u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "posShow", id: id)
        }
    }
    def posSearch(Integer max){

        def name=params.name
        def result=User.findAllByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",1,0,[offset: params.offset,max: max])
        def userInstanceTotal=User.countByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",1,0)

        render (view:'posList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
def platformList(Integer max){
//        params.max = Math.min(max ?: 10, 100)
//        params.accountType = 3
        def result=User.findAllByAccountTypeAndIsdelete(3,0,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountTypeAndIsdelete(3,0)

       [userInstanceList: result, userInstanceTotal:userInstanceTotal]
    }
def platformCreate(){

    def  category =CardPlatform.findAll()
    [userInstance: new User(params),category: category,accountType:3]
}
def platformSave() {
    def userInstance = new User(params)
    def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)
    if(userInfo){
        flash.message = message(code: 'user.platformname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        render(view: "platformCreate", model: [userInstance: userInstance,accountType:3])
        return
    }
    userInstance.accountType=3
    if (!userInstance.save(flush: true)) {
        render(view: "platformCreate", model: [userInstance: userInstance,accountType:3])
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
    if (!userInstance) {
        flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
        redirect(action: "platformList")
        return
    }

    [userInstance: userInstance,accountType:3]
//        render (view:'posEdit' , model:)
}
def platformUpdate(Long id, Long version) {
    def userInstance = User.get(id)
    if(params.username!=userInstance.username){
        def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)

        if(userInfo){
            flash.message = message(code: 'user.platformname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "posEdit", model: [userInstance: userInstance,accountType:1])
            return
        }
    }
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
            render(view: "platformEdit", model: [userInstance: userInstance,accountType:3])
            return
        }
    }

    userInstance.properties = params

    if (!userInstance.save(flush: true)) {
        render(view: "platformEdit", model: [userInstance: userInstance,accountType:3])
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
            userInstance.save(flush: true)

            userInstance.executeUpdate("update User u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformShow", id: id)
        }
    }
def platformSearch(Integer max){

        def name=params.name
        def result=User.findAllByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",3,0,[offset: params.offset,max: max])
        def userInstanceTotal=User.countByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",3,0)

        render (view:'platformList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }
    def supplierList(Integer max){

//        def name=params.name
//        def result=User.findAllByAccountType(4)
//        def userInstanceTotal=User.countByUsername(name)
//
//        render (view:'supplierList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
        def result=User.findAllByAccountTypeAndIsdelete(4,0,[offset:params.offset,max:max])
//        def result=User.list(params)
//        def userInstanceTotal=User.countByAccountType(3)
        def userInstanceTotal=User.countByAccountTypeAndIsdelete(4,0)

        [userInstanceList: result, userInstanceTotal:userInstanceTotal]
    }
    def supplierCreate(){
        [userInstance: new User(params),accountType:4,supplierType:supplierType]
    }
    def supplierSave() {
        def userInstance = new User(params)
        if(!params.uTypeId.toInteger()){
            flash.message = message(code: 'user.uTypeId.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "supplierCreate", model: [userInstance: userInstance,accountType:4,supplierType:supplierType])
            return
        }

        def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)
        if(userInfo){
            flash.message = message(code: 'user.suppliername.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "supplierCreate", model: [userInstance: userInstance,accountType:4,supplierType:supplierType])
            return
        }
        userInstance.accountType=4
        if (!userInstance.save(flush: true)) {
            render(view: "supplierCreate", model: [userInstance: userInstance,accountType:4,supplierType:supplierType])
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
        if(params.username!=userInstance.username){
            def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)

            if(userInfo){
                flash.message = message(code: 'user.suppliername.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                render(view: "supplierEdit", model: [userInstance: userInstance,accountType:4,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
                return
            }
        }
        def supplierInstance = Supplier.get(userInstance.uTypeId)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        if(!params.uTypeId){
            flash.message = message(code: 'user.uTypeId.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "supplierEdit", model: [userInstance: userInstance,accountType:4,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
            return
        }
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
                render(view: "supplierEdit", model: [userInstance: userInstance,accountType:4,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "supplierEdit", model: [userInstance: userInstance,accountType:4,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "supplierShow", id: userInstance.id)
    }
    def supplierDelete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }

        try {
            userInstance.save(flush: true)

           userInstance.executeUpdate("update User u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
        }
        catch (DataIntegrityViolationException e) {
           flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierShow", id: id)
        }
    }
    def supplierSearch(Integer max){

        def name=params.name
        def result=User.findAllByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",4,0,[offset: params.offset,max: max])
        def userInstanceTotal=User.countByUsernameLikeAndAccountTypeAndIsdelete("%"+name+"%",4,0)

        render (view:'supplierList' , model: [userInstanceList: result, userInstanceTotal:userInstanceTotal])
    }

}
