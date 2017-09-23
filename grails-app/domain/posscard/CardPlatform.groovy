package posscard

class CardPlatform {//商户数据表
    String name
    String address
    Short  isdelete=0 //删除状态 0，未删 1：删除
    Date dateCreated //创建时间

    static constraints = {
        name(unique: true)
        address()
        isdelete(nullable: false)
        dateCreated(display:false)
    }

    static hasMany = [cardBin: CardBin]
    String toString(){
        "${name}"
    }
}
