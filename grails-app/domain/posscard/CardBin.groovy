package posscard

class CardBin {//卡bin
    String cardbin //卡bin,卡号前6位
    CardPlatform cardPlatform
    Date dateCreated//创建时间

    static constraints = {
        cardbin(blank: false, nullable: false, unique: true)
        cardPlatform(nullable: false)
        dateCreated(display: false)
    }

    static belongsTo = [CardPlatform,Supplier]
    static hasMany = [suppliers: Supplier]

    String toString(){
        "${cardbin}"
    }
}
