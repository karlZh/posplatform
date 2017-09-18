package posscard

class PosMachine {
    Integer userId
    Date  dateCreated //创建时间

    static constraints = {
        userId()
        dateCreated(display:false)
    }
    static belongsTo = [supplier: Supplier]
}
