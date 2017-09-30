package posscard

class PosMachine {
    Long userId
    String name
    Short  isdelete = 0 //删除状态 0，未删 1：删除
    Date  dateCreated //创建时间

    static constraints = {
        name(nullable: false,unique: true, blank: false, maxSize: 50)
        userId(nullable: true, display:false)
        supplier(nullable: false)
        isdelete(nullable: false)
        dateCreated(display:false)
    }
    static belongsTo = [supplier: Supplier]
}
