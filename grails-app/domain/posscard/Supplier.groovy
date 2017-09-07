package posscard

class Supplier {
    String name
    Float ratio //结算比例
    Float price //结算价格
    String address //地址
    String phone //电话
    String remark //备注
    Integer parentId //父供应商id
    Integer createTime //创建时间

    static constraints = {
        name(size: 2..10,blank: false)
        ratio() //结算比例
        price() //结算价格
        address() //地址
        phone(matches: /\d{7,11}/,blank: false) //电话
        remark(maxSize: 50,blank: false) //备注
        parentId() //父供应商id
        createTime() //创建时间
    }

    static hasMany = [user: User, posmachine: PosMachine, tickettype: TicketType]
}
