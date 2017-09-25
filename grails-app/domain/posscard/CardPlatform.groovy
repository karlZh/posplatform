package posscard

class CardPlatform {//商户数据表
    String name
    String address
    Short  isdelete=0 //删除状态 0，未删 1：删除
    Date dateCreated //创建时间

    static constraints = {
        name(nullable: false, unique: true,maxSize: 50)
        address(maxSize: 255)
        isdelete(nullable: false)
        dateCreated(display:false)
    }

    static hasMany = [cardBin: CardBin]
    String toString(){
        "${name}"
    }
}
