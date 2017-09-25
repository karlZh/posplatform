package posscard

class Supplier {
    String name
    Short type//供应商类型1电影，2蛋糕,0无分类
    Integer ratio //结算比例
    Float price //结算价格
    String address //地址
    String phone //电话
    String remark //备注
    Long parentId //父供应商id
    Short   isdelete = 0 //删除状态 0，未删 1：删除
    Date  dateCreated

    static constraints = {
        name(size: 2..10,blank: false,unique: true)
        type(nullable: false)
        ratio(max: 100) //结算比例
        price() //结算价格
        address(maxSize: 255) //地址
        phone(matches: /\d{7,11}/,blank: false) //电话
        remark(maxSize: 50,blank: true) //备注
        isdelete(nullable: false)
        parentId() //父供应商id

        dateCreated(display:false) //创建时间

    }

    static hasMany = [posmachine: PosMachine, tickettype: TicketType,cardbins: CardBin]

    String toString(){
        "${name}"
    }
}
