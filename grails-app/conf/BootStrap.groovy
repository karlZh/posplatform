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
    }
    def destroy = {
    }
}
