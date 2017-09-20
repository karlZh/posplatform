package posscard

class CardBin {//卡bin
    String cardbin //卡bin,卡号前6位
    Date dateCreated//创建时间

    static constraints = {
        cardbin(blank: false, nullable: false, unique: true)
        dateCreated(display: false)
    }

    static belongsTo = ['cardPlatform':CardPlatform]
    static hasMany = [cardBinSupplier: CardBinSupplier]
}
