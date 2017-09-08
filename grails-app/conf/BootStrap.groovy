import posscard.CardBin
import posscard.CardPlatform

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
    }
    def destroy = {
    }
}
