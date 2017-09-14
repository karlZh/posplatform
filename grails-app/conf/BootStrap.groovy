import posscard.CardBin
import posscard.CardPlatform
import posscard.Supplier

class BootStrap {

    def init = { servletContext ->
        def cardbin = new CardBin(
                cardbin:'711001'
        )
        cardbin.save()
        if (cardbin.hasErrors()) {
           println cardbin.errors
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
                name: 'juyou',
                ratio: 1,
                price: 10,
                address: 'yuanyangguoji',
                phone: '18512345678',
                remark: 'haode',
                parentId: 0
        )
        supplier.save()
        if (supplier.hasErrors()) {
            println supplier.errors
        }

    }
    def destroy = {
    }
}
