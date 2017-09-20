import posscard.CardBin
import posscard.CardPlatform
import posscard.Supplier
import posscard.User

class BootStrap {

    def init = { servletContext ->
        def user = new User(
                username:"admin",
                password: "123456",
                phone: "18312345678",
                accountType: 2,
                uTypeId: 1,
                supplier: Supplier.get(1)
        )
        user.save()
        if (user.hasErrors()) {
            println user.errors
        }
        def cardplatform = new CardPlatform(
                name: 'juyou',
                address: 'yuanyingguoji'
        )
                cardplatform.save()
        if (cardplatform.hasErrors()) {
            println cardplatform.errors
        }

        def supplier = new Supplier(
                name:'asdf',
                ratio:1,
                price: 10,
                address: 'asdf',
                phone: '18512345678',
                remark :'1121312',
                parentId:0
        )
        supplier.save()
        if (supplier.hasErrors()) {
            println supplier.errors
        }
    }
    def destroy = {
    }
}
