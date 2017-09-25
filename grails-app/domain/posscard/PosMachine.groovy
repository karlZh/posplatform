package posscard

class PosMachine {
    Long userId
    String name
    Date  dateCreated //创建时间

    static constraints = {
        name(nullable: false,unique: true, blank: false, maxSize: 50)
        userId(nullable: true, display:false)
        supplier(nullable: false)
        dateCreated(display:false)
    }
    static belongsTo = [supplier: Supplier]
}
