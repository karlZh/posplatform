package posscard

import grails.converters.JSON
import org.springframework.dao.DataIntegrityViolationException

class SupplierController {

    static allowedMethods = [save: "POST", update: "POST"]
    def supplierType = [1:"电影",2:"蛋糕"]
    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [supplierInstanceList: Supplier.list(params), supplierInstanceTotal: Supplier.count()]
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
        def result=Supplier.findAllByName(name)
        def supplierInstanceTotal=Supplier.countByName(name)

        render (view:'list' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
    }
    def create() {
        [supplierInstance: new Supplier(params),supplierType:supplierType]
    }
    def ajaxSearchSupplier(){
        def result = [status:0,message:'',data:[:]]
        def parents = Supplier.findAllByParentIdAndType(0,params.type)
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
                render(view: "edit", model: [supplierInstance: supplierInstance])
                return
            }
        }

        supplierInstance.properties = params

        if (!supplierInstance.save(flush: true)) {
            render(view: "edit", model: [supplierInstance: supplierInstance])
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
            supplierInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "show", id: id)
        }
    }
    def fList(Integer max) {
        def name=params.name
        def result=Supplier.findAllByParentId(0)
        def supplierInstanceTotal=Supplier.countByName(name)

        render (view:'fList' , model:  [supplierInstanceList: result, supplierInstanceTotal: Supplier.count()])
    }

    def fSearch(){

        def name=params.name
        def result=Supplier.findAllByNameAndParentId(name,0)
        def supplierInstanceTotal=Supplier.countByName(name)

        render (view:'fList' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
    }
    def fCreate() {

        [supplierInstance: new Supplier(params),supplierType:supplierType]
    }
    def fSave() {
        def supplierInstance = new Supplier(params)
        if (!supplierInstance.save(flush: true)) {
            render(view: "fCreate", model: [supplierInstance: supplierInstance])
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

        [supplierInstance: supplierInstance]
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
                render(view: "fEdit", model: [supplierInstance: supplierInstance])
                return
            }
        }

        supplierInstance.properties = params

        if (!supplierInstance.save(flush: true)) {
            render(view: "fEdit", model: [supplierInstance: supplierInstance])
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
            supplierInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fList")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'supplier.label', default: 'Supplier'), id])
            redirect(action: "fShow", id: id)
        }
    }
    def zgSearch(Long id){

        def result=Supplier.findAllByParentId(id)
        def supplierInstanceTotal=Supplier.countById(id)

        render (view:'List' , model: [supplierInstanceList: result, supplierInstanceTotal:supplierInstanceTotal])
    }

    def yuanxianList(Integer max) {
        def supplierInfo = Supplier.get(session.uTypeId)
        def yuanxian
        if(supplierInfo.parentId==0){
            yuanxian = supplierInfo
        }else{
            yuanxian = Supplier.findById(supplierInfo.parentId)
        }
//        def result=Supplier.findAllByParentId(session.uTypeId)
        def supplierInstanceTotal=Supplier.countById(supplierInfo.parentId)
        render (view:'yuanxianList' , model:  [supplierInstanceList: yuanxian, supplierInstanceTotal: supplierInstanceTotal])
    }
    def yingyuanList(Integer max) {

        def result=Supplier.findAllByParentId(session.uTypeId)
        def supplierInstanceTotal=Supplier.countByParentId(session.uTypeId)
        render (view:'yingyuanList' , model:  [supplierInstanceList: result, supplierInstanceTotal: supplierInstanceTotal])
    }

}
