package posscard

class PosMachine {
    Long userId
    String name
    Date  dateCreated //创建时间

    static constraints = {
        name(nullable: false)
        userId(nullable: true, display:false)
        dateCreated(display:false)
    }
    static belongsTo = [supplier: Supplier]
}
