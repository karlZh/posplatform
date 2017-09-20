package posscard

class CardPlatform {//商户数据表
    String name
    String address
    Date dateCreated //创建时间

    static constraints = {
        name(unique: true)
        address()
        dateCreated(display:false)
    }

    static hasMany = [cardBin: CardBin]
    String toString(){
        "${name}"
    }
}
