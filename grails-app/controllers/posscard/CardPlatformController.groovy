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
    def platformCreate(Long id){
        def  category =CardPlatform.findAll()
        [cardPlatformInstance: new User(params),category: category,accountType:3,uTypeId:id]
    }
    def platformSave() {
        def userInstance = new User(params)
        def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)
        if(userInfo){
            flash.message = message(code: 'user.platformname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
            render(view: "platformCreate", model: [userInstance: userInstance,accountType:3,uTypeId: params.uTypeId])
            return
        }
        userInstance.accountType=3
        if (!userInstance.save(flush: true)) {
            render(view: "platformCreate", model: [userInstance: userInstance,accountType:3,uTypeId: params.uTypeId])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "platformShow",params:[ id: userInstance.id, uTypeId: params.uTypeId])
    }
    def platformShow(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList")
            return
        }
   render (view: "platformShow", model:   [userInstance: userInstance, uTypeId: params.uTypeId])

    }


    def platformEdit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformCreate" ,params: [uTypeId: params.uTypeId])
            return
        }

        [userInstance: userInstance,accountType:3,uTypeId: params.uTypeId]

    }
    def platformUpdate(Long id, Long version) {
        def userInstance = User.get(id)
        if(params.username!=userInstance.username){
            def userInfo = User.findAllByUsernameAndPasswordAndUTypeIdAndAccountType(params.username,params.password,params.uTypeId,params.accountType)

            if(userInfo){
                flash.message = message(code: 'user.platformname.not.unique.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
                render(view: "platformEdit", model: [userInstance: userInstance,accountType:1])
                return
            }
        }
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "platformList",params: [uTypeId: params.uTypeId])
            return
        }


        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'user.label', default: 'User')] as Object[],
                        "Another user has updated this User while you were editing")
                render(view: "platformEdit", model: [userInstance: userInstance,accountType:3,uTypeId: params.uTypeId])
                return
            }
        }

        userInstance.properties = params

        def a=params
        if (!userInstance.save(flush: true)) {
            render(view: "platformEdit", model: [userInstance: userInstance,accountType:3,uTypeId: params.uTypeId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "platformShow",params: [ id: userInstance.id,uTypeId: params.uTypeId])
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
    def klist(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def result=CardBin.findAllByIsdelete(0,[offset:params.offset,max:max])
        def cardBinInstanceTotal=CardBin.countByIsdelete(0)
        [cardBinInstanceList: result, cardBinInstanceTotal:cardBinInstanceTotal]
    }
    def ksearch(Integer max){

        def name=params.name
        //def result1=CardBin.findAllByCardbinAndIsdelete(name,0,[offset:params.offset,max:max])
        def result =CardBin.findAllByCardbinLikeAndIsdelete("%"+name+"%",0,[offset:params.offset,max:max])
        def cardBinInstanceTotal=CardBin.countByCardbinLikeAndIsdelete("%"+name+"%",0)

        render (view:'blist' , model: [cardBinInstanceList: result, cardBinInstanceTotal:cardBinInstanceTotal])
    }
    def kcreate(Long id) {
        [cardBinInstance: new CardBin(params),cardPlatformId:id]
    }
    def ksave(Long id) {

        def cardBinInstance = new CardBin(params)
        if (!cardBinInstance.save(flush: true)) {
            render(view: "kcreate", model: [cardBinInstance: cardBinInstance,cardPlatformId: cardBinInstance.cardPlatformId])
            return
        }
        flash.message = message(code: 'default.created.message', args: [message(code: 'cardBin.label', default: 'CardBin'), cardBinInstance.id])
       redirect(action: "kshow", id: cardBinInstance.id,params:[cardPlatformId:cardBinInstance.cardPlatformId])
    }

    def kshow(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "klist")

            return
        }
        [cardBinInstance: cardBinInstance,id: id, cardPlatformId:cardBinInstance.cardPlatformId]

    }
    def kedit(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "klist")
            return
        }

        [cardBinInstance: cardBinInstance,cardPlatformId:cardBinInstance.cardPlatformId]
    }
    def kupdate(Long id, Long version) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "klist",params: [cardPlatformId:cardBinInstance.cardPlatformId])
            return
        }

        if (version != null) {
            if (cardBinInstance.version > version) {
                cardBinInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                        [message(code: 'cardBin.label', default: 'CardBin')] as Object[],
                        "Another user has updated this CardBin while you were editing")
                render(view: "kedit", model: [cardBinInstance: cardBinInstance,cardPlatformId:cardBinInstance.cardPlatformId])
                return
            }
        }

        cardBinInstance.properties = params

        if (!cardBinInstance.save(flush: true)) {
            render(view: "kedit", model: [cardBinInstance: cardBinInstance,cardPlatformId:cardBinInstance.cardPlatformId])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'cardBin.label', default: 'CardBin'), cardBinInstance.id])
        redirect(action: "kshow", id: cardBinInstance.id)
    }
    def kdelete(Long id) {
        def cardBinInstance = CardBin.get(id)
        if (!cardBinInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "klist")
            return
        }

        try {
            cardBinInstance.save(flush: true)
            cardBinInstance.executeUpdate("update CardBin u set u.isdelete=1 where u.id=?",[id])
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "klist")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'cardBin.label', default: 'CardBin'), id])
            redirect(action: "kshow", id: id)
        }
    }
}
