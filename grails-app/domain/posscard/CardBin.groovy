package posscard

class CardBin {//卡bin
    String cardbin //卡bin,卡号前6位
    CardPlatform cardPlatform
    Short   isdelete = 0 //删除状态 0，未删 1：删除
    Date dateCreated//创建时间

    static constraints = {
        cardbin(blank: false, maxSize: 6, nullable: false, unique: true)
        cardPlatform(nullable: false)
        isdelete(nullable: false)
        dateCreated(display: false)
    }

    static belongsTo = [CardPlatform,Supplier]
    static hasMany = [suppliers: Supplier]

    String toString(){
        "${cardbin}"
    }
}
