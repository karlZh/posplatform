package posscard

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class SupplierController {


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
        redirect(action: "list", params: params)
    }
    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def result = Supplier.findAllByIsdelete(0,[offset:params.offset,max: params.max])
        def supplierInstanceTotal=Supplier.countByIsdelete(0)
        [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal]
    }

    def supCardBinEdit(Long id){
        def supplierInstance = Supplier.get(id)
        def a = CardBin.list()
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
            return
        }
        [supplierInstance: supplierInstance]
    }
    def supCardBinUpdate(Long id){
        def c = params
        def supplierInstance = Supplier.get(id)
        for(em in params.cardbins){
            supplierInstance.addToCardbins()
        }
        supplierInstance.save(flush: true)
        def a=1
        def b=1
    }

    def search(){


        def name=params.name
        def result=Supplier.findAllByNameLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max: params.max])
        def supplierInstanceTotal=Supplier.countByNameLikeAndIsdelete("%"+name+"%",0)

        render (view:'list' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
    }
    def create() {
        [supplierInstance: new Supplier(params),supplierType:supplierType]
    }
    def ajaxSearchSupplier(){
        def result = [status:0,message:'',data:[:]]
        def parentId = params.parentId?params.parentId:0
        def parents = Supplier.findAllByParentIdAndType(parentId,params.type)
        if(!parents){
            result.status = 1
            result.message = "未找到父供应商"
            render result as JSON
            return
        }
        result.data = parents
        render result as JSON
        return
    }
    def save() {
        def supplierInstance = new Supplier(params)
        if (!supplierInstance.save(flush: true)) {
            render(view: "create", model: [supplierInstance: supplierInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "show", id: supplierInstance.id)
    }
    def show(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
            return
        }

        [supplierInstance: supplierInstance]
    }
    def edit(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
            return
        }

        [supplierInstance: supplierInstance,supplierType: supplierType]
    }
    def update(Long id, Long version) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (supplierInstance.version > version) {
                supplierInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'supplier.label', default: 'Supplier')] as Object[],
                          "Another user has updated this Supplier while you were editing")
                render(view: "edit", model: [supplierInstance: supplierInstance,supplierType: supplierType])
                return
            }
        }

        supplierInstance.properties = params

        if (!supplierInstance.save(flush: true)) {
            render(view: "edit", model: [supplierInstance: supplierInstance,supplierType: supplierType])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "show", id: supplierInstance.id)
    }
    def delete(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
            return
        }

        try {
            supplierInstance.save(flush: true)
            supplierInstance.executeUpdate("update Supplier u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "show", id: id)
        }
    }
    def fList(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def result=Supplier.findAllByParentIdAndIsdelete(0,0,[offset:params.offset,max:params.max])
        def supplierInstanceTotal=Supplier.countByParentIdAndIsdelete(0,0)
        render (view:'fList' , model:  [supplierInstanceList: result, supplierInstanceTotal: supplierInstanceTotal])
    }
    def fSearch(Integer max){

        def name=params.name
        def result=Supplier.findAllByNameLikeAndParentIdAndIsdelete("%"+name+"%",0,0,[offset:params.offset,max:max])
        def supplierInstanceTotal=Supplier.countByNameLikeAndParentIdAndIsdelete("%"+name+"%",0,0)

        render (view:'fList' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
    }
    def fCreate() {

        [supplierInstance: new Supplier(params),supplierType:supplierType]
    }
    def fSave() {
        def supplierInstance = new Supplier(params)
        if (!supplierInstance.save(flush: true)) {
            render(view: "fCreate", model: [supplierInstance: supplierInstance,supplierType: supplierType])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "fShow", id: supplierInstance.id)
    }
    def fShow(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
            return
        }

        [supplierInstance: supplierInstance,supplierType:supplierType]
    }
    def fEdit(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
            return
        }

        [supplierInstance: supplierInstance,supplierType:supplierType]
    }
    def fUpdate(Long id, Long version) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
            return
        }

        if (version != null) {
            if (supplierInstance.version > version) {
                supplierInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'supplier.label', default: 'Supplier')] as Object[],
                        "Another user has updated this Supplier while you were editing")
                render(view: "fEdit", model: [supplierInstance: supplierInstance,supplierType: supplierType])
                return
            }
        }

        supplierInstance.properties = params

        if (!supplierInstance.save(flush: true)) {
            render(view: "fEdit", model: [supplierInstance: supplierInstance,supplierType: supplierType])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "fShow", id: supplierInstance.id)
    }
    def fDelete(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
            return
        }

        try {
            supplierInstance.isdelete=1
            supplierInstance.save(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fShow", id: id)
        }
    }
//    def zgSearch(Long id){
//
//        def result=Supplier.findAllByParentId(id)
//        def supplierInstanceTotal=Supplier.countByParentId(id)
//
//        render (view:'List' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
//    }

    def yuanxianList(Integer max) {
        def supplierInfo = Supplier.get(session.uTypeId)
        def yuanxian
        if(supplierInfo.parentId==0){
            yuanxian = supplierInfo
        }else{
            yuanxian = Supplier.findByIdAndIsdelete(supplierInfo.parentId,0,[offset:params.offset,max:max])
        }
//        def result=Supplier.findAllByParentId(session.uTypeId)
        def supplierInstanceTotal=Supplier.countByIdAndIsdelete(supplierInfo.parentId,0,[offset:params.offset,max:max])
        render (view:'yuanxianList' , model:  [supplierInstanceList: yuanxian, supplierInstanceTotal: supplierInstanceTotal])
    }

    def yingyuanList(Integer max,Long id) {
        //def id=session.userId
        def result=Supplier.findAllByParentIdAndIsdelete(session.uTypeId,0,[offset:params.offset,max:max])
        def supplierInstanceTotal=Supplier.countByParentIdAndIsdelete(session.uTypeId,0)

        render (view:'yingyuanList' , model:  [supplierInstanceList: result, supplierInstanceTotal: supplierInstanceTotal])
    }

    def   yingyuanSearch(Integer max,Long id){

        def name=params.name

        def result=Supplier.findAllByNameLikeAndParentIdAndIsdelete("%"+name+"%",session.uTypeId,0,[offset:params.offset,max:max])
        def supplierInstanceTotal=Supplier.countByNameLikeAndParentIdAndIsdelete("%"+name+"%",session.uTypeId,0)

        render (view:'yingyuanList' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal,id:id])
    }
    def zList(Integer max,Long id) {
        def result = Supplier.findAllByParentIdAndIsdelete(id, 0, [offset: params.offset, max: max])
        def supplierInstanceTotal = Supplier.countByParentIdAndIsdelete(id, 0)
        render(view: 'zList', model: [supplierInstanceList: result, supplierInstanceTotal: supplierInstanceTotal, id: id])
    }
    def zSearch(Long id,Integer max){

        def name=params.name
        def result=Supplier.findAllByNameLikeAndParentIdAndIsdelete("%"+name+"%",id,0,[offset:params.offset,max:max])
        def supplierInstanceTotal=Supplier.countByNameLikeAndParentIdAndIsdelete("%"+name+"%",id,0)

        render (view:'zList' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal,id: id])
    }
    def zCreate() {
        def pSupplierInstance = Supplier.get(params.parentId)
        [supplierInstance: new Supplier(params),pSupplierInstance:pSupplierInstance]
    }
    def zSave() {
        def supplierInstance = new Supplier(params)
        if (!supplierInstance.save(flush: true)) {
            render(view: "zCreate", model: [supplierInstance: supplierInstance])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "zShow", id: supplierInstance.id)
    }
    def zShow(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zList")
            return
        }

        [supplierInstance: supplierInstance]
    }
    def zEdit(Long id) {
        def supplierInstance = Supplier.get(id)
        def pSupplierInstance = Supplier.get(supplierInstance.parentId)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zList")
            return
        }

        [supplierInstance: supplierInstance,pSupplierInstance:pSupplierInstance]
    }
    def zUpdate(Long id, Long version) {
        def supplierInstance = Supplier.get(id)
        def pSupplierInstance = Supplier.get(supplierInstance.parentId)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zList")
            return
        }

        if (version != null) {
            if (supplierInstance.version > version) {
                supplierInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'supplier.label', default: 'Supplier')] as Object[],
                        "Another user has updated this Supplier while you were editing")
                render(view: "zEdit", model: [supplierInstance: supplierInstance,pSupplierInstance:pSupplierInstance])
                return
            }
        }

        supplierInstance.properties = params

        if (!supplierInstance.save(flush: true)) {
            render(view: "zEdit", model: [supplierInstance: supplierInstance,pSupplierInstance:pSupplierInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'supplier.label', default: 'Supplier'), supplierInstance.id])
        redirect(action: "zShow", id: supplierInstance.id)
    }
    def zDelete(Long id) {
        def supplierInstance = Supplier.get(id)
        if (!supplierInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zList")
            return
        }

        try {
            supplierInstance.isdelete=1
            supplierInstance.save(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zList",id: supplierInstance.parentId)
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "zShow", id: id)
        }
    }

    //常见供应商用户
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
    def supplierCreate(Long id){
        [userInstance: new User(params),accountType:4,uTypeId:id]
    }
    def supplierSave() {
        def userInstance = new User(params)
        def q=params.uTypeId
        if(!params.uTypeId.toInteger()){
            flash.message = message(code: 'user.uTypeId.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "supplierCreate", model: [userInstance: userInstance,accountType:4,uTypeId:params.uTypeId])
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
            redirect(action: "supplierList",uTypeId:userInstance.uTypeId)
            return
        }

        [userInstance: userInstance,uTypeId:userInstance.uTypeId]
    }
    def supplierEdit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "supplierList")
            return
        }
        def supplierInstance = Supplier.get(userInstance.uTypeId)//供应商信息
//        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
//        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        [userInstance: userInstance,accountType:4,uTypeId: userInstance.uTypeId,supplierInstance: supplierInstance]
    }
    def supplierUpdate(Long id, Long version) {
        def userInstance = User.get(id)
        def a=params
        if(params.username!=userInstance.username){
            def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)

            if(userInfo){
                flash.message = message(code: 'user.suppliername.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                render(view: "supplierEdit", model: [userInstance: userInstance,accountType:4,supplierType: supplierType])
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
    //创建pos机
    def pList(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def result =PosMachine.findAllByIsdelete(0,[offset:params.offset,max:params.max])
        def posMachineInstanceTotal=PosMachine.countByIsdelete(0)
        [posMachineInstanceList: result, posMachineInstanceTotal: posMachineInstanceTotal]
    }
    def pCreate(Long id) {
        [posMachineInstance: new PosMachine(params),supplierType:id]
    }
    def pSave(Long id) {
        def posMachineInstance = new PosMachine(params)
        if (!posMachineInstance.save(flush: true)) {
            render(view: "pCreate", model: [posMachineInstance: posMachineInstance,supplierType:id])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), posMachineInstance.id])
        redirect(action: "pShow", id: posMachineInstance.id)
    }
    def pShow(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pList" ,id:id,supplierType:supplierType)
            return
        }

        [posMachineInstance: posMachineInstance]
    }
    def pEdit(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pList")
            return
        }
        def supplierInstance = Supplier.get(posMachineInstance.supplier.id)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        [posMachineInstance: posMachineInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers]
    }
    def pUpdate(Long id, Long version) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pList")
            return
        }
        def supplierInstance = Supplier.get(posMachineInstance.supplier.id)//供应商信息
        def psuppliers = Supplier.findAllByParentIdAndType(0,supplierInstance.type)//分类对应的父供应商列表
        def csuppliers = Supplier.findAllByParentIdAndType(supplierInstance.parentId,supplierInstance.type)//跟供应商同级的其他供应商
        if (version != null) {
            if (posMachineInstance.version > version) {
                posMachineInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'posMachine.label', default: 'PosMachine')] as Object[],
                        "Another user has updated this PosMachine while you were editing")
                render(view: "pEdit", model: [posMachineInstance: posMachineInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
                return
            }
        }

        posMachineInstance.properties = params

        if (!posMachineInstance.save(flush: true)) {
            render(view: "edit", model: [posMachineInstance: posMachineInstance,supplierType: supplierType,supplierInstance: supplierInstance,psuppliers: psuppliers,csuppliers: csuppliers])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), posMachineInstance.id])
        redirect(action: "show", id: posMachineInstance.id)
    }
    def pDelete(Long id) {
        def posMachineInstance = PosMachine.get(id)
        if (!posMachineInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pList")
            return
        }

        try {
            posMachineInstance.save(flush: true)
            posMachineInstance.executeUpdate("update PosMachine u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'posMachine.label', default: 'PosMachine'), id])
            redirect(action: "pShow", id: id)
        }
    }

}
